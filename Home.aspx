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
           <li class="nav-item active">
            <a class="nav-link" href="Home.aspx">Home
              <span class="sr-only">(current)</span>
            </a>
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
          <li class="nav-item">
            <a class="nav-link" href="GamePage.aspx">Games</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Page Content -->
    <form id="HomeForm" runat="server">
        <!-- Page Content -->
        <div class="row h-100 justify-content-center align-items-center">
            <img src="https://image.roku.com/blog/wp-content/uploads/2018/04/NBAApp-Playoffs18-Roku-1200x628.jpg" />
         </div>

        <div class="container py-3 my-5" id="input">
            <div class="row h-100 justify-content-center align-items-center">
                <div class="form-group row">
                     <div class="row h-100 justify-content-center align-items-center">
                    <h1 class="mt-5">NBA Management Application</h1>                   
                    <div class="col-9">                     
                        <div class="row h-100 justify-content-center align-items-center">
                        <p class="lead">Created by: Tanner Bayless, Mitchell Blazer, Graham Wood, Tyler Trammell</p>
                        <p class="lead">App created for Educational purposes</p>
                        <p class="lead">We do not own the rights to NBA or any of it's trademarks. All trademarks belong by their respective owners</p>
                        </div>
                       
                     </div>
                </div>
            </div>
        </div>
    </div>
        
                    
         
            
         
    
         </form>
  <!-- Bootstrap core JavaScript -->
  <script src="~/Content/vendor/jquery/jquery.min.js"></script>
  <script src="~/Content/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
