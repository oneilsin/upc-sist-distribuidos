import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ProductService } from 'src/app/services/product.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  create: any;
  
  loginForm = this.fb.group({
    user: ['', [Validators.required, Validators.email]],
    password: ['', [Validators.required, Validators.minLength(6)]]
  });

  addForm = this.fb.group({
    name: ['', [Validators.required, Validators.minLength(10)]],
    password: ['', [Validators.required, Validators.minLength(6)]],
    email: ['', [Validators.required, Validators.email]],
  });

  editForm = this.fb.group({
    editName: ['', [Validators.required, Validators.minLength(10)]],
  });

  constructor(private fb: FormBuilder,
    private readonly userService: UserService,
    private readonly cartService: ProductService) { }


    enableCreate(){
      this.create=true;
    }
    enableLogin(){
      this.create=false;
    }
  createAccount() {    
    this.addForm.patchValue({
      password: this.loginForm.get('password')?.value,
      email: this.loginForm.get('user')?.value,
    });
    //console.log(this.addForm.value);
    if (this.addForm.value) {
      this.userService.createAccount(this.addForm.value).subscribe((rest: any) => {
        //console.log(rest);
        if (rest.isSuccess) {
          //console.log(rest.isSuccess);
          sessionStorage.setItem('token', JSON.stringify(rest.data));
          this.countCart(Number(rest.data.idUsuario));
          // this.router.navigate(["product"]);
          // window.location.reload();
          window.location.href = "/product";
        } else {
          alert(rest.errorMessage);
        }
      });
    }
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
       // console.log(rest);
        if (rest.isSuccess) {
          sessionStorage.setItem('token', JSON.stringify(rest.data));
          this.countCart(Number(rest.data.idUsuario));
          if (rest.data.role == "employee") {
            window.location.href = "/delivery";
          } else {
            window.location.href = "/product";
          }

          // this.router.navigateByUrl("./views/product", { skipLocationChange: true }).then(() => {
          //   // console.log(decodeURI(this._location.path()));
          //   // this._router.navigate([decodeURI(this._location.path())]);
          //   });

          //this.router.navigate(["product"]);  
          //window.location.reload();
        } else {
          alert(rest.errorMessage);
        }
      })
    }
  }

  ngOnInit(): void {
    this.create=false;
  }

}
