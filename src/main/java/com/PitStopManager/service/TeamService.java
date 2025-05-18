package com.PitStopManager.service;

import com.PitStopManager.config.DbConfig;
import com.PitStopManager.model.Team;
import java.sql.*;
import java.util.*;

public class TeamService {
    public List<Team> getAllTeams() {
        List<Team> teams = new ArrayList<>();
        String sql = "SELECT * FROM team";
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Team t = new Team();
                t.setTeamId(rs.getInt("TeamID"));
                t.setTeamName(rs.getString("TeamName"));
                t.setTeamPrincipal(rs.getString("TeamPrincipal"));
                t.setBaseLocation(rs.getString("BaseLocation"));
                t.setTeamBudget(rs.getDouble("TeamBudget"));
                teams.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teams;
    }

    // New method to get driver names for each team
    public Map<Integer, String> getTeamDriverNames() {
        Map<Integer, String> teamDrivers = new HashMap<>();
        String sql = "SELECT TeamID, GROUP_CONCAT(DriverName ORDER BY DriverName SEPARATOR ', ') AS DriverNames FROM driver_team GROUP BY TeamID";
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                int teamId = rs.getInt("TeamID");
                String driverNames = rs.getString("DriverNames");
                teamDrivers.put(teamId, driverNames);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teamDrivers;
    }
}
