<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "password");

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

        ResultSet rs = pst.executeQuery();

        if (!rs.isBeforeFirst()) { // Check if ResultSet is empty
            out.println("No employees found.");
        } else {
            out.println("<table border='1' style='border-collapse:collapse;'>");
            out.println("<tr><th>Username</th><th>Salary</th></tr>");
            while (rs.next()) {
                String name = rs.getString("name");
                String salary = rs.getString("salary");
                out.println("<tr><td>" + name + "</td><td>" + salary + "</td></tr>");
            }
            out.println("</table>");
        }

        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>