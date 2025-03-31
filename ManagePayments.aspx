<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagePayments.aspx.cs" Inherits="GYM_MANAGEMENT.ManagePayments" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Payments</title>
    <style>
        /* General styling */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #f8f9fa, #e0e0e0);
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #333;
            padding: 20px;
            background: #5bc0de;
            color: white;
            border-radius: 5px;
            margin-bottom: 30px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .table th, .table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        .table th {
            background-color: #5bc0de;
            color: white;
        }

        .status-pending {
            color: red;
            font-weight: bold;
        }

        .status-completed {
            color: green;
            font-weight: bold;
        }

        /* Button styles with 3D effect */
        .btn-warning {
            background: linear-gradient(to bottom, #ffcc00, #e6a800);
            color: white;
            padding: 10px 20px;
            font-size: 14px;
            border: 2px solid #ffb84d;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        .btn-warning:hover {
            background: linear-gradient(to bottom, #ffb84d, #ffcc00);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.3);
        }

        .btn-warning:focus {
            outline: none;
        }

        .btn-warning i {
            margin-right: 8px;
        }

        /* Styling for icons */
        .fa-envelope {
            font-size: 18px;
        }

        /* Row styles for pending and completed payments */
        .status-pending, .status-completed {
            font-weight: bold;
        }
    </style>
    <!-- Include Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Manage Payments</h2>

            <asp:GridView ID="GridViewPayments" runat="server" AutoGenerateColumns="False"
                OnRowDataBound="GridViewPayments_RowDataBound"
                CssClass="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="PaymentID" HeaderText="Payment ID" SortExpression="PaymentID" />
                    <asp:BoundField DataField="MemberID" HeaderText="Member ID" SortExpression="MemberID" />
                    <asp:BoundField DataField="Name" HeaderText="Member Name" SortExpression="MemberName" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                    <asp:BoundField DataField="PaymentDate" HeaderText="Payment Date" SortExpression="PaymentDate" />
                    <asp:BoundField DataField="PaymentMethod" HeaderText="Payment Method" SortExpression="PaymentMethod" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text="" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="NotifyButton" runat="server" Text="Send Reminder"
                                CommandArgument='<%# Eval("MemberID") %>' OnClick="NotifyButton_Click"
                                CssClass="btn-warning" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
