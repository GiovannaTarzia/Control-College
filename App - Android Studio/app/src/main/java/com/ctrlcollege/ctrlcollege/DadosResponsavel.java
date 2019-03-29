package com.ctrlcollege.ctrlcollege;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class DadosResponsavel extends AppCompatActivity {

    private String url;
    private String parametros;
    private int ra;
    private ImageView foto;
    private String[] codResp;
    private String codAtual;
    private String[] descResp;
    private String[] nomeResp;
    private Spinner spinner;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dados_responsavel);

        Intent i = getIntent();
        if(i != null){
            Bundle params = i.getExtras();

            if(params != null){
                ra = params.getInt("codAluno");
            }
        }

        getResponsavel();

        Button retira = (Button) findViewById(R.id.btRetiraAluno);
        retira.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                registraSaida();
            }
        });
    }

    public void onBackPressed(){

        startActivity(new Intent(this, SelecionaAluno.class));
        finish();

    }

    private void getResponsavel(){

        ConnectivityManager connMgr = (ConnectivityManager)
                getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();

        if(networkInfo != null && networkInfo.isConnected()) {
            url = "http://192.168.1.2/nodemcu/buscaResp.php";
            parametros  = "ra="+ra;

            //fetch data
            new Resp().execute(url);
        }else {
            //display error
            Toast.makeText(getApplicationContext(), "Nenhuma conexão foi detectada", Toast.LENGTH_SHORT).show();
        }
    }

    private void registraSaida(){

        ConnectivityManager connMgr = (ConnectivityManager)
                getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();

        if(networkInfo != null && networkInfo.isConnected()) {
            url = "http://192.168.1.2/nodemcu/retiraAluno.php";
            parametros  = "aluno="+ra+"&resp="+codAtual;

            //fetch data
            new Saida().execute(url);
        }else {
            //display error
            Toast.makeText(getApplicationContext(), "Nenhuma conexão foi detectada", Toast.LENGTH_SHORT).show();
        }
    }

    private void getFoto(final String cod){

        foto = (ImageView) findViewById(R.id.imgResp);

        url = "http://192.168.1.2/nodemcu/exibeImagem.php";
        parametros  = "id="+cod;

        new Foto().execute(url);

    }

    private class Foto extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){

            Picasso.with(DadosResponsavel.this).load(result).into(foto);

        }

    }


    private class Saida extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){

            Toast.makeText(DadosResponsavel.this, result, Toast.LENGTH_SHORT).show();
            startActivity(new Intent(DadosResponsavel.this, SelecionaAluno.class));
            finish();

        }

    }


    private class Resp extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){
            String[] divisao_ini = result.split(";</br>");

            int tamanho = divisao_ini.length;
            codResp = new String[tamanho-1];
            descResp = new String[tamanho-1];
            nomeResp = new String[tamanho-1];

            for(int i = 0; i < tamanho-1; i++){
                String[] divisao_final = divisao_ini[i].split(",");
                codResp[i] = divisao_final[0];
                nomeResp[i] = divisao_final[1];
                descResp[i] = divisao_final[2];
            }

            spinner = (Spinner) findViewById(R.id.spinSelectResp);

            ArrayAdapter<String> adapter = new ArrayAdapter<String>(DadosResponsavel.this, R.layout.spinner_container, nomeResp);
            spinner.setAdapter(adapter);



            spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

                        getFoto(codResp[position]);
                        codAtual = codResp[position];

                        TextView nome = (TextView) findViewById(R.id.textNomeResp);
                        TextView tipo = (TextView) findViewById(R.id.textTipoResp);

                        nome.setText(nomeResp[position]);
                        tipo.setText(descResp[position]);

                   }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {



                }
            });

        }

    }
}
