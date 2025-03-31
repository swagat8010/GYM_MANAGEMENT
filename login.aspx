<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="GYM_MANAGEMENT.login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Gym Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: url('images/Background.jpg') no-repeat center center/cover;
            color: white;
            min-height: 100vh;
            position: relative;
            padding-top: 70px; /* Space for fixed navbar */
        }

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

        /* ===== NAVBAR ===== */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(to right, #1a1a1a, #2a2a2a);
            padding: 0 30px;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            height: 70px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
            text-decoration: none;
        }

        .logo img {
            height: 50px;
            transition: transform 0.3s;
        }

        .logo:hover img {
            transform: scale(1.05);
        }

        .logo span {
            font-size: 18px;
            font-weight: bold;
            color: white;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .nav-links {
            display: flex;
            gap: 5px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 5px;
            transition: all 0.3s;
            font-size: 15px;
        }

        .nav-links a:hover, .nav-links a.active {
            background-color: #3399ff;
            color: white;
        }

        .auth-links {
            display: flex;
            gap: 5px;
        }

        .auth-links a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .auth-links a.login {
            background-color: #3399ff;
        }

        .auth-links a.signup {
            background-color: transparent;
            border: 2px solid #3399ff;
        }

        .auth-links a.signup:hover {
            background-color: #3399ff;
        }

        /* ===== LOGIN FORM ===== */
        .login-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            width: 100%;
            max-width: 450px;
            padding: 30px;
            margin: 30px auto;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        h1 {
            font-size: 24px;
            text-align: center;
            margin-bottom: 10px;
            color: white;
        }

        h2 {
            font-size: 22px;
            text-align: center;
            margin-bottom: 20px;
        }

        .signup-link {
            text-align: center;
            margin-bottom: 20px;
        }

        .signup-link a {
            color: #3399ff;
            text-decoration: none;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.9);
            font-size: 14px;
        }

        .btn-primary {
            width: 100%;
            padding: 12px;
            background-color: #3399ff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #2a7bc8;
        }

        #lblMessage {
            display: block;
            text-align: center;
            margin: 15px 0;
            color: #ff6b6b;
            font-size: 14px;
        }

        .footer {
            margin-top: 20px;
            font-size: 12px;
            color: rgba(255, 255, 255, 0.7);
            text-align: center;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                padding: 0 15px;
                flex-direction: column;
                height: auto;
                padding: 10px;
            }

            .nav-links, .auth-links {
                margin-top: 10px;
                flex-wrap: wrap;
                justify-content: center;
            }

            .login-container {
                margin: 20px;
                padding: 20px;
            }
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
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <a href="Home.aspx" class="logo">
            <img src="images/LOGO.png" alt="Gym Logo" />
            <span>Body Boost Fitness Center</span>
        </a>

        <div class="nav-links">
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

    <!-- Login Form -->
    <div class="login-container">
        <h1>GYM MANAGEMENT SYSTEM</h1>
        <h2>Login</h2>
        <p class="signup-link">New User? <a href="SignUp.aspx">Sign Up</a></p>
        <asp:Label runat="server" ID="lblMessage"></asp:Label>
        
        <form id="loginForm" runat="server">
            <div class="form-group">
                <label for="txtUsername">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter your username" required="true" />
            </div>
            
            <div class="form-group">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password" required="true" />
            </div>
            
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-primary" OnClick="btnLogin_Click1" />
        </form>
        
        <div class="footer">
            <p>&copy; 2025 Gym Management. All Rights Reserved.</p>
        </div>
    </div>
</body>
</html>