// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/time;

# HTTP Client for NetSuite SOAP web service
#
# + basicClient - NetSuite HTTP Client
@display{label: "NetSuite Client", iconPath: "logo.svg"} 
public client class Client {
    public http:Client basicClient;
    private NetSuiteConfiguration config;

    public isolated function init(NetSuiteConfiguration config)returns error? {
        self.config = config;
        self.basicClient = check new (config.baseURL, {timeout: 120});
    }

    # Creates a record instance in NetSuite according to the given detail
    #
    # + customer - Details of NetSuite record instance creation
    # + return - If success returns a RecordAddResponse type record otherwise the relevant error
    @display{label: "Add new customer"}
    isolated remote function addNewCustomer(@display{label: "Customer"} NewCustomer customer) returns @tainted 
                                            @display{label: "Response"} RecordAddResponse|error{
        xml payload = check buildAddRecord(customer, CUSTOMER, self.config);
        http:Response response = check sendRequest(self.basicClient, ADD_SOAP_ACTION, payload);
        return getCreateResponse(response); 
    }

    # Creates a record instance in NetSuite according to the given detail
    #
    # + contact - Details of NetSuite record instance creation
    # + return - If success returns a RecordAddResponse type record otherwise the relevant error
    @display{label: "Add new contact"}
    isolated remote function addNewContact(@display{label: "Contact"} NewContact contact) returns @tainted 
                                           @display{label: "Response"} RecordAddResponse|error{
        xml payload = check buildAddRecord(contact, CONTACT, self.config);
        http:Response response = check sendRequest(self.basicClient, ADD_SOAP_ACTION, payload);
        return getCreateResponse(response); 
    }

    # Creates a record instance in NetSuite according to the given detail
    #
    # + invoice - Invoice type record with detail
    # + return - If success returns a RecordAddResponse type record otherwise the relevant error
    @display{label: "Add new invoice"}  
    isolated remote function addNewInvoice(@display{label: "Invoice"} NewInvoice invoice) returns @tainted 
                                           @display{label: "Response"} RecordAddResponse|error{
        xml payload = check buildAddRecord(invoice, INVOICE, self.config);
        http:Response response = check sendRequest(self.basicClient, ADD_SOAP_ACTION, payload);
        return getCreateResponse(response); 
    }

    # Creates a record instance in NetSuite according to the given detail
    #
    # + currency - Currency type record with detail
    # + return - If success returns a RecordAddResponse type record otherwise the relevant error
    @display{label: "Add new currency"} 
    isolated remote function addNewCurrency(@display{label: "Currency"} NewCurrency currency) returns @tainted
                                            @display{label: "Response"} RecordAddResponse|error{
        xml payload = check buildAddRecord(currency, CURRENCY, self.config);
        http:Response response = check sendRequest(self.basicClient, ADD_SOAP_ACTION, payload);
        return getCreateResponse(response); 
    }

    # Creates a record instance in NetSuite according to the given detail
    #
    # + salesOrder - SalesOrder type record with detail
    # + return - If success returns a RecordAddResponse type record otherwise the relevant error
    @display{label: "Add new sales order"} 
    isolated remote function addNewSalesOrder(@display{label: "Sales Order"} NewSalesOrder salesOrder) returns @tainted
                                              @display{label: "Response"} RecordAddResponse|error{
        xml payload = check buildAddRecord(salesOrder, SALES_ORDER, self.config);
        http:Response response = check sendRequest(self.basicClient, ADD_SOAP_ACTION, payload);
        return getCreateResponse(response); 
    }

    # Creates a record instance in NetSuite according to the given detail
    #
    # + classification - Classification type record with detail
    # + return - If success returns a RecordAddResponse type record otherwise the relevant error
    @display{label: "Add new classification"}
    isolated remote function addNewClassification(@display{label: "Classification"} NewClassification classification) 
                                                  returns @tainted @display{label: "Response"} RecordAddResponse|error {
        xml payload = check buildAddRecord(classification, CLASSIFICATION, self.config);
        http:Response response = check sendRequest(self.basicClient, ADD_SOAP_ACTION, payload);
        return getCreateResponse(response); 
    }

    # Creates a record instance in NetSuite according to the given detail
    #
    # + account - Account type record with detail
    # + return - If success returns a RecordAddResponse type record otherwise the relevant error
    @display{label: "Add new account"}
    isolated remote function addNewAccount(@display{label: "Account"} NewAccount account) returns @tainted
                                           @display{label: "Response"} RecordAddResponse|error {
        xml payload = check buildAddRecord(account, ACCOUNT, self.config);
        http:Response response = check sendRequest(self.basicClient, ADD_SOAP_ACTION, payload);
        return getCreateResponse(response); 
    }

    # Deletes a record instance from NetSuite according to the given detail if they are valid.
    #
    # + info - Details of NetSuite record instance to be deleted
    # + return - If success returns a RecordDeletionResponse type record otherwise the relevant error
    @display{label: "Delete a record"}
    isolated remote function deleteRecord(@display{label: "Record Detail"} RecordDetail info) returns @tainted
                                          @display{label: "Response"} RecordDeletionResponse|error{
        xml payload = check buildDeletePayload(info, self.config);
        http:Response response = check sendRequest(self.basicClient, DELETE_SOAP_ACTION, payload);
        //getDeleteResponse
        return getDeleteResponse(response); 
    }
    
    # Updates a NetSuite customer instance by internalId
    #
    # + customer - Customer record with details and internalId
    # + return - If success returns a RecordUpdateResponse type record otherwise the relevant error
    @display{label: "Update customer record"}   
    isolated remote function updateCustomerRecord(@display{label: "Customer"} Customer customer) returns @tainted
                                                  @display{label: "Response"} RecordUpdateResponse|error {
        xml payload = check buildUpdateRecord(customer, CUSTOMER , self.config);
        //sendRequest
        http:Response response = check sendRequest(self.basicClient, UPDATE_SOAP_ACTION, payload);
        return getUpdateResponse(response); 
    }

    # Updates a NetSuite contact instance by internalId
    #
    # + contact - Contact record with details and internalId
    # + return - If success returns a RecordUpdateResponse type record otherwise the relevant error
    @display{label: "Update contact record"} 
    isolated remote function updateContactRecord(@display{label: "Contact"} Contact contact) returns @tainted
                                                 @display{label: "Response"} RecordUpdateResponse|error {
        xml payload = check buildUpdateRecord(contact, CONTACT , self.config);
        http:Response response = check sendRequest(self.basicClient, UPDATE_SOAP_ACTION, payload);
        return getUpdateResponse(response); 
    }
    
    # Updates a NetSuite currency instance by internalId
    #
    # + currency - Currency record with details and internalId
    # + return - If success returns a RecordUpdateResponse type record otherwise the relevant error
    @display{label: "Update currency record"} 
    isolated remote function updateCurrencyRecord(@display{label: "Currency"} Currency currency) returns @tainted
                                                  @display{label: "Response"} RecordUpdateResponse|error {
        xml payload = check buildUpdateRecord(currency, CURRENCY , self.config);
        http:Response response = check sendRequest(self.basicClient, UPDATE_SOAP_ACTION, payload);
        return getUpdateResponse(response); 
    }

    # Updates a NetSuite invoice instance by internalId
    #
    # + invoice - Invoice record with details and internalId
    # + return - If success returns a RecordUpdateResponse type record otherwise the relevant error 
    @display{label: "Update invoice record"}
    isolated remote function updateInvoiceRecord(@display{label: "Invoice"} Invoice invoice) returns @tainted
                                                 @display{label: "Response"} RecordUpdateResponse|error {
        xml payload = check buildUpdateRecord(invoice, INVOICE , self.config);
        http:Response response = check sendRequest(self.basicClient, UPDATE_SOAP_ACTION, payload);
        return getUpdateResponse(response); 
    }

    # Updates a NetSuite salesOrder instance by internalId
    #
    # + salesOrder - SalesOrder record with details and internalId
    # + return - If success returns a RecordUpdateResponse type record otherwise the relevant error
    @display{label: "Update sales order record"} 
    isolated remote function updateSalesOrderRecord(@display{label: "Sales Order"} SalesOrder salesOrder) returns 
                                                    @tainted @display{label: "Response"} RecordUpdateResponse|error {
        xml payload = check buildUpdateRecord(salesOrder, SALES_ORDER , self.config);
        http:Response response = check sendRequest(self.basicClient, UPDATE_SOAP_ACTION, payload);
        return getUpdateResponse(response); 
    }

    # Updates a NetSuite classification instance by internalId
    #
    # + classification - Classification record with details and internalId
    # + return - If success returns a RecordUpdateResponse type record otherwise the relevant error
    @display{label: "Update classification record"} 
    isolated remote function updateClassificationRecord(@display{label: "Classification"} Classification classification) 
                                                        returns @tainted @display{label: "Response"} 
                                                        RecordUpdateResponse|error {
        xml payload = check buildUpdateRecord(classification, CLASSIFICATION , self.config);
        http:Response response = check sendRequest(self.basicClient, UPDATE_SOAP_ACTION, payload);
        return getUpdateResponse(response); 
    }

    # Updates a NetSuite account instance by internalId
    #
    # + account - Account record with details and internalId
    # + return - If success returns a RecordUpdateResponse type record otherwise the relevant error
    @display{label: "Update account record"} 
    isolated remote function updateAccountRecord(@display{label: "Account"} Account account) returns @tainted @display 
                                                {label: "Response"} RecordUpdateResponse|error {
        xml payload = check buildUpdateRecord(account, ACCOUNT , self.config);
        http:Response response = check sendRequest(self.basicClient, UPDATE_SOAP_ACTION, payload);
        return getUpdateResponse(response); 
    }

    # Retrieves all currency types instances from NetSuite
    #
    # + return - If success returns an array of Currencies otherwise the relevant error
    isolated remote function getAllCurrencyRecords() returns Currency[]|error {
        xml payload = check buildGetAllPayload(CURRENCY_All_TYPES, self.config);
        http:Response response = check sendRequest(self.basicClient, GET_ALL_SOAP_ACTION, payload);
        var output = formatGetAllResponse(response);
        if(output is anydata) {
            return <Currency[]>output;
        } else {
            fail error(output.message());
        }  
    }

    # Returns the NetSuite server time in GMT, regardless of a user's time zone 
    #
    # + return - If success returns the server time in Ballerina time:Civil format otherwise the relevant error
    @display{label: "Get saved search"} 
    isolated remote function getNetSuiteServerTime() returns @tainted @display{label: "Response"} time:Civil|error {
        xml payload = check buildGetServerTime(self.config);
        http:Response response = check sendRequest(self.basicClient, GET_SERVER_TIME_ACTION, payload);
        return getServerTimeResponse(response);
    }

    # Retrieves NetSuite client instances from NetSuite according to the given detail 
    # if they are valid
    #
    # + searchElements - Details of a NetSuite record to be retrieved from NetSuite
    # + return - If success returns a json otherwise the relevant error
    @display{label: "Search a customer record"} 
    isolated remote function searchCustomerRecord(@display{label: "Search elements"} SearchElement[] searchElements) 
                                                  returns @tainted @display{label: "Response"} Customer|error {
        xml payload = check buildCustomerSearchPayload(self.config, searchElements);
        http:Response response = check sendRequest(self.basicClient, SEARCH_SOAP_ACTION, payload);
        return getCustomerSearchResult(response);
    }

    # Retrieves NetSuite transaction instances from NetSuite according to the given detail 
    # if they are valid
    #
    # + searchElements - Details of a NetSuite record to be retrieved from NetSuite
    # + return - If success returns a json otherwise the relevant error
    @display{label: "Search a transaction record"}
    isolated remote function searchTransactionRecord(@display{label: "Search elements"} SearchElement[] searchElements) 
                                                     returns @tainted @display{label: "Response"} RecordList|error {
        xml payload = check buildTransactionSearchPayload(self.config, searchElements);
        http:Response response = check sendRequest(self.basicClient, SEARCH_SOAP_ACTION, payload);
        return getTransactionSearchResult(response);
    }

    # Retrieves NetSuite account record instances from NetSuite according to the given detail 
    # if they are valid
    #
    # + searchElements - Details of a NetSuite record to be retrieved from NetSuite
    # + return - If success returns a json otherwise the relevant error
    @display{label: "Search a account record"}
    isolated remote function searchAccountRecord(@display{label: "Search elements"} SearchElement[] searchElements) 
                                                 returns @tainted @display{label: "Response"} Account|error {
        xml payload = check buildAccountSearchPayload(self.config, searchElements);
        http:Response response = check sendRequest(self.basicClient, SEARCH_SOAP_ACTION, payload);
        return getAccountSearchResult(response);
    }

    # Gets a customer record from Netsuite by using internal Id
    #
    # + recordInfo - Ballerina record for Netsuite record information
    # + return - If success returns a Customer type record otherwise the relevant error
    @display{label: "Get a customer record"}
    isolated remote function getCustomerRecord(@display{label: "Record detail"} RecordInfo recordInfo) returns 
                                               @tainted @display{label: "Response"} Customer|error {
        http:Request request = new;
        xml payload = check buildGetOperationPayload(recordInfo, self.config);
        http:Response response = check sendRequest(self.basicClient, GET_SOAP_ACTION, payload);
        return getCustomerResult(response, CUSTOMER);
    }

    # Gets a contact record from Netsuite by using internal Id
    #
    # + recordInfo - Ballerina record for Netsuite record information
    # + return - If success returns a Contact type record otherwise the relevant error
    @display{label: "Get a contact record"}  
    isolated remote function getContactRecord(@display{label: "Record detail"} RecordInfo recordInfo) returns 
                                              @tainted @display{label: "Response"} Contact|error {
        http:Request request = new;
        xml payload = check buildGetOperationPayload(recordInfo, self.config);
        http:Response response = check sendRequest(self.basicClient, GET_SOAP_ACTION, payload);
        return getContactResult(response);
    }

    # Gets a currency record from Netsuite by using internal Id
    #
    # + recordInfo - Ballerina record for Netsuite record information
    # + return - If success returns a Currency type record otherwise the relevant error
    @display{label: "Get a currency record"}
    isolated remote function getCurrencyRecord(@display{label: "Record detail"} RecordInfo recordInfo) returns 
                                               @tainted @display{label: "Response"} Currency|error {
        http:Request request = new;
        xml payload = check buildGetOperationPayload(recordInfo, self.config);
        http:Response response = check sendRequest(self.basicClient, GET_SOAP_ACTION, payload);
        return getCurrencyResult(response, CURRENCY);
    }

    # Gets a currency record from Netsuite by using internal Id
    #
    # + recordInfo - Ballerina record for Netsuite record information
    # + return - If success returns a Classification type record otherwise the relevant error
    @display{label: "Get a classification record"}
    isolated remote function getClassificationRecord(@display{label: "Record detail"} RecordInfo recordInfo) returns 
                                                     @tainted @display{label: "Response"} Classification|error {
        http:Request request = new;
        xml payload = check buildGetOperationPayload(recordInfo, self.config);
        http:Response response = check sendRequest(self.basicClient, GET_SOAP_ACTION, payload);
        return getClassificationResult(response, CLASSIFICATION);
    }

    # Gets a invoice record from Netsuite by using internal Id
    #
    # + recordInfo - Ballerina record for Netsuite record information
    # + return - If success returns a invoice type record otherwise the relevant error
    @display{label: "Get a invoice record"}
    isolated remote function getInvoiceRecord(@display{label: "Record detail"} RecordInfo recordInfo) returns 
                                              @tainted @display{label: "Response"} Invoice|error {
        http:Request request = new;
        xml payload = check buildGetOperationPayload(recordInfo, self.config);
        http:Response response = check sendRequest(self.basicClient, GET_SOAP_ACTION, payload);
        return getInvoiceResult(response, INVOICE);
    }

    # Gets a salesOrder record from Netsuite by using internal Id
    #
    # + recordInfo - Ballerina record for Netsuite record information
    # + return - If success returns a SalesOrder type record otherwise the relevant error
    @display{label: "Get a sales order record"}
    isolated remote function getSalesOrderRecord(@display{label: "Record detail"} RecordInfo recordInfo) returns 
                                                 @tainted @display{label: "Response"} SalesOrder|error {
        http:Request request = new;
        xml payload = check buildGetOperationPayload(recordInfo, self.config);
        http:Response response = check sendRequest(self.basicClient, GET_SOAP_ACTION, payload);
        return getSalesOrderResult(response, SALES_ORDER);
    }
 }

# Configuration record for NetSuite
#
# + accountId - NetSuite account Id  
# + consumerSecret - Netsuite Integration App consumer secret
# + baseURL - Netsuite baseURL for web services and this "/services/NetSuitePort_2020_2" should be added to the link.   
# + consumerId - Netsuite Integration App consumer Id   
# + tokenSecret - Netsuite user role access secret 
# + token - Netsuite user role access token
@display{label: "Connection Config"}  
public type NetSuiteConfiguration record {
    @display{label: "Account Id"}
    string accountId;
    @display{label: "Consumer Id"}
    string consumerId;
    @display{label: "Consumer Secret"}
    string consumerSecret;
    @display{label: "Access Token"}
    string token;
    @display{label: "Access Secret"}
    string tokenSecret;
    @display{label: "NetSuite WebServices URL"}
    string baseURL;
};