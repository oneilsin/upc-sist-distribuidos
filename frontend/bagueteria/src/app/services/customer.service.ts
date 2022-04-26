import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {

  constructor(private readonly http: HttpClient ) { }

  getCustomerById(idCustomer: Number){
    return this.http.get<any>('https://localhost:44309/api/Customers/GetCustomerById?idCustomer='+idCustomer);
  }

}
