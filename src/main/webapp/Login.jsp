<%-- 
    Document   : Login
    Created on : 27 jun. 2026, 12:09:36
    Author     : Jhonny Dev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Iniciar Sesión en CodeSolve</title>
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

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                20%, 60% { transform: translateX(-6px); }
                40%, 80% { transform: translateX(6px); }
            }
            .shake { animation: shake 0.4s ease; }

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

            .input-error { 
                border-color: #ef4444 !important; 
                box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.2) !important; 
            }
            .input-success { 
                border-color: #10b981 !important; 
                box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.2) !important; 
            }

            .btn-submit {
                width: 100%;
                padding: 14px;
                background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
                color: black;
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

    <div class="register-card" id="card">
        <div class="brand">
            <h1>CodeSolve</h1>
            <p>Bienvenido de vuelta, desarrollador.</p>
        </div>
        
        <%-- Capturar errores devueltos por el servlet o sesiones expiradas --%>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert-error">
                <strong>¡Acceso Denegado!</strong> Credenciales inválidas o sesión expirada.
            </div>
        <% } %>

        <form action="UsuarioServlet" method="POST" id="loginForm">
            
            <input type="hidden" name="accion" value="login">
            
            <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="email" id="email" name="txtEmail" required placeholder="Ingresa tu correo">
            </div>
            
            <div class="form-group">
                <label for="password">Contraseña</label>
                <input type="password" id="password" name="txtPassword" required placeholder="••••••••">
            </div>
            
            <button type="submit" class="btn-submit" id="btnSubmit">Ingresar</button>
        </form>
        
        <div class="footer-links">
            ¿Nuevo en la comunidad? <a href="Registro.jsp">Crea una cuenta aquí</a>
        </div>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const form = document.getElementById('loginForm');
        const card = document.getElementById('card');
        const email = document.getElementById('email');
        const password = document.getElementById('password');
        const btnSubmit = document.getElementById('btnSubmit');

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        function marcarInput(input, esValido) {
            if (esValido) {
                input.classList.remove('input-error');
                input.classList.add('input-success');
            } else {
                input.classList.remove('input-success');
                input.classList.add('input-error');
            }
            return esValido;
        }

        // Validación en tiempo real para el login
        email.addEventListener('input', () => {
            marcarInput(email, emailRegex.test(email.value.trim()));
        });

        password.addEventListener('input', () => {
            marcarInput(password, password.value.length >= 6);
        });

        // Interceptar submit
        form.addEventListener('submit', function(e) {
            const v1 = marcarInput(email, emailRegex.test(email.value.trim()));
            const v2 = marcarInput(password, password.value.length >= 6);

            if (!v1 || !v2) {
                e.preventDefault();
                
                card.classList.add('shake');
                setTimeout(() => card.classList.remove('shake'), 400);
            } else {
                btnSubmit.innerText = "Verificando...";
                btnSubmit.style.opacity = "0.7";
            }
        });
    });
    </script>
</body>
</html>
