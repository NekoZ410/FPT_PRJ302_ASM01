/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.*;

/**
 *
 * @author Admin
 */
public class OrderDAO extends MyDAO {

    public List<Order> getOrderList(int userID) {
        List<Order> l = new ArrayList<Order>();
        xSql = "select * from Orders where UserID = " + userID;

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            int xOrderID;
            UserAccount xUserID;
            Product xProductID;
            int xQuantity;
            Date xOrderDate;
            Date xRequiredDate;
            int xFreight;
            Order x;
            UserAccountDAO uad = new UserAccountDAO();
            ProductDAO pd = new ProductDAO();
            while (rs.next()) {
                xOrderID = rs.getInt("OrderID");
                xUserID = uad.getUserAccountByID(userID);
                xProductID = pd.getProductByID(rs.getInt("ProductID"));
                xQuantity = rs.getInt("Quantity");
                xOrderDate = rs.getDate("OrderDate");
                xRequiredDate = rs.getDate("RequiredDate");
                xFreight = rs.getInt("Freight");

                x = new Order(xOrderID, xUserID, xProductID, xQuantity, xOrderDate, xRequiredDate, xFreight);
                l.add(x);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }

    public Order getOrderByUserIDAndProductID(int userID, int productID) {
        int xOrderID;
        int xQuantity;
        int xFreight;
        Date xOrderDate;
        Date xRequiredDate;

        xSql = "select * from Orders where (UserID = ?) and (ProductID = ?)";
        Order x = new Order();
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userID);
            ps.setInt(2, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                xOrderID = rs.getInt("OrderID");
                xQuantity = rs.getInt("Quantity");
                xOrderDate = rs.getDate("OrderDate");
                xRequiredDate = rs.getDate("RequiredDate");
                xFreight = rs.getInt("Freight");

                x = new Order(xOrderID, new UserAccountDAO().getUserAccountByID(userID), new ProductDAO().getProductByID(productID), xQuantity, xOrderDate, xRequiredDate, xFreight);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }

    public void insertOrder(Order x) {

        xSql = "insert into Orders (UserID, ProductID, Quantity, Freight) values (?, ?, ?, ?)";
        try {

            ps = con.prepareStatement(xSql);
            ps.setInt(1, x.getUserID().getUserID());
            ps.setInt(2, x.getProductID().getProductID());
            ps.setInt(3, x.getQuantity());
            ps.setInt(4, x.getFreight());

            ps.executeUpdate();

            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteOrder(int userID, int OrderID) {
        xSql = "delete from Orders where (OrderID = ?) and (userID = ?)";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, OrderID);
            ps.setInt(2, userID);
            ps.executeUpdate();
            //con.commit();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void freeShip(int userID, int productID) {
        xSql = "update Orders set Freight = 0 where UserID = ? and ProductID = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userID);
            ps.setInt(2, productID);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
