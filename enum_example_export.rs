#![crate_type = "cdylib"]

#[derive(Debug)]
enum UsState {
    Alabama,
    Alaska,
}

enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter(UsState),
}

#[no_mangle]
pub extern "C" fn value_in_cents(coin_type: u8, state: u8) -> u8 {
    // Reconstruction d'un enum pour la démo
    let coin = match coin_type {
        0 => Coin::Penny,
        1 => Coin::Nickel,
        2 => Coin::Dime,
        3 => {
            let us_state = match state {
                0 => UsState::Alabama,
                _ => UsState::Alaska,
            };
            Coin::Quarter(us_state)
        }
        _ => Coin::Penny,
    };

    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter(_state) => 25,
    }
}
