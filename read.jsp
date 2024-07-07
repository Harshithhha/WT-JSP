<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String username = request.getParameter("username");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
             PrintWriter writer = new PrintWriter(out)) {

            String query;
            PreparedStatement pst;

            if (username != null && !username.isEmpty()) {
                query = "SELECT * FROM employee WHERE name = ?";
                pst = con.prepareStatement(query);
                pst.setString(1, username);
            } else {
                query = "SELECT * FROM employee";
                pst = con.prepareStatement(query);
            }

            try (ResultSet rs = pst.executeQuery()) {
                if (!rs.isBeforeFirst()) { // Check if ResultSet is empty
                    out.println("No employees found.");
                } else {
                    out.println("<table border='1'>");
                    out.println("<tr><th>Username</th><th>Salary</th></tr>");
                    while (rs.next()) {
                        String name = rs.getString("name");
                        String salary = rs.getString("salary");
                        out.println("<tr><td>" + name + "</td><td>" + salary + "</td></tr>");
                    }
                    out.println("</table>");
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace(new PrintWriter(out));
    }
%>
