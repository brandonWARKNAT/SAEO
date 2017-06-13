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
    
    public BeanPaciente(){
        this.idPaciente = 0;
        this.nombre = "";
        this.descripcion = "";
        this.sexo = "";
        this.edad = "";
    }

    public int getID(){
        return idPaciente;
    }
    
    public String getDesc(){
        return descripcion;
    }
    
    public String getSex(){
        return sexo;
    }
    
    public String getAge(){
        return edad;
    }

    public String getName(){
        return nombre;
    }

    public ArrayList<BeanPaciente> buscaPacientes(){
        ArrayList<BeanPaciente> pacientes = new ArrayList<BeanPaciente>();

        try{
            Connection con = DatabaseConnector.getConnection(context);
            if(con != null){
                
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Paciente");
                ps.executeQuery();
                ResultSet rs = ps.getResultSet();
                
                while(rs.next()){
                    pacientes.add(new BeanPaciente(rs.getInt("idPaciente"),rs.getString("Nombre"), rs.getString("Descripcion"), rs.getString("Sexo"), rs.getString("Edad")));
                }
                con.close();
            }
        }
        catch(SQLException ex){
            System.out.println("Busca Paciente: Error al conectar con la base de datos");
        }

        return pacientes;
    }

    public boolean registraPaciente(){
        boolean res=true;
        try{
            Connection con = DatabaseConnector.getConnection(context);
            if(con != null){
                
                PreparedStatement ps = con.prepareStatement("INSERT INTO Paciente VALUES (?,?,?,?,?)");
                ps.setInt(1, this.idPaciente);
                ps.setString(2, this.nombre);
                ps.setString(3, this.descripcion);
                ps.setString(4, this.sexo);
                ps.setString(5, this.edad);
                ps.executeQuery();

                con.close();

            }
        }
        catch(SQLException ex){
             res=false;
             System.out.println("Registra Paciente: Error al registrar paciente");
        }
        
        return res;
    
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
                    BeanConsulta consulta = new BeanConsulta(rs.getInt("idConsulta"), this.idPaciente, rs.getInt("Odontologo_idOdontologo"), rs.getString("Fecha"));
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

    public void setContext(ServletContext context) {
        this.context = context;
    }
    
}
