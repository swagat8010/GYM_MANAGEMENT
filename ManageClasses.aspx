<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageClasses.aspx.cs" Inherits="GYM_MANAGEMENT.ManageClasses" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Manage Classes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            color: #343a40;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn:hover {
            background: #0056b3;
        }

        .message {
            color: green;
            text-align: center;
            font-weight: bold;
            margin-top: 10px;
        }

        .error {
            color: red;
            text-align: center;
            font-weight: bold;
            margin-top: 10px;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background: #007bff;
            color: white;
        }

        .edit-btn, .delete-btn {
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }

        .edit-btn {
            background: #ffc107;
            color: black;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
        }

        .edit-btn:hover {
            background: #e0a800;
        }

        .delete-btn:hover {
            background: #c82333;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Manage Classes</h2>

            <!-- ADD CLASS FORM -->
            <label>Class Name:</label>
            <asp:TextBox ID="txtClassName" runat="server"></asp:TextBox>

            <label>Trainer:</label>
            <asp:DropDownList ID="ddlTrainers" runat="server"></asp:DropDownList>

            <label>Schedule:</label>
            <asp:TextBox ID="txtSchedule" runat="server"></asp:TextBox>

            <label>Class Time:</label>
            <asp:TextBox ID="txtClassTime" runat="server" TextMode="Time"></asp:TextBox>

            <asp:Button ID="btnAddClass" runat="server" Text="Add Class" CssClass="btn" OnClick="btnAddClass_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

            <!-- CLASSES LIST -->
            <asp:GridView ID="gvClasses" runat="server" AutoGenerateColumns="False" CssClass="table" OnRowEditing="gvClasses_RowEditing" OnRowDeleting="gvClasses_RowDeleting" DataKeyNames="ClassID">
                <Columns>
                    <asp:BoundField DataField="ClassID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="ClassName" HeaderText="Class Name" />
                    <asp:BoundField DataField="Trainer" HeaderText="Trainer" />
                    <asp:BoundField DataField="Schedule" HeaderText="Schedule" />
                    <asp:BoundField DataField="ClassTime" HeaderText="Class Time" />

                    <asp:CommandField ShowEditButton="True" ControlStyle-CssClass="edit-btn" />
                    <asp:CommandField ShowDeleteButton="True" ControlStyle-CssClass="delete-btn" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
