import pandas as pd

# ---------------------------------------------------------
# 1. Load the Dataset
# ---------------------------------------------------------
df = pd.read_csv('data/cleaned_o2c_orders.csv')

# ---------------------------------------------------------
# 2. Executive KPIs Baseline
# Target Delivery SLA: 40.0 Hours
# ---------------------------------------------------------
avg_cycle_time = df['cycle_time_hours'].mean()
sla_compliance_rate = (df['cycle_time_hours'] <= 40.0).mean() * 100
avg_dso = df['dso_days'].mean()

print("--- Overall Baseline KPIs ---")
print(f"Average Cycle Time  : {round(avg_cycle_time, 1)} Hours")
print(f"SLA Compliance Rate : {round(sla_compliance_rate, 1)}%")
print(f"Average DSO         : {round(avg_dso, 1)} Days")

# ---------------------------------------------------------
# 3. Stage Bottleneck Analysis (Find highest delay)
# Primary bottleneck target: Warehouse Dispatch (~18.5h)
# ---------------------------------------------------------
stage_analysis = df.groupby('stage_name')['stage_duration_hours'].mean().reset_index()
stage_analysis = stage_analysis.sort_values(by='stage_duration_hours', ascending=False)

print("\n--- Average Duration by Stage ---")
print(stage_analysis)

# ---------------------------------------------------------
# 4. DSO by Customer Segment (RULE-02)
# Wholesalers (41.8d) vs Retailers (16.5d)
# ---------------------------------------------------------
dso_by_segment = df.groupby('customer_segment')['dso_days'].mean().reset_index()

print("\n--- DSO by Customer Segment ---")
print(dso_by_segment)
