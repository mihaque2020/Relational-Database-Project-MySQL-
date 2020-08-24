-- Hotel Data Base Queries
USE Hotel;

-- 1. list of reservations that end in July 2023, name of the guest, the room number(s), and the reservation dates.
SELECT 
	Guest.`Name`,
    RoomReservation.Room_RoomId,
    Reservation.StartDate,
    Reservation.EndDate
FROM Reservation
INNER JOIN Guest ON Reservation.Guest_GuestId = Guest.GuestId
INNER JOIN RoomReservation ON Reservation.ReservationId = RoomReservation.Reservation_ReservationId 
WHERE EndDate BETWEEN '2023-07-01' AND '2023-07-31';

/*
Minul Haque		205	2023-06-28	2023-07-02
Walter Holaway	204	2023-07-13	2023-07-14
Wilfred Vise	401	2023-07-18	2023-07-21
Bettyann Seery	303	2023-07-28	2023-07-29
*/
-- 2. list of all reservations for rooms with a jacuzzi, displaying the guest's name, the room number, and the dates of the reservation.
SELECT 
	Guest.`Name`,
    RoomReservation.Room_RoomId,
    Reservation.StartDate,
    Reservation.EndDate
FROM Reservation
INNER JOIN Guest ON Reservation.Guest_GuestId = Guest.GuestId
INNER JOIN RoomReservation ON Reservation.ReservationId = RoomReservation.Reservation_ReservationId 
INNER JOIN Room ON RoomReservation.Room_RoomId = Room.RoomId
INNER JOIN RoomAmenities ON Room.RoomId = RoomAmenities.Room_RoomId
WHERE RoomAmenities.Amenity_AmenityId = 3;

/*
Karie Yang		201	2023-03-06	2023-03-07
Bettyann Seery	203	2023-02-05	2023-02-10
Karie Yang		203	2023-09-13	2023-09-15
Minul Haque		205	2023-06-28	2023-07-02
Wilfred Vise	207	2023-04-23	2023-04-24
Walter Holaway	301	2023-04-09	2023-04-13
Mack Simmer		301	2023-11-22	2023-11-25
Bettyann Seery	303	2023-07-28	2023-07-29
Duane Cullison	305	2023-02-22	2023-02-24
Bettyann Seery	305	2023-08-30	2023-09-01
Minul Haque		307	2023-03-17	2023-03-20
*/

-- 3. list of all the rooms reserved for a specific guest, guest's name, the room(s) reserved, the starting date of the reservation, how many people in the reservation.
-- hoose a guest's name from the existing data
SELECT
	Guest.`Name`,
	Room.RoomId,
    Reservation.StartDate,
    (Reservation.NumAdults + Reservation.NumChildren) AS TotalPeople
From Room    
INNER JOIN RoomReservation ON Room.RoomId = RoomReservation.Room_RoomId
INNER JOIN Reservation ON RoomReservation.Reservation_ReservationId = Reservation.ReservationId
INNER JOIN Guest ON Reservation.Guest_GuestId = Guest.GuestId    
WHERE Guest.`Name` = "Minul Haque";

/*
Minul Haque	307	2023-03-17	2
Minul Haque	205	2023-06-28	2
*/

-- 4. list of rooms, reservation ID, and per-room cost for each reservation
-- include all rooms, whether or not there is a reservation associated with the room.
SELECT 
	Room.RoomId,
    RoomReservation.Reservation_ReservationID,
   -- Reservation.TotalCost
   Room.BasePrice
FROM Room
-- INNER JOIN RoomReservation ON Room.RoomId = RoomReservation.Room_RoomId

LEFT OUTER JOIN RoomReservation
	ON Room.RoomId = RoomReservation.Room_RoomId;

/*
205	14	699.96
206	12	1199.92
206	22	1049.94
207	10	174.99
208	12	1199.92
208	19	149.99
305	3	349.98
305	18	349.98
307	5	524.97
308	1	299.98
201	4	199.99
202	7	349.98
203	2	999.95
203	20	399.98
204	15	184.99
301	9	799.96
301	22	1049.94
302	6	924.95
302	23	699.96
303	17	199.99
304	13	184.99
401	11	1199.97
401	16	1259.97
401	21	1199.97
*/

-- 5.  all rooms with a capacity of three or more and that are reserved on any date in April 2023.
SELECT 
	Room.RoomId
FROM Room
INNER JOIN RoomReservation ON Room.RoomId = RoomReservation.Room_RoomId
INNER JOIN Reservation ON RoomReservation.Reservation_ReservationId = Reservation.ReservationId
WHERE Room.MaxOccupancy >= 3 AND Reservation.StartDate BETWEEN '2023-04-01' AND '2023-04-30';

/* 301	
*/

-- 6.  list of all guest names and the number of reservations per guest
-- sorted starting with the guest with the most reservations, then by the guest's name.
SELECT
	Guest.`Name`,
    COUNT(Reservation.Guest_GuestId) AS ReservationCount
    
FROM Reservation
INNER JOIN Guest ON Reservation.Guest_GuestId = GuestId
GROUP BY `Name`
ORDER BY 2 DESC, 1 ASC;
/*
Bettyann Seery	3
Mack Simmer		3
Aurore Lipton	2
Duane Cullison	2
Karie Yang		2
Maritza Tilton	2
Minul Haque		2
Walter Holaway	2
Wilfred Vise	2
Joleen Tison	1
Zachery Luechtefeld	1
*/

-- 7. name, address, and phone number of a guest based on their phone number. (Choose any phone number)
SELECT
	Guest.`Name`,
    Guest.Address,
    Guest.Phone
FROM Guest
WHERE Guest.Phone = "(432) 941-2334";

/* 
Minul Haque	123 Made Up Rd.	(432) 941-2334
*/