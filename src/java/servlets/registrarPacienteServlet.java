
package servlets;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.BeanPaciente;

@WebServlet(name = "registrarPacienteServlet", urlPatterns = {"/registrarPacienteServlet"})
public class registrarPacienteServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServletContext context = getServletContext();
        BeanPaciente paciente=new BeanPaciente();
        paciente.setContext(context);
        ArrayList<BeanPaciente> pacientes =paciente.buscaPacientes();
        request.getSession().setAttribute("pacientes",pacientes); 
        response.sendRedirect("dashboardOdontologo.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");        
        String id = request.getParameter("idPaciente");
        String nombre = request.getParameter("nombrePaciente");
        String descripcion = request.getParameter("descripcion");
        String sexo = request.getParameter("sexo");
        String edad = request.getParameter("edad");
        ServletContext context = getServletContext();
        
        BeanPaciente user = new BeanPaciente(Integer.parseInt(id),nombre, descripcion, sexo, edad); 
        user.setContext(context);
        
        user.registraPaciente();
        
        doGet(request,response);

        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
