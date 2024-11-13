// Load modules
const mongoose = require("mongoose");

const debug = require("debug")("convergeinnov-api:database");

// Load configs
const environment = require("./environment");

const mongoUri = environment.mongo.host;

module.exports = class Database {
  static async connect() {
    console.log("on database class connect");

    try {
    //   if (mongoose.connection.readyState === 2) {
    //     return; 
    //   }

    //   await mongoose.connection.close();

      await mongoose.connect("mongodb+srv://aziz1:aziz1234@cluster0.l7vwvnt.mongodb.net/node_test", { 
        // useNewUrlParser: true,
        // useUnifiedTopology: true,
      });
      console.log(
        "** Connection to database has been established successfully **"
      );

      mongoose.connection.on("disconnected", () => {
        console.log("** Database disconnected **");

        if (mongoose.connection.readyState !== 2) {
        // debug("** Retrying connection in 10 seconds **");
          setTimeout(async () => {
            await Database.connect();
          }, 10000);
        }
      });
    } catch (error) {
    //   debug(`Unable to connect to database: ${error.message.split("\n")[0]}`);
      if (mongoose.connection.readyState !== 2) {
        // debug("** Retrying connection in 10 seconds **");
         console.log("** Retrying connection in 10 seconds **");
        setTimeout(async () => {
          await Database.connect();
        }, 10000);
      }
    }
  }
};
