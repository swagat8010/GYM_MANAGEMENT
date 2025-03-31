<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Plans.aspx.cs" Inherits="GYM_MANAGEMENT.Plans" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Subscription Plans - Gym Management</title>
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

        /* Navbar */
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

        /* Plans Section */
        .plans-container {
            width: 80%;
            max-width: 1200px;
            text-align: center;
            margin: 100px auto 20px;
        }

        h1, h2 {
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .plans-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            justify-content: center;
        }

        .plan-card {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease-in-out;
            box-shadow: 0 5px 10px rgba(255, 255, 255, 0.3);
        }

        .plan-card:hover {
            transform: scale(1.05);
        }

        .plan-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #fff;
        }

        .plan-price {
            font-size: 18px;
            color: #ffcc00;
            margin-bottom: 10px;
        }

        .plan-duration {
            font-size: 16px;
            color: #ddd;
            margin-bottom: 10px;
        }

        .plan-description {
            font-size: 14px;
            color: #ccc;
            margin-bottom: 15px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 15px;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            position: absolute;
            bottom: 0;
            width: 100%;
        }

    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
     <!-- Logo and Gym Name -->
     <div class="logo"href="Home.aspx">
      <img src="images/LOGO.png" href="Home.aspx"/>
         <span >Body Boost Fitness Center</span>
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

    <!-- Plans Section -->
    <div class="plans-container">
        <h1>Choose Your Subscription Plan</h1>
        <div class="plans-grid">
            <asp:Repeater ID="rptPlans" runat="server">
                <ItemTemplate>
                    <div class="plan-card">
                        <h3 class="plan-title"><%# Eval("PlanName") %></h3>
                        <p class="plan-price">Price: ₹<%# Eval("Price") %></p>
                        <p class="plan-duration">Duration: <%# Eval("DurationMonths") %> Months</p>
                        <p class="plan-description"><%# Eval("Description") %></p>
                        <a href="SignUp.aspx?planID=<%# Eval("SubscriptionID") %>" class="btn">Subscribe Now</a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Gym Management. All Rights Reserved.</p>
    </div>

</body>
</html>
