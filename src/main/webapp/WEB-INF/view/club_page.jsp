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
                    <h1>社團</h1>
                    <h2>公司社團分類</h2>
                </div>
                <table class="pure-table" style="border: none;">
                    <td valign="top">
                        <!-- 表單 -->
                        <form:form class="pure-form" 
                                   modelAttribute="club" 
                                   method="post" 
                                   action="${pageContext.request.contextPath}/mvc/club/" >
                            <fieldset>
                                <legend>社團表單 ─ 新增、修改、刪除</legend>
                                社團序號：<br/>
                                <form:input path="id" readonly="true" /><p />
                                社團名稱：<br/>
                                <form:input path="name" placeholder="請輸入社團名稱" /><p />
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
                                <legend>社團清單</legend>
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
                                        <c:forEach var="club" items="${ club_list }">
                                            <tr>
                                                <td>${ club.id }</td>
                                                <td>${ club.name }</td>
                                                <td>${ fn:length(club.employees) }</td>
                                                <td><a href="${pageContext.request.contextPath}/mvc/club/${ club.id }">修改</a></td>
                                                <td><a href="${pageContext.request.contextPath}/mvc/club/delete/${ club.id }">刪除</a></td>
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
                                <legend>社團圖表</legend>
                                <%@include file="chart/club_chart.jspf" %>
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