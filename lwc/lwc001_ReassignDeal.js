import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import reassignLead from '@salesforce/apex/LWGC001_ReassignDeal.reassignLead';
import reassignOpp from '@salesforce/apex/LWGC001_ReassignDeal.reassignOpp';

export default class Lwc001_ReassignDeal extends LightningElement {
    @api recordId;
    reassignDeal(){
        if(this.recordId.startsWith('00Q')){ //if record is a Lead
            console.log('lead');
            reassignLead({leadId: this.recordId})
            .then(res => {
                this.dispatchEvent(new CloseActionScreenEvent()); //Close the lwc and display the message
                this.showSuccessNotification();
            })
            .catch(error => {
                console.log("LWC001 - reassignLead - Error: ", error);
            });
        }
        else if(this.recordId.startsWith('006')){ //if record is an Opportunity
            console.log('opp');
            reassignOpp({oppId: this.recordId})
            .then(res => {
                this.dispatchEvent(new CloseActionScreenEvent()); //Close the lwc and display the message
                this.showSuccessNotification();
            })
            .catch(error => {
                console.log("LWC001 - reassignOpp - Error: ", error);
            });
        }
    }

    //Message to be displayed on successful lead reassignment
    showSuccessNotification() {
        const evt = new ShowToastEvent({
            title: 'Deal reassigned !',
            message: 'Your deal was sucessfully reassigned.',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
}