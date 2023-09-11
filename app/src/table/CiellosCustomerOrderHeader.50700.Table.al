table 50700 "Ciellos_Customer Order Header"
{
    Caption = 'Customer Order Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(SalesSetup."Ciellos_Customer Order Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Sell to Customer No."; Code[20])
        {
            Caption = 'Sell to Customer';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer: Record Customer;
                CustomerOrderLine: Record "Ciellos_Customer Order Line";
            begin
                if "Sell to Customer No." <> '' then begin
                    Customer.get("Sell to Customer No.");
                    "Sell to Customer Name" := Customer.Name;

                    CustomerOrderLine.SetRange("Document No.", Rec."No.");
                    if CustomerOrderLine.FindSet() then
                        repeat
                            CustomerOrderLine.Validate("Customer No.", Rec."Sell to Customer No.");
                            CustomerOrderLine.Modify(true);
                        until CustomerOrderLine.Next() = 0;
                end
            end;
        }
        field(3; "Sell to Customer Name"; Text[100])
        {
            Caption = 'Sell to Customer Name';
            TableRelation = Customer.Name where("No." = field("Sell to Customer No."));
        }
        field(4; "Order Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Ciellos_Customer Order Line"."Line Amount"
            where("Document No." = field("No."),
            "Customer No." = field("Sell to Customer No.")));
            Caption = 'Order Amount';
            Editable = false;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        InitInsert();
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure InitInsert()
    begin

        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Ciellos_Customer Order Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Ciellos_Customer Order Nos.", xRec."No. Series", "Posting Date", Rec."No.", Rec."No. Series");
        end;

    end;

    trigger OnDelete()
    var
        CustomerOrderLine: Record "Ciellos_Customer Order Line";
    begin
        CustomerOrderLine.SetRange("Document No.", Rec."No.");
        CustomerOrderLine.DeleteAll();
    end;
}
