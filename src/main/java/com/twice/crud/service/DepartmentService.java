package com.twice.crud.service;

import com.twice.crud.bean.Department;
import com.twice.crud.mapper.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @program: 1.ssm-maven-crud
 * @author: ChenCanYU
 * @create: 2021-10-25 23:29
 **/
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getAll() {
        return departmentMapper.selectByExample(null);
    }
}
