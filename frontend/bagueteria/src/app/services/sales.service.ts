import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class SalesService {

  constructor(private readonly http: HttpClient) { }

  createSale(data: any[]){
    return this.http.post<any>('https://localhost:44309/api/Sales/CreateSales',data);
  }

  getPayment(){
    return this.http.get<any>('https://localhost:44309/api/Sales/GetPayment');
  }
  
  getSalesByCustomer(idCustomer:number){
    return this.http.get<any>('https://localhost:44309/api/Sales/GetSalesByCustomer?idCustomer='+idCustomer);
  }
  getSalesDetail(idSales:number){
    return this.http.get<any>('https://localhost:44309/api/Sales/GetSalesDetailById?idSales='+idSales);
  }
  getSalesPending(){
    return this.http.get<any>('https://localhost:44309/api/Sales/GetPendingSales');
  }
  SetSaleDispatch(data: any[]){
    return this.http.post<any>('https://localhost:44309/api/Sales/SetSaleDispatch',data);
  }
}
