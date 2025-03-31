<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RenewSubscription.aspx.cs" Inherits="GYM_MANAGEMENT.RenewSubscription" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Renew Subscription</title>
    <style>
        /* Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }

        .container {
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 300px;
            margin: 0 auto;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
        }

        .select, btn {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            margin: 5px 0;
            border-radius: 5px;
        }

        .btn {
            background-color: #e84343;
            border: none;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
            border-radius:6px;
        }

            .btn:hover {
                background-color: #e76f51;
            }
    </style>
</head>
<body>
    <form runat="server">
        <div class="container">
            <h2>Renew Your Subscription</h2>


            <asp:DropDownList ID="ddlSubscriptionPlans" CssClass="select" runat="server" class="form-group" AutoPostBack="true">
            </asp:DropDownList>

            <asp:Button ID="btnRenew" CssClass="btn" runat="server" Text="Renew Subscription" OnClick="btnRenew_Click" />
        </div>
    </form>
</body>
</html>

