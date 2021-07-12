<h1 align="center">squareBracket Alpha 3.5</h1>

<p align="center">
<img src="https://user-images.githubusercontent.com/60856959/123635056-798e0800-d81b-11eb-9742-5bc19a4f35a2.png"><br>
<img src="https://img.shields.io/discord/853036368712040498?style=plastic">
<img src="https://img.shields.io/github/v/release/chazizsquarebracket/squarebracket?include_prereleases&label=lastest%20released&style=plastic">
<img src="https://img.shields.io/github/release-date-pre/chazizsquarebracket/squarebracket?label=released&style=plastic">
<img src="https://img.shields.io/github/commits-since/chazizsquarebracket/squarebracket/alpha3-refresh?include_prereleases&style=plastic">
<img src="https://img.shields.io/github/repo-size/chazizsquarebracket/squarebracket?style=plastic"><br><br>
<a href="https://www.youtube.com/channel/UCMnG3eA5QcSgIPsavuW4ubA">
<img src="https://img.shields.io/youtube/channel/subscribers/UCMnG3eA5QcSgIPsavuW4ubA?style=social">
</a>
<br>
</p>

<h3 align="center"><a href="https://squarebracket.veselcraft.ru/">Live website here ></a></h3>

## How to setup squareBracket.
1. Get a web server (Apache/NGINX) with PHP and MariaDB up and running, including Composer.
1. Run `composer update` from the terminal.
1. Copy `config.sample.php`, rename it to `config.php` and fill in your database credentials.
1. Import the database dump found in `sql/` into the database you want to use.
1. Either run the `compile-scss-sassc` or `compile-scss-pscss` script available in the tools directory to generate CSS.
1. (Optional for Discord webhook functionality) Enable the cURL module in PHP.

### Production specific
1. Make the `videos/`, `templates/cache/` and `assets/thumb/` directories writable by your web server.

### Development specific
1. Disable Twig's template caching by setting `$tplNoCache` to true.
1. If you want to be able to upload videos during development, make the `videos/` and `assets/thumb/` directory writable by your web server.

## Questions

### Why is Rollerguy part of this project?
People change.

### Will my videos/comments on PokTube be on squareBracket?
Nope. We have since decided to only import users, and not any videos and comments from PokTube.

### Why not  still use the old PokTube codebase?
A lot of the code was garbage, and around the time the codebase was abandonned in favor of squareBracket, spaghetti code problems had started appearing.

### Why Twig?
Twig literally makes HTML injection attacks a thing of the past. It's more short and concise than PHP's "templating" syntax, it supports layout inheritance and it allows for more code reuse and it's versatile for creating more frontends in the future. It's secure (it treats all variables as "unsafe" and automatically escapes them unless you explicitly mark them as safe), concise (its liquid-like syntax is shorter and way more appropriate for the context of templating) and fast (with caching enabled there's basically no overhead compared to not using Twig).
