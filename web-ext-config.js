// Configuration for Vite's build process
module.exports = {
  // List of files to ignore during the build process
  ignoreFiles: ["web-ext-config.js", "Makefile", "helper", "popup"],
  // Build options
  build: {
    // Overwrite destination files if they already exist
    overwriteDest: true,
  },
};
