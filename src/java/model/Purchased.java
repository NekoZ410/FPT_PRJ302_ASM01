/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Purchased {
    private UserAccount UserID;
    private int purchasedID;
    private Product productID;
    private int quantity;
    private Date purchasedDate;
    private int freight;  

    public Purchased() {
    }

    public Purchased(UserAccount UserID, int purchasedID, Product productID, int quantity, Date purchasedDate, int freight) {
        this.UserID = UserID;
        this.purchasedID = purchasedID;
        this.productID = productID;
        this.quantity = quantity;
        this.purchasedDate = purchasedDate;
        this.freight = freight;
    }

    public UserAccount getUserID() {
        return UserID;
    }

    public void setUserID(UserAccount UserID) {
        this.UserID = UserID;
    }

    public int getPurchasedID() {
        return purchasedID;
    }

    public void setPurchasedID(int purchasedID) {
        this.purchasedID = purchasedID;
    }

    public Product getProductID() {
        return productID;
    }

    public void setProductID(Product productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getPurchasedDate() {
        return purchasedDate;
    }

    public void setPurchasedDate(Date purchasedDate) {
        this.purchasedDate = purchasedDate;
    }

    public int getFreight() {
        return freight;
    }

    public void setFreight(int freight) {
        this.freight = freight;
    }
    
    
}
