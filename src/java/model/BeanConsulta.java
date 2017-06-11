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
    private Integer idConsulta;
    private Date date = null;
    private Integer idPaciente = null;
    private Integer idOdontologo = null;
    private ServletContext context;
    
    public BeanConsulta(int idConsulta, int idPaciente, int idOdontologo, Date date){
        this.idConsulta = idConsulta;
        this.idPaciente = idPaciente;
        this.idOdontologo = idOdontologo;
        this.date = date;
    }
    
    public void setDate(Date date){
        this.date = date;
    }
    
    public void setPaciente(int idPaciente){
        this.idPaciente = idPaciente;
    }
    
    public void setContext(ServletContext context){
        this.context = context;
    }
    
    public int getID(){
        return idConsulta;
    }
    
    public Date getFecha(){
        return date;
    }
    
    public int getPaciente(){
        return idPaciente;
    }
    
    public int getIdOdontologo(){
        return idOdontologo;
    }
    
    public String getNombreOdontologo(){
        return "Doctor";
    }
    
    public String getEstado(){
        return "Lista";
    }
        
    public void reset(){
        this.idConsulta = null;
        this.idOdontologo = null;
        this.date = null;
        this.idPaciente = null;
        
    }
    
    public void read(int id)
    {
        this.reset();
        this.idConsulta = id;
        
        try {
            Connection con = DatabaseConnector.getConnection(context);
            if (con != null){
                PreparedStatement ps = con.prepareStatement("SELECT * FROM consulta where id_consulta = ?");
                ps.setInt(1, id);
                ps.executeQuery();
                ResultSet rs = ps.getResultSet();
                if (rs.next()){
                    this.idConsulta = id;
                    this.idPaciente = rs.getInt("Paciente_idPaciente");
                    this.date = rs.getDate("date");
                }
                con.close();
            }
        }
        catch (Exception ex){
            ex.printStackTrace();
        }

    }
    
    public void create(int id, Date date, int idPaciente){
        this.idConsulta = id;
        
        try{
            Connection con = DatabaseConnector.getConnection(context);

            if (con != null) {
                
                PreparedStatement ps = con.prepareStatement("INSERT INTO consulta values(?,?)");
                ps.setDate(1, java.sql.Date.valueOf(date.toString()));
                ps.setInt(2, idPaciente);
                
                ps.execute();
                
                this.date = date;
                this.idPaciente = idPaciente;
                con.close();
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        } 
    }
    
    public void update(int id, Date date, int idPaciente){
        try {
            Connection con = DatabaseConnector.getConnection(context);
            if (con != null) {
                PreparedStatement ps = con.prepareStatement("UPDATE consulta SET client_id = ?, date = ? where id_consulta = ?");
                ps.setInt(4, id);
                ps.setInt(1, idPaciente);
                ps.setDate(2, java.sql.Date.valueOf(date.toString()));
                
                ps.execute();
                this.idConsulta = id;
                this.idPaciente = idPaciente;
                this.date = date;
                
                con.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    
    
    
}
