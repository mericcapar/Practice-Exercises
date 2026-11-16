"""
Meric Capar
11/16/2026
Estimates income tax from gross income and number of dependents.
"""
TAX_RATE = 0.20
STANDARD_DEDUCTION = 10000
ADDITIONAL_DEDUCTION_PER_DEPENDENT = 2000

print("INCOME TAX CALCULATOR")
print('-' * 40)

gross_income = float(input("Enter your gross income: "))
number_of_dependents = int(input("Enter your dependents: "))

dependent_deductions = ADDITIONAL_DEDUCTION_PER_DEPENDENT * number_of_dependents
total_deductions = STANDARD_DEDUCTION + dependent_deductions
taxable_income = gross_income - total_deductions
estimated_tax = taxable_income * TAX_RATE

print("\nINCOME TAX SUMMARY")
print("-" * 40, end="\n\n")
print(f"{'Gross Income:':<28}{f'${gross_income:,.2f}':>12}")
print(f"{'Standard Deduction:':<28}{f'${STANDARD_DEDUCTION:,.2f}':>12}")
print(f"{'Dependent Deductions:':<28}{f'${dependent_deductions:,.2f}':>12}")
print(f"{'Total Deductions:':<28}{f'${total_deductions:,.2f}':>12}")
print(f"{'Taxable Income:':<28}{f'${taxable_income:,.2f}':>12}")
print(f"{'Tax Rate:':<28}{TAX_RATE:>12.0%}")
print(f"{'Estimated Income Tax:':<28}{f'${estimated_tax:,.2f}':>12}")

# 1. Gross income is stored as a float because income can include cents (for example, 75000.50).
# 2. The number of dependents is stored as an int because you can't have half a person.
# 3. The .2f format shows money with exactly two decimal places, so amounts stay clean and easy to read.