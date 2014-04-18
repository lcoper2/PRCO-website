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
                <li><a href="index.html">Home</a></li>
                <li><a href="about.html">About</a></li>
                <li><a href="contact.html">Contact</a></li>
                <li><a href="relativeHome.jsp">My Account</a></li>
                <li><a href="index.html">Logout</a></li>
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
          <img src="images\nursery3.jpg" alt="Nursery">
          <div class="container">
            <div class="carousel-caption">
              <h1>Child Bookings</h1>
              <p>Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesent commodo cursus magna.</p>
              <a class="btn btn-lg btn-primary" role="button" href="addBooking.jsp">Add Booking</a>
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
                  <th>Edit</th>
                  <th>Delete</th>
                </tr>
              </thead>
              <tbody>
                  <% for (Booking b: arrayList){%>
                    <tr>
                        <form action="deleteBooking" method="post">
                        <td><input name="j_BookingID" value="<%out.print(b.getBookingID());%>"></td>
                        <td><%out.print(b.getDate());%></td>
                        <td><%out.print(b.getSession());%></td>
                        <td><a class="btn btn-default" href="childBooking.jsp?id=<%out.print(b.getBookingID());%>" role="button">Edit Booking &raquo;</a></td>
                        <td><font color="black"><input type="submit" value="Delete Booking"></font></td>
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
