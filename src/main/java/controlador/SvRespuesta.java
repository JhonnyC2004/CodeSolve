
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
import jhonnydev.codesolve.modelo.Pregunta;
import jhonnydev.codesolve.modelo.Respuesta;
import jhonnydev.codesolve.modelo.Usuario;


@WebServlet(name="SvRespuesta", urlPatterns={"/SvRespuesta"})
public class SvRespuesta extends HttpServlet {
   private RespuestaDAO respuestaDAO = new RespuestaDAO();
  

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        if (usuarioLogueado == null) {
            response.sendRedirect("login.jsp?error=sesion_expirada");
            return;
        }

        String contenido = request.getParameter("txtContenido");
        String idPreguntaStr = request.getParameter("txtIdPregunta");

        try {
            int idPregunta = Integer.parseInt(idPreguntaStr);
            
            Pregunta preguntaAsociada = new Pregunta();
            preguntaAsociada.setIdPregunta(idPregunta);

            Respuesta nuevaRespuesta = new Respuesta(contenido, preguntaAsociada, usuarioLogueado);

            boolean exito = respuestaDAO.registrarRespuesta(nuevaRespuesta);

            if (exito) {
                response.sendRedirect("verPregunta.jsp?id=" + idPregunta + "&msg=respuesta_enviada");
            } else {
                response.sendRedirect("verPregunta.jsp?id=" + idPregunta + "&error=fallo_respuesta");
            }
            
        } catch (NumberFormatException e) {
            System.out.println("Error al procesar el ID de la pregunta: " + e.getMessage());
            response.sendRedirect("index.jsp");
        }
    }

 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
