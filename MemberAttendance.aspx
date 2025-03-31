<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberAttendance.aspx.cs" Inherits="GYM_MANAGEMENT.MemberAttendance" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Member Attendance</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Member Attendance</h2>

            <label>Select Date:</label>
            <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
            <asp:Button ID="btnLoad" runat="server" Text="Load Attendance" OnClick="btnLoad_Click" />

            <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="MemberID" HeaderText="Member ID" />
                    <asp:BoundField DataField="Name" HeaderText="Member Name" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server">
                                <asp:ListItem Text="Present" Value="Present"></asp:ListItem>
                                <asp:ListItem Text="Absent" Value="Absent"></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Button ID="btnSave" runat="server" Text="Save Attendance" OnClick="btnSave_Click" />
        </div>
    </form>
</body>
</html>
