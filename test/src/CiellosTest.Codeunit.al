codeunit 80001 "Customer Order"
{
    // Generated on 8/09/2023 at 10:58 p. m. by Angello

    Subtype = Test;

    var
        LibraryAssert: Codeunit "Library Assert";
        LibrarySales: Codeunit "Library - Sales";
        LibraryRandom: Codeunit "Library - Random";
        LibraryUtility: Codeunit "Library - Utility";
        LibraryERM: Codeunit "Library - ERM";
        LibraryGraphMgt: Codeunit "Library - Graph Mgt";

    trigger OnRun()
    begin
        // [FEATURE] Task1
    end;

    [Test]
    [TestPermissions(TestPermissions::Disabled)]
    procedure CreateACustomerOrderWithAutomaticNoSeries()
    // [FEATURE] Task1
    var
        Customer: Record Customer;
        CustomerOrderHeader: Record "Ciellos_Customer Order Header";
    begin
        // [SCENARIO #0001] Create a Customer order with automatic No Series

        // [GIVEN] Customer
        CreateCustomer(Customer);

        // [GIVEN] No Serie
        // CreateNoSerie();

        // [WHEN] Create and Select a Customer
        CreateAndSelectACustomer(Customer, CustomerOrderHeader);

        // [THEN] Document No with related No Serie
        VerifyDocumentNoWithRelatedNoSerie(CustomerOrderHeader);

    end;

    [Test]
    [TestPermissions(TestPermissions::Disabled)]
    procedure CalculateFlowFieldForOrderAmount()
    // [FEATURE] Task1
    var
        Customer: Record Customer;
        CustomerOrderHeader: Record "Ciellos_Customer Order Header";
        CustomerOrderLine: Record "Ciellos_Customer Order Line";
        OrderAmount: Decimal;
    begin
        // [SCENARIO #0002] Calculate flow field for order amount

        // [GIVEN] Customer
        CreateCustomer(Customer);

        // [GIVEN] No Serie
        // CreateNoSerie();

        // [GIVEN] Customer order Header
        CreateAndSelectACustomer(Customer, CustomerOrderHeader);

        // [WHEN] Create Customer Order Line
        OrderAmount := CreateCustomerOrderLine(CustomerOrderHeader, CustomerOrderLine, 3);

        // [THEN] order amount different to zero
        VerifyOrderAmountDifferentToZero(CustomerOrderHeader, OrderAmount);

    end;

    local procedure CreateCustomer(var Customer: Record Customer)
    begin
        LibrarySales.CreateCustomer(Customer);
    end;

    local procedure CreateCustomerOrderLine(var CustomerOrderHeader: Record "Ciellos_Customer Order Header"; var CustomerOrderLine: Record "Ciellos_Customer Order Line"; NumbLines: Integer) TotalAmount: Decimal
    var
        i: Integer;
    begin
        for i := 1 to NumbLines do begin
            Clear(CustomerOrderLine);
            CustomerOrderLine.Init();
            CustomerOrderLine."Document No." := CustomerOrderHeader."No.";
            CustomerOrderLine."Line No." := i * 10000;
            CustomerOrderLine.Insert(true);
            CustomerOrderLine.Validate("Customer No.", CustomerOrderHeader."Sell to Customer No.");
            CustomerOrderLine.Validate(Description, LibraryRandom.RandText(20));
            CustomerOrderLine.Validate(Quantity, LibraryRandom.RandDec(10, 2));
            CustomerOrderLine.Validate("Unit Amount", LibraryRandom.RandDec(10, 2));
            CustomerOrderLine.Modify(true);
            TotalAmount += CustomerOrderLine."Line Amount";
        end;
        CustomerOrderHeader.CalcFields("Order Amount");
    end;

    local procedure CreateNoSerie()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.get();
        SalesSetup."Ciellos_Customer Order Nos." := LibraryERM.CreateNoSeriesCode();
        SalesSetup."Ciellos_Customer Payment Nos." := LibraryERM.CreateNoSeriesCode();
        SalesSetup.Modify();
    end;

    local procedure CreateAndSelectACustomer(Customer: Record Customer; var CustomerOrderHeader: Record "Ciellos_Customer Order Header")
    begin
        CustomerOrderHeader.Init();
        CustomerOrderHeader.Validate("Sell to Customer No.", Customer."No.");
        CustomerOrderHeader.Insert(true);
    end;

    local procedure VerifyDocumentNoWithRelatedNoSerie(CustomerOrderHeader: Record "Ciellos_Customer Order Header")
    SalesSetup: Record "Sales & Receivables Setup";
    begin
        LibraryAssert.IsTrue(CustomerOrderHeader."No." <> '', 'No. should not be empty');
        SalesSetup.Get();
        LibraryAssert.AreEqual(SalesSetup."Ciellos_Customer Order Nos.", CustomerOrderHeader."No. Series", 'No. Series doesn`t match');
    end;

    local procedure VerifyOrderAmountDifferentToZero(CustomerOrderHeader: Record "Ciellos_Customer Order Header"; OrderAmount: Decimal)
    begin
        LibraryAssert.AreNotEqual(0, CustomerOrderHeader."Order Amount", 'Order Amount was not calculated');
        LibraryAssert.AreEqual(OrderAmount, CustomerOrderHeader."Order Amount", 'Order Amount doen`t match');
    end;

}

