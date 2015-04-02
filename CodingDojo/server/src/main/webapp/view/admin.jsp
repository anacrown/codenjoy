<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<head>
    <meta http-equiv="Content-Type" content="text/html;">
    <title>Admin page</title>
    <link href="${ctx}/resources/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx}/resources/css/dojo.css" rel="stylesheet">
    <script src="${ctx}/resources/js/jquery-1.7.2.js"></script>
    <script src="${ctx}/resources/js/jquery.validate.js"></script>
    <script src="${ctx}/resources/js/validation.js"></script>
    <script src="${ctx}/resources/js/admin.js"></script>
    <script src="${ctx}/resources/js/hotkeys.js"></script>
    <script>
        $(document).ready(function () {
            initHotkeys('${gameName}', '${ctx}/');
        });
    </script>
</head>
<body>
    <div class="page-header">
        <h1>Admin page</h1>
    </div>

    <table class="admin-table" id="selectGame">
        <tr>
            <td>
                <c:forEach items="${games}" var="game" varStatus="status">
                    <c:if test="${game == gameName}">
                        <b>
                    </c:if>
                        <a href="${ctx}/admin31415?gameName=${game}&select">${game}</a>
                    <c:if test="${game == gameName}">
                        </b>
                    </c:if>
                </c:forEach>
            </td>
        </tr>
    </table>

    <table class="admin-table" id="pauseGame">
        <tr>
            <td>
                <c:choose>
                    <c:when test="${paused}">
                        <b>The codenjoy was suspended</b></br> <a href="${ctx}/admin31415?resume&gameName=${gameName}">Resume game</a>.
                    </c:when>
                    <c:otherwise>
                        <b>The codenjoy is active</b></br> <a href="${ctx}/admin31415?pause&gameName=${gameName}">Pause game</a>.
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>

     <table class="admin-table" id="recordGame">
            <tr>
                <td>
                    <c:choose>
                        <c:when test="${recording}">
                            <b>The recording is active</b></br> <a href="${ctx}/admin31415?stopRecording&gameName=${gameName}">Stop recording</a>.
                        </c:when>
                        <c:otherwise>
                            <b>The recording was suspended</b></br> <a href="${ctx}/admin31415?recording&gameName=${gameName}">Start recording</a>.
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>

    <table class="admin-table" id="closeRegistration">
        <tr>
            <td>
                <c:choose>
                    <c:when test="${opened}">
                        <b>The registration is active</b></br> <a href="${ctx}/admin31415?close&gameName=${gameName}">Close registration</a>.
                    </c:when>
                    <c:otherwise>
                        <b>The registration was closed</b></br> <a href="${ctx}/admin31415?open&gameName=${gameName}">Open registration</a>.
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>

    <table class="admin-table" id="cleanGame">
        <tr>
            <td>
                <a href="${ctx}/admin31415?cleanAll&gameName=${gameName}">Clean all scores</a>.
            </td>
        </tr>
    </table>

    <form:form commandName="adminSettings" action="admin31415" method="POST">
        <table class="admin-table" id="createNewUsers">
            <tr>
                <td>NameMask</td>
                <td>Count</td>
            <tr>
                <td><input type="text" name="generateNameMask" value="${generateNameMask}"/></td>
                <td><input type="text" name="generateCount" value="${generateCount}"/></td>
            </tr>
            <tr>
                <td>
                    <input type="hidden" name="gameName" value="${gameName}"/>
                    <input type="submit" value="Create"/>
                </td>
            </tr>
        </table>
    </form:form>

    <c:if test="${parameters.size() != 0}">
        <form:form commandName="adminSettings" action="admin31415" method="POST">
            <table class="admin-table" id="gameSettings">
                <tr colspan="2">
                    <td><b>Game settings</b></td>
                </tr>
                <c:forEach items="${parameters}" var="parameter" varStatus="status">
                    <tr>
                        <td>${parameter.name}</td>
                        <td><form:input path="parameters[${status.index}]"/></td>
                    </tr>
                </c:forEach>
                <tr>
                    <td>
                        <input type="hidden" name="gameName" value="${gameName}"/>
                        <input type="submit" value="Save"/>
                    </td>
                </tr>
            </table>
        </form:form>
    </c:if>

    <c:if test="${players != null || savedGames != null}">
        <form:form commandName="adminSettings" action="admin31415" method="POST">
            <table class="admin-table" id="savePlayersGame">
                <tr colspan="4">
                    <td><b>Registered Players</b></td>
                </tr>
                <tr>
                    <td class="header">Player name</td>
                    <td class="header">IP</td>
                    <td class="header">Game name</td>
                    <td>
                        <a href="${ctx}/admin31415?saveAll&gameName=${gameName}">SaveAll&nbsp;&nbsp;</a>
                    </td>
                    <td>
                        <a href="${ctx}/admin31415?loadAll&gameName=${gameName}">LoadAll&nbsp;&nbsp;</a>
                    </td>
                    <td>
                        <a href="${ctx}/admin31415?removeSaveAll&gameName=${gameName}">RemoveSaveAll&nbsp;&nbsp;</a>
                    </td>
                    <td>
                        <a href="${ctx}/admin31415?gameOverAll&gameName=${gameName}">GameOverAll&nbsp;&nbsp;</a>
                    </td>
                </tr>
                <c:forEach items="${players}" var="player" varStatus="status">
                    <c:choose>
                        <c:when test="${player.active}">
                            <tr>
                                <td><form:input path="players[${status.index}].name"/></td>
                                <td><form:input path="players[${status.index}].callbackUrl"/></td>
                                <td><a href="${ctx}/board?gameName=${player.gameName}">${player.gameName}</a></td>
                                <td><a href="${ctx}/admin31415?save=${player.name}&gameName=${gameName}">Save</a></td>
                                <c:choose>
                                    <c:when test="${player.saved}">
                                        <td><a href="${ctx}/admin31415?load=${player.name}&gameName=${gameName}">Load</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>Load</td>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${player.saved}">
                                        <td><a href="${ctx}/admin31415?removeSave=${player.name}&gameName=${gameName}">RemoveSave</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>RemoveSave</td>
                                    </c:otherwise>
                                </c:choose>
                                <td><a href="${ctx}/admin31415?gameOver=${player.name}&gameName=${gameName}">GameOver</a></td>
                                <td><a href="${ctx}/board/${player.name}?code=${player.code}">ViewGame</a></td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td><input class="uneditable-input" value="${player.name}"/></td>
                                <td><input class="uneditable-input" value="${player.callbackUrl}"/></td>
                                <td><a href="${ctx}/board?gameName=${player.gameName}">${player.gameName}</a></td>
                                <td>Save</td>
                                <c:choose>
                                    <c:when test="${player.saved}">
                                        <td><a href="${ctx}/admin31415?load=${player.name}&gameName=${gameName}">Load</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>Load</td>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${player.saved}">
                                        <td><a href="${ctx}/admin31415?removeSave=${player.name}&gameName=${gameName}">RemoveSave</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>RemoveSave</td>
                                    </c:otherwise>
                                </c:choose>
                                <td>GameOver</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <tr>
                    <td>
                        <input type="hidden" name="gameName" value="${gameName}"/>
                        <input type="submit" value="Save"/>
                    </td>
                </tr>
            </table>
        </form:form>
    </c:if>

    </br>
    Go to <a href="${ctx}/">main page</a>.
</body>
</html>