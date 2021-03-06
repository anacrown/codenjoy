package com.codenjoy.dojo.services;

/*-
 * #%L
 * Codenjoy - it's a dojo-like platform from developers to developers.
 * %%
 * Copyright (C) 2018 Codenjoy
 * %%
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public
 * License along with this program.  If not, see
 * <http://www.gnu.org/licenses/gpl-3.0.html>.
 * #L%
 */


import com.codenjoy.dojo.services.hero.HeroData;
import org.json.JSONObject;

import java.util.List;
import java.util.Map;

public class GameData {

    private final int boardSize;
    private final GuiPlotColorDecoder decoder;
    private final Map<String, Object> scores;
    private final List<String> group;
    private final Map<String, HeroData> coordinates;
    private Map<String, String> readableNames;


    public GameData(int boardSize, GuiPlotColorDecoder decoder,
                    Map<String, Object> scores, List<String> group,
                    Map<String, HeroData> coordinates,
                    Map<String, String> readableNames)
    {
        this.boardSize = boardSize;
        this.decoder = decoder;
        this.scores = scores;
        this.group = group;
        this.coordinates = coordinates;
        this.readableNames = readableNames;
    }

    public GuiPlotColorDecoder getDecoder() {
        return decoder;
    }

    public int getBoardSize() {
        return boardSize;
    }

    public JSONObject getScores() {
        return new JSONObject(scores);
    }

    public JSONObject getHeroesData() {
        JSONObject result = new JSONObject();
        result.put("coordinates", coordinates);
        result.put("group", group);
        result.put("readableNames", readableNames);
        return result;
    }
}
