# About

Repository of [my static website](https://ivan.kulagin.dev)

# TODO

**Primary**

* [ ] migrate to tailwindcss
* [ ] add lightbox for images ([this one?](https://github.com/noelboss/featherlight/))
* [ ] deploy with [Github actions](https://gohugo.io/hosting-and-deployment/hosting-on-github/)
* [ ] fix tailwind css purging in development env, we don't need that
* [ ] differentiate between [dev|prod assets processing](https://gohugo.io/hugo-pipes/postprocess/#css-purging-with-postcss) (bottom snippet)
* [x] contacts (*2015-12-24*)
* [x] instamotor about (*2015-12-24*)
* [x] thumbs links (*2015-12-24*)
* [x] get back metrics (*2015-12-24*)

  **Secondary**

* [ ] works: get rid of ``showcaseThumb`` variable, use index 0 unless defined
* [ ] screenshot captions?
* [ ] add books list
* [ ] track if [this issue](https://github.com/gohugoio/hugo/issues/9730) fixed. solved by installing `nodejs` globally with homebrew.

# Dependencies

``asdf plugin add hugo nodejs yarn``

- [Hugo](http://gohugo.io/)
- **(deprecated)** [Google Material Design Lite](http://www.getmdl.io/)

# HUGO TIPS REMINDER

- archetypes: defaults for each content type
- ``content/[content type]`` - taken from dirname or ``type`` in FM. If not set, the value is “page”.
- [Examples: Layout Lookup for Regular Pages](https://gohugo.io/templates/lookup-order/#examples-layout-lookup-for-regular-pages)
- `$` has special significance in your templates. `$` is set to the starting value of `.` (“the dot”) by default. This is a documented feature of Go text/template. This means you have access to the global context from anywhere. 
- ``{{- .Title -}}`` trim whitespace (works with ``{{- range ... -}}...{{- end --}}`` too
- [Go Templates](https://pkg.go.dev/text/template) support `{{/*` and `*/}}` to open and close a comment block. Nothing within that block will be rendered.

# package.json

- [``node-sass``/``nodejs`` versions](https://github.com/sass/node-sass#node-sass)
- ``~version``: “Approximately equivalent to version”, will update you to all future patch versions, without incrementing the minor version. ~1.2.3 will use releases from 1.2.3 to <1.3.0.
- ``^version``: “Compatible with version”, will update you to all future minor/patch versions, without incrementing the major version. ^2.3.4 will use releases from 2.3.4 to <3.0.0
