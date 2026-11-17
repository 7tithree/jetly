<?php
// Assuming you have set up a database connection and required variables

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $old_password = $_POST['old_password'];
    $new_password = $_POST['new_password'];

    // Example: Check if the old password is correct
    $conn = new mysqli('localhost', 'your_db_user', 'your_db_password', 'your_db_name');

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $sql = "SELECT * FROM users WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();

        // Verify old password (you should use hashing for real-world applications)
        if ($user['password'] == $old_password) {
            // Update password if old password is correct
            $new_password_hashed = password_hash($new_password, PASSWORD_DEFAULT);  // Hash new password

            $update_sql = "UPDATE users SET password = ? WHERE email = ?";
            $update_stmt = $conn->prepare($update_sql);
            $update_stmt->bind_param("ss", $new_password_hashed, $email);
            $update_stmt->execute();

            if ($update_stmt->affected_rows > 0) {
                echo 'success';  // Return success response
            } else {
                echo 'failed';   // If password update failed
            }
        } else {
            echo 'invalid_old_password';  // If old password is incorrect
        }
    } else {
        echo 'user_not_found';  // If user with the provided email is not found
    }

    $conn->close();
}
?>
