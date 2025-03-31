<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditTrainerProfile.aspx.cs" Inherits="GYM_MANAGEMENT.EditTrainerProfile" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <form runat="server">
    <div class="container mt-5">
        <h2 class="mb-4">Edit Profile</h2>
        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
        <div class="card p-4 shadow">
            <div class="mb-3">
                <label class="form-label">Name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Specialization</label>
                <asp:TextBox ID="txtSpecialization" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">New Password</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
         
            <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />   <br />
            <a href="TrainerDashboard.aspx" class="btn btn-secondary">Cancel</a>
        </div>
    </div>
        </form>
</body>
    </html>
