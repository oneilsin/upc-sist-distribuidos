import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { SalesService } from 'src/app/services/sales.service';

@Component({
  selector: 'app-delivery',
  templateUrl: './delivery.component.html',
  styleUrls: ['./delivery.component.css']
})
export class DeliveryComponent implements OnInit {
  saleList: any[] = [];
  count:any;
  userForm = this.fb.group({
    nombres: [''],
    idUsuario: ['']
  });
  deliveryForm = this.fb.group({
    employeeID: ['', [Validators.required, Validators.maxLength(1)]],
    attendedStatus: [false, [Validators.required]],
    salesID: ['', [Validators.required, Validators.maxLength(1)]]
  });
  constructor(private fb: FormBuilder,
    private readonly salesService: SalesService) { }

  initUserInfo() {
    var _token = sessionStorage.getItem('token');
    if (_token == null) return;

    var data = JSON.parse(_token);
    this.userForm.patchValue({
      nombres: data.nombres,
      idUsuario: data.idUsuario
    });
  };

  getPending() {
    this.salesService.getSalesPending().subscribe((rest: any) => {
      if (rest.isSuccess) {
       // console.log(rest);
        this.saleList = rest.data;
        this.count= this.saleList.length;
      };
    });
  };

  selectDispatched(idSales: Number) {
    var _customerID = Number(this.userForm.get('idUsuario')?.value);
    this.deliveryForm.patchValue({
      salesID: idSales,
      employeeID: _customerID
    })
  }

  saveDispatched() {
    if (this.deliveryForm.valid) {
      confirm("¿Estás seguro de registrar el despacho para este cliente?.");
      //console.log(this.deliveryForm.value);
      this.salesService.SetSaleDispatch(this.deliveryForm.value).subscribe((rest: any) => {
        if (rest.isSuccess) {
          alert("El despacho se ha registrado correctamente.");
          this.getPending();
        }
      });
    }

  }
  ngOnInit(): void {
    this.initUserInfo();
    this.getPending();
  }

}
