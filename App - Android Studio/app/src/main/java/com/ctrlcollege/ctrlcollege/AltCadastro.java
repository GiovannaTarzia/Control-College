package com.ctrlcollege.ctrlcollege;

import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class AltCadastro extends AppCompatActivity {

    private String user;
    private String url;
    private String tam;
    private int posicao;
    private String[] nomeEcod;
    private String[] nomesAlunos;
    private String[] codAlunos;
    private String parametros;
    private Spinner spinner;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_alt_cadastro);

        Intent i = getIntent();
        if (i != null){
            Bundle parametros = i.getExtras();
            if(parametros != null){
                user = parametros.getString("user");
            }
        }

        if(user != "admin"){
            getTamanho();}

        //desabilita teclado
        getWindow().setSoftInputMode(
                WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);

        //Desabilita as editText
        //Ao clicar no botao editar habilita as editText
                 desabilita();



    final Button edi = findViewById(R.id.bt_Editar);
        edi.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                habilita();
            }});

    final Button salvar = findViewById(R.id.bt_Salvar);
        salvar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                alteraCadastro();
            }
        });

    }

    private void alteraCadastro(){
        ConnectivityManager connMgr = (ConnectivityManager)
                getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();

        if(networkInfo != null && networkInfo.isConnected()) {

            TextView email = (TextView) findViewById(R.id.txEmail);
            TextView endereco = (TextView) findViewById(R.id.txEndereco);
            TextView bairro = (TextView) findViewById(R.id.txBairro);
            TextView cidade = (TextView) findViewById(R.id.txCidade);
            TextView uf = (TextView) findViewById(R.id.txUF);
            TextView numero = (TextView) findViewById(R.id.txNumero);
            TextView complemento = (TextView) findViewById(R.id.txComplemento);

            String textEmail = email.getText().toString();

            if(textEmail.equals("")||endereco.getText().toString().equals("")||bairro.getText().toString().equals("")||cidade.getText().toString().equals("")||uf.getText().toString().equals("")||numero.getText().toString().equals("")){
                Toast.makeText(this, "Campo(s) não preenchido(s) corretamente", Toast.LENGTH_SHORT).show();
            }else{

            url = "http://192.168.1.2/nodemcu/alteraDados.php";

            parametros = "id="+ codAlunos[posicao]+"&email="+email.getText()+"&endereco="+endereco.getText()+"&bairro="+bairro.getText()+
                    "&cidade="+cidade.getText()+"&numero="+numero.getText()+"&complemento="+complemento.getText()+"&uf="+uf.getText();
//            Toast.makeText(this, textEmail, Toast.LENGTH_SHORT).show();
            if(textEmail.contains("@")&&textEmail.contains(".com")){
            //fetch data
            new AlteraDados().execute(url);}
            else{
                Toast.makeText(this, "O e-mail digitado está incorreto", Toast.LENGTH_SHORT).show();
            }}
        }else {
            //display error
            Toast.makeText(getApplicationContext(), "Nenhuma conexão foi detectada", Toast.LENGTH_SHORT).show();
        }



    }

    private void getTamanho(){

        ConnectivityManager connMgr = (ConnectivityManager)
                getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();

        if(networkInfo != null && networkInfo.isConnected()) {
            url = "http://192.168.1.2/nodemcu/qtdAlunoResponsavel.php";

            parametros = "id="+ user;

            //fetch data
            new AltCadastro.DadosTamanho().execute(url);
        }else {
            //display error
            Toast.makeText(getApplicationContext(), "Nenhuma conexão foi detectada", Toast.LENGTH_SHORT).show();
        }



    }

    private class AlteraDados extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){
            Toast.makeText(AltCadastro.this, result, Toast.LENGTH_LONG).show();
            if(result.contains("Dados alterados com sucesso")){
                desabilita();
            }
        }

    }

    private class DadosTamanho extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){
            tam = result;
            getNomes();
        }

    }

    private void getNomes(){


        url = "http://192.168.1.2/nodemcu/nomeAluno.php";

        parametros = "tam="+ tam +"&id="+user;

        //fetch data
        new DadosNomes().execute(url);




    }

    private class DadosNomes extends AsyncTask<String, Void, String>{
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){

            nomeEcod = result.split(";");

            int tamanho = nomeEcod.length;
            codAlunos = new String[tamanho-1];
            nomesAlunos = new String[tamanho-1];


            for(int cont =0; cont<tamanho-1; cont++){
                String[] divisao = nomeEcod[cont].split(",");
                codAlunos[cont] = divisao[0];
                nomesAlunos[cont]=divisao[1];
            }

            spinner = (Spinner) findViewById(R.id.spinnerAluno2);

            ArrayAdapter<String> adapter = new ArrayAdapter<String>(AltCadastro.this, R.layout.spinner_container, nomesAlunos);
            spinner.setAdapter(adapter);

            spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

                    posicao = position;
                    dadosAluno(posicao);

                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {

                }
            });



        }

    }

    private void dadosAluno(int id){


        url = "http://192.168.1.2/nodemcu/buscaDados.php";

        parametros = "id="+codAlunos[id];


        //fetch data
        new BuscaDados().execute(url);

    }

    private class BuscaDados extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){
            String[] dados = result.split(";");

            TextView email = (TextView) findViewById(R.id.txEmail);
            TextView endereco = (TextView) findViewById(R.id.txEndereco);
            TextView bairro = (TextView) findViewById(R.id.txBairro);
            TextView cidade = (TextView) findViewById(R.id.txCidade);
            TextView uf = (TextView) findViewById(R.id.txUF);
            TextView numero = (TextView) findViewById(R.id.txNumero);
            TextView complemento = (TextView) findViewById(R.id.txComplemento);


            email.setText(dados[0]);
            endereco.setText(dados[1]);
            bairro.setText(dados[2]);
            cidade.setText(dados[3]);
            numero.setText(dados[4]);
            complemento.setText(dados[5]);
            uf.setText(dados[6]);

        }

    }

    @Override
    public void onBackPressed(){ //Botão BACK padrão do android
        Intent i = new Intent(this, TelaMenuPais.class);

        Bundle parametros = new Bundle();
        parametros.putString("user", user);

        i.putExtras(parametros);

        startActivity(i); //O efeito ao ser pressionado do botão (no caso abre a activity)
        finishAffinity(); //Método para matar a activity e não deixa-lá indexada na pilhagem
        return;
    }

    public void desabilita(){

        TextView email = (TextView) findViewById(R.id.txEmail);
        TextView endereco = (TextView) findViewById(R.id.txEndereco);
        TextView bairro = (TextView) findViewById(R.id.txBairro);
        TextView cidade = (TextView) findViewById(R.id.txCidade);
        TextView uf = (TextView) findViewById(R.id.txUF);
        TextView numero = (TextView) findViewById(R.id.txNumero);
        TextView complemento = (TextView) findViewById(R.id.txComplemento);
        Button salvar = (Button) findViewById(R.id.bt_Salvar);

        salvar.setEnabled(false);
        email.setEnabled(false);
        endereco.setEnabled(false);
        uf.setEnabled(false);
        bairro.setEnabled(false);
        cidade.setEnabled(false);
        numero.setEnabled(false);
        complemento.setEnabled(false);
    }
    public void habilita(){

        TextView email = (TextView) findViewById(R.id.txEmail);
        TextView endereco = (TextView) findViewById(R.id.txEndereco);
        TextView bairro = (TextView) findViewById(R.id.txBairro);
        TextView cidade = (TextView) findViewById(R.id.txCidade);
        TextView uf = (TextView) findViewById(R.id.txUF);
        TextView numero = (TextView) findViewById(R.id.txNumero);
        TextView complemento = (TextView) findViewById(R.id.txComplemento);
        Button salvar = (Button) findViewById(R.id.bt_Salvar);

        salvar.setEnabled(true);
        email.setEnabled(true);
        endereco.setEnabled(true);
        uf.setEnabled(true);
        bairro.setEnabled(true);
        cidade.setEnabled(true);
        numero.setEnabled(true);
        complemento.setEnabled(true);
    }

}