package com.upc.bakery.biscuits.models;

import java.util.Date;

public class CustomerModifyModel {
    private String CustomerName;
    private String LastName;
    private String CardID;
    private Date Birthday;
    private boolean Gender;
    private String Password;
    private String Address;
    private String Reference;
    private Long CustomerID;

    public CustomerModifyModel() {
    }

    public String getCustomerName() {
        return CustomerName;
    }

    public void setCustomerName(String customerName) {
        CustomerName = customerName;
    }

    public String getLastName() {
        return LastName;
    }

    public void setLastName(String lastName) {
        LastName = lastName;
    }

    public String getCardID() {
        return CardID;
    }

    public void setCardID(String cardID) {
        CardID = cardID;
    }

    public Date getBirthday() {
        return Birthday;
    }

    public void setBirthday(Date birthday) {
        Birthday = birthday;
    }

    public boolean isGender() {
        return Gender;
    }

    public void setGender(boolean gender) {
        Gender = gender;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String address) {
        Address = address;
    }

    public String getReference() {
        return Reference;
    }

    public void setReference(String reference) {
        Reference = reference;
    }

    public Long getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(Long customerID) {
        CustomerID = customerID;
    }
}
