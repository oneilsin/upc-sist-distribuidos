package com.upc.bakery.biscuits.repositories;

import com.upc.bakery.biscuits.entities.Customer;
import com.upc.bakery.biscuits.models.EntityResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.util.Date;

public interface CustomerRepository extends JpaRepository<Customer,Long> {

    @Query("SELECT c FROM Customer c WHERE c.CardID=:idCard")
    EntityResponse findCustomerByDocument(String idCard);

    @Modifying
    @Transactional
    @Query("UPDATE Customer c SET c.Name=:name, c.LastName=:lastName,c.CardID=:card," +
            "c.Birthday=:birth, c.Gender=:sex,c.Password=:pass,c.Address=:adders, c.Reference=:ref " +
            "WHERE c.CustomerID=:id")
    int updateCustomer(@Param("name")String name,@Param("lastName")String lastName,
                                  @Param("card")String card,@Param("birth")Date birth,
                                  @Param("sex")String sex,@Param("pass")String pass,
                                  @Param("adders")String adders,@Param("ref")String ref,
                                  @Param("id")Long id);

}
