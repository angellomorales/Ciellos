Feature 'Task1' {
	Scenario 0001 'Create a Customer order with automatic No Series' {
		Given 'Customer'
		Given 'No Serie'
		When 'Create and Select a Customer'
		Then 'Document No with related No Serie'
	}
	Scenario 0002 'Calculate flow field for order amount' {
		Given 'Customer'
		Given 'No Serie'
		Given 'Customer Order Line'
		When 'Fill Qty or unit price in Cust Ord Line'
		Then 'order amount different to zero' 
	}
}
