# 💻 CodeSolve - Ecosistema Interactivo para Desarrolladores

**CodeSolve** es una plataforma web interactiva diseñada bajo un enfoque colaborativo, donde estudiantes y profesionales de Ingeniería de Software pueden publicar problemas técnicos, debatir soluciones de código y realizar un seguimiento activo de sus aportes en la comunidad.

Desarrollado como proyecto académico, el sistema prioriza la consistencia visual mediante una interfaz oscura moderna y buenas prácticas de arquitectura de software.

---

## 🚀 Características Principales

* **Landing Page Informativa:** Pantalla de bienvenida que introduce el propósito de la app y centraliza los flujos de acceso (Login / Registro).
* **Gestión de Preguntas y Respuestas (CRUD Completo):** Los usuarios autenticados pueden crear, editar, visualizar y eliminar sus hilos de discusión técnicos.
* **Módulo de Autenticación Seguro:** Control de sesiones HTTP con funciones avanzadas de experiencia de usuario (UX), como el toggle dinámico (`👁️`/`🙈`) para visualizar contraseñas.
* **Dashboard Lateral (Sidebar):** Visualización en tiempo real de métricas de la comunidad (usuarios totales, respuestas) y estadísticas personalizadas del usuario logueado (*Mis Preguntas* y *Mis Respuestas*).
* **Consejos Didácticos:** Enfoque pedagógico en las respuestas para guiar de manera empática a los programadores junior.

---

## 🏗️ Arquitectura y Tecnologías

El sistema está construido siguiendo el patrón arquitectónico **Modelo-Vista-Controlador (MVC)**, garantizando una separación clara entre la interfaz y la lógica de persistencia.

* **Backend:** Java EE / Jakarta EE (Servlets y Controladores).
* **Persistencia / ORM:** JPA (Java Persistence API) con Hibernate.
* **Base de Datos:** MySQL Server.
* **Frontend:** JSP (JavaServer Pages), CSS3 (Diseño responsivo con fondo de rejilla oscura), JavaScript (Manipulación del DOM y lógica UX).
* **Servidor de Aplicaciones:** Apache Tomcat.
* **IDE de Desarrollo:** Apache NetBeans.

---

## 🛠️ Requisitos e Instalación

Para levantar este proyecto de manera local en tu entorno de desarrollo, sigue estos pasos:

### 1. Requisitos Previos
* Java Development Kit (JDK 8 o superior).
* Apache NetBeans IDE.
* Servidor MySQL corriendo localmente.
* Apache Tomcat (configurado en tu IDE).

### 2. Configuración de la Base de Datos
1. Abre tu gestor de MySQL (Workbench, phpMyAdmin, etc.).
2. Crea una base de datos llamada `codesolve_db`.
3. Importa el archivo de respaldo o ejecuta las sentencias de la estructura de tablas (mapeadas automáticamente por JPA).

### 3. Despliegue en NetBeans
1. Clona o descarga este repositorio.
2. Abre Apache NetBeans e ingresa a **File -> Open Project** para seleccionar la carpeta del proyecto.
3. Haz clic derecho sobre el proyecto **CodeSolve** y selecciona **Properties**. En la sección **Run**, asegúrate de asociar tu servidor Apache Tomcat local.
4. Haz clic derecho sobre el proyecto y selecciona **Clean and Build** para compilar las dependencias.
5. Presiona **Run** (F6) para desplegar. El archivo `web.xml` redirigirá automáticamente a la pantalla de `Bienvenida.jsp`.

---
* **Jhonny Coello Lamilla** - *Desarrollo Full-Stack / Arquitectura backend (JPA & Servlets)*

---

Este proyecto fue desarrollado en el marco académico de la carrera de Ingeniería de Software (6to Semestre) - 2026.
