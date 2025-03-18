/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.SQLException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class PurchasedDAO extends MyDAO {

    public List<Purchased> getPurchasedList(int userID, int purchasedID) {
        List<Purchased> l = new ArrayList<Purchased>();
        xSql = "select * from Purchased where UserID = " + userID + " and PurchasedID = " + purchasedID;

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            int xPurchasedID;
            UserAccount xUserID;
            Product xProductID;
            int xQuantity;
            Date xPurchasedDate;

            int xFreight;
            Purchased x;
            UserAccountDAO uad = new UserAccountDAO();
            ProductDAO pd = new ProductDAO();
            while (rs.next()) {
                xPurchasedID = rs.getInt("PurchasedID");
                xUserID = uad.getUserAccountByID(userID);
                xProductID = pd.getProductByID(rs.getInt("ProductID"));
                xQuantity = rs.getInt("Quantity");
                xPurchasedDate = rs.getDate("PurchasedDate");
                xFreight = rs.getInt("Freight");

                x = new Purchased(xUserID, purchasedID, xProductID, xQuantity, xPurchasedDate, xFreight);
                l.add(x);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }

    public int getMaxPurchasedIDByUserID(int userID) {
        int purchasedID = 0;
        xSql = "  SELECT MAX(PurchasedID) AS maxID\n"
                + "  FROM Purchased\n"
                + "  WHERE UserID = " + userID;
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            if (rs.next()) {
                purchasedID = rs.getInt("maxID");
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(PurchasedDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return purchasedID;
    }

    public void insertPurchased(int userID, List<Order> listOrder) {
        int purchasedID = getMaxPurchasedIDByUserID(userID) + 1;

        xSql = "insert into Purchased(UserID, PurchasedID, ProductID, Quantity, Freight) VALUES";

        for (int i = 0; i < listOrder.size(); i++) {
            if (i != (listOrder.size() - 1)) {
                xSql += "(" + userID + ", " + purchasedID + ", " + listOrder.get(i).getProductID().getProductID() + ", " + listOrder.get(i).getQuantity() + ", " + listOrder.get(i).getFreight() + "),\n";
            } else {
                xSql += "(" + userID + ", " + purchasedID + ", " + listOrder.get(i).getProductID().getProductID() + ", " + listOrder.get(i).getQuantity() + ", " + listOrder.get(i).getFreight() + ")";
            }
        }

        try {
            ps = con.prepareStatement(xSql);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(PurchasedDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
