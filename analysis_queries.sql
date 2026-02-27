-- =====================================================
-- تحليل البيانات
-- Data Analysis Queries
-- =====================================================

-- 1. إجمالي المبيعات الشهرية
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value
FROM orders
WHERE status != 'cancelled'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month DESC;

-- 2. أفضل 5 منتجات مبيعاً
SELECT 
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 5;

-- 3. أكثر العملاء إنفاقاً
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    COUNT(DISTINCT o.order_id) AS orders_count,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'delivered'
GROUP BY c.customer_id, customer_name, c.city
ORDER BY total_spent DESC;

-- 4. المنتجات الأقل من مستوى إعادة الطلب
SELECT 
    product_name,
    category,
    stock_quantity,
    reorder_level,
    (reorder_level - stock_quantity) AS need_to_order
FROM products
WHERE stock_quantity <= reorder_level
ORDER BY need_to_order DESC;

-- 5. تحليل المبيعات حسب المدينة
SELECT 
    c.city,
    COUNT(DISTINCT c.customer_id) AS customers_count,
    COUNT(DISTINCT o.order_id) AS orders_count,
    SUM(o.total_amount) AS total_revenue,
    AVG(o.total_amount) AS avg_order_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- 6. نسبة نجاح الطلبات
SELECT 
    status,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS percentage
FROM orders
GROUP BY status;

-- 7. متوسط قيمة الطلب حسب الشهر
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(*) AS orders,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    ROUND(MAX(total_amount), 2) AS max_order_value,
    ROUND(MIN(total_amount), 2) AS min_order_value
FROM orders
GROUP BY month
ORDER BY month;

-- 8. العملاء الجدد vs العملاء المتكررين
SELECT 
    CASE 
        WHEN orders_count = 1 THEN 'New Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count,
    AVG(total_spent) AS avg_spent
FROM (
    SELECT 
        c.customer_id,
        COUNT(o.order_id) AS orders_count,
        COALESCE(SUM(o.total_amount), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
) AS customer_stats
GROUP BY customer_type;

-- 9. تحليل ربحية المنتجات
SELECT 
    product_name,
    category,
    price,
    cost,
    (price - cost) AS profit_per_unit,
    ROUND((price - cost) * 100.0 / price, 2) AS profit_margin_percent
FROM products
ORDER BY profit_margin_percent DESC;

-- 10. تقرير المخزون
SELECT 
    category,
    COUNT(*) AS products_count,
    SUM(stock_quantity) AS total_stock,
    SUM(CASE WHEN stock_quantity <= reorder_level THEN 1 ELSE 0 END) AS products_needing_reorder
FROM products
GROUP BY category;
