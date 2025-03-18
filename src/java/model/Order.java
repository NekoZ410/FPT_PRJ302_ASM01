/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Order {
    // attributes / fields
    private int orderID;
    private UserAccount UserID;
    private Product productID;
    private int quantity;
    private Date orderDate;
    private Date requiredDate;
    private int freight;  
    
    // constructor
    public Order() {
        this.quantity = 0;
    }

    public Order(int orderID, UserAccount UserID, Product productID, int quantity, Date orderDate, Date requiredDate, int freight) {
        this.orderID = orderID;
        this.UserID = UserID;
        this.productID = productID;
        this.quantity = quantity;
        this.orderDate = orderDate;
        this.requiredDate = requiredDate;
        this.freight = freight;
    }
    
    // getters
    public int getOrderID() {
        return orderID;
    }

    public UserAccount getUserID() {
        return UserID;
    }

    public Product getProductID() {
        return productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public Date getRequiredDate() {
        return requiredDate;
    }

    public int getFreight() {
        return freight;
    }

    // setters
    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public void setUserID(UserAccount UserID) {
        this.UserID = UserID;
    }

    public void setProductID(Product productID) {
        this.productID = productID;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public void setRequiredDate(Date requiredDate) {
        this.requiredDate = requiredDate;
    }

    public void setFreight(int freight) {
        this.freight = freight;
    }

    // others

}
