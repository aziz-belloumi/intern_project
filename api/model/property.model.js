const mongoose = require("mongoose");

const propertySchema = new mongoose.Schema(
  {
    creator: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
    category: {
      type: String,
    },
    streetAddress: {
      type: String,
    },
    aptSuite: {
      type: String,
    },
    city: {
      type: String,
    },
    province: {
      type: String,
    },
    country: {
      type: String,
    },
    guestCount: {
      type: Number,
    },
    position: {
      type: Array,
      default: [],
    },
    bedroomCount: {
      type: Number,
    },
    bedCount: {
      type: Number,
    },
    bathroomCount: {
      type: Number,
    },
    amenities: {
      type: Array,
      default: [],
    },
    panoImg: {
      type: String,
    },
    listingPhotoPaths: [{ type: String }],
    pdfFile: { type: String },
    title: {
      type: String,
    },
    description: {
      type: String,
    },
    highlight: {
      type: String,
    },
    highlightDesc: {
      type: String,
    },
    price: {
      type: Number,
    },
    immobStatus: {
      type: String,
    },
    paymentInterval: {
      type: String,
    },
    VRTour: {
      type: Boolean,
      default: false,
    },
    location: {
      latitude: {
        type: Number,
      },
      longitude: {
        type: Number,
      },
      address: {
        type: String,
      },
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Property", propertySchema);
