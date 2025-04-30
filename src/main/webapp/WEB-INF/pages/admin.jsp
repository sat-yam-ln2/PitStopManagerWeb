<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css" />
</head>
<body>
  <div class="navbar">
    <a href="#users" class="active">Users</a>
    <a href="#drivers">Drivers</a>
    <a href="#teams">Teams</a>
    <a href="#contracts">Contracts</a>
  </div>

  <div class="container">
    <div id="users" class="card">
      <h2>Users</h2>
      <table>
        <tr>
          <th>ID</th><th>Username</th><th>Email</th><th>Role</th><th>Created At</th><th>Last Login</th>
        </tr>
        <c:forEach var="u" items="${users}">
          <tr>
            <td>${u.userId}</td>
            <td>${u.username}</td>
            <td>${u.email}</td>
            <td>${u.role}</td>
            <td>${u.createdAt}</td>
            <td>${u.lastLogin}</td>
          </tr>
        </c:forEach>
      </table>
    </div>

    <div id="drivers" class="card">
      <h2>Drivers</h2>
      <table>
        <tr>
          <th>ID</th><th>Name</th><th>Age</th><th>Market Value</th><th>Points</th><th>Team ID</th>
        </tr>
        <c:forEach var="d" items="${drivers}">
          <tr>
            <td>${d.driverId}</td>
            <td>${d.driverName}</td>
            <td>${d.age}</td>
            <td>${d.marketValue}</td>
            <td>${d.pointsScored}</td>
            <td>${d.teamId}</td>
          </tr>
        </c:forEach>
      </table>
    </div>

    <div id="teams" class="card">
      <h2>Teams</h2>
      <table>
        <tr>
          <th>ID</th><th>Name</th><th>Principal</th><th>Base</th><th>Budget</th>
        </tr>
        <c:forEach var="t" items="${teams}">
          <tr>
            <td>${t.teamId}</td>
            <td>${t.teamName}</td>
            <td>${t.teamPrincipal}</td>
            <td>${t.baseLocation}</td>
            <td>${t.teamBudget}</td>
          </tr>
        </c:forEach>
      </table>
    </div>

    <div id="contracts" class="card">
      <h2>Contracts</h2>
      <table>
        <tr>
          <th>ID</th><th>Driver ID</th><th>Start Date</th><th>End Date</th><th>Fee</th>
        </tr>
        <c:forEach var="c" items="${contracts}">
          <tr>
            <td>${c.contractId}</td>
            <td>${c.driverId}</td>
            <td>${c.startDate}</td>
            <td>${c.endDate}</td>
            <td>${c.transferFee}</td>
          </tr>
        </c:forEach>
      </table>
    </div>
  </div>
</body>
</html>
