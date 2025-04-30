package com.PitStopManager.model;

public class DriverTeam {
    private int driverId;
    private String driverName;
    private int age;
    private double marketValue;
    private int raceWins;
    private int podiumFinishes;
    private int fastestLaps;
    private int pointsScored;
    private double consistencyRating;
    private int teamId;

    // Getters and Setters
    public int getDriverId() { return driverId; }
    public void setDriverId(int driverId) { this.driverId = driverId; }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public double getMarketValue() { return marketValue; }
    public void setMarketValue(double marketValue) { this.marketValue = marketValue; }

    public int getRaceWins() { return raceWins; }
    public void setRaceWins(int raceWins) { this.raceWins = raceWins; }

    public int getPodiumFinishes() { return podiumFinishes; }
    public void setPodiumFinishes(int podiumFinishes) { this.podiumFinishes = podiumFinishes; }

    public int getFastestLaps() { return fastestLaps; }
    public void setFastestLaps(int fastestLaps) { this.fastestLaps = fastestLaps; }

    public int getPointsScored() { return pointsScored; }
    public void setPointsScored(int pointsScored) { this.pointsScored = pointsScored; }

    public double getConsistencyRating() { return consistencyRating; }
    public void setConsistencyRating(double consistencyRating) { this.consistencyRating = consistencyRating; }

    public int getTeamId() { return teamId; }
    public void setTeamId(int teamId) { this.teamId = teamId; }
}
