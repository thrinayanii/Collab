// Function for Tracking Package
function trackPackage(event) {
    if (event) event.preventDefault();
    const trackingNumber = document.getElementById('tracking_number').value;
    const resultDiv = document.getElementById('trackingResult');

    resultDiv.innerHTML = `<p class="text-muted">Searching...</p>`;

    fetch(`api_tracking.php?tracking_number=${trackingNumber}`)
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                resultDiv.innerHTML = `<p class="error-msg">⚠ ${data.error}</p>`;
            } else {
                let historyHTML = '';
                if (data.history.length === 0) {
                    historyHTML = `<p class="text-muted" style="font-size:0.9rem;">No tracking history yet.</p>`;
                } else {
                    historyHTML = `<ul class="timeline">`;
                    data.history.forEach(record => {
                        historyHTML += `
                            <li>
                                <div class="timeline-dot"></div>
                                <div>
                                    <div class="timeline-time">${record.time}</div>
                                    <div class="timeline-update">${record.update}</div>
                                    <div class="timeline-location">📍 ${record.location}</div>
                                </div>
                            </li>`;
                    });
                    historyHTML += `</ul>`;
                }

                resultDiv.innerHTML = `
                    <hr>
                    <p class="mb-1" style="color:#555; font-size:0.85rem;">CURRENT STATUS</p>
                    <span class="status-badge">${data.status}</span>
                    <p class="mb-2" style="color:#555; font-size:0.85rem;">TRACKING HISTORY</p>
                    ${historyHTML}
                `;
            }
        })
        .catch(err => {
            resultDiv.innerHTML = `<p class="error-msg">⚠ Could not connect to server. Please try again.</p>`;
            console.error('Error:', err);
        });
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
                // Show styled success box with courier ID instead of an alert
                const successBox = document.getElementById('successBox');
                const courierIdDisplay = document.getElementById('courierIdDisplay');
                courierIdDisplay.textContent = `#${data.courier_id}`;
                successBox.style.display = 'block';
                successBox.scrollIntoView({ behavior: 'smooth' });
                this.reset();
            } else {
                alert('Booking failed: ' + data.message);
            }
        })
        .catch(err => {
            alert('Could not connect to server. Please try again.');
            console.error('Error:', err);
        });
    });
}
