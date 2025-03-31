<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageAttendance.aspx.cs" Inherits="GYM_MANAGEMENT.ManageAttendance" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 30px;
        }
        .card {
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form runat="server">
    <div class="container">
        <h2 class="mb-4 text-center">Manage Attendance</h2>

        <div class="card shadow p-3">
            <div class="card-body">
                <div class="d-flex justify-content-between mb-3">
                    <h5 class="card-title">Attendance Records</h5>
                    <div>
                        <asp:Button ID="btnExportExcel" runat="server" Text="Export to Excel" CssClass="btn btn-success me-2" OnClick="btnExportExcel_Click" />
                        <asp:Button ID="btnExportPDF" runat="server" Text="Export to PDF" CssClass="btn btn-danger" OnClick="btnExportPDF_Click" />
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>Member Name</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptAttendance" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("MemberName") %></td>
                                        <td><%# Convert.ToDateTime(Eval("Date")).ToString("yyyy-MM-dd") %></td>
                                        <td>
                                            <%# Eval("Status").ToString() == "Present" ? "<span class='badge bg-success'>Present</span>" : "<span class='badge bg-danger'>Absent</span>" %>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
</html>
