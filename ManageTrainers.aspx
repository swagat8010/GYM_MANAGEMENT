<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageTrainers.aspx.cs" Inherits="GYM_MANAGEMENT.ManageTrainers" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Manage Trainers</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .btn-edit, .btn-delete {
            width: 100px;
        }
        .grid-container {
            margin-top: 20px;
        }
        .alert {
            margin-top: 20px;
        }
        .btn-custom {
            width: 100px;
        }
        .error-message {
            margin-top: 10px;
            font-size: 16px;
        }
        .grid-container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2 class="mt-4">Manage Trainers</h2>

            <!-- ScriptManager for AJAX functionality -->
            <asp:ScriptManager ID="ScriptManager1" runat="server" />

            <!-- UpdatePanel to refresh GridView without reloading the page -->
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <!-- Error Message -->
                    <asp:Label ID="lblError" runat="server" ForeColor="Red" CssClass="alert alert-danger error-message" Visible="false"></asp:Label>

                    <!-- Trainer GridView -->
                    <div class="grid-container">
                        <asp:GridView ID="gvTrainers" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" 
                            OnRowEditing="gvTrainers_RowEditing" OnRowCancelingEdit="gvTrainers_RowCancelingEdit" 
                            OnRowUpdating="gvTrainers_RowUpdating" OnRowDeleting="gvTrainers_RowDeleting" 
                            DataKeyNames="TrainerID" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="TrainerID" HeaderText="TrainerID" SortExpression="TrainerID" ReadOnly="True" />
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("Name") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("Email") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Specialization">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSpecialization" runat="server" Text='<%# Eval("Specialization") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtSpecialization" runat="server" Text='<%# Eval("Specialization") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Join Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblJoinDate" runat="server" Text='<%# Eval("JoinDate", "{0:dd-MM-yyyy}") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtJoinDate" runat="server" Text='<%# Eval("JoinDate", "{0:dd-MM-yyyy}") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-warning btn-edit" />
                                        <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger btn-delete" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-success btn-custom" />
                                        <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-secondary btn-custom" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
