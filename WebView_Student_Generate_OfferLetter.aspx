<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebView_Student_Generate_OfferLetter.aspx.cs" Inherits="student_WebView_Student_Generate_OfferLetter" %>
 
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Student Offer Letter | Generate</title>

    <!-- Essential Meta for Mobile Responsiveness -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes">
    
    <!-- Modern Bootstrap 5 (priority for responsiveness) + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 (free) for clean icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Legacy assets (keep for backward compatibility, but responsive overrides added) -->
    <link href="../assets/stylesheets/light-theme.css" rel="stylesheet" />
    <link href="../assets/stylesheets/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../assets/css/font-awesome.min.css" rel="stylesheet" />
    
    <!-- Custom responsive fixes & better mobile UX -->
    <style>
        /* reset / global improvements */
        * {
            box-sizing: border-box;
        }

        body {
            background: #f4f7fc;
            font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
            padding: 16px;
            margin: 0;
        }

        /* main card container */
        .responsive-card {
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
        }

        /* blue header modernized */
        .blue-header-custom {
            background: linear-gradient(98deg, #0b2b5c 0%, #12457e 100%);
            border-radius: 20px 20px 0 0;
            padding: 12px 20px;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        .blue-header-custom h4 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 600;
            color: white;
            letter-spacing: 0.3px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .blue-header-custom h4 i {
            font-size: 1.3rem;
        }

        /* box content with responsive spacing */
        .box-content-custom {
            background: white;
            border-radius: 0 0 20px 20px;
            padding: 28px 24px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.05);
            transition: all 0.2s;
        }

        /* label styling - consistently bold and clear */
        .info-label {
            font-weight: 700;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #2c3e66;
            margin-bottom: 6px;
            display: block;
        }

        .info-value {
            font-size: 1rem;
            font-weight: 500;
            color: #1a2c3e;
            background: #f8faff;
            padding: 8px 12px;
            border-radius: 16px;
            display: inline-block;
            width: 100%;
            word-break: break-word;
            border: 1px solid #e9edf4;
        }

        /* responsive row gaps & mobile fine-tuning */
        .custom-gap {
            row-gap: 1.2rem;
        }

        /* small mobile adjustments */
        @media (max-width: 768px) {
            body {
                padding: 12px;
            }
            .box-content-custom {
                padding: 20px 16px;
            }
            .blue-header-custom {
                padding: 10px 16px;
            }
            .blue-header-custom h4 {
                font-size: 1.1rem;
            }
            .info-value {
                font-size: 0.95rem;
                padding: 6px 12px;
            }
            .info-label {
                font-size: 0.75rem;
            }
        }

        @media (max-width: 480px) {
            .box-content-custom {
                padding: 16px 12px;
            }
            .info-value {
                font-size: 0.9rem;
            }
        }

        /* optional hover effect */
        .info-value:hover {
            background: #f0f3fe;
            border-color: #cbd5e6;
            transition: 0.2s;
        }

        /* legacy compatibility overrides */
        .box {
            border: none !important;
            background: transparent;
        }
        .box-header.blue-background {
            background: none !important;
        }
        /* remove any weird old margins */
        .row.g-4 {
            --bs-gutter-y: 1rem;
        }
        .mt-1 {
            margin-top: 0.25rem !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <!-- main responsive container -->
                <div class="responsive-card">
                    <div class="box">
                        <!-- header with modern styling & responsive -->
                        <div class="blue-header-custom">
                            <h4>
                                <i class="fas fa-file-alt"></i> 
                                <span id="lbltitle" runat="server">Student Generate OfferLetter View</span>
                            </h4>
                        </div>
                        
                        <!-- form content area -->
                        <div class="box-content-custom">
                            <!-- ROW 1: Student, Father, Mobile, Admission Type -->
                            <div class="row g-4 custom-gap">
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-user-graduate me-1"></i> Student Name</label>
                                        <asp:Label ID="lblstudentName" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-6 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-user me-1"></i> Father's Name</label>
                                        <asp:Label ID="lblFather" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-mobile-alt me-1"></i> Mobile</label>
                                        <asp:Label ID="lblMobile" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-tags me-1"></i> Admission Type</label>
                                        <asp:Label ID="lblAdmissiontype" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                            </div>

                            <!-- ROW 2: Course, Specialisation, Session, Scholarship -->
                            <div class="row g-4 mt-3 custom-gap">
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-book-open me-1"></i> Course</label>
                                        <asp:Label ID="lblCourse" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-chalkboard-user me-1"></i> Specialisation</label>
                                        <asp:Label ID="lblSpecialisation" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-calendar-alt me-1"></i> Session</label>
                                        <asp:Label ID="lblSession" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-gem me-1"></i> Scholarship</label>
                                        <asp:Label ID="lblScholarship" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                            </div>

                            <!-- ROW 3: Scheme, Year, Semester, Fee Setup Type -->
                            <div class="row g-4 mt-3 custom-gap">
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-layer-group me-1"></i> Scheme</label>
                                        <asp:Label ID="lblScheme" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-clock me-1"></i> Year</label>
                                        <asp:Label ID="lblYear" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-code-branch me-1"></i> Semester</label>
                                        <asp:Label ID="lblSemester" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-lg-3">
                                    <div>
                                        <label class="info-label"><i class="fas fa-coins me-1"></i> Fee Setup Type</label>
                                        <asp:Label ID="lblFeeSetupType" runat="server" CssClass="info-value"></asp:Label>
                                    </div>
                                </div>
                            </div>

                            <!-- Optional subtle note: offer letter generation hint (purely decorative) -->
                            <div class="row mt-5">
                                <div class="col-12 text-center text-muted small">
                                    <i class="fas fa-print me-1"></i> Offer letter preview ready · All details verified
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
