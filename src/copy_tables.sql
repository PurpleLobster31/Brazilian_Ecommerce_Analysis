-- COMO IMPORTAR TABELAS PARA O POSTGRES
-- Primeiramente, é necessário criar as tabelas em que serão importados os dados.
CREATE TABLE customers (
    customer_id UUID UNIQUE NOT NULL PRIMARY KEY,
    customer_unique_id UUID NOT NULL,
    customer_zip_code INTEGER NOT NULL,
    customer_city VARCHAR(100) NOT NULL,
    customer_state CHAR(2) NOT NULL
);

CREATE TABLE geolocations (
    geolocation_zip_code_prefix INTEGER NOT NULL,
    geolocation_lat NUMERIC NOT NULL,
    geolocation_lng NUMERIC NOT NULL,
    geolocation_city VARCHAR(100) NOT NULL,
    geolocation_state CHAR(2) NOT NULL
);

CREATE TABLE order_items (
    order_id UUID NOT NULL,
    order_item_id INTEGER NOT NULL,
    product_id UUID NOT NULL,
    seller_id UUID NOT NULL,
    shipping_limit_date TIMESTAMP NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    freight_value DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_order_items PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE order_payments (
    order_id UUID NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(255) NOT NULL,
    payment_installments INT NOT NULL,
    payment_value NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE order_reviews (
    review_id UUID NOT NULL,
    order_id UUID NOT NULL,
    review_score INT NOT NULL,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date TIMESTAMP NOT NULL,
    review_answer_timestamp TIMESTAMP NOT NULL
);

CREATE TABLE orders (
    order_id UUID PRIMARY KEY,
    customer_id UUID NOT NULL,
    order_status VARCHAR(255) NOT NULL,
    order_purchase_timestamp TIMESTAMP NOT NULL,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP NOT NULL
);

CREATE TABLE products (
    product_id UUID PRIMARY KEY,
    product_category_name VARCHAR(255),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

CREATE TABLE sellers (
    seller_id UUID PRIMARY KEY,
    seller_zip_code_prefix INT NOT NULL,
    seller_city VARCHAR(255) NOT NULL,
    seller_state VARCHAR(2) NOT NULL
);

-- Momento de cópia para o Postgres
COPY customers FROM 'D:\Users\matmen\Desktop\Pessoal\Projetos\Projeto Banco\data\olist_customers_dataset.csv' DELIMITER ',' CSV HEADER;
COPY geolocations FROM 'D:\Users\matmen\Desktop\Pessoal\Projetos\Projeto Banco\data\olist_geolocation_dataset.csv' DELIMITER ',' CSV HEADER;
COPY order_items FROM 'D:\Users\matmen\Desktop\Pessoal\Projetos\Projeto Banco\data\olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER;
COPY order_payments FROM 'D:\Users\matmen\Desktop\Pessoal\Projetos\Projeto Banco\data\olist_order_payments_dataset.csv' DELIMITER ',' CSV HEADER;
COPY order_reviews FROM 'D:\Users\matmen\Desktop\Pessoal\Projetos\Projeto Banco\data\olist_order_reviews_dataset.csv' DELIMITER ',' CSV HEADER;
COPY orders FROM 'D:\Users\matmen\Desktop\Pessoal\Projetos\Projeto Banco\data\olist_orders_dataset.csv' DELIMITER ',' CSV HEADER;
COPY products FROM 'D:\Users\matmen\Desktop\Pessoal\Projetos\Projeto Banco\data\olist_products_dataset.csv' DELIMITER ',' CSV HEADER;
COPY sellers FROM 'D:\Users\matmen\Desktop\Pessoal\Projetos\Projeto Banco\data\olist_sellers_dataset.csv' DELIMITER ',' CSV HEADER;
