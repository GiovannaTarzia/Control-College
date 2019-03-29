/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Codigos;

import java.sql.Date;


/**
 *
 * @author Renan
 */
public class ListadeChamada extends Pessoa{
    private String datachamada;
    private String Aula;
    private String Sala;
    private String Situacao;
    private String Disciplina;
    private int tamanho; 
    private int CodLista;
    private Date Datarecente;
    private int AulaR;
    
    
    public String getDatachamada() {
        return datachamada;
    }

    public void setDatachamada(String datachamada) {
        this.datachamada = datachamada;
    }

    public String getAula() {
        return Aula;
    }

    public void setAula(String Aula) {
        this.Aula = Aula;
    }

    public String getSala() {
        return Sala;
    }

    public void setSala(String Sala) {
        this.Sala = Sala;
    }

    public String getSituacao() {
        return Situacao;
    }

    public void setSituacao(String Situacao) {
        this.Situacao = Situacao;
    }

    public String getDisciplina() {
        return Disciplina;
    }

    public void setDisciplina(String Disciplina) {
        this.Disciplina = Disciplina;
    }

    public int getTamanho() {
        return tamanho;
    }

    public void setTamanho(int tamanho) {
        this.tamanho = tamanho;
    }

    public int getCodLista() {
        return CodLista;
    }

    public void setCodLista(int CodLista) {
        this.CodLista = CodLista;
    }

    public Date getDatarecente() {
        return Datarecente;
    }

    public void setDatarecente(Date Datarecente) {
        this.Datarecente = Datarecente;
    }

    public int getAulaR() {
        return AulaR;
    }

    public void setAulaR(int AulaR) {
        this.AulaR = AulaR;
    }
    
}
