/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;
import java.sql.*;
import javax.servlet.ServletContext;

/**
 *
 * @author robot-boy
 */
public class DatabaseConnector {
    public static Connection getConnection(ServletContext contexto){
        Connection con = null;
        try {
            String mySQLHost = contexto.getInitParameter("mySQLHost");
            String dbName = contexto.getInitParameter("dbName");
            String user = contexto.getInitParameter("user");
            String password = contexto.getInitParameter("password");
            
            Class.forName("com.mysql.jdbc.Driver");
            
            String urlBD = mySQLHost + dbName+ "?user=" + user + "&password=" + password;
            con = DriverManager.getConnection(urlBD);
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        
        return con;
    }
}

