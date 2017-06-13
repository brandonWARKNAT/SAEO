/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.*;
import javax.servlet.http.*;
import model.BeanPaciente;
import model.BeanResConsulta;


import model.BeanUsuario;

/**
 *
 * @author robot-boy
 */
@WebServlet("/LoginServlet")
public class loginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final long serialVersionUID = 1L;
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet loginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginServlet at " + request.getContextPath() + "</h1>");
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
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        ServletContext context = getServletContext();
        
        BeanUsuario user = new BeanUsuario(); 
        user.setContext(context);
        user.readUser(email, password);
        
        if (password.equals(user.getPassword()) && email.equals(user.getEmail())) {
            
            HttpSession session = request.getSession();
            // Agregamos el usuario a la sesion pero hay que saber si es usuario o paciente
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(60 * 60);
            
            Cookie userName = new Cookie("user", user.getEmail());
            //setting cookie to expiry in 30 mins
            userName.setMaxAge(60 * 60);
            response.addCookie(userName);

            if(user.isPaciente()){
                user.setPaciente(user.getPacienteID());
                response.sendRedirect("dashboardPaciente.jsp");
            }
            else if(user.isOdontologo()){
                user.setOdontologo(user.getOdontologoID());
                context = getServletContext();
                
                BeanPaciente paciente = new BeanPaciente();
                BeanResConsulta cons = new BeanResConsulta();
                
                paciente.setContext(context);
                cons.setContext(context);

                System.out.println("2.0");
                
                response.sendRedirect("dashboardOdontologo.jsp"); 
            }
            else{
                response.sendRedirect("dashboardOdontologo.jsp");
            }
            
        } else {
            request.setAttribute("error", "Usuario no encontrado. Verifica correo y contraseña.");
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
            rd.forward(request, response);
//            PrintWriter out = response.getWriter();
//            out.println("<div class='alert alert-warning'>Usuario no encontrado. Verificar correo y contraseña.</div>");
//            rd.include(request, response);
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
