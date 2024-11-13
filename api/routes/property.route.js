const express = require("express");
const router = express.Router();

const propertyController = require("../controllers/property.controller");
const uploadFiles = require("../../config/multer");

router.post(
  "/add",
  uploadFiles("property").fields([
    { name: "panoImg" },
    { name: "otherImg" },
    { name: "pdfFile" },
  ]),
  propertyController.createProperty
);
router.get("/all", propertyController.getAllImmobs);
router.get("/:id", propertyController.getImmobById);

module.exports = router;
