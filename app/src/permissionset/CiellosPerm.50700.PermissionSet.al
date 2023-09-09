permissionset 50700 "Ciellos_Perm"
{
    Assignable = true;
    Caption = 'Customer Order Permisions', MaxLength = 30;
    Permissions =
        table "Ciellos_Customer Order Line" = X,
        tabledata "Ciellos_Customer Order Line" = RMID,
        table "Ciellos_Customer Order Header" = X,
        tabledata "Ciellos_Customer Order Header" = RMID,
        table "Ciellos_Customer Order Payment" = X,
        tabledata "Ciellos_Customer Order Payment" = RMID;
}
