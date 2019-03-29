/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Codigos;

/**
 *
 * @author Renan
 */
public class Horario extends Pessoa{
    private int codAula;
    private int codDia;
    private int codSerie;
    private int codHorario;
    private int codDisciplina;
    private String AulaH;
    private String Serie;
    private String Disciplina;
    private String DiadaSemana;

    
    
    
    
    
    public int getCodAula() {
        return codAula;
    }

    public void setCodAula(int codAula) {
        this.codAula = codAula;
    }

    public int getCodDia() {
        return codDia;
    }

    public void setCodDia(int codDia) {
        this.codDia = codDia;
    }

    public int getCodSerie() {
        return codSerie;
    }

    public void setCodSerie(int codSerie) {
        this.codSerie = codSerie;
    }

    public int getCodHorario() {
        return codHorario;
    }

    public void setCodHorario(int codHorario) {
        this.codHorario = codHorario;
    }

    public int getCodDisciplina() {
        return codDisciplina;
    }

    public void setCodDisciplina(int codDisciplina) {
        this.codDisciplina = codDisciplina;
    }

    public String getAulaH() {
        return AulaH;
    }

    public void setAulaH(String AulaH) {
        this.AulaH = AulaH;
    }

    public String getSerie() {
        return Serie;
    }

    public void setSerie(String Serie) {
        this.Serie = Serie;
    }

    public String getDisciplina() {
        return Disciplina;
    }

    public void setDisciplina(String Disciplina) {
        this.Disciplina = Disciplina;
    }

    public String getDiadaSemana() {
        return DiadaSemana;
    }

    public void setDiadaSemana(String DiadaSemana) {
        this.DiadaSemana = DiadaSemana;
    }

    
    
}
