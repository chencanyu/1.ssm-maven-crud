package com.twice.crud.controller;

import com.twice.crud.bean.Department;
import com.twice.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @program: 1.ssm-maven-crud
 * @author: ChenCanYU
 * @create: 2021-10-25 23:26
 **/
@Controller
public class DepartmentController<Lits> {

    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/deptList")
    @ResponseBody
    public List<Department> getAll() {
        return departmentService.getAll();
    }
}
