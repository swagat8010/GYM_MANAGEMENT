<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Services.aspx.cs" Inherits="GYM_MANAGEMENT.Services" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Services | Gym Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            scroll-behavior: smooth;
        }

        body {
            font-family: Arial, sans-serif;
            background: url('images/Background.jpg') no-repeat center center/cover;
            min-height: 100vh;
            color: white;
            position: relative;
            display: flex;
            flex-direction: column;
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
        }

        .logo img {
            height: 50px;
            width: auto;
        }

        .logo span {
            font-size: 18px;
            font-weight: bold;
            color: white;
            white-space: nowrap;
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

        .services-section {
            text-align: center;
            padding: 120px 20px;
            flex-grow: 1;
        }

        .services-section h1 {
            font-size: 40px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7);
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
            transition: transform 0.3s ease-in-out;
        }

        .service-card:hover {
            transform: scale(1.05);
        }

        .service-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
        }

        .service-card h3 {
            margin: 10px 0;
        }

        footer {
            text-align: center;
            padding: 15px;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            position: relative;
            bottom: 0;
            width: 100%;
        }
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
 
        .auth-links {
            display: flex;
            align-items: center;
        }

    </style>
</head>
<body>
    <form runat="server">
    
    <div class="navbar">
        <div class="logo">
            <img src="images/LOGO.png" alt="Gym Logo" />
            <span>Body Boost Fitness Center</span>
        </div>

       
        <div class="links">
            <a href="Home.aspx">Home</a>
            <a href="Services.aspx">Services</a>
            <a href="Plans.aspx">Plans</a>
            <a href="Classes.aspx.aspx">Classes</a>
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

    <div class="services-section">
        <h1>Our Services</h1>
        <div class="services-container">
            <div class="service-card">
            <img src="images/personal%20trainner.jpg"alt="Personal Training" />
                <h3>Personal Training</h3>
                <p>Get one-on-one sessions with expert trainers.</p>
            </div>
            <div class="service-card">
              <img src="images/GroupWorkout.jpg" alt="Group Workouts" />
                <h3>Group Workouts</h3>
                <p>Join fun and energetic group fitness classes.</p>
            </div>
            <div class="service-card">
               <img src="images/nutrition.jpg" alt="Nutrition Plans" />
                <h3>Nutrition Plans</h3>
                <p>Customized diet plans to reach your fitness goals.</p>
            </div>
            <div class="service-card">
              <img src="images/Cordio.jpg"alt="Cardio Programs"  />
                <h3>Cardio Programs</h3>
                <p>Boost endurance with tailored cardio workouts.</p>
            </div>
            <div class="service-card">
            <img src="images/weight.jpg"alt="Weight Training" />
                <h3>Weight Training</h3>
                <p>Strength-building exercises for all levels.</p>
            </div>
            <div class="service-card">
                <img src="images/yoga.jpg" alt="Yoga & Meditation" />
                <h3>Yoga & Meditation</h3>
                <p>Relax and strengthen your body with yoga.</p>
            </div>
        </div>
    </div>

    <footer>
        <p>Contact us at: 123-456-7890 | email@example.com</p>
        <p>&copy; 2025 Gym Management System. All Rights Reserved.</p>
    </footer>
    
    </form>
</body>
</html>
