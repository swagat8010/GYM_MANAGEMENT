<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageSubscriptions.aspx.cs" Inherits="GYM_MANAGEMENT.ManageSubscriptions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Subscriptions</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #2e3b4e;
            margin-top: 10px;
        }

        .grid-container {
            margin-top: 30px;
            width: 80%;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .grid-container h3 {
            text-align: center;
            margin-bottom: 15px;
            color: #2e3b4e;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .delete-button {
            color: red;
            font-weight: bold;
            cursor: pointer;
        }

        .delete-button:hover {
            color: #d32f2f;
        }

        /* Form styling */
        form {
            width: 50%;
            margin: 30px auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        label {
            font-size: 16px;
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            color: #2e3b4e;
        }

        input[type="text"], input[type="checkbox"] {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        input[type="checkbox"] {
            width: auto;
            margin-right: 10px;
        }

        input[type="text"]:focus {
            border-color: #007bff;
            outline: none;
        }

        .button-container {
            text-align: center;
        }

        .button-container input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .button-container input[type="submit"]:hover {
            background-color: #0056b3;
        }

        /* Copyright styles */
        .copyright {
            text-align: center;
            font-size: 14px;
            color: #999;
            margin-top: 20px;
        }

    </style>
</head>
<body> <form runat="server">

    <h2>Manage Subscriptions</h2>

    <!-- GridView to display subscriptions (Table comes first) -->
    <div class="grid-container">
        <h3>Subscription List</h3>
        <asp:GridView ID="GridViewSubscriptions" runat="server" AutoGenerateColumns="False" OnRowDeleting="GridViewSubscriptions_RowDeleting" DataKeyNames="SubscriptionID">
            <Columns>
                <asp:BoundField DataField="SubscriptionID" HeaderText="Subscription ID" SortExpression="SubscriptionID" />
                <asp:BoundField DataField="PlanName" HeaderText="Plan Name" SortExpression="PlanName" />
                <asp:BoundField DataField="DurationMonths" HeaderText="Duration (Months)" SortExpression="DurationMonths" />
                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                <asp:CheckBoxField DataField="IsActive" HeaderText="Active" SortExpression="IsActive" />
                <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" SortExpression="CreatedDate" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
    </div>

    <!-- Form comes after the table -->
   
        <h3 style="text-align: center;">Add New Subscription</h3>
        <asp:ScriptManager ID="sc1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <label for="PlanName">Plan Name:</label>
                <input type="text" id="PlanName" runat="server" /><br />

                <label for="DurationMonths">Duration (Months):</label>
                <input type="text" id="DurationMonths" runat="server" /><br />

                <label for="Price">Price:</label>
                <input type="text" id="Price" runat="server" /><br />

                <label for="Description">Description:</label>
                <input type="text" id="Description" runat="server" /><br />

                <label for="IsActive">Active:</label>
                <input type="checkbox" id="IsActive" runat="server" /><br />

                <div class="button-container">
                    <asp:Button ID="AddSubscription" runat="server" Text="Add Subscription" CssClass="btn-primary" OnClick="AddSubscription_Click" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>

    <div class="copyright">
        &copy; 2025 Your Company. All rights reserved.
    </div>
    
</body>
</html>
