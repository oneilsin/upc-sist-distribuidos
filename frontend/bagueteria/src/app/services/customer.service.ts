import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {

  constructor(private readonly http: HttpClient ) { }

  getCustomerById(idCustomer: Number){
    return this.http.get<any>('http://ww2.jockeyclub.org.pe:8086/api/Customers/GetCustomerById?idCustomer='+idCustomer);
  }

}
