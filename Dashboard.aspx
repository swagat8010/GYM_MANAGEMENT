<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="GYM_MANAGEMENT.Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Member Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        /* Sidebar */
        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #343a40;
            padding-top: 20px;
            position: fixed;
        }
        .sidebar a {
            padding: 12px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .content {
            margin-left: 270px;
            padding: 20px;
        }
        .card {
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            padding: 10px 15px;
            font-size: 16px;
            border-radius: 5px;
            text-align: center;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-success {
            background-color: #28a745;
            border: none;
        }
        .btn-success:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<form runat="server">
    <!-- Sidebar -->
    <div class="sidebar">
        <h4 class="text-center text-white">Member Panel</h4>
        <a href="Dashboard.aspx">Dashboard</a>
        <a href="MarkAttendance.aspx">Mark Attendance</a>
        <a href="RenewSubscription.aspx">Subscription</a>
        <a href="login.aspx">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="container">
            <h2 class="mb-4"> <asp:Label ID="lblName" runat="server" /></h2>

            <div class="row">
                <!-- Profile Section -->
                <div class="col-md-5">
                    <div class="card text-center">
                        <h2>Profile</h2>
                        <p><strong>Name:</strong> <asp:Label ID="Label1" runat="server" /></p>
                        <p><strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" /></p>
                        <p><strong>Subscription:</strong> <asp:Label ID="lblSubscription" runat="server" /></p>
                        <p><strong>Subscription Expiry:</strong> <asp:Label ID="lblExpiryDate" runat="server" /></p>
                        <asp:Button ID="btnEditProfile" runat="server" Text="Edit Profile" CssClass="btn btn-primary btn-custom" OnClick="btnEditProfile_Click" />
                    </div>
                </div>

                <!-- Subscription Section -->
                <div class="col-md-7">
                    <div class="card">
                        <h2>Subscription Details</h2>
                        <p><strong>Plan:</strong> <asp:Label ID="lblPlanName" runat="server" /></p>
                        <p><strong>Duration:</strong> <asp:Label ID="lblPlanDuration" runat="server" /> Months</p>
                        <p><strong>Price:</strong> $<asp:Label ID="lblPrice" runat="server" /></p>
                        <asp:Button ID="btnRenewSubscription" runat="server" Text="Renew Subscription" CssClass="btn btn-primary btn-custom" OnClick="btnRenewSubscription_Click" /> <br />
                        <asp:Button ID="makepayment" runat="server" Text="Make Payment" CssClass="btn btn-primary btn-custom" OnClick="makepayment_Click" />
                    </div>
                </div>
            </div>

            <!-- Attendance Section -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card text-center">
                        <h2>Mark Attendance</h2>
                        <p>Click below to mark your attendance for today.</p>
                        <asp:Button ID="btnMarkAttendance" runat="server" Text="Mark Attendance" CssClass="btn btn-success btn-custom" OnClick="btnMarkAttendance_Click" />
                    </div>
                </div>
            </div>

            <!-- Change Password Section -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card">
                        <h2>Change Password</h2>
                        <asp:TextBox ID="newPasswordTextBox" runat="server" TextMode="Password" placeholder="New Password" CssClass="form-control mb-2" />
                        <asp:TextBox ID="confirmPasswordTextBox" runat="server" TextMode="Password" placeholder="Confirm Password" CssClass="form-control mb-2" />
                        <asp:Button ID="btnChangePassword" runat="server" Text="Submit" CssClass="btn btn-primary btn-custom" OnClick="btnChangePassword_Click" UseSubmitBehavior="false" />
                    </div>
                </div>
            </div>

        </div>
    </div>
</form>

</body>
</html>
