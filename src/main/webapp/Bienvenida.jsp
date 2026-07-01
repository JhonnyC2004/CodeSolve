<%-- 
    Document   : Bienvenida
    Created on : 1 jul. 2026, 14:58:44
    Author     : Jhonny Dev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bienvenido a CodeSolve</title>
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
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }

            .landing-card {
                background: #1e293b;
                border: 1px solid #334155;
                max-width: 800px;
                width: 100%;
                border-radius: 16px;
                padding: 40px;
                box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
                text-align: center;
            }

            .logo-title {
                font-size: 3rem;
                font-weight: 800;
                color: #38bdf8;
                margin-bottom: 10px;
                letter-spacing: -0.05em;
            }
            
            .tagline {
                font-size: 1.25rem;
                color: #94a3b8;
                margin-bottom: 30px;
                line-height: 1.6;
            }
            .features-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 20px;
                margin-bottom: 40px;
                text-align: left;
            }

            .feature-item {
                background: #0f172a;
                border: 1px solid #334155;
                padding: 20px;
                border-radius: 10px;
            }

            .feature-item h3 {
                color: #f1f5f9;
                font-size: 1.05rem;
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .feature-item p {
                color: #94a3b8;
                font-size: 0.88rem;
                line-height: 1.5;
            }

            .cta-container {
                display: flex;
                justify-content: center;
                gap: 20px;
                flex-wrap: wrap;
            }

            .btn-cta {
                padding: 14px 32px;
                font-size: 1rem;
                font-weight: 600;
                border-radius: 8px;
                text-decoration: none;
                transition: all 0.2s ease;
                display: inline-block;
            }

            .btn-login {
                background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
                color: #0f172a;
                border: none;
                box-shadow: 0 4px 14px rgba(56, 189, 248, 0.3);
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(56, 189, 248, 0.4);
            }

            .btn-register {
                background: #1e293b;
                color: #cbd5e1;
                border: 1px solid #475569;
            }

            .btn-register:hover {
                background: #334155;
                color: #f8fafc;
                border-color: #64748b;
                transform: translateY(-2px);
            }

            /* Footer sutil */
            .footer-text {
                margin-top: 35px;
                font-size: 0.8rem;
                color: #475569;
            }
        </style>
    </head>
    <body>

        <div class="landing-card">
            <h1 class="logo-title">CodeSolve</h1>
            <p class="tagline">El ecosistema interactivo donde los desarrolladores comparten conocimiento, resuelven errores complejos y crecen juntos.</p>
            
            <div class="features-grid">
                <div class="feature-item">
                    <h3>🔍 Resuelve Dudas</h3>
                    <p>Publica tus problemas de código detallando el entorno, las tecnologías usadas y recibe soluciones precisas de la comunidad.</p>
                </div>
                <div class="feature-item">
                    <h3>💡 Comparte Conocimiento</h3>
                    <p>Ayuda a otros desarrolladores explicando el <em>porqué</em> de las soluciones. Impulsa la pedagogía y la paciencia con los nuevos talentos.</p>
                </div>
                <div class="feature-item">
                    <h3>📊 Datos en Tiempo Real</h3>
                    <p>Visualiza el crecimiento de la plataforma mediante métricas activas de la comunidad y monitorea tu propia actividad de aportes.</p>
                </div>
            </div>

            <div class="cta-container">
                <a href="Login.jsp" class="btn-cta btn-login">Ingresar a la Plataforma</a>
                <a href="Registro.jsp" class="btn-cta btn-register">Crear una Cuenta</a>
            </div>

            <p class="footer-text">Preguntar es vergüenza de un instante, no preguntar es vergüenza de una vida - Kafka en la orilla</p>
        </div>

    </body>
</html>