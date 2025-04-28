-- Создание базы данных
CREATE DATABASE FurnitureFactory;
GO

USE FurnitureFactory;
GO

-- Создание таблицы пользователей
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    login NVARCHAR(50) NOT NULL UNIQUE,
    email NVARCHAR(100) NOT NULL UNIQUE,
    phone NVARCHAR(20),
    password NVARCHAR(100) NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    address NVARCHAR(200) NOT NULL,
    is_synced BIT DEFAULT 0 -- Флаг синхронизации с сервером
);

-- Создание таблицы категорий товаров
CREATE TABLE Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    is_synced BIT DEFAULT 0 -- Флаг синхронизации с сервером
);

-- Создание таблицы товаров
CREATE TABLE Products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(5, 2) DEFAULT 0,
    category_id INT,
    in_stock BIT DEFAULT 1,
    is_synced BIT DEFAULT 0, -- Флаг синхронизации с сервером
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Создание таблицы заказов
CREATE TABLE Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    total_price DECIMAL(10, 2) NOT NULL,
    delivery_address NVARCHAR(200) NOT NULL,
    delivery_date DATE,
    delivery_time TIME,
    status NVARCHAR(50) DEFAULT 'Pending',
    is_synced BIT DEFAULT 0, -- Флаг синхронизации с сервером
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Создание таблицы товаров в заказе
CREATE TABLE OrderItems (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    is_synced BIT DEFAULT 0, -- Флаг синхронизации с сервером
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Создание таблицы уведомлений
CREATE TABLE Notifications (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    message NVARCHAR(MAX) NOT NULL,
    status NVARCHAR(50) DEFAULT 'Unread',
    created_at DATETIME DEFAULT GETDATE(),
    is_synced BIT DEFAULT 0, -- Флаг синхронизации с сервером
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
