<%-- 
    Document   : dashboardPaciente
    Created on : Jun 10, 2017, 6:44:38 PM
    Author     : robot-boy
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bienvenido Paciente</title>
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans|Raleway|Candal">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-datetimepicker.min.css">
    </head>
    <%
        // Allow to enter if user is Paciente and logged in
        BeanUsuario user = null;
        BeanPaciente paciente = null;
        
        if(session.getAttribute("user") == null){
            response.sendRedirect("login.html");
        }            
        else{
            user = (BeanUsuario)session.getAttribute("user");
            paciente = user.getPaciente();
            if(paciente == null){
                response.sendRedirect("login.html");
            }
        }
    %>
    <body id="dashboardPaciente" data-spy="scroll" data-target=".navbar" data-offset="60">

        <section class="banner">
            <div class="nav-bg-color">
                <nav class="navbar-fixed-top">
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
                                <li class=""><a data-toggle="modal" data-target="#create-appointment-modal" href="#">Agendar Cita</a></li>
                                <li class=""><a href="#">Salir</a></li>
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
                        <h2 class="ser-title">Bienvenido Paciente <%= paciente.getName()%></h2>
                        <hr class="botm-line"/>
                    </div>
                    <div class="col-md-12">
                        <table class="table">
                            <thead>
                                <tr>
                                    <!-- Campos de la tabla consulta -->
                                    <th>Fecha</th>
                                    <th>Odontologo</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    ArrayList<BeanConsulta> consultas = paciente.getConsultas();
                                    for(BeanConsulta consulta: consultas){%>
                                        <tr>
                                            <td><%= consulta.getFecha() %></td>
                                            <td><%= consulta.getNombreOdontologo() %></td>
                                            <td><%= consulta.getEstado() %></td>
                                        </tr>
                                        <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>

        <div class="modal fade" id="create-appointment-modal" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelled-by="modal" aria-hidden="true">
           <div class="modal-dialog modal-md">
               <div class="modal-content">
                   <div class="modal-header">
                       <button data-dismiss="modal" class="close" type="button">
                           <span aria-hidden="true">&times;</span>
                       </button>
                       <h3 class="ser-title">Agendar nueva cita</h3>
                   </div>
                   <div class="modal-body">
                       <form action="" id="create-appointment">
                           <div class="form-group">
                                <label for="service">Servicio: </label>
                               <select placeholder="Servicio" name="service" id="" class="form-control">
                                   <option value=""></option>
                                   <%
                                       BeanServicio serv = new BeanServicio(getServletContext());
                                       ArrayList<BeanServicio> servicios = serv.getServicios();
                                       for(BeanServicio servicio: servicios){%>
                                            <option value=""><%= servicio.getNombre() %></option>
                                       <%}
                                   %>
                               </select>
                           </div>
                            <div class="form-group">
                                <div class="dtp-container">
                                    <label for="datetime">Selecciona la hora: </label>
                                    <input type="text" name="datetime" id="appointment-date" class="form-control date-picker information" placeholder="Selecciona una fecha" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="dtp-container">
                                    <label for="message">Mensaje: </label>
                                </div>
                                <textarea name="message" id="" cols="30" rows="10" placeholder="Escribe tu mensaje"></textarea>
                            </div>
                       </form>
                   </div>
                   <div class="modal-footer">
                       <button class="btn btn-primary" id="submit-create-appointment" data-loading-text="Enviando...">Agendar Consulta</button>
                   </div>
               </div>
           </div> 
        </div>
        
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.easing.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/moment.min.js"></script>  
        <script src="js/bootstrap-datetimepicker.min.js"></script>
        <script src="js/custom.js"></script>
        <script type="text/javascript">

            $(document).ready(function(){
                $(".date-picker").datetimepicker({
                    format: 'DD/MM/YYYY hh:mm A',
                    minDate: moment().subtract(1,'d')
                });
                
                $("#submit-create-appointment").on("click", function(event){
                        $.ajax({
                            url: "ConsultaController",
                            data: $("#create-appointment").serialize(),
                            method: "POST",
                            dataType: 'json',
                        })
                        .done(function(response){
                            console.log("done");
                            console.log(response);
                        })
                        .fail(function(response){
                            console.log("error");
                        })
                });

            });

                    
        </script>
    </body>
</html>
