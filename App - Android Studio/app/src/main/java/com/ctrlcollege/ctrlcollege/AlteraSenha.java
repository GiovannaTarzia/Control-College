package com.ctrlcollege.ctrlcollege;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class AlteraSenha extends AppCompatActivity {

    private String user;
    private String url = "";
    private String parametros = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_altera_senha);

        Intent i = getIntent();
        if(i != null){
            Bundle parametros = i.getExtras();

            if(parametros != null){
                user = parametros.getString("user");
            }
        }

        Button salvar = (Button) findViewById(R.id.bt_salvaSenha);

        salvar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText senhaAtual = (EditText) findViewById(R.id.tx_senhaAtual);
                EditText senhaNova = (EditText) findViewById(R.id.tx_senhaNova);
                EditText confirmSenhaNova = (EditText) findViewById(R.id.tx_confirmSenha);

                if (senhaNova.getText().toString().equals(confirmSenhaNova.getText().toString())){

                    url = "http://192.168.1.100/nodemcu/alteraSenha.php";

                    parametros = "id="+ user +"&sa="+senhaAtual.getText().toString()+"&sn="+senhaNova.getText().toString();

                    //fetch data
                    new Alterar().execute(url);

                }else{
                    Toast.makeText(AlteraSenha.this, "As senhas digitadas não são iguais", Toast.LENGTH_SHORT).show();
                    senhaNova.setText(null);
                    confirmSenhaNova.setText(null);
                    senhaNova.requestFocus();
                }

            }
        });
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

    private class Alterar extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls){

            return Conexao.postDados(urls[0], parametros);

        }
        // onPostExecute displays the results of the AsyncTask
        @Override
        protected void onPostExecute(String result){
            Toast.makeText(AlteraSenha.this, result, Toast.LENGTH_SHORT).show();

            Intent i=new Intent(AlteraSenha.this, TelaMenuPais.class);

            Bundle parametros = new Bundle();
            parametros.putString("user", user);

            i.putExtras(parametros);

            startActivity(i);
            finish();
        }
    }
}
