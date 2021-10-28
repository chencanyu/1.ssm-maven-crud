package com.twice.crud.mapper;

import com.twice.crud.bean.Department;
import com.twice.crud.bean.Employee;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @program: 1.ssm-maven-crud
 * @author: ChenCanYU
 * @create: 2021-10-22 00:16
 **/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:springConfig.xml"})
public class CRUDTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSessionTemplate sessionTemplate;

    @Test
    public void tt() {
        System.out.println(departmentMapper);
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));

//        employeeMapper.insertSelective(new Employee(null, "Jerry", 1, "Jerry@twice.com", 1));
        EmployeeMapper mapper = sessionTemplate.getMapper(EmployeeMapper.class);
        for (int i = 1; i <= 1000; i ++) {
            String name  = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, name, 1, name + "@twice.com", 1));
        }
    }

}
