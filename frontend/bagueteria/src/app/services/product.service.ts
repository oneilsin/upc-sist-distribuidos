import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AnyForUntypedForms } from '@angular/forms';

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  constructor(private readonly http: HttpClient ) { }

  getProductByCategory(id: number){
    return this.http.get<any>('http://ww2.jockeyclub.org.pe:8086/api/Products/GetStockByCategory?idCategory='+id);
  }

  addToCart(data: any[]){
    return this.http.post<any>('http://ww2.jockeyclub.org.pe:8086/api/Products/AddToCart',data);
  }

  editToCart(data: any[]){
    return this.http.post<any>('http://ww2.jockeyclub.org.pe:8086/api/Products/EditToCart',data);
  }

  getCartItems(idCustomer:number){
    return this.http.get<any>('http://ww2.jockeyclub.org.pe:8086/api/Products/GetCartByCustomer?idCustomer='+idCustomer);
  }
}
