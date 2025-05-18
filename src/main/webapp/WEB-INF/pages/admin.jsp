<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - PitStop Manager</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <style>
        body {
            background: linear-gradient(135deg, #000428, #004e92) !important; /* Deep Blue Gradient */
            min-height: 100vh;
        }

        .nav-brand {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .nav-brand img {
            width: 32px;
            height: 32px;
        }

        .nav-brand h1 {
            font-size: 1.5rem;
            color: white;
        }

        .nav-brand span {
            color: var(--racing-red);
        }

        .nav-menu {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .nav-menu .logout-button {
            background: transparent;
            border: 2px solid var(--racing-blue);
            color: var(--silver-gray);
            padding: 0.5rem 1.5rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: 1rem;
        }

        .nav-menu .logout-button:hover {
            background: var(--racing-red);
            border-color: var(--racing-red);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 0, 0, 0.2);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 1.5rem;
            text-align: center;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .stat-card h3 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: white;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: bold;
            color: var(--racing-red);
        }

        .data-section {
            margin-bottom: 2rem;
        }

        .data-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .card-header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .card-header-actions h2 {
            font-size: 1.5rem;
            margin: 0;
            color: white;
        }

        .btn-add {
            background: var(--racing-blue);
            color: white;
            padding: 0.5rem 1.5rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
            font-weight: 500;
            font-size: 1rem;
        }

        .btn-add:hover {
            background: var(--racing-red);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: white;
        }

        th {
            background: rgba(255, 255, 255, 0.1);
            font-weight: bold;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn-edit, .btn-delete {
            background: transparent;
            border: none;
            color: var(--racing-blue);
            cursor: pointer;
            font-size: 1rem;
            transition: color 0.3s ease;
        }

        .btn-edit:hover {
            color: var(--racing-red);
        }

        .btn-delete:hover {
            color: var(--racing-red);
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.8);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 10px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            margin: 0;
            font-size: 1.5rem;
            color: #333;
        }

        .modal-close {
            background: transparent;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #333;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: var(--racing-blue);
            outline: none;
        }

        .modal-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }

        .btn-save, .btn-cancel {
            background: var(--racing-blue);
            color: white;
            padding: 0.5rem 1.5rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
            font-weight: 500;
            font-size: 1rem;
        }

        .btn-cancel {
            background: transparent;
            border: 2px solid var(--racing-blue);
            color: var(--silver-gray);
        }

        .btn-cancel:hover {
            background: var(--racing-red);
            border-color: var(--racing-red);
            color: white;
        }

        .btn-save:hover {
            background: var(--racing-red);
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="container nav-container">
            <div class="nav-brand">
                <img src="${pageContext.request.contextPath}/resources/images/icons/f1-icon.png" alt="F1 Icon">
                <h1>Admin<span>Dashboard</span></h1>
            </div>
            <ul class="nav-menu">
                <li>
                    <form action="${pageContext.request.contextPath}/logout" method="POST" style="margin: 0;">
                        <button type="submit" class="logout-button">Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container dashboard-container">
        <!-- Statistics Summary -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Users</h3>
                <p class="stat-value">${totalUsers}</p>
            </div>
            <div class="stat-card">
                <h3>Total Drivers</h3>
                <p class="stat-value">${totalDrivers}</p>
            </div>
            <div class="stat-card">
                <h3>Total Teams</h3>
                <p class="stat-value">${totalTeams}</p>
            </div>
            <div class="stat-card">
                <h3>Active Contracts</h3>
                <p class="stat-value">${totalContracts}</p>
            </div>
        </div>

        <!-- Data Tables -->
        <div class="data-section">
            <div id="users" class="data-card">
                <div class="card-header-actions">
                    <h2>Users</h2>
                    <button class="btn-add" onclick="showAddUserModal()">Add New User</button>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Created At</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.userId}</td>
                                <td>${user.username}</td>
                                <td>${user.email}</td>
                                <td>${user.role}</td>
                                <td>${user.createdAt}</td>
                                <td class="action-buttons">
                                    <button class="btn-edit" onclick="showEditUserModal('${user.userId}', '${user.username}', '${user.email}', '${user.role}')">Edit</button>
                                    <button class="btn-delete" onclick="confirmDelete('user', ${user.userId})">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Add User Modal -->
            <div id="addUserModal" class="modal">
                <div class="modal-content">
                    <h3>Add New User</h3>
                    <form action="${pageContext.request.contextPath}/admin" method="POST">
                        <input type="hidden" name="action" value="create">
                        <input type="hidden" name="entity" value="user">
                        
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="username" required>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" required>
                        </div>
                        <div class="form-group">
                            <label>Role</label>
                            <select name="role" required>
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                                <option value="manager">Manager</option>
                            </select>
                        </div>
                        <div class="modal-buttons">
                            <button type="submit" class="btn-save">Save</button>
                            <button type="button" class="btn-cancel" onclick="closeModal('addUserModal')">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Edit User Modal -->
            <div id="editUserModal" class="modal">
                <div class="modal-content">
                    <h3>Edit User</h3>
                    <form action="${pageContext.request.contextPath}/admin" method="POST">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="entity" value="user">
                        <input type="hidden" name="id" id="editUserId">
                        
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="username" id="editUsername" required>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" id="editEmail" required>
                        </div>
                        <div class="form-group">
                            <label>Role</label>
                            <select name="role" id="editRole" required>
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                                <option value="manager">Manager</option>
                            </select>
                        </div>
                        <div class="modal-buttons">
                            <button type="submit" class="btn-save">Update</button>
                            <button type="button" class="btn-cancel" onclick="closeModal('editUserModal')">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <div id="drivers" class="data-card">
                <div class="card-header-actions">
                    <h2>Drivers</h2>
                    <button class="btn-add" onclick="showAddDriverModal()">Add New Driver</button>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Age</th>
                            <th>Market Value</th>
                            <th>Points</th>
                            <th>Team ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="d" items="${drivers}">
                            <tr>
                                <td>${d.driverId}</td>
                                <td>${d.driverName}</td>
                                <td>${d.age}</td>
                                <td>${d.marketValue}</td>
                                <td>${d.pointsScored}</td>
                                <td>${d.teamId}</td>
                                <td class="action-buttons">
                                    <button class="btn-edit" onclick="showEditDriverModal('${d.driverId}', '${d.driverName}', ${d.age}, ${d.marketValue}, ${d.teamId})">Edit</button>
                                    <button class="btn-delete" onclick="confirmDelete('driver', ${d.driverId})">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div id="teams" class="data-card">
                <div class="card-header-actions">
                    <h2>Teams</h2>
                    <button class="btn-add" onclick="showAddTeamModal()">Add New Team</button>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Principal</th>
                            <th>Base</th>
                            <th>Budget</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${teams}">
                            <tr>
                                <td>${t.teamId}</td>
                                <td>${t.teamName}</td>
                                <td>${t.teamPrincipal}</td>
                                <td>${t.baseLocation}</td>
                                <td>${t.teamBudget}</td>
                                <td class="action-buttons">
                                    <button class="btn-edit" onclick="showEditTeamModal('${t.teamId}', '${t.teamName}', '${t.teamPrincipal}', '${t.baseLocation}', ${t.teamBudget})">Edit</button>
                                    <button class="btn-delete" onclick="confirmDelete('team', ${t.teamId})">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div id="contracts" class="data-card">
                <div class="card-header-actions">
                    <h2>Contracts</h2>
                    <button class="btn-add" onclick="showAddContractModal()">Add New Contract</button>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Driver ID</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Fee</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${contracts}">
                            <tr>
                                <td>${c.contractId}</td>
                                <td>${c.driverId}</td>
                                <td>${c.startDate}</td>
                                <td>${c.endDate}</td>
                                <td>${c.transferFee}</td>
                                <td class="action-buttons">
                                    <button class="btn-edit" onclick="showEditContractModal('${c.contractId}', ${c.driverId}, '${c.startDate}', '${c.endDate}', ${c.transferFee})">Edit</button>
                                    <button class="btn-delete" onclick="confirmDelete('contract', ${c.contractId})">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Add Driver Modal -->
            <div id="addDriverModal" class="modal">
                <div class="modal-content">
                    <h3>Add New Driver</h3>
                    <form action="${pageContext.request.contextPath}/admin" method="POST">
                        <input type="hidden" name="action" value="create">
                        <input type="hidden" name="entity" value="driver">
                        
                        <div class="form-group">
                            <label>Driver Name</label>
                            <input type="text" name="driverName" required>
                        </div>
                        <div class="form-group">
                            <label>Age</label>
                            <input type="number" name="age" required>
                        </div>
                        <div class="form-group">
                            <label>Market Value</label>
                            <input type="number" name="marketValue" required>
                        </div>
                        <div class="form-group">
                            <label>Team ID</label>
                            <select name="teamId" required>
                                <c:forEach var="team" items="${teams}">
                                    <option value="${team.teamId}">${team.teamName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="modal-buttons">
                            <button type="submit" class="btn-save">Save</button>
                            <button type="button" class="btn-cancel" onclick="closeModal('addDriverModal')">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Add Team Modal -->
            <div id="addTeamModal" class="modal">
                <div class="modal-content">
                    <h3>Add New Team</h3>
                    <form action="${pageContext.request.contextPath}/admin" method="POST">
                        <input type="hidden" name="action" value="create">
                        <input type="hidden" name="entity" value="team">
                        
                        <div class="form-group">
                            <label>Team Name</label>
                            <input type="text" name="teamName" required>
                        </div>
                        <div class="form-group">
                            <label>Team Principal</label>
                            <input type="text" name="teamPrincipal" required>
                        </div>
                        <div class="form-group">
                            <label>Base Location</label>
                            <input type="text" name="baseLocation" required>
                        </div>
                        <div class="form-group">
                            <label>Team Budget</label>
                            <input type="number" name="teamBudget" required>
                        </div>
                        <div class="modal-buttons">
                            <button type="submit" class="btn-save">Save</button>
                            <button type="button" class="btn-cancel" onclick="closeModal('addTeamModal')">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Add Contract Modal -->
            <div id="addContractModal" class="modal">
                <div class="modal-content">
                    <h3>Add New Contract</h3>
                    <form action="${pageContext.request.contextPath}/admin" method="POST">
                        <input type="hidden" name="action" value="create">
                        <input type="hidden" name="entity" value="contract">
                        
                        <div class="form-group">
                            <label>Driver</label>
                            <select name="driverId" required>
                                <c:forEach var="driver" items="${drivers}">
                                    <option value="${driver.driverId}">${driver.driverName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Start Date</label>
                            <input type="date" name="startDate" required>
                        </div>
                        <div class="form-group">
                            <label>End Date</label>
                            <input type="date" name="endDate" required>
                        </div>
                        <div class="form-group">
                            <label>Transfer Fee</label>
                            <input type="number" name="transferFee" required>
                        </div>
                        <div class="modal-buttons">
                            <button type="submit" class="btn-save">Save</button>
                            <button type="button" class="btn-cancel" onclick="closeModal('addContractModal')">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Edit Driver Modal -->
            <div id="editDriverModal" class="modal">
                <div class="modal-content">
                    <h3>Edit Driver</h3>
                    <form action="${pageContext.request.contextPath}/admin" method="POST">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="entity" value="driver">
                        <input type="hidden" name="id" id="editDriverId">
                        
                        <div class="form-group">
                            <label>Driver Name</label>
                            <input type="text" name="driverName" id="editDriverName" required>
                        </div>
                        <div class="form-group">
                            <label>Age</label>
                            <input type="number" name="age" id="editDriverAge" required>
                        </div>
                        <div class="form-group">
                            <label>Market Value</label>
                            <input type="number" name="marketValue" id="editDriverMarketValue" required>
                        </div>
                        <div class="form-group">
                            <label>Team ID</label>
                            <select name="teamId" id="editDriverTeamId" required>
                                <c:forEach var="team" items="${teams}">
                                    <option value="${team.teamId}">${team.teamName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="modal-buttons">
                            <button type="submit" class="btn-save">Update</button>
                            <button type="button" class="btn-cancel" onclick="closeModal('editDriverModal')">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Edit Team Modal -->
            <div id="editTeamModal" class="modal">
                <div class="modal-content">
                    <h3>Edit Team</h3>
                    <form action="${pageContext.request.contextPath}/admin" method="POST">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="entity" value="team">
                        <input type="hidden" name="id" id="editTeamId">
                        
                        <div class="form-group">
                            <label>Team Name</label>
                            <input type="text" name="teamName" id="editTeamName" required>
                        </div>
                        <div class="form-group">
                            <label>Team Principal</label>
                            <input type="text" name="teamPrincipal" id="editTeamPrincipal" required>
                        </div>
                        <div class="form-group">
                            <label>Base Location</label>
                            <input type="text" name="baseLocation" id="editTeamBaseLocation" required>
                        </div>
                        <div class="form-group">
                            <label>Team Budget</label>
                            <input type="number" name="teamBudget" id="editTeamBudget" required>
                        </div>
                        <div class="modal-buttons">
                            <button type="submit" class="btn-save">Update</button>
                            <button type="button" class="btn-cancel" onclick="closeModal('editTeamModal')">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Edit Contract Modal -->
            <div id="editContractModal" class="modal">
                <div class="modal-content">
                    <h3>Edit Contract</h3>
                    <form action="${pageContext.request.contextPath}/admin" method="POST">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="entity" value="contract">
                        <input type="hidden" name="id" id="editContractId">
                        
                        <div class="form-group">
                            <label>Driver</label>
                            <select name="driverId" id="editContractDriverId" required>
                                <c:forEach var="driver" items="${drivers}">
                                    <option value="${driver.driverId}">${driver.driverName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Start Date</label>
                            <input type="date" name="startDate" id="editContractStartDate" required>
                        </div>
                        <div class="form-group">
                            <label>End Date</label>
                            <input type="date" name="endDate" id="editContractEndDate" required>
                        </div>
                        <div class="form-group">
                            <label>Transfer Fee</label>
                            <input type="number" name="transferFee" id="editContractTransferFee" required>
                        </div>
                        <div class="modal-buttons">
                            <button type="submit" class="btn-save">Update</button>
                            <button type="button" class="btn-cancel" onclick="closeModal('editContractModal')">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
    function showAddUserModal() {
        document.getElementById('addUserModal').style.display = 'block';
    }

    function showEditUserModal(id, username, email, role) {
        document.getElementById('editUserId').value = id;
        document.getElementById('editUsername').value = username;
        document.getElementById('editEmail').value = email;
        document.getElementById('editRole').value = role;
        document.getElementById('editUserModal').style.display = 'block';
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    function confirmDelete(entity, id) {
        if (confirm('Are you sure you want to delete this ' + entity + '?')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/admin';
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';
            
            const entityInput = document.createElement('input');
            entityInput.type = 'hidden';
            entityInput.name = 'entity';
            entityInput.value = entity;
            
            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = id;
            
            form.appendChild(actionInput);
            form.appendChild(entityInput);
            form.appendChild(idInput);
            document.body.appendChild(form);
            form.submit();
        }
    }

    function showAddDriverModal() {
        document.getElementById('addDriverModal').style.display = 'block';
    }

    function showAddTeamModal() {
        document.getElementById('addTeamModal').style.display = 'block';
    }

    function showAddContractModal() {
        document.getElementById('addContractModal').style.display = 'block';
    }

    function showEditDriverModal(id, name, age, marketValue, teamId) {
        document.getElementById('editDriverId').value = id;
        document.getElementById('editDriverName').value = name;
        document.getElementById('editDriverAge').value = age;
        document.getElementById('editDriverMarketValue').value = marketValue;
        document.getElementById('editDriverTeamId').value = teamId;
        document.getElementById('editDriverModal').style.display = 'block';
    }

    function showEditTeamModal(id, name, principal, base, budget) {
        document.getElementById('editTeamId').value = id;
        document.getElementById('editTeamName').value = name;
        document.getElementById('editTeamPrincipal').value = principal;
        document.getElementById('editTeamBaseLocation').value = base;
        document.getElementById('editTeamBudget').value = budget;
        document.getElementById('editTeamModal').style.display = 'block';
    }

    function showEditContractModal(id, driverId, startDate, endDate, fee) {
        document.getElementById('editContractId').value = id;
        document.getElementById('editContractDriverId').value = driverId;
        document.getElementById('editContractStartDate').value = startDate;
        document.getElementById('editContractEndDate').value = endDate;
        document.getElementById('editContractTransferFee').value = fee;
        document.getElementById('editContractModal').style.display = 'block';
    }
    </script>
</body>
</html>
