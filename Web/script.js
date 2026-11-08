// SpendWise - Expense Tracker Logic
let totalExpense = 0;

function addExpense(amount, category) {
  totalExpense += amount;
  console.log(`Added ${category}: Rs.${amount}`);
  console.log(`Total Expense: Rs.${totalExpense}`);
  updateDisplay();
}

function updateDisplay() {
  const totalElement = document.getElementById('total');
  if (totalElement) {
    totalElement.textContent = `Total: Rs.${totalExpense}`;
  }
}

function showWelcome() {
  alert("Welcome to SpendWise!");
  console.log("SpendWise App Started!");
}

// Example expenses
addExpense(100, "Food");
addExpense(50, "Travel");

showWelcome();
