/datum/emote/living/carbon
	mob_type_allowed_typecache = list(/mob/living/carbon)

/datum/emote/living/carbon/airguitar
	key = "airguitar"
	name = "Обезьянничать"
	message = "машет руками и мотает головой, как шимпанзе на сафари."
	hands_use_check = TRUE

/datum/emote/living/carbon/clap
	key = "clap"
	key_third_person = "claps"
	name = "Хлопать"
	message = "хлопает."
	hands_use_check = TRUE
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	vary = TRUE
	affected_by_pitch = FALSE

/datum/emote/living/carbon/clap/get_sound(mob/living/user)
	if(!user.get_bodypart(BODY_ZONE_L_ARM) || !user.get_bodypart(BODY_ZONE_R_ARM))
		return
	return pick(
		'sound/mobs/humanoids/human/clap/clap1.ogg',
		'sound/mobs/humanoids/human/clap/clap2.ogg',
		'sound/mobs/humanoids/human/clap/clap3.ogg',
		'sound/mobs/humanoids/human/clap/clap4.ogg',
	)

/datum/emote/living/carbon/crack
	key = "crack"
	key_third_person = "cracks"
	name = "Хрустеть"
	message = "хрустит костяшками пальцев."
	sound = 'sound/mobs/humanoids/human/knuckle_crack/knuckles.ogg'
	hands_use_check = TRUE
	cooldown = 6 SECONDS

/datum/emote/living/carbon/crack/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional, params)
	if(!iscarbon(user) || user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/carbon/cry
	key = "cry"
	key_third_person = "cries"
	name = "Плакать"
	message = "плачет."
	message_mime = "sobs silently."
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	vary = TRUE
	stat_allowed = SOFT_CRIT

/datum/emote/living/carbon/cry/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	QDEL_IN(human_user.give_emote_overlay(/datum/bodypart_overlay/simple/emote/cry), 12.8 SECONDS)

/datum/emote/living/carbon/cry/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	return user.dna.species.get_cry_sound(user)

/datum/emote/living/carbon/circle
	key = "circle"
	key_third_person = "circles"
	name = "Окей"
	hands_use_check = TRUE

/datum/emote/living/carbon/circle/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!length(user.get_empty_held_indexes()))
		to_chat(user, span_warning("У тебя нет свободных рук, чтобы очертить круг."))
		return
	var/obj/item/hand_item/circlegame/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, span_notice("Ты описываешь рукой символ ОК."))

/datum/emote/living/carbon/meow
	key = "meow"
	key_third_person = "meows"
	vary = TRUE
	sound = SFX_CAT_MEOW
	name = "Мяукнуть"
	message = "мяу!"
	message_mime = "meows silently."
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/datum/emote/living/carbon/meow/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional, params)
	if(!iscarbon(user) || (!istype(user.get_organ_slot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/cat)))
		return FALSE
	return ..()

/datum/emote/living/carbon/purr
	key = "purr"
	key_third_person = "purrs"
	vary = TRUE
	sound = SFX_CAT_PURR
	name = "Мурлыкать"
	message = "мрр~."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/purr/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional, params)
	if(!iscarbon(user) || (!istype(user.get_organ_slot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/cat)) || HAS_MIND_TRAIT(user, TRAIT_MIMING))
		return FALSE
	return ..()

/datum/emote/living/carbon/moan
	key = "moan"
	key_third_person = "moans"
	name = "Стонать"
	message = "стонет!"
	message_mime = "appears to moan!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/carbon/noogie
	key = "noogie"
	key_third_person = "noogies"
	hands_use_check = TRUE

/datum/emote/living/carbon/noogie/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/hand_item/noogie/noogie = new(user)
	if(user.put_in_hands(noogie))
		to_chat(user, span_notice("Ты готовишь свою крутую руку."))
	else
		qdel(noogie)
		to_chat(user, span_warning("В своем нынешнем состоянии ты ни на что не способен."))

/datum/emote/living/carbon/roll
	key = "roll"
	key_third_person = "rolls"
	message = "rolls."
	mob_type_allowed_typecache = list(/mob/living/carbon/alien)
	hands_use_check = TRUE

/datum/emote/living/carbon/scratch
	key = "scratch"
	key_third_person = "scratches"
	name = "Царапать"
	message = "царапает."
	mob_type_allowed_typecache = list(/mob/living/carbon/alien)
	hands_use_check = TRUE

/datum/emote/living/carbon/sign
	key = "sign"
	key_third_person = "signs"
	message_param = "обозначает число %t."
	mob_type_allowed_typecache = list(/mob/living/carbon/alien)
	hands_use_check = TRUE

/datum/emote/living/carbon/sign/select_param(mob/user, params)
	. = ..()
	if(!isnum(text2num(params)))
		return message

/datum/emote/living/carbon/sign/signal
	key = "signal"
	key_third_person = "signals"
	message_param = "raises %t fingers."
	mob_type_allowed_typecache = list(/mob/living/carbon/human)
	hands_use_check = TRUE

/datum/emote/living/carbon/slap
	key = "slap"
	key_third_person = "slaps"
	name = "Шлёпать"
	hands_use_check = TRUE
	cooldown = 3 SECONDS // to prevent endless table slamming

/datum/emote/living/carbon/slap/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/hand_item/slapper/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, span_notice("Ты готовишь свою руку для пощечины."))
	else
		qdel(N)
		to_chat(user, span_warning("В своем нынешнем состоянии ты не способен дать пощечину."))


/datum/emote/living/carbon/hand
	key = "hand"
	key_third_person = "hands"
	name = "Рука"
	hands_use_check = TRUE


/datum/emote/living/carbon/hand/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/hand_item/hand/hand = new(user)
	if(user.put_in_hands(hand))
		to_chat(user, span_notice("You ready your hand."))
	else
		qdel(hand)
		to_chat(user, span_warning("You're incapable of using your hand in your current state."))


/datum/emote/living/carbon/snap
	key = "snap"
	key_third_person = "snaps"
	name = "Щёлкнуть"
	message = "щелкает пальцами."
	message_param = "snaps their fingers at %t."
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	hands_use_check = TRUE
	affected_by_pitch = FALSE

/datum/emote/living/carbon/snap/get_sound(mob/living/user)
	if(ishuman(user))
		return pick(
			'sound/mobs/humanoids/human/snap/fingersnap1.ogg',
			'sound/mobs/humanoids/human/snap/fingersnap2.ogg',
			)
	return null

/datum/emote/living/carbon/shoesteal
	key = "shoesteal"
	key_third_person = "shoesteals"
	name = "Украсть обувь"
	hands_use_check = TRUE
	cooldown = 3 SECONDS

/datum/emote/living/carbon/shoesteal/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/hand_item/stealer/stealing_hand = new(user)
	if (user.put_in_hands(stealing_hand))
		user.balloon_alert(user, "готовится украсть обувь...")
	else
		qdel(stealing_hand)
		user.balloon_alert(user, "ты не можешь украсть обувь!")

/datum/emote/living/carbon/tail
	key = "tail"
	name = "Вилять хвостом"
	message = "машет хвостом."
	mob_type_allowed_typecache = list(/mob/living/carbon/alien)

/datum/emote/living/carbon/wink
	key = "wink"
	key_third_person = "winks"
	name = "Подмигнуть"
	message = "подмигивает."

/datum/emote/living/carbon/hiss
	key = "hiss"
	key_third_person = "hisses"
	name = "Шипеть"
	message = "шипит!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	vary = TRUE

/datum/emote/living/carbon/hiss/get_sound(mob/living/carbon/user)
	. = ..()
	if(!istype(user))
		return
	if(isalien(user))
		return SFX_HISS
	return user.dna.species.get_hiss_sound()
