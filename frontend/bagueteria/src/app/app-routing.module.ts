import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";

import { HomeComponent } from "./views/home/home.component";
import { CartComponent } from "./views/cart/cart.component";
import { ProductComponent } from "./views/product/product.component";
import { SalesComponent } from "./views/sales/sales.component";
import { LoginComponent } from "./account/login/login.component";
import { ProfileComponent } from "./account/profile/profile.component";
import { DeliveryComponent } from "./views/delivery/delivery.component";
import { DispatchComponent } from "./views/dispatch/dispatch.component";

const routes: Routes=[
    { path: 'home', component: HomeComponent },
    { path: 'cart', component: CartComponent },
    { path: 'product', component: ProductComponent },
    { path: 'sales', component: SalesComponent },
    { path: 'login', component: LoginComponent },
    { path: 'profile', component: ProfileComponent },
    { path: 'delivery', component: DeliveryComponent },
    { path: 'dispatch', component: DispatchComponent },
    { path: '', redirectTo: 'product', pathMatch: 'full' }
];


@NgModule({
    imports : [RouterModule.forRoot(routes)],
    exports: [RouterModule]
})
export class AppRoutingModule{}