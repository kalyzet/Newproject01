package com.muhammadhaikal.drawingkalyzet;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Bitmap;
import android.net.Uri;
import android.provider.MediaStore;
import android.content.ContentValues;
import android.widget.Toast;
import android.content.pm.PackageManager;
import android.os.Environment;
import android.graphics.Path;
import android.graphics.PathMeasure;
import com.muhammadhaikal.drawingkalyzet.Stroke;
import android.graphics.PointF;
import java.util.List;


import java.io.OutputStream;

public class MainActivity extends AppCompatActivity {

    private DrawingView drawingView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        drawingView = findViewById(R.id.drawingView);

        Button undoBtn = findViewById(R.id.undoBtn);
        Button redoBtn = findViewById(R.id.redoBtn);
        Button saveBtn = findViewById(R.id.saveBtn);



        undoBtn.setOnClickListener(v -> drawingView.undo());
        redoBtn.setOnClickListener(v -> drawingView.redo());
        saveBtn.setOnClickListener(v -> showSaveFormatDialog());
        if (android.os.Build.VERSION.SDK_INT <= 28) {
            if (checkSelfPermission(android.Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    != PackageManager.PERMISSION_GRANTED) {

                requestPermissions(new String[]{
                        android.Manifest.permission.WRITE_EXTERNAL_STORAGE,
                        android.Manifest.permission.READ_EXTERNAL_STORAGE
                }, 100);
            }
        }

    }

//    private void saveDrawing() {
//        try {
//            Bitmap bitmap = drawingView.getBitmap();
//            if (bitmap == null) {
//                Toast.makeText(this, "Bitmap null", Toast.LENGTH_SHORT).show();
//                return;
//            }
//
//            ContentValues values = new ContentValues();
//            values.put(MediaStore.Images.Media.DISPLAY_NAME, "drawing_" + System.currentTimeMillis() + ".png");
//            values.put(MediaStore.Images.Media.MIME_TYPE, "image/png");
//            values.put(MediaStore.Images.Media.RELATIVE_PATH,
//                    Environment.DIRECTORY_PICTURES + "/DrawingKalyzet");
//            values.put(MediaStore.Images.Media.IS_PENDING, 1);
//
//            Uri uri = getContentResolver().insert(
//                    MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
//                    values
//            );
//
//            if (uri == null) {
//                Toast.makeText(this, "URI NULL (Insert gagal)", Toast.LENGTH_LONG).show();
//                return;
//            }
//
//            OutputStream outputStream = getContentResolver().openOutputStream(uri);
//            bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
//            outputStream.close();
//
//            values.clear();
//            values.put(MediaStore.Images.Media.IS_PENDING, 0);
//            getContentResolver().update(uri, values, null, null);
//
//            Toast.makeText(this, "Berhasil disimpan!", Toast.LENGTH_SHORT).show();
//
//        } catch (Exception e) {
//            Toast.makeText(this, "Error: " + e.getMessage(), Toast.LENGTH_LONG).show();
//        }
//        Uri test = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
//        Toast.makeText(this, "Media URI: " + test.toString(), Toast.LENGTH_LONG).show();
//
//    }
private void exportToSVG() {
    try {
        List<Stroke> strokes = drawingView.getStrokes();
        if (strokes.isEmpty()) {
            Toast.makeText(this, "Tidak ada coretan untuk disimpan!", Toast.LENGTH_SHORT).show();
            return;
        }

        float minX = Float.MAX_VALUE, minY = Float.MAX_VALUE;
        float maxX = Float.MIN_VALUE, maxY = Float.MIN_VALUE;

        for (Stroke s : strokes) {
            for (PointF p : s.points) {
                if (p.x < minX) minX = p.x;
                if (p.y < minY) minY = p.y;
                if (p.x > maxX) maxX = p.x;
                if (p.y > maxY) maxY = p.y;
            }
        }

        float width = maxX - minX;
        float height = maxY - minY;

        StringBuilder svg = new StringBuilder();
        svg.append("<svg xmlns=\"http://www.w3.org/2000/svg\" ")
                .append("width=\"").append(width).append("\" ")
                .append("height=\"").append(height).append("\" ")
                .append("viewBox=\"").append(minX).append(" ").append(minY)
                .append(" ").append(width).append(" ").append(height).append("\">\n");

        for (Stroke s : strokes) {
            if (s.points.isEmpty()) continue;

            StringBuilder pathData = new StringBuilder();
            for (int i = 0; i < s.points.size(); i++) {
                PointF pt = s.points.get(i);
                if (i == 0) {
                    pathData.append("M").append(pt.x).append(",").append(pt.y).append(" ");
                } else {
                    pathData.append("L").append(pt.x).append(",").append(pt.y).append(" ");
                }
            }

            svg.append("<path d=\"").append(pathData)
                    .append("\" stroke=\"").append(String.format("#%06X", (0xFFFFFF & s.color)))
                    .append("\" stroke-width=\"").append(s.strokeWidth)
                    .append("\" fill=\"none\" />\n");
        }

        svg.append("</svg>");

        ContentValues values = new ContentValues();
        values.put(MediaStore.MediaColumns.DISPLAY_NAME, "drawing_" + System.currentTimeMillis() + ".svg");
        values.put(MediaStore.MediaColumns.MIME_TYPE, "image/svg+xml");
        values.put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS + "/DrawingKalyzet");

        Uri uri = getContentResolver().insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values);
        if (uri == null) {
            Toast.makeText(this, "Gagal membuat file SVG", Toast.LENGTH_LONG).show();
            return;
        }

        OutputStream os = getContentResolver().openOutputStream(uri);
        os.write(svg.toString().getBytes("UTF-8"));
        os.close();

        Toast.makeText(this, "SVG berhasil disimpan di Downloads/DrawingKalyzet!", Toast.LENGTH_SHORT).show();

    } catch (Exception e) {
        Toast.makeText(this, "Error export SVG: " + e.getMessage(), Toast.LENGTH_LONG).show();
    }
}
    private void showSaveFormatDialog() {
        String[] options = {"PNG", "SVG"};

        new android.app.AlertDialog.Builder(this)
                .setTitle("Pilih format penyimpanan")
                .setItems(options, (dialog, which) -> {
                    if (which == 0) {
                        saveDrawingAsPNG();
                    } else if (which == 1) {
                        exportToSVG();
                    }
                })
                .show();
    }
    private void saveDrawingAsPNG() {
        try {
            Bitmap bitmap = drawingView.getBitmap();
            if (bitmap == null) {
                Toast.makeText(this, "Bitmap null", Toast.LENGTH_SHORT).show();
                return;
            }

            ContentValues values = new ContentValues();
            values.put(MediaStore.Images.Media.DISPLAY_NAME, "drawing_" + System.currentTimeMillis() + ".png");
            values.put(MediaStore.Images.Media.MIME_TYPE, "image/png");
            values.put(MediaStore.Images.Media.RELATIVE_PATH,
                    Environment.DIRECTORY_PICTURES + "/DrawingKalyzet");
            values.put(MediaStore.Images.Media.IS_PENDING, 1);

            Uri uri = getContentResolver().insert(
                    MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                    values
            );

            if (uri == null) {
                Toast.makeText(this, "URI NULL (Insert gagal)", Toast.LENGTH_LONG).show();
                return;
            }

            OutputStream outputStream = getContentResolver().openOutputStream(uri);
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
            outputStream.close();

            values.clear();
            values.put(MediaStore.Images.Media.IS_PENDING, 0);
            getContentResolver().update(uri, values, null, null);

            Toast.makeText(this, "PNG tersimpan!", Toast.LENGTH_SHORT).show();

        } catch (Exception e) {
            Toast.makeText(this, "Error PNG: " + e.getMessage(), Toast.LENGTH_LONG).show();
        }
    }
}