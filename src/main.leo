program tamagotchi.aleo {
    struct Pet {
        secret_hash: field,
        saturation: u16,
        happiness: u16,
        health: u16,
        balance: u32,
        create_height: u32,
        update_height: u32,
        feed_height: u32,
        play_height: u32
    }

    mapping pets: field => Pet;

    transition create(secret: scalar, height: u32) -> Pet {
        let hash: field = BHP1024::hash_to_field(secret);
        let pet: Pet = Pet {
            secret_hash: hash,
            saturation: 8640u16,
            happiness: 8640u16,
            health: 8640u16,
            balance: 0u32,
            create_height: height,
            update_height: height,
            feed_height: height,
            play_height: height
        };
        return pet then finalize(pet);
    }

    finalize create(pet: Pet) {
        assert_eq(pet.create_height, block.height);
        assert_neq(Mapping::contains(pets, pet.secret_hash), true);
        Mapping::set(pets, pet.secret_hash, pet);
    }

    transition update(secret: scalar) {
        return then finalize(secret);
    }

    finalize update(secret: scalar) {
        let hash: field = BHP1024::hash_to_field(secret);
        assert(Mapping::contains(pets, hash));

        let pet: Pet = Mapping::get(pets, hash);

        let time_since_feed: u32 = block.height - pet.feed_height;

        let saturation: u16 = pet.saturation;
        let health: u16 = pet.health;
        let happiness: u16 = pet.happiness;

        if (time_since_feed > pet.saturation as u32) {
            saturation = 0u16;
            if (time_since_feed > pet.health as u32) {
                health = 0u16;
            } else {
                health -= time_since_feed as u16 - pet.saturation;
            }
        } else {
            saturation -= time_since_feed as u16;
        }

        if (pet.saturation - saturation > happiness) {
            happiness = 0u16;
        } else {
            happiness -= (pet.saturation - saturation);
        }

        if ((pet.health - health) * 2u16 > happiness) {
            happiness = 0u16;
        } else {
            happiness -= (pet.health - health) * 2u16;
        }

        let new_pet: Pet = Pet {
            secret_hash: pet.secret_hash,
            saturation: saturation,
            happiness: happiness,
            health: health,
            balance: pet.balance,
            create_height: pet.create_height,
            update_height: block.height,
            feed_height: pet.feed_height,
            play_height: pet.play_height
        };

        Mapping::set(pets, hash, new_pet);
    }

    transition top_up_balance(secret: scalar, amount: u32) {
        return then finalize(secret, amount);
    }

    finalize top_up_balance (secret: scalar, amount: u32) {
        let hash: field = BHP1024::hash_to_field(secret);
        assert(Mapping::contains(pets, hash));

        let pet: Pet = Mapping::get(pets, hash);
        let new_pet: Pet = Pet {
            secret_hash: pet.secret_hash,
            saturation: pet.saturation,
            happiness: pet.happiness,
            health: pet.health,
            balance: pet.balance + amount,
            create_height: pet.create_height,
            update_height: pet.update_height,
            feed_height: pet.feed_height,
            play_height: pet.play_height
        };
        Mapping::set(pets, hash, new_pet);
    }

    transition feed(secret: scalar, dish: u8) {
        return then finalize(secret, dish);
    }

    finalize feed(secret: scalar, dish: u8) {
        assert(dish <= 4u8)

        let hash: field = BHP1024::hash_to_field(secret);

        assert(Mapping::contains(pets, hash));

        let pet: Pet = Mapping::get(pets, hash);

        assert(pet.update_height + 20u32 >= block.height);

        let cost: u32 = 0u32;
        let saturation_increase: u16 = 0u16;
        let health_increase: u16 = 0u16;
        let health_decrease: u16 = 0u16;
        let happiness_increase: u16 = 0u16;
        
        let saturation: u16 = pet.saturation;
        let health: u16 = pet.health;
        let happiness: u16 = pet.happiness;
        let balance: u32 = pet.balance;

        assert(health > 0u16);


        if (dish == 0u8) { // Basic Food
            cost = 2u32;
            saturation_increase = 2000u16;
        } else if (dish == 1u8) { // Healthy Salad
            cost = 5u32;
            saturation_increase = 3000u16;
            happiness_increase = 1000u16;
            health_increase = 1000u16;
        } else if (dish == 2u8) { // Deluxe Meal
            cost = 10u32;
            saturation_increase = 4000u16;
            happiness_increase = 3000u16;
        } else if (dish == 3u8) { // Sweet Treat
            cost = 3u32;
            saturation_increase = 1000u16;
            happiness_increase = 2000u16;
            health_decrease = 500u16;
        } else if (dish == 4u8) { // Energizing Smoothie
            cost = 7u32;
            saturation_increase = 2000u16;
            happiness_increase = 2000u16;
            health_increase = 2000u16;
        }

        assert(cost <= balance)
        
        if (saturation + saturation_increase > 8640u16) {
            saturation = 8640u16;
        } else {
            saturation += saturation_increase;
        }
        if (health + health_increase > 8640u16) {
            health = 8640u16;
        } else {
            health += health_increase;
        }
        if (health_decrease > health) {
            health = 0u16;
            if (health_decrease > happiness) {
                happiness = 0u16;
            } else {
                happiness -= health_decrease - health;
            }
        } else {
            health -= health_decrease;
        }
        if (happiness + happiness_increase > 8640u16) {
            happiness = 8640u16;
        } else {
            happiness += happiness_increase;
        }

        let new_pet: Pet = Pet {
            secret_hash: pet.secret_hash,
            saturation: saturation,
            happiness: happiness,
            health: health,
            balance: balance - cost,
            create_height: pet.create_height,
            update_height: pet.update_height,
            feed_height: block.height,
            play_height: pet.play_height
        };
    }

    transition play(secret: scalar, toy: u8) {
        return then finalize(secret, toy);
    }

    finalize play(secret: scalar, toy: u8) {
        let hash: field = BHP1024::hash_to_field(secret);

        assert(Mapping::contains(pets, hash));

        let pet: Pet = Mapping::get(pets, hash);

        assert(pet.update_height + 20u32 >= block.height);
        assert(pet.play_height + 500u32 < block.height);
        assert(toy <= 4u8);

        let cost: u32 = 0u32;
        let happiness_increase: u16 = 0u16;
        let health_decrease: u16 = 0u16;
        
        let saturation: u16 = pet.saturation;
        let health: u16 = pet.health;
        let happiness: u16 = pet.happiness;
        let balance: u32 = pet.balance;

        assert(health > 0u16);

        if (toy == 0u8) { // Ball
            cost = 1u32;
            happiness_increase = 1000u16;
        } else if (toy == 1u8) { // Frisbee
            cost = 2u32;
            happiness_increase = 2000u16;
        } else if (toy == 2u8) { // Puzzle
            cost = 2u32;
            happiness_increase = 3000u16;
            health_decrease = 1000u16;
        } else if (toy == 3u8) { // Cat Tree
            cost = 2u32;
            happiness_increase = 2000u16;
            health_decrease = 500u16;
        } else if (toy == 4u8) { // Laser Pointer
            cost = 3u32;
            happiness_increase = 1000u16;
        }

        assert(cost <= balance)
        
        if (happiness + happiness_increase > 8640u16) {
            happiness = 8640u16;
        } else {
            happiness += happiness_increase;
        }
        if (health_decrease > health) {
            health = 0u16;
            if (health_decrease > happiness) {
                happiness = 0u16;
            } else {
                happiness -= health_decrease - health;
            }
        } else {
            health -= health_decrease;
        }

        let new_pet: Pet = Pet {
            secret_hash: pet.secret_hash,
            saturation: saturation,
            happiness: happiness,
            health: health,
            balance: balance - cost,
            create_height: pet.create_height,
            update_height: pet.update_height,
            feed_height: pet.feed_height,
            play_height: block.height
        };
    }

    transition heal(secret: scalar, variant: u8) {
        return then finalize(secret, variant);
    }

    finalize heal(secret: scalar, variant: u8) {
        assert(variant <= 3u8);

        let hash: field = BHP1024::hash_to_field(secret);

        assert(Mapping::contains(pets, hash));

        let pet: Pet = Mapping::get(pets, hash);

        assert(pet.update_height + 20u32 >= block.height);

        let balance: u32 = pet.balance;

        let health: u16 = pet.health;

        let health_increase: u16 = 0u16;
        let cost: u16 = 0u16;

        if (variant == 0u16) {
            cost = 15u16;
            health_increase = 500u16;
        } else if (variant == 1u16) {
            cost = 27u16;
            health_increase = 1000u16;
        } else if (variant == 2u16) {
            cost = 50u16;
            health_increase = 2000u16;
        } else if (variant == 3u16) {
            cost = 90u16;
            health_increase = 4000u16;
        }

        assert(cost <= balance);

        if (health + health_increase > 8640u16) {
            health = 8640u16;
        } else {
            health += health_increase;
        }

        let new_pet: Pet = Pet {
            secret_hash: pet.secret_hash,
            saturation: pet.saturation,
            happiness: pet.happiness,
            health: health,
            balance: balance - cost,
            create_height: pet.create_height,
            update_height: pet.update_height,
            feed_height: pet.feed_height,
            play_height: pet.play_height
        };

        Mapping::set(pets, hash, new_pet);
    }
}
