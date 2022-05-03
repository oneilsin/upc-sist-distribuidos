import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class SalesService {

  constructor(private readonly http: HttpClient) { }

  createSale(data: any[]){
    return this.http.post<any>('http://ww2.jockeyclub.org.pe:8086/api/Sales/CreateSales',data);
  }

  getPayment(){
    return this.http.get<any>('http://ww2.jockeyclub.org.pe:8086/api/Sales/GetPayment');
  }
  
  getSalesByCustomer(idCustomer:number){
    return this.http.get<any>('http://ww2.jockeyclub.org.pe:8086/api/Sales/GetSalesByCustomer?idCustomer='+idCustomer);
  }
  getSalesDetail(idSales:number){
    return this.http.get<any>('http://ww2.jockeyclub.org.pe:8086/api/Sales/GetSalesDetailById?idSales='+idSales);
  }
  getSalesPending(){
    return this.http.get<any>('http://ww2.jockeyclub.org.pe:8086/api/Sales/GetPendingSales');
  }
  SetSaleDispatch(data: any[]){
    return this.http.post<any>('http://ww2.jockeyclub.org.pe:8086/api/Sales/SetSaleDispatch',data);
  }
}
