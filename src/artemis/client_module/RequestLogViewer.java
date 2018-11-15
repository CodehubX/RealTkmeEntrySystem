/*
 * Copyright (c) FOREVER, Jefferson Buot. All rights reserved.
 * Build | Imagine | Think | Explore -> By: Jeff 
 */
package artemis.client_module;

import artemis.classes.LoggerFile;
import artemis.classes.Tip;
import artemis.dialogs.ArtemisConfirm;
import artemis.panels.QueryResultViewer;
import com.jeff.util.ChromieDB;
import java.awt.Component;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Jefferson
 */
public class RequestLogViewer extends javax.swing.JDialog {

    /**
     * Creates new form RequestLogViewer
     *
     * @param comp
     */
    RequestLogData rld[];
    File file;

    public RequestLogViewer(Component comp) {
        this.file = LoggerFile.LOG_FILE;
        initComponents();
        setModal(true);
        setLocationRelativeTo(comp);
        btnDelete.setVisible(false);
        btnSelectAll.setVisible(false);
        initTable();
    }

    public RequestLogViewer(Component comp, File file) {
        this.file = file;
        initComponents();
        setModal(true);
        setLocationRelativeTo(comp);
        btnDelete.setVisible(false);
        btnSelectAll.setVisible(false);
        initTable();
    }

    private void initTable() {
        List<RequestLogData> tmp = ChromieDB.loadListData(file, RequestLogData.class);
        this.rld = new RequestLogData[tmp.size()];
        int h = 0;
        for (int n = rld.length - 1; n >= 0; n--) {
            rld[h++] = tmp.get(n);
        }
        DefaultTableModel dtm = new DefaultTableModel() {

            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }

        };
        dtm.addColumn("Date");
        dtm.addColumn("Time");
        dtm.addColumn("Description");
        for (RequestLogData r : rld) {
            dtm.addRow(new String[]{r.getDate(), r.getTime(), r.getDesc()});
        }
        table.setModel(dtm);
        if (table.getColumnModel().getColumnCount() > 0) {
            table.getColumnModel().getColumn(0).setPreferredWidth(70);
            table.getColumnModel().getColumn(1).setPreferredWidth(70);
            table.getColumnModel().getColumn(2).setPreferredWidth(400);
        }
    }

    private void makeSelection() {
        DefaultTableModel dtm = new DefaultTableModel() {

            @Override
            public boolean isCellEditable(int row, int column) {
                return column == table.getColumnCount() - 1;
            }

        };
        for (int h = 0; h < table.getColumnCount(); h++) {
            dtm.addColumn(table.getColumnName(h));
        }
        dtm.addColumn("Delete");
        for (int i = 0; i < table.getRowCount(); i++) {
            Object[] dr = new Object[table.getColumnCount() + 1];
            for (int h = 0; h < dr.length - 1; h++) {
                dr[h] = table.getValueAt(i, h);
            }
            dr[dr.length - 1] = false;
            dtm.addRow(dr);
        }
        table.setModel(dtm);
    }

    public static void showDialog(Component c) {
        new RequestLogViewer(c).setVisible(true);
    }

    public static void showDialog(Component c, File file) {
        new RequestLogViewer(c, file).setVisible(true);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        table = new javax.swing.JTable(){

            @Override
            public Class getColumnClass(int c){
                if(c==3){
                    return Boolean.TRUE.getClass();
                }else{
                    return getModel().getColumnClass(convertColumnIndexToModel(c));
                }
            }
        };
        btnClose = new javax.swing.JButton();
        select = new javax.swing.JToggleButton();
        btnDelete = new javax.swing.JButton();
        btnInfo2 = new com.alee.laf.button.WebButton();
        btnSelectAll = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Data Requests History");

        table.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        table.setRowHeight(28);
        table.setSelectionMode(javax.swing.ListSelectionModel.SINGLE_SELECTION);
        table.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tableMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(table);

        btnClose.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnClose.setIcon(new javax.swing.ImageIcon(getClass().getResource("/artemis/img/return.png"))); // NOI18N
        btnClose.setText("Close");
        btnClose.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCloseActionPerformed(evt);
            }
        });

        select.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        select.setIcon(new javax.swing.ImageIcon(getClass().getResource("/artemis/img/check_list.png"))); // NOI18N
        select.setText("Make Selection");
        select.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                selectActionPerformed(evt);
            }
        });

        btnDelete.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnDelete.setIcon(new javax.swing.ImageIcon(getClass().getResource("/artemis/img/adding_cancel.png"))); // NOI18N
        btnDelete.setText("Delete");
        btnDelete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnDeleteActionPerformed(evt);
            }
        });

        btnInfo2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/artemis/img/Electric Bulb-wf.png"))); // NOI18N
        btnInfo2.setUndecorated(true);
        btnInfo2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnInfo2ActionPerformed(evt);
            }
        });

        btnSelectAll.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        btnSelectAll.setIcon(new javax.swing.ImageIcon(getClass().getResource("/artemis/img/select_all.png"))); // NOI18N
        btnSelectAll.setText("Select All");
        btnSelectAll.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSelectAllActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 695, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(btnInfo2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btnSelectAll)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnDelete)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(select)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnClose)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 366, Short.MAX_VALUE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(btnClose)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(select)
                            .addComponent(btnDelete)
                            .addComponent(btnSelectAll)))
                    .addComponent(btnInfo2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(5, 5, 5))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void selectActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_selectActionPerformed
        btnDelete.setVisible(select.isSelected());
        btnSelectAll.setVisible(select.isSelected());
        if (select.isSelected()) {
            makeSelection();
        } else {
            initTable();
        }
    }//GEN-LAST:event_selectActionPerformed

    private void btnCloseActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCloseActionPerformed
        dispose();
    }//GEN-LAST:event_btnCloseActionPerformed

    private void btnInfo2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnInfo2ActionPerformed
        Tip.showTip(this, evt, tip);
    }//GEN-LAST:event_btnInfo2ActionPerformed

    private void btnSelectAllActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSelectAllActionPerformed
        selectAll();
    }//GEN-LAST:event_btnSelectAllActionPerformed

    private void btnDeleteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnDeleteActionPerformed
        deleteSelected();
    }//GEN-LAST:event_btnDeleteActionPerformed

    private void tableMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tableMouseClicked
        if (evt.getClickCount() == 2) {
            if (table.getSelectedRow() != -1) {
                QueryResultViewer.showDialog(this, rld[table.getSelectedRow()].getQ());
            }
        }
    }//GEN-LAST:event_tableMouseClicked
    private final String tip = "<html><b>Double click</b> a row to view details.</html>";

    private void selectAll() {
        for (int i = 0; i < table.getRowCount(); i++) {
            table.setValueAt(true, i, table.getColumnCount() - 1);
        }
    }

    private void deleteSelected() {
        boolean d = false;
        for (int i = 0; i < table.getRowCount(); i++) {
            if ((boolean) table.getValueAt(i, table.getColumnCount() - 1)) {
                rld[i] = null;
                d = true;
            }
        }
        if (!d) {
            return;
        }
        if (ArtemisConfirm.showDialog(this, "Confirm Delete", "Are you sure you "
                + "want to delete selected log data?") == 0) {
            ArrayList<RequestLogData> li = new ArrayList<>();
            for (int r = rld.length - 1; r >= 0; r--) {
                if (rld[r] != null) {
                    li.add(rld[r]);
                }
            }
            ChromieDB.saveListData(file, li, LoggerFile.class);
            initTable();
            select.setSelected(false);
            btnDelete.setVisible(false);
            btnSelectAll.setVisible(false);
        }
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(RequestLogViewer.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(RequestLogViewer.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(RequestLogViewer.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(RequestLogViewer.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(() -> {
            showDialog(null);
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnClose;
    private javax.swing.JButton btnDelete;
    private com.alee.laf.button.WebButton btnInfo2;
    private javax.swing.JButton btnSelectAll;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JToggleButton select;
    private javax.swing.JTable table;
    // End of variables declaration//GEN-END:variables
}
