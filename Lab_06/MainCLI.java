import java.sql.*;
import java.util.Scanner;

public class MainCLI {

    static final String URL = "jdbc:mysql://127.0.0.1:3306/management7";
    static final String USER = "YOUR_USERNAME";
    static final String PASS = "YOUR_PASSWORD";

    static Scanner sc = new Scanner(System.in);

    public static void main(String[] args) {

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS)) {

            while (true) {
                System.out.println("\n===== LOGIN MENU =====");
                System.out.println("1. Admin Login");
                System.out.println("2. Agent Login");
                System.out.println("3. Customer Login");
                System.out.println("4. Exit");

                int ch = sc.nextInt();
                sc.nextLine();

                switch (ch) {
                    case 1 -> adminPanel(conn);
                    case 2 -> agentLogin(conn);
                    case 3 -> customerLogin(conn);
                    case 4 -> System.exit(0);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= ADMIN =================
    static void adminPanel(Connection conn) throws SQLException {
        while (true) {
            System.out.println("\n--- ADMIN DASHBOARD ---");
            System.out.println("1. View Properties");
            System.out.println("2. View Agents");
            System.out.println("3. View Customers");
            System.out.println("4. Reports");
            System.out.println("5. Logout");

            int ch = sc.nextInt();

            switch (ch) {
                case 1 -> execute(conn, "SELECT * FROM available_properties");
                case 2 -> execute(conn, "SELECT * FROM agent");
                case 3 -> execute(conn, "SELECT * FROM customer");
                case 4 -> reports(conn);
                case 5 -> { return; }
            }
        }
    }

    // ================= AGENT =================
    static void agentLogin(Connection conn) throws SQLException {
        System.out.print("Enter Agent Email: ");
        String email = sc.nextLine();

        PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM agent WHERE email=?");
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();

        if (!rs.next()) {
            System.out.println("❌ Invalid Agent");
            return;
        }

        int agentId = rs.getInt("agent_id");
        System.out.println("✅ Welcome Agent: " + rs.getString("name"));

        agentPanel(conn, agentId);
    }

    static void agentPanel(Connection conn, int agentId) throws SQLException {
        while (true) {
            System.out.println("\n--- AGENT DASHBOARD ---");
            System.out.println("1. Add Property");
            System.out.println("2. Sell Property");
            System.out.println("3. Rent Property");
            System.out.println("4. My Sales");
            System.out.println("5. Logout");

            int ch = sc.nextInt();

            switch (ch) {
                case 1 -> addProperty(conn, agentId);
                case 2 -> sellProperty(conn, agentId);
                case 3 -> rentProperty(conn, agentId);
                case 4 -> execute(conn,
                        "SELECT * FROM sale WHERE agent_id=" + agentId);
                case 5 -> { return; }
            }
        }
    }

    // ================= CUSTOMER =================
    static void customerLogin(Connection conn) throws SQLException {
        System.out.print("Enter Customer Email: ");
        String email = sc.nextLine();

        PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM customer WHERE email=?");
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();

        if (!rs.next()) {
            System.out.println("❌ Invalid Customer");
            return;
        }

        int cid = rs.getInt("customer_id");
        System.out.println("✅ Welcome " + rs.getString("name"));

        customerPanel(conn, cid);
    }

    static void customerPanel(Connection conn, int cid) throws SQLException {
        while (true) {
            System.out.println("\n--- CUSTOMER DASHBOARD ---");
            System.out.println("1. View Available Properties");
            System.out.println("2. Buy Property");
            System.out.println("3. Rent Property");
            System.out.println("4. Logout");

            int ch = sc.nextInt();

            switch (ch) {
                case 1 -> execute(conn, "SELECT * FROM available_properties");
                case 2 -> buyProperty(conn, cid);
                case 3 -> rentAsCustomer(conn, cid);
                case 4 -> { return; }
            }
        }
    }

    // ================= REPORTS =================
    static void reports(Connection conn) throws SQLException {
        System.out.println("\n--- REPORTS ---");
        System.out.println("1. Top Agent");
        System.out.println("2. Most Expensive Property");
        System.out.println("3. Highest Rent");

        int ch = sc.nextInt();

        switch (ch) {
            case 1 -> execute(conn,
                    "SELECT * FROM agent_performance ORDER BY revenue DESC LIMIT 1");
            case 2 -> execute(conn,
                    "SELECT * FROM property WHERE asking_price=(SELECT MAX(asking_price) FROM property)");
            case 3 -> execute(conn,
                    "SELECT * FROM rent WHERE rent_amount=(SELECT MAX(rent_amount) FROM rent)");
        }
    }

    // ================= ACTIONS =================

    static void addProperty(Connection conn, int agentId) throws SQLException {
        sc.nextLine();

        System.out.print("Home No: ");
        String home = sc.nextLine();

        CallableStatement cs = conn.prepareCall(
                "{CALL add_property_with_location(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

        cs.setString(1, home);
        cs.setString(2, "Street");
        cs.setString(3, "Area");
        cs.setString(4, "Guwahati");
        cs.setString(5, "Assam");
        cs.setString(6, "781000");
        cs.setInt(7, 1);
        cs.setInt(8, agentId);
        cs.setString(9, "flat");
        cs.setInt(10, 2);
        cs.setInt(11, 2020);
        cs.setDouble(12, 900);
        cs.setDouble(13, 3000000);
        cs.setDouble(14, 0);
        cs.setString(15, "sale");
        cs.setDate(16, new Date(System.currentTimeMillis()));

        cs.execute();
        System.out.println("✅ Property Added");
    }

    static void sellProperty(Connection conn, int agentId) throws SQLException {
        System.out.print("Property ID: ");
        int pid = sc.nextInt();

        System.out.print("Customer ID: ");
        int cid = sc.nextInt();

        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO sale(property_id, customer_id, agent_id, sale_date, amount) VALUES (?,?,?,?,?)");

        ps.setInt(1, pid);
        ps.setInt(2, cid);
        ps.setInt(3, agentId);
        ps.setDate(4, new Date(System.currentTimeMillis()));
        ps.setDouble(5, 5000000);

        ps.executeUpdate();
        System.out.println("✅ Sold!");
    }

    static void rentProperty(Connection conn, int agentId) throws SQLException {
        System.out.print("Property ID: ");
        int pid = sc.nextInt();

        System.out.print("Customer ID: ");
        int cid = sc.nextInt();

        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO rent(property_id, customer_id, agent_id, rent_amount, rent_date, end_date) VALUES (?,?,?,?,?,?)");

        ps.setInt(1, pid);
        ps.setInt(2, cid);
        ps.setInt(3, agentId);
        ps.setDouble(4, 15000);
        ps.setDate(5, new Date(System.currentTimeMillis()));
        ps.setDate(6, Date.valueOf("2026-01-01"));

        ps.executeUpdate();
        System.out.println("✅ Rented!");
    }

    static void buyProperty(Connection conn, int cid) throws SQLException {
        System.out.print("Property ID: ");
        int pid = sc.nextInt();

        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO sale(property_id, customer_id, agent_id, sale_date, amount) VALUES (?,?,?,?,?)");

        ps.setInt(1, pid);
        ps.setInt(2, cid);
        ps.setInt(3, 1);
        ps.setDate(4, new Date(System.currentTimeMillis()));
        ps.setDouble(5, 5000000);

        ps.executeUpdate();
        System.out.println("✅ Purchased!");
    }

    static void rentAsCustomer(Connection conn, int cid) throws SQLException {
        System.out.print("Property ID: ");
        int pid = sc.nextInt();

        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO rent(property_id, customer_id, agent_id, rent_amount, rent_date, end_date) VALUES (?,?,?,?,?,?)");

        ps.setInt(1, pid);
        ps.setInt(2, cid);
        ps.setInt(3, 1);
        ps.setDouble(4, 12000);
        ps.setDate(5, new Date(System.currentTimeMillis()));
        ps.setDate(6, Date.valueOf("2026-01-01"));

        ps.executeUpdate();
        System.out.println("✅ Rented!");
    }

    // ================= UTIL =================
    static void execute(Connection conn, String query) throws SQLException {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(query);

        ResultSetMetaData md = rs.getMetaData();
        int cols = md.getColumnCount();

        while (rs.next()) {
            for (int i = 1; i <= cols; i++) {
                System.out.print(md.getColumnName(i) + ": " + rs.getString(i) + " | ");
            }
            System.out.println();
        }
    }
}