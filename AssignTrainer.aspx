<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssignTrainer.aspx.cs" Inherits="GYM_MANAGEMENT.AssignTrainer" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Assign Trainer to Member</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #e3f2fd; /* Light sky blue background */
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.container {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    width: 400px;
    text-align: center;
}

h2 {
    color: #007BFF; /* Blue Title */
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 15px;
    text-align: left;
}

label {
    font-weight: bold;
    color: #333;
}

.dropdown {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.btn {
    background-color: #007BFF; /* Sky Blue Button */
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    width: 100%;
    margin-top: 10px;
}

.btn:hover {
    background-color: #0056b3; /* Darker blue on hover */
}

.message {
    margin-top: 10px;
    font-weight: bold;
}

    </style>
</head>
<body>
    <form runat="server">
    <div class="container">
        <h2>Assign Trainer to Member</h2>

        <div class="form-group">
            <label for="ddlMembers">Select Member:</label>
            <asp:DropDownList ID="ddlMembers" runat="server" CssClass="dropdown"></asp:DropDownList>
        </div>

        <div class="form-group">
            <label for="ddlTrainers">Select Trainer:</label>
            <asp:DropDownList ID="ddlTrainers" runat="server" CssClass="dropdown"></asp:DropDownList>
        </div>

        <asp:Button ID="btnAssign" runat="server" Text="Assign Trainer" OnClick="btnAssign_Click" CssClass="btn"/>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Green" CssClass="message"></asp:Label>
    </div></form>
</body>
</html>
