package com.ctrlcollege.ctrlcollege;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class SelecionaAluno extends AppCompatActivity {

    private String url;
    private String parametros;
    private String[] codSerie;
    private String[] descSerie;
    private String[] perSerie;
    private String[] salaSerie;
    private String[] codAluno;
    private String[] nomeAluno;
    private int codAtual;
    private int i = 0;
    private TextView sitAluno;
    private Spinner spinner;
    private Spinner spinner2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_seleciona_aluno);

        getSalas();

        Button confirm = (Button) findViewById(R.id.btConfirmAluno);

        confirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(i == 1){
                    if(sitAluno.getText().toString().contains("Não retirado")){

                        Intent i = new Intent(SelecionaAluno.this, DadosResponsavel.class);
                        Bundle parametros = new Bundle();
                        parametros.putInt("codAluno", codAtual);
                        i.putExtras(parametros);

                        startActivity(i);
                        finish();

                    }else{
                        Toast.makeText(SelecionaAluno.this, "O aluno já foi retirado", Toast.LENGTH_SHORT).show();
                    }

                }else{
                    Toast.makeText(SelecionaAluno.this, "Nenhum aluno selecionado", Toast.LENGTH_SHORT).show();
                }


            }
        });
    }

    private void getSalas(){

        ConnectivityManager connMgr = (ConnectivityManager)
                getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();

        if(networkInfo != null && networkInfo.isConnected()) {
            url = "http://192.168.1.100/nodemcu/buscaSalas.php";
            parametros  = "";

            //fetch data
            new Salas().execute(url);
        }else {
            //display error
            Toast.makeText(getApplicationContext(), "Nenhuma conexão foi detectada", Toast.LENGTH_SHORT).show();
        }
    }

    private void getAluno(String sala){

        url = "http://192.168.1.100/nodemcu/buscaAlunoSala.php";
        parametros = "sala=" + sala;

        //fetch data
        new Alunos().execute(url);
    }

    private class Situacao extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){
            sitAluno = (TextView) findViewById(R.id.textSitTabela);
            
            sitAluno.setText(result);
            
        }

    }
    
    private class Alunos extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){
            String[] divisao_ini = result.split(";</br>");
            int tamanho = divisao_ini.length;
            codAluno = new String[tamanho];
            nomeAluno = new String[tamanho];

            nomeAluno[0] = "Nenhum aluno selecionado";

            for(int i = 1; i < tamanho; i++){
                String[] divisao_final = divisao_ini[i-1].split(",");
                codAluno[i] = divisao_final[0];
                nomeAluno [i] = divisao_final[1] ;
            }

            spinner2 = (Spinner) findViewById(R.id.spinSelectAluno);

            ArrayAdapter<String> adapter = new ArrayAdapter<String>(SelecionaAluno.this, R.layout.spinner_container, nomeAluno);
            spinner2.setAdapter(adapter);

            spinner2.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                   if(position != 0) {
                            codAtual = Integer.parseInt(codAluno[position]);
                            i = 1;
                            getSitAluno(codAtual);
                        }

                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {

                }
            });

        }

    }

    private void getSitAluno(int cod){

        url = "http://192.168.1.100/nodemcu/situacaoAluno.php";
        parametros = "id=" + cod;

        //fetch data
        new Situacao().execute(url);
    }

    public void onBackPressed(){ //Botão BACK padrão do android

        checkExit();

    }

    private void checkExit()
    {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage("Deseja realmente sair?")
                .setCancelable(false)
                .setPositiveButton("Sim", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        startActivity(new Intent(SelecionaAluno.this, TelaLogin.class)); //O efeito ao ser pressionado do botão (no caso abre a activity)
                        finishAffinity(); //Método para matar a activity e não deixa-lá indexada na pilhagem
                        // Ação tomada caso o usuário escolha sim.
                    }
                })
                .setNegativeButton("Não", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        dialog.cancel();
                    }
                });
        AlertDialog alert = builder.create();
        alert.show();
    }

    private class Salas extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){
            String[] divisao_ini = result.split(";</br>");

            int tamanho = divisao_ini.length;
            codSerie = new String[tamanho];
            descSerie = new String[tamanho];
            perSerie = new String[tamanho];
            salaSerie = new String[tamanho];

            descSerie[0] = "Nenhuma sala selecionada";

            for(int i = 1; i < tamanho; i++){
                String[] divisao_final = divisao_ini[i-1].split(",");
                codSerie[i] = divisao_final[0];
                descSerie [i] = divisao_final[1] ;
                perSerie [i] = divisao_final[2] ;
                salaSerie [i] = divisao_final[3] ;
            }

            spinner = (Spinner) findViewById(R.id.spinSelectSala);

            ArrayAdapter<String> adapter = new ArrayAdapter<String>(SelecionaAluno.this, R.layout.spinner_container, descSerie);
            spinner.setAdapter(adapter);



            spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

                    if(position != 0) {
                        getAluno(codSerie[position]);

                        TextView serie = (TextView) findViewById(R.id.textSerieTabela);
                        TextView periodo = (TextView) findViewById(R.id.textPeriodoTabela);
                        TextView sala = (TextView) findViewById(R.id.textSalaTabela);

                        sala.setText(salaSerie[position]);
                        serie.setText(descSerie[position]);
                        periodo.setText(perSerie[position]);
                    }

                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {



                }
            });

        }

    }
}
