/obj/item/ammo_box/magazine/usp9mm
	name = "pistol magazine (9mm)"
	desc = "A 18-round 9mm magazine designed for the USP Match pistol."
	icon_state = "9x19p-10"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 18

/obj/item/ammo_box/magazine/usp9mm/update_icon_state()
	. = ..()
	icon_state = "9x19p-[ammo_count() ? "10" : "0"]"

/obj/item/ammo_box/magazine/ar2
	name = "OSIPR magazine (pulse)"
	desc = "A 30-round magazine for the OSIPR that contains pulse rounds."
	icon_state = "ar2"
	ammo_type = /obj/item/ammo_casing/caseless/pulse/ar2
	caliber = CALIBER_PULSROUND
	max_ammo = 30

/obj/item/ammo_box/magazine/combine_sniper
	name = "Sniper magazine (pulse)"
	desc = "A 10-round magazine for the combine sniper rifle that contains pulse rounds."
	icon_state = "ar2"
	ammo_type = /obj/item/ammo_casing/caseless/pulse/combine_sniper
	caliber = CALIBER_PULSROUND
	max_ammo = 10

/obj/item/ammo_box/magazine/mp7
	name = "\improper MP7 magazine (4.6x30mm)"
	desc = "A 45-round 4.6x30mm magazine, designed for the MP7."
	icon_state = "smg9mm-42"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = CALIBER_46X30MM
	max_ammo = 45
