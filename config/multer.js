const multer = require("multer");
const path = require("path");

const uploadFiles = (folderName) => {
  const storage = multer.diskStorage({
    destination: (req, file, cb) => {
      if (file.fieldname === "pdfFile") {
        folderName = "propertyfiles";
      }

      cb(null, `public/${folderName}`);
    },
    filename: (req, file, cb) => {
      const ext = path.extname(file.originalname);
      const name = path.basename(file.originalname, ext);
      cb(null, name + "-" + Date.now() + ext);
    },
  });

  return multer({ storage: storage });
};

module.exports = uploadFiles;
