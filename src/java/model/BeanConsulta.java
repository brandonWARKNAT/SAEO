/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;
import java.sql.*;
import javax.servlet.ServletContext;
import java.util.Date;

/**
 *
 * @author robot-boy
 */
public class BeanConsulta {
    private int ID;
    private Date date = null;
    private String client_id = new String();
    private ServletContext context;
    
    public void setID(int id){
        this.ID = id;
    }
    
    public void setDate(Date date){
        this.date = date;
    }
    
    public void setClient(String client_id ){
        this.client_id = client_id;
    }
    
    public void setContext(ServletContext context){
        this.context = context;
    }
    
    public int getID(){
        return ID;
    }
    
    public Date getDate(){
        return date;
    }
    
    public String getClient(){
        return client_id;
    }
        
    public void reset(){
        this.ID = 0;
        this.date = null;
        this.client_id = new String();
        
    }
    
    public void read(int id)
    {
        this.reset();
        this.ID = id;
        
        try {
            Connection con = DatabaseConnector.getConnection(context);
            if (con != null){
                PreparedStatement ps = con.prepareStatement("SELECT * FROM consulta where id_consulta = ?");
                ps.setInt(1, id);
                ps.executeQuery();
                ResultSet rs = ps.getResultSet();
                if (rs.next()){
                    this.ID = id;
                    this.client_id = rs.getString("client_id");
                    this.date = rs.getDate("date");
                }
                con.close();
            }
        }
        catch (Exception ex){
            ex.printStackTrace();
        }

    }
    
    public void create(int id, Date date, String client_id){
        this.ID = id;
        
        try{
            Connection con = DatabaseConnector.getConnection(context);

            if (con != null) {
                
                PreparedStatement ps = con.prepareStatement("INSERT INTO consulta values(?,?)");
                ps.setDate(1, java.sql.Date.valueOf(date.toString()));
                ps.setString(2, client_id);
                
                ps.execute();
                
                this.date = date;
                this.client_id = client_id;
                con.close();
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        } 
    }
    
    public void update(int id, Date date, String client_id){
        try {
            Connection con = DatabaseConnector.getConnection(context);
            if (con != null) {
                PreparedStatement ps = con.prepareStatement("UPDATE consulta SET client_id = ?, date = ? where id_consulta = ?");
                ps.setInt(4, id);
                ps.setString(1, client_id);
                ps.setDate(2, java.sql.Date.valueOf(date.toString()));
                
                ps.execute();
                this.ID = id;
                this.client_id = client_id;
                this.date = date;
                
                con.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    
    
    
}
