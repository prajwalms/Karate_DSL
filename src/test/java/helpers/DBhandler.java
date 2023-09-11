package helpers;

import net.minidev.json.JSONObject;

import java.sql.*;

public class DBhandler {

    static String username = "root";
    static String password = "root";
    public static String dbString = "jdbc:mysql://127.0.0.1:3306/business";
    public static void dbConnectionWithInsert(String courseName) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con= DriverManager.getConnection(dbString,username, password);
        Statement stmt=con.createStatement();
        stmt.execute("Insert into customerinfo values ('"+courseName+"','2922-06-06',65,'Asia')");

    }

    public static JSONObject dbConnectionWithselect(String courseName) throws ClassNotFoundException, SQLException {
        JSONObject js = new JSONObject();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con= DriverManager.getConnection(dbString,username, password);
        Statement stmt=con.createStatement();
        ResultSet rs = stmt.executeQuery("select amount,location from customerinfo where courename = '"+courseName+"'");
        rs.next();
        js.put("courseAmt",rs.getString("amount"));
        js.put("courseLocation",rs.getString("location"));

        return js;
    }
}
