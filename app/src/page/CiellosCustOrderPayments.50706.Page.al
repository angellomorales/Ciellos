page 50706 "Ciellos_Cust. Order Payments"
{
    ApplicationArea = All;
    Caption = 'Customer Order Payments';
    AboutText = 'Create payment for current order';
    PageType = Card;
    DelayedInsert = true;
    // SourceTable = "Ciellos_Customer Order Payment";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {

            field("Customer Name"; CustomerName)
            {
                ToolTip = 'Specifies the value of the Customer No. field.';
                Editable = false;
            }
            field("Posting Date"; PostingDate)
            {
                ToolTip = 'Specifies the value of the Posting Date field.';
                Editable = false;
            }
            field("Related Document No."; RelatedDocNo)
            {
                ToolTip = 'Specifies the value of the Related Document No. field.';
                Editable = false;
            }
            field(Amount; Amount)
            {
                ToolTip = 'Specifies the value of the Amount field.';
                trigger OnValidate()
                begin
                    if Amount > PendingAmount then
                        Amount := PendingAmount

                end;
            }
        }
    }
    var
        PostingDate: Date;
        CustomerNo: Code[20];
        CustomerName: Text;
        RelatedDocNo: Code[20];
        PendingAmount: Decimal;
        Amount: Decimal;


    procedure SetDefaults(PostedCustOrderHead: Record "Ciellos_Posted Cus_Ord Head.")
    begin
        PostingDate := WorkDate();
        CustomerNo := PostedCustOrderHead."Sell to Customer No.";
        CustomerName := PostedCustOrderHead."Sell to Customer Name";
        RelatedDocNo := PostedCustOrderHead."No.";
        PendingAmount := PostedCustOrderHead."Order Amount" - PostedCustOrderHead."Paid Amount";
    end;

    procedure SavePayment(PostedCustOrderHead: Record "Ciellos_Posted Cus_Ord Head.")
    var
        CustomerOrderPayments: Record "Ciellos_Customer Order Payment";
    begin
        PendingAmount := PendingAmount - Amount;

        CustomerOrderPayments.Validate("Posting Date", PostingDate);
        CustomerOrderPayments.Validate("Related Document No.", RelatedDocNo);
        CustomerOrderPayments.Validate("Customer No.", CustomerNo);
        CustomerOrderPayments.Validate(Amount, Amount);
        CustomerOrderPayments.Validate("Pending Amount", PendingAmount);
        CustomerOrderPayments.Insert(true);

    end;
}
