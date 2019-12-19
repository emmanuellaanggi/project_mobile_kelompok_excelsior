package com.example.fira_app;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;

public class RegisterActivity extends AppCompatActivity implements View.OnClickListener {

    private static final String TAG = "EmailPassword";
    private EditText mEmailField;
    private EditText mPasswordField;

    private FirebaseAuth mAuth;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        mEmailField = findViewById(R.id.email_reg);
        mPasswordField = findViewById(R.id.password_reg);

        findViewById(R.id.login_now).setOnClickListener(this);
        findViewById(R.id.button_reg).setOnClickListener(this);

        mAuth = FirebaseAuth.getInstance();
    }

    private void createAccount(String email, String password) {
        Log.d(TAG, "createAccount:" + email);

        // [START create_user_with_email]
        mAuth.createUserWithEmailAndPassword(email, password)
                .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()) {
                            // Sign in success, update UI with the signed-in user's information
                            Log.d(TAG, "createUserWithEmail:success");
                            Intent z = new Intent(RegisterActivity.this, MainActivity.class);
                            startActivity(z);
                        } else {
                            // If sign in fails, display a message to the user.
                            Log.w(TAG, "createUserWithEmail:failure", task.getException());
                            Toast.makeText(RegisterActivity.this, "Authentication failed.",
                                    Toast.LENGTH_SHORT).show();
                        }
                    }
                });
        // [END create_user_with_email]
    }

    @Override
    public void onClick(View v) {
        int i = v.getId();
        if (i == R.id.button_reg) {
            createAccount(mEmailField.getText().toString(), mPasswordField.getText().toString());
        }
        else if (i == R.id.login_now) {
            Intent z = new Intent(RegisterActivity.this, LoginActivity.class);
            startActivity(z);
        }

    }
}
