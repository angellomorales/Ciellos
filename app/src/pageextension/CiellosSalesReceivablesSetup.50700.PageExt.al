pageextension 50700 "Ciellos_SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("Ciellos_Customer Order Nos."; Rec."Ciellos_Customer Order Nos.")
            {
                ApplicationArea = All;
            }
            field("Ciellos_Customer Payment Nos."; Rec."Ciellos_Customer Payment Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
}
