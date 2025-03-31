<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="GYM_MANAGEMENT.SignUp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Gym Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: url('images/Signup.jpg') no-repeat center center/cover;
            min-height: 100vh;
            position: relative;
            color: white;
            padding-top: 70px; /* Space for fixed navbar */
        }

        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
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
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            padding: 20px;
            max-width: 450px;
            width: 100%;
            margin: 2px auto;
            text-align: center;
            backdrop-filter: blur(10px);
        }

        h1 {
            font-size: 26px;
          margin-top:0px;
            color: white;
        }

        h2 {
            font-size: 22px;
            margin-bottom: 10px;
            color: white;
        }

        .login-link {
            margin-bottom: 20px;
        }

        .login-link a {
            color: #3399ff;
            text-decoration: none;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 18px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 5px;
            color: white;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.9);
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            box-shadow: 0 0 8px rgba(255, 255, 255, 0.5);
        }

        .btn-primary {
            width: 100%;
            padding: 14px;
            background-color: #3399ff;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #2a7bc8;
        }

        #lbldenger {
            display: block;
            text-align: center;
            margin: 15px 0;
            color: #ff6b6b;
            font-size: 14px;
        }

        .footer {
            margin-top: 20px;
            font-size: 14px;
            color: rgba(255, 255, 255, 0.7);
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
        
        <h2>Sign Up</h2>
        <p class="login-link">Already have an account? <a href="login.aspx">Log In</a></p>
        <asp:Label runat="server" ID="lbldenger"></asp:Label>
        
        <form id="signupForm" runat="server">
            <div class="form-group">
                <label for="txtUsername">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter your username" required="true" />
            </div>
            
            <div class="form-group">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password" required="true"  />
            </div>
            
            <div class="form-group">
                <label for="txtConfirmPassword">Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm your password" required="true" />
                <asp:CompareValidator ID="cvPassword" runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtPassword"
                    Operator="Equal"
                    Type="String"
                    ErrorMessage="Passwords do not match!"
                    ForeColor="Red" />
            </div>
            
            <div class="form-group">
                <label for="ddlRole">Select Role</label>
                <asp:DropDownList ID="ddlRole" runat="server">
                    <asp:ListItem Value="Member">Member</asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" CssClass="btn-primary" OnClick="btnSignUp_Click1" />
        </form>
        
        <div class="footer">
            <p>&copy; 2025 Gym Management. All Rights Reserved.</p>
        </div>
    </div>
</body>
</html>