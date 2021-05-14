// required for rocket macros to work
#![feature(proc_macro_hygiene, decl_macro)]

extern crate dotenv;
use rocket::http::Status as Status;
use serde::Serialize;
use rocket_contrib::json::Json;

mod logger;

type StdErr = Box<dyn std::error::Error>;

#[derive(Serialize)]
pub struct MyResponse {
    pub key: String,
    pub value: String
}

#[rocket::get("/")]
fn hello_world() -> Json<MyResponse> {
   Json(MyResponse { key: String::from("Hello"), value: String::from("World") })
}

#[rocket::get("/health-check/readiness")]
fn readiness() -> Status {
    Status::Ok
}
#[rocket::get("/health-check/liveness")]
fn liveness() -> Status {
    Status::Ok
}

fn main() -> Result<(), StdErr> {
    // loads env variables from .env
    dotenv::dotenv()?;
    logger::init()?;

    rocket::ignite()
       .mount("/", rocket::routes![hello_world])
       .mount("/", rocket::routes![readiness])
       .mount("/", rocket::routes![liveness])
       .launch();

    Ok(())
}
