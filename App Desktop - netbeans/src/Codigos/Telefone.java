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
public class Telefone extends Pessoa{
      private String Telefone;
      private int tamanhoTel;
      private String descricao;

    public String getTelefone() {
        return Telefone;
    }

    public void setTelefone(String Telefone) {
        this.Telefone = Telefone;
    }

    public int getTamanhoTel() {
        return tamanhoTel;
    }

    public void setTamanhoTel(int tamanhoTel) {
        this.tamanhoTel = tamanhoTel;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    
}
