package com.PitStopManager.service;

import com.PitStopManager.config.DbConfig;
import com.PitStopManager.model.DriverTeam;
import com.PitStopManager.model.Team;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverService {
    
    public List<DriverTeam> getAllDrivers() throws SQLException, ClassNotFoundException {
        List<DriverTeam> drivers = new ArrayList<>();
        String sql = "SELECT * FROM driver_team";
        
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                DriverTeam driver = mapResultSetToDriver(rs);
                drivers.add(driver);
            }
        }
        return drivers;
    }

    public List<Team> getAllTeams() throws SQLException, ClassNotFoundException {
        List<Team> teams = new ArrayList<>();
        String sql = "SELECT * FROM team";
        
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Team team = new Team();
                team.setTeamId(rs.getInt("TeamID"));
                team.setTeamName(rs.getString("TeamName"));
                team.setTeamPrincipal(rs.getString("TeamPrincipal"));
                team.setBaseLocation(rs.getString("BaseLocation"));
                team.setTeamBudget(rs.getDouble("TeamBudget"));
                teams.add(team);
            }
        }
        return teams;
    }

    public List<DriverTeam> filterDrivers(Integer teamId, Integer minAge, Integer maxAge, 
                                        Integer minPoints, Double minMarketValue) 
            throws SQLException, ClassNotFoundException {
        
        List<DriverTeam> drivers = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM driver_team WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (teamId != null) {
            sql.append(" AND TeamID = ?");
            params.add(teamId);
        }
        if (minAge != null) {
            sql.append(" AND Age >= ?");
            params.add(minAge);
        }
        if (maxAge != null) {
            sql.append(" AND Age <= ?");
            params.add(maxAge);
        }
        if (minPoints != null) {
            sql.append(" AND PointsScored >= ?");
            params.add(minPoints);
        }
        if (minMarketValue != null) {
            sql.append(" AND MarketValue >= ?");
            params.add(minMarketValue);
        }

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    DriverTeam driver = mapResultSetToDriver(rs);
                    drivers.add(driver);
                }
            }
        }
        return drivers;
    }

    private DriverTeam mapResultSetToDriver(ResultSet rs) throws SQLException {
        DriverTeam driver = new DriverTeam();
        driver.setDriverId(rs.getInt("DriverID"));
        driver.setDriverName(rs.getString("DriverName"));
        driver.setAge(rs.getInt("Age"));
        driver.setMarketValue(rs.getDouble("MarketValue"));
        driver.setRaceWins(rs.getInt("RaceWins"));
        driver.setPodiumFinishes(rs.getInt("PodiumFinishes"));
        driver.setFastestLaps(rs.getInt("FastestLaps"));
        driver.setPointsScored(rs.getInt("PointsScored"));
        driver.setConsistencyRating(rs.getDouble("ConsistencyRating"));
        driver.setTeamId(rs.getInt("TeamID"));
        return driver;
    }
}
