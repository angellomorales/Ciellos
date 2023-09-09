& "..\atdd.scenarios\Customer Order\Customer Order.ps1" | `
    ConvertTo-ALTestCodeunit `
        -CodeunitID 80001 `
        -CodeunitName 'CustomerOrder_Test' `
        -GivenFunctionName "Create {0}" `
        -ThenFunctionName "Verify {0}" `
        | Out-File '..\test\src\CiellosTest.Codeunit.al'