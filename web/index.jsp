<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%-- import redis connector and set operations --%>
<%@page import="redistools.RedisConnector" %>
<%@page import="redistools.SetOperations" %>
<%@page import="servlet.*" %>
<%@page import="java.util.*" %>
<%@page import="javax.servlet.jsp.*" %>
<%@page import="java.io.*" %>

<!DOCTYPE html>
<%!
    // initialize Jedis
    SetOperations so = new SetOperations("candidates");

    // function definitions
    public void makeDivCard(PrintWriter out, String $name, int $score) {
        out.println("<div class=\"card\">");
        out.println("<span class=\"score\">(" + $score + ")</span><span class=\"name\">" + $name + "</span>");
        out.println("<button class=\"votebtn\">vote</button>");
        out.println("</div>");
    }
%>


<html>
<head>
    <meta charset="utf-8">
    <title>Redis Voting System</title>
    <link rel="stylesheet" href="styles.css" charset="utf-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
</head>
<body>
<%
    session.setAttribute("setoper", so);
%>
<h1>Redis Voting System - Redis Tutorial</h1>
<div id="navbar">
    <a href="/AddCandidate.jsp">Add candidate</a>
    <a href="/resetList">Reset Candidate List</a>
</div>

<div id="centerPane">
    <%
        Set<String> entries = so.sortDesc();
        for (String entry : entries) {
            int score = so.getScore(entry);
            makeDivCard(new PrintWriter((Writer) out, true), entry, score);
        }
    %>
</div>

<script>
    $(document).ready(function () {
        $("button").click(function () {
            var entry = $(this).prevAll('.name').text();
            //    console.log("voted for " + entry);
            $.ajax({
                url: '/vote',
                type: "POST",
                data: {entryName: entry}
            }).done(function () {
                window.location.reload();
            });
        });
    });
</script>

</body>
</html>
