<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CoachPage.aspx.cs" Inherits="CIS560_Team9_NBA_App.CoachPage" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <style>
        #topNav {
            background-color: #512888 !important;
        }
        body {
            background-image: none !important;
        }
        @media (min-width: 780px) {
            body {
                background-color: rgba(81, 40, 136, .75) !important;
            }
        }
        @media (max-width: 780px) {
            body {
                background-color: rgba(81, 40, 136, .25) !important;
            }
        }
        #input {
            border-radius: 25px;
            background: rgb(220,220,220);
        }
        #dropdownMenuButton {
            background-color: #512888 !important;
            color: rgba(255,255,255,.5);
        }
        #dropdownMenuButton:hover {
            background-color: #512888 !important;
            color: rgba(255,255,255,1);
        }
        .nav-link:hover {
            color: rgba(255,255,255,1) !important;
        }
    </style>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>NBA Application</title>

  <!-- Bootstrap core CSS -->
    <link href="~/Content/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link href="css/NbaStyle.css" rel="stylesheet">
    <!-- Bootstrap core JavaScript -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

</head>

<body>

    

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
    <div class="container">
        <a class="navbar-brand" href="Home.aspx">NBA Management Application</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
           <li class="nav-item">
            <a class="nav-link" href="home.aspx">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="TeamPage.aspx">Teams
              
            </a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="CoachPage.aspx">Coaches
                <span class="sr-only">(current)</span>
            </a>
              
          </li>
          <li class="nav-item">
            <a class="nav-link" href="ArenaPage.aspx">Arenas</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="PlayersPage.aspx">Players</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="GamePage.aspx">Games</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
        <form id="HomeForm" runat="server">
        <!-- Page Content -->
       <div class="container py-3 my-5" id="input">
                    <div class="form-group row">
                   
                        <asp:Label ID="Label1" runat="server" class="col-3 col-form-label font-weight-bold" Font-Bold="True" Font-Size="X-Large" Text=" Select Coach"></asp:Label>
                       
                        <div class ="col-9">
                            <asp:DropDownList ID="uxCoachDropdown" CssClass="form-control" runat="server" TabIndex="1" OnSelectedIndexChanged="uxCoachDropdown_SelectedIndexChanged" DataSourceID="SqlDataSource1" DataTextField="LastName" DataValueField="LastName" >
                                    <asp:ListItem> -- select an option -- </asp:ListItem>
                                    <asp:ListItem>Lloyd Pierce</asp:ListItem>
                                    <asp:ListItem>Brad Stevens</asp:ListItem>
                                    <asp:ListItem>Kenny Atkinson</asp:ListItem>
                                    <asp:ListItem>James Borrego</asp:ListItem>
                                    <asp:ListItem>Jim Boylen</asp:ListItem>
                                    <asp:ListItem>Tyronn Lue</asp:ListItem>
                                    <asp:ListItem>Rick Carlisle</asp:ListItem>
                                    <asp:ListItem>Michael Malone</asp:ListItem>
                                    <asp:ListItem>Dwane Casey	</asp:ListItem>
                                    <asp:ListItem>Steve Kerr</asp:ListItem>
                                    <asp:ListItem>Mike D&#39;Antoni</asp:ListItem>
                                    <asp:ListItem>Nate McMillan</asp:ListItem>
                                    <asp:ListItem>Doc Rivers</asp:ListItem>
                                    <asp:ListItem>Luke Walton</asp:ListItem>
                                    <asp:ListItem>J.B. Bickerstaff</asp:ListItem>
                                    <asp:ListItem>Erik Spoelstra</asp:ListItem>
                                    <asp:ListItem>Mike Budenholzer</asp:ListItem>
                                    <asp:ListItem>Ryan Saunders</asp:ListItem>
                                    <asp:ListItem>Alvin Gentry</asp:ListItem>
                                    <asp:ListItem>David Fizdale</asp:ListItem>
                                    <asp:ListItem>Billy Donovan</asp:ListItem>
                                    <asp:ListItem>Steve Clifford	</asp:ListItem>
                                    <asp:ListItem>Brett Brown</asp:ListItem>
                                    <asp:ListItem>Igor Kokoskov</asp:ListItem>
                                    <asp:ListItem>Terry Stotts</asp:ListItem>
                                    <asp:ListItem>Dave Joerger</asp:ListItem>
                                    <asp:ListItem>Gregg Popovich</asp:ListItem>
                                    <asp:ListItem>Nick Nurse</asp:ListItem>
                                    <asp:ListItem>Quin Snyder</asp:ListItem>
                                    <asp:ListItem>Scott Brooks</asp:ListItem>
                                     </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NBALeagueConnectionString %>" SelectCommand="Select LastName from League.Coaches"></asp:SqlDataSource>
                                </div>
                    </div>
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary btn-lg btn-block" OnClick="searchSubmit_Click" Text="Search"/>
                        <asp:Button ID="Button2" runat="server" CssClass="btn btn-primary btn-lg btn-block"  Text="Show All Coaches" OnClick="Button2_Click"/>

           </div>
            <asp:GridView id="GridView2" runat="server" class="Table-hover table-dark container my-5 ">


        </asp:GridView>
    </form>
    
</body>
</html>


