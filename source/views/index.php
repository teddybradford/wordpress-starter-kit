<?php

if (!class_exists("Timber")) {
  echo "<div class='error'><p>Timber is not activated. Make sure you activate
    the plugin in <a href='" . esc_url(admin_url("plugins.php#timber")) . "'>
    /wp-admin/plugins.php</a>.</p></div>";
  return;
}

$context = Timber::get_context();
$context["posts"] = Timber::get_posts();

$templates = array("index.twig");

if (is_home()) {
  array_unshift($templates, "home.twig");
}

Timber::render($templates, $context);
