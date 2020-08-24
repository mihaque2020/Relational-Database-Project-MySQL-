-- Managing the Hotel Data
-- Import data using the Wizard and manual for small entity tables

USE hotel;
SELECT * FROM RoomType;
INSERT INTO RoomType (RoomTypeName) VALUES 
	("Single"),
    ("Double"),
    ("Suite");
    
INSERT INTO Amenity (AmenityName) VALUES
	("Microwave"),
    ("Refrigerator"),
    ("Jacuzzi"),
    ("Oven");
SELECT * FROM Amenity;

-- Import Wizard
SELECT * FROM Guest;
INSERT INTO Guest (`Name`, Address, City, State, Zip, Phone) VALUES (
	"Minul Haque",
    "123 Made Up Rd.",
    "Secret Town",
    "NY",
    "98538",
    "(432) 941-2334"
);
	
-- Import Wizard
SELECT * FROM Room;

-- Import Wizard
SELECT * FROM RoomAmenities;

-- Import Wizard
SELECT * FROM Reservation;

-- Import Wizard
SELECT * FROM RoomReservation;

-- Deleting Jeremiah Pendergrass 
DELETE FROM RoomReservation
WHERE RoomReservation.Reservation_ReservationId = 8;

DELETE FROM Reservation
WHERE Reservation.Guest_GuestId = 7;

DELETE FROM Guest
WHERE Guest.GuestId = 7;