<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="GYM_MANAGEMENT.AboutUs" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Gym Management</title>
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

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            white-space: nowrap;
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

        .navbar .links {
            display: flex;
            gap: 15px;
        }

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

        /* Sign Up Dropdown */
        .auth-links {
            display: flex;
            align-items: center;
            position: relative;
        }

        .signup-dropdown {
            position: relative;
            display: inline-block;
        }

        .signup-dropdown a {
            cursor: pointer;
            padding: 10px 16px;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background: rgba(0, 0, 0, 0.9);
            min-width: 150px;
            right: 0;
            border-radius: 5px;
            z-index: 1000;
        }

        .dropdown-content a {
            padding: 10px;
            display: block;
            color: white;
            text-decoration: none;
        }

        .dropdown-content a:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .signup-dropdown:hover .dropdown-content {
            display: block;
        }

        /* Content Section */
        .about-container {
            width: 80%;
            max-width: 1200px;
            text-align: center;
            margin: 100px auto 20px;
        }

        h1, h2 {
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #ffcc00;
        }

        p {
            font-size: 18px;
            line-height: 1.6;
            color: white;
        }

        .trainers-grid {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .trainer-card {
            background: rgba(255, 255, 255, 0.2);
            padding: 15px;
            border-radius: 10px;
            width: 200px;
            text-align: center;
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
        <div class="logo">
            <img src="images/LOGO.png" alt="Gym Logo"/>
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
                <a id="signup">Sign Up ▾</a>
                <div class="dropdown-content">
                    <a href="SignUp.aspx?role=member">Member</a>
                    <a href="TrainerSignUp.aspx?role=trainer">Trainer</a>
                </div>
            </div>
        </div>
    </div>

    <!-- About Section -->
    <div class="about-container">
        <h1>About Us</h1>
        <p>Welcome to <b>Body Boost Fitness Center</b>, where your fitness journey begins! We are dedicated to helping individuals lead a healthier and stronger life through expert training, modern facilities, and personalized programs.</p>

        <h2>Our Mission</h2>
        <p>We strive to empower people by providing top-notch training, state-of-the-art equipment, and a supportive community. Whether you're a beginner or an advanced athlete, we ensure you get the best fitness experience.</p>

        <h2>Why Choose Us?</h2>
        <p>✔ Certified Trainers | ✔ Modern Equipment | ✔ Personalized Plans | ✔ Friendly Atmosphere</p>

        <h2>Meet Our Trainers</h2>
        <div class="trainers-grid">
            <div class="trainer-card">
                <h3>Mike Tyson</h3>
                <p>Boxing & Strength Coach</p>
            </div>
            <div class="trainer-card">
                <h3>Jane Smith</h3>
                <p>Zumba & Dance Instructor</p>
            </div>
            <div class="trainer-card">
                <h3>Chris Hemsworth</h3>
                <p>CrossFit & Strength Training</p>
            </div>
        </div>

        <h2>Contact Us</h2>
        <p>📞 Call: +91 98765 43210 | 📧 Email: info@bodyboostgym.com</p>
        <p>📍 Location: 123, Fitness Street, New Delhi, India</p>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Body Boost Fitness Center. All Rights Reserved.</p>
    </div>

</body>
</html>
