-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-07-2026 a las 04:51:07
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `codesolve_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `id_pregunta` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  `etiquetas` varchar(255) DEFAULT 'general'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`id_pregunta`, `titulo`, `descripcion`, `fecha`, `id_usuario`, `etiquetas`) VALUES
(1, '¿Como puedo empaquetar mi proyecto sin importar el SO, librerias y entornos etc??', '¡Hola a todos! Estoy terminando un proyecto y me encuentro con el típico problema de principiante. En mi computadora funciona todo perfecto, pero necesito que cualquier otra persona lo pueda ejecutar en su propia máquina (ya sea que usen Windows, Linux o macOS) y que funcione exactamente igual. Mi mayor temor son las librerías, las dependencias y las variables de entorno. No quiero que el usuario final tenga que estar instalando paquetes a mano, lidiando con versiones incompatibles de Node/Python/Java, o que el programa falle porque falta alguna configuración en su sistema operativo. Busco una solución donde el proyecto vaya \"blindado\" con todo lo que necesita para correr a la primera. ¿Cuál es la mejor estrategia o herramienta para lograr esto hoy en día? Me han hablado un poco de empaquetar el código y también de contenedores, pero como soy aprendiz no sé qué me conviene más ni por dónde empezar para no complicarme la vida. Agradezco mucho cualquier guía, tutorial o consejo que me puedan dar!', '2026-06-28 04:39:58', 1, 'general'),
(2, '¿Por qué mi bucle forEach en JavaScript no modifica el array original al actualizar un estado en React?', 'Hola. Estoy intentando modificar un array de objetos dentro de un estado en React usando un bucle forEach. El objetivo es cambiar la propiedad activo a true para un elemento específico, pero el componente no se vuelve a renderizar ni los datos parecen cambiar.\r\nCódigo:\r\njavascriptconst [items, setItems] = useState([\r\n  { id: 1, nombre: \'Item 1\', activo: false },\r\n  { id: 2, nombre: \'Item 2\', activo: false }\r\n]);\r\n\r\nconst activarItem = (id) => {\r\n  const nuevosItems = items;\r\n  nuevosItems.forEach(item => {\r\n    if (item.id === id) {\r\n      item.activo = true;\r\n    }\r\n  });\r\n  setItems(nuevosItems);\r\n};', '2026-06-28 05:06:58', 3, 'general'),
(6, 'Problema de codificación (UTF-8) al guardar datos con la letra ñ', 'Hola, al enviar datos desde el formulario por método POST, las palabras que llevan tildes o la letra ñ se transforman en símbolos extraños en la persistencia. ¿Alguien sabe cómo configurar el request.setCharacterEncoding en el Servlet?', '2026-07-03 02:22:57', 5, 'web, servlet, java'),
(7, '¿Cómo capturar un NullPointerException en el login con JPA?', 'Buenas. Cuando un usuario ingresa mal la contraseña, mi método em.createQuery().getSingleResult() me arroja una excepción en lugar de retornar null. ¿Debería envolverlo en un bloque try-catch o usar un if?', '2026-07-03 02:24:04', 5, 'mysql, backend, jpa'),
(8, 'Error 404 al intentar acceder a un Servlet desde un formulario en NetBeans', 'Tengo un formulario en mi JSP con action=\"SvContador\". Al darle al botón submit, el navegador me redirige a una pantalla blanca con un Error 404 que dice que el recurso no está disponible. Ya limpié el proyecto con Clean and Build y el servidor Tomcat está corriendo bien. ¿Por qué ocurre esto?', '2026-07-03 02:26:27', 6, 'servlets, netbeans, tomcat'),
(9, '¿Cómo pasar el objeto de sesión (Usuario) de un Servlet a un JSP?', 'Logré validar las credenciales de mi usuario en el Servlet de Login usando JPA. Ahora necesito que el nombre del desarrollador se muestre arriba en la barra de navegación de todas las páginas JSP del sistema. ¿Cuál es el procedimiento correcto para guardar el objeto en memoria y leerlo en las vistas?', '2026-07-03 02:28:17', 6, 'backend, jsp, session'),
(10, 'Error: \'java.lang.ClassCastException\' al recuperar datos con JPA', 'Hola a todos, estoy usando una consulta JPQL personalizada con em.createQuery() para traer un conteo de registros. Al intentar almacenar el resultado en una variable de tipo int, la aplicación se cae arrojando una excepción de casteo. ¿Qué tipo de dato devuelve por defecto un COUNT en JPQL?', '2026-07-03 02:28:52', 6, 'jpa, exceptions, java'),
(11, '¿Cómo aplicar Atomic Design para maquetar los componentes de un Foro en Figma?', 'Hola comunidad, estamos diseñando la interfaz de nuestro proyecto y queremos usar la metodología de Atomic Design (Diseño Atómico) para mantener la consistencia. Tengo claro que los botones y inputs son átomos, pero tengo dudas con las tarjetas de las preguntas donde va el nombre del usuario, la fecha y los tags. ¿Eso calificaría como un molécula o ya entra en la categoría de organismo? ¿Cómo recomiendan estructurar la arquitectura de información en este caso?', '2026-07-03 02:34:56', 7, 'ux, ui, figma'),
(12, '¿Cuándo es estrictamente necesario usar un INNER JOIN en lugar de subconsultas?', 'Hola a todos, estoy optimizando el rendimiento de las consultas en MySQL para un reporte de aportes por desarrollador. Noto que al usar subconsultas con SELECT COUNT dentro de otra consulta el tiempo de respuesta sube cuando hay miles de registros. ¿En términos de rendimiento, el motor de base de datos optimiza mejor los JOIN tradicionales o las subconsultas correlacionadas?', '2026-07-03 02:35:29', 7, 'mysql, query, sql'),
(13, '¿Cómo prevenir ataques de inyección SQL al usar JPA o JDBC en formularios de Login?', 'Qué tal. Estoy diseñando el backend del inicio de sesión. Sé que si uso consultas concatenando texto plano soy vulnerable a que alguien manipule las credenciales. Si estoy utilizando JPA con EntityManager y createQuery con parámetros nombrados (usando el método setParameter), ¿el framework ya se encarga de sanitizar los inputs automáticamente o debo agregar una capa extra de validación con expresiones regulares?', '2026-07-03 02:37:35', 3, 'backend, security');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `id_respuesta` int(11) NOT NULL,
  `contenido` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_pregunta` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `respuestas`
--

INSERT INTO `respuestas` (`id_respuesta`, `contenido`, `fecha`, `id_pregunta`, `id_usuario`) VALUES
(4, 'hdhwydywdywgw segunda ', '2026-06-28 20:16:38', 1, 3),
(7, 'Hola, bro. Ese error 404 significa casi siempre que el mapeo de la URL en tu controlador no coincide con lo que escribiste en el formulario. Revisa la cabecera de tu clase Servlet; debes asegurarte de tener la anotación @WebServlet(name = \"SvContador\", urlPatterns = {\"/SvContador\"}).\r\n\r\nSi la anotación está bien, fíjate en el action de tu formulario en el JSP. Si tu URL es relativa, intenta ponerle un punto adelante: action=\"./SvContador\". Esto evita que el navegador se coma el Context Path (el nombre de tu proyecto en la URL) al enviar la petición por POST.', '2026-07-03 02:29:55', 8, 5),
(8, 'Complementando lo que dice Dustin, a veces Tomcat guarda en caché las rutas viejas del despliegue y no se entera de que creaste un Servlet nuevo. No basta con darle \'Run\'. Ve a la pestaña de proyectos en NetBeans, haz clic derecho sobre el proyecto principal y selecciona \'Clean and Build\' (Limpiar y Construir). Esto fuerza al IDE a recompilar las clases Java a archivos .class y actualiza el mapa de rutas dentro de las carpetas internas de Tomcat.', '2026-07-03 02:31:41', 8, 7),
(9, 'Hola, amigo. El problema que estás experimentando ocurre porque en JavaScript los arrays y objetos se manejan por referencia en memoria. Al hacer la asignación de nuevosItems igual a items, no estás creando una lista nueva, sino apuntando al mismo espacio. Cuando usas el bucle forEach y modificas la propiedad directamente, estás mutando el estado original de React de forma prohibida. Como la dirección de memoria no cambia, la función setItems asume que los datos son los mismos y decide optimizar el rendimiento no volviendo a renderizar tu componente. Para solucionarlo, debes usar el método punto map, el cual se encarga de retornar un array completamente nuevo en memoria, rompiendo la referencia antigua y forzando a React a actualizar la interfaz al instante.', '2026-07-03 02:33:12', 2, 7),
(10, 'Hola, colega. Para solucionar este problema de raíz y asegurar que la letra ñ y las tildes se guarden correctamente, debes forzar al Servlet a procesar la petición usando UTF-8 antes de leer cualquier parámetro.\r\n\r\nLa forma directa de solucionarlo es agregando la siguiente línea como la primerísima instrucción dentro de los métodos doGet y doPost (o dentro de tu método processRequest) de tu Servlet:\r\n\r\nrequest.setCharacterEncoding(\"UTF-8\");\r\n\r\nEs fundamental que coloques esa línea antes de cualquier llamado a request.getParameter, de lo contrario no tendrá efecto. Adicionalmente, si quieres que la respuesta que viaja del Servlet al JSP también soporte caracteres especiales, añade abajo esta línea:\r\n\r\nresponse.setContentType(\"text/html;charset=UTF-8\");\r\n\r\nComo buena práctica para tu documentación, si el problema persiste en todo el proyecto, lo ideal en aplicaciones Java Web más grandes es implementar un Filtro (Servlet Filter) que intercepte todas las peticiones generales y les aplique el setCharacterEncoding automáticamente, evitando que tengas que escribir la misma línea en cada uno de tus Servlets controladores. ¡Prueba agregando esa línea al inicio de tu doPost y verás cómo MySQL empieza a registrar todo de forma impecable!', '2026-07-03 02:33:53', 6, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`) VALUES
(1, 'Admin', 'admin123@outlook.com', 'admin123'),
(3, 'MoureDev123', 'mouredev123@outlook.com', 'mouredev123'),
(4, 'Javi18', 'javi18@gmail.com', 'javi18'),
(5, 'DustinUX', 'dustin@outlook.com', 'dustin'),
(6, 'DaniPro777', 'dani777@gmail.com', 'dani777'),
(7, 'BryanDev', 'bryan@gmail.com', 'bryan123');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`id_pregunta`),
  ADD KEY `fk_preguntas_usuarios` (`id_usuario`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id_respuesta`),
  ADD KEY `fk_respuestas_preguntas` (`id_pregunta`),
  ADD KEY `fk_respuestas_usuarios` (`id_usuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `uq_email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `id_pregunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id_respuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD CONSTRAINT `fk_preguntas_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `fk_respuestas_preguntas` FOREIGN KEY (`id_pregunta`) REFERENCES `preguntas` (`id_pregunta`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_respuestas_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
