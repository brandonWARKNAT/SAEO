
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.ejb.Stateless;
import javax.servlet.ServletContext;

@Stateless
public class BeanOdontologo {
    private Integer idOdontologo = null;
    private String nombre = new String();
    private String Cedula = new String();
    private ServletContext context;

    public BeanOdontologo(String nombre,String Cedula,Integer id) {
        this.Cedula=Cedula;
        this.idOdontologo=id;
        this.nombre=nombre;
    }

  
    public BeanOdontologo(){
        this.Cedula="";
        this.idOdontologo=0;
        this.nombre="";
        
    }
    
    public String getName(){
        return nombre;
    }
    
    public ServletContext getContext(){
        return context;
    }

    public ArrayList<BeanPaciente> getPacientes(){
        ArrayList<BeanPaciente> pacientes = new ArrayList<BeanPaciente>();
        
        try{
            Connection con = DatabaseConnector.getConnection(context);
            if(con != null){
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Paciente");
                ps.executeQuery();
                ResultSet rs = ps.getResultSet();
                
                if(rs.next()){
                    BeanPaciente paciente = new BeanPaciente(rs.getInt("idPaciente"), rs.getString("Nombre"), rs.getString("Descripcion"), rs.getString("Sexo"), rs.getString("Edad"));
                    pacientes.add(paciente);
                }
                
                con.close();
            }
        }
        catch(SQLException ex){
            ex.printStackTrace();
        }
        return pacientes;
    }
    
    public ArrayList<BeanResConsulta> consultasAgendadas(){
       
        ArrayList<BeanResConsulta> consultas=new ArrayList<BeanResConsulta>();
        
        try{
            Connection con = DatabaseConnector.getConnection(context);
            if(con != null){
                
                PreparedStatement ps = con.prepareStatement("select Paciente.Nombre, Consulta.Fecha , "
                                                            + "Consulta.Mensaje, Servicio.Nombre_Servicio, "
                                                            + "Consulta.Estado from Consulta inner join Paciente "
                                                            + "on Consulta.Paciente_idPaciente = Paciente.idPaciente "
                                                            + "inner join Servicio on Consulta.Servicio_idServicio = Servicio.idServicio;");
                ps.executeQuery();
                ResultSet rs = ps.getResultSet();
                
                while(rs.next()){
                    consultas.add(new BeanResConsulta(rs.getString("Nombre"),rs.getDate("Fecha"),rs.getString("Mensaje"),rs.getString("Nombre_Servicio"),rs.getString("Estado")));
                }
                con.close();
            }
        }
        catch(SQLException ex){
            System.out.println("Busca Consultas: Error al conectar con la base de datos");
        }
        
        return consultas;
    }
    
    
    public ArrayList<BeanConsulta> getConsultas(){
        ArrayList<BeanConsulta> consultas = new ArrayList<BeanConsulta>();
        
        try{
            Connection con = DatabaseConnector.getConnection(context);
            if(con != null){
                
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Consulta WHERE Odontologo_idOdontologo = ?");
                ps.setInt(1, this.idOdontologo);
                ps.executeQuery();
                ResultSet rs = ps.getResultSet();
                
                if(rs.next()){
                    BeanConsulta consulta = new BeanConsulta(rs.getInt("idConsulta"), rs.getInt("Paciente_idPaciente"), this.idOdontologo, rs.getString("Fecha"));
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
