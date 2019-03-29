package com.ctrlcollege.ctrlcollege;

import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class Situacao extends AppCompatActivity {

    private String[] nomesAlunos;
    private String[] nomeEcod;
    private String[] codAlunos;
    private Spinner spinner;
    private String [] divisao;
    private String texto;
    private String user;
    private String tam;
    private TextView teste;
    private TextView teste2;
    private String url = "";
    private String parametros = "";



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_situacao);

        Intent i = getIntent();
        if (i != null){
            Bundle parametros = i.getExtras();
            if(parametros != null){
              user = parametros.getString("user");
            }
        }

        if(user != "admin"){
        getTamanho();}

    }



    @Override
    public void onBackPressed(){ //Botão BACK padrão do android
        Intent i =new Intent(this, TelaMenuPais.class);

        Bundle parametros = new Bundle();
        parametros.putString("user", user);

        i.putExtras(parametros);

        startActivity(i); //O efeito ao ser pressionado do botão (no caso abre a activity)
        finishAffinity(); //Método para matar a activity e não deixa-lá indexada na pilhagem
        return;
    }

    private void frequencia(int i){
        url = "http://192.168.1.100/nodemcu/relatorio.php";

        parametros = "ra="+ codAlunos[i];

        //fetch data
        new DadosFrequencia().execute(url);
    }



    private void getTamanho(){

        ConnectivityManager connMgr = (ConnectivityManager)
                getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();

        if(networkInfo != null && networkInfo.isConnected()) {
                url = "http://192.168.1.100/nodemcu/qtdAlunoResponsavel.php";

                parametros = "id="+ user;

                    //fetch data
                    new DadosTamanho().execute(url);
            }else {
                //display error
                Toast.makeText(getApplicationContext(), "Nenhuma conexão foi detectada", Toast.LENGTH_SHORT).show();
            }



    }

    private class DadosTamanho extends AsyncTask<String, Void, String>{
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

    private void montadorTabela(int i, String m, String a, String f, String fq){

        TextView materia = (TextView) findViewById(R.id.textTbMateria1);
        TextView qtdAulas= (TextView) findViewById(R.id.textTbTotalAulas1);
        TextView faltas= (TextView) findViewById(R.id.textTbTotalFaltas1);
        TextView frequencia= (TextView) findViewById(R.id.textTbFrequência1);

        switch (i){
            case 1:
                materia = (TextView) findViewById(R.id.textTbMateria1);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas1);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas1);
                frequencia = (TextView) findViewById(R.id.textTbFrequência1);
                break;
            case 2:
                materia = (TextView) findViewById(R.id.textTbMateria2);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas2);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas2);
                frequencia = (TextView) findViewById(R.id.textTbFrequência2);
                break;
            case 3:
                materia = (TextView) findViewById(R.id.textTbMateria3);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas3);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas3);
                frequencia = (TextView) findViewById(R.id.textTbFrequência3);
                break;
            case 4:
                materia = (TextView) findViewById(R.id.textTbMateria4);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas4);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas4);
                frequencia = (TextView) findViewById(R.id.textTbFrequência4);
                break;
            case 5:
                materia = (TextView) findViewById(R.id.textTbMateria5);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas5);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas5);
                frequencia = (TextView) findViewById(R.id.textTbFrequência5);
                break;
            case 6:
                materia = (TextView) findViewById(R.id.textTbMateria6);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas6);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas6);
                frequencia = (TextView) findViewById(R.id.textTbFrequência6);
                break;
            case 7:
                materia = (TextView) findViewById(R.id.textTbMateria7);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas7);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas7);
                frequencia = (TextView) findViewById(R.id.textTbFrequência7);
                break;
            case 8:
                materia = (TextView) findViewById(R.id.textTbMateria8);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas8);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas8);
                frequencia = (TextView) findViewById(R.id.textTbFrequência8);
                break;
            case 9:
                materia = (TextView) findViewById(R.id.textTbMateria9);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas9);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas9);
                frequencia = (TextView) findViewById(R.id.textTbFrequência9);
                break;
            case 10:
                materia = (TextView) findViewById(R.id.textTbMateria10);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas10);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas10);
                frequencia = (TextView) findViewById(R.id.textTbFrequência10);
                break;
            case 11:
                materia = (TextView) findViewById(R.id.textTbMateria11);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas11);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas11);
                frequencia = (TextView) findViewById(R.id.textTbFrequência11);
                break;
            case 12:
                materia = (TextView) findViewById(R.id.textTbMateria12);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas12);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas12);
                frequencia = (TextView) findViewById(R.id.textTbFrequência12);
                break;
            case 13:
                materia = (TextView) findViewById(R.id.textTbMateria13);
                qtdAulas = (TextView) findViewById(R.id.textTbTotalAulas13);
                faltas = (TextView) findViewById(R.id.textTbTotalFaltas13);
                frequencia = (TextView) findViewById(R.id.textTbFrequência13);
                break;
        }

        materia.setText(m);
        qtdAulas.setText(a);
        faltas.setText(f);
        frequencia.setText(fq);

    }

    private class DadosFrequencia extends AsyncTask<String, Void, String>{
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){
            String[] conteudo = result.split(";<br>");

            for(int contMat = 0; contMat<13; contMat++){
                String[] divisao = conteudo[contMat].split(";");
                String materia = divisao[0];
                String aulas = divisao[1];
                String faltas = divisao[2];
                String freq = divisao[3];
                int linha = contMat+1;

                montadorTabela(linha,materia,aulas,faltas,freq);



            }
        }

    }

    private void getNomes(){


            url = "http://192.168.1.100/nodemcu/nomeAluno.php";

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
                divisao = nomeEcod[cont].split(",");
                codAlunos[cont] = divisao[0];
                nomesAlunos[cont]=divisao[1];
            }

            spinner = (Spinner) findViewById(R.id.spinnerAluno);

            ArrayAdapter<String> adapter = new ArrayAdapter<String>(Situacao.this, R.layout.spinner_container, nomesAlunos);
            spinner.setAdapter(adapter);

            spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

                        frequencia(position);

                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {

                }
            });



        }

    }



}





