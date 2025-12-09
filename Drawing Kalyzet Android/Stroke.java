package com.muhammadhaikal.drawingkalyzet;

import android.graphics.Path;
import android.graphics.PointF;
import java.util.ArrayList;
import java.util.List;

public class Stroke {
    public Path path;               
    public int color;             
    public float strokeWidth;       
    public List<PointF> points;     

    public Stroke(Path p, int c, float w) {
        path = new Path(p);      
        color = c;
        strokeWidth = w;
        points = new ArrayList<>();
    }

    public void addPoint(float x, float y) {
        points.add(new PointF(x, y));
        if (points.size() == 1) {
            path.moveTo(x, y);
        } else {
            path.lineTo(x, y);
        }
    }
}