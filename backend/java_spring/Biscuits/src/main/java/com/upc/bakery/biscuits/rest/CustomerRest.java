package com.upc.bakery.biscuits.rest;

import com.upc.bakery.biscuits.business.CustomerBusiness;
import com.upc.bakery.biscuits.models.CustomerCreateModel;
import com.upc.bakery.biscuits.models.CustomerModifyModel;
import com.upc.bakery.biscuits.models.EntityResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/Customers")
public class CustomerRest {

    @Autowired
    private CustomerBusiness _customer;

    @PostMapping("/CreateCustomer")
    public EntityResponse create(@RequestBody CustomerCreateModel model){
        return _customer.Create(model);
    }

    @PostMapping("/ModifyCustomer")
    public EntityResponse modify(@RequestBody CustomerModifyModel model){
        return _customer.Modify(model);
    }

    @GetMapping("/GetCustomerById")
    public EntityResponse getCustomerById(@RequestBody String idCustomer){
        return  _customer.getById(idCustomer);
    }
}
