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
public class Review {
    // attributes / fields    
    private Product productID;
    private int reviewID;
    private UserAccount userID;
    private int rating;
    private String comment;
    private Date reviewDate;
    
    // constructor
    public Review() {
    }

    public Review(Product productID, int reviewID, UserAccount userID, int rating, String comment, Date reviewDate) {
        this.productID = productID;
        this.reviewID = reviewID;
        this.userID = userID;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
    }
    
    // getters
    public UserAccount getUserID() {
        return userID;
    }

    public int getReviewID() {
        return reviewID;
    }

    public Product getProductID() {
        return productID;
    }

    public int getRating() {
        return rating;
    }

    public String getComment() {
        return comment;
    }

    public Date getReviewDate() {
        return reviewDate;
    }
    
    // setters
    public void setUserID(UserAccount userID) {
        this.userID = userID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public void setProductID(Product productID) {
        this.productID = productID;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }
	
    // others
}
