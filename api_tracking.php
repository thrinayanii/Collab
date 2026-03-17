<?php
header('Content-Type: application/json');
$conn = new mysqli("localhost", "root", "", "CourierTrackingSystem");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $customer_name = $_POST['customer_name'];
    $weight = $_POST['weight'];
    $package_type = $_POST['package_type'];
    $destination = $_POST['destination'];
    $receiver_name = $_POST['receiver_name'];

    // Look up customer_id and address by name
    $stmt_customer = $conn->prepare("SELECT customer_id, customer_address FROM customer WHERE customer_name = ?");
    if (!$stmt_customer) {
        echo json_encode(["success" => false, "message" => "Prepare failed: " . $conn->error]);
        exit;
    }
    $stmt_customer->bind_param("s", $customer_name);
    $stmt_customer->execute();
    $result = $stmt_customer->get_result();
    if ($result->num_rows == 0) {
        echo json_encode(["success" => false, "message" => "Customer not found. Please check your name."]);
        exit;
    }
    $customer = $result->fetch_assoc();
    $customer_id = $customer['customer_id'];
    $pickup_address = $customer['customer_address'];

    $stmt = $conn->prepare("INSERT INTO courier_shipment (customer_id, dispatch_branch_id, delivery_branch_id, weight, package_type, pickup_address, destination_address, status) VALUES (?, 1, 1, ?, ?, ?, ?, 'Booked')");
    $stmt->bind_param("issss", $customer_id, $weight, $package_type, $pickup_address, $destination);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "courier_id" => $stmt->insert_id]);
    } else {
        echo json_encode(["success" => false, "message" => $conn->error]);
    }
}
?>
