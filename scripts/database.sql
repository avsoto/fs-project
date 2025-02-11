CREATE DATABASE IF NOT EXISTS cafe_db;
USE cafe_db;

-- Users Table
CREATE TABLE user (
    id_user CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('customer', 'producer', 'admin') NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status BOOLEAN DEFAULT TRUE
);
-- Provinces Table
CREATE TABLE provinces (
    id_province CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL
);
-- Producers Table
CREATE TABLE producers (
    id_producer CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    location CHAR(36),
    image TEXT,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    status BOOLEAN DEFAULT TRUE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (location) REFERENCES provinces(id_province) ON DELETE SET NULL
);
-- Products Table
CREATE TABLE products (
    id_product CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image TEXT,
    stock INT NOT NULL DEFAULT 0,
    id_producer CHAR(36),
    coffee_type ENUM('arabica', 'robusta', 'blend') NOT NULL,
    weight DECIMAL(10,2) NOT NULL,
    certifications TEXT,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producer) REFERENCES producers(id_producer) ON DELETE CASCADE
);
CREATE TABLE coffee_types (
    id_coffee_type CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    type_name VARCHAR(50) NOT NULL UNIQUE
);
-- Orders Table
CREATE TABLE orders (
    id_order CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    id_customer CHAR(36),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'paid', 'shipped', 'delivered') NOT NULL DEFAULT 'pending',
    shipping_address TEXT,
    shipping_method ENUM('standard', 'express') NOT NULL,
    tracking_number VARCHAR(255) NULL,
    FOREIGN KEY (id_customer) REFERENCES users(id_user) ON DELETE CASCADE
);
-- Order Details Table
CREATE TABLE order_details (
    id_detail CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    id_order CHAR(36),
    id_product CHAR(36),
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_order) REFERENCES orders(id_order) ON DELETE CASCADE,
    FOREIGN KEY (id_product) REFERENCES products(id_product) ON DELETE CASCADE
);
-- Payments Table
CREATE TABLE payments (
    id_payment CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    id_order CHAR(36),
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('card', 'transfer', 'Yape', 'Plin') NOT NULL,
    status ENUM('pending', 'completed', 'failed') NOT NULL DEFAULT 'pending',
    transaction_id VARCHAR(255) UNIQUE NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_order) REFERENCES orders(id_order) ON DELETE CASCADE
);

INSERT INTO provinces (id_province, name) VALUES
(UUID(), 'Amazonas'), 
(UUID(), 'Áncash'), 
(UUID(), 'Apurímac'),
(UUID(), 'Arequipa'), 
(UUID(), 'Ayacucho'),
(UUID(), 'Cajamarca'),
(UUID(), 'Callao'), 
(UUID(), 'Cusco'), 
(UUID(), 'Huancavelica'),
(UUID(), 'Huánuco'), 
(UUID(), 'Ica'), 
(UUID(), 'Junín'),
(UUID(), 'La Libertad'), 
(UUID(), 'Lambayeque'), 
(UUID(), 'Lima'),
(UUID(), 'Loreto'), 
(UUID(), 'Madre de Dios'), 
(UUID(), 'Moquegua'),
(UUID(), 'Pasco'), 
(UUID(), 'Piura'), 
(UUID(), 'Puno'),
(UUID(), 'San Martín'), 
(UUID(), 'Tacna'), 
(UUID(), 'Tumbes'),
(UUID(), 'Ucayali');

INSERT INTO coffee_types (id_coffee_type, type_name) VALUES
(UUID(), 'Typica'),
(UUID(), 'Bourbon'),
(UUID(), 'Arabica'),
(UUID(), 'Blend'),
(UUID(), 'Catimor'),
(UUID(), 'Geisha'),
(UUID(), 'Mundo Novo'),
(UUID(), 'Catuai'),
(UUID(), 'Villa Sarchi'),
(UUID(), 'Marsellesa');

INSERT INTO user (id_user, name, email, password, role, phone, address) VALUES
(UUID(), 'Juan Pérez', 'juan.perez@example.com', 'hashed_password', 'customer', '987654321', 'Av. Siempre Viva 123, Lima'),
(UUID(), 'María Gómez', 'maria.gomez@example.com', 'hashed_password', 'producer', '976543210', 'Jr. Los Cafetales, Cusco'),
(UUID(), 'Carlos Rodríguez', 'carlos.rodriguez@example.com', 'hashed_password', 'admin', '965432109', 'Calle Principal 456, Lima');

INSERT INTO producers (id_producer, name, description, location, image, email, phone) VALUES
(UUID(), 'La Inka', 'Café La Inca es una finca familiar en las montañas de Cusco, donde las tradiciones de los abuelos se mantienen vivas. Cultivamos café con pasión y respeto por la naturaleza, utilizando métodos orgánicos que han sido transmitidos de generación en generación.', (SELECT id_province FROM provinces WHERE name = 'Cusco'), 'cafe_andino.jpg', 'info@cafeandino.com', '956123456'),
(UUID(), 'Valle Blanco', 'En el corazón de Arequipa, Café Valle Blanco ha sido el sueño de una familia que decidió llevar el café de su tierra a los rincones más lejanos del mundo. Cada grano tiene la historia de nuestros antepasados que sembraron este sueño con esfuerzo y dedicación.', (SELECT id_province FROM provinces WHERE name = 'Cajamarca'), 'cafe_norte.jpg', 'contacto@caficultoresnorte.com', '987654123');

INSERT INTO products (id_product, name, description, price, image, stock, id_producer, id_coffee_type, weight, certifications) VALUES
(UUID(), 'La Inka Supremo', 'La Inca Supremo es nuestro orgullo. Cultivado a mano en las alturas de Cusco, este café arábico se cosecha solo durante la temporada de lluvias, cuando los granos están llenos de sabor y aroma. Cada taza cuenta la historia de nuestro abuelo quien, desde joven, nos enseñó a trabajar la tierra con cariño.', 25.00, 'cafe_cusco.jpg', 100, (SELECT id_producer FROM producers WHERE name = 'La Inka'), (SELECT id_coffee_type FROM coffee_types WHERE type_name = 'Arabica'), 250, 'Orgánico, Comercio Justo'),
(UUID(), 'Valle Blanco Orgánico', 'Valle Blanco Orgánico es nuestro homenaje a la tierra arequipeña. Cultivado en las laderas de los volcanes, este robusta tiene una fortaleza única, como el carácter de la gente de nuestra región. Lo sembramos con amor y cosechamos a mano, para que cada grano cuente la historia de nuestra familia.', 22.50, 'cafe_norte.jpg', 150, (SELECT id_producer FROM producers WHERE name = 'Valle Blanco'), (SELECT id_coffee_type FROM coffee_types WHERE type_name = 'Blend'), 500, 'Rainforest Alliance');

INSERT INTO orders (id_order, id_customer, total, status, shipping_address, shipping_method, tracking_number) VALUES
(UUID(), (SELECT id_user FROM user WHERE email = 'juan.perez@example.com'), 47.50, 'pending', 'Av. Siempre Viva 123, Lima', 'standard', NULL);

INSERT INTO order_details (id_detail, id_order, id_product, quantity, unit_price, subtotal) VALUES
(UUID(), (SELECT id_order FROM orders LIMIT 1), (SELECT id_product FROM products WHERE name = 'La Inka Supremo'), 1, 25.00, 25.00),
(UUID(), (SELECT id_order FROM orders LIMIT 1), (SELECT id_product FROM products WHERE name = 'Valle Blanco Orgánico'), 1, 22.50, 22.50);

INSERT INTO payments (id_payment, id_order, amount, payment_method, status, transaction_id) VALUES
(UUID(), (SELECT id_order FROM orders LIMIT 1), 47.50, 'card', 'completed', 'TXN123456');

