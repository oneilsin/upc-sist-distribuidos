import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  title = 'Los cachidos de don Carlos';
  isLog = false;
  isEmployee = false;
  countCart = 0;
  token: any[] = [];

  userForm = this.fb.group({
    nombres: [''],
    email: ['']
  });

  constructor(private fb: FormBuilder,
    private readonly router: Router) {
  }

  logOut() {
    sessionStorage.removeItem('token');
    sessionStorage.removeItem('cart');
    this.router.navigate(["product"]);
    this.isLog = false;
    this.isEmployee = false;
  }

  _setLogin() {
    let _token = sessionStorage.getItem('token');
    if (_token != null) {
      var data = JSON.parse(_token);
      
      this.userForm.patchValue({
        nombres: data.nombres,
        email: data.email
      });
    } else {
      this.userForm.patchValue({
        nombres: '',
        email: ''
      });
      //console.log("abrir Login")
      //  this.router.navigate(["login"]);

    }


  };

  ngOnInit(): void {
    this._setLogin();

    let _token = sessionStorage.getItem('token');
    if(_token==null)return;
    
    var data = JSON.parse(_token);

    if (data != null) {
      this.isLog = true;
      this.countCart=Number(sessionStorage.getItem('cart'));
      if (data.role == "employee") {
        this.isEmployee = true;
      } else { this.isEmployee = false; }

     // console.log(data);
    } else {
      this.isLog = false;
    }
  }
}
