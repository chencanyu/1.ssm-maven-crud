package com.twice.crud.bean;

public class Department {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tnl_dept.dept_id
     *
     * @mbg.generated Thu Oct 21 23:40:47 CST 2021
     */
    private Integer deptId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tnl_dept.dept_name
     *
     * @mbg.generated Thu Oct 21 23:40:47 CST 2021
     */
    private String deptName;

    /**
     * hhhhh
     * hhhhhhh
     * 1
     * pull test
     * master test
     * test hot-fix
     */
    public Department() {
    }

    public Department(Integer deptId, String deptName) {
        this.deptId = deptId;
        this.deptName = deptName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tnl_dept.dept_id
     *
     * @return the value of tnl_dept.dept_id
     *
     * @mbg.generated Thu Oct 21 23:40:47 CST 2021
     */
    public Integer getDeptId() {
        return deptId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tnl_dept.dept_id
     *
     * @param deptId the value for tnl_dept.dept_id
     *
     * @mbg.generated Thu Oct 21 23:40:47 CST 2021
     */
    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tnl_dept.dept_name
     *
     * @return the value of tnl_dept.dept_name
     *
     * @mbg.generated Thu Oct 21 23:40:47 CST 2021
     */
    public String getDeptName() {
        return deptName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tnl_dept.dept_name
     *
     * @param deptName the value for tnl_dept.dept_name
     *
     * @mbg.generated Thu Oct 21 23:40:47 CST 2021
     */
    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }

    @Override
    public String toString() {
        return "Department{" +
                "deptId=" + deptId +
                ", deptName='" + deptName + '\'' +
                '}';
    }
}
