// Function for Tracking Package
function trackPackage(event) {
    if (event) event.preventDefault(); // Prevent form from refreshing page
    const trackingNumber = document.getElementById('tracking_number').value;
    const resultDiv = document.getElementById('trackingResult');

    fetch(`api_tracking.php?tracking_number=${trackingNumber}`)
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                resultDiv.innerHTML = `<p style="color:red;">${data.error}</p>`;
            } else {
                let html = `<h3>Current Status: ${data.status}</h3><ul>`;
                data.history.forEach(record => {
                    html += `<li><strong>${record.time}:</strong> ${record.update} at ${record.location}</li>`;
                });
                html += `</ul>`;
                resultDiv.innerHTML = html;
            }
        })
        .catch(err => console.error('Error:', err));
}

// Function for Booking Shipment
const bookingForm = document.getElementById('bookingForm');
if (bookingForm) {
    bookingForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const formData = new FormData(this);

        fetch('api_booking.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(`Shipment Booked! Your Courier ID is: ${data.courier_id}`);
                this.reset();
            } else {
                alert('Booking failed: ' + data.message);
            }
        });
    });
}