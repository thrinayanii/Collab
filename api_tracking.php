<?php
header('Content-Type: application/json');
$conn = new mysqli("localhost", "root", "", "CourierTrackingSystem");

if (isset($_GET['tracking_number'])) {
    $tracking_id = $_GET['tracking_number'];

    $shipment_res = $conn->query("SELECT status FROM Courier_Shipment WHERE courier_id = $tracking_id");
    $shipment = $shipment_res->fetch_assoc();

    if (!$shipment) {
        echo json_encode(["error" => "No shipment found with this ID."]);
        exit;
    }

    $history_res = $conn->query("SELECT updated_timestamp as time, status_update as `update`, location FROM Tracking_Record WHERE courier_id = $tracking_id ORDER BY updated_timestamp DESC");
    
    $history = [];
    while ($row = $history_res->fetch_assoc()) {
        $history[] = $row;
    }

    echo json_encode([
        "status" => $shipment['status'],
        "history" => $history
    ]);
}
?>
