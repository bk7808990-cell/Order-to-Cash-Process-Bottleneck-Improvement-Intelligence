# Order-to-Cash (O2C) Process Bottleneck Analysis

End-to-end operational analysis of 5,000 B2B electrical distribution orders to identify fulfillment bottlenecks, delivery SLA breaches, and working capital delays using **SQL, Python, Power BI, Jira, and Confluence**.

---

## 1. Project Snapshot & Problem Statement
* **Objective:** Diagnose cross-functional friction points across the 8-stage fulfillment pipeline and restore target delivery commitments.
* **Target Delivery SLA:** 40.0 Hours (RULE-03)
* **Current Baseline Performance:**
  * **SLA Compliance Rate:** 64.2% (Target: >= 85.0%)
  * **Average Cycle Time:** 43.8 Hours (Target: <= 40.0 Hours)
  * **Days Sales Outstanding (DSO):** 33.4 Days (Target: <= 30.0 Days)

---

## 2. 8-Stage AS-IS Workflow & Rules Mapping

* **Stage 1: Validation** --> RULE-05: Weekend staffing lag
* **Stage 2: Inventory Check** --> RULE-04: SKU shortages in Lighting & MCBs
* **Stage 3: Approval** --> RULE-01: High-value (>40k) queue (9.2h delay)
* **Stage 4: Invoicing** --> Automated system generation
* **Stage 5: Dispatch** --> **PRIMARY BOTTLENECK** (18.5h avg | 42% of cycle)
* **Stage 6: Delivery** --> RULE-03: 40-hour delivery SLA
* **Stage 7: Payment Due** --> Contractual credit terms applied
* **Stage 8: Cash Collection** --> RULE-02: Wholesalers (41.8d) vs Retailers (16.5d)

---

## 3. Key Analytical Findings
1. **Warehouse Dispatch is the Primary Bottleneck:**
   * Averages **18.5 hours**, accounting for **42%** of the entire fulfillment lead time.
   * Single-shift packing batches cause order pileups during peak operational windows.
2. **Top Drivers of Delivery SLA Breaches:**
   * **Warehouse Backlog:** 41% of all breached deliveries.
   * **Inventory Shortages:** 27% (concentrated in high-variety categories).
   * **Manual Approvals:** 18% (orders exceeding 40,000 threshold).
   * **Transit Delays:** 14% (remote zones).
3. **Cash Flow Variances:**
   * Wholesalers stretch payment cycles to **41.8 days** (near the 45-day limit).
   * Retailers settle faster with an average of **16.5 days**.

---

## 4. Strategic Recommendations & Projected Impact

| Initiative | Strategy | Projected Impact |
|:---|:---|:---|
| **Warehouse Shift Optimization** | Introduce staggered 2-shift packing and scheduled carrier pickup slots. | Reduces Dispatch from **18.5h to 12.0h**; improves SLA compliance by **+14.4%**. |
| **Automated Approval Workflows** | Auto-approve repeat orders for established Tier-1 clients up to 75,000. | Eliminates **9.2 hours** of administrative queue wait time. |
| **Targeted Safety Stock** | Implement dynamic safety stock buffers for top 20% high-frequency SKUs. | Reduces stockout-related order delays by **60%**. |
| **Dynamic Credit Terms** | Offer a 1.5% discount for invoices settled within 15 days. | Lowers Wholesaler DSO to **28 days**, freeing up operating liquidity. |

---

## 5. Repository Structure
* `data/` : Raw and cleaned order datasets
* `sql/` : Data cleaning, SLA calculations, and KPI queries
* `notebooks/` : Exploratory data analysis (EDA) in Python
* `dashboard/` : Power BI reporting model (.pbix)
* `README.md` : Executive summary and portfolio documentation

---

## 6. Live Project Workspaces
* 🔗 **Confluence Space:** [Order-to-Cash Technical Documentation](https://bk7808990.atlassian.net/wiki/spaces/OPI/overview)
* 🔗 **Jira Project:** [OTC Sprint & Delivery Board](https://bk7808990.atlassian.net/jira/software/projects/OTC/boards/199)
