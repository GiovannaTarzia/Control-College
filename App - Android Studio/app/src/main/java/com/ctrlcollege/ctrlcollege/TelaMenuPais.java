package com.ctrlcollege.ctrlcollege;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.CardView;
import android.view.View;
import android.support.design.widget.NavigationView;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;

public class TelaMenuPais extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener, View.OnClickListener {

    private CardView frequencia;
    private CardView dados;
    private String user;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tela_menu_pais);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.addDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

        Intent i = getIntent();
        if(i != null){
            Bundle parametros = i.getExtras();

            if(parametros != null){
                user = parametros.getString("user");
            }
        }

        //Definindo card por id
        frequencia = (CardView) findViewById(R.id.cv_frequência);
        dados = (CardView) findViewById(R.id.cv_dadosAluno);

        // Adicionando o 'Click Listener' aos cards
        frequencia.setOnClickListener(TelaMenuPais.this);
        dados.setOnClickListener(TelaMenuPais.this);
    }

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            checkExit();
        }
    }

    private void checkExit()
    {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage("Deseja realmente sair?")
                .setCancelable(false)
                .setPositiveButton("Sim", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        startActivity(new Intent(TelaMenuPais.this, TelaLogin.class)); //O efeito ao ser pressionado do botão (no caso abre a activity)
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

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.tela_menu_pais, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();



        return super.onOptionsItemSelected(item);
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        if (id == R.id.alt_dados) {
            Intent i=new Intent(TelaMenuPais.this, AlteraDadosResp.class);

            Bundle parametros = new Bundle();
            parametros.putString("user", user);

            i.putExtras(parametros);

            startActivity(i);
            finish();
        } else if (id == R.id.alt_senha) {

            Intent i=new Intent(TelaMenuPais.this, AlteraSenha.class);

            Bundle parametros = new Bundle();
            parametros.putString("user", user);

            i.putExtras(parametros);

            startActivity(i);
            finish();

        }

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }

    @Override
    public void onClick(View v) {
        Intent i;
        Bundle parametros = new Bundle();
        parametros.putString("user", user);

        switch (v.getId()) {
            case R.id.cv_frequência:
                i = new Intent(this, Situacao.class);

                i.putExtras(parametros);

                startActivity(i);
                finish();
                break;

            case R.id.cv_dadosAluno:
                i = new Intent(this, AltCadastro.class);

                i.putExtras(parametros);

                startActivity(i);
                finish();
                break;
        }
    }

}
