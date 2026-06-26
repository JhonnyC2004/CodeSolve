<%-- 
    Document   : Registro
    Created on : 26 jun. 2026, 16:38:15
    Author     : Jhonny Dev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Únete a CodeSolve</title>
        <style>
            * { 
                box-sizing: border-box; 
                margin: 0; 
                padding: 0; 
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            }
            
            body { 
                background-color: #0f172a;
                background-image: linear-gradient(rgba(248, 250, 252, 0.03) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(248, 250, 252, 0.03) 1px, transparent 1px);
                background-size: 40px 40px; 
                color: #f8fafc;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                
            }
            .register-card {
                background: #1e293b;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
                width: 100%;
                max-width: 450px;
                border: 1px solid #334155;
            }

            .brand {
                text-align: center;
                margin-bottom: 30px;
            }
            .brand h1 {
                font-size: 2rem;
                color: #38bdf8; 
                font-weight: 700;
            }
            .brand p {
                color: #94a3b8;
                font-size: 0.9rem;
                margin-top: 5px;
            }

            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #cbd5e1;
                font-size: 0.85rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            .form-group input {
                width: 100%;
                padding: 12px 16px;
                background: #0f172a;
                border: 1px solid #475569;
                border-radius: 8px;
                color: #fff;
                font-size: 0.95rem;
                transition: all 0.3s ease;
            }

            .form-group input:focus {
                outline: none;
                border-color: #38bdf8;
                box-shadow: 0 0 0 3px rgba(56, 189, 248, 0.2);
            }

            .btn-submit {
                width: 100%;
                padding: 14px;
                background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
                margin-top: 10px;
            }
            .btn-submit:hover {
                box-shadow: 0 4px 15px rgba(56, 189, 248, 0.4);
                transform: translateY(-1px);
            }
            .btn-submit:active {
                transform: translateY(1px);
            }

            .alert-error {
                background: rgba(239, 68, 68, 0.1);
                border-left: 4px solid #ef4444;
                color: #fca5a5;
                padding: 12px;
                border-radius: 6px;
                font-size: 0.85rem;
                margin-bottom: 20px;
            }

            .footer-links {
                text-align: center;
                margin-top: 25px;
                font-size: 0.9rem;
                color: #94a3b8;
            }
            .footer-links a {
                color: #38bdf8;
                text-decoration: none;
                font-weight: 600;
            }
            .footer-links a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <div class="register-card">
            <div class="brand">
                <h1>CodeSolve</h1>
                <p>La comunidad donde los desarrolladores encuentran la respuesta.</p>
            </div>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="alert-error">
                    <strong>¡Error!</strong> No se pudo procesar el registro. Inténtalo de nuevo o usa otro correo.
                </div>
            <% } %>

            <form action="UsuarioServlet" method="POST">
                
                <input type="hidden" name="accion" value="registrar">
                
                <div class="form-group">
                    <label for="nombre">Nombre Completo</label>
                    <input type="text" id="nombre" name="txtNombre" required placeholder="Tu nombre o alias">
                </div>
                
                <div class="form-group">
                    <label for="email">Correo Electrónico</label>
                    <input type="email" id="email" name="txtEmail" required placeholder="nombre@ejemplo.com">
                </div>
                
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" id="password" name="txtPassword" required placeholder="••••••••">
                </div>
                
                <button type="submit" class="btn-submit">Crear Cuenta</button>
            </form>
            
            <div class="footer-links">
                ¿Ya eres miembro? <a href="login.jsp">Inicia sesión</a>
            </div>
        </div>
        

    </body>
</html>