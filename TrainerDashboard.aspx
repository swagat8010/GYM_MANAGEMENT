<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrainerDashboard.aspx.cs" Inherits="GYM_MANAGEMENT.TrainerDashboard" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trainer Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #343a40;
            padding-top: 20px;
            position: fixed;
        }
        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .content {
            margin-left: 260px;
            padding: 20px;
        }
        .card {
            border-radius: 10px;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h4 class="text-center text-white">Trainer Panel</h4>
        <a href="TrainerDashboard.aspx">Dashboard</a>
      
        <a href="ManageAttendance.aspx">Attendance</a>
       
        <a href="Login.aspx">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="container">
            <h2 class="mb-4">Welcome, <asp:Label ID="lblTrainerName" runat="server" Text="Trainer Name"></asp:Label></h2>
            
            <div class="row">
                <!-- Trainer Info Card -->
                <div class="col-md-4">
                    <div class="card shadow p-3">
                        <div class="card-body text-center">
                            <img src="trainer-placeholder.jpg" class="rounded-circle mb-3" width="100" alt="im" />
                            <h5><asp:Label ID="lblTrainerSpecialization" runat="server" Text="Specialization"></asp:Label></h5>
                            <p><asp:Label ID="lblTrainerEmail" runat="server" Text="email@example.com"></asp:Label></p>
                            <a href="EditTrainerProfile.aspx" class="btn btn-primary">Edit Profile</a>
                        </div>
                    </div>
                </div>

                <!-- Members List -->
                <div class="col-md-8">
                    <div class="card shadow p-3">
                        <div class="card-body">
                            <h5 class="card-title">Assigned Members</h5>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Plan</th>
                                        <th>Attendance</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptMembers" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("MemberName") %></td>
                                                <td><%# Eval("SubscriptionPlan") %></td>
                                                <td><%# Eval("AttendancePercentage") %>%</td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Attendance & Reports -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card shadow p-3">
                        <div class="card-body">
                            <h5 class="card-title">Attendance Overview</h5>
                            <p>Track and manage member attendance here.</p>
                            <a href="ManageAttendance.aspx" class="btn btn-success">Manage Attendance</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card shadow p-3">
                        <div class="card-body">
                            <h5 class="card-title">Reports & Analytics</h5>
                            <p>Generate reports to analyze member performance.</p>
                            <a href="TrainerReport.aspx" class="btn btn-info">View Reports</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</body>
</html>
