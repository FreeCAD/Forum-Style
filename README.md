# Forum-Style

The phpBB styles and shared static assets for the FreeCAD forum at https://forum.freecad.org.

## Layout

This repo is laid out so that it matches as closely as possible the actual on-disk deployment needed for [phpBB][phpbb] (the software running the forum).

| Path | Deployed as | Contents |
|---|---|---|
| `styles/freecad/` | `styles/freecad/` in the phpBB root | the `FreeCAD` style (light), child of `prosilver` |
| `styles/freecad-dark/` | `styles/freecad-dark/` in the phpBB root | the `FreeCAD-Dark` style, child of `prosilver` |
| `freecad-assets/` | `freecad-assets/` in the phpBB root, served at `/freecad-assets/` | Bootstrap 3.3.5 CSS and JS, the site fonts, `freecad.css`, and the favicons, shared by both styles |

## History

The styles were previously tracked in [FreeCAD-Homepage](https://github.com/FreeCAD/FreeCAD-Homepage) under `themes/forum/styles`, but the files running on the live forum had since been edited in place. This repository starts from the files that were live on the forum in October 2026, with three differences: files that nothing referenced were left out (Font Awesome 4.3.0, unused logo images including the pre-2024 FreeCAD logo, two unused fonts in the dark style, and the ColorizeIt tool's configuration files), the header logo was replaced by the equivalent wordmark from the FPA's official logo kit so that its source is known, and GLYPHICONS PRO is excluded (see below). `freecad-assets/` holds copies of files the styles used to load from `www.freecad.org`; the only change from those is that `css/freecad.css` refers to its fonts by relative paths (`../fonts/...`) so that they resolve inside `freecad-assets/`.

## Making Changes

Please submit changes as normal pull requests to this repo. Changes reach the forum only when a project Maintainer or forums manager explicitly runs the deployment workflow. There is (currently) no staging or test server available, all changes go directly to the live forum.

## Not in this repository: GLYPHICONS PRO

Both styles load the GLYPHICONS PRO icon font from `theme/fonts/glyphicons-pro-1.9.2/` (the headers load its CSS, and `theme/stylesheet.css` uses the `Glyphicons Regular` font family). GLYPHICONS PRO is commercially licensed, and its license forbids offering the icons for download, so those files are not in this repository and are listed in `.gitignore`. They exist only on the forum server, and the deployment leaves them in place. Replacing them with a freely licensed icon font (Font Awesome is already included in both styles) would remove this exception.

## License

The repository as a whole is distributed under the GNU General Public License, version 2 (see [LICENSE](LICENSE)), the license of the phpBB templates the styles derive from. It includes third-party components under their own licenses:

| Component | Path | License |
|---|---|---|
| phpBB `prosilver`-derived templates and theme | `styles/*/template/`, `styles/*/theme/` | GPL-2.0 ([phpBB][phpbb]) |
| Elegance style by Vjacheslav Trushkin, on which both styles are based | `styles/*/` | BSD-2-Clause, © 2015 Vjacheslav Trushkin; see `styles/*/license.txt`, which excludes `theme/fonts/` |
| FreeCAD's changes and additions to both styles (by Yorik van Havre and others), including `styles/freecad-dark/theme/freecad.css` | `styles/*/` | previously published under the LGPL-2.1 in [FreeCAD-Homepage][homepage]; distributed here under the GPL-2.0, as section 3 of the LGPL-2.1 permits |
| Font Awesome 4.5.0 | `styles/*/theme/fonts/font-awesome-4.5.0/` | font: SIL OFL 1.1 (`OFL.txt`); CSS: MIT (`MIT.txt`); © 2015 Dave Gandy |
| Bootstrap 3.3.5 | `freecad-assets/css/bootstrap-3.3.5.min.css`, `freecad-assets/js/bootstrap-3.3.5.min.js` | MIT, © 2011-2015 Twitter, Inc.; see `freecad-assets/LICENSE-Bootstrap.txt` |
| GLYPHICONS Halflings font, as included in Bootstrap 3.3.5 | `freecad-assets/fonts/glyphicons-halflings-regular.*` | © 2014 Jan Kovařík; made available by its author for Bootstrap free of cost, under Bootstrap's license |
| Fira Sans | `freecad-assets/fonts/FiraSans-Regular.*` | SIL OFL 1.1, © 2012-2014 The Mozilla Foundation and Telefonica S.A.; see `freecad-assets/fonts/OFL.txt` |
| Evolventa | `freecad-assets/fonts/Evolventa-*` | © 2016 Alex I. Kuznetsov, under the GPL-2.0 or the LaTeX Project Public License 1.3c or later at the recipient's choice; distributed here under the GPL-2.0 ([LICENSE](LICENSE)). Contains URW Gothic L, released by URW++ Design and Development GmbH |
| `freecad.css`, from [FreeCAD-Homepage][homepage] | `freecad-assets/css/freecad.css` | LGPL-2.1 (the FreeCAD-Homepage license) |
| FreeCAD wordmark and favicons, from the FPA's official logo kit | `styles/*/theme/images/FreeCAD-wordmark-light.svg`, `freecad-assets/images/` | The FreeCAD logo is a registered trademark of the FreeCAD project association AISBL, used here for an official FPA project as described in the [FreeCAD brand guidelines][brand]. Not covered by the repository's GPL-2.0 license. |

[phpbb]: https://www.phpbb.com/
[homepage]: https://github.com/FreeCAD/FreeCAD-Homepage
[brand]: https://fpa.freecad.org/handbook/process/logo.html
