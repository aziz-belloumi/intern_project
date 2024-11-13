const Immob = require("../model/property.model");

const createProperty = async (req, res) => {
  try {
    console.log("Received files:", req.files);
    console.log("Received body:", req.body);
    console.log("address:", req.body.location.latitude);

    const immobPhotos = req.files.otherImg;
    const panoImg = req.files.panoImg ? req.files.panoImg[0].path : null;
    const pdfFile = req.files.pdfFile ? req.files.pdfFile[0].path : null;

    if (!immobPhotos || immobPhotos.length === 0) {
      return res.status(400).json({ message: "No images uploaded." });
    }

    const immobPhotoPaths = immobPhotos.map((file) => file.path);

    const newImmob = new Immob({
      category: req.body.category,
      streetAddress: req.body.streetAddress,
      aptSuite: req.body.aptSuite,
      city: req.body.city,
      province: req.body.province,
      country: req.body.country,
      guestCount: req.body.guestCount,
      bedroomCount: req.body.bedroomCount,
      bedCount: req.body.bedCount,
      bathroomCount: req.body.bathroomCount,
      amenities: JSON.parse(req.body.amenities),
      panoImg,
      listingPhotoPaths: immobPhotoPaths,
      title: req.body.title,
      description: req.body.description,
      location: JSON.parse(req.body.location),
      highlight: req.body.highlight,
      highlightDesc: req.body.highlightDesc,
      price: req.body.price,
      immobStatus: req.body.immobStatus,
      paymentInterval: req.body.paymentInterval,
      VRTour: req.body.VRTour,
      pdfFile,
    });

    await newImmob.save();
    console.log("Property saved successfully");

    return res.status(201).json(newImmob);
  } catch (error) {
    console.error("Error creating property:", error);
    return res.status(500).json({
      message: "Failed to create property. Please try again later.",
    });
  }
};

const getAllImmobs = async (req, res) => {
  try {
    const immobs = await Immob.find();

    res.status(200).json(immobs);
  } catch (error) {
    console.error("Error retrieving immobilers:", error);
    res.status(500).json({
      message: "Failed to retrieve immobilers. Please try again later.",
    });
  }
};

const getImmobById = async (req, res) => {
  try {
    const immobId = req.params.id;

    if (!immobId) {
      return res.status(400).json({ message: "Immobilier ID is required." });
    }

    const immob = await Immob.findById(immobId);

    if (!immob) {
      return res.status(404).json({ message: "Immobilier not found." });
    }

    res.status(200).json(immob);
  } catch (error) {
    console.error("Error retrieving immobilier:", error);
    res.status(500).json({
      message: "Failed to retrieve Immobilier. Please try again later.",
    });
  }
};

module.exports = {
  createProperty,
  getAllImmobs,
  getImmobById,
};
