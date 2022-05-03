package com.upc.bakery.biscuits.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.util.Date;

@Entity
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long CustomerID;
    private String Name;
    private String LastName;
    private String CardID;
    private Date Birthday;
    private String Gender;
    private String Email;
    private String Address;
    private String Reference;
    private String Password;
    private String Role;
    private boolean Deleted;

    public Customer() {
    }

    public Customer(Long customerID, String name, String lastName, String cardID, Date birthday, String gender, String email, String address, String reference, String password, String role, boolean deleted) {
        CustomerID = customerID;
        Name = name;
        LastName = lastName;
        CardID = cardID;
        Birthday = birthday;
        Gender = gender;
        Email = email;
        Address = address;
        Reference = reference;
        Password = password;
        Role = role;
        Deleted = deleted;
    }

    public Customer toCreate(String name, String email, String password){
        this.Name = name;
        this.LastName = "";
        this.CardID = "";
        this.Birthday = null;
        this.Gender = null;
        this.Email = email;
        this.Address = null;
        this.Reference = null;
        this.Password = password;
        this.Role = "customer";
        this.Deleted = false;

        return  this;
    }

    public Long getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(Long customerID) {
        CustomerID = customerID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
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

    public String getGender() {
        return Gender;
    }

    public void setGender(String gender) {
        Gender = gender;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
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

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public String getRole() {
        return Role;
    }

    public void setRole(String role) {
        Role = role;
    }

    public boolean isDeleted() {
        return Deleted;
    }

    public void setDeleted(boolean deleted) {
        Deleted = deleted;
    }
}
