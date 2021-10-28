package com.twice.crud.controller;

import com.github.pagehelper.PageInfo;
import com.twice.crud.bean.Employee;
import com.twice.crud.service.EmployeeService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @program: 1.ssm-maven-crud
 * @author: ChenCanYU
 * @create: 2021-10-24 14:13
 **/
@RunWith(SpringJUnit4ClassRunner.class)
// 使用IOC容器可以装配本身
@WebAppConfiguration
@ContextConfiguration(value = {"classpath:springConfig.xml",
        "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class EmployeeControllerTest {

    @Autowired
    EmployeeService employeeService;

    @Autowired
    WebApplicationContext applicationContext;

    MockMvc mockMvc;

    @Before // 用于初始化方法，被这个注解修饰的方法在其他测试方法执行之前都会执行一次。
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(applicationContext).build();
    }

    @Test
    public void TT1() {
        List<Employee> allEmployee = employeeService.getAllEmployee();
        System.out.println(allEmployee.toString());
    }

    @Test
    public void getAll() throws Exception {
        MvcResult page = mockMvc.perform(MockMvcRequestBuilders.get("/empList").param("page", "5")) // 设置模拟请求的请求参数
                .andReturn();// 返回结果
        MockHttpServletRequest request = page.getRequest(); // 获取请求对象
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");// 获取请求参数
        System.out.println(pageInfo.toString());
    }
}
