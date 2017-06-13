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
public class BeanServicio {
    private Integer idServicio = null;
    private String nombre = new String();
    private String duracion = new String();
    private Double costo = null;
    
    private ServletContext context;
    
    public BeanServicio(int idServicio, String nombre, String duracion, double costo){
        this.idServicio = idServicio;
        this.nombre = nombre;
        this.duracion = duracion;
        this.costo = costo;
    }
    
    public BeanServicio(ServletContext context){
        this.context = context;
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public int getID(){
        return idServicio;
    }
    
    public ArrayList<BeanServicio> getServicios(){
        ArrayList<BeanServicio> servicios = new ArrayList<>();
        
        try{
            
            Connection con = DatabaseConnector.getConnection(context);
            
            if(con != null){
                
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Servicio");
                ps.executeQuery();
                ResultSet rs = ps.getResultSet();
                
                if(rs.next()){
                    BeanServicio servicio = new BeanServicio(rs.getInt("idServicio"), rs.getString("Nombre_Servicio"), rs.getString("Duracion"), rs.getDouble("Costo"));
                    servicios.add(servicio);
                }
                
                con.close();
            }
        }
        catch(SQLException ex){
            ex.printStackTrace();
        }
        return servicios;
    }
    
}

