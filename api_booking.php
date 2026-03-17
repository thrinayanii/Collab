<?php
header('Content-Type: application/json');
$conn = new mysqli("localhost", "root", "", "CourierTrackingSystem");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $customer_id = $_POST['customer_id'];
    $weight = $_POST['weight'];
    $package_type = $_POST['package_type'];
    $destination = $_POST['destination'];

    // Fetch customer's address for pickup
    $stmt_customer = $conn->prepare("SELECT customer_address FROM customer WHERE customer_id = ?");
    if (!$stmt_customer) {
        echo json_encode(["success" => false, "message" => "Prepare failed: " . $conn->error]);
        exit;
    }
    $stmt_customer->bind_param("i", $customer_id);
    $stmt_customer->execute();
    $result = $stmt_customer->get_result();
    if ($result->num_rows == 0) {
        echo json_encode(["success" => false, "message" => "Customer not found"]);
        exit;
    }
    $customer = $result->fetch_assoc();
    $pickup_address = $customer['customer_address'];

    $stmt = $conn->prepare("INSERT INTO courier_shipment (customer_id, dispatch_branch_id, delivery_branch_id, weight, package_type, pickup_address, destination_address, status) VALUES (?, 1, 1, ?, ?, ?, ?, 'Booked')");
    $stmt->bind_param("idsss", $customer_id, $weight, $package_type, $pickup_address, $destination);

    if ($stmt->execute()) {
        header('Location: index.html');
        exit;
    } else {
        echo json_encode(["success" => false, "message" => $conn->error]);
    }
}
?>