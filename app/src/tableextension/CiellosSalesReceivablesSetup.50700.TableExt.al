tableextension 50700 "Ciellos_SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50700; "Ciellos_Customer Order Nos."; Code[20])
        {
            Caption = 'Customer Order No';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50701; "Ciellos_Customer Payment Nos."; Code[20])
        {
            Caption = 'Customer Payment No';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
}
