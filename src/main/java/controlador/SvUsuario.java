
package controlador;

import dao.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jhonnydev.codesolve.modelo.Usuario;


public class SvUsuario extends HttpServlet {
   
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //  el usuario dio clic en Login o Registro?
        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "registrar":
                    procesarRegistro(request, response);
                    break;
                case "login":
                    procesarLogin(request, response);
                    break;
            }
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private void procesarRegistro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("txtNombre");
        String email = request.getParameter("txtEmail");
        String password = request.getParameter("txtPassword");

        Usuario nuevoUsuario = new Usuario(nombre, email, password);

        // Guardar en bd por el DAO
        boolean exito = usuarioDAO.registrarUsuario(nuevoUsuario);

        if (exito) {
            response.sendRedirect("login.jsp?msg=registrado");
        } else {
            response.sendRedirect("registro.jsp?error=error_registro");
        }
    }

    private void procesarLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("txtEmail");
        String password = request.getParameter("txtPassword");

        Usuario usuarioLogueado = usuarioDAO.validarLogin(email, password);

        if (usuarioLogueado != null) {

            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuarioLogueado);
            
            response.sendRedirect("index.jsp");
        } else {
            
            response.sendRedirect("login.jsp?error=datos_incorrectos");
        }
    }
}

