/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author robot-boy
 */
import java.sql.*;
import java.util.Objects;
import javax.servlet.ServletContext;

public class BeanUsuario {
    // 2.6 - .5  ? Saber que tiene la varuiable
    Integer idUsuario = null;
    Integer idPaciente = null;
    Integer idOdontologo = null;
    private String correo = new String();
    private String password = new String();
    private ServletContext context;
    
    private BeanPaciente paciente = null;
    private BeanOdontologo odontologo = null;
    // private BeanOdontologo odontologo;
                    
    public void setPaciente(int idPaciente){
        try{
          Connection con = DatabaseConnector.getConnection(context);
          if (con != null){
              PreparedStatement ps = con.prepareStatement("SELECT * FROM Paciente WHERE idPaciente = ?");
              ps.setInt(1, idPaciente);
              
              ps.executeQuery();
              ResultSet rs = ps.getResultSet();

              if(rs.next()){
                   paciente = new BeanPaciente(idPaciente, rs.getString("nombre"), rs.getString("descripcion"), rs.getString("sexo"), rs.getString("edad"));
              }
              
              con.close();
          }
          
        }
        catch(Exception ex){
            ex.printStackTrace();
        } 
        
    }
    
    public void setEmail(String email){
        this.correo = email;
    }
   
    
    public void setOdontologo(int odontologo_id){
        try{
          Connection con = DatabaseConnector.getConnection(context);
          if (con != null){
              PreparedStatement ps = con.prepareStatement("SELECT * FROM odontologo WHERE idOdontologo = ?");
              ps.setInt(1, odontologo_id);
              ps.executeQuery();
              ResultSet rs = ps.getResultSet();

              if(rs.next()){
                   odontologo = new BeanOdontologo(rs.getString("Nombre"), rs.getString("Cedula"), 1);
              }
              
              con.close();
          }
          
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }
    
    public void setContext(ServletContext context){
        this.context = context;
    }
    
    public void setPassword(String password){
        this.password = password;
    }
    
    public boolean isPaciente(){
        return this.idPaciente != null && !Objects.equals(this.idPaciente, "") && this.idPaciente!=0;
    }

    public boolean isOdontologo(){
        return this.idOdontologo != null && !Objects.equals(this.idOdontologo, "") && this.idOdontologo!=0;
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
                
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Usuario WHERE correo = ? AND password = ?");
                ps.setString(1, email);
                ps.setString(2, password);
                
                ps.executeQuery();
                ResultSet rs = ps.getResultSet();
                
                if(rs.next()){
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
    
    public int getPacienteID(){
        return idPaciente;
    }

    public int getOdontologoID(){
        return idOdontologo;
    }
    
    public BeanPaciente getPaciente(){
        return paciente;
    }
    
    public BeanOdontologo getOdontologo(){
        return odontologo;
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
