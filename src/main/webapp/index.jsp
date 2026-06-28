<%-- 
    Document   : index.jsp
    Created on : 27 jun. 2026, 12:32:35
    Author     : Jhonny Dev
--%>

<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="jhonnydev.codesolve.modelo.Usuario"%>
<%@page import="jhonnydev.codesolve.modelo.Pregunta"%>
<%@page import="dao.PreguntaDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    HttpSession checkSession = request.getSession(false);
    if (checkSession == null || checkSession.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("Login.jsp?msg=inicia_sesion");
        return; 
    }
    SimpleDateFormat sdfEspanol = new SimpleDateFormat("dd 'de' MMM. 'de' yyyy", new Locale("es", "EC"));
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CodeSolve - Comunidad de Desarrolladores</title>
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
                background-image: linear-gradient(rgba(248, 250, 252, 0.02) 1px, transparent 1px), linear-gradient(90deg, rgba                     (248, 250, 252, 0.02) 1px, transparent 1px);
                background-size: 30px 30px;
            }

            .navbar {
                background: #1e293b;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #334155;
                position: sticky;
                top: 0;
                z-index: 100;
            }
            .navbar h1 { 
                font-size: 1.5rem; 
                color: #38bdf8; 
                font-weight: 700; 
            }
            .user-menu { 
                display: flex; 
                align-items: center; 
                gap: 15px; }
            .btn-logout { 
                color: #94a3b8; 
                text-decoration: none; 
                font-size: 0.9rem; 
                transition: color 0.2s; 
            }
            .btn-logout:hover { 
                color: #ef4444; 
            }

            .main-container {
                max-width: 1000px;
                margin: 30px auto;
                padding: 0 20px;
                display: grid;
                grid-template-columns: 1fr 280px;
                gap: 25px;
            }

            .feed-section { 
                display: flex; 
                flex-direction: column; 
                gap: 20px; 
            }
            
            .feed-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }
            .btn-ask {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%); 
                color: black; 
                text-decoration: none; 
                padding: 10px 18px;
                border-radius: 8px; 
                font-weight: 600; 
                font-size: 0.9rem;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: transform 0.2s, box-shadow 0.2s;
            }
            .btn-ask:hover { 
                box-shadow: 0 4px 15px rgba(16, 185, 129, 0.4); 
                transform: translateY(-1px); 
            }
            .btn-search {
                background: #1e293b;
                color: #cbd5e1;
                border: 1px solid #475569;
                padding: 10px 18px;
                border-radius: 8px;
                font-weight: 600;
                font-size: 0.9rem;
                cursor: pointer;
                transition: background-color 0.2s, border-color 0.2s, color 0.2s;
            }
            .btn-search:hover {
                background: #334155; 
                border-color: #94a3b8;
                color: #f8fafc;
            }
            .btn-clear {
                background: #334155;
                color: #cbd5e1;
                padding: 10px 15px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 0.95rem;
                display: flex;
                align-items: center;
                font-weight: 600;
                transition: background-color 0.2s, color 0.2s;
            }

            .btn-clear:hover {
                background: #475569;
                color: #f8fafc;
            }

            .question-card {
                background: #1e293b;
                border: 1px solid #334155;
                border-radius: 12px;
                padding: 20px;
                transition: border-color 0.2s;
            }
            .question-card:hover { 
                border-color: #475569; 
            }
            .question-title { 
                font-size: 1.2rem; 
                color: #f1f5f9; 
                margin-bottom: 8px; 
                font-weight: 600; 
                cursor: pointer; 
            }
            .question-title:hover { 
                color: #38bdf8; 
            }
            .question-desc { 
                color: #94a3b8; 
                font-size: 0.95rem; 
                line-height: 1.5; 
                margin-bottom: 15px; 
            }
            
            .question-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 0.85rem;
                color: #64748b;
                border-top: 1px solid #334155;
                padding-top: 12px;
            }
            .tags { 
                display: flex; 
                gap: 8px; 
            }
            .tag { 
                background: rgba(56, 189, 248, 0.1); 
                color: #38bdf8; 
                padding: 4px 8px; 
                border-radius: 4px; 
                font-weight: 500; 
            }

            .sidebar {
                background: #1e293b;
                border: 1px solid #334155;
                border-radius: 12px;
                padding: 20px;
                height: fit-content;
            }
            .sidebar h3 { 
                font-size: 1rem; 
                color: #cbd5e1; 
                margin-bottom: 15px; 
                text-transform: uppercase; 
                letter-spacing: 0.5px; 
            }
            .stats-list {
                list-style: none; 
                display: flex; 
                flex-direction: column; 
                gap: 12px; 
                font-size: 0.9rem; 
                color: #94a3b8; 
            }
            .stats-list span { 
                color: #38bdf8; 
                font-weight: 600; 
            }
        </style>
    </head>
    <body>

        <nav class="navbar">
          <h1>CodeSolve</h1>
          <div class="user-menu">
          <%
            HttpSession misession = request.getSession(false);
            String nombreMostrar = "Invitado";

            if (misession != null && misession.getAttribute("usuarioLogueado") != null) {
                Usuario uLogueado = (Usuario) misession.getAttribute("usuarioLogueado");
                nombreMostrar = uLogueado.getNombre(); 
            }
          %>
           <span>Bienvenido, <strong style="color: #38bdf8;"><%= nombreMostrar %></strong></span>
           <a href="SvLogout" class="btn-logout">Cerrar Sesión</a>
          </div>
        </nav>

        <div class="main-container">
            
            <main class="feed-section">
                <div class="feed-header">
                    <h2>Todas las Preguntas</h2>
                    <a href="HacerPregunta.jsp" class="btn-ask">Plantear Pregunta</a>
                </div>

                <div class="search-container" style="margin-bottom: 25px;">
                    <form action="index.jsp" method="GET" style="display: flex; gap: 10px;">
                        <input type="text" name="txtBuscar" placeholder="Buscar por título o etiqueta (ej: react)..." 
                               value="<%= request.getParameter("txtBuscar") != null ? request.getParameter("txtBuscar") : "" %>"
                               style="flex: 1; background: #0f172a; border: 1px solid #334155; padding: 12px; 
                               border-radius: 8px; color: #f8fafc; outline: none; font-size: 0.95rem;">
                        
                        <button type="submit" class="btn-search">Buscar</button>
                        
                        <% if (request.getParameter("txtBuscar") != null && !request.getParameter("txtBuscar").trim().isEmpty()) {                         %>
                            <a href="index.jsp" class="btn-clear">Limpiar</a>
                        <% } %>
                    </form>
                </div>

                <%
                    PreguntaDAO preguntaDAO = new PreguntaDAO();
                    List<Pregunta> listaPreguntas;

                    String buscar = request.getParameter("txtBuscar");

                    if (buscar != null && !buscar.trim().isEmpty()) {
                        listaPreguntas = preguntaDAO.buscarPreguntasPorCriterio(buscar.trim());
                    } else {
                        listaPreguntas = preguntaDAO.obtenerTodasLasPreguntas();
                    }

                    if (listaPreguntas != null && !listaPreguntas.isEmpty()) {
                        for (Pregunta p : listaPreguntas) {
                            Usuario autor = p.getUsuario();
                            String nombreAutor = (autor != null) ? autor.getNombre() : "Anónimo";
                %>
                            <div class="question-card" style="position: relative;">
                                <%
                                    int totalRespuestas = (p.getListaRespuestas() != null) ? p.getListaRespuestas().size() : 0;
                                %>
                                <div class="answers-badge" style="position: absolute; top: 20px; 
                                     right: 20px; background: #1e293b; border: 1px solid #334155; padding: 6px 12px; 
                                     border-radius: 20px; text-align: center; min-width: 70px;">
                                    <span style="display: block; font-size: 1.1rem; font-weight: 700; 
                                          color: #38bdf8;"><%= totalRespuestas %></span>
                                    <span style="font-size: 0.7rem; color: #94a3b8; text-transform: uppercase; 
                                          letter-spacing: 0.5px;">respuestas</span>
                                </div>

                                <div style="padding-right: 90px;">
                                    <div class="question-title">
                                        <a href="DetallePregunta.jsp?id=<%= p.getIdPregunta() %>" style="color: #38bdf8; 
                                           text-decoration: none; font-weight: 600;"><%= p.getTitulo() %></a>
                                    </div>
                                    <div class="question-desc">
                                        <%= p.getDescripcion() %>
                                    </div>
                                </div>

                                <div class="question-footer" style="margin-top: 15px;">
                                    <div class="tags">
                                        <%
                                            String tagsPlano = p.getEtiquetas(); 
                                            if (tagsPlano != null && !tagsPlano.isEmpty()) {
                                                String[] listaTags = tagsPlano.split(",");
                                                for (String tag : listaTags) {
                                        %>
                                                    <a href="index.jsp?txtBuscar=<%= tag.trim() %>" class="tag" 
                                                       style="text-decoration: none;"><%= tag.trim() %></a>
                                        <%
                                                }
                                            } else {
                                        %>
                                                <span class="tag">general</span>
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div style="color: #94a3b8; font-size: 0.85rem;">Por <span><%= nombreAutor %>
                                        </span> • <%= p.getFechaCreacion() != null ? sdfEspanol.format
                                                (p.getFechaCreacion()) : "Reciente" %></div>
                                </div>
                            </div>
                <%
                        }
                    } else {
                %>
                        <div class="question-card" style="text-align: center; color: #94a3b8;">
                            <div class="question-desc">No se encontraron preguntas que coincidan con tu búsqueda.</div>
                        </div>
                <%
                    }
                %>

            </main>

            <aside class="sidebar">
                <h3>Estadísticas de la Comunidad</h3>
                <%
                    dao.RespuestaDAO respuestaDAOStats = new dao.RespuestaDAO();
                    dao.UsuarioDAO usuarioDAOStats = new dao.UsuarioDAO(); 
                    
                    long respuestasTotales = respuestaDAOStats.contarRespuestasTotales();
                    long desarrolladoresTotales = usuarioDAOStats.contarUsuariosTotales();
                %>
                <ul class="stats-list">
                    <li>Preguntas totales: <span><%= (listaPreguntas != null) ? listaPreguntas.size() : 0 %></span></li>
                    
                    <li>Respuestas activas: <span><%= respuestasTotales %></span></li>
                    
                    <li>Desarrolladores: <span><%= desarrolladoresTotales %></span></li>
                </ul>
            </aside>

        </div>

    </body>