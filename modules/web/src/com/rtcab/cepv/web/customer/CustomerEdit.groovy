package com.rtcab.cepv.web.customer

import com.haulmont.cuba.core.app.EntitySnapshotService
import com.haulmont.cuba.core.global.PersistenceHelper
import com.haulmont.cuba.gui.app.core.entitydiff.EntityDiffViewer
import com.haulmont.cuba.gui.components.AbstractEditor
import com.haulmont.cuba.gui.data.Datasource
import com.rtcab.cepv.entity.Customer

import javax.inject.Inject

class CustomerEdit extends AbstractEditor<Customer> {


    @Inject
    protected EntityDiffViewer diffFrame;


    @Inject
    protected EntitySnapshotService entitySnapshotService


    @Inject
    protected Datasource<Customer> customerDs


    @Override
    protected void postInit() {
        setCaption(formatMessage('editorCaption', getItem().instanceName))

        if (!PersistenceHelper.isNew(getItem())) {
            diffFrame.loadVersions(getItem())
        }
    }


    @Override
    protected boolean postCommit(boolean committed, boolean close) {
        if (committed) {
            entitySnapshotService.createSnapshot(customerDs.getItem(), customerDs.getView())
        }
        return super.postCommit(committed, close)
    }
}