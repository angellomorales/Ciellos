table 50702 "Ciellos_Customer Order Payment"
{
    Caption = 'Customer Order Payment';
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
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Related Document No."; Code[20])
        {
            Caption = 'Related Document No.';
            TableRelation = "Ciellos_Customer Order Header"."No.";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; "Pending Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "No.", "Line No.")
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
            SalesSetup.TestField("Ciellos_Customer Payment Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Ciellos_Customer Payment Nos.", xRec."No. Series", "Posting Date", Rec."No.", Rec."No. Series");
        end;

    end;
}
