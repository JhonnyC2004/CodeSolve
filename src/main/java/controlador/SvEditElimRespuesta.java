
package controlador;

import dao.RespuestaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jhonnydev.codesolve.modelo.Respuesta;
import jhonnydev.codesolve.modelo.Usuario;


@WebServlet(name="SvEditElimRespuesta", urlPatterns={"/SvEditElimRespuesta"})
public class SvEditElimRespuesta extends HttpServlet {
   

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
        String idPreguntaStr = request.getParameter("idPregunta");

        if (usuarioLogueado == null || idStr == null || idPreguntaStr == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            int idRespuesta = Integer.parseInt(idStr.trim());
            RespuestaDAO rDAO = new RespuestaDAO();
            Respuesta r = rDAO.buscarRespuestaPorId(idRespuesta); 

            // Verificación: ¿Es el dueño de la respuesta?
            if (r != null && r.getUsuario().getIdUsuario() == usuarioLogueado.getIdUsuario()) {
                rDAO.eliminarRespuesta(idRespuesta);
                response.sendRedirect("DetallePregunta.jsp?id=" + idPreguntaStr + "&msg=respuesta_eliminada");
            } else {
                response.sendRedirect("DetallePregunta.jsp?id=" + idPreguntaStr + "&error=no_autorizado");
            }
        } catch (Exception e) {
            response.sendRedirect("index.jsp");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
        
        String idRespuestaStr = request.getParameter("idRespuesta");
        String idPreguntaStr = request.getParameter("idPregunta");
        String nuevoContenido = request.getParameter("txtContenido");

        if (usuarioLogueado == null || idRespuestaStr == null || idPreguntaStr == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            int idRespuesta = Integer.parseInt(idRespuestaStr.trim());
            RespuestaDAO rDAO = new RespuestaDAO();
            Respuesta r = rDAO.buscarRespuestaPorId(idRespuesta);

            if (r != null && r.getUsuario().getIdUsuario() == usuarioLogueado.getIdUsuario()) {
                r.setContenido(nuevoContenido.trim());
                rDAO.editarRespuesta(r);
                response.sendRedirect("DetallePregunta.jsp?id=" + idPreguntaStr + "&msg=respuesta_actualizada");
            } else {
                response.sendRedirect("DetallePregunta.jsp?id=" + idPreguntaStr + "&error=no_autorizado");
            }
        } catch (Exception e) {
            response.sendRedirect("index.jsp");
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
