#define TANK_DISPENSER_CAPACITY 10

/obj/structure/tank_dispenser
	name = "устройство раздачи баллонов"
	desc = "Простое, но громоздкое устройство для хранения газовых баллонов."
	icon = 'icons/obj/structures.dmi'
	icon_state = "dispenser"
	density = TRUE
	anchored = TRUE
	max_integrity = 300
	var/oxygentanks = TANK_DISPENSER_CAPACITY
	var/plasmatanks = TANK_DISPENSER_CAPACITY

/obj/structure/tank_dispenser/oxygen
	plasmatanks = 0

/obj/structure/tank_dispenser/plasma
	oxygentanks = 0

/obj/structure/tank_dispenser/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "Возьмите плазменный баллон", rmb_text = "Возьмите кислородный баллон")
	update_appearance()

/obj/structure/tank_dispenser/update_overlays()
	. = ..()
	switch(oxygentanks)
		if(1 to 3)
			. += "oxygen-[oxygentanks]"
		if(4 to TANK_DISPENSER_CAPACITY)
			. += "oxygen-4"
	switch(plasmatanks)
		if(1 to 4)
			. += "plasma-[plasmatanks]"
		if(5 to TANK_DISPENSER_CAPACITY)
			. += "plasma-5"

/obj/structure/tank_dispenser/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if (!plasmatanks)
		balloon_alert(user, "нету плазменных баллонов!")
		return
	dispense(/obj/item/tank/internals/plasma, user)
	plasmatanks--
	update_appearance()

/obj/structure/tank_dispenser/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if (!oxygentanks)
		balloon_alert(user, "никаких кислородных баллонов!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	dispense(/obj/item/tank/internals/oxygen, user)
	oxygentanks--
	update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/tank_dispenser/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/structure/tank_dispenser/attackby(obj/item/I, mob/living/user, params)
	var/full
	if(istype(I, /obj/item/tank/internals/plasma))
		if(plasmatanks < TANK_DISPENSER_CAPACITY)
			plasmatanks++
		else
			full = TRUE
	else if(istype(I, /obj/item/tank/internals/oxygen))
		if(oxygentanks < TANK_DISPENSER_CAPACITY)
			oxygentanks++
		else
			full = TRUE
	else if(!user.combat_mode || (I.item_flags & NOBLUDGEON))
		balloon_alert(user, "не удается вставить!")
		return
	else
		return ..()
	if(full)
		balloon_alert(user, "он полон!")
		return

	if(!user.transferItemToLoc(I, src))
		return
	balloon_alert(user, "вставленный резервуар")
	update_appearance()

/obj/structure/tank_dispenser/atom_deconstruct(disassembled = TRUE)
	for(var/X in src)
		var/obj/item/I = X
		I.forceMove(loc)
	new /obj/item/stack/sheet/iron (loc, 2)

/obj/structure/tank_dispenser/examine(mob/user)
	. = ..()
	if(plasmatanks && oxygentanks)
		. += span_notice("В нем остались <b>[plasmatanks]</b> плазменный баллон и <b>[oxygentanks]</b> кислородный баллон.")
	else if(plasmatanks || oxygentanks)
		. += span_notice("В нем есть <b>[plasmatanks ? "[plasmatanks]</b> плазма" : "[oxygentanks]</b> oxygen"] слева от бака.")

/obj/structure/tank_dispenser/proc/dispense(tank_type, mob/receiver)
	var/existing_tank = locate(tank_type) in src
	if (isnull(existing_tank))
		existing_tank = new tank_type
	receiver.put_in_hands(existing_tank)
	balloon_alert(receiver, "tank received")

#undef TANK_DISPENSER_CAPACITY
