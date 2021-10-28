<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="${APP_PATH}/static/js/jquery.min.js"></script>
    <link
            href="${APP_PATH}/static/dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH}/static/dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="add_emp_info">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!-- 显示分页信息 -->
    <div class="row">
        <%--        显示分页信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--        显示分页条--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="add_emp_table" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加员工</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_update_data" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_update_data" placeholder="email@atguigu.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">
                                gender
                            </label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" placeholder="email@twice.com" value="1" checked="checked"> male
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" placeholder="email@twice.com" value="0"> woman
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">
                                deptName
                            </label>
                            <div class="col-sm-4" id="deptName_label">
                                <select class="form-control" name="dId">
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="save_emp_info">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        var pageEnd = 1;

        $(function () {
            to_page(1);
        })

        function to_page(page) {
            $.ajax({
                url:"${APP_PATH}/empList",
                data:"page=" + page,
                type:"GET",
                success:function(result) {
                    // console.log(result);
                    build_emps_table(result);
                    build_page_info(result);
                    build_page_nav(result);
                }
            })
        }

        function build_emps_table(result){
            //清空table表格
            $("#emps_table tbody").empty();
            var emps = result.store.pageInfo.list;
            $.each(emps,function(index,item){
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender==='1'?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                /**
                 <button class="">
                 <span class="" aria-hidden="true"></span>
                 编辑
                 </button>
                 */
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                //为编辑按钮添加一个自定义的属性，来表示当前员工id
                editBtn.attr("edit-id",item.empId);
                var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的员工id
                delBtn.attr("del-id",item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //var delBtn =
                //append方法执行完成以后还是返回原来的元素
                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            });
        }
        //解析显示分页信息
        function build_page_info(result){
            console.log(result)
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.store.pageInfo.pageNum+"页,总"+
                result.store.pageInfo.pages+"页,总"+
                result.store.pageInfo.total+"条记录");
            totalRecord = result.store.pageInfo.total;
            currentPage = result.store.pageInfo.pageNum;
            pageNum = result.store.pageInfo.pages;
        }
        //解析显示分页条，点击分页要能去下一页....
        function build_page_nav(result){
            //page_nav_area
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");

            //构建元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if(result.store.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加点击翻页的事件
                firstPageLi.click(function(){
                    to_page(1);
                });
                prePageLi.click(function(){
                    to_page(result.store.pageInfo.pageNum -1);
                });
            }



            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if(result.store.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function(){
                    to_page(result.store.pageInfo.pageNum +1);
                });
                lastPageLi.click(function(){
                    to_page(result.store.pageInfo.pages);
                });
            }



            //添加首页和前一页 的提示
            ul.append(firstPageLi).append(prePageLi);
            //1,2，3遍历给ul中添加页码提示
            $.each(result.store.pageInfo.navigatepageNums,function(index,item){

                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(result.store.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function(){
                    to_page(item);
                });
                ul.append(numLi);
            });
            //添加下一页和末页 的提示
            ul.append(nextPageLi).append(lastPageLi);

            //把ul加入到nav
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        $("#add_emp_info").click(function () {
            console.log($("#add_emp_table form"));
            // 清空表单数据
            $("#add_emp_table form")[0].reset();

            $('#add_emp_table').modal({
                backdrop:"static"
            })
            $.ajax({
                url:"${APP_PATH}/deptList",
                type: "GET",
                success:function (result) {
                    console.log(result)
                    insert_dept_data(result);
                }
            })
        })

        // 检验empName输入规范
        function validate_empName_data() {
            let val = $("#empName_update_data").val();
            let reg = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;

            if (!reg.test(val)) {
                // alert("empName必须是3~16位数字，后2~5位中文字符");
                $("#empName_update_data").parent().addClass("has-error");
                $("#empName_update_data").next("span").text("empName必须是3~16位数字，后2~5位中文字符");
                return false;
            }else {
                $("#empName_update_data").parent().removeClass("has-error").addClass("has-success");
                $("#empName_update_data").next("span").text("")
            }

            let valEmail = $("#email_update_data").val();
            let regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;

            if (!regEmail.test(valEmail)) {
                // alert("email必须是xxx@xxx格式，且不含有特殊字符");
                $("#email_update_data").parent().addClass("has-error");
                $("#email_update_data").next("span").text("email必须是xxx@xxx格式，且不含有特殊字符");
                return false;
            }else {
                $("#email_update_data").parent().removeClass("has-error").addClass("has-success");
                $("#email_update_data").next("span").text("")
            }

            return true;
        }

        // 保存员工信息
        $("#save_emp_info").click(function () {
            // alert($("#add_emp_table form").serialize());

            if ($(this).attr("state") === "false") return false;

            if (!validate_empName_data()) {
                return false;
            }

            $.ajax({
                url:"${APP_PATH}/emp",
                data:$("#add_emp_table form").serialize(),
                type:"POST",
                success:function (result) {
                    // console.log(result)


                    $('#add_emp_table').modal('hide')
                    to_page(pageNum + 1);
                }
            })
        })

        // 检查用户名是否可用
        $("#empName_update_data").change(function () {
            let name = $("#empName_update_data").val();
            console.log(name)
            $.ajax({
                url:"${APP_PATH}/checkName",
                type:"GET",
                data:"name=" + name,
                success: function (result) {
                    console.log(result);
                    if (result.code === 200) {
                        $("#empName_update_data").parent().addClass("has-error");
                        $("#empName_update_data").next("span").text("用户名已存在");
                        $("#save_emp_info").attr("state", "false");
                    }
                    else {
                        $("#empName_update_data").parent().removeClass("has-error").addClass("has-success");
                        $("#empName_update_data").next("span").text("")
                        $("#save_emp_info").attr("state", "true");
                    }
                }
            })
        })

        function insert_dept_data(result) {
            $.each(result, function () {
                $("#deptName_label select").append(
                    $("<option></option>").append(this.deptName).attr("value", this.deptId));
            })
        }
    </script>
</div>

</body>
</html>