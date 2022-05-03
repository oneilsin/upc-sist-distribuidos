package com.upc.bakery.biscuits.business;

import com.upc.bakery.biscuits.entities.Customer;
import com.upc.bakery.biscuits.models.CustomerCreateModel;
import com.upc.bakery.biscuits.models.CustomerModifyModel;
import com.upc.bakery.biscuits.models.EntityResponse;
import com.upc.bakery.biscuits.repositories.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Struct;

@Service
public class CustomerBusiness {

    @Autowired
    private CustomerRepository _customer;

    public EntityResponse getById(String idCustomer){
        var objC = _customer.getById(Long.parseLong(idCustomer));
        var objResponse = new EntityResponse();
        if(objC.getCustomerID()!=null){
            objResponse.setSuccess(true);
            Object data= new Object[]{
                    objC.getCustomerID(),
                    objC.getName(),
                    objC.getLastName(),
                    objC.getCardID(),
                    objC.getBirthday(),
                    objC.getGender(),
                    objC.getEmail(),
                    objC.getAddress(),
                    objC.getReference()
            };
            objResponse.setData(data);
        }else{
            objResponse.setSuccess(false);
        }
    return  objResponse;
    }

    public EntityResponse Create(CustomerCreateModel customer){
        var response = _customer.save(
                new Customer()
                        .toCreate(
                                customer.getName(),
                                customer.getEmail(),
                                customer.getPassword()
                        )
        );

        var objResponse = new EntityResponse();
        if(response.getCustomerID()!=null){
            objResponse.setSuccess(true);
            var value = new Customer();
            value.setCustomerID(response.getCustomerID());
            value.setName(response.getName());
            value.setLastName(response.getLastName());
            value.setCardID(response.getCardID());
            value.setEmail(response.getEmail());
            value.setRole(response.getRole());

            objResponse.setData(value);
        }
        return  objResponse;
    }

    public EntityResponse Modify(CustomerModifyModel customer){
        var objResponse= new    EntityResponse();
        var sex="";
        if(customer.isGender()){
            sex = "M";
        }else   {sex    ="F";}
        var ret = _customer.updateCustomer(customer.getCustomerName(),
                customer.getLastName(), customer.getCardID(),customer.getBirthday(),
                sex,customer.getPassword(),customer.getAddress(),
                customer.getReference(),customer.getCustomerID());

        if(ret>0) {
            var objCustomer = _customer.getById(customer.getCustomerID());
            var values = new Customer();
            objResponse.setSuccess(true);
            values.setCustomerID(objCustomer.getCustomerID());
            values.setName(objCustomer.getName());
            values.setLastName(objCustomer.getLastName());
            values.setCardID(objCustomer.getCardID());
            values.setEmail(objCustomer.getEmail());
            values.setRole(objCustomer.getRole());

            objResponse.setData(values);
        }else{
            objResponse.setSuccess(false);
        }

        return  objResponse;
    }
}
