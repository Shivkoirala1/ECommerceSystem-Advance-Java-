package com.ecommerce.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static DBConnection instance;
    private Connection connection;

    private static final String URL = firstNonBlank(System.getenv("ECOMMERCE_DB_URL"), "jdbc:mysql://localhost:3306/ecommerce_jsp?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
    private static final String USER = firstNonBlank(System.getenv("ECOMMERCE_DB_USER"), "root");
    private static final String PASSWORD = firstNonBlank(System.getenv("ECOMMERCE_DB_PASSWORD"), "1234");

    private static String firstNonBlank(String value, String fallback) {
        return (value != null && !value.isBlank()) ? value.trim() : fallback;
    }

    private DBConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }
    }

    public static synchronized DBConnection getInstance() throws SQLException {
        if (instance == null || instance.connection == null || instance.connection.isClosed()) {
            instance = new DBConnection();
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }

    public static Connection getActiveConnection() throws SQLException {
        return getInstance().getConnection();
    }
}
