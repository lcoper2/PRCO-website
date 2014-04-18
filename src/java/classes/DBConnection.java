/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Lewis
 */
public class DBConnection {

    Connection conn = null;
    String query;
    String todayDate;
    String date;
    int count;
    private PreparedStatement statement;
    private ResultSet result;
    
    ChildList childList;
    RelativeList relativeList;
    RelationshipList relationshipList;
    RoomList roomList;
    BookingList bookingList;
    ChildRoomList childRoomList;

    public void dbConnect() throws SQLException, ClassNotFoundException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/nurserybooking","root","root");
        } catch (SQLException ex) {
            // handle errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
    }
    
    public void closeConnection() throws SQLException{
        conn.close();
    } 
    
    public String checkLogin(String userName, String password) throws SQLException, ClassNotFoundException{
        boolean correct = false;
        int i = 0;
        String id= "";
                
        query = "SELECT * FROM relative WHERE emailAddress = '"+ userName +
                "' AND password = '"+ password + "'";
        dbConnect();
        statement = conn.prepareStatement(query);
        result = statement.executeQuery();
        
        System.out.println(result);
        
        while(result.next()){
            i++;
            id = result.getString(1);
            System.out.println(id);
        } 
        
        if(i > 0){
            return id;
        }
        return id;
    }
    
    public ChildList viewAllChildren() throws SQLException, ClassNotFoundException{
        query = "SELECT * FROM child ORDER BY surname";
        dbConnect();
        statement = conn.prepareStatement(query);
        result = statement.executeQuery();

        this.childList = new ChildList(result);

        return this.childList;
    }
    
    public BookingList getChildBookings(String stringID) throws SQLException, ClassNotFoundException{
        int id = Integer.parseInt(stringID);
        
        query = "SELECT * FROM booking WHERE childID = " + id;
        dbConnect();
        statement = conn.prepareStatement(query);
        result = statement.executeQuery();

        this.bookingList = new BookingList(result);
        return this.bookingList;
    }
    
    public BookingList searchChildBookings(int id, String search) throws SQLException, ClassNotFoundException{
        query = "SELECT * FROM booking WHERE Date LIKE '%"+search+"%' AND childID = "+id+" OR "
                + "Session LIKE '%"+search+"%' AND childID = "+id+" ORDER BY Date";
        dbConnect();
        statement = conn.prepareStatement(query);
        result = statement.executeQuery();

        this.bookingList = new BookingList(result);

        return this.bookingList;
    }
    
    public RelationshipList getRelativesChild(String stringID) throws SQLException, ClassNotFoundException{
        int id = Integer.parseInt(stringID);
        
        query = "SELECT * FROM relationship WHERE relativeID = " + id;
        dbConnect();
        statement = conn.prepareStatement(query);
        result = statement.executeQuery();
        
        this.relationshipList = new RelationshipList(result);
        
        return this.relationshipList;
    }
    
    public boolean addBooking(String childID, String roomID, String date, String session, String notes) {
        boolean temp = false;
        try{
            query = "INSERT INTO booking VALUES (NULL, '" + childID + "','" +
                    roomID + "','" + date + "','" + session + "','" + notes + "')";
            dbConnect();
            statement = conn.prepareStatement(query);
            statement.executeUpdate();
            temp = true;
        }
        catch(Exception e){
             System.out.println(e);
        }
        return temp;
    }
    
    public void deleteBooking(String stringID) throws SQLException, ClassNotFoundException{
        int id = Integer.parseInt(stringID);
        
        query = "DELETE FROM booking WHERE bookingID = " + id;
        dbConnect();
        statement = conn.prepareStatement(query);
        statement.executeUpdate();
    }

    public Boolean editBooking(String stringID, String date, String session, String notes) throws ClassNotFoundException {
        int id = Integer.parseInt(stringID);
        
        Boolean temp = false;
        try{
            query = "UPDATE booking SET Date='"+date+
                    "',Session='"+session+"', Notes='"+notes+
                    "' WHERE bookingID = "+id;
                    dbConnect();
                    statement = conn.prepareStatement(query);
                    statement.executeUpdate();
                    temp = true;    
        }
        catch(SQLException e){
            System.out.println(e);
        }
        return temp;
    }
    
}
