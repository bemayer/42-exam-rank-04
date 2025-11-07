#![crate_type = "cdylib"]
#[derive(Debug)]
enum UsState {
    Alabama,
    Alaska,
    // ... autres états
}

enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter(UsState),  // Quarter contient une donnée UsState
}

fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter(state) => {
            // Ici on extrait la donnée 'state' du variant Quarter
            println!("State quarter from {:?}!", state);
            25
        }
    }
}

fn main() {
    let coin1 = Coin::Penny;
    let coin2 = Coin::Quarter(UsState::Alaska);

    println!("Penny value: {}", value_in_cents(coin1)); // Affiche 1
    println!("Quarter value: {}", value_in_cents(coin2)); // Affiche 25 et log l'état Alaska
}
