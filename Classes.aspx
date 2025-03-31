<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Classes.aspx.cs" Inherits="GYM_MANAGEMENT.Classes" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classes - Gym Management</title>
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

        .classes-container {
            width: 80%;
            max-width: 1200px;
            text-align: center;
            margin: 100px auto 20px;
        }

        .classes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .class-card {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 10px rgba(255, 255, 255, 0.3);
            transition: transform 0.3s ease-in-out;
        }

            .class-card:hover {
                transform: scale(1.05);
            }

        .footer {
            text-align: center;
            padding: 15px;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            position: absolute;
            bottom: 0;
            width: 100%;
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
    <a href="login.aspx">Login</a><br />
    <div class="signup-dropdown">
        <a href="#" id="signup">Sign Up ▾</a>
        <div class="dropdown-content">
            <a href="SignUp.aspx?role=member">Member</a>
            <a href="TrainerSignUp.aspx?role=trainer">Trainer</a>
        </div>
    </div>
</div>
    </div>
    <div class="classes-container">
        <h1>Our Gym Classes</h1>
        <div class="classes-grid">
            <asp:Repeater ID="rptClasses" runat="server">
                <ItemTemplate>
                    <div class="class-card">
                        <h3 class="class-title"><%# Eval("ClassName") %></h3>
                        <p class="class-instructor"><strong>Instructor:</strong> <%# Eval("Instructor") %></p>
                        <p class="class-trainer"><strong>Trainer:</strong> <%# Eval("Trainer") %></p>
                        <p class="class-time"><strong>Time:</strong> <%# Eval("ClassTime", "{0:hh:mm tt}") %></p>
                        <p class="class-schedule"><strong>Schedule:</strong> <%# Eval("Schedule") %></p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2025 Gym Management. All Rights Reserved.</p>
    </div>

</body>
</html>
