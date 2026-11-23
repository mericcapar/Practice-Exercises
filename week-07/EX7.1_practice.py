import numpy as np
sales = np.array([
    [[1200,1500,1800],   #Store 1, Month 1
     [2000,2200,2500]],  #Store 1, Month 2
      
    [[1400,1600,1900],  #Store 2, Month 1
     [2100,2300,2600]]  #Store 2, Month 2
])

#Task 2

print("SALES ARRAY")
print(sales)

#Task 3

print("\nALL SALES (np.nditer)")
for amount in np.nditer(sales):
    print(amount)

#Task 4

print("\nSALES BY STORE AND MONTH")
for store in range(sales.shape[0]):
    for month in range(sales.shape[1]):
        for record in range(sales.shape[2]):
            amount = sales[store,month,record]
            print(f"Store {store+1}, Month {month+1}, Record {record+1}: ${amount}")

#Task 5
total = 0
for amount in np.nditer(sales):
    total += amount
print(f"\nTotal Sales: ${total:,}")

#Task 6

count = 0
for amount in np.nditer(sales):
    count +=1
average = total/count
print(f"Number of records: {count}")
print(f"Average sales: ${average:,.2f}")

# Task 7

highest = sales[0,0,0]
for amount in np.nditer(sales):
    if amount > highest:
        highest = amount

print(f"Highest Amount: ${highest:,}")