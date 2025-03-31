<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="GYM_MANAGEMENT.Registration" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Member Registration - Gym Management</title>
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
            background-color: transparent;
            border: 2px solid #3399ff;
        }

        .auth-links a.login:hover {
            background-color: #3399ff;
        }

        .auth-links a.signup {
            background-color: #3399ff;
        }

        .auth-links a.signup:hover {
            background-color: #2a7bc8;
        }

        /* ===== REGISTRATION FORM ===== */
        .registration-container {
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
            margin-bottom: 20px;
            color: white;
        }

        .login-link {
            text-align: center;
            margin-bottom: 20px;
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
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.9);
            font-size: 14px;
        }

        .name-group {
            display: flex;
            gap: 15px;
        }

        .terms-group {
            display: flex;
            align-items: center;
            margin: 20px 0;
        }

        .terms-group input {
            margin-right: 10px;
        }

        .terms-group label {
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

            .registration-container {
                margin: 20px;
                padding: 20px;
            }

            .name-group {
                flex-direction: column;
                gap: 0;
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
            <a href="SignUp.aspx" class="signup">Sign Up</a>
        </div>
    </div>

    <!-- Registration Form -->
    <div class="registration-container">
        <h1>MEMBER REGISTRATION</h1>
        <p class="login-link">Already have an account? <a href="login.aspx">Login</a></p>
        <asp:Label runat="server" ID="lblMessage"></asp:Label>
        
        <form id="registrationForm" runat="server">
            <div class="name-group">
                <div class="form-group">
                    <label for="txtFirstName">First Name</label>
                    <asp:TextBox ID="txtFirstName" runat="server" placeholder="First name" required="true" />
                </div>
                <div class="form-group">
                    <label for="txtLastName">Last Name</label>
                    <asp:TextBox ID="txtLastName" runat="server" placeholder="Last name" required="true" />
                </div>
            </div>

            <div class="form-group">
                <label for="txtEmail">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Email" required="true" />
            </div>

            <div class="form-group">
                <label for="txtPhone">Phone</label>
                <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone" required="true" />
            </div>
            <asp:RegularExpressionValidator ID="revEmail" runat="server"
    ControlToValidate="txtEmail"
    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    ErrorMessage="Invalid email format"
    ForeColor="Red"
    Display="Dynamic" />

<asp:RegularExpressionValidator ID="revPhone" runat="server"
    ControlToValidate="txtPhone"
    ValidationExpression="^[0-9]{10,15}$"
    ErrorMessage="Phone must be 10-15 digits"
    ForeColor="Red"
    Display="Dynamic" />
            <div class="form-group">
                <label for="ddlSubscriptionPlan">Subscription Plan</label>
                <asp:DropDownList ID="ddlSubscriptionPlan" runat="server" required="true">
                    <asp:ListItem Text="Select Plan" Value=""></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="terms-group">
                <asp:CheckBox ID="chkTerms" runat="server" required="true" />
                <label for="chkTerms">I agree with the Terms and Conditions and Privacy Policy</label>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn-primary" OnClick="btnRegister_Click" />
        </form>
    </div>
</body>
</html>