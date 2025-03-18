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
public class Payment {
    // attributes / fields
    public UserAccount userID;
    public int paymentID;
    public String paymentMethod;
    public Date paymentDate;
    public double price;
    
    // constructor
    public Payment() {
    }

    public Payment(UserAccount userID, int paymentID, String paymentMethod, Date paymentDate, double price) {
        this.userID = userID;
        this.paymentID = paymentID;
        this.paymentMethod = paymentMethod;
        this.paymentDate = paymentDate;
        this.price = price;
    }
    
    // getters

    public UserAccount getUserID() {
        return userID;
    }

    public int getPaymentID() {
        return paymentID;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public double getPrice() {
        return price;
    }
    
    // setters

    public void setUserID(UserAccount userID) {
        this.userID = userID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    // others

}
