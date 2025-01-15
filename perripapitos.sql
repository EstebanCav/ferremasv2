-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-06-2023 a las 02:02:20
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `perripapitos`
--
CREATE DATABASE IF NOT EXISTS `perripapitos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `perripapitos`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(3, 'admin'),
(1, 'cliente'),
(2, 'vendedor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_group_permissions`
--

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(15, 1, 28),
(1, 1, 32),
(2, 1, 34),
(3, 1, 35),
(4, 1, 36),
(5, 1, 37),
(6, 1, 38),
(7, 1, 39),
(8, 1, 40),
(9, 1, 44),
(10, 1, 45),
(11, 1, 46),
(12, 1, 47),
(13, 1, 48),
(14, 1, 52),
(16, 2, 25),
(17, 2, 26),
(18, 2, 27),
(19, 2, 28),
(20, 2, 29),
(21, 2, 30),
(22, 2, 31),
(23, 2, 32),
(24, 2, 33),
(25, 2, 34),
(26, 2, 35),
(27, 2, 36),
(28, 2, 37),
(29, 2, 38),
(30, 2, 39),
(31, 2, 40),
(32, 2, 41),
(33, 2, 42),
(34, 2, 43),
(35, 2, 44),
(36, 3, 1),
(37, 3, 2),
(38, 3, 3),
(39, 3, 4),
(40, 3, 5),
(41, 3, 6),
(42, 3, 7),
(43, 3, 8),
(44, 3, 9),
(45, 3, 10),
(46, 3, 11),
(47, 3, 12),
(48, 3, 13),
(49, 3, 14),
(50, 3, 15),
(51, 3, 16),
(52, 3, 17),
(53, 3, 18),
(54, 3, 19),
(55, 3, 20),
(56, 3, 21),
(57, 3, 22),
(58, 3, 23),
(59, 3, 24),
(60, 3, 25),
(61, 3, 26),
(62, 3, 27),
(63, 3, 28),
(64, 3, 29),
(65, 3, 30),
(66, 3, 31),
(67, 3, 32),
(68, 3, 33),
(69, 3, 34),
(70, 3, 35),
(71, 3, 36),
(72, 3, 37),
(73, 3, 38),
(74, 3, 39),
(75, 3, 40),
(76, 3, 41),
(77, 3, 42),
(78, 3, 43),
(79, 3, 44),
(80, 3, 45),
(81, 3, 46),
(82, 3, 47),
(83, 3, 48),
(84, 3, 49),
(85, 3, 50),
(86, 3, 51),
(87, 3, 52);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add tipo producto', 7, 'add_tipoproducto'),
(26, 'Can change tipo producto', 7, 'change_tipoproducto'),
(27, 'Can delete tipo producto', 7, 'delete_tipoproducto'),
(28, 'Can view tipo producto', 7, 'view_tipoproducto'),
(29, 'Can add tipo suscripcion', 8, 'add_tiposuscripcion'),
(30, 'Can change tipo suscripcion', 8, 'change_tiposuscripcion'),
(31, 'Can delete tipo suscripcion', 8, 'delete_tiposuscripcion'),
(32, 'Can view tipo suscripcion', 8, 'view_tiposuscripcion'),
(33, 'Can add suscripcion', 9, 'add_suscripcion'),
(34, 'Can change suscripcion', 9, 'change_suscripcion'),
(35, 'Can delete suscripcion', 9, 'delete_suscripcion'),
(36, 'Can view suscripcion', 9, 'view_suscripcion'),
(37, 'Can add producto', 10, 'add_producto'),
(38, 'Can change producto', 10, 'change_producto'),
(39, 'Can delete producto', 10, 'delete_producto'),
(40, 'Can view producto', 10, 'view_producto'),
(41, 'Can add pedido', 11, 'add_pedido'),
(42, 'Can change pedido', 11, 'change_pedido'),
(43, 'Can delete pedido', 11, 'delete_pedido'),
(44, 'Can view pedido', 11, 'view_pedido'),
(45, 'Can add item_carrito', 12, 'add_item_carrito'),
(46, 'Can change item_carrito', 12, 'change_item_carrito'),
(47, 'Can delete item_carrito', 12, 'delete_item_carrito'),
(48, 'Can view item_carrito', 12, 'view_item_carrito'),
(49, 'Can add historial compra', 13, 'add_historialcompra'),
(50, 'Can change historial compra', 13, 'change_historialcompra'),
(51, 'Can delete historial compra', 13, 'delete_historialcompra'),
(52, 'Can view historial compra', 13, 'view_historialcompra');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$216000$oGG4Z8d97Dqz$Og+lN+5VcDnn3xpfaaYvDmUdAEM2QKS5hplaXzBFFOY=', '2023-06-27 23:56:25.000000', 1, 'eliasalcaide', '', '', '', 1, 1, '2023-06-27 23:56:03.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_suscripcion`
--

CREATE TABLE `core_suscripcion` (
  `id` int(11) NOT NULL,
  `suscripcion_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_tipoproducto`
--

CREATE TABLE `core_tipoproducto` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_tiposuscripcion`
--

CREATE TABLE `core_tiposuscripcion` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `db_historial_compra`
--

CREATE TABLE `db_historial_compra` (
  `pedido` int(11) NOT NULL,
  `codigo` varchar(10) NOT NULL,
  `compra_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `db_item_carrito`
--

CREATE TABLE `db_item_carrito` (
  `id` int(11) NOT NULL,
  `items` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `db_pedido`
--

CREATE TABLE `db_pedido` (
  `id` int(11) NOT NULL,
  `items` int(11) NOT NULL,
  `precio_total` decimal(10,2) NOT NULL,
  `fecha_compra` datetime(6) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `db_producto`
--

CREATE TABLE `db_producto` (
  `id` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `precio` int(11) NOT NULL,
  `Stock` int(11) NOT NULL,
  `Descripcion` varchar(250) NOT NULL,
  `Fecha_creacion` date NOT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `update_at` date NOT NULL,
  `tipo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2023-06-27 23:56:44.395920', '1', 'cliente', 1, '[{\"added\": {}}]', 3, 1),
(2, '2023-06-27 23:56:48.052653', '2', 'vendedor', 1, '[{\"added\": {}}]', 3, 1),
(3, '2023-06-27 23:56:53.559232', '3', 'admin', 1, '[{\"added\": {}}]', 3, 1),
(4, '2023-06-27 23:56:54.685270', '3', 'admin', 2, '[]', 3, 1),
(5, '2023-06-27 23:57:42.634119', '1', 'cliente', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(6, '2023-06-27 23:58:20.348523', '2', 'vendedor', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(7, '2023-06-27 23:58:25.958325', '3', 'admin', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(8, '2023-06-27 23:58:32.479211', '1', 'eliasalcaide', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(13, 'core', 'historialcompra'),
(12, 'core', 'item_carrito'),
(11, 'core', 'pedido'),
(10, 'core', 'producto'),
(9, 'core', 'suscripcion'),
(7, 'core', 'tipoproducto'),
(8, 'core', 'tiposuscripcion'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-06-27 23:54:13.597602'),
(2, 'auth', '0001_initial', '2023-06-27 23:54:13.678577'),
(3, 'admin', '0001_initial', '2023-06-27 23:54:13.941219'),
(4, 'admin', '0002_logentry_remove_auto_add', '2023-06-27 23:54:14.000108'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-06-27 23:54:14.006091'),
(6, 'contenttypes', '0002_remove_content_type_name', '2023-06-27 23:54:14.053964'),
(7, 'auth', '0002_alter_permission_name_max_length', '2023-06-27 23:54:14.087894'),
(8, 'auth', '0003_alter_user_email_max_length', '2023-06-27 23:54:14.101857'),
(9, 'auth', '0004_alter_user_username_opts', '2023-06-27 23:54:14.109835'),
(10, 'auth', '0005_alter_user_last_login_null', '2023-06-27 23:54:14.144748'),
(11, 'auth', '0006_require_contenttypes_0002', '2023-06-27 23:54:14.146743'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2023-06-27 23:54:14.152727'),
(13, 'auth', '0008_alter_user_username_max_length', '2023-06-27 23:54:14.166693'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2023-06-27 23:54:14.180656'),
(15, 'auth', '0010_alter_group_name_max_length', '2023-06-27 23:54:14.194615'),
(16, 'auth', '0011_update_proxy_permissions', '2023-06-27 23:54:14.201612'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2023-06-27 23:54:14.217569'),
(18, 'core', '0001_initial', '2023-06-27 23:54:14.421533'),
(19, 'sessions', '0001_initial', '2023-06-27 23:54:14.791025');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('jfs77b7zxsyut98l0ld372yvxx12na5y', '.eJxVjMEOwiAQRP-FsyHIot169O43kF1YpGogKe3J-O_SpAe9Tea9mbfytC7Zr01mP0V1UUd1-O2YwlPKBuKDyr3qUMsyT6w3Re-06VuN8rru7t9Bppb7OozJigUyiROic8gOzDBYMWicSWBSBDoD9ti1FEQCAjILWxrBndTnC-CzN_s:1qEIXp:7P8kfCM21RMFCYih9aWyBhkGBn2GWyUnbWY3GZqReF8', '2023-07-11 23:56:25.994312');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `core_suscripcion`
--
ALTER TABLE `core_suscripcion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`),
  ADD KEY `core_suscripcion_suscripcion_id_6a460276_fk_core_tipo` (`suscripcion_id`);

--
-- Indices de la tabla `core_tipoproducto`
--
ALTER TABLE `core_tipoproducto`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `core_tiposuscripcion`
--
ALTER TABLE `core_tiposuscripcion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `db_historial_compra`
--
ALTER TABLE `db_historial_compra`
  ADD PRIMARY KEY (`pedido`),
  ADD KEY `db_historial_compra_compra_id_d1148fa8_fk_db_Pedido_id` (`compra_id`);

--
-- Indices de la tabla `db_item_carrito`
--
ALTER TABLE `db_item_carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `db_item_carrito_producto_id_44361e86_fk_db_producto_id` (`producto_id`),
  ADD KEY `db_item_carrito_usuario_id_e8799e07_fk_auth_user_id` (`usuario_id`);

--
-- Indices de la tabla `db_pedido`
--
ALTER TABLE `db_pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `db_Pedido_producto_id_359aeb88_fk_db_producto_id` (`producto_id`),
  ADD KEY `db_Pedido_usuario_id_6ca89da0_fk_auth_user_id` (`usuario_id`);

--
-- Indices de la tabla `db_producto`
--
ALTER TABLE `db_producto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `db_producto_tipo_id_b9ba0546_fk_core_tipoproducto_id` (`tipo_id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_suscripcion`
--
ALTER TABLE `core_suscripcion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_tipoproducto`
--
ALTER TABLE `core_tipoproducto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_tiposuscripcion`
--
ALTER TABLE `core_tiposuscripcion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `db_historial_compra`
--
ALTER TABLE `db_historial_compra`
  MODIFY `pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `db_item_carrito`
--
ALTER TABLE `db_item_carrito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `db_pedido`
--
ALTER TABLE `db_pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `db_producto`
--
ALTER TABLE `db_producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `core_suscripcion`
--
ALTER TABLE `core_suscripcion`
  ADD CONSTRAINT `core_suscripcion_suscripcion_id_6a460276_fk_core_tipo` FOREIGN KEY (`suscripcion_id`) REFERENCES `core_tiposuscripcion` (`id`),
  ADD CONSTRAINT `core_suscripcion_usuario_id_e497b785_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `db_historial_compra`
--
ALTER TABLE `db_historial_compra`
  ADD CONSTRAINT `db_historial_compra_compra_id_d1148fa8_fk_db_Pedido_id` FOREIGN KEY (`compra_id`) REFERENCES `db_pedido` (`id`);

--
-- Filtros para la tabla `db_item_carrito`
--
ALTER TABLE `db_item_carrito`
  ADD CONSTRAINT `db_item_carrito_producto_id_44361e86_fk_db_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `db_producto` (`id`),
  ADD CONSTRAINT `db_item_carrito_usuario_id_e8799e07_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `db_pedido`
--
ALTER TABLE `db_pedido`
  ADD CONSTRAINT `db_Pedido_producto_id_359aeb88_fk_db_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `db_producto` (`id`),
  ADD CONSTRAINT `db_Pedido_usuario_id_6ca89da0_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `db_producto`
--
ALTER TABLE `db_producto`
  ADD CONSTRAINT `db_producto_tipo_id_b9ba0546_fk_core_tipoproducto_id` FOREIGN KEY (`tipo_id`) REFERENCES `core_tipoproducto` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
