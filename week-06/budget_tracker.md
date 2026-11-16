# FinTrack — Personal Budget Tracker
**Course:** Data Analytics  
**Date:** 11/16/2026

This notebook collects monthly income and expenses, then
produces a formatted budget summary — no libraries required.

## Section 1: Analyst information
Enter your name and the month being analysed when prompted.


```python
analyst = input("Analyst name: ")
month = input("Budget month: ")
```

    Analyst name:  Meric
    Budget month:  Nov 2026
    

## Section 2: Monthly income and expenses
Enter each dollar amount when prompted. Values are cast to float
so arithmetic works correctly — no libraries needed.


```python
income = float(input("Monthly income $: "))
rent = float(input("Rent / housing $: "))
food = float(input("Food / groceries $: "))
transport = float(input("Transport $: "))
utilities = float(input("Utilities $: "))
```

    Monthly income $:  3500
    Rent / housing $:  1000
    Food / groceries $:  800
    Transport $:  220
    Utilities $:  200
    

## Section 3: Budget calculations
Total expenses, remaining budget, and savings rate are computed
using plain Python arithmetic — no import statements required.


```python
total_expenses = rent + food + transport + utilities
remaining = income - total_expenses
savings_rate = (remaining / income) * 100
```

## Section 4: Budget summary report
The report below is generated using Python f-strings.


```python
print(f"""
====== FinTrack Budget Report ======
Analyst : {analyst}
Month : {month}
------------------------------------
Income : ${income:,.2f}
Rent/Housing : ${rent:,.2f}
Food/Groceries : ${food:,.2f}
Transport : ${transport:,.2f}
Utilities : ${utilities:,.2f}
------------------------------------
Total expenses : ${total_expenses:,.2f}
Remaining : ${remaining:,.2f}
Savings rate : {savings_rate:.1f}%
====================================
""")
```

    
    ====== FinTrack Budget Report ======
    Analyst : Meric
    Month : Nov 2026
    ------------------------------------
    Income : $3,500.00
    Rent/Housing : $1,000.00
    Food/Groceries : $800.00
    Transport : $220.00
    Utilities : $200.00
    ------------------------------------
    Total expenses : $2,220.00
    Remaining : $1,280.00
    Savings rate : 36.6%
    ====================================
    
    
