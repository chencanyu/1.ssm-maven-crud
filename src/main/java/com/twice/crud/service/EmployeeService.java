package com.twice.crud.service;

import com.twice.crud.bean.Employee;
import com.twice.crud.bean.EmployeeExample;
import com.twice.crud.mapper.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @program: 1.ssm-maven-crud
 * @author: ChenCanYU
 * @create: 2021-10-24 00:45
 **/
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAllEmployee() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public int saveEmp(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    public boolean checkName(String name) {
        EmployeeExample employeeExample = new EmployeeExample();
        // 创造查询条件
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        // 查询条件设置值必须等于name
        criteria.andEmpNameEqualTo(name);
        long l = employeeMapper.countByExample(employeeExample);
        return l == 0;
    }
}
