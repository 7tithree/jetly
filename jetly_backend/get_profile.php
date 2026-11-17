<?php
// get_profile.php
header('Content-Type: application/json');
include('db_connection.php');

$email = $_POST['email'];

// Fetch user details from database
$query = "SELECT * FROM users WHERE email = '$email'";
$result = mysqli_query($conn, $query);

if ($result) {
    $user = mysqli_fetch_assoc($result);
    echo json_encode($user);
} else {
    echo json_encode(['error' => 'User not found']);
}
?>
