package com.twice.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.twice.crud.bean.Employee;
import com.twice.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import javax.xml.ws.BindingProvider;
import java.util.List;

/**
 * @program: 1.ssm-maven-crud
 * @author: ChenCanYU
 * @create: 2021-10-24 00:43
 **/
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/empList")
    @ResponseBody
    public Msg getPageInfo(
            @RequestParam(value = "page", defaultValue = "1") Integer page
    ) {
        // 设置分页
        PageHelper.startPage(page, 5);
        List<Employee> allEmployee = employeeService.getAllEmployee();
        PageInfo<Employee> p = new PageInfo<>(allEmployee, 5);
        Msg msg = Msg.success();
        msg.add("pageInfo", p);
        // 获取分页详细信息
        return msg;
    }

    /**
     * ...
     * @param employee @Valid表示该参数会进行数据校验
     * @param result 放回数据校验之后的结果
     * @return ...
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            return Msg.fail();
        }
        else {

            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping("/checkName")
    @ResponseBody
    public Msg checkName(@RequestParam(value = "name", defaultValue = "") String name) {
        System.out.println(name);
        if (employeeService.checkName(name)) {

            return Msg.success();
        }
        else {
            return Msg.fail();
        }
    }

}
