<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrainerSignup.aspx.cs" Inherits="GYM_MANAGEMENT.TrainerSignup" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trainer Sign-Up - Gym Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            min-height: 100vh;
            position: relative;
            padding-top: 70px; /* Space for fixed navbar */
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
            align-items: center;
            gap: 5px;
        }

        .auth-links a.login {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 5px;
            transition: all 0.3s;
            background-color: transparent;
            border: 2px solid #3399ff;
        }

        .auth-links a.login:hover {
            background-color: #3399ff;
        }

        /* Dropdown Menu */
        .signup-dropdown {
            position: relative;
            display: inline-block;
        }

        .signup-dropdown > a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 5px;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 5px;
            background-color: #3399ff;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: rgba(0, 0, 0, 0.9);
            min-width: 160px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
            z-index: 1;
        }

        .dropdown-content a {
            color: white;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s;
        }

        .dropdown-content a:hover {
            background-color: #3399ff;
            border-radius: 5px;
        }

        .signup-dropdown:hover .dropdown-content {
            display: block;
        }

        /* ===== SIGNUP FORM ===== */
        .signup-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            padding: 30px;
            margin: 30px auto;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
            text-align: center;
            text-transform: uppercase;
        }

        .login-link {
            text-align: center;
            margin-bottom: 20px;
            color: #666;
            font-size: 14px;
        }

        .login-link a {
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
            color: #333;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            border-color: #3399ff;
            outline: none;
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
            margin-top: 10px;
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
            color: #999;
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

            .signup-container {
                margin: 20px;
                padding: 20px;
            }
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
            <a href="login.aspx" class="login">Login</a>
            <div class="signup-dropdown">
                <a href="#">Sign Up ▾</a>
                <div class="dropdown-content">
                    <a href="SignUp.aspx?role=member">Member</a>
                    <a href="TrainerSignUp.aspx?role=trainer">Trainer</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Signup Form -->
    <div class="signup-container">
        <h1>FITNESS TRAINER</h1>
        <p class="login-link">Already a member? <a href="Login.aspx">Login</a></p>
        <asp:Label runat="server" ID="lblMessage"></asp:Label>
        
        <form id="signupForm" runat="server">
            <div class="form-group">
                <label for="txtName">Full Name</label>
                <asp:TextBox ID="txtName" runat="server" placeholder="Full name" required="true" />
            </div>
            
            <div class="form-group">
                <label for="txtEmail">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Email" required="true" />
            </div>
            
            <div class="form-group">
                <label for="txtPhone">Phone</label>
                <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone" required="true" />
            </div>
            
            <div class="form-group">
                <label for="txtSpecialization">Specialization</label>
                <asp:TextBox ID="txtSpecialization" runat="server" placeholder="Specialization" required="true" />
            </div>
            
            <div class="form-group">
                <label for="txtUsername">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" required="true" />
            </div>
            
            <div class="form-group">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" required="true" />
            </div>
            
            <asp:Button ID="btnSignup" runat="server" Text="Sign Up" CssClass="btn-primary" OnClick="btnSignup_Click" />
        </form>
        
        <div class="footer">
            <p>&copy; 2025 Gym Management</p>
        </div>
    </div>
</body>
</html>