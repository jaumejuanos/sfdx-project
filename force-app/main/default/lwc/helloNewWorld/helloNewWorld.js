import { LightningElement } from 'lwc';
export default class helloNewWorld extends LightningElement {
  greeting = 'New World';
  changeHandler(event) {
    this.greeting = event.target.value;
  }
}