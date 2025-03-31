<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageMembers.aspx.cs" Inherits="GYM_MANAGEMENT.ManageMembers" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Members</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .form-control {
            margin-bottom: 5px;
        }
        .table {
            margin-top: 20px;
        }
        .edit-row {
            background-color: #f9f9a9; /* Light yellow */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- ScriptManager for handling AJAX postbacks -->
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        
        <!-- UpdatePanel to prevent full-page reloads -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="container mt-4">
                    <h2 class="text-center">Manage Gym Members</h2>

                    <!-- Message panel for success/error feedback -->
                    <asp:Panel ID="MessagePanel" runat="server" CssClass="alert alert-success" Visible="false">
                        <asp:Label ID="MessageLabel" runat="server" Text="Operation successful!" />
                    </asp:Panel>

                    <!-- Members Table -->
                    <div class="table-responsive">
                        <asp:GridView ID="gvMembers" runat="server" CssClass="table table-striped"
                                      AutoGenerateColumns="false" DataKeyNames="MemberID"
                                      OnRowEditing="gvMembers_RowEditing"
                                      OnRowCancelingEdit="gvMembers_RowCancelingEdit"
                                      OnRowUpdating="gvMembers_RowUpdating"
                                      OnRowDeleting="gvMembers_RowDeleting"
                                      OnPageIndexChanging="gvMembers_PageIndexChanging"
                                      OnSorting="gvMembers_Sorting" AllowPaging="true" PageSize="10"
                                      AllowSorting="true">
                            <Columns>
                                <asp:TemplateField HeaderText="Member Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("Name") %>' CssClass="form-control"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("Email") %>' CssClass="form-control"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Phone">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPhone" runat="server" Text='<%# Eval("Phone") %>' CssClass="form-control"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Subscription Plan">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSubscriptionPlan" runat="server" Text='<%# Eval("SubscriptionPlan") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtSubscriptionPlan" runat="server" Text='<%# Eval("SubscriptionPlan") %>' CssClass="form-control"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />

                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
