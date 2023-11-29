<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html>
    <head>
        <!-- Head -->
        <%@include file="include/head.jspf"  %>

        <style>
            legend, 
            .pure-table thead th {
                font-weight: bold; /* 將字體設為粗體 */
            }


            .pure-form legend {
                color: 	#000000; /* 黑色 */
            }
            .pure-form input {
                color: #6C6C6C; /* 深灰色 */
            }
            .pure-table thead th {
                background-color: #0072E3; /* 深藍色 */
                color: 	#FFFFFF; /* 白色 */
            }
            .pure-table tbody td {
                background-color: #FFFFFF; /* 白色 */
                color:#000000; /* 黑色 */
            }

        </style>

    </head>
    <body style="padding: 10px">

        <div id="layout">
            <!-- Toggle -->
            <%@include file="include/toggle.jspf"  %>

            <!-- Menu -->
            <%@include file="include/menu.jspf"  %>

            <div id="main">
                <div class="header">
                    <h1>員工</h1>
                    <h2>公司員工個人資料</h2>
                </div>
                <table class="pure-table" style="border: none;">
                    <td valign="top">
                        <!-- 表單 -->
                        <form:form class="pure-form" 
                                   modelAttribute="emp" 
                                   method="post" 
                                   action="${pageContext.request.contextPath}/mvc/emp/" >
                            <fieldset>
                                <legend>員工表單 ─ 新增、修改、刪除</legend>
                                員工序號：<br/>
                                <form:input path="id" readonly="true" /><p />
                                員工姓名：<br/>
                                <form:input path="name" placeholder="請輸入姓名" /><p />
                                <form:errors path="name" style="color:red" /><p />
                                員工薪資：<br/>
                                <form:input path="salary.money" placeholder="請輸入薪資" /><p />
                                <form:errors path="salary.money" style="color:red" /><p />
                                操作狀態：<br/>
                                <input type="text" id="_method" name="_method" readonly="true" value="${ _method }" /><p />
                                員工部門：<br/>
                                <form:select path="department.id">
                                    <form:option value="0" label="請選擇部門" />
                                    <form:options items="${ dept_list }" itemValue="id" itemLabel="name" />
                                </form:select><p />
                                員工社團：<br/>
                                <c:forEach var="club" items="${ club_list }">
                                    <input name="clubIds" type="checkbox" value="${ club.id }" 
                                           <c:forEach var="eclub" items="${ emp.clubs }">
                                               <c:if test="${ eclub.id eq club.id }">
                                                   checked
                                               </c:if>
                                           </c:forEach>
                                           > ${ club.name }
                                </c:forEach><p />
                                <button type="sumbit" class="pure-button pure-button-primary">Submit</button>
                            </fieldset>

                        </form:form>
                    </td>
                    <td valign="top">
                        <!-- 圖表 -->
                        <form class="pure-form">
                            <fieldset>
                                <legend>薪資圖表</legend>
                                <%@include file="chart/salary_chart.jspf" %>
                            </fieldset>
                        </form>
                        <!-- 列表 -->
                        <form class="pure-form">
                            <fieldset>
                                <legend>員工列表</legend>
                                <table class="pure-table pure-table-bordered" width="100%">
                                    <thead>

                                        <tr>
                                            <th>序號</th>
                                            <th>姓名</th>
                                            <th>部門</th>
                                            <th>薪資</th>
                                            <th>社團</th>
                                            <th>修改</th>
                                            <th>刪除</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach var="emp" items="${ emp_list }">
                                            <tr>
                                                <td>${ emp.id }</td>
                                                <td>${ emp.name }</td>
                                                <td>${ emp.department.name }</td>
                                                <td>
                                                    <fmt:formatNumber type="number" pattern="###,###" value="${ emp.salary.money }" />
                                                </td>
                                                <td>
                                                    <c:forEach var="club" items="${ emp.clubs }">
                                                        ${ club.name }
                                                    </c:forEach>    
                                                </td>
                                                <td><a href="${pageContext.request.contextPath}/mvc/emp/${ emp.id }">修改</a></td>
                                                <td><a href="${pageContext.request.contextPath}/mvc/emp/delete/${ emp.id }">刪除</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table> 
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