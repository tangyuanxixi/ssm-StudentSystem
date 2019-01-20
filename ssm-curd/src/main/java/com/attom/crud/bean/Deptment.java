package com.attom.crud.bean;
public class Deptment {
    private Integer deptId;

    private String deptName;

    public Deptment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Deptment(Integer deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}

	public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }

	@Override
	public String toString() {
		return "Deptment [deptId=" + deptId + ", deptName=" + deptName + "]";
	}
    
}