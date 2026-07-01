<%-- 
    Document   : DetallePregunta
    Created on : 28 jun. 2026, 14:06:34
    Author     : Jhonny Dev
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="jhonnydev.codesolve.modelo.Usuario"%>
<%@page import="jhonnydev.codesolve.modelo.Pregunta"%>
<%@page import="dao.PreguntaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession checkSession = request.getSession(false);
    if (checkSession == null || checkSession.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("Login.jsp?msg=inicia_sesion");
        return;
    }

    String idParam = request.getParameter("id");
    Pregunta pregunta = null;

    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            int idPregunta = Integer.parseInt(idParam.trim()); 
            PreguntaDAO pDAO = new PreguntaDAO();
            
            pregunta = pDAO.buscarPreguntaPorId(idPregunta); 
        } catch (NumberFormatException e) {
        }
    }

    if (pregunta == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Usuario autorPregunta = pregunta.getUsuario();
    String nombreAutorP = (autorPregunta != null) ? autorPregunta.getNombre() : "Anónimo";
    SimpleDateFormat sdfEspanol = new SimpleDateFormat("dd 'de' MMM. 'de' yyyy", new Locale("es", "EC"));
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CodeSolve - <%= pregunta.getTitulo() %></title>
        <style>
            * { 
                box-sizing: border-box; 
                margin: 0; 
                padding: 0; 
                font-family: 'Segoe UI', sans-serif; 
            }
            body { 
                background-color: #0f172a; 
                color: #f8fafc; 
                min-height: 100vh; 
            }

            .navbar {
                background: #1e293b; 
                padding: 15px 30px; 
                border-bottom: 1px solid #334155; 
                display: flex; 
                justify-content: space-between; 
                align-items: center; 
            }
            .navbar h1 a { 
                font-size: 1.5rem; 
                color: #38bdf8; 
                font-weight: 700; 
                text-decoration: none; 
            }
            .user-menu { 
                color: #cbd5e1; 
                font-size: 0.95rem; 
            }

            .main-container { 
                max-width: 900px; 
                margin: 40px auto; 
                padding: 0 20px; 
            }
            
            .main-question-card {
                background: #1e293b; 
                border: 1px solid #334155; 
                padding: 24px; 
                border-radius: 12px; 
                margin-bottom: 25px; 
                position: relative;
            }
            .main-question-card h2 {
                font-size: 1.6rem; 
                font-weight: 700; 
                color: #38bdf8; 
                margin: 0 0 12px 0; 
                line-height: 1.3;
            }
            .main-question-card .desc {
                font-size: 1.05rem; 
                color: #cbd5e1; 
                line-height: 1.6; 
                white-space: pre-wrap; 
                margin-bottom: 20px;
            }
            .main-question-card .meta {
                display: flex; 
                justify-content: space-between; 
                align-items: center; 
                color: #94a3b8; 
                font-size: 0.85rem; 
                border-top: 1px solid #334155; 
                padding-top: 15px;
            }
            .action-buttons-container {
                margin-top: 15px; 
                display: flex; 
                gap: 20px; 
                border-top: 1px dashed #475569; 
                padding-top: 15px;
            }
            .btn-action-edit {
                color: #38bdf8; 
                text-decoration: none; 
                font-size: 0.9rem; 
                font-weight: 600; 
                display: flex; 
                align-items: center; 
                gap: 5px;
                transition: color 0.2s;
            }
            .btn-action-edit:hover {
                color: #7dd3fc; 
            }
            .btn-action-delete {
                color: #ef4444; 
                text-decoration: none; 
                font-size: 0.9rem; 
                font-weight: 600; 
                display: flex; 
                align-items: center; 
                gap: 5px;
                transition: color 0.2s;
            }
            .btn-action-delete:hover {
                color: #f87171; 
            }
            .edit-form-group {
                margin-bottom: 18px;
            }
            .edit-form-group label {
                color: #94a3b8; 
                font-size: 0.85rem; 
                display: block; 
                margin-bottom: 6px; 
                font-weight: 500;
            }
            .edit-form-group input, .edit-form-group textarea {
                width: 100%; 
                background: #0f172a; 
                border: 1px solid #475569; 
                border-radius: 8px; 
                padding: 12px; 
                color: #f8fafc; 
                font-size: 0.95rem; 
                outline: none; 
                box-sizing: border-box;
            }
            .edit-form-group textarea {
                min-height: 160px; 
                resize: vertical; 
                font-family: inherit;
            }
            .question-title { 
                font-size: 1.8rem; 
                color: #f1f5f9; 
                margin-bottom: 15px; 
                font-weight: 600; 
                line-height: 1.3; 
            }
            .question-desc { 
                color: #cbd5e1; 
                font-size: 1.05rem; 
                line-height: 1.6; 
                margin-bottom: 20px; 
                white-space: pre-line; 
            }
            .community-tip-box {
                background: rgba(56, 189, 248, 0.05);
                border: 1px dashed rgba(56, 189, 248, 0.3);
                padding: 14px 18px;
                border-radius: 8px;
                margin-bottom: 20px;
                display: flex;
                align-items: flex-start;
                gap: 12px;
            }
            .community-tip-box p {
                margin: 0;
                font-size: 0.9rem;
                color: #94a3b8;
                line-height: 1.5;
            }
            .community-tip-box strong {
                color: #38bdf8; 
            }

            .answers-section { 
                margin-top: 40px; 
            }
            .answers-section h3 { 
                font-size: 1.3rem; 
                margin-bottom: 20px; 
                color: #f1f5f9; 
                border-bottom: 1px solid #334155; 
                padding-bottom: 10px; 
            }
            .answer-card { 
                background: #111827; 
                border-left: 4px solid #38bdf8; 
                padding: 20px; 
                border-radius: 4px 8px 8px 4px; 
                margin-bottom: 15px; 
            }
            .answer-content { 
                color: #cbd5e1; 
                font-size: 1rem; 
                line-height: 1.5; 
                margin-bottom: 12px; 
                white-space: pre-line; 
            }
            .answer-meta { 
                color: #94a3b8; 
                font-size: 0.85rem; 
                text-align: right; 
            }

            .reply-form-container { 
                margin-top: 40px; 
                background: #1e293b; 
                border: 1px solid #334155; 
                padding: 25px; 
                border-radius: 12px; 
            }
            .reply-form-container h4 { 
                margin-bottom: 15px; 
                color: #f1f5f9; 
            }
            .reply-form textarea { 
                width: 100%; 
                background: #0f172a; 
                border: 1px solid #475569; 
                border-radius: 8px; 
                padding: 15px; 
                color: #f8fafc; 
                font-size: 0.95rem; 
                outline: none; 
                min-height: 120px; 
                resize: vertical; 
                margin-bottom: 15px; 
            }
            .reply-form textarea:focus { 
                border-color: #38bdf8; 
            }
            .btn-reply { 
                background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%); 
                color: black; 
                border: none; 
                padding: 12px 24px; 
                border-radius: 8px; 
                font-weight: 600; 
                cursor: pointer; 
                transition: all 0.2s; 
            }
            .btn-reply:hover { 
                box-shadow: 0 4px 12px rgba(56, 189, 248, 0.3); 
            }
            .btn-back { 
                display: inline-block; 
                color: #94a3b8; 
                text-decoration: none; 
                margin-bottom: 20px; 
                font-size: 0.95rem; 
            }
            .btn-back:hover { 
                color: #f1f5f9; 
            }
        </style>
    </head>
    <body>

        <nav class="navbar">
            <h1><a href="index.jsp">CodeSolve</a></h1>
            <div class="user-menu">
                <span>Conectado como: <strong style="color: #38bdf8;"><%= ((Usuario)session.getAttribute
                        ("usuarioLogueado")).getNombre() %></strong></span>
            </div>
        </nav>

        <div class="main-container">
            <a href="index.jsp" class="btn-back">← Volver al Feed</a>

            <div class="main-question-card" id="vistaPregunta">
                <h2><%= pregunta.getTitulo() %></h2>
                <div class="desc"><%= pregunta.getDescripcion() %></div>
                
                <div class="meta">
                    <div>Por <strong style="color: #f1f5f9;"><%= nombreAutorP %></strong></div>
                    <div>Publicado el: <%= pregunta.getFechaCreacion() != null ? sdfEspanol.format(pregunta.getFechaCreacion()) : "Reciente" %></div>
                </div>

                <%
                    Usuario userLog = (Usuario) session.getAttribute("usuarioLogueado");
                    if (userLog != null && autorPregunta != null && userLog.getIdUsuario() == autorPregunta.getIdUsuario()) {
                %>
                    <div class="action-buttons-container">
                        <a href="javascript:void(0);" onclick="activarEdicion();" class="btn-action-edit">Editar Pregunta
                        </a>
                        <a href="SvEditElimPregunta?id=<%= pregunta.getIdPregunta() %>" 
                           onclick="return confirm('¿Seguro que deseas eliminar esta pregunta de forma permanente? Esto borrará también sus respuestas.');"
                           class="btn-action-delete">Eliminar Pregunta
                        </a>
                    </div>
                <%
                    }
                %>
            </div>

            <% if (userLog != null && autorPregunta != null && userLog.getIdUsuario() == autorPregunta.getIdUsuario()) { %>
                <div id="formEdicionPregunta" class="main-question-card" style="display: none;">
                    <h3 style="color: #f1f5f9; margin-top: 0; margin-bottom: 20px; font-size: 1.3rem;">Editar Pregunta</h3>
                    
                    <form action="SvEditElimPregunta" method="POST">
                        <input type="hidden" name="idPregunta" value="<%= pregunta.getIdPregunta() %>">
                        
                        <div class="edit-form-group">
                            <label>Título de la duda</label>
                            <input type="text" name="txtTitulo" value="<%= pregunta.getTitulo() %>" required>
                        </div>
                        
                        <div class="edit-form-group">
                            <label>Descripción del problema</label>
                            <textarea name="txtDescripcion" required><%= pregunta.getDescripcion() %></textarea>
                        </div>
                        
                        <div class="edit-form-group">
                            <label>Etiquetas (separadas por comas)</label>
                            <input type="text" name="txtEtiquetas" value="<%= pregunta.getEtiquetas() != null ? pregunta.getEtiquetas() : "" %>" placeholder="ej: java, jpa, mysql">
                        </div>
                        
                        <div style="display: flex; gap: 12px;">
                            <button type="submit" class="btn-reply" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">Guardar Cambios</button>
                            <button type="button" class="btn-search" onclick="cancelarEdicion();" style="background: #334155; border-color: #475569;">Cancelar</button>
                        </div>
                    </form>
                </div>
            <% } %>
                <div class="community-tip-box">
        <span style="font-size: 1.2rem;">💡</span>
        <p>
            <strong>¿Vas a responder?</strong> Explica el <em>porqué</em> de tu solución. 
            La paciencia con los nuevos desarrolladores hace fuerte a nuestra comunidad.
        </p>
    </div>

            <div class="answers-section">
                <%
                    java.util.List<jhonnydev.codesolve.modelo.Respuesta> respuestas = pregunta.getListaRespuestas();
                    int numRespuestas = (respuestas != null) ? respuestas.size() : 0;
                %>
                
                <h3>Respuestas (<%= numRespuestas %>)</h3>
                
                <%
                    if (respuestas != null && !respuestas.isEmpty()) {
                        for (jhonnydev.codesolve.modelo.Respuesta r : respuestas) {
                            Usuario autorRespuesta = r.getUsuario();
                            String nombreAutorR = (autorRespuesta != null) ? autorRespuesta.getNombre() : "Anónimo";
                %>
                            <div class="answer-card">
                                <div class="answer-content"><%= r.getContenido() %></div>
                                <div class="answer-meta">Respondido por <strong><%= nombreAutorR %>
                                    </strong> • <%= r.getFechaCreacion() != null ? sdfEspanol.format
                                            (r.getFechaCreacion()) : "Reciente" %></div>
                            </div>
                <%
                        }
                    }else {
                %>
                        <div class="answer-card" style="border-left-color: #64748b; background: #0f172a;">
                            <div class="answer-content" style="color: #94a3b8; text-align: center;">Aún no hay respuestas 
                                para esta duda. ¡Comparte tu conocimiento abajo!</div>
                        </div>
                <%
                    }
                %>

                <div class="reply-form-container">
                    <h4>Tu Respuesta</h4>
                    <form action="SvRespuesta" method="POST" class="reply-form">
                        <input type="hidden" name="idPregunta" value="<%= pregunta.getIdPregunta() %>">
                        
                        <textarea name="txtContenido" placeholder="Escribe tu solución detallada o comparte un fragmento de código..." required></textarea>
                        <button type="submit" class="btn-reply">Publicar Respuesta</button>
                    </form>
                </div>
            </div>
        </div>

    </body>
</html>
