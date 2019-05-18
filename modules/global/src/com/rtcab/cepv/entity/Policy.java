package com.rtcab.cepv.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import com.haulmont.cuba.core.entity.StandardEntity;
import com.haulmont.cuba.core.entity.annotation.Lookup;
import com.haulmont.cuba.core.entity.annotation.LookupType;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import com.haulmont.chile.core.annotations.NamePattern;
import com.haulmont.cuba.core.entity.annotation.Listeners;

@Listeners("cepv_PolicyEntityListener")
@NamePattern("%s|policyId")
@Table(name = "CEPV_POLICY")
@Entity(name = "cepv$Policy")
public class Policy extends StandardEntity {
    private static final long serialVersionUID = 8574253491819821937L;

    @Lookup(type = LookupType.DROPDOWN, actions = {"lookup", "open", "clear"})
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "CUSTOMER_ID")
    protected Customer customer;

    @Column(name = "POLICY_ID")
    protected Long policyId;

    @Temporal(TemporalType.DATE)
    @Column(name = "COVER_START_DATE", nullable = false)
    protected Date coverStartDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "COVER_END_DATE")
    protected Date coverEndDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "DOCUMENTS_SIGNING_DATE")
    protected Date documentsSigningDate;

    @Column(name = "PREMIUM")
    protected BigDecimal premium;

    public void setPolicyId(Long policyId) {
        this.policyId = policyId;
    }

    public Long getPolicyId() {
        return policyId;
    }


    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Customer getCustomer() {
        return customer;
    }


    public void setCoverStartDate(Date coverStartDate) {
        this.coverStartDate = coverStartDate;
    }

    public Date getCoverStartDate() {
        return coverStartDate;
    }

    public void setCoverEndDate(Date coverEndDate) {
        this.coverEndDate = coverEndDate;
    }

    public Date getCoverEndDate() {
        return coverEndDate;
    }

    public void setDocumentsSigningDate(Date documentsSigningDate) {
        this.documentsSigningDate = documentsSigningDate;
    }

    public Date getDocumentsSigningDate() {
        return documentsSigningDate;
    }

    public void setPremium(BigDecimal premium) {
        this.premium = premium;
    }

    public BigDecimal getPremium() {
        return premium;
    }


}