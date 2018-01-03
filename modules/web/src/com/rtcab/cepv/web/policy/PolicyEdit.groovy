package com.rtcab.cepv.web.policy

import com.haulmont.cuba.core.app.EntitySnapshotService
import com.haulmont.cuba.core.global.PersistenceHelper
import com.haulmont.cuba.gui.app.core.entitydiff.EntityDiffViewer
import com.haulmont.cuba.gui.components.AbstractEditor
import com.haulmont.cuba.gui.data.Datasource
import com.rtcab.cepv.entity.Policy

import javax.inject.Inject

class PolicyEdit extends AbstractEditor<Policy> {

    @Inject
    protected EntityDiffViewer diffFrame;


    @Inject
    protected EntitySnapshotService entitySnapshotService


    @Inject
    protected Datasource<Policy> policyDs


    @Override
    protected void postInit() {
        if (!PersistenceHelper.isNew(getItem())) {
            diffFrame.loadVersions(getItem())
        }

        setCaption(formatMessage('editorCaption', getItem().instanceName))
    }

    @Override
    protected boolean postCommit(boolean committed, boolean close) {
        if (committed) {
            entitySnapshotService.createSnapshot(policyDs.getItem(), policyDs.getView())
        }
        return super.postCommit(committed, close)
    }
}