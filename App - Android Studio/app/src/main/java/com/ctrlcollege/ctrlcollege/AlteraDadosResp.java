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
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class AlteraDadosResp extends AppCompatActivity {

    private String user;
    private String url;
    private String parametros;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_altera_dados_resp);

        Intent i = getIntent();
        if (i != null){
            Bundle parametros = i.getExtras();
            if(parametros != null){
                user = parametros.getString("user");
            }
        }

        dadosResp();

        //desabilita teclado
        getWindow().setSoftInputMode(
                WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);

        //Desabilita as editText
        //Ao clicar no botao editar habilita as editText
        desabilita();

        final Button edi = findViewById(R.id.bt_EditarResp);
        edi.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                habilita();
            }});

        final Button salvar = findViewById(R.id.bt_SalvarResp);
        salvar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                alteraDadosResp();
            }
        });

    }

    private void dadosResp(){


        url = "http://192.168.1.2/nodemcu/buscaDados.php";

        parametros = "id="+user;


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

            TextView email = (TextView) findViewById(R.id.txEmailResp);
            TextView endereco = (TextView) findViewById(R.id.txEnderecoResp);
            TextView bairro = (TextView) findViewById(R.id.txBairroResp);
            TextView cidade = (TextView) findViewById(R.id.txCidadeResp);
            TextView uf = (TextView) findViewById(R.id.txUFResp);
            TextView numero = (TextView) findViewById(R.id.txNumeroResp);
            TextView complemento = (TextView) findViewById(R.id.txComplementoResp);


            email.setText(dados[0]);
            endereco.setText(dados[1]);
            bairro.setText(dados[2]);
            cidade.setText(dados[3]);
            numero.setText(dados[4]);
            complemento.setText(dados[5]);
            uf.setText(dados[6]);

        }

    }

    private void alteraDadosResp(){
        ConnectivityManager connMgr = (ConnectivityManager)
                getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();

        if(networkInfo != null && networkInfo.isConnected()) {

            TextView email = (TextView) findViewById(R.id.txEmailResp);
            TextView endereco = (TextView) findViewById(R.id.txEnderecoResp);
            TextView bairro = (TextView) findViewById(R.id.txBairroResp);
            TextView cidade = (TextView) findViewById(R.id.txCidadeResp);
            TextView uf = (TextView) findViewById(R.id.txUFResp);
            TextView numero = (TextView) findViewById(R.id.txNumeroResp);
            TextView complemento = (TextView) findViewById(R.id.txComplementoResp);

            String textEmail = email.getText().toString();

            if(textEmail.equals("")||endereco.getText().toString().equals("")||bairro.getText().toString().equals("")||cidade.getText().toString().equals("")||uf.getText().toString().equals("")||numero.getText().toString().equals("")){
                Toast.makeText(this, "Campo(s) não preenchido(s) corretamente", Toast.LENGTH_SHORT).show();
            }else{
                url = "http://192.168.1.2/nodemcu/alteraDados.php";

                parametros = "id="+ user+"&email="+email.getText()+"&endereco="+endereco.getText()+"&bairro="+bairro.getText()+
                        "&cidade="+cidade.getText()+"&numero="+numero.getText()+"&complemento="+complemento.getText()+"&uf="+uf.getText();

                if(textEmail.contains("@")&&textEmail.contains(".com")){
                    //fetch data
                    new AlteraDadosResp.AlteraDados().execute(url);}
                else{
                    Toast.makeText(this, "O e-mail digitado está incorreto", Toast.LENGTH_SHORT).show();
                }
            }
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
            Toast.makeText(AlteraDadosResp.this, result, Toast.LENGTH_LONG).show();
            if(result.contains("Dados alterados com sucesso")){
                desabilita();
            }
        }

    }

    public void desabilita(){

        TextView email = (TextView) findViewById(R.id.txEmailResp);
        TextView endereco = (TextView) findViewById(R.id.txEnderecoResp);
        TextView bairro = (TextView) findViewById(R.id.txBairroResp);
        TextView cidade = (TextView) findViewById(R.id.txCidadeResp);
        TextView uf = (TextView) findViewById(R.id.txUFResp);
        TextView numero = (TextView) findViewById(R.id.txNumeroResp);
        TextView complemento = (TextView) findViewById(R.id.txComplementoResp);
        Button salvar = (Button) findViewById(R.id.bt_SalvarResp);

        salvar.setEnabled(false);
        email.setEnabled(false);
        endereco.setEnabled(false);
        bairro.setEnabled(false);
        uf.setEnabled(false);
        cidade.setEnabled(false);
        numero.setEnabled(false);
        complemento.setEnabled(false);
    }
    @Override
    public void onBackPressed() {
        Intent i = new Intent(this, TelaMenuPais.class);
        Bundle parametros = new Bundle();
        parametros.putString("user", user);

        i.putExtras(parametros);

        startActivity(i);
        finish();
    }
    public void habilita(){

        TextView email = (TextView) findViewById(R.id.txEmailResp);
        TextView endereco = (TextView) findViewById(R.id.txEnderecoResp);
        TextView bairro = (TextView) findViewById(R.id.txBairroResp);
        TextView cidade = (TextView) findViewById(R.id.txCidadeResp);
        TextView uf = (TextView) findViewById(R.id.txUFResp);
        TextView numero = (TextView) findViewById(R.id.txNumeroResp);
        TextView complemento = (TextView) findViewById(R.id.txComplementoResp);
        Button salvar = (Button) findViewById(R.id.bt_SalvarResp);

        salvar.setEnabled(true);
        email.setEnabled(true);
        endereco.setEnabled(true);
        bairro.setEnabled(true);
        uf.setEnabled(true);
        cidade.setEnabled(true);
        numero.setEnabled(true);
        complemento.setEnabled(true);
    }
}
