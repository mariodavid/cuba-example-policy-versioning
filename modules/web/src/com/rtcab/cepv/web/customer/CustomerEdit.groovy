package com.rtcab.cepv.web.customer

import com.haulmont.cuba.gui.components.AbstractEditor
import com.rtcab.cepv.entity.Customer

class CustomerEdit extends AbstractEditor<Customer> {

    @java.lang.Override
    protected void postInit() {


        setCaption(formatMessage('editorCaption', getItem().instanceName))
    }
}