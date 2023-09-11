codeunit 50701 "Ciellos_Post Customer Order"
{
    TableNo = "Ciellos_Customer Order Header";
    trigger OnRun()
    begin
        transferToPosted(Rec);
    end;

    local procedure transferToPosted(Rec: Record "Ciellos_Customer Order Header")
    var
        PostedCustomerOrderHead: Record "Ciellos_Posted Cus_Ord Head.";
        PostedCustomerOrderLines: record "Ciellos_Posted Cust. Ord. Line";
        CustomerOrderLines: record "Ciellos_Customer Order Line";
    begin
        PostedCustomerOrderHead.TransferFields(Rec);
        PostedCustomerOrderHead."No." := '';
        PostedCustomerOrderHead."Order Amount" := Rec."Order Amount";
        if PostedCustomerOrderHead.Insert(true) then
            CustomerOrderLines.SetRange("Document No.", Rec."No.");
        if CustomerOrderLines.FindSet() then
            repeat
                PostedCustomerOrderLines.TransferFields(CustomerOrderLines);
                PostedCustomerOrderLines."Document No." := PostedCustomerOrderHead."No.";
                PostedCustomerOrderLines.Insert(true);
            until CustomerOrderLines.Next() = 0;

        Rec.Delete(true);
    end;

}
