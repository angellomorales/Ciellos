pageextension 50702 "Ciellos_CustomerList" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field("Ciellos_Open Cust. Ord. Amount"; Rec."Ciellos_Cust. Ord. Open")
            {
                trigger OnDrillDown()
                begin
                    Rec.OpenCustomerOrderLines();
                end;
            }
        }
        moveafter(Name; Contact)
        movebefore("Responsibility Center"; "Location Code")
        moveafter("Location Code"; "Phone No.")

        modify(Contact)
        {
            Caption = 'Modified Contact';
        }
        modify("Location Code")
        {
            Caption = 'Modified Location Code';
        }
        modify("Phone No.")
        {
            Caption = 'Modified Phone No.';
        }

    }

}
