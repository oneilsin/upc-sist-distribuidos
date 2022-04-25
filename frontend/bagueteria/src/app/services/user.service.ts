import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private readonly http: HttpClient) { }

  createAccount(data: any[]){
    return this.http.post<any>('https://localhost:44309/api/Customers/CreateCustomer',data);
  }

  startLogin(data: any[]){
    return this.http.post<any>('https://localhost:44309/api/Login/login',data);
  }

  modifyAccount(data: any[]){
    return this.http.post<any>('https://localhost:44309/api/Customers/ModifyCustomer',data);
  }
}
