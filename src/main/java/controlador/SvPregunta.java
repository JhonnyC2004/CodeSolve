
package controlador;

import dao.PreguntaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jhonnydev.codesolve.modelo.Pregunta;
import jhonnydev.codesolve.modelo.Usuario;


@WebServlet(name="SvPregunta", urlPatterns={"/SvPregunta"})
public class SvPregunta extends HttpServlet {
   private PreguntaDAO preguntaDAO = new PreguntaDAO();
   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        // obtener sesion actual para saber quien esta publicando
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        if (usuarioLogueado == null) {
            response.sendRedirect("login.jsp?error=sesion_expirada");
            return;
        }

        String titulo = request.getParameter("txtTitulo");
        String descripcion = request.getParameter("txtDescripcion");

        Pregunta nuevaPregunta = new Pregunta(titulo, descripcion, usuarioLogueado);

        boolean exito = preguntaDAO.registrarPregunta(nuevaPregunta);

        if (exito) {
            response.sendRedirect("index.jsp?msg=pregunta_publicada");
        } else {
            response.sendRedirect("publicar.jsp?error=fallo_publicacion");
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
