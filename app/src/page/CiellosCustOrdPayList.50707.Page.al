page 50707 "Ciellos_Cust. Ord. PayList"
{
    ApplicationArea = All;
    Caption = 'Cust. Ord. PayList';
    PageType = List;
    SourceTable = "Ciellos_Customer Order Payment";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Related Document No."; Rec."Related Document No.")
                {
                    ToolTip = 'Specifies the value of the Related Document No. field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Pending Amount"; Rec."Pending Amount")
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}
