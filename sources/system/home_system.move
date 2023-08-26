module withinfinity::home_system {
    use withinfinity::world::World;
    use sui::clock::Clock;
    use sui::object;
    use withinfinity::world;
    use withinfinity::pet::Pet;
    use withinfinity::state_system;
    use withinfinity::level;
    use withinfinity::level::LevelStorage;

    const Hour:u64 = 3600000u64;
    const Minute:u64 = 60000u64;
    const Second:u64 = 1000u64;

    public entry fun bathe_pet(world: &mut World, pet: &Pet, clock: &Clock){
        let pet_id = object::id(pet);
        let (state, hunger,cleanliness,mood,level) = state_system::get_pet_state_and_level(world, pet_id, clock);
        assert!(state == b"online", 0);
        cleanliness = cleanliness + 50;
        mood = mood + 10;

        let level_storage = world::get_mut_storage<LevelStorage>(world, level::get_level_storage_key());
        level::set_level_data_all(level_storage, pet_id , hunger, cleanliness,mood, level);
    }

    public entry fun play_with_pet(world:&mut World, pet: &Pet, clock: &Clock){
        let pet_id = object::id(pet);
        let (state, hunger,cleanliness,mood,level) = state_system::get_pet_state_and_level(world, pet_id, clock);
        assert!(state == b"online", 0);
        hunger = hunger + 20;
        mood = mood + 50;

        let level_storage = world::get_mut_storage<LevelStorage>(world, level::get_level_storage_key());
        level::set_level_data_all(level_storage, pet_id , hunger, cleanliness,mood, level);
    }
}
