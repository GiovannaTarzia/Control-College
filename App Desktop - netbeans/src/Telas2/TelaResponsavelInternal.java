/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Telas2;

import TelasAntigas.TelaCadastro2;
import Codigos.Conexao;
import Codigos.Responsavel;
import java.awt.Component;
import java.awt.event.KeyEvent;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import static javax.swing.SwingConstants.CENTER;
import javax.swing.table.DefaultTableCellRenderer;

/**
 *
 * @author Renan
 */
public class TelaResponsavelInternal extends javax.swing.JInternalFrame {
    private int func;
    private String log;
    private String registroLog;
    /**
     * Creates new form TelaResponsavelInternal
     */
    public TelaResponsavelInternal() {
        initComponents();
        jTabelaRespo.setDefaultRenderer(Object.class, new CellRenderer());
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel18 = new javax.swing.JLabel();
        jTFCodigoAluno = new javax.swing.JTextField();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTabelaRespo = new javax.swing.JTable();
        jTFDescrRespo = new javax.swing.JTextField();
        jLabel19 = new javax.swing.JLabel();
        jLabel20 = new javax.swing.JLabel();
        jBAddR = new javax.swing.JButton();
        jBBuscarR = new javax.swing.JButton();
        jBExR = new javax.swing.JButton();
        jBLimparR = new javax.swing.JButton();
        jBBusCod2 = new javax.swing.JButton();
        jTFCodigoResp = new javax.swing.JTextField();
        jBBusCod3 = new javax.swing.JButton();

        setBackground(new java.awt.Color(255, 255, 255));
        setClosable(true);
        setMinimumSize(new java.awt.Dimension(820, 620));
        setPreferredSize(new java.awt.Dimension(820, 620));

        jLabel18.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        jLabel18.setText("RA:");

        jTFCodigoAluno.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        jTFCodigoAluno.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jTFCodigoAluno.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyTyped(java.awt.event.KeyEvent evt) {
                jTFCodigoAlunoKeyTyped(evt);
            }
        });

        jTabelaRespo.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null},
                {null, null}
            },
            new String [] {
                "Nome", "Descrição"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jTabelaRespo.setGridColor(new java.awt.Color(0, 0, 0));
        jTabelaRespo.setSelectionBackground(new java.awt.Color(51, 102, 255));
        jScrollPane2.setViewportView(jTabelaRespo);

        jTFDescrRespo.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        jTFDescrRespo.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jTFDescrRespo.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyTyped(java.awt.event.KeyEvent evt) {
                jTFDescrRespoKeyTyped(evt);
            }
        });

        jLabel19.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        jLabel19.setText("Descrição:");

        jLabel20.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N
        jLabel20.setText("Cod. do Responsável: ");

        jBAddR.setFont(new java.awt.Font("Arial", 1, 12)); // NOI18N
        jBAddR.setText("Adicionar");
        jBAddR.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jBAddR.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jBAddRActionPerformed(evt);
            }
        });

        jBBuscarR.setFont(new java.awt.Font("Arial", 1, 12)); // NOI18N
        jBBuscarR.setText("Buscar");
        jBBuscarR.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jBBuscarR.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jBBuscarRActionPerformed(evt);
            }
        });

        jBExR.setFont(new java.awt.Font("Arial", 1, 12)); // NOI18N
        jBExR.setText("Excluir");
        jBExR.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jBExR.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jBExRActionPerformed(evt);
            }
        });

        jBLimparR.setFont(new java.awt.Font("Arial", 1, 12)); // NOI18N
        jBLimparR.setText("Limpar");
        jBLimparR.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jBLimparR.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jBLimparRActionPerformed(evt);
            }
        });

        jBBusCod2.setText("...");
        jBBusCod2.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jBBusCod2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jBBusCod2ActionPerformed(evt);
            }
        });

        jTFCodigoResp.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        jTFCodigoResp.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jTFCodigoResp.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyTyped(java.awt.event.KeyEvent evt) {
                jTFCodigoRespKeyTyped(evt);
            }
        });

        jBBusCod3.setText("...");
        jBBusCod3.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jBBusCod3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jBBusCod3ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jBAddR, javax.swing.GroupLayout.PREFERRED_SIZE, 102, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(jBBuscarR, javax.swing.GroupLayout.PREFERRED_SIZE, 102, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(jBExR, javax.swing.GroupLayout.PREFERRED_SIZE, 102, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(jBLimparR, javax.swing.GroupLayout.PREFERRED_SIZE, 102, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel20)
                        .addGap(18, 18, 18)
                        .addComponent(jTFCodigoResp, javax.swing.GroupLayout.PREFERRED_SIZE, 142, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jBBusCod3, javax.swing.GroupLayout.PREFERRED_SIZE, 64, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel19)
                            .addComponent(jLabel18, javax.swing.GroupLayout.PREFERRED_SIZE, 59, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(100, 100, 100)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jTFCodigoAluno, javax.swing.GroupLayout.PREFERRED_SIZE, 138, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(jBBusCod2, javax.swing.GroupLayout.PREFERRED_SIZE, 66, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(jTFDescrRespo))))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 576, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(143, 143, 143))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(59, 59, 59)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 288, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jTFCodigoAluno, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel18, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jBBusCod2, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jTFDescrRespo, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel19, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                .addComponent(jTFCodigoResp, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(jBBusCod3, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(jLabel20, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(106, 106, 106)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jBLimparR, javax.swing.GroupLayout.PREFERRED_SIZE, 44, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jBExR, javax.swing.GroupLayout.PREFERRED_SIZE, 44, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jBBuscarR, javax.swing.GroupLayout.PREFERRED_SIZE, 44, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jBAddR, javax.swing.GroupLayout.PREFERRED_SIZE, 44, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addGap(143, 143, 143))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    public int getFunc() {
        return func;
    }

    public void setFunc(int func) {
        this.func = func;
    }

        public class CellRenderer extends DefaultTableCellRenderer {
	public CellRenderer() {
		super();
	}
	public Component getTableCellRendererComponent(JTable table, Object value,
			boolean isSelected, boolean hasFocus, int row, int column) {
		this.setHorizontalAlignment(CENTER);
		return super.getTableCellRendererComponent(table, value, isSelected,
				hasFocus, row, column);
	}
}
        
    private void jBAddRActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jBAddRActionPerformed
       //Verifica se o campos estão preenchidos
        if(jTFCodigoAluno.getText().equals("")||jTFDescrRespo.getText().equals("")||jTFCodigoResp.getText().equals("")){
            JOptionPane.showMessageDialog(this, "Campo(s) não preenchido(s) corretamente!!!");
        }else{
        Responsavel r = new Responsavel();
        Conexao c = new Conexao();

        r.setRA(Integer.parseInt(jTFCodigoAluno.getText()));
        r.setResponsavel(jTFCodigoResp.getText());
        r.setDescricao(jTFDescrRespo.getText().toUpperCase());
        
        //Verifica se o RA digitado é realmente de um aluno
        String existeAluno = "select count(*) from pcc_tb_pessoas where Pess_INT_Codigo = "+r.getRA()+" and Pess_ST_Situacao = 'Ativado' and Pess_ST_Tipo='Aluno';";
            try {
                c.conectar();
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(TelaResponsavelInternal.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(TelaResponsavelInternal.class.getName()).log(Level.SEVERE, null, ex);
            }
        int contAlu = c.verifica(existeAluno);
        if(contAlu == 0){
            JOptionPane.showMessageDialog(this, "O RA digitado não é de um aluno");
        }else{
        
        //Verifica se o responsável já foi cadastrado para aquele aluno
        String verifica = "select count(*) from pcc_tb_responsavel where Alu_INT_Codigo = "+r.getRA()+
                " and Resp_INT_Codigo = "+r.getResponsavel()+";";
        int contResp = c.verifica(verifica);
        
        if(contResp == 0){

        //Comando que cadastra no banco de dados os valores lidos (Tabela: pcc_tb_responsaveis)
        //correspondente com um codigo de usuario
        String cadres= "call proc_CadResponsavel('"+r.getResponsavel()+"', '"+r.getRA()+"', '"+r.getDescricao()+"');";

        try {
            c.conectar();
            if(c.runSql(cadres)){
                JOptionPane.showMessageDialog(null, "Cadastrado com sucesso!");
                log = "Cadastro de novo responsável para aluno de ID: "+r.getRA()+";";
                registroLog = "insert into pcc_tb_log values(null,"+func+",'"+log+"', default);";
                c.runSql(registroLog);
                }else{
                JOptionPane.showMessageDialog(null, "Não foi possivel cadastrar!");
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TelaCadastro2.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TelaCadastro2.class.getName()).log(Level.SEVERE, null, ex);
        }
        jBBuscarR.doClick(); // Executa o botão de busv=car para mostrar que foi cadastrado 
        }else{
            JOptionPane.showMessageDialog(this, "Este responsável já foi cadastrado para esse aluno");
        }}
    }
        
    }//GEN-LAST:event_jBAddRActionPerformed
       
    public void LimpaTabela(){ // Método para limpar a tabela de responsaveis 
        for(int i = 0; i<jTabelaRespo.getRowCount(); i++){
           jTabelaRespo.setValueAt(null, i, 0);
           jTabelaRespo.setValueAt(null, i, 1);
       }
    }
       
    private void jBBuscarRActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jBBuscarRActionPerformed
       //Verifica se o campo foi preechido 
        if(jTFCodigoAluno.getText().equals("")){
            JOptionPane.showMessageDialog(this, "Nenhum código digitado");
        }else{
        Responsavel  a = new  Responsavel();
        Responsavel  x = new  Responsavel();
        Conexao c = new Conexao();
        int linha=1;

        int codigo = Integer.parseInt(jTFCodigoAluno.getText());

        //Comando que realiza uma contagem de dados inseridos na tabela de responsavel de
        //acordo com o codigo do usuario e esse valor é inserido na variavel (tamanhoR)
        String tamanhoR = "select count(res_int_codigo) from pcc_tb_responsavel"
        + "  where alu_int_codigo = '"+codigo+"';";

        try {
            c.conectar();

            jTabelaRespo.setVisible(true);
            x= c.pesquisa_tamResponsavel(tamanhoR);
            LimpaTabela();
            if(!c.equals(null)){
                if(x.getTamanho() == 0){
                    JOptionPane.showMessageDialog(this, "Nenhum responsável encontrado!!!");
                }else{
                do{
                    //Comando que realiza uma busca na tabela de responsavel com base em um codigo de pessoa
                    String buscar= "select a.pess_st_nome, b.res_st_descrição "
                    + "from pcc_tb_pessoas a , pcc_tb_responsavel b where "
                    + "a.Pess_INT_Codigo = b.Resp_INT_Codigo and a.Pess_ST_Situacao = 'Ativado' "
                    + "and b.Alu_INT_Codigo = '"+codigo+"' and b.Res_INT_Codigo = '"+linha+"';";

                    a=c.pesquisa_responsavel(buscar);
                    jTabelaRespo.setValueAt(a.getResponsavel(), linha-1 , 0);
                    jTabelaRespo.setValueAt(a.getDescricao(), linha-1, 1);
                    linha++;
                    
                }while (linha <= x.getTamanho());//Determina quantas vezes a impressão dos valores encotrados deve ser feita
            }}
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TelaCadastro2.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TelaCadastro2.class.getName()).log(Level.SEVERE, null, ex);
        }}
    }//GEN-LAST:event_jBBuscarRActionPerformed

    private void jBExRActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jBExRActionPerformed
        // TODO add your handling code here:
        Responsavel r = new Responsavel();
        Conexao c = new Conexao();

        r.setRA(Integer.parseInt(jTFCodigoAluno.getText()));
        r.setResponsavel(jTFCodigoResp.getText());
        try {
            c.conectar();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TelaResponsavelInternal.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TelaResponsavelInternal.class.getName()).log(Level.SEVERE, null, ex);
        }
        //Verifica se o aluno possui no mínimo um responsável cadastrado
        String ultimoResp = "select count(*) from pcc_tb_responsavel where Alu_INT_Codigo = "+r.getRA()+";";
        if(c.verifica(ultimoResp) == 1){
            JOptionPane.showMessageDialog(this, "É necessário ter no mínimo um responsável cadastrado");
        }else{
        //Comando que realiza uma exclusão na tebela de responsavel baseado no RA do aluno e no CPF do responsavel
        String deletar = "delete from pcc_tb_responsavel "
        + "where Alu_INT_Codigo = '"+r.getRA()+"' and "
        + "Resp_INT_Codigo = "+r.getResponsavel()+" ;";

        try {
            c.conectar();
            if(c.runSql(deletar)){
                JOptionPane.showMessageDialog(null, "Deletado com sucesso!");
                log = "Exclusão de responsável de aluno com RA: "+r.getRA()+";";
                registroLog = "insert into pcc_tb_log values(null,"+func+",'"+log+"', default);";
                c.runSql(registroLog);
            }else{
                JOptionPane.showMessageDialog(null, "Não foi possivel excluir");
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TelaCadastro2.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TelaCadastro2.class.getName()).log(Level.SEVERE, null, ex);
        }}
        jBBuscarR.doClick();
    }//GEN-LAST:event_jBExRActionPerformed

    private void jBLimparRActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jBLimparRActionPerformed
        // TODO add your handling code here:
        LimpaTelaRespo();
        
    }//GEN-LAST:event_jBLimparRActionPerformed

    private void jBBusCod2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jBBusCod2ActionPerformed
        // TODO add your handling code here:

        TelaBuscaCodigo t = new TelaBuscaCodigo();
        t.setTipo("Aluno");
        t.getCod();
        t.setVisible(true);

    }//GEN-LAST:event_jBBusCod2ActionPerformed

    private void jTFCodigoAlunoKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jTFCodigoAlunoKeyTyped
        char vchar = evt.getKeyChar();
        if(!(Character.isDigit(vchar)) || (vchar == KeyEvent.VK_BACK_SPACE) || (vchar == KeyEvent.VK_DELETE)){
            evt.consume();
        }
    }//GEN-LAST:event_jTFCodigoAlunoKeyTyped

    private void jTFDescrRespoKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jTFDescrRespoKeyTyped
        char vchar = evt.getKeyChar();
        if(!(Character.isLetter(vchar)) || (vchar == KeyEvent.VK_BACK_SPACE) || (vchar == KeyEvent.VK_DELETE)){
            evt.consume();
        }
    }//GEN-LAST:event_jTFDescrRespoKeyTyped

    private void jTFCodigoRespKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jTFCodigoRespKeyTyped
        char vchar = evt.getKeyChar();
        if(!(Character.isDigit(vchar)) || (vchar == KeyEvent.VK_BACK_SPACE) || (vchar == KeyEvent.VK_DELETE)){
            evt.consume();
        }
    }//GEN-LAST:event_jTFCodigoRespKeyTyped

    private void jBBusCod3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jBBusCod3ActionPerformed
        TelaBuscaCodigo t = new TelaBuscaCodigo();
        t.setTipo("Responsável");
        t.getCod();
        t.setVisible(true);
    }//GEN-LAST:event_jBBusCod3ActionPerformed
    public void LimpaTelaRespo() {
        //Metodo que "Limpa" todas as caixas de texto no painel "Responsavel"
        jTFCodigoAluno.setText(null);
        jTFDescrRespo.setText(null);
        jTFCodigoResp.setText(null);
        LimpaTabela();
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jBAddR;
    private javax.swing.JButton jBBusCod2;
    private javax.swing.JButton jBBusCod3;
    private javax.swing.JButton jBBuscarR;
    private javax.swing.JButton jBExR;
    private javax.swing.JButton jBLimparR;
    private javax.swing.JLabel jLabel18;
    private javax.swing.JLabel jLabel19;
    private javax.swing.JLabel jLabel20;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTextField jTFCodigoAluno;
    private javax.swing.JTextField jTFCodigoResp;
    private javax.swing.JTextField jTFDescrRespo;
    private javax.swing.JTable jTabelaRespo;
    // End of variables declaration//GEN-END:variables
}
