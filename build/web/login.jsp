<%-- 
    Document   : login
    Created on : Jun 10, 2017, 8:16:00 PM
    Author     : robot-boy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>SAEO login</title>

        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans|Raleway|Candal">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <%
        // Redirect user to its respective dashboard if already logged in
        BeanUsuario user = null;
        BeanPaciente paciente = null;
        BeanOdontologo odontologo = null;
        if(session.getAttribute("user") != null){
            user = (BeanUsuario)session.getAttribute("user");
            paciente = user.getPaciente();
            odontologo = user.getOdontologo();
            if(paciente != null){
                response.sendRedirect("dashboardPaciente.jsp");
            }
            else if(odontologo != null){
                response.sendRedirect("dashboardOdontologo.jsp");
            }
        }
    %>
    <body data-spy="scroll" data-target=".navbar" data-offset="60">
        <section class="banner">
            <div class="nav-bg-color">
                    <nav class="navbar navbar-default navbar-fixed-top">
                      <div class="container">
                            <div class="col-md-12">
                                <div class="navbar-header">
                                  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                  </button>
                                  <a class="navbar-brand" href="#"><img src="img/logo.png" class="img-responsive" style="width: 140px; margin-top: -16px;"></a>
                                </div>
                                <div class="collapse navbar-collapse navbar-right" id="myNavbar">
                                  <ul class="nav navbar-nav">
                                    <li class="active"><a href="index.html">Inicio</a></li>
                                    <li class=""><a href="#agendarConsulta">Registrarse</a></li>
                                    <li class=""><a href="#registrarPaciente">Iniciar Sesión</a></li>
                                  </ul>
                                </div>
                            </div>
                      </div>
                    </nav>
            </div>
	</section>
        
        <section class="section-padding">
		<div class="container">
			<div class="row">
                            <div class="col-md-12">
                                    <h2 class="ser-title">Iniciar Sesión</h2>
                                    <hr class="botm-line">
                            </div>
                            <div class="col-md-8 col-sm-8 marb20">
                                <div class="contact-info">
                                    <div id="sendmessage">Informaci&oacuten registrada correctamente</div>
                                    <%
                                        if(request.getParameter("error") != null){%>
                                        <div id="errormessage"><%= request.getParameter("error") %></div>                                    
                                        <%}
                                    %>
                                   <form action="loginServlet" method="post" role="form" class="contactForm">
                                        <div class="form-group">
                                            <label for="email">Correo electronico: </label>
                                            <input type="email" name="email" class="form-control br-radius-zero" id="email" placeholder="Correo electrónico" data-rule="minlen:10" data-msg="Inserte solo caracteres alfabeticos" />
                                            <div class="validation"></div>
                                        </div>
                                        <div class="form-group">
                                            <label for="hora">Password: </label>
                                            <input type="password" class="form-control br-radius-zero" name="password" id="subject" placeholder="Contraseña" />
                                            <div class="validation"></div>
                                        </div>                                
                                	<div class="form-action">
                                            <button type="submit" class="btn btn-form">Iniciar</button>
                                            <button type="reset" class="btn btn-form">Borrar</button>
					</div>
                                    </form>
				</div>
                            </div>
			</div>
		</div>
	</section>
    </body>
</html>
