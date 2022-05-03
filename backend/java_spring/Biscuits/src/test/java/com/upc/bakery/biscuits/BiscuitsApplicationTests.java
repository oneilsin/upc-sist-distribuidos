package com.upc.bakery.biscuits;

import com.upc.bakery.biscuits.business.CustomerBusiness;
import com.upc.bakery.biscuits.models.CustomerCreateModel;
import org.junit.Assert;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.sql.Date;

@RunWith(SpringRunner.class)
@SpringBootTest
class BiscuitsApplicationTests {

  @Autowired
    private CustomerBusiness _customer;

  @Test
    void createCustomer(){
      var objCustomer = new CustomerCreateModel();
      objCustomer.setName("Alcides");
      objCustomer.setEmail("aleguia@upc.com");
      objCustomer.setPassword("123456");
      var response = _customer.Create(objCustomer);
      Assert.assertNotNull(response);
  }
/*
  @Test
  void editCustomer(){
    var objCustomer = new CustomerModifyModel();
    objCustomer.setCustomerName("Alcies aaa");
    objCustomer.setLastName("leguia ");
    objCustomer.setCardID("42805995");
    objCustomer.setBirthday(Date.valueOf("1984-12-10"));
    objCustomer.setGender(true);
    objCustomer.setPassword("123456");
    objCustomer.setAddress("La casa de don tito");
    objCustomer.setReference("cerca del rio");
    objCustomer.setCustomerID(Long.parseLong("1"));
    var response =_customer.Modify(objCustomer);
    Assert.assertTrue(response.isSuccess());
  }*/

}
