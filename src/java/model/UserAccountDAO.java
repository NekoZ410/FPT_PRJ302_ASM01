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
public class UserAccountDAO extends MyDAO {

    public List<UserAccount> getUserAccountList() {
        List<UserAccount> l = new ArrayList<UserAccount>();
        xSql = "select * from UserAccounts";

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();

            int xUserID;
            String accountName;
            String userName;
            String password;
            String email;
            UserAccount x;
            Date createdDate;

            while (rs.next()) {
                xUserID = rs.getInt("UserID");
                accountName = rs.getString("AccountName");
                userName = rs.getString("userName");
                password = rs.getString("password");

                email = rs.getString("Email");
                createdDate = rs.getDate("CreatedDate");

                x = new UserAccount(xUserID, accountName, userName, password, email, createdDate);
                l.add(x);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }

    public List<UserAccount> getUserAccountByName(String name) {
        List<UserAccount> l = new ArrayList<UserAccount>();
        xSql = "select * from UserAccounts WHERE UserName LIKE ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();

            int xUserID;
            String accountName;
            String userName;
            String password;
            String email;
            Date createdDate;
            UserAccount x;

            while (rs.next()) {
                xUserID = rs.getInt("UserID");
                accountName = rs.getString("AccountName");
                userName = rs.getString("userName");
                password = rs.getString("password");
                createdDate = rs.getDate("CreatedDate");
                email = rs.getString("Email");

                x = new UserAccount(xUserID, accountName, userName, password, email, createdDate);
                l.add(x);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }

    public UserAccount getUserAccountByID(int userID) {
        String accountName;
        String userName;
        String password;
        String email;
        Date createdDate;
        UserAccount x = new UserAccount();
        xSql = "select * from UserAccounts where UserID = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userID);

            rs = ps.executeQuery();
            if (rs.next()) {

                accountName = rs.getString("AccountName");
                userName = rs.getString("UserName");
                password = rs.getString("Password");
                email = rs.getString("Email");
                createdDate = rs.getDate("CreatedDate");

                x = new UserAccount(userID, accountName, userName, password, email, createdDate);
                x.setRole(rs.getString("Role"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }

    public UserAccount getUserAccountByAccountNamePassword(String accountName, String password) {
        int userID;
        String userName;
        String email;
        Date createdDate;
        UserAccount x = null;
        xSql = "SELECT * FROM UserAccounts WHERE AccountName = ? and Password = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, accountName);
            ps.setString(2, password);

            rs = ps.executeQuery();
            if (rs.next()) {
                userID = rs.getInt("UserID");
                userName = rs.getString("UserName");
                email = rs.getString("Email");
                createdDate = rs.getDate("CreatedDate");
                x = new UserAccount(userID, accountName, userName, password, email, createdDate);
                x.setRole(rs.getString("Role"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
    }

    public UserAccount getUserAccountByAccountName(String accountName) {
        int userID;
        String userName;
        String password;
        String email;
        Date createdDate;
        UserAccount x = null;
        xSql = "SELECT * FROM UserAccounts WHERE AccountName = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, accountName);

            rs = ps.executeQuery();
            if (rs.next()) {
                userID = rs.getInt("UserID");
                userName = rs.getString("UserName");
                password = rs.getString("Password");
                email = rs.getString("Email");
                createdDate = rs.getDate("CreatedDate");
                x = new UserAccount(userID, accountName, userName, password, email, createdDate);
                x.setRole(rs.getString("Role"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
    }

    public UserAccount getUserAccountByEmail(String email) {
        int userID;
        String userName;
        String accountName;
        String password;
        Date createdDate;
        UserAccount x = null;
        xSql = "SELECT * FROM UserAccounts WHERE Email = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, email);

            rs = ps.executeQuery();
            if (rs.next()) {
                userID = rs.getInt("UserID");
                accountName = rs.getString("AccountName");
                userName = rs.getString("UserName");
                password = rs.getString("Password");
                createdDate = rs.getDate("CreatedDate");
                x = new UserAccount(userID, accountName, userName, password, email, createdDate);
                x.setRole(rs.getString("Role"));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
    }

    public void updatePassword(String accountName, String newPassword) {
        xSql = "UPDATE UserAccounts SET Password = ? WHERE AccountName = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, newPassword);
            ps.setString(2, accountName);

            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertUserAccount(String accountName, String userName, String password, String email) {
        xSql = "insert into UserAccounts (AccountName, UserName, Password, Role, Email) values (?, ?, ?, ?, ?)";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, accountName);
            ps.setString(2, userName);
            ps.setString(3, password);
            ps.setString(4, "User");
            ps.setString(5, email);

            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<UserAccount> sortUserAccountByName() {
        List<UserAccount> oldList = getUserAccountList();

        List<UserAccount> newList = new ArrayList<>(oldList);
        newList.sort(Comparator.comparing(UserAccount::getUserName));

        return newList;
    }

    public void deleteUserAccount(int userID) {
        xSql = "delete from UserAccounts where UserID = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userID);

            ps.executeUpdate();
            //con.commit();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    public void updateUserAccount(UserAccount x) {
//        xSql = "update UserAccounts set Password = ?, Role = ?, Email = ? where ";
//
//        try {
//            ps = con.prepareStatement(xSql);
//            ps.setString(1, x.getPassword());
//            ps.setString(2, x.getRole());
//            ps.setString(3, x.getEmail());
//            ps.setString(4, x.getPhone());
//
//            ps.setInt(5, x.getUserID());
//            ps.executeUpdate();
//            ps.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
}
