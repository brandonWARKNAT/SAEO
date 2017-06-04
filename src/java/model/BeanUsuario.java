/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.beans.*;
import java.io.Serializable;

/**
 *
 * @author robot-boy
 */
import java.sql.*;
import javax.servlet.ServletContext;

public class BeanUsuario {
    // 2.6 - .5  ? Saber que tiene la varuiable
    Integer idUsuario = null;
    Integer idPaciente = null;
    Integer idOdontologo = null;
    private String correo = new String();
    private String password = new String();
    
    private ServletContext context;
                    
                

    
    public void setEmail(String email){
        this.correo = email;
    }
    
    public void setPaciente(int paciente_id){
        this.idPaciente = paciente_id;
    }
    
    public void setOdontologo(int odontologo_id){
        this.idOdontologo = odontologo_id;
    }
    
    public void setContext(ServletContext context){
        this.context = context;
    }
    
    public void setPassword(String password){
        this.password = password;
    }
    
    public String getEmail(){
        return correo;
    }
    
    public String getPassword(){
        return password;
    }
    
    public void readUser(String email, String password){
        try{
            Connection con = DatabaseConnector.getConnection(context);
            if(con != null){
                System.out.println("Información read User");
                
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Usuario WHERE correo = ? AND password = ?");
                ps.setString(1, email);
                ps.setString(2, password);
                
                ps.executeQuery();
                ResultSet rs = ps.getResultSet();
                
                if(rs.next()){
                    System.out.println("Entre alguna vez aquí");
                    this.correo = email;
                    this.password = password;
                    this.idOdontologo = rs.getInt("idOdontologo");
                    this.idPaciente = rs.getInt("idPaciente");
                    this.idUsuario = rs.getInt("idUsuario");
                }
                
                con.close();
            }
        }
        catch(SQLException ex){
            ex.printStackTrace();
        }
        
    }
    
    public int getPaciente(){
        return idPaciente;
    }
    
    public int getOdontologo(){
        return idOdontologo;
    }
    
    public void reset()
    {
        this.idUsuario = null;
        this.idPaciente = null;
        this.idOdontologo = null;
        this.correo = "";
        this.password = "";
    }
    
}
