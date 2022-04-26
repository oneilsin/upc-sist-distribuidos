import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';

import { ReactiveFormsModule } from "@angular/forms";

import { AppComponent } from './app.component';
import { HomeComponent } from './views/home/home.component';
import { LoginComponent } from './account/login/login.component';
import { ProfileComponent } from './account/profile/profile.component';
import { CartComponent } from './views/cart/cart.component';
import { ProductComponent } from './views/product/product.component';
import { SalesComponent } from './views/sales/sales.component';

import { AppRoutingModule } from './app-routing.module';
import { DeliveryComponent } from './views/delivery/delivery.component';
import { DispatchComponent } from './views/dispatch/dispatch.component';
import { PaymentComponent } from './views/payment/payment.component';
import { PaymentExtComponent } from './views/payment-ext/payment-ext.component'; 

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    LoginComponent,
    ProfileComponent,
    CartComponent,
    ProductComponent,
    SalesComponent,
    DeliveryComponent,
    DispatchComponent,
    PaymentComponent,
    PaymentExtComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
