/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Codigos;

import Telas2.TelaListaDeChamada;
import com.mysql.jdbc.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Renan
 */
public class Conexao {
    
    String url = "jdbc:mysql://localhost/sql10232285";
    String usuario="root";
//    String senha= "1610";
    String senha= "";
//    String url = "jdbc:mysql://sql10.freesqldatabase.com:3306/sql10232285";
//    String usuario="sql10232285";
//    String senha= "tMBJSC8gQi";  
    
    
    private Connection conexao=null;
    private Statement stmt = null;
    private ResultSet rs=null;
    
    int prof;
    String disc;
    String serie;
    String Aula;
    String Data;
    private int func;
    
    public void conectar() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.jdbc.Driver");
        conexao=DriverManager.getConnection(url, usuario, senha);
        stmt = conexao.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
    }
    
    public void desconectar() throws SQLException{
        conexao.close();
    }
    
    public boolean runSql(String sql){
        boolean res=false;
        try {
            stmt.executeUpdate(sql);
            res=true;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return res;
    }
    
    //Busca a ultima lista do professor
    public int max_lista(String sql){
        try {
            rs=stmt.executeQuery(sql);
            int maximo = 0;
            while(rs.next()){
                
               maximo = rs.getInt("max(Lista_INT_Codigo)");               
               
            }
            //retorna valor maximo
            return maximo;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }   
    }
    
    //Busca a o codigo horario
    public int cod_hor(String sql){
        try {
            rs=stmt.executeQuery(sql);
            int codHor = 0;
            while(rs.next()){
                
               codHor = rs.getInt("Hor_INT_Codigo");               
               
            }
            //retorna valor maximo
            return codHor;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }   
    }
    
    public Pessoa pesquisa_aluno( String sql){
        
        Pessoa resultado = new Pessoa();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                
               // resultado.setRA(rs.getInt("Pess_INT_Codigo"));
                resultado.setNome(rs.getString("pess_ST_Nome"));
                resultado.setRua(rs.getString("pess_ST_Rua"));
                resultado.setCidade(rs.getString("pess_st_cidade"));
                resultado.setNumero(rs.getString("pess_st_numero"));
                resultado.setComplemento(rs.getString("pess_st_complemento"));
                resultado.setBairro(rs.getString("pess_st_bairro"));
                resultado.setCidade(rs.getString("pess_st_cidade"));
                resultado.setUf(rs.getString("pess_st_uf"));
                resultado.setDataNasc(rs.getString("pess_st_datanasc"));
                resultado.setRg(rs.getString("pess_st_Rg"));
                resultado.setCpf(rs.getString("pess_st_cpf"));
                resultado.setTipo(rs.getString("pess_st_tipo"));;
                resultado.setEmail(rs.getString("pess_st_email"));
                resultado.setSenha(rs.getString("pess_st_senha"));
                resultado.setCep(rs.getInt("Pess_INT_CEP"));
      
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public Pessoa pesquisa_professor( String sql){
        
        Pessoa resultado = new Pessoa();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                
                resultado.setRA(rs.getInt("Pro_INT_Codigo"));
                      
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
   
    //Seta os valores vindo da tela Gerar Lista nas variaveis da classe
    public void InfoLista(int prof, String serie, String disc, String Aula, String Data){
       this.prof = prof;
       this.disc = disc;
       this.Aula = Aula;
       this.serie = serie;
       this.Data = Data;
    }
    
    //Busca a existência de uma lista com os dados passados
    public int verifica_chamada (String sql){
                
        try {
            rs=stmt.executeQuery(sql);
            int contador = 0;
            while(rs.next()){
                //A cada registro do banco, preenche a tabela com os dados e pula para a linha seguinte
               contador = rs.getInt("count(*)");               
               
            }
            //retorna valor do contador
            return contador;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }
    
        public int verifica(String sql){
             
            try {
                rs=stmt.executeQuery(sql);
                int contador = 0;
                while(rs.next()){
                    contador = rs.getInt("count(*)");               
               
                }
                //retorna valor do contador
                return contador;
            } catch (SQLException ex) {
                Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
                return 0;
            }
    }
    
    public ArrayList<String> pesquisa_chamada (String sql){
        
        ArrayList<String> resultado = new ArrayList<>();
                
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
              resultado.add(rs.getString("pess_int_codigo")+";"+rs.getString("pess_ST_Nome")+";"+rs.getString("lista_st_situacaoAluno")+";"+rs.getString("Lista_INT_Codigo"));
                
               
            }
            novaLista(resultado);
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public void novaLista(ArrayList<String> result){
        TelaListaDeChamada tlc = new TelaListaDeChamada();
        tlc.setFunc(func);
        tlc.setLista(result);
        tlc.setDados(prof, serie, disc, Aula, Data);
        tlc.setVisible(true);
    }
    
    public ArrayList<String> nova_chamada (String sql){
        
        ArrayList<String> lista = new ArrayList<>();
        try {
            rs=stmt.executeQuery(sql);
            int contador = 0;
            while(rs.next()){
               lista.add(rs.getString("Aluno_INT_Codigo")+";"+rs.getString("pess_ST_Nome"));
               
            }
            novaLista(lista);
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public Telefone pesquisa_telefone (String sql){
        
        Telefone resultado = new Telefone();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                   
                resultado.setDescricao(rs.getString("Tel_ST_Descricao"));
                resultado.setTelefone(rs.getString("Tel_ST_Numero"));
//                resultado.setTamanhoTel(rs.getInt(sql));

            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public Telefone pesquisa_tamtelefone (String sql){
        
        Telefone resultado = new Telefone();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                 resultado.setTamanhoTel(rs.getInt("count(Tel_INT_Codigo)"));
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public Responsavel pesquisa_tamResponsavel (String sql){
            
            Responsavel resultado = new Responsavel();
            try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                 resultado.setTamanho(rs.getInt("count(res_int_codigo)"));
            }
            return resultado;
             } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
 
    
    public Responsavel pesquisa_responsavel (String sql){
        
        Responsavel resultado = new Responsavel();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                
                resultado.setResponsavel(rs.getString("Pess_ST_Nome"));   
                resultado.setDescricao(rs.getString("Res_ST_Descrição"));
                
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public Usuario login(int user){
        
        Usuario resultado =  new Usuario();
        
        try {
            rs=stmt.executeQuery("select pess_st_senha, pess_st_tipo from pcc_tb_pessoas where pess_int_codigo ='"+user+"';");
            while(rs.next()){
                resultado.setSenha(rs.getString("pess_st_senha"));
                resultado.setTipo(rs.getString("pess_st_tipo"));
                
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        
    }
        public Horario codHorario(String sql){
            Horario resultado = new Horario();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                
                resultado.setCodDia(rs.getInt(1));   
                resultado.setCodSerie(rs.getInt("Serie_INT_Codigo"));
                resultado.setDisciplina("disc_int_codigo");

            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        
        }
        public Horario pesquisa_horario (String sql){
        
        Horario resultado = new Horario();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
               
                resultado.setDiadaSemana(rs.getString("Hor_ST_DiaDaSemana"));
                resultado.setCodAula(rs.getInt("Hor_INT_Aula"));
                resultado.setDisciplina(rs.getString("Disc_ST_Descricao"));
                resultado.setNome(rs.getString("Pess_ST_Nome"));
               
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
        public ListadeChamada CodigoLista (String sql){
        
        ListadeChamada resultado = new ListadeChamada();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
               
                resultado.setCodLista(rs.getInt("lista_int_codigo"));
  
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
        
    public Relatorio Disciplinas (String sql){
        
        Relatorio resultado = new Relatorio();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
               
                resultado.setTamanho(rs.getInt("count(Disc_INT_Codigo)"));
  
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }  
    
    public Relatorio relatorio_frequencia (String sql){
        
        Relatorio resultado = new Relatorio();
        
           try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
               
                resultado.setMateria(rs.getString("Matéria"));
                resultado.setQtdAulas(rs.getInt("Quantidade de Aulas"));
                resultado.setQtdPresecas(rs.getInt("Quantidade de Presenças"));
                resultado.setQtdFaltas(rs.getInt("Quantidade de Faltas"));
                resultado.setPorcFreq(rs.getString("Percentual de Frequência"));
  
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public ArrayList<String> pesquisa_maisrecentes (String sql){
        
        ArrayList<String> recentes = new ArrayList();
        int cont = 0;
        String dataFormatada;
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                if(cont<17){
                    String div[] = String.valueOf(rs.getDate("Lista_DT_Data")).split("-");
                    dataFormatada = div[2]+"/"+div[1]+"/"+div[0];
                    recentes.add(dataFormatada+";"+rs.getInt("Hor_INT_Aula")+";"+
                        rs.getString("Serie_ST_Sala")+";"+rs.getString("Lista_ST_SituacaoAluno")+";"+rs.getString("Disc_ST_Descricao")+";"+
                                rs.getString("Pess_ST_Nome"));
                    cont++;
                }
            }
            return recentes;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public ArrayList<String> cod_pessoas (String sql){
        
        ArrayList<String> pessoas = new ArrayList();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                pessoas.add(rs.getString("Pess_INT_Codigo")+";"+rs.getString("Pess_ST_Nome"));
            }
            return pessoas;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
        public Pessoa pesquisa_nome (String sql){
        
        Pessoa resultado = new Pessoa();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
               
                resultado.setSerie(rs.getString("serie_st_descricao"));
                resultado.setNome(rs.getString("pess_st_nome"));
                resultado.setSala(rs.getString("serie_st_sala"));
               
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
        
        
     public Pessoa Codigo_Cadastrado(){
         
         Pessoa resultado = new Pessoa();
           try {
            rs=stmt.executeQuery("SELECT MAX(pess_int_codigo) from pcc_tb_pessoas;");
            while(rs.next()){
                resultado.setRA(rs.getInt("MAX(pess_int_codigo)"));

            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }   
     
     
    public Pessoa pesquisa_codigo (String sql){
        
        Pessoa resultado = new Pessoa();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
               
                resultado.setRA(rs.getInt("pess_int_codigo"));
                
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
   public Pessoa pesquisa_serie (String sql){
        
        Pessoa resultado = new Pessoa();
        
        try {
            rs=stmt.executeQuery(sql);
            while(rs.next()){
               
                resultado.setSerie(rs.getString("serie_st_descricao"));
               
            }
            return resultado;
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public int getFunc() {
        return func;
    }

    public void setFunc(int func) {
        this.func = func;
    }
}
    


