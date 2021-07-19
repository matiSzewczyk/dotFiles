package com.example.todoapp;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity implements View.OnClickListener, TextView.OnEditorActionListener {

    ListView taskListView;
    ArrayList<String> todoList = new ArrayList<>();
    ArrayAdapter<String> taskAdapter;
    EditText taskInput;
    Button addButton;
    String task;
    InputMethodManager imm;

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.addButton:
                addButton.setVisibility(View.GONE);
                taskInput.setVisibility(View.VISIBLE);
                taskInput.requestFocus();
                // So i have no clue what this does
                // TODO: learn exactly how this works
                imm.showSoftInput(taskInput, InputMethodManager.SHOW_IMPLICIT);
                break;
        }
    }

    @Override
    public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
        if (actionId == EditorInfo.IME_ACTION_DONE) {
            String task = taskInput.getText().toString();
            todoList.add(task);
            taskAdapter.notifyDataSetChanged();
            taskInput.getText().clear();
            addButton.setVisibility(View.VISIBLE);
            taskInput.setVisibility(View.GONE);
        }
        return false;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        // Init the TextView.
        taskInput = (EditText) findViewById(R.id.taskInput);
        taskInput.setVisibility(View.GONE);
        taskInput.setOnEditorActionListener(this);

        // Init ListView.
        taskListView = (ListView) findViewById(R.id.todoList);

        taskAdapter = new ArrayAdapter<>(
                this,
                android.R.layout.simple_list_item_1,
                todoList
        );
        taskListView.setAdapter(taskAdapter);

        // Init Button.
        addButton = (Button) findViewById(R.id.addButton);
        addButton.setVisibility(View.VISIBLE);
        addButton.setOnClickListener(this);
    }
}
/*
                String task = taskInput.getText().toString();
                todoList.add(task);
                taskAdapter.notifyDataSetChanged();
                taskInput.getText().clear();

 */
