<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "jetly_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
if (isset($_POST['action']) && $_POST['action'] === 'get_history') {
    $email = $_POST['email'];

    $sql = "SELECT jet_name, booking_date, passenger_count, flight_time, departure_location, destination_location 
            FROM bookings 
            WHERE user_id = (SELECT id FROM users WHERE email = '$email')";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $bookings = [];
        while ($row = $result->fetch_assoc()) {
            $bookings[] = $row;
        }
        echo json_encode(['bookings' => $bookings]);
    } else {
        echo json_encode(['bookings' => []]);
    }
} else {
    $user_id = $_POST['user_id'];
    $jet_id = $_POST['jet_id'];
    $booking_date = $_POST['booking_date'];
    $passenger_count = $_POST['passenger_count'];
    $flight_time = $_POST['flight_time'];
    $departure_location = $_POST['departure_location'];
    $destination_location = $_POST['destination_location'];

    $sql = "INSERT INTO bookings (user_id, jet_id, booking_date, passenger_count, flight_time, departure_location, destination_location) 
            VALUES ('$user_id', '$jet_id', '$booking_date', '$passenger_count', '$flight_time', '$departure_location', '$destination_location')";

    if ($conn->query($sql) === TRUE) {
        echo "Booking successful";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

$conn->close();
?>
