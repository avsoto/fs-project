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
