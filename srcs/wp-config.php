<?php
/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   wp-config.php                                      :+:    :+:            */
/*                                                     +:+                    */
/*   By: nsterk <nsterk@student.codam.nl>             +#+                     */
/*                                                   +#+                      */
/*   Created: 2021/02/03 15:40:47 by nsterk        #+#    #+#                 */
/*   Updated: 2021/02/03 15:40:47 by nsterk        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'ft_server' );

/** MySQL database username */
define( 'DB_USER', 'nsterk' );

/** MySQL database password */
define( 'DB_PASSWORD', 'codam' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         ' }^iDl@5i#2dw?CH{n(GSFA TwvA4j Z-BGN;k-+=jne-*g<#>>B(;[B<oLtH3lE');
define('SECURE_AUTH_KEY',  'GXESs[i1gDiCYHe%*(z;7E`^W;5ny]k&LTr,-y,WVJi`_@4C3lP&b~>3oyo(:-PH');
define('LOGGED_IN_KEY',    '.Bb,D&T97M3/avx9Mg]3:}).NCEb2 ia0f_#?v0y>hme{^_F,8sG?5*qvj(;|I>^');
define('NONCE_KEY',        '{A_oS?7;c&jCYjmnnQ,-:42XM_;u[/xL~xK}Hg4+ZvT9,&,eACep`)/($;AQRj)M');
define('AUTH_SALT',        'Y?M@gF(S=Ylm6(#a@`[J.W`oo.^T$Cxvl-Tw-W%Z%gYyPFD!K&l8UzAR?ESt|OK~');
define('SECURE_AUTH_SALT', 'BCDv#[fV6<{C00f:>!=S[$d%wN*|eRv^X/!N(+Qc7-o$bR!D5a,5L5RYt?-Zv@L2');
define('LOGGED_IN_SALT',   '~ I3?4<l1J=%lI.zo;.B8 EoVP?HWZ;`-OhMS~~}e<#xDaW?/%!?<eQN~-0gL76K');
define('NONCE_SALT',       '0T)+V%|uyYI8ZNuE&&u* R OBWc5zJUg%L-%@%&s#YVqEA#IRIl9*m,MhWnZ:kIf');
/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
