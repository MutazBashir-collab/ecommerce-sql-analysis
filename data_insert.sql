-- =====================================================
-- إدخال بيانات تجريبية
-- Insert Sample Data
-- =====================================================

-- إضافة عملاء
INSERT INTO customers (first_name, last_name, email, phone, city, registration_date) VALUES
('Ahmed', 'Mohammed', 'ahmed@email.com', '5550100', 'Doha', '2025-01-15'),
('Sara', 'Ali', 'sara@email.com', '5550101', 'Al Wakrah', '2025-01-20'),
('Khalid', 'Hassan', 'khalid@email.com', '5550102', 'Doha', '2025-02-01'),
('Noura', 'Saleh', 'noura@email.com', '5550103', 'Al Rayyan', '2025-02-10'),
('Faisal', 'Omar', 'faisal@email.com', '5550104', 'Doha', '2025-02-15');

-- إضافة منتجات
INSERT INTO products (product_name, category, price, cost, stock_quantity, reorder_level) VALUES
('Dell XPS 13 Laptop', 'Electronics', 4500, 3800, 15, 5),
('iPhone 15', 'Electronics', 3500, 3000, 25, 10),
('Wireless Headphones', 'Electronics', 350, 200, 50, 15),
('Office Chair', 'Furniture', 850, 600, 8, 3),
('Coffee Table', 'Furniture', 650, 400, 5, 2),
('Wireless Mouse', 'Accessories', 80, 45, 100, 20),
('Mechanical Keyboard', 'Accessories', 220, 150, 30, 10),
('Smart Watch', 'Wearables', 750, 500, 12, 5);

-- إضافة طلبات
INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, '2025-02-01 10:30:00', 'delivered', 4850),
(2, '2025-02-03 14:15:00', 'delivered', 3500),
(3, '2025-02-05 09:45:00', 'delivered', 1070),
(1, '2025-02-10 11:20:00', 'processing', 350),
(4, '2025-02-12 16:30:00', 'shipped', 1500),
(5, '2025-02-15 13:10:00', 'pending', 850),
(2, '2025-02-18 12:00:00', 'delivered', 220),
(3, '2025-02-20 15:45:00', 'processing', 1600);

-- إضافة تفاصيل الطلبات
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 4500),
(1, 3, 1, 350),
(2, 2, 1, 3500),
(3, 3, 2, 350),
(3, 7, 1, 220),
(3, 6, 2, 80),
(4, 3, 1, 350),
(5, 8, 2, 750),
(6, 4, 1, 850),
(7, 7, 1, 220),
(8, 2, 1, 3500);
