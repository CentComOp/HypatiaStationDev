/datum/species/phoronman // /vg/
	name = "Phoronman"
	icobase = 'icons/mob/human_races/r_phoronman_sb.dmi'
	deform = 'icons/mob/human_races/r_phoronman_pb.dmi'  // TODO: Need deform.
	//language = "Clatter"
	unarmed_type = /datum/unarmed_attack/punch

	flags = IS_WHITELISTED | NO_BLOOD
	dietflags = DIET_OMNI

	//default_mutations=list(SKELETON) // This screws things up

	breath_type = "phoron"

	heat_level_1 = 350  // Heat damage level 1 above this point.
	heat_level_2 = 400  // Heat damage level 2 above this point.
	heat_level_3 = 500  // Heat damage level 3 above this point.

/datum/species/phoronman/say_filter(mob/M, message, datum/language/speaking)
	if(copytext(message, 1, 2) != "*")
		message = replacetext(message, "s", stutter("ss"))
	return message

/datum/species/phoronman/equip(var/mob/living/carbon/human/H)
	H.fire_sprite = "Phoronman"

	// Unequip existing suits and hats.
	H.unEquip(H.wear_suit)
	H.unEquip(H.head)
	if(H.mind.assigned_role!="Clown")
		H.unEquip(H.wear_mask)

	H.equip_or_collect(new /obj/item/clothing/mask/breath(H), slot_wear_mask)
	var/suit=/obj/item/clothing/suit/space/eva/phoronman
	var/helm=/obj/item/clothing/head/helmet/space/eva/phoronman
	var/tank_slot = slot_s_store
	var/tank_slot_name = "suit storage"

	switch(H.mind.assigned_role)
		if("Scientist","Geneticist","Roboticist")
			suit=/obj/item/clothing/suit/space/eva/phoronman/science
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/science
		if("Research Director")
			suit=/obj/item/clothing/suit/space/eva/phoronman/science/rd
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/science/rd
		if("Station Engineer", "Mechanic")
			suit=/obj/item/clothing/suit/space/eva/phoronman/engineer/
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/engineer/
		if("Chief Engineer")
			suit=/obj/item/clothing/suit/space/eva/phoronman/engineer/ce
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/engineer/ce
		if("Life Support Specialist")
			suit=/obj/item/clothing/suit/space/eva/phoronman/atmostech
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/atmostech
		if("Warden","Detective","Security Officer","Security Pod Pilot")
			suit=/obj/item/clothing/suit/space/eva/phoronman/security/
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/security/
		if("Head of Security", "Magistrate")
			suit=/obj/item/clothing/suit/space/eva/phoronman/security/hos
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/security/hos
		if("Captain", "Blueshield")
			suit=/obj/item/clothing/suit/space/eva/phoronman/security/captain
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/security/captain
		if("Head of Personnel", "Nanotrasen Representative")
			suit=/obj/item/clothing/suit/space/eva/phoronman/security/hop
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/security/hop
		if("Medical Doctor","Brig Physician")
			suit=/obj/item/clothing/suit/space/eva/phoronman/medical
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/medical
		if("Paramedic")
			suit=/obj/item/clothing/suit/space/eva/phoronman/medical/paramedic
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/medical/paramedic
		if("Chemist")
			suit=/obj/item/clothing/suit/space/eva/phoronman/medical/chemist
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/medical/chemist
		if("Chief Medical Officer")
			suit=/obj/item/clothing/suit/space/eva/phoronman/medical/cmo
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/medical/cmo
		if("Bartender", "Chef")
			suit=/obj/item/clothing/suit/space/eva/phoronman/service
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/service
		if("Cargo Technician", "Quartermaster")
			suit=/obj/item/clothing/suit/space/eva/phoronman/cargo
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/cargo
		if("Shaft Miner")
			suit=/obj/item/clothing/suit/space/eva/phoronman/miner
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/miner
		if("Botanist")
			suit=/obj/item/clothing/suit/space/eva/phoronman/botanist
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/botanist
		if("Chaplain")
			suit=/obj/item/clothing/suit/space/eva/phoronman/chaplain
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/chaplain
		if("Janitor")
			suit=/obj/item/clothing/suit/space/eva/phoronman/janitor
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/janitor
		if("Civilian", "Barber")
			suit=/obj/item/clothing/suit/space/eva/phoronman/assistant
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/assistant
		if("Clown")
			suit=/obj/item/clothing/suit/space/eva/phoronman/clown
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/clown
		if("Mime")
			suit=/obj/item/clothing/suit/space/eva/phoronman/mime
			helm=/obj/item/clothing/head/helmet/space/eva/phoronman/mime
	H.equip_or_collect(new suit(H), slot_wear_suit)
	H.equip_or_collect(new helm(H), slot_head)
	H.equip_or_collect(new/obj/item/weapon/tank/phoron/phoronman(H), tank_slot) // Bigger phoron tank from Raggy.
	H << "\blue You are now running on phoron internals from the [H.s_store] in your [tank_slot_name].  You must breathe phoron in order to survive, and are extremely flammable."
	H.internal = H.get_item_by_slot(tank_slot)
	if (H.internals)
		H.internals.icon_state = "internal1"

// Phoronmen are so fucking different that they need their own proc.
/datum/species/phoronman/handle_breath(var/datum/gas_mixture/breath, var/mob/living/carbon/human/H)
	var/safe_phoron_min = 16 // Minimum safe partial pressure of PHORON, in kPa
	//var/safe_oxygen_max = 140 // Maximum safe partial pressure of PHORON, in kPa (Not used for now)
	var/safe_co2_max = 10 // Yes it's an arbitrary value who cares?
	var/SA_para_min = 1
	var/SA_sleep_min = 5
	var/phoron_used = 0
	var/nitrogen_used = 0
	var/breath_pressure = (breath.total_moles()*R_IDEAL_GAS_EQUATION*breath.temperature)/BREATH_VOLUME

	// Partial pressure of phoron
	var/Toxins_pp = (breath.toxins/breath.total_moles())*breath_pressure
	// And CO2, lets say a PP of more than 10 will be bad (It's a little less really, but eh, being passed out all round aint no fun)
	var/CO2_pp = (breath.carbon_dioxide/breath.total_moles())*breath_pressure // Tweaking to fit the hacky bullshit I've done with atmo -- TLE

	if(Toxins_pp < safe_phoron_min)
		if(prob(20))
			spawn(0)
				H.emote("gasp")
		if(Toxins_pp > 0)
			var/ratio = safe_phoron_min/Toxins_pp
			H.adjustOxyLoss(min(5*ratio, HUMAN_MAX_OXYLOSS)) // Don't fuck them up too fast (space only does HUMAN_MAX_OXYLOSS after all!)
			H.failed_last_breath = 1
			phoron_used = breath.toxins*ratio/6
		else
			H.adjustOxyLoss(HUMAN_MAX_OXYLOSS)
			H.failed_last_breath = 1
		H.oxygen_alert = max(H.oxygen_alert, 1)

	else								// We're in safe limits
		H.failed_last_breath = 0
		H.adjustOxyLoss(-5)
		phoron_used = breath.toxins/6
		H.oxygen_alert = 0

	breath.toxins -= phoron_used
	breath.nitrogen -= nitrogen_used
	breath.carbon_dioxide += phoron_used

	//CO2 does not affect failed_last_breath. So if there was enough oxygen in the air but too much co2, this will hurt you, but only once per 4 ticks, instead of once per tick.
	if(CO2_pp > safe_co2_max)
		if(!H.co2overloadtime) // If it's the first breath with too much CO2 in it, lets start a counter, then have them pass out after 12s or so.
			H.co2overloadtime = world.time
		else if(world.time - H.co2overloadtime > 120)
			H.Paralyse(3)
			H.adjustOxyLoss(3) // Lets hurt em a little, let them know we mean business
			if(world.time - H.co2overloadtime > 300) // They've been in here 30s now, lets start to kill them for their own good!
				H.adjustOxyLoss(8)
		if(prob(20)) // Lets give them some chance to know somethings not right though I guess.
			spawn(0)
				H.emote("cough")

	else
		H.co2overloadtime = 0

	if(breath.trace_gases.len)	// If there's some other shit in the air lets deal with it here.
		for(var/datum/gas/sleeping_agent/SA in breath.trace_gases)
			var/SA_pp = (SA.moles/breath.total_moles())*breath_pressure
			if(SA_pp > SA_para_min) // Enough to make us paralysed for a bit
				H.Paralyse(3) // 3 gives them one second to wake up and run away a bit!
				if(SA_pp > SA_sleep_min) // Enough to make us sleep as well
					H.sleeping = min(H.sleeping+2, 10)
			else if(SA_pp > 0.15)	// There is sleeping gas in their lungs, but only a little, so give them a bit of a warning
				if(prob(20))
					spawn(0)
						H.emote(pick("giggle", "laugh"))
			SA.moles = 0

	if( (abs(310.15 - breath.temperature) > 50) && !(RESIST_HEAT in H.mutations)) // Hot air hurts :(
		if(H.status_flags & GODMODE)
			return 1	//godmode
		if(breath.temperature < cold_level_1)
			if(prob(20))
				src << "\red You feel your face freezing and an icicle forming in your lungs!"
		else if(breath.temperature > heat_level_1)
			if(prob(20))
				src << "\red You feel your face burning and a searing heat in your lungs!"

		switch(breath.temperature)
			if(-INFINITY to cold_level_3)
				H.apply_damage(COLD_GAS_DAMAGE_LEVEL_3, BURN, "head", used_weapon = "Excessive Cold")
				H.fire_alert = max(H.fire_alert, 1)

			if(cold_level_3 to cold_level_2)
				H.apply_damage(COLD_GAS_DAMAGE_LEVEL_2, BURN, "head", used_weapon = "Excessive Cold")
				H.fire_alert = max(H.fire_alert, 1)

			if(cold_level_2 to cold_level_1)
				H.apply_damage(COLD_GAS_DAMAGE_LEVEL_1, BURN, "head", used_weapon = "Excessive Cold")
				H.fire_alert = max(H.fire_alert, 1)

			if(heat_level_1 to heat_level_2)
				H.apply_damage(HEAT_GAS_DAMAGE_LEVEL_1, BURN, "head", used_weapon = "Excessive Heat")
				H.fire_alert = max(H.fire_alert, 2)

			if(heat_level_2 to heat_level_3)
				H.apply_damage(HEAT_GAS_DAMAGE_LEVEL_2, BURN, "head", used_weapon = "Excessive Heat")
				H.fire_alert = max(H.fire_alert, 2)

			if(heat_level_3 to INFINITY)
				H.apply_damage(HEAT_GAS_DAMAGE_LEVEL_3, BURN, "head", used_weapon = "Excessive Heat")
				H.fire_alert = max(H.fire_alert, 2)
	return 1