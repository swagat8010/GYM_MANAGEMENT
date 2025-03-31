<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="GYM_MANAGEMENT.Payment" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make Payment</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .payment-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .btn-pay {
            width: 100%;
        }
    </style>
</head>
<body>
    <form runat="server">
<div class="container payment-container">
    <h4 class="text-center mb-4">Payment</h4>
    <asp:Label ID="lblSubscription" runat="server" CssClass="font-weight-bold"></asp:Label><br />
    <asp:Label ID="lblAmount" runat="server" CssClass="text-success h5"></asp:Label><br /><br />
    <asp:Button ID="btnPayNow" runat="server" Text="💸 Pay Now" CssClass="btn btn-success btn-pay" OnClick="btnPayNow_Click" />
    <br /><br />
    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
    <asp:Label ID="Label1" runat="server" CssClass="text-info"></asp:Label><br />
<asp:Label ID="Label2" runat="server" CssClass="text-info"></asp:Label><br /><br />

<asp:Label Text="Name:" AssociatedControlID="txtName" runat="server"></asp:Label>
<asp:TextBox ID="txtName" runat="server" ReadOnly="true"></asp:TextBox><br /><br />

<asp:Label Text="Payment Method:" AssociatedControlID="ddlPaymentMethod" runat="server"></asp:Label>
<asp:DropDownList ID="ddlPaymentMethod" runat="server">
    <asp:ListItem Value="Credit Card">Credit Card</asp:ListItem>
    <asp:ListItem Value="Debit Card">Debit Card</asp:ListItem>
    <asp:ListItem Value="UPI">UPI</asp:ListItem>
    <asp:ListItem Value="Net Banking">Net Banking</asp:ListItem>
</asp:DropDownList><br /><br />

<asp:Label Text="Reference Code:" AssociatedControlID="txtReferenceCode" runat="server"></asp:Label>
<asp:TextBox ID="txtReferenceCode" runat="server"></asp:TextBox><br /><br />


<asp:Label ID="Label3" runat="server" CssClass="text-danger"></asp:Label>

</div>
    </form>
</body>
</html>
