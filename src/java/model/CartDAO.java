package model;

import java.util.*;

public class CartDAO extends MyDAO {

    public List<Cart> getCartList(int userID) {
        List<Cart> l = new ArrayList<>();
        xSql = "select * from Carts where UserID = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userID);
            rs = ps.executeQuery();

            int cartID;
            String xDescription;
            Product productID;
            int quantity;
            Cart x;
            while (rs.next()) {
                cartID = rs.getInt("CartID");
                productID = new ProductDAO().getProductByID(rs.getInt("ProductID"));
                quantity = rs.getInt("Quantity");
                x = new Cart(new UserAccountDAO().getUserAccountByID(userID), cartID, productID, quantity);
                l.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }

    public Cart getCartByUserIDAndProductID(int userID, int productID) {
        int xCartID;
        int xQuantity;
        Cart x = new Cart();
        xSql = "select * from Carts where (UserID = ?) and (ProductID = ?)";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userID);
            ps.setInt(2, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                xCartID = rs.getInt("CartID");
                xQuantity = rs.getInt("Quantity");

                x = new Cart(new UserAccountDAO().getUserAccountByID(userID), xCartID, new ProductDAO().getProductByID(productID), xQuantity);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }

    public void insertCart(Cart x) {
        xSql = "insert into Carts (UserID, ProductID, Quantity) values (?, ?, ?)";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, x.getUserID().getUserID());
            ps.setInt(2, x.getProductID().getProductID());
            ps.setInt(3, x.getQuantity());

            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCart(int userID, int cartID) {
        xSql = "delete from Carts where CartID = ? and UserID = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, cartID);
            ps.setInt(2, userID);

            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

 
}
