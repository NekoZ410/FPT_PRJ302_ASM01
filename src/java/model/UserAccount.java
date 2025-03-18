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
public class UserAccount {

    // attributes / fields
    private int userID;
    private String accountName;
    private String userName;
    private String password;
    private String role;
    private String email;
    private Date createdDate;

    // constructor
    public UserAccount() {
    }

    public UserAccount(int userID, String accountName, String userName, String password, String email, Date createdDate) {
        this.userID = userID;
        this.accountName = accountName;
        this.userName = userName;
        this.password = password;
        this.email = email;
        this.createdDate = createdDate;
        this.role = "User";
    }

    // getters
    
    public int getUserID() {
        return userID;
    }

    public String getAccountName() {
        return accountName;
    }

    public String getUserName() {
        return userName;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public Date getCreatedDate() {
        return createdDate;
    }
    
    public String getRole() {
        return role;
    }

    // setters

    public void setUserID(int userID) {
        this.userID = userID;
    }
    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
    public void setRole(String role) {
        this.role = role;
    }

    // others
}
