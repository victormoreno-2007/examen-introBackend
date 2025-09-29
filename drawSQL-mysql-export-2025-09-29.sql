CREATE TABLE `libro`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `titulo` VARCHAR(50) NOT NULL,
    `ISBN` INT NOT NULL,
    `ano_publicacion` DATE NOT NULL,
    `stock` INT NOT NULL,
    `id-categoria` INT NOT NULL,
    `id-autor` INT NOT NULL,
    `id-editorial` INT NOT NULL
);
ALTER TABLE
    `libro` ADD UNIQUE `libro_isbn_unique`(`ISBN`);
CREATE TABLE `autores`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(50) NOT NULL,
    `fecha-nacimiento` DATE NOT NULL,
    `nacionalidad` VARCHAR(50) NOT NULL
);
CREATE TABLE `editorial`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(50) NOT NULL
);
CREATE TABLE `categoria`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(50) NOT NULL
);
CREATE TABLE `libro-autor`(
    `id-autor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `id-libro` INT NOT NULL,
    PRIMARY KEY(`id-libro`)
);
CREATE TABLE `cliente`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `telefono` VARCHAR(15) NOT NULL,
    `direccion` VARCHAR(20) NOT NULL
);
CREATE TABLE `pedidos`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `estado-pedido` ENUM(
        'pendiente',
        'procesado',
        'completado'
    ) NOT NULL DEFAULT 'pendiente',
    `id-detalle` INT NOT NULL,
    `id-trasaccion` INT NOT NULL
);
CREATE TABLE `deta-pedido`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cantidad` INT NOT NULL,
    `fecha` DATE NOT NULL,
    `id-libro` INT NOT NULL,
    `id-cliente` INT NOT NULL
);
CREATE TABLE `transacciones`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `metodo` ENUM(
        'tarjetaCredito',
        'payPal',
        'efectivo',
        'tarjetaDebito'
    ) NOT NULL DEFAULT 'efectivo',
    `motoTotal` DECIMAL(10, 2) NOT NULL,
    `fecha` DATE NOT NULL
);
ALTER TABLE
    `deta-pedido` ADD CONSTRAINT `deta_pedido_id_libro_foreign` FOREIGN KEY(`id-libro`) REFERENCES `libro`(`id`);
ALTER TABLE
    `pedidos` ADD CONSTRAINT `pedidos_id_detalle_foreign` FOREIGN KEY(`id-detalle`) REFERENCES `deta-pedido`(`id`);
ALTER TABLE
    `libro-autor` ADD CONSTRAINT `libro_autor_id_autor_foreign` FOREIGN KEY(`id-autor`) REFERENCES `autores`(`id`);
ALTER TABLE
    `libro` ADD CONSTRAINT `libro_id_editorial_foreign` FOREIGN KEY(`id-editorial`) REFERENCES `editorial`(`id`);
ALTER TABLE
    `libro` ADD CONSTRAINT `libro_id_autor_foreign` FOREIGN KEY(`id-autor`) REFERENCES `libro-autor`(`id-libro`);
ALTER TABLE
    `categoria` ADD CONSTRAINT `categoria_nombre_foreign` FOREIGN KEY(`nombre`) REFERENCES `libro`(`id-categoria`);
ALTER TABLE
    `deta-pedido` ADD CONSTRAINT `deta_pedido_id_cliente_foreign` FOREIGN KEY(`id-cliente`) REFERENCES `cliente`(`id`);
ALTER TABLE
    `pedidos` ADD CONSTRAINT `pedidos_id_trasaccion_foreign` FOREIGN KEY(`id-trasaccion`) REFERENCES `transacciones`(`id`);