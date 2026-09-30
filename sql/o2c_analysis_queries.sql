-- Project: B2B Order-to-Cash (O2C) Analytics
-- Database: MySQL
-- Description: Core Analytical Queries for SLA & Cash Collection Analysis
-- ===================================================

USE o2c_project;

-- 1. Executive Summary & Revenue Baseline
SELECT 
    COUNT(order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(total_order_value), 2) AS total_revenue_inr,
    ROUND(AVG(total_order_value), 2) AS avg_order_value_inr
FROM cleaned_o2c_orders;

-- 2. Warehouse Dispatch Bottleneck & 36-Hr SLA Breach Rate
SELECT 
    warehouse_id,
    COUNT(order_id) AS total_orders_handled,
    ROUND(AVG(TIMESTAMPDIFF(HOUR, credit_approved_ts, dispatched_ts)), 1) AS avg_dispatch_hours,
    SUM(CASE WHEN TIMESTAMPDIFF(HOUR, credit_approved_ts, dispatched_ts) > 36 THEN 1 ELSE 0 END) AS sla_breached_orders,
    ROUND(SUM(CASE WHEN TIMESTAMPDIFF(HOUR, credit_approved_ts, dispatched_ts) > 36 THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS sla_breach_pct
FROM cleaned_o2c_orders
GROUP BY warehouse_id
ORDER BY sla_breach_pct DESC;

-- 3. Customer Tier Cash Collection Delay (DSO Impact)
SELECT 
    customer_tier,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_order_value), 2) AS tier_revenue_inr,
    ROUND(AVG(TIMESTAMPDIFF(DAY, delivered_ts, payment_collected_ts)), 1) AS avg_collection_days
FROM cleaned_o2c_orders
GROUP BY customer_tier
ORDER BY avg_collection_days DESC;

-- 4. End-to-End Turnaround Time (TAT Breakdown)
SELECT 
    ROUND(AVG(TIMESTAMPDIFF(DAY, order_placed_ts, payment_collected_ts)), 1) AS total_o2c_cycle_days,
    ROUND(AVG(TIMESTAMPDIFF(HOUR, order_placed_ts, credit_approved_ts)), 1) AS avg_credit_approval_hours,
    ROUND(AVG(TIMESTAMPDIFF(HOUR, credit_approved_ts, dispatched_ts)), 1) AS avg_fulfillment_hours,
    ROUND(AVG(TIMESTAMPDIFF(DAY, dispatched_ts, delivered_ts)), 1) AS avg_transit_days
FROM cleaned_o2c_orders;
