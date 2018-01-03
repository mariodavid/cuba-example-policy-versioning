package com.rtcab.cepv.listener

import com.haulmont.cuba.core.app.UniqueNumbersAPI
import org.springframework.stereotype.Component
import com.haulmont.cuba.core.listener.BeforeInsertEntityListener
import com.haulmont.cuba.core.EntityManager
import com.rtcab.cepv.entity.Policy

import javax.inject.Inject

@Component("cepv_PolicyEntityListener")
class PolicyEntityListener implements BeforeInsertEntityListener<Policy> {

    @Inject
    private UniqueNumbersAPI uniqueNumbers

    private long getNextValue() {
        return uniqueNumbers.getNextNumber("policyId")
    }

    @Override
    void onBeforeInsert(Policy entity, EntityManager entityManager) {
        entity.policyId = getNextValue()
    }

}