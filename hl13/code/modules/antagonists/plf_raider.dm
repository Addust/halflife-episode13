/datum/outfit/plfraider_preview
	name = "Uprising Ringleader (Preview only)"

	uniform = /obj/item/clothing/under/citizen/rebel
	suit = /obj/item/clothing/suit/armor/rebel
	head = /obj/item/clothing/head/helmet/halflife/military
	shoes = /obj/item/clothing/shoes/boots
	gloves = /obj/item/clothing/gloves/combat

/datum/antagonist/plfraider
	name = "PLF Raider"
	roundend_category = "uprising ring leaders"
	antagpanel_category = "Uprising Ringleaders"
	antag_hud_name = "traitor"
	job_rank = ROLE_OPERATIVE
	antag_moodlet = /datum/mood_event/rebel
	preview_outfit = /datum/outfit/plfraider_preview
	show_in_antagpanel = TRUE
	/// Which uprising team are we on?
	var/datum/team/plfraider/plfraider_team
	send_to_base = TRUE
	loud = TRUE


	uprising_outfit = /datum/outfit/plf_raider


/datum/outfit/plf_raider
	uniform = /obj/item/clothing/under/syndicate/camo/halflife
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/beret

/datum/antagonist/plfraider/greet()
	owner.current.playsound_local(get_turf(owner.current), 'hl13/sound/ambience/combineadvisory.ogg',50,0)
	to_chat(owner, "<B>As the klaxons of the forward base roar to life and you stir out of bed, you remember your mission...</B>")
	to_chat(owner, span_userdanger("You are a Polish Liberation Front raider!"))
	to_chat(owner, span_boldnotice("The time has come for this district to be freed from the tyranny of the combine."))
	to_chat(owner, span_notice("You are a rapid-deployment trooper of the Polish Liberation Front, having successfully intercepted a Combine transmission."))
	to_chat(owner, span_boldnotice("You are armed to the teeth with the best equipment the Front has in the field. Do not squander it."))
	to_chat(owner, span_notice("All supplies necessary for your attack are kept in the base. A single specialist equipment beacon is available in the centre of the room."))
	to_chat(owner, span_notice("For more information, visit the wiki page for this antagonist: https://halflifeepisode13.miraheze.org/wiki/Uprising_Ringleader"))
	owner.announce_objectives()

/datum/antagonist/plfraider/on_removal()
	return ..()

/datum/antagonist/plfraider/on_gain()
	//Give uprising Objective
	var/datum/objective/plfraider/raider_objective = new
	raider_objective.owner = owner

	var/mob/living/current = owner.current

	objectives += raider_objective

	current.cmode_music = 'hl13/sound/music/combat/penultimatum.ogg'
	if(send_to_base)
		move_to_spawnpoint()

	equip_op()

	return ..()

/datum/antagonist/plfraider/proc/equip_op()
	if(!ishuman(owner.current))
		return

	var/mob/living/carbon/human/operative = owner.current
	ADD_TRAIT(operative, TRAIT_NOFEAR_HOLDUPS, INNATE_TRAIT)

	operative.set_species(/datum/species/human)

	operative.delete_equipment()

	operative.equip_species_outfit(plfraider_outfit)

	return TRUE

/// Actually moves our nukie to where they should be
/datum/antagonist/plfraider/proc/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.nukeop_start))
	if(!owner.current.onSyndieBase())
		message_admins("[ADMIN_LOOKUPFLW(owner.current)] is a NUKE OP and move_to_spawnpoint put them somewhere that isn't the syndie base, help please.")
		stack_trace("Nuke op move_to_spawnpoint resulted in a location not on the syndicate base.")

/// Gets the position we spawn at
/datum/antagonist/plfraider/proc/get_spawnpoint()
	var/team_number = 1
	if(plfraider_team)
		team_number = plfraider_team.members.Find(owner)

	return GLOB.nukeop_start[((team_number - 1) % GLOB.nukeop_start.len) + 1]


/datum/objective/plfraider
	explanation_text = "Assault local Combine territory and ensure as many civilians as possible are able to escape. Seize resources and destroy vital equipment."

/datum/antagonist/plfraider/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_team_hud(M, /datum/antagonist/plfraider)

/datum/antagonist/plfraider/create_team(datum/team/uprising/new_team)
	if(!new_team)
		//For now only one uprising at a time
		for(var/datum/antagonist/plfraider/H in GLOB.antagonists)
			if(!H.owner)
				continue
			if(H.plfraider_team)
				plfraider_team = H.plfraider_team
				return
		plfraider_team = new /datum/team/plfraider
		plfraider_team.update_objectives()
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	plfraider_team = new_team


/datum/team/plfraider
	var/core_objective = /datum/objective/plfraider

/datum/team/uprising/roundend_report()
	var/list/parts = list()
	parts += span_header("PLF Raiders:")

	var/text = span_header("<br>The raider team was comprised of::")
	text += printplayerlist(members)
	text += "<br>"

	parts += text

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/team/plfraider/antag_listing_name()
	return "PLF Raider"

/datum/team/plfraider/proc/update_objectives()
	if(core_objective)
		var/datum/objective/O = new core_objective
		O.team = src
		objectives += O



/datum/team/plfraider/add_member(datum/mind/new_member)
	..()
	SEND_SIGNAL(src, COMSIG_NUKE_TEAM_ADDITION, new_member.current)
