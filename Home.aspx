<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="GYM_MANAGEMENT.Home" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gym Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: url('images/Background.jpg') no-repeat center center/cover;
            height: 100vh;
            color: white;
            position: relative;
        }

            /* Background overlay */
            body::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                z-index: -1;
            }

        /* Navigation Bar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(0, 0, 0, 0.8);
            padding: 10px 20px;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        /* Logo Section */
        .logo {
            display: flex;
            align-items: center;
            gap: 10px; /* Adds space between logo and text */
            white-space: nowrap; /* Prevents wrapping */
        }

            .logo img {
                height: 50px;
                width: auto;
            }

            .logo span {
                font-size: 15px;
                font-weight: bold;
                color: white;
            }

        /* Navigation Links */
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 16px;
            font-weight: bold;
        }

            .navbar a:hover {
                background-color: rgba(255, 255, 255, 0.2);
                border-radius: 5px;
            }

        .auth-links {
            display: flex;
            align-items: center;
        }

        /* Dropdown Menu */
        .signup-dropdown {
            position: relative;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: rgba(0, 0, 0, 0.9);
            min-width: 130px;
            box-shadow: 0px 4px 8px rgba(255, 255, 255, 0.2);
            border-radius: 5px;
            text-align: center;
        }

            .dropdown-content a {
                display: block;
                padding: 10px;
            }

        .signup-dropdown:hover .dropdown-content {
            display: block;
        }

        /* Welcome Section */
        .welcome {
            text-align: center;
            padding: 120px 20px;
        }

            .welcome h1 {
                font-size: 40px;
                text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7);
            }

            .welcome p {
                font-size: 18px;
                max-width: 600px;
                margin: 10px auto;
                text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7);
            }

        /* Services Section */
        .services {
            text-align: center;
            padding: 60px 20px;
            background: rgba(0, 0, 0, 0.8);
        }

            .services h2 {
                font-size: 26px;
                margin-bottom: 20px;
            }

        .services-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .service-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 20px;
            width: 250px;
            text-align: center;
            box-shadow: 0px 4px 8px rgba(255, 255, 255, 0.2);
        }

            .service-card h3 {
                margin-bottom: 10px;
            }

        /* Footer */
        footer {
            text-align: center;
            padding: 15px;
            background: rgba(0, 0, 0, 0.8);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                text-align: center;
            }

            .logo img {
                height: 40px; /* Adjust size for small screens */
            }

            .logo span {
                font-size: 12px; /* Reduce font size */
            }

            .links a {
                display: block;
                margin: 5px 0;
            }

            .services-container {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <form runat="server">

        <!-- Navigation Bar -->
        <div class="navbar">
            <!-- Logo and Gym Name -->
            <div class="logo" href="Home.aspx">
                <img src="images/LOGO.png" href="Home.aspx" />
                <span>Body Boost Fitness Center</span>
            </div>

            <div class="links">
                <a href="Home.aspx">Home</a>
                <a href="Services.aspx">Services</a>
                <a href="Plans.aspx">Plans</a>
                <a href="Classes.aspx">Classes</a>
                <a href="AboutUs.aspx">About Us</a>

            </div>

            <div class="auth-links">
                <a href="login.aspx">Login</a>
                <div class="signup-dropdown">
                    <a href="#" id="signup">Sign Up ▾</a>
                    <div class="dropdown-content">
                        <a href="SignUp.aspx?role=member">Member</a>
                        <a href="TrainerSignUp.aspx?role=trainer">Trainer</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Welcome Section -->
        <div class="welcome">
            <h1>Welcome to Body Boost Fitness Center</h1>
            <p>Your fitness journey starts here. Explore our services and start your transformation today!</p>
        </div>

        <!-- Services Section -->
        <div class="services" id="services">
            <h2>Our Services</h2>
            <div class="services-container">
                <div class="service-card">
                    <h3>Personal Training</h3>
                    <p>Get one-on-one sessions with expert trainers.</p>
                </div>
                <div class="service-card">
                    <h3>Group Workouts</h3>
                    <p>Join fun and energetic group fitness classes.</p>
                </div>
                <div class="service-card">
                    <h3>Nutrition Plans</h3>
                    <p>Customized diet plans to reach your fitness goals. Many More...</p>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer>
            <p>Contact us at: 123-456-7890 | email@example.com</p>
            <p>&copy; 2025 Gym Management System. All Rights Reserved.</p>
        </footer>

    </form>
</body>
</html>
