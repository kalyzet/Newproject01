package com.muhammadhaikal.drawingkalyzet;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Path;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.graphics.Bitmap;
import android.graphics.PointF;

import java.util.ArrayList;
import java.util.List;

public class DrawingView extends View {

    private Paint currentPaint;
    private Stroke currentStroke;

    private List<Stroke> strokes = new ArrayList<>();
    private List<Stroke> undoneStrokes = new ArrayList<>();

    public DrawingView(Context context) {
        super(context);
        init();
    }

    public DrawingView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public DrawingView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    private void init() {
        currentPaint = createPaint();
    }

    private Paint createPaint() {
        Paint p = new Paint();
        p.setColor(0xFF000000); // hitam
        p.setStrokeWidth(8f);
        p.setStyle(Paint.Style.STROKE);
        p.setStrokeCap(Paint.Cap.ROUND);
        p.setStrokeJoin(Paint.Join.ROUND);
        p.setAntiAlias(true);
        return p;
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        // Gambar semua stroke
        for (Stroke s : strokes) {
            canvas.drawPath(s.path, createPaintFromStroke(s));
        }

        // Gambar stroke yang sedang digambar
        if (currentStroke != null) {
            canvas.drawPath(currentStroke.path, createPaintFromStroke(currentStroke));
        }
    }

    private Paint createPaintFromStroke(Stroke s) {
        Paint p = new Paint();
        p.setColor(s.color);
        p.setStrokeWidth(s.strokeWidth);
        p.setStyle(Paint.Style.STROKE);
        p.setStrokeCap(Paint.Cap.ROUND);
        p.setStrokeJoin(Paint.Join.ROUND);
        p.setAntiAlias(true);
        return p;
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        float x = event.getX();
        float y = event.getY();

        switch (event.getAction()) {
            case MotionEvent.ACTION_DOWN:
                currentPaint = createPaint();
                currentStroke = new Stroke(new Path(), currentPaint.getColor(), currentPaint.getStrokeWidth());
                currentStroke.addPoint(x, y);
                undoneStrokes.clear();
                break;

            case MotionEvent.ACTION_MOVE:
                if (currentStroke != null) currentStroke.addPoint(x, y);
                break;

            case MotionEvent.ACTION_UP:
                if (currentStroke != null) {
                    strokes.add(currentStroke);
                    currentStroke = null;
                }
                break;
        }

        invalidate();
        return true;
    }

    // Undo
    public void undo() {
        if (!strokes.isEmpty()) {
            undoneStrokes.add(strokes.remove(strokes.size() - 1));
            invalidate();
        }
    }

    // Redo
    public void redo() {
        if (!undoneStrokes.isEmpty()) {
            strokes.add(undoneStrokes.remove(undoneStrokes.size() - 1));
            invalidate();
        }
    }

    // Clear canvas
    public void clearCanvas() {
        strokes.clear();
        undoneStrokes.clear();
        invalidate();
    }

    public Bitmap getBitmap() {
        Bitmap bitmap = Bitmap.createBitmap(getWidth(), getHeight(), Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        draw(canvas);
        return bitmap;
    }

    public List<Stroke> getStrokes() {
        return strokes;
    }
}
