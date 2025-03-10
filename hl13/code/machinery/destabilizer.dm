/obj/machinery/destabilizer
	name = "destabilizer"
	desc = "A hacked piece of combine machinery which emits radio signals that disrupt district wide systems and machinery, reducing sociostability over time."
	icon = 'hl13/icons/obj/machines/machinery.dmi'
	icon_state = "destabilizer"
	var/destabilization_rate = -1
	var/destabilization_chance = 100

/obj/machinery/destabilizer/process(delta_time)
	if(prob(destabilization_chance))
		SSsociostability.modifystability(destabilization_rate) //Slowly wittles down stability

/obj/machinery/destabilizer/examine(mob/user)
	. = ..()
	. += span_notice("It's currently disrupting district sociostability. You can destroy it to halt this.")

/obj/machinery/destabilizer/deconstruct(disassembled = TRUE)
	SSsociostability.modifystability(10) //Good for stability to break it.
	if(!(obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION))
		new /obj/item/circuitmaterial(loc)
		new /obj/item/halflife/antenna(loc)
	qdel(src)

/obj/machinery/destabilizer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "Disruptive Signal")

/obj/machinery/destabilizer/makeshift
	name = "makeshift destabilizer"
	desc = "A shoddily made piece of machinery made from spare combine machinery parts. Emits radio signals that disrupt district wide systems and machinery, reducing sociostability over time."
	destabilization_chance = 50

/obj/machinery/destabilizer/makeshift/Initialize(mapload)
	. = ..()
	priority_announce("Warning. Disruptive sociostability threat detected in your district. Local protection team units, contain immediately. A GPS signal has been assigned to the threat.", "Overwatch Alert")
