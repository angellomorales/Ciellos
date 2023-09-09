table 50701 "Ciellos_Customer Order Line"
{
    Caption = 'Customer Order Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Ciellos_Customer Order Header"."No.";
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            trigger OnValidate()
            begin
                CalculateLinePrice();
            end;
        }
        field(6; "Unit Amount"; Decimal)
        {
            Caption = 'Unit Price';
            trigger OnValidate()
            begin
                CalculateLinePrice();
            end;
        }
        field(7; "Line Amount"; Decimal)
        {
            Caption = 'Unit Price';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    local procedure CalculateLinePrice()
    begin
        if (Rec."Unit Amount" <> 0) and (Rec.Quantity <> 0) then
            Rec."Line Amount" := Quantity * "Unit Amount";
    end;
}
