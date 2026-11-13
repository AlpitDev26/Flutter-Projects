// Email validation regex pattern
const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;

// Clear form function
function clearForm() {
    document.getElementById('nameInput').value = '';
    document.getElementById('emailInput').value = '';
    document.getElementById('nameError').textContent = '';
    document.getElementById('emailError').textContent = '';
}

// Validate name
function validateName(name) {
    if (name === null || name.trim() === '') {
        return "Please Enter your name";
    }
    if (name.length < 3) {
        return "Name must be atleast 3 characters.";
    }
    return '';
}

// Validate email
function validateEmail(email) {
    if (email === null || email.trim() === '') {
        return "Please Enter your email";
    }
    if (!emailRegex.test(email)) {
        return "Please Enter a valid email";
    }
    return '';
}

// Handle form submission
document.getElementById('loginForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const nameInput = document.getElementById('nameInput').value;
    const emailInput = document.getElementById('emailInput').value;
    
    // Validate and display errors
    const nameError = validateName(nameInput);
    const emailError = validateEmail(emailInput);
    
    document.getElementById('nameError').textContent = nameError;
    document.getElementById('emailError').textContent = emailError;
    
    // If no errors, proceed with login
    if (!nameError && !emailError) {
        console.log('Form submitted with:', { name: nameInput, email: emailInput });
        // Add your login logic here
        // Example: window.location.href = '../dashboard.html';
        alert('Login successful! Name: ' + nameInput + ', Email: ' + emailInput);
    }
});

// Real-time validation on blur
document.getElementById('nameInput').addEventListener('blur', function() {
    const error = validateName(this.value);
    document.getElementById('nameError').textContent = error;
});

document.getElementById('emailInput').addEventListener('blur', function() {
    const error = validateEmail(this.value);
    document.getElementById('emailError').textContent = error;
});
