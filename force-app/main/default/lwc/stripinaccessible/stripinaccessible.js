import { LightningElement, wire } from "lwc";
import { reduceErrors } from "c/ldsUtils";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import TYPE_FIELD from "@salesforce/schema/Account.Type";
import getFilteredAccountsStripped from "@salesforce/apex/AccountController.getFilteredAccountsStripped";

const COLUMNS = [
  { label: "Account Name", fieldName: NAME_FIELD.fieldApiName, type: "text" },
  { label: "Industry", fieldName: INDUSTRY_FIELD.fieldApiName, type: "text" },
  { label: "Type", fieldName: TYPE_FIELD.fieldApiName, type: "text" }
];

export default class NoSoqlInjection2 extends LightningElement {
  columns = COLUMNS;
  searchValue = "";

  @wire(getFilteredAccountsStripped, { searchValue: "$searchValue" })
  accounts;

  get errors() {
    return this.accounts.error ? reduceErrors(this.accounts.error) : [];
  }

  handleInputChange(event) {
    this.searchValue = event.target.value;
  }
}