/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import com.mysql.jdbc.Statement;
import java.io.IOException;
import model.*;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.*;

/**
 *
 * @author robot-boy
 */
public class ConsultaController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ConsultaController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConsultaController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        JSONObject respuesta = new JSONObject();
        
        try{
            String accion = request.getParameter("accion");
            int paciente = Integer.valueOf(request.getParameter("paciente"));
            int servicio = Integer.valueOf(request.getParameter("service"));
            
            switch(accion){
                case "create":
                {
                    
                    try {
                        Connection con = DatabaseConnector.getConnection(getServletContext());

                        if (con != null) {
                            // fecha, Paciente_idPaciente, estado, mensaje
                            PreparedStatement ps = con.prepareStatement("INSERT INTO Consulta (Fecha, Paciente_idPaciente, Servicio_idServicio, Estado, Mensaje) VALUES(?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
                            
                            ps.setString(1, request.getParameter("datetime"));
                            ps.setInt(2, paciente);
                            ps.setInt(3, servicio);
                            ps.setString(4, "SIN CONFIRMAR");
                            ps.setString(5, request.getParameter("message"));
                            
                            ps.executeUpdate();
                            
                            ResultSet rs = ps.getGeneratedKeys();
                            
                            rs.next();
                            int auto_id = rs.getInt(1);
                            
                            BeanConsulta consulta = new BeanConsulta(auto_id, paciente, 1, request.getParameter("datetime"));
                            
                            respuesta.put("servicio", servicio);
                            respuesta.put("fecha", consulta.getFecha());
                            respuesta.put("odontologo", consulta.getNombreOdontologo());
                            con.close();
                        }
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                    
                    respuesta.put("success", "true");
                    out.print(respuesta);
                    break;
                }
                default:{
                    break;
                }
                    
            }
            
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
