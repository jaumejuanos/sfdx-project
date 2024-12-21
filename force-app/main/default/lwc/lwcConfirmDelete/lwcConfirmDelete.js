import { LightningElement } from "lwc";
import LightningConfirm from "lightning/confirm";
import LightningAlert from "lightning/alert";

export default class LwcConfirmDelete extends LightningElement {
    async handleConfirmClick() {
        const result = await LightningConfirm.open({
            message: "All events, visit reports and tasks linked to the contact will be deleted. Do you want to continue??",
            variant: "default", // headerless
            label: "Delete a record"
        });

        //Confirm has been closed

        //result is true if OK was clicked
        if (result) {
            this.handleSuccessAlertClick();
        } else {
            //and false if cancel was clicked
            this.handleErrorAlertClick();
        }
    }

    async handleSuccessAlertClick() {
        await LightningAlert.open({
            message: "You clicked Ok",
            theme: "success",
            label: "Success!"
        });
    }

    async handleErrorAlertClick() {
        await LightningAlert.open({
            message: "You clicked Cancel",
            theme: "error",
            label: "Error!"
        });
    }
}