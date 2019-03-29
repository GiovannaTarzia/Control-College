package com.ctrlcollege.ctrlcollege;

import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class TelaLogin extends AppCompatActivity{
    private Button login;
    private EditText user;
    private EditText pass;
    private String cod;
    private String url = "";
    private String parametros = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tela_login);

        //Definindo card por id
        login = (Button) findViewById(R.id.botaoLogin);

        login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                user = (EditText) findViewById(R.id.textID);
                pass = (EditText) findViewById(R.id.textPass);
                String textUser = String.valueOf(user.getText());
                String textPass = String.valueOf(pass.getText());

                ConnectivityManager connMgr = (ConnectivityManager)
                        getSystemService(Context.CONNECTIVITY_SERVICE);
                NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();

                //para testes locais
                if(textUser.equals("admin")&&textPass.equals("admin")){
                    Intent i=new Intent(TelaLogin.this, TelaMenuPais.class);
                    startActivity(i);
                    finish();
                }else {
                    if(networkInfo != null && networkInfo.isConnected()) {
                        if(textUser.isEmpty() || textPass.isEmpty()){
                            Toast.makeText(getApplicationContext(),"Há um campo vazio. Preencha todos corretamente", Toast.LENGTH_LONG).show();
                        } else {

                            url = "http://192.168.1.2/nodemcu/login.php";

                            parametros = "user="+ textUser +"&senha="+textPass;

                            //fetch data
                            new SolicitaDados().execute(url);}
                    }else {
                        //display error
                        Toast.makeText(getApplicationContext(), "Nenhuma conexão foi detectada", Toast.LENGTH_SHORT).show();
                    }

                }
            }
        });


    }


    public void onBackPressed(){ //Botão BACK padrão do android

        finishAffinity();

    }



    private class SolicitaDados extends AsyncTask<String, Void, String>{
        @Override
        protected String doInBackground(String... urls){

                return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){
            if(result != null){
                if(result.contains("Funcionário")){
                    Intent i=new Intent(TelaLogin.this, SelecionaAluno.class);
                    startActivity(i);
                    finish();
                }else{
                    if(result.contains("Responsável")){
                        String[] divisao = result.split(",");
                        cod = divisao[1];
                        Intent i=new Intent(TelaLogin.this, TelaMenuPais.class);

                        Bundle parametros = new Bundle();
                        parametros.putString("user", cod);

                        i.putExtras(parametros);

                        startActivity(i);
                        finish();
                    }
                    else{
                        Toast.makeText(TelaLogin.this, "O Usuário ou Senha informados estão incorretos", Toast.LENGTH_SHORT).show();
                        user.setText("");
                        pass.setText("");
                        user.requestFocus();
                    }
                }
            }
        }
    }

}
