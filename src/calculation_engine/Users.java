package calculation_engine;

import javax.naming.*;
import javax.sql.*;
import java.sql.*;

public class Users {

    String firstName = "Not Connected";
    String lastName = "Not Connected";
    int age = -1;
    String country = "Not Connected";

    public void init() {
        try{
            Context ctx = new InitialContext();

            DataSource ds =
                    (DataSource)ctx.lookup(
                            "java:comp/env/jdbc/ef_java_calculation_engine");

            if (ds != null) {
                Connection conn = ds.getConnection();

                if(conn != null)  {
                    firstName = "Got Connection "+conn.toString();
                    Statement stmt = conn.createStatement();
                    ResultSet rst =
                            stmt.executeQuery(
                                    "select first_name, last_name, age, country from users");
                    if(rst.next()) {
                        firstName=rst.getString(1);
                        lastName=rst.getString(2);
                        age=rst.getInt(3);
                        country=rst.getString(4);
                    }
                    conn.close();
                }
            } else{
                firstName="DataSource is null";
            }
        }catch(Exception e) {
            firstName=e.toString();
        }
    }

    public String getFirstName() { return firstName; }
    public String getLastName() { return lastName;}
    public int getAge() { return age;}
    public String getCountry() { return country;}
}