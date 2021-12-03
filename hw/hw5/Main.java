import java.sql.*;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) throws SQLException {
        String url = "jdbc:sqlite:sample.db";
        try(Connection connection = DriverManager.getConnection(url)) {
            create(connection, 234, 23.45f,
                    "random-comment-234");
            retrieve(connection, 59);
            update(connection, 59, 99.35f);
            retrieve(connection, 59);
            delete(connection, 58);
            list(connection);
        }

        List<Food> foodList;
        foodList = Food.search("steak");
        // print 10 items from search result
        for (int i = 0; i < 10 && i < foodList.size(); i++) {
            System.out.println(foodList.get(i));
        }

    }

    public static void list(Connection connection) throws SQLException {
        PreparedStatement listStatement =
                connection.prepareStatement("SELECT * FROM food_journal;");
        System.out.println("ID, Food ID,Quantity, Comment, Eaten At");
        ResultSet results = listStatement.executeQuery();
        while  (results.next()) {
            System.out.printf("%d, %d, %f, %s, %s\n",
                results.getInt("id"),
                results.getInt("food_portion_id"),
                results.getFloat("quantity"),
                results.getString("comment"),
                results.getTimestamp("eaten_at")
            );
        }
    }

    public static void create(Connection connection, int foodId, float val,
                              String comment) throws SQLException{
        String statement = "INSERT INTO food_journal (food_portion_id," +
                "quantity,comment,eaten_at) VALUES(?,?,?,?);";
        PreparedStatement insertStatement = connection.prepareStatement(statement);

        insertStatement.setInt(1, foodId);
        insertStatement.setFloat(2, val);;
        insertStatement.setString(3, comment);
        insertStatement.setTimestamp(4, Timestamp.from(Instant.now()));
        if(insertStatement.executeUpdate() == 1) {
            System.out.println("Inserted Successfully");
        }
    }

    public static void retrieve(Connection connection, int id)
            throws SQLException {
        PreparedStatement retrieveStatement =
                connection.prepareStatement(
            "SELECT * FROM food_journal WHERE id = ?;");

        retrieveStatement.setInt(1,id);
        System.out.println("ID, Food ID,Quantity, Comment, Eaten At");
        ResultSet results = retrieveStatement.executeQuery();
        while  (results.next()) {
            System.out.print(results.getInt("id"));
            System.out.print(", ");
            System.out.print(results.getInt("food_portion_id"));
            System.out.print(", ");
            System.out.print(results.getFloat("quantity"));
            System.out.print(", ");
            System.out.print(results.getString("comment"));
            System.out.print(", ");
            System.out.print(results.getTimestamp("eaten_at"));
            System.out.println();
        }

    }

    public static void update(Connection connection, int id, float val)
            throws SQLException {

        PreparedStatement updateStatement = connection.prepareStatement(
                "UPDATE food_journal SET quantity = ? WHERE id = ?;"
        );
        updateStatement.setFloat(1, val);
        updateStatement.setInt(2,id);
        updateStatement.executeUpdate();
        if(updateStatement.executeUpdate() == 1) {
            System.out.println("Update Successfully!");
        }

    }

    public static void delete(Connection connection, int id)
            throws SQLException {
        PreparedStatement deleteStatement = connection.prepareStatement(
            "DELETE FROM food_journal WHERE id = ?;"
        );
        deleteStatement.setInt(1, id);
        deleteStatement.executeUpdate();
        if(deleteStatement.executeUpdate() == 1) {
            System.out.println("Deleted Successfully!");
        }
    }
}
