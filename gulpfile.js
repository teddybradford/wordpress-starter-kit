"use strict";

let gulp = require("gulp");
let del = require("del");
let rename = require("gulp-rename");
let sourcemaps = require("gulp-sourcemaps");
let jspm = require("gulp-jspm");
let sass = require("gulp-sass");
let autoprefixer = require("gulp-autoprefixer");
let portfinder = require("portfinder");
let connect = require("gulp-connect-php");
let browserSync = require("browser-sync").create();

let themeName = "my-theme";

let paths = {
  src: "source",
  dest: "wordpress/wp-content/themes/" + themeName
};

let globs = {
  scripts: paths.src + "/scripts/**/*.js",
  styles: paths.src + "/styles/**/*.scss",
  images: paths.src + "/images/**/*.{jpg,png,gif,svg}",
  fonts: paths.src + "/fonts/**/*.{eot,woff2,woff,ttf,otf,svg}",
  views: paths.src + "/views/**/*.php",
  templates: paths.src + "/templates/**/*.twig",
  files: [
    paths.src + "/functions.php",
    paths.src + "/style.css",
    paths.src + "/screenshot.png"
  ]
};

gulp.task("scripts", () => {
  return gulp.src(globs.scripts)
    .pipe(sourcemaps.init())
    .pipe(jspm({selfExecutingBundle: true}))
    .pipe(rename("theme.js"))
    .pipe(sourcemaps.write("."))
    .pipe(gulp.dest(paths.dest + "/scripts"));
});

gulp.task("styles", () => {
  return gulp.src(globs.styles)
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(autoprefixer())
    .pipe(rename("theme.css"))
    .pipe(sourcemaps.write("."))
    .pipe(gulp.dest(paths.dest + "/styles"))
    .pipe(browserSync.stream({match: "**/*.css"}));
});

gulp.task("images", () => {
  return gulp.src(globs.images)
    .pipe(gulp.dest(paths.dest + "/images"));
});

gulp.task("fonts", () => {
  return gulp.src(globs.fonts)
    .pipe(gulp.dest(paths.dest + "/fonts"));
});

gulp.task("files", () => {
  return gulp.src(globs.files)
    .pipe(gulp.dest(paths.dest));
});

gulp.task("views", () => {
  return gulp.src(globs.views)
    .pipe(gulp.dest(paths.dest));
});

gulp.task("templates", () => {
  return gulp.src(globs.templates)
    .pipe(gulp.dest(paths.dest + "/templates"));
});

gulp.task("clean", (done) => {
  del([paths.dest + "/**/*"], done);
});

gulp.task("build", [
  "scripts",
  "styles",
  "images",
  "fonts",
  "files",
  "views",
  "templates"
]);

gulp.task("watch", () => {
  gulp.watch(globs.scripts, ["scripts"]).on("change", browserSync.reload);
  gulp.watch(globs.styles, ["styles"]);
  gulp.watch(globs.images, ["images"]).on("change", browserSync.reload);
  gulp.watch(globs.fonts, ["fonts"]).on("change", browserSync.reload);
  gulp.watch(globs.files, ["files"]).on("change", browserSync.reload);
  gulp.watch(globs.views, ["views"]).on("change", browserSync.reload);
  gulp.watch(globs.templates, ["templates"]).on("change", browserSync.reload);
});

gulp.task("serve", () => {
  portfinder.getPort((err, port) => {
    connect.server({
      port: port,
      base: "wordpress",
      stdio: "ignore"
    }, () => {
      browserSync.init({
        proxy: "127.0.0.1:" + port
      });
    });
  });
});

gulp.task("default", [
  "build",
  "watch",
  "serve"
]);
