<%-- 
    Document   : index.jsp
    Created on : 27 jun. 2026, 12:32:35
    Author     : Jhonny Dev
--%>

<%@page import="jhonnydev.codesolve.modelo.Usuario"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <a href="hacer-pregunta.jsp" class="btn-ask">Plantear Pregunta</a>
                </div>

                <div class="question-card">
                    <div class="question-title">¿Cómo solucionar el error ExceptionInInitializerError en módulos de Java?</div>
                    <div class="question-desc">
                        Estoy intentando compilar un empaquetado WAR usando Maven en una versión de JDK superior a la 11, pero el compilador colapsa indicando problemas de acceso reflejado en java.base...
                    </div>
                    <div class="question-footer">
                        <div class="tags">
                            <span class="tag">java</span>
                            <span class="tag">maven</span>
                        </div>
                        <div>Por <span>Jhonny Coello</span> • Hace 10 min</div>
                    </div>
                </div>

                <div class="question-card">
                    <div class="question-title">Duda sobre la configuración correcta de persistence.xml en JPA</div>
                    <div class="question-desc">
                        ¿Es obligatorio definir las clases entidad explícitamente dentro de la etiqueta class o el proveedor EclipseLink las mapea automáticamente al escanear el proyecto?
                    </div>
                    <div class="question-footer">
                        <div class="tags">
                            <span class="tag">jpa</span>
                            <span class="tag">mysql</span>
                        </div>
                        <div>Por <span>Anónimo</span> • Hace 2 horas</div>
                    </div>
                </div>

            </main>

            <aside class="sidebar">
                <h3>Estadísticas de la Comunidad</h3>
                <ul class="stats-list">
                    <li>Preguntas totales: <span>2</span></li>
                    <li>Respuestas activas: <span>0</span></li>
                    <li>Desarrolladores: <span>1</span></li>
                </ul>
            </aside>

        </div>

    </body>
</html>
