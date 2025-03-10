/datum/keybinding/living/fixeye
	hotkey_keys = list("ShiftF")
	name = "fixeye"
	full_name = "Fix Eye"
	description = "Fix the direction you're staring at."
	keybind_signal = COMSIG_KB_FIXEYE_DOWN

/datum/keybinding/living/fixeye/down(client/user)
	. = ..()
	var/mob/living/living_user = user.mob
	if(istype(living_user))
		SEND_SIGNAL(living_user, COMSIG_FIXEYE_TOGGLE)
	return TRUE
