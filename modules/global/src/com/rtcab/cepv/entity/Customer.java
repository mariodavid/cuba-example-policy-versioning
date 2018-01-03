package com.rtcab.cepv.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.validation.constraints.NotNull;
import com.haulmont.cuba.core.entity.StandardEntity;
import com.haulmont.chile.core.annotations.NamePattern;
import com.haulmont.chile.core.annotations.Composition;
import com.haulmont.cuba.core.entity.annotation.OnDelete;
import com.haulmont.cuba.core.global.DeletePolicy;
import java.util.List;
import javax.persistence.OneToMany;

@NamePattern("%s|name")
@Table(name = "CEPV_CUSTOMER")
@Entity(name = "cepv$Customer")
public class Customer extends StandardEntity {
    private static final long serialVersionUID = 6806959444725666491L;

    @NotNull
    @Column(name = "NAME", nullable = false)
    protected String name;

    @Composition
    @OnDelete(DeletePolicy.CASCADE)
    @OneToMany(mappedBy = "customer")
    protected List<Policy> policies;

    public void setPolicies(List<Policy> policies) {
        this.policies = policies;
    }

    public List<Policy> getPolicies() {
        return policies;
    }


    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }


}