
package model;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.ejb.Stateless;
import java.util.Date;


@Stateless
public class BeanResConsulta {
    private String paciente;
    private Date fecha ;
    private String mensaje ; 
    private String servicio;
    private String estado;
    private ServletContext context;
    
    public BeanResConsulta(String paciente,Date fecha, String mensaje,String servicio,String estado){
        this.paciente=paciente;
        this.fecha =fecha;
        this.mensaje=mensaje ; 
        this.servicio=servicio;
        this.estado=estado;
    }
    
    public BeanResConsulta(){
        this.paciente="";
        this.fecha =null;
        this.mensaje=""; 
        this.servicio="";
        this.estado="";
    }
    
    public ServletContext getContext(){
        return this.context;
    }
    
    public String getPaciente(){
        return this.paciente;
    }
    
    public Date getFecha(){
        return this.fecha;
    }
    
    public String getMensaje(){
       return this.mensaje;
    }
    
    public String getServicio(){
       return this.servicio;
    }
    
    public String getEstado(){
        return this.estado;
    }
    
    public void setContext(ServletContext context){
        this.context=context;
    }
    
    public void setPaciente(String paciente){
        this.paciente=paciente;
    }
    
    public void setFecha(Date Fecha){
        this.fecha=Fecha;
    }
    
    public void setMensaje(String mensaje){
        this.mensaje=mensaje;
    }
    
    public void setServicio(String servicio){
        this.servicio=servicio;
    }
    
    public void setEstado(String estado){
        this.estado=estado;
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

}
