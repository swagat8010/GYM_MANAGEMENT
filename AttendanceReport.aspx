<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AttendanceReport.aspx.cs" Inherits="GYM_MANAGEMENT.AttendanceReport" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Attendance Report</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .filter-container {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .filter-container .form-control {
            border-radius: 6px;
            font-size: 14px;
        }

        .filter-container label {
            font-weight: bold;
            color: #333;
        }

        .filter-container .modern-btn {
            margin: 5px;
            font-weight: bold;
        }

        .table-container {
            padding: 15px;
            background: white;
            border-radius: 8px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Attendance Report</h2>

            <!-- FILTER SECTION -->
            <div class="filter-container">
                <div class="row">
                    <div class="col-md-3">
                        <label for="txtStartDate">Start Date:</label>
                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label for="txtEndDate">End Date:</label>
                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label for="txtMemberID">Member ID:</label>
                        <asp:TextBox ID="txtMemberID" runat="server" CssClass="form-control" placeholder="Enter Member ID"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label for="txtMemberName">Member Name:</label>
                        <asp:TextBox ID="txtMemberName" runat="server" CssClass="form-control" placeholder="Enter Name"></asp:TextBox>
                    </div>
                </div>
                <div class="row mt-3 text-center">
                    <div class="col-md-12">
                        <asp:Button ID="btnLoad" runat="server" CssClass="btn btn-primary modern-btn" Text="Load Data" OnClick="btnLoad_Click" />
                        <asp:LinkButton ID="btnExportExcel" runat="server" CssClass="btn btn-success modern-btn" OnClick="btnExportExcel_Click">
                            <i class="fa-solid fa-file-excel"></i> Export to Excel
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnExportPDF" runat="server" CssClass="btn btn-danger modern-btn" OnClick="btnExportPDF_Click">
                            <i class="fa-solid fa-file-pdf"></i> Export to PDF
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

            <!-- ATTENDANCE TABLE -->
            <div class="table-container">
                <asp:GridView ID="GridViewAttendance" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="true"></asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
