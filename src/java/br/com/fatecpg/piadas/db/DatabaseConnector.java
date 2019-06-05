package br.com.fatecpg.piadas.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DatabaseConnector {
    public static final String DRIVER = "org.apache.derby.jdbc.ClientDriver";
    public static final String URL = "jdbc:derby://localhost:1527/piadasdb";
    public static final String USER = "piadmin";
    public static final String PASS = "piadmin";
    
    public static Connection getConnection() throws Exception {
        Class.forName(DRIVER);
        return DriverManager.getConnection(URL, USER, PASS);
    }
    
    public static ArrayList<Object[]> getQuery(String sql, Object[] parameters) throws Exception {
        ArrayList<Object[]> list = new ArrayList<>();
        Class.forName(DRIVER);
        try (Connection connection = getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            for (int index = 0; index < parameters.length; index++) {
                statement.setObject(index + 1, parameters[index]);
            }
            ResultSet results = statement.executeQuery();
            while (results.next()) {
                int columnCount = results.getMetaData().getColumnCount();
                Object row[] = new Object[columnCount];
                for (int index = 0; index < columnCount; index++) {
                    row[index] = results.getObject(index + 1);
                }
                list.add(row);
            }
            results.close(); statement.close();
        }
        return list;
    }
    
    public static boolean insertQuery(String sql, Object[] parameters) throws Exception {
        Class.forName(DRIVER);
        Connection connection = getConnection();
        PreparedStatement statement = connection.prepareStatement(sql);
        for (int index = 0; index < parameters.length; index++) {
            statement.setObject(index + 1, parameters[index]);
        }
        int results = statement.executeUpdate();
        if (results > 0) {
            statement.close();
            return true;
        } else {
            statement.close();
            return false;
        }
    }
    
    public static boolean updateQuery(String sql, Object[] parameters) throws Exception {
        Class.forName(DRIVER);
        Connection connection = getConnection();
        PreparedStatement statement = connection.prepareStatement(sql);
        for (int index = 0; index < parameters.length; index++) {
            statement.setObject(index + 1, parameters[index]);
        }
        int results = statement.executeUpdate();
        if (results > 0) {
            statement.close();
            return true;
        } else {
            statement.close();
            return false;
        }
    }
}
