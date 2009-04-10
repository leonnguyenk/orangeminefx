/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package orangefx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ramakant
 */
public class DerbyEntry {

    private static Connection uniqueConnection = null;
    private Statement stmt = null;
    private int numberOfEntries = 0;


    private static DerbyEntry getEntry(){
        uniqueConnection = getConnection();
        return new DerbyEntry();
    }
   
    private static Connection getConnection(){
        if (uniqueConnection  != null) {
            try {
                try {
                    Class.forName("org.apache.derby.jdbc.EmbeddedDriver").newInstance();
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(DerbyEntry.class.getName()).log(Level.SEVERE, null, ex);
                }

                try {
                    uniqueConnection = DriverManager.getConnection("jdbc:derby:derbyDB;create=true");
                } catch (SQLException ex) {
                    Logger.getLogger(DerbyEntry.class.getName()).log(Level.SEVERE, null, ex);
                }

            } catch (InstantiationException ex) {
                //Logger.getLogger(DBClient.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IllegalAccessException ex) {
                //Logger.getLogger(DBClient.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return uniqueConnection ;
    }

    public boolean insertScore(String name, String score) {
        try {
            stmt = uniqueConnection.createStatement();
            stmt.executeQuery("select COUNT from highscores");
            ResultSet rs = stmt.getResultSet();
            while (rs.next()) {
                numberOfEntries = rs.getInt(name);
            }
            if (numberOfEntries < 10) {
                System.out.println("ha! less then 10 entering straightforward");
                stmt.executeUpdate("update highscores set name=" + name + ", score = " + score);
            }else{
                stmt.executeUpdate("DELETE FROM highscores where score<"+score);
                rs = stmt.getResultSet();
                if(rs == null){
                    System.out.println("entry deleted new entry entered");
                     stmt.executeUpdate("update highscores set name=" + name + ", score = " + score);
                }
            }

        } catch (SQLException ex) {
            //Logger.getLogger(DerbyEntry.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) {
        DerbyEntry ent = DerbyEntry.getEntry();

        ent.insertScore("vaibhav","11");
    }
}
