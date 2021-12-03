import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Food {
   private int foodID;
   private int categoryID;
   private String type;
   private String description;
   private String publicationDate;

   public Food(int id, int catID, String type, String desc, String pubDate) {
      this.foodID = id;
      this.categoryID = catID;
      this.type = type;
      this.description = desc;
      this.publicationDate = pubDate;
   }

   public static List<Food> search(String text) throws SQLException {
      String url = "jdbc:sqlite:sample.db";
      List<Food> foodList = new ArrayList<>();
      Food food; // hold a row food item
      try(Connection connection = DriverManager.getConnection(url)) {
         PreparedStatement searchStatement =
                 connection.prepareStatement("SELECT * FROM food" +
                         " WHERE description LIKE ?;");
         searchStatement.setString(1, "%" + text + "%");
         ResultSet results = searchStatement.executeQuery();

         while  (results.next()) {
            food = new Food(
                    results.getInt("fdc_id"),
                    results.getInt("food_category_id"),
                    results.getString("data_type"),
                    results.getString("description"),
                    results.getString("publication_date")
            );
            foodList.add(food);
         }
      }
      return foodList;
   }

   @Override
   public String toString() {
      return "Food{" +
              "foodID=" + foodID +
              ", categoryID=" + categoryID +
              ", type='" + type + '\'' +
              ", description='" + description + '\'' +
              ", publicationDate=" + publicationDate +
              '}';
   }
}
