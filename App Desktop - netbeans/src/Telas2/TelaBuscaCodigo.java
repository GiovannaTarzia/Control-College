/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Telas2;

import Codigos.Conexao;
import Codigos.Pessoa;
import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.event.KeyEvent;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import static javax.swing.SwingConstants.CENTER;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Renan
 */
public class TelaBuscaCodigo extends javax.swing.JFrame {
    
    private ArrayList<String> pessoas;
    private String tipo;
    private String sql;
    private final String[] columnNames = {"Código", "Nome"};
    private final JTable tabela;
    private JScrollPane sp = new JScrollPane();


    /**
     * Creates new form BuscaCodigo
     */
    public TelaBuscaCodigo() {
        initComponents();
        tabela = new JTable();
        tabela.setEnabled(false);
        setLayout(new FlowLayout());
        sp = new JScrollPane(tabela);
        add(sp);
                
    }
    
    
    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void getCod (){
        Conexao c = new Conexao();
        
        if(getTipo().equals("")){ // Verifica se a variavel Tipo está vazia
            
            // Se sim, seleciona essa select para ser executada!
            sql="select Pess_INT_Codigo, Pess_ST_Nome from pcc_tb_pessoas where Pess_ST_Situacao = 'Ativado' and Pess_ST_Nome like '"+jCTNome.getText()+"%';";
        }else{
            
            //Se não, seleciona essa select com um campo especifico para o tipo de pessoa cadastrada
            sql="select Pess_INT_Codigo, Pess_ST_Nome from pcc_tb_pessoas where Pess_ST_Situacao = 'Ativado' and Pess_ST_Tipo = '"+getTipo()+"' and Pess_ST_Nome like '"+jCTNome.getText()+"%';"; 
        }
        
        try {
            c.conectar();
            pessoas = c.cod_pessoas(sql); // Executa a select seleciona acima!
            tabela(); // Preenche a tabela com os dados encontrados 
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TelaBuscaCodigo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TelaBuscaCodigo.class.getName()).log(Level.SEVERE, null, ex);
        }
        
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
    
    public void tabela(){ // Método que cria a tabela 
        
        Object[][] data = new Object[pessoas.size()][2];
        
        for(int i =0; i<pessoas.size(); i++){
            String divisor[] = pessoas.get(i).split(";");
            data[i][0] = divisor[0];
            data[i][1] = divisor[1];
        }
        
        
        tabela.setModel(new DefaultTableModel(data, columnNames));
        tabela.setPreferredScrollableViewportSize(new Dimension(380,380));
        tabela.setFillsViewportHeight(true);
        tabela.setDefaultRenderer(Object.class, new TelaBuscaCodigo.CellRenderer());
        
        
    }
    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLCodigo = new javax.swing.JLabel();
        jCTNome = new Codigos.JCTextField();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Busca de Código");
        setBackground(new java.awt.Color(255, 255, 255));
        setPreferredSize(new java.awt.Dimension(431, 500));
        addWindowFocusListener(new java.awt.event.WindowFocusListener() {
            public void windowGainedFocus(java.awt.event.WindowEvent evt) {
            }
            public void windowLostFocus(java.awt.event.WindowEvent evt) {
                formWindowLostFocus(evt);
            }
        });

        jLCodigo.setFont(new java.awt.Font("Arial", 1, 14)); // NOI18N

        jCTNome.setPlaceholder("Nome:");
        jCTNome.setPreferredSize(new java.awt.Dimension(400, 32));
        jCTNome.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jCTNomeActionPerformed(evt);
            }
        });
        jCTNome.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                jCTNomeKeyPressed(evt);
            }
            public void keyReleased(java.awt.event.KeyEvent evt) {
                jCTNomeKeyReleased(evt);
            }
            public void keyTyped(java.awt.event.KeyEvent evt) {
                jCTNomeKeyTyped(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(124, 124, 124)
                .addComponent(jLCodigo, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jCTNome, javax.swing.GroupLayout.DEFAULT_SIZE, 411, Short.MAX_VALUE)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(23, 23, 23)
                .addComponent(jCTNome, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(121, 121, 121)
                .addComponent(jLCodigo, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGap(21, 21, 21))
        );

        pack();
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void jCTNomeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jCTNomeActionPerformed
        
    }//GEN-LAST:event_jCTNomeActionPerformed

    private void jCTNomeKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jCTNomeKeyPressed
        
    }//GEN-LAST:event_jCTNomeKeyPressed

    private void jCTNomeKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jCTNomeKeyReleased
        getCod();
    }//GEN-LAST:event_jCTNomeKeyReleased

    private void formWindowLostFocus(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowLostFocus
        this.dispose();
    }//GEN-LAST:event_formWindowLostFocus

    private void jCTNomeKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jCTNomeKeyTyped
        char vchar = evt.getKeyChar();
        if(!(Character.isLetter(vchar)) || (vchar == KeyEvent.VK_BACK_SPACE) || (vchar == KeyEvent.VK_DELETE)){
            evt.consume();
        }
    }//GEN-LAST:event_jCTNomeKeyTyped

    public static void main(String args[]) {
                        
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new TelaBuscaCodigo().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private Codigos.JCTextField jCTNome;
    private javax.swing.JLabel jLCodigo;
    // End of variables declaration//GEN-END:variables
}
