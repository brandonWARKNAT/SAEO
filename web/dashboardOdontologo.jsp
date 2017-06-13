<%-- 
    Document   : dashboardOdontologo
    Created on : 11/06/2017, 07:40:30 PM
    Author     : Esteban
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>SAEO</title>
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans|Raleway|Candal">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-datetimepicker.min.css">
    </head>
    <%

        BeanUsuario user = null;
        BeanOdontologo odontologo = null;

        
        
        if(session.getAttribute("user") == null){
            response.sendRedirect("login.jsp");
        }            
        else{
            user = (BeanUsuario)session.getAttribute("user");
            System.out.println("About to take the odontologo");
            odontologo = user.getOdontologo();
            if(odontologo == null){
                System.out.println("Odontologo is null");
                response.sendRedirect("login.jsp");
            }
        }
    %>
    <body id="dashboardOdontologo" data-spy="scroll" data-target=".navbar" data-offset="60">

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
                                    <li class="active"><a href="#listaPacientes">Lista de pacientes</a></li>
                                    <li class=""><a data-toggle="modal" data-target="#create-appointment-modal" href="#">Registrar Paciente</a></li>
                                    <li class="active"><a href="#listaConsultas">Consultas Agendadas</a></li>
                                    <li class=""><a href="#">Cerrar Sesi&oacuten</a></li>
                                  </ul>
                                </div>
                            </div>
                      </div>
                    </nav>
            </div>
	</section>
    
        <div class="col-md-12">
            <h1 class="ser-title">Dr <%= odontologo.getName()%></h1>
            <hr class="botm-line"/>
        </div>
        
        <section id="listaPacientes" class="section-padding">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <h2 class="ser-title">Lista de pacientes</h2>
                            <hr class="botm-line"/>
                        </div>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>id</th>
                                    <th>Nombre</th>
                                    <th>Descripcion</th>
                                    <th>Sexo</th>
                                    <th>Edad</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    System.out.println("Showing pacientes");
                                    ArrayList<BeanPaciente> pacientes = odontologo.getPacientes();
                                    for(BeanPaciente paciente: pacientes)
                                    {
                                    %>
                                        <tr>
                                            <td><%= paciente.getID() %></td>
                                            <td><%= paciente.getName() %></td>
                                            <td><%= paciente.getDesc() %></td>
                                            <td><%= paciente.getSex() %></td>
                                            <td><%= paciente.getAge() %></td>
                                            
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
                            
        <section id="listaConsultas" class="section-padding">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <h2 class="ser-title">Consultas Agendadas</h2>
                            <hr class="botm-line"/>
                        </div>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Paciente</th>
                                    <th>Fecha</th>
                                    <th>Mensaje</th>
                                    <th>Servicio</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    ArrayList<BeanResConsulta> consultas = odontologo.consultasAgendadas();
                                    for(BeanResConsulta consulta: consultas){
                                    %>
                                        <tr>
                                            <td><%= consulta.getPaciente() %></td>
                                            <td><%= consulta.getFecha() %></td>
                                            <td><%= consulta.getMensaje() %></td>
                                            <td><%= consulta.getServicio() %></td>
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
                       <h3 class="ser-title">Registrar paciente</h3>
                   </div>
                   <div class="modal-body">
                           <form action="registrarPacienteServlet" id="create-appointment" method="post">
                           <div class="form-group">
                                <label for="idPaciente">id Paciente: </label><br/>
                                <input type="number" name="idPaciente" id="idPaciente"/>
                           </div>
                            <div class="form-group">
                                <div class="dtp-container">
                                    <label for="nombrePaciente">Nombre: </label><br/>
                                    <input type="text" name="nombrePaciente" id="nombrePaciente"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="dtp-container">
                                    <label for="descripcion">Descripcion: </label><br/>
                                    <input type="text" name="descripcion" id="descripcion"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="dtp-container">
                                    <label for="sexo">Sexo: </label><br/>
                                    <input type="text" name="sexo" id="sexo"/>
                                </div>
                            </div>
                           <div class="form-group">
                                <div class="dtp-container">
                                    <label for="edad">Edad: </label><br/>
                                    <input type="number" name="edad" id="edad"/>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-form">Registrar paciente</button>
                                <button type="reset" class="btn btn-form">Borrar</button>
                            </div>
                       </form>
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
