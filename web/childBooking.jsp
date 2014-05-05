<%@page import="classes.Booking"%>
<%@page import="classes.BookingList"%>
<%@page import="classes.Relationship"%>
<%@page import="classes.RelationshipList"%>
<%@page import="classes.DBConnection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="classes.ChildList"%>
<%@page import="classes.Child"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Child Bookings</title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap.min.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Custom styles for this template -->
    <link href="carousel.css" rel="stylesheet">
  </head>
<!-- NAVBAR
================================================== -->
  <body>
    <div class="navbar-wrapper">
      <div class="container">	
        <div class="navbar navbar-inverse navbar-static-top" role="navigation">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="index.jsp">Willow Childcare Centre</a>
            </div>
            <div class="navbar-collapse collapse">
              <ul class="nav navbar-nav">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="relativeHome.jsp">My Account</a></li>
                <li><a href="logout">Logout</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
	
	<!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
        <div class="item active">
          <img src="images\snowdropGarden.jpg" alt="Nursery">
          <div class="container">
            <div class="carousel-caption">
              <h1>Child Bookings</h1>
              <p>Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesent commodo cursus magna.</p>
            </div>
          </div>
        </div>
        </div>
      </div><!-- /.carousel -->


    <!-- Marketing messaging and featurettes
    ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->

    <div class="container marketing">
	<div class="table-responsive">
            <table class="table table-striped">
                <%DBConnection connect = new DBConnection();
                String fullurl = request.getQueryString().toString();
                String[] array = fullurl.split("=");
                BookingList bookingList = connect.getChildBookings(array[1]);
                ArrayList<Booking> arrayList = bookingList.getBookingList();
                %>
              <thead>
                <tr>
                  <th>Booking ID</th>
                  <th>Booking Date</th>
                  <th>Session</th>
                  <th>Notes</th>
                  <th>Edit</th>
                </tr>
              </thead>
              <tbody>
                  <% for (Booking b: arrayList){%>
                    <tr>
                        <form action="editBooking" method="post">
                        <td><input name="j_BookingID" value="<%out.print(array[1]);%>"></td>
                        <td><input type="text" name="j_BookingDate" value="<%b.getDate();%>"></td>
                        <td><input type="text" name="j_BookingSession" value="<%b.getSession();%>"></td>
                        <td><input type="text" name="j_BookingNotes" value="<%b.getNotes();%>"></td>
                        <td><input type="submit" value="Edit Booking"></td>
                        </form>
                    </tr>
                  <%}%>
                
              </tbody>
            </table>
        </div>
        
        <!-- FOOTER -->
      <footer>
        <p>&copy; 2014 Willow Childcare Centre</p>
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>
