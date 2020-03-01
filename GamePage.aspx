<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GamePage.aspx.cs" Inherits="CIS560_Team9_NBA_App.GamePage" %>

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
    <form id="AddPlayerForm" runat="server">
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
          <li class="nav-item">
            <a class="nav-link" href="CoachPage.aspx">Coaches</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="ArenaPage.aspx">Arenas</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="PlayersPage.aspx">Players</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="GamePage.aspx">Games
                <span class="sr-only">(current)</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
            <asp:Button ID="btn_AddPlayer" runat="server" CssClass="btn btn-primary btn-lg btn-block" PostBackUrl="~/AddGame.aspx" Text="Add a Game" OnClick="btn_AddPlayer_Click" />
            <div class="container py-3 my-5" id="input">
                <div class="input-group py-0" style="padding-top: 20%; top: 0px; left: 0px;">
                <asp:DropDownList ID="ArenaDropDown" runat="server" AppendDataBoundItems="True" CssClass="custom-select form-control col-form-label-lg h-auto" DataTextField="Venue" DataValueField="Venue" DataSourceID="ArenaAdapter"></asp:DropDownList>
                    <asp:SqlDataSource ID="ArenaAdapter" runat="server" ConnectionString="<%$ ConnectionStrings:NBALeagueConnectionString %>" SelectCommand="SELECT [Venue] FROM League.[Arena]"></asp:SqlDataSource>


                
                                      
                  <asp:DropDownList ID="TeamName" runat="server" AppendDataBoundItems="True" CssClass="custom-select form-control col-form-label-lg h-auto" DataTextField="TeamName" DataValueField="TeamName" DataSourceID="SqlDataSource1"></asp:DropDownList>

                
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NBALeagueConnectionString %>" SelectCommand="Select TeamName from League.Team"></asp:SqlDataSource>

                
            </div>
            <div class="form-inline col-12">
                <asp:RadioButton runat="server" groupname="connected" id="ArenaRadio" Text="Arena" Checked/>
                <label class="form-check-label font-weight-bold mx-1" for="ArenaRadio"></label> 

                <asp:RadioButton runat="server" groupname="connected" id="TeamNameRadio" Text="Team Name"/>
                <label class="form-check-label font-weight-bold mx-1" for="TeamNameRadio"></label>

                 <asp:RadioButton runat="server" groupname="connected" id="BothRadio" Text="Both"/>
                <label class="form-check-label font-weight-bold mx-1" for="BothRadio"></label>
       
                <asp:Button ID="searchSubmit" runat="server" CssClass="btn btn-primary m-1 px-5 float-right" OnClick="searchSubmit_Click" Text="Search" />
            </div>
        </div>
        <asp:GridView id="GridView2" runat="server" class="Table-hover table-dark container my-5 ">


        </asp:GridView>
</form>
</html>