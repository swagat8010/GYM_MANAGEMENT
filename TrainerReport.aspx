<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrainerReport.aspx.cs" Inherits="GYM_MANAGEMENT.TrainerReport" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trainer Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form runat="server">
    <div class="container">
        <h2 class="mb-4">Trainer Report</h2>

        <!-- GridView for Attendance & Payment Status -->
        <asp:GridView ID="GridViewAttendance" runat="server" CssClass="table table-striped" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="MemberName" HeaderText="Member Name" />
                <asp:BoundField DataField="Date" HeaderText="Attendance Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="AttendanceStatus" HeaderText="Attendance Status" />
                <asp:BoundField DataField="PaymentStatus" HeaderText="Payment Status" />
            </Columns>
        </asp:GridView>

    </div>
</form>
</body>
</html>
