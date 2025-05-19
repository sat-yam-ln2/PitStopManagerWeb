package com.PitStopManager.model;

public class Team {
    private int teamId;
    private String teamName;
    private String teamPrincipal;
    private String baseLocation;
    private double teamBudget;

    // Getters and Setters
    public int getTeamId() { return teamId; }
    public void setTeamId(int teamId) { this.teamId = teamId; }

    public String getTeamName() { return teamName; }
    public void setTeamName(String teamName) { this.teamName = teamName; }

    public String getTeamPrincipal() { return teamPrincipal; }
    public void setTeamPrincipal(String teamPrincipal) { this.teamPrincipal = teamPrincipal; }

    public String getBaseLocation() { return baseLocation; }
    public void setBaseLocation(String baseLocation) { this.baseLocation = baseLocation; }

    public double getTeamBudget() { return teamBudget; }
    public void setTeamBudget(double teamBudget) { this.teamBudget = teamBudget; }
}
