import { Component, OnInit } from '@angular/core';
import { AnyForUntypedForms, FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ProductService } from 'src/app/services/product.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  loginForm = this.fb.group({
    user: ['', [Validators.required, Validators.email]],
    password: ['', [Validators.required, Validators.minLength(6)]]
  });

  addForm = this.fb.group({
    addName: ['', Validators.required, Validators.minLength(10)],
    addEmail: ['', [Validators.required, Validators.email]],
    addPassword: ['', [Validators.required, Validators.minLength(6)]]
  });

  editForm = this.fb.group({
    editName: ['', Validators.required, Validators.minLength(10)],
  });

  constructor(private fb: FormBuilder,
    private readonly userService: UserService,
    private readonly cartService: ProductService,
    private readonly router: Router) { }


  createAccount(data: any[]) {
    this.userService.createAccount(data).subscribe((rest: any) => {
      if (rest.isSuccess) {
        sessionStorage.setItem('token', JSON.stringify(rest.data));
        this.countCart(Number(rest.data.idUsuario));
        this.router.navigate(["product"]);
      } else {
        alert(rest.errorMessage);
      }
    });
  };

  countCart(id: Number) {
    var _cartCount = 0;
    this.cartService.getCartItems(Number(id)).subscribe((rs: any) => {
      if (rs.isSuccess) {
        _cartCount = rs.data.length;
        sessionStorage.setItem('cart', String(_cartCount));
        console.log(rs.data.length);
      }
    });   
  }

  startLogin() {
    if (this.loginForm.valid) {
      this.userService.startLogin(this.loginForm.value).subscribe((rest: any) => {
        if (rest.isSuccess) {
          sessionStorage.setItem('token', JSON.stringify(rest.data));
          this.countCart(Number(rest.data.idUsuario));
          this.router.navigate(["product"]);
        } else {
          alert(rest.errorMessage);
        }
      })
    }
  //  console.log(this.loginForm.value);
  }

  _cAccount(name: any, mail: any, password: any) {
    this.addForm.patchValue({
      addName: name,
      addEmail: mail,
      addPassword: password
    });
  }
  _eAccount(name: any, mail: any, password: any) {
    this.editForm.patchValue({
      editName: name,
    });
  }

  ngOnInit(): void {

  }

}
