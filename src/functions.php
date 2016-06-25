<?php

if (WP_DEBUG) {
  header("Access-Control-Allow-Origin: *");
}

if (!class_exists("Timber")) {
  add_action("admin_notices", function () {
    echo "<div class=\"error\"><p>Timber is not activated. Make sure you activate the plugin in
    <a href=\"" . esc_url(admin_url("plugins.php#timber")) . "\">" .
    esc_url(admin_url("plugins.php")) . "</a>.</p></div>";
  });
  return;
}

Timber::$dirname = "templates";

class MyTimberSite extends TimberSite {
  function __construct() {
    add_theme_support("post-formats");
    add_theme_support("post-thumbnails");
    add_theme_support("menus");
    add_action("init", array($this, "register_post_types"));
    add_action("init", array($this, "register_taxonomies"));
    add_action("wp_enqueue_scripts", array($this, "enqueue_scripts"));
    add_filter("timber_context", array($this, "add_to_context"));
    add_filter("get_twig", array($this, "add_to_twig"));
    parent::__construct();
  }

  function register_post_types() {
    // This is where you can register custom post types
  }

  function register_taxonomies() {
    // This is where you can register custom taxonomies
  }

  function enqueue_scripts() {
    wp_enqueue_script(
      "bundle",
      get_template_directory_uri() . "/bundle.js",
      array(),
      filemtime(get_template_directory() . "/bundle.js"),
      true
    );
  }

  function add_to_context($context) {
    $context["site"] = $this;
    $context["menu"] = new TimberMenu();
    return $context;
  }

  function add_to_twig($twig) {
    $twig->addExtension(new Twig_Extension_StringLoader());
    return $twig;
  }
}

new MyTimberSite();
