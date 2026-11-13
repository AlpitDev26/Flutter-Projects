document.addEventListener('DOMContentLoaded', () => {
    const splash = document.getElementById('splash-screen');
    const home = document.getElementById('home-screen');
    const login = document.getElementById('login-screen');
    
    // 1. Splash to Home transition (3 seconds)
    setTimeout(() => {
        splash.classList.add('hidden');
        home.classList.remove('hidden');
    }, 3000);

    // 2. Home to Login Navigation
    document.getElementById('get-started-btn').addEventListener('click', () => {
        home.classList.add('hidden');
        login.classList.remove('hidden');
    });

    // 3. Login Logic
    const loginForm = document.getElementById('login-form');
    const nameInput = document.getElementById('name');
    const emailInput = document.getElementById('email');

    // Clear Form
    document.getElementById('clear-btn').addEventListener('click', () => {
        loginForm.reset();
        document.querySelectorAll('.error-msg').forEach(el => el.innerText = '');
    });

    // Form Validation (Flutter logic replica)
    loginForm.addEventListener('submit', (e) => {
        e.preventDefault();
        let isValid = true;

        // Name Validation
        if (nameInput.value.length < 3) {
            document.getElementById('name-error').innerText = "Name must be at least 3 characters.";
            isValid = false;
        } else {
            document.getElementById('name-error').innerText = "";
        }

        // Email Validation
        const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
        if (!emailRegex.test(emailInput.value)) {
            document.getElementById('email-error').innerText = "Please enter a valid email";
            isValid = false;
        } else {
            document.getElementById('email-error').innerText = "";
        }

        if (isValid) {
            alert('Login Successful!');
        }
    });
});