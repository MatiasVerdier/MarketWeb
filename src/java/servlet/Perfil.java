package servlet;

import baseDatos.ManejadorBD;
import controladores.ControladorUsuarios;
import dominio.Usuario;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Perfil", urlPatterns = {"/Perfil"})
public class Perfil extends HttpServlet {
    ManejadorBD mbd = ManejadorBD.getInstancia();
    ControladorUsuarios cu = ControladorUsuarios.getInstancia();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        try {
            mbd.setHost("localhost");
            mbd.setPuerto("3306");
            mbd.setBd("market");
            mbd.setUsuario("root");
            mbd.setPassword("root");
            if (mbd.estaDesconectado()){
                mbd.conectar();
            }
        } catch (SQLException ex) {
            Logger.getLogger(Perfil.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        HttpSession sesion = request.getSession(true);
        
        
        if (sesion.getAttribute("usuario") != null){
            try {
                String usuarioLogueado = sesion.getAttribute("usuario").toString();
                Usuario u = cu.find(usuarioLogueado);
                System.out.println(u);

                request.setAttribute("perfil", u);
                request.getRequestDispatcher("verPerfil.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(Perfil.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else{
            String error = "Error, no ha iniciado sesion";
            request.setAttribute("error", error);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}