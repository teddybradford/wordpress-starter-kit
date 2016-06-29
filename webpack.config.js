const path = require("path");
const exec = require("child_process").exec;
const CleanPlugin = require("clean-webpack-plugin");
const BrowserSyncPlugin = require("browser-sync-webpack-plugin");
const validate = require("webpack-validator");

const paths = {
  src: path.resolve(__dirname, "src"),
  dist: path.resolve(__dirname, "wordpress/wp-content/themes/custom")
};

const server = {
  host: "localhost",
  port: 3000,
  proxyHost: "127.0.0.1",
  proxyPort: 3100,
  proxyBaseDir: path.resolve(__dirname, "wordpress")
};

const config = {
  entry: `${paths.src}/scripts/main`,
  output: {
    path: paths.dist,
    filename: "bundle.js",
    publicPath: "/"
  },
  module: {
    loaders: [
      { test: /metadata\.txt$/, loader: "file?name=style.css" },
      { test: /\.php$/, loader: "file?name=[name].[ext]" },
      { test: /\.twig$/, loader: `file?name=[path][name].[ext]&context=${paths.src}` },
      { test: /\.(svg|png|jpg|gif)$/, loader: "file?name=images/[hash].[ext]" },
      { test: /\.(woff2?|ttf)$/, loader: "file?name=fonts/[hash].[ext]" },
      { test: /\.js$/, exclude: /node_modules/, loader: "babel" },
      { test: /\.scss$/, exclude: /node_modules/, loader: "style!css?sourceMap!sass?sourceMap" }
    ]
  },
  plugins: [
    new CleanPlugin([paths.dist], { root: __dirname }),
    new BrowserSyncPlugin({
      host: server.host,
      port: server.port,
      proxy: `http://${server.proxyHost}:${server.proxyPort}/`,
      notify: false
    }, () => {
      exec(`php -S ${server.proxyHost}:${server.proxyPort} -t "${server.proxyBaseDir}"`);
    })
  ],
  devtool: "cheap-eval-source-map"
};

module.exports = validate(config);
