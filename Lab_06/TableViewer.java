import java.sql.*;
import java.util.*;

public class TableViewer {

    static final String DB_URL = "jdbc:mysql://localhost:3306/lab06";
    static final String USER = "YOUR_USERNAME";
    static final String PASS = "YOUR_PASSWORD";

    public static void main(String[] args) {

         try {
            // Load JDBC Driver (IMPORTANT)
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Now create resources
            try (Scanner sc = new Scanner(System.in);
                 Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {

                System.out.println("Connected to Database!\n");

                // Step 1: Fetch all tables
                DatabaseMetaData metaData = conn.getMetaData();
                ResultSet tables = metaData.getTables("lab06", null, "%", new String[]{"TABLE"});

                List<String> tableList = new ArrayList<>();
                int i = 1;

                System.out.println("Available Tables:");
                while (tables.next()) {
                    String tableName = tables.getString("TABLE_NAME");
                    tableList.add(tableName);
                    System.out.println(i + ". " + tableName);
                    i++;
                }

                // Step 2: Ask user to select table
                System.out.print("\nSelect a table number to display: ");
                int choice = sc.nextInt();

                if (choice < 1 || choice > tableList.size()) {
                    System.out.println("Invalid choice!");
                    return;
                }

                String selectedTable = tableList.get(choice - 1);

                // Step 3: Query selected table
                String query = "SELECT * FROM " + selectedTable;
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                ResultSetMetaData rsMeta = rs.getMetaData();
                int columnCount = rsMeta.getColumnCount();

                System.out.println("\n===== " + selectedTable + " TABLE =====");

                // Print column headers
                for (int j = 1; j <= columnCount; j++) {
                    System.out.printf("%-15s", rsMeta.getColumnName(j));
                }
                System.out.println();
                System.out.println("-------------------------------------------------------------");

                // Print rows
                while (rs.next()) {
                    for (int j = 1; j <= columnCount; j++) {
                        System.out.printf("%-15s", rs.getString(j));
                    }
                    System.out.println();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
