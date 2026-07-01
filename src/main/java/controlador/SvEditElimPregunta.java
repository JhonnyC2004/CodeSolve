
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


@WebServlet(name="SvEditElimPregunta", urlPatterns={"/SvEditElimPregunta"})
public class SvEditElimPregunta extends HttpServlet {
   
 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
        String idStr = request.getParameter("id");

        if (usuarioLogueado == null || idStr == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            int idPregunta = Integer.parseInt(idStr.trim());
            PreguntaDAO pDAO = new PreguntaDAO();
            Pregunta p = pDAO.buscarPreguntaPorId(idPregunta);

            // Verificación de seguridad: ¿El que borra es el dueño?
            if (p != null && p.getUsuario().getIdUsuario() == usuarioLogueado.getIdUsuario()) {
                pDAO.eliminarPregunta(idPregunta);
                response.sendRedirect("index.jsp?msg=pregunta_eliminada");
            } else {
                response.sendRedirect("index.jsp?error=no_autorizado");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
        
        String idStr = request.getParameter("idPregunta");
        String nuevoTitulo = request.getParameter("txtTitulo");
        String nuevaDesc = request.getParameter("txtDescripcion");
        String nuevasEtiquetas = request.getParameter("txtEtiquetas");

        if (usuarioLogueado == null || idStr == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            int idPregunta = Integer.parseInt(idStr.trim());
            PreguntaDAO pDAO = new PreguntaDAO();
            Pregunta p = pDAO.buscarPreguntaPorId(idPregunta);

            // Verificación de seguridad: ¿El que edita es el dueño?
            if (p != null && p.getUsuario().getIdUsuario() == usuarioLogueado.getIdUsuario()) {
                p.setTitulo(nuevoTitulo.trim());
                p.setDescripcion(nuevaDesc.trim());
                p.setEtiquetas(nuevasEtiquetas.trim());
                
                pDAO.editarPregunta(p);
                response.sendRedirect("DetallePregunta.jsp?id=" + idPregunta + "&msg=pregunta_actualizada");
            } else {
                response.sendRedirect("index.jsp?error=no_autorizado");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
