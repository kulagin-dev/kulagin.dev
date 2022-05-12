const colors = require('tailwindcss/colors')

// NOTE: currently some classed not parsed after first time introduced, just restart hugo

module.exports = {
  content:  ["./layouts/**/*.html", "./partials/**/*.html"],
  safelist: [
    // we dynamically generate names for these classes in skill level templates
    {pattern: /bg-(secondary|lime)-\d+/}
  ],
  theme:    {
    extend:        {
      fontFamily: {
        'accent': ['PT Sans Narrow', 'sans-serif'],
        'sans':   ['PT Sans', 'sans-serif']
      },
      // https://tailwindcss.com/docs/customizing-colors
      colors: {
        // CV secondary
        secondary: colors.slate
      },
    },
    listStyleType: {
      square: 'square'
    }
  },
  plugins:  [
    // https://tailwindcss.com/docs/typography-plugin
    require('@tailwindcss/typography')
  ]
}
