<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="GYM_MANAGEMENT.AdminDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="sidebar">
            <h4 class="text-center text-white">Admin Panel</h4>
            <a href="AdminDashboard.aspx">Dashboard</a>
            <a href="ManageMembers.aspx">Manage Members</a>
            <a href="ManageClasses.aspx">Manage Classes</a>
            <a href="ManageTrainers.aspx">Manage Trainers</a>
            <a href="AssignTrainer.aspx">Assign Trainer</a>
            <a href="ManageSubscriptions.aspx">Manage Subscriptions</a>
            <a href="ManagePayments.aspx">Manage Payments</a>
            <a href="AttendanceReport.aspx">Attendance Reports</a>
            <a href="Home.aspx">Logout</a>
        </div>

        <!-- Main Content -->
        <div class="content">
            <div class="container">
                <h2 class="mb-4">Admin Dashboard</h2>

                <div class="row">
                    <div class="col-md-3">
                        <div class="card text-white bg-primary mb-3 shadow">
                            <div class="card-body text-center">
                                <h5 class="card-title">Total Members</h5>
                                <asp:Label ID="lblTotalMembers" runat="server" CssClass="card-text">0</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-success mb-3 shadow">
                            <div class="card-body text-center">
                                <h5 class="card-title">Total Trainers</h5>
                                <asp:Label ID="lblTotalTrainers" runat="server" CssClass="card-text">0</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-warning mb-3 shadow">
                            <div class="card-body text-center">
                                <h5 class="card-title">Active Subscriptions</h5>
                                <asp:Label ID="lblActiveSubscriptions" runat="server" CssClass="card-text">0</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-danger mb-3 shadow">
                            <div class="card-body text-center">
                                <h5 class="card-title">Pending Payments</h5>
                                <asp:Label ID="lblPendingPayments" runat="server" CssClass="card-text">0</asp:Label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Members Table -->
                <div class="row">
                    <div class="col-md-12">
                        <h3>Members</h3>
                        <asp:GridView ID="gvMembers" runat="server" CssClass="table table-striped shadow" AutoGenerateColumns="true"></asp:GridView>
                    </div>
                </div>

                <!-- Subscriptions Table -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <h3>Subscriptions</h3>
                        <asp:GridView ID="gvSubscriptions" runat="server" CssClass="table table-striped shadow" AutoGenerateColumns="true"></asp:GridView>
                    </div>
                </div>

                <!-- Payments Table -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <h3>Payments</h3>
                        <asp:GridView ID="gvPayments" runat="server" CssClass="table table-striped shadow" AutoGenerateColumns="true"></asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
