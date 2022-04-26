import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { CustomerService } from 'src/app/services/customer.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {
  _id: any;
  _mail: any;
  userList: any[] = [];
  profileForm = this.fb.group({
    customerName: ['', [Validators.required, Validators.minLength(3)]],
    lastName: ['', [Validators.required, Validators.minLength(3)]],
    cardID: ['', [Validators.required, Validators.minLength(8)]],
    bithday: ['', [Validators.required, Validators.minLength(10)]],
    gender: [false, [Validators.required]],
    password: ['', [Validators.required, Validators.minLength(4)]],
    address: ['', [Validators.required, Validators.minLength(2)]],
    referece: [''],
    customerID: ['', [Validators.required, Validators.minLength(1)]],
  });
  constructor(private fb: FormBuilder,
    private readonly customerService: CustomerService,
    private readonly userService: UserService) { }

  initUserInfo() {
    var _token = sessionStorage.getItem('token');
    if (_token == null) return;

    var data = JSON.parse(_token);
    this._id = data.idUsuario;
  };

  loadData() {
    this.customerService.getCustomerById(1).subscribe((rest: any) => {
      if (rest.isSuccess) {
        // var _sex = rest.data.gender=="M"?true:false;
        this.profileForm.patchValue({
          customerName: rest.data.name,
          lastName: rest.data.lastName,
          cardID: rest.data.cardID,
          bithday: rest.data.bithday,
          gender: rest.data.gender,
          password: rest.data.password,
          address: rest.data.address,
          referece: rest.data.referece,
          customerID: rest.data.customerID
        });
        this._mail = rest.data.email;
        //console.log(rest.data.gender);
        //console.log(rest.data.password);
        //console.log(this.profileForm.value);
      }
    })
  }


  loginForm = this.fb.group({
    user: ['', [Validators.required, Validators.email]],
    password: ['', [Validators.required, Validators.minLength(6)]]
  });
  update() {
    if (this.profileForm.valid) {

      this.userService.modifyAccount(this.profileForm.value).subscribe((rest: any) => {
        //console.log(rest);
        if (rest.isSuccess) {
          //console.log(this.profileForm.value)
          //this.loadData();

          //Actualizar token-storage
          this.loginForm.patchValue({
            user: this._mail,
            password: this.profileForm.get('password')?.value
          });

          this.userService.startLogin(this.loginForm.value).subscribe((rlg: any) => {
            if (rlg.isSuccess) {
              sessionStorage.removeItem('token');
              sessionStorage.setItem('token', JSON.stringify(rlg.data));
            }
          })

          window.location.reload();
        }
      });
    }
  }
  ngOnInit(): void {
    this.initUserInfo();
    this.loadData();
  }

}
