require("../metadata.txt");
require("../functions.php");

const requireAll = (r) => r.keys().forEach(r);
requireAll(require.context("../views", true, /\.php$/));
requireAll(require.context("../templates", true, /\.twig$/));
requireAll(require.context("../images", true, /\.(svg|png|jpg|gif)$/));
requireAll(require.context("../fonts", true, /\.(woff2?|ttf)$/));

require("../styles/main.scss");

require("./modules/hello");
