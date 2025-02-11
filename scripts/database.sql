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
(UUID(), 'Caturra'),
(UUID(), 'Pache'),
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
(UUID(), 'La Inca Supremo', 'La Inca Supremo es nuestro orgullo. Cultivado a mano en las alturas de Cusco, este café arábico se cosecha solo durante la temporada de lluvias, cuando los granos están llenos de sabor y aroma. Cada taza cuenta la historia de nuestro abuelo quien, desde joven, nos enseñó a trabajar la tierra con cariño.', 25.00, 'cafe_cusco.jpg', 100, (SELECT id_producer FROM producers WHERE name = 'Café Andino'), (SELECT id_coffee_type FROM coffee_types WHERE type_name = 'Arabica'), 250, 'Orgánico, Comercio Justo'),
(UUID(), 'Valle Blanco Orgánico', 'Valle Blanco Orgánico es nuestro homenaje a la tierra arequipeña. Cultivado en las laderas de los volcanes, este robusta tiene una fortaleza única, como el carácter de la gente de nuestra región. Lo sembramos con amor y cosechamos a mano, para que cada grano cuente la historia de nuestra familia.', 22.50, 'cafe_norte.jpg', 150, (SELECT id_producer FROM producers WHERE name = 'Caficultores del Norte'), (SELECT id_coffee_type FROM coffee_types WHERE type_name = 'Blend'), 500, 'Rainforest Alliance');

INSERT INTO orders (id_order, id_customer, total, status, shipping_address, shipping_method, tracking_number) VALUES
(UUID(), (SELECT id_user FROM user WHERE email = 'juan.perez@example.com'), 47.50, 'pending', 'Av. Siempre Viva 123, Lima', 'standard', NULL);

INSERT INTO order_details (id_detail, id_order, id_product, quantity, unit_price, subtotal) VALUES
(UUID(), (SELECT id_order FROM orders LIMIT 1), (SELECT id_product FROM products WHERE name = 'Café Cusqueño'), 1, 25.00, 25.00),
(UUID(), (SELECT id_order FROM orders LIMIT 1), (SELECT id_product FROM products WHERE name = 'Café Norteño'), 1, 22.50, 22.50);

INSERT INTO payments (id_payment, id_order, amount, payment_method, status, transaction_id) VALUES
(UUID(), (SELECT id_order FROM orders LIMIT 1), 47.50, 'card', 'completed', 'TXN123456');

