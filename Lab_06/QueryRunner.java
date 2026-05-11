import java.sql.*;
import java.util.*;

public class QueryRunner {

    static final String DB_URL = "jdbc:mysql://localhost:3306/lab06";
    static final String USER = "YOUR_USERNAME";
    static final String PASS = "YOUR_PASSWORD";

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

            System.out.println("Connected to Database!");

            while(true){

                System.out.println("\nChoose Query:");
                System.out.println("1. Classes in a given room");
                System.out.println("2. Rooms and times for a given course");
                System.out.println("3. Courses taught by a faculty member");
                System.out.println("4. Exit");

                System.out.println("\n");
                System.out.print("Enter your choice: ");
                int choice = sc.nextInt();
                sc.nextLine();

                switch(choice){

                    // (a) Classes in a room
                    case 1:

                        System.out.print("Enter room name: ");
                        String room = sc.nextLine();

                        try{
                            String query = "SELECT name FROM Class WHERE room = ?";
                            PreparedStatement ps = conn.prepareStatement(query);
                            ps.setString(1, room);

                            ResultSet rs = ps.executeQuery();

                            System.out.println("Classes in room " + room + ":");

                            while(rs.next()){
                                System.out.println(rs.getString("name"));
                            }

                        }catch(SQLException e){
                            System.out.println("Error: " + e.getMessage());
                        }

                        break;

                    // (b) Rooms and times of a course
                    case 2:

                        System.out.print("Enter course name: ");
                        String course = sc.nextLine();

                        try{
                            String query = "SELECT room, meets_at FROM Class WHERE name = ?";
                            PreparedStatement ps = conn.prepareStatement(query);
                            ps.setString(1, course);

                            ResultSet rs = ps.executeQuery();

                            System.out.println("Schedule for course " + course + ":");

                            while(rs.next()){
                                System.out.println("Room: " + rs.getString("room")
                                        + "  Time: " + rs.getString("meets_at"));
                            }

                        }catch(SQLException e){
                            System.out.println("Error: " + e.getMessage());
                        }

                        break;

                    // (c) Courses taught by faculty
                    case 3:

                        System.out.print("Enter faculty name: ");
                        String faculty = sc.nextLine();

                        try{
                            String query =
                                    "SELECT Class.name " +
                                    "FROM Class JOIN Faculty " +
                                    "ON Class.fid = Faculty.fid " +
                                    "WHERE Faculty.fname = ?";

                            PreparedStatement ps = conn.prepareStatement(query);
                            ps.setString(1, faculty);

                            ResultSet rs = ps.executeQuery();

                            System.out.println("Courses taught by " + faculty + ":");

                            while(rs.next()){
                                System.out.println(rs.getString("name"));
                            }

                        }catch(SQLException e){
                            System.out.println("Error: " + e.getMessage());
                        }

                        break;

                    case 4:
                        System.out.println("Exiting...");
                        conn.close();
                        sc.close();
                        return;

                    default:
                        System.out.println("Invalid option");
                }
            }

        } catch(Exception e){
            System.out.println("Database Error: " + e.getMessage());
        }
    }
}
