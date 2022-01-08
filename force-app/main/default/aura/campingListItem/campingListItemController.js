({
	packItem : function(component, event, helper) {
	    var item = component.get("v.item",true);
        item.Packed__c = true;
        component.set("v.item",item);
        var btnClicked = event.getSource();
		btnClicked.set("v.disabled",true);
	}
})