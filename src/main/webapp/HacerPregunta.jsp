<%-- 
    Document   : HacerPregunta
    Created on : 27 jun. 2026, 23:31:37
    Author     : Jhonny Dev
--%>

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
        <title>CodeSolve - Plantear Pregunta</title>
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
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-image: linear-gradient(rgba(248, 250, 252, 0.02) 1px, transparent 1px), 
                    linear-gradient(90deg, rgba (248, 250, 252, 0.02) 1px, transparent 1px);
                background-size: 30px 30px;
            }

            .navbar {
                background: #1e293b;
                padding: 15px 30px;
                border-bottom: 1px solid #334155;
            }
            .navbar a { 
                font-size: 1.5rem; 
                color: #38bdf8; 
                font-weight: 700; 
                text-decoration: none; 
            }

            .form-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 40px 20px;
            }
            .card-form {
                background: #1e293b;
                border: 1px solid #334155;
                width: 100%;
                max-width: 700px;
                padding: 35px;
                border-radius: 16px;
                box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
            }
            .card-form h2 { 
                font-size: 1.6rem; 
                color: #f1f5f9; 
                margin-bottom: 8px; 
                font-weight: 600; 
            }
            .card-form p { 
                color: #94a3b8; 
                font-size: 0.9rem; 
                margin-bottom: 25px; 
            }

            .input-group { 
                margin-bottom: 20px; 
                position: relative; 
            }
            .input-group label { 
                display: block; 
                color: #cbd5e1; 
                font-size: 0.9rem; 
                font-weight: 500; 
                margin-bottom: 8px; 
            }
            
            .input-group input, .input-group textarea {
                width: 100%;
                background: #0f172a;
                border: 1px solid #475569;
                border-radius: 8px;
                padding: 12px 14px;
                color: #f8fafc;
                font-size: 0.95rem;
                outline: none;
                transition: all 0.2s;
            }
            .input-group textarea { resize: vertical; min-height: 150px; font-family: inherit; }
            .input-group input:focus, .input-group textarea:focus { border-color: #38bdf8; box-shadow: 0 0 0 1px #38bdf8; }

            /* Botones de acción */
            .actions-layout { display: flex; justify-content: flex-end; gap: 15px; margin-top: 25px; }
            .btn {
                padding: 12px 24px; border-radius: 8px; font-weight: 600; font-size: 0.95rem; cursor: pointer; text-decoration: none; transition: all 0.2s; border: none;
            }
            .btn-cancel { background: transparent; color: #94a3b8; border: 1px solid #334155; }
            .btn-cancel:hover { background: rgba(148, 163, 184, 0.05); color: #f1f5f9; }
            
            .btn-submit { background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%); color: white; }
            .btn-submit:hover { box-shadow: 0 4px 12px rgba(56, 189, 248, 0.3); }

            /* Animación de feedback por si acaso */
            @keyframes shake { 0%, 100% { transform: translateX(0); } 20%, 60% { transform: translateX(-6px); } 40%, 80% { transform: translateX(6px); } }
            .error-shake { animation: shake 0.4s ease-in-out; border-color: #ef4444 !important; }
        </style>
    </head>
    <body>

        <nav class="navbar">
            <a href="index.jsp">CodeSolve</a>
        </nav>

        <div class="form-container">
            <div class="card-form" id="questionCard">
                <h2>Plantear una pregunta pública</h2>
                <p>Sé específico e imagina que le estás preguntando a otro desarrollador cara a cara.</p>

                <form action="SvPregunta" method="POST" id="questionForm">
                    <input type="hidden" name="accion" value="publicar">

                    <div class="input-group">
                        <label for="txtTitulo">Título del Hilo</label>
                        <input type="text" id="txtTitulo" name="txtTitulo" placeholder="Ej. ¿Cómo inyectar un EntityManager en una clase DAO en JPA?" autocomplete="off">
                    </div>

                    <div class="input-group">
                        <label for="txtDescripcion">Detalle de la duda / Problema</label>
                        <textarea id="txtDescripcion" name="txtDescripcion" placeholder="Introduce todo el contexto necesario, código de error o configuración que estés utilizando..."></textarea>
                    </div>

                    <div class="actions-layout">
                        <a href="index.jsp" class="btn btn-cancel">Cancelar</a>
                        <button type="submit" class="btn btn-submit" id="btnPublish">Publicar en el Feed</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            const form = document.getElementById('questionForm');
            const card = document.getElementById('questionCard');
            const title = document.getElementById('txtTitulo');
            const desc = document.getElementById('txtDescripcion');
            const btn = document.getElementById('btnPublish');

            form.addEventListener('submit', (e) => {
                card.classList.remove('error-shake');
                
                if (title.value.trim() === "" || desc.value.trim() === "") {
                    e.preventDefault();

                    void card.offsetWidth; 
                    card.classList.add('error-shake');
                    return;
                }

                btn.innerText = "Publicando Hilo...";
                btn.style.opacity = "0.7";
            });
        </script>
    </body>
</html>
