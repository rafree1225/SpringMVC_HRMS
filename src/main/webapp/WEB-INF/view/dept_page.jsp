<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html>
    <head>
        <!-- Head -->
        <%@include file="include/head.jspf"  %>
    </head>
    <body style="padding: 10px">

        <div id="layout">
            <!-- Toggle -->
            <%@include file="include/toggle.jspf"  %>

            <!-- Menu -->
            <%@include file="include/menu.jspf"  %>

            <div id="main">
                <div class="header">
                    <h1>部門</h1>
                    <h2>${ result }</h2>
                </div>
                <table class="pure-table" style="border: none;">
                    <td valign="top">
                        <!-- 表單 -->
                        <form:form class="pure-form" 
                                   modelAttribute="dept" 
                                   method="post" 
                                   action="${pageContext.request.contextPath}/mvc/dept/" >
                            <fieldset>
                                <legend>部門表單 ─ 新增、修改、刪除</legend>
                                部門序號：<br/>
                                <form:input path="id" readonly="true" /><p />
                                部門名稱：<br/>
                                <form:input path="name" placeholder="請輸入部門名稱" /><p />
                                <form:errors path="name" style="color:red" /><p />
                                操作狀態：<br/>
                                <input type="text" id="_method" name="_method" readonly="true" value="${ _method }" /><p />
                                <button type="sumbit" class="pure-button pure-button-primary">Submit</button>
                            </fieldset>
                        </form:form>
                        
                    </td>
                    <td valign="top">
                        <!-- 列表 -->
                        <form class="pure-form">
                            <fieldset>
                                <legend>部門清單</legend>
                                <table class="pure-table pure-table-bordered" width="100%">
                                    <thead>
                                        <tr>
                                            <th>序號</th>
                                            <th>名稱</th>
                                            <th>人數</th>
                                            <th>修改</th>
                                            <th>刪除</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach var="dept" items="${ dept_list }">
                                            <tr>
                                                <td>${ dept.id }</td>
                                                <td>${ dept.name }</td>
                                                <td>${ fn:length(dept.employees) }</td>
                                                <td><a href="${pageContext.request.contextPath}/mvc/dept/${ dept.id }">修改</a></td>
                                                <td><a href="${pageContext.request.contextPath}/mvc/dept/delete/${ dept.id }">刪除</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table> 
                            </fieldset>
                        </form>
                    </td>
                    <td valign="top">
                        <!-- 圖表 -->
                        <form class="pure-form">
                            <fieldset>
                                <legend>部門圖表</legend>
                                <%@include file="chart/dept_chart.jspf" %>
                            </fieldset>
                        </form>
                    </td>
                </table>   


            </div>
        </div>

        <!-- Foot -->
        <%@include file="include/foot.jspf"  %>

        <script src="${pageContext.servletContext.contextPath}/js/ui.js"></script>
    </body>
</html>