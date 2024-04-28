% item(itemName,WeatherCondition,mainlyfocusedon,nature,UsingGender,usedIn)

item(wallet, all,all,essential,both,any).
item(camera, all,all,photography,both,any).
item(camera_charger, all,all,photography,both,any).
item(phone_charger, all,all,essential,both,any).
item(phone, all,all,essential,both,any).
item(headphones, all,all,entertainment,both,any).
item(power_bank, all,all,essential,both,any).
item(toothbrush, all,all,essential,both,any).
item(toothpaste, all,all,essential,both,any).
item(comb, all,all,essential,both,any).
item(deodorant, all,all,essential,both,any).
item(razor, all,all,essential,male,any).
item(hand_sanitizer, all,all,essential,both,any).
item(medications, all,all,essential,both,any).
item(first_aid, all,all,essential,both,any).
item(towel, all,all,essential,both,any).
item(underwear, all,all,essential,both,any).
item(t-shirt, all,all,clothing,both,any).
item(casual_shirt, all,all,clothing,male,any).
item(vest, all,all,clothing,both,any).
item(jacket,cold,all,clothing,both,any).
item(jersey,cold,all,clothing,both,any).
item(raincoat,rainy, outdoor, clothing, both,any).
item(casual_trouser, all, all, clothing, male,any).
item(shorts, all,all,clothing,both,any).
item(swimsuit, sunny, outdoor, clothing, both,any).
item(pant, all,all,clothing,both,any).
item(pyjama, all,all,clothing,both,any).
item(belt, all,all,essential,male,any).
item(sandals, all,all,clothing,both,any).
item(hiking_shoes, all, outdoor, clothing, both,any).
item(flip-flops, all,all,clothing,both,any).
item(casual_shoes, all,all,clothing,both,any).
item(casual_socks, all,all,clothing,both,any).
item(sunglasses, sunny, outdoor,accessory,both,any).
item(watch, all,all,accessory,both,any).
item(map, all, outdoor, equipment, both,camping).
item(compass, all, outdoor, equipment, both,camping).
item(flashlight, all, outdoor, equipment,both,camping).
item(water_bottle, all,all,essential,both,any).
item(lighter, all, outdoor, equipment, both,any).
item(soap, all,all,essential,both,any).
item(feminine_hygiene_product, all,all,essential,female,any).
item(cap, sunny, outdoor,accessory,both,any).
item(hat, sunny,outdoor,accessory,both,any).
item(sunscreen, sunny, outdoor,pcare,both,any).
item(moisturizing_cream, all,all,pcare,both,any).
item(instant_coffee, all,all,fooditem,both,camping).
item(lip_balm, all,all,pcare,both,any).
item(sleeping_bag, all, outdoor,equipment,both,camping).
item(inflatable_pillow, all, outdoor, equipment, both,camping).
item(tent, all, outdoor, equipment, both,camping).
item(portable_cooker, all,all,equipment,both,camping).
item(portable_cooker, all,all,equipment,both,camping).
item(cooker_fuel, all, all,equipment,both,camping).
item(spoon, all,all,equipment,both,camping).
item(knife, all,all,equipment,both,camping).
item(plates, all,all,equipment,both,camping).
item(cups, all,all,equipment,both,camping).
item(dry_foods, all,all,fooditem,both,camping).
item(spices, all,all,fooditem,both,camping).
item(sugar, all,all,fooditem,both,camping).
item(packed_food, all,all,fooditem,both,any).
item(whistle, all, outdoor,equipment,both,any).
item(card_games, all,all,entertainment,both,any).
item(trash_bags, all, outdoor,equipment,both,camping).
item(rope, all, outdoor,equipment,both,any).
item(formal_shirt, all,business,clothing,male,any).
item(formal_trouser, all,business,clothing,male,any).
item(formal_shoes, all,business,clothing,male,any).
item(suit, all,business,clothing,male,any).
item(tie, all,business,clothing,male,any).
item(tiepin, all,business,clothing,male,any).
item(cufflinks, all,business,clothing,male,any).
item(blouse, all,business,clothing,female,any).
item(skirts, all,business,clothing,female,any).
item(dress_shoes, all,business,clothing,female,any).
item(skirt_suit, all,business,clothing,female,any).

%Camping

% Rule to select must essential items for a camping trip
any_c_essentials(ItemName) :- item(ItemName,all,all,essential,both,any).
% Rule to select essential items for a camping trip
camping_essentials(ItemName, WeatherCondition) :- item(ItemName, WeatherCondition, _, essential, _,_).
% Rule to select outdoor items for a camping trip
camping_outdoor(ItemName, WeatherCondition) :- item(ItemName, WeatherCondition, _,_, _,_),(WeatherCondition = sunny ; WeatherCondition = rainy ; WeatherCondition = cold).
% Rule to select clothing for an camping trip
camping_g_clothing(ItemName,Gender) :- item(ItemName,all,all,clothing,Gender,_);item(ItemName,all,all,clothing,both,_).
% Rule to select clothing for an camping trip
camping_clothing(ItemName, WeatherCondition) :- item(ItemName, WeatherCondition,all,clothing, _,_).
% Rule to select camping equipment
camping_equipment(ItemName) :- item(ItemName, _, _, equipment, _,camping).
% Rule to select personal care items for a camping trip
camping_personal_care(ItemName) :- item(ItemName, _, _, pcare, _,_).
% Rule to select food items for a camping trip
camping_food(ItemName) :- item(ItemName, _, _, fooditem, _,camping).


% Rule to generate a packing list for a camping trip
camping_packing_list(WeatherCondition,Gender) :-
    findall(Item, any_c_essentials(Item), MustEssentials),
    findall(Item, camping_essentials(Item, WeatherCondition), Essentials),
    findall(Item, camping_outdoor(Item, WeatherCondition), Outdoor),
    findall(Item, camping_clothing(Item, WeatherCondition), Clothing),
    findall(Item, camping_g_clothing(Item,Gender), GClothing),
    findall(Item, camping_equipment(Item), Equipment),
    findall(Item, camping_personal_care(Item), PersonalCare),
    findall(Item, camping_food(Item), Food),
    append([MustEssentials,Essentials, Outdoor,Clothing,GClothing,Equipment, PersonalCare, Food], CampingItems),
    print_packing_list(CampingItems).

% Rule to print the packing list downward
print_packing_list([]).
print_packing_list([Item|Rest]) :-
    write(Item), nl,
    print_packing_list(Rest).

%Outdoor

% Rule to select must essential items for a outdoor trip
any_o_essentials(ItemName) :-item(ItemName,all,all,essential,both,any).
% Rule to select essential items for an outdoor trip
outdoor_essentials(ItemName, WeatherCondition) :-item(ItemName, WeatherCondition, _, essential, _,_).
% Rule to select outdoor items for an outdoor trip
outdoor_items(ItemName, WeatherCondition) :-item(ItemName, WeatherCondition, outdoor, _, _,_).
% Rule to select clothing for an outdoor trip
outdoor_g_clothing(ItemName,Gender) :-item(ItemName,all,all,clothing,Gender,_);item(ItemName,all,all,clothing,both,_).
% Rule to select clothing for an outdoor trip
outdoor_clothing(ItemName, WeatherCondition) :-item(ItemName, WeatherCondition,all,clothing, _,_).
% Rule to select outdoor equipment
outdoor_equipment(ItemName) :-item(ItemName, _, outdoor, equipment, _,_).
% Rule to select personal care items for an outdoor trip
outdoor_personal_care(ItemName) :-item(ItemName, _, _, pcare, _,_).
% Rule to select food items for an outdoor trip
outdoor_food(ItemName) :-item(ItemName, _, _, fooditem, _,any).

% Rule to generate a packing list for an outdoor trip
outdoor_packing_list(WeatherCondition,Gender) :-
    findall(Item, any_o_essentials(Item), MustEssentials),
    findall(Item, outdoor_essentials(Item, WeatherCondition), Essentials),
    findall(Item, outdoor_items(Item, WeatherCondition), Items),
    findall(Item, outdoor_clothing(Item, WeatherCondition), Clothing),
    findall(Item, outdoor_g_clothing(Item,Gender), GClothing),
    findall(Item, outdoor_equipment(Item), Equipment),
    findall(Item, outdoor_personal_care(Item), PersonalCare),
    findall(Item, outdoor_food(Item), Food),
    append([MustEssentials,Essentials, Items,Clothing,GClothing,Equipment, PersonalCare, Food], PackingList),
    print_packing_list(PackingList).

%Business

% Rule to select must essential items for a business trip based on gender
any_b_essentials(ItemName,_) :-item(ItemName, all, all, essential, both, any).
business_g_clothing(ItemName,Gender) :-item(ItemName,all,all,clothing,Gender,_);item(ItemName,all,all,clothing,both,_).
% Rule to select clothing items for a business trip based on gender
business_clothing(ItemName,Gender) :-item(ItemName, _, business, clothing, Gender, _).
% Rule to select personal care items for a business trip based on gender
business_personal_care(ItemName, Gender) :-item(ItemName, _, _, pcare, Gender, _).
% Rule to select food items for a business trip based on gender
business_food(ItemName,_) :-item(ItemName, _, _, fooditem, _, any).

% Rule to generate a packing list for a business trip based on gender
business_packing_list(Gender) :-
    findall(Item, any_b_essentials(Item, Gender), MustEssentials),
    findall(Item, business_g_clothing(Item,Gender), GClothing),
    findall(Item, business_clothing(Item, Gender), Clothing),
    findall(Item, business_personal_care(Item, Gender), PersonalCare),
    findall(Item, business_food(Item, Gender), Food),
    append([MustEssentials, GClothing,Clothing, PersonalCare, Food], PackingList),
    print_packing_list(PackingList).

%userInput

% Predicates to get user input
get_trip_type(TripType) :-
    write('Enter trip type (camping, outdoor, business): '),
    read(TripType).

get_gender(Gender) :-
    write('Enter your gender (male, female): '),
    read(Gender).

get_weather_condition(WeatherCondition) :-
    write('Enter weather condition (sunny, rainy, cold): '),
    read(WeatherCondition).

% generate packing list based on user input
generate_packing_list :-
    get_trip_type(TripType),
    (TripType = camping ->
        get_gender(Gender),
        get_weather_condition(WeatherCondition),
        camping_packing_list(WeatherCondition, Gender)
    ; TripType = outdoor ->
        get_gender(Gender),
        get_weather_condition(WeatherCondition),
        outdoor_packing_list(WeatherCondition, Gender)
    ; TripType = business ->
        get_gender(Gender),
        business_packing_list(Gender)
    ; write('Invalid trip type.'), nl
    ).

% Entry point

start :-
    generate_packing_list.

:- initialization(start).
