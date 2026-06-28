<%-- 
    Document   : index.jsp
    Created on : 27 jun. 2026, 12:32:35
    Author     : Jhonny Dev
--%>

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
                background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
                color: white; 
                text-decoration: none; 
                padding: 10px 18px;
                border-radius: 8px; 
                font-weight: 600; 
                font-size: 0.9rem;
                transition: box-shadow 0.2s;
            }
            .btn-ask:hover { 
                box-shadow: 0 4px 12px rgba(56, 189, 248, 0.3); 
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
                               style="flex: 1; 
                               background: #0f172a; 
                               border: 1px solid #334155; 
                               padding: 12px; 
                               border-radius: 8px; 
                               color: #f8fafc; 
                               outline: none; 
                               font-size: 0.95rem;">
                        <button type="submit" style="background: #38bdf8; 
                                color: #0f172a; 
                                border: none; 
                                padding: 12px 20px; 
                                border-radius: 8px; 
                                font-weight: 600; 
                                cursor: pointer;">Buscar</button>
                        <% if (request.getParameter("txtBuscar") != null && !request.getParameter("txtBuscar").trim().isEmpty()) {                         %>
                            <a href="index.jsp" style="background: #334155; color: #cbd5e1; padding: 12px 15px; 
                               border-radius: 8px; 
                               text-decoration: none; 
                               font-size: 0.95rem; 
                               display: flex; 
                               align-items: center;">Limpiar</a>
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
                            <div class="question-card">
                                <div class="question-title">
                                   <a href="DetallePregunta.jsp?id=<%= p.getIdPregunta() %>" style="color: #38bdf8; 
                                   text-decoration: none; font-weight: 600;"><%= p.getTitulo() %></a>
                                </div>
                                <div class="question-desc">
                                    <%= p.getDescripcion() %>
                                </div>
                                <div class="question-footer">
                                    <div class="tags">
                                    <%
                                      String tagsPlano = p.getEtiquetas(); 
                                      int totalRespuestas = (p.getListaRespuestas() != null) ? p.getListaRespuestas().size() : 0;

                                      if (tagsPlano != null && !tagsPlano.isEmpty()) {
                                          String[] listaTags = tagsPlano.split(",");
                                          for (String tag : listaTags) {
                                    %>
                                      <a href="index.jsp?txtBuscar=<%= tag.trim() %>" class="tag" style="text-decoration: none;">
                                      <%= tag.trim() %> (<%= totalRespuestas %>)
                                      </a>
                                    <%
                                          }
                                      }else{
                                      %>
                                      <span class="tag">general (<%= totalRespuestas %>)</span>
                                      <%
                                      }
                                    %>
                                    </div> 
                                         <div>Por <span><%= nombreAutor %></span> • <%= p.getFechaCreacion() %></div>
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
                <ul class="stats-list">
                    <li>Preguntas totales: <span><%= (listaPreguntas != null) ? listaPreguntas.size() : 0 %></span></li>
                    <li>Respuestas activas: <span>0</span></li>
                    <li>Desarrolladores: <span>1</span></li>
                </ul>
            </aside>

        </div>

    </body>