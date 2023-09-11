tableextension 50701 "Ciellos_Customer" extends Customer
{
    fields
    {
        field(50700; "Ciellos_Cust. Ord. Open"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Customer Orders Open';
            CalcFormula = Count("Ciellos_Customer Order Header" WHERE("Sell to Customer No." = FIELD("No.")));
            Editable = false;

        }
    }

    procedure OpenCustomerOrderLines()
    var
        CustomerOrderHeader: Record "Ciellos_Customer Order Header";

    begin
        CustomerOrderHeader.SetRange("Sell to Customer No.", Rec."No.");
        Page.Run(Page::"Ciellos_Customer Order List", CustomerOrderHeader);
    end;
}
