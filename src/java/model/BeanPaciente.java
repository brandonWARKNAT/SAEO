/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;
import java.beans.*;
import java.io.Serializable;

import java.sql.*;
import java.util.ArrayList;
import javax.servlet.ServletContext;

/**
 *
 * @author robot-boy
 */
public class BeanPaciente {
    private Integer idPaciente = null;
    private String nombre = new String();
    private String descripcion = new String();
    private String sexo = new String();
    private String edad = new String();
    private ServletContext context;
    
    
    public BeanPaciente(int idPaciente, String nombre, String descripcion, String sexo, String edad){
        this.idPaciente = idPaciente;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.sexo = sexo;
        this.edad = edad;
    }
    
    public String getName(){
        return nombre;
    }
    
    public ArrayList<BeanConsulta> getConsultas(){
        ArrayList<BeanConsulta> consultas = new ArrayList<BeanConsulta>();
        
        try{
            Connection con = DatabaseConnector.getConnection(context);
            if(con != null){
                
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Consulta WHERE Paciente_idPaciente = ?");
                ps.setInt(1, this.idPaciente);
                ps.executeQuery();
                ResultSet rs = ps.getResultSet();
                
                if(rs.next()){
                    BeanConsulta consulta = new BeanConsulta(rs.getInt("idConsulta"), this.idPaciente, rs.getInt("Odontologo_idOdontologo"), rs.getDate("Fecha"));
                    consultas.add(consulta);
                }
                
                con.close();
            }
        }
        catch(SQLException ex){
            ex.printStackTrace();
        }
        return consultas;
    }
    
}
