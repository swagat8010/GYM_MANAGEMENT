<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="GYM_MANAGEMENT.EditProfile" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <style>
        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            font-size: 12px;
            margin: 0;
            background-color: #202020;
            color: #ffffff;
        }

        /* Navigation Bar */
        .navbar {
            display: flex;
            justify-content: space-between;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 10px 20px;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
        }

        .navbar a:hover {
            background-color: #f4a261;
            border-radius: 5px;
        }

        /* Profile Section */
        .profile-container {
            background-color: rgba(0, 0, 0, 0.5);
            margin: 50px auto;
            padding: 40px;
            border-radius: 10px;
            width: 400px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.3);
        }

        .profile-container h2 {
            text-align: center;
            color: #f4a261;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-weight: bold;
            color: #f4a261;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            font-size: 14px;
            margin: 5px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .form-group input:focus {
            border-color: #f4a261;
        }

        .btn {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #f4a261;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #e76f51;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: rgba(0, 0, 0, 0.8);
            font-size: 12px;
            margin-top: 20px;
        }
      
    </style>
</head>
<body>

<form runat="server">
    <!-- Navigation Bar -->
    <div class="navbar">
        <div class="links">
            <a href="Home.aspx">Home</a>
            <a href="#services">Services</a>
            <a href="#about">About Us</a>
            <a href="#contact">Contact</a>
        </div>
        <div class="auth-links">
            <a href="login.aspx">Login</a>
            <a href="SignUp.aspx">Sign Up</a>
        </div>
    </div>

    <!-- Profile Edit Section -->
    <div class="profile-container">
        <h2>Edit Profile</h2>

        <div class="form-group">
            <label for="txtUsername">Username</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-group" ReadOnly="true"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <label for="txtName">Name</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-group"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="txtEmail">Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-group"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="txtPhone">Phone</label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-group"></asp:TextBox>
        </div>

       

       <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn" OnClick="btnSaveChanges_Click1"
     />

    </div>

    <!-- Footer Section -->
    <footer>
        <p>Contact us at: 123-456-7890 | email@example.com</p>
        <p>&copy; 2025 Gym Management System. All Rights Reserved.</p>
    </footer>
</form>

</body>
</html>
