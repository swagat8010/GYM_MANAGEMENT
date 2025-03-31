<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MarkAttendance.aspx.cs" Inherits="GYM_MANAGEMENT.MarkAttendance" %>

<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container { max-width: 600px; margin-top: 50px; }
        .card { padding: 20px; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); }
    </style>
</head>
<body>
    <form runat="server">
    <div class="container">
        <div class="card">
            <h3 class="text-center">Mark Attendance</h3>
            <asp:Label ID="lblMemberID" runat="server" CssClass="form-label"></asp:Label>
            <br />
            <asp:Button ID="btnSubmitAttendance" runat="server" Text="Mark Attendance" CssClass="btn btn-primary w-100 mt-3" OnClick="btnSubmitAttendance_Click" />
            <br />
            <asp:Label ID="lblMessage" runat="server" CssClass="text-success mt-3"></asp:Label> 
            <asp:Button ID="Button1" runat="server" Text="LogOut" CssClass="btn btn-primary w-100 mt-3" visible="false" OnClick="Button1_Click" />
        </div>
       
    </div>
        </form>
</body>
</html>
