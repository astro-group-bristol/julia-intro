#import "@preview/polylux:0.3.1": *

#let SECONDARY_COLOR = rgb("#f6f0e0").lighten(90%)
#let PRIMARY_COLOR = rgb("#bf2f38")
#let TEXT_COLOR = black.lighten(13%)

#let JULIA_RED = rgb("#c93b31")
#let JULIA_PURPLE = rgb("#9158a2")
#let JULIA_GREEN = rgb("#389645")
#let JULIA_BLUE = rgb("#4063d8")

#let tamburlaine-theme(aspect-ratio: "4-3", body) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    fill: SECONDARY_COLOR,
    margin: 1em
  )
  set text(fill: TEXT_COLOR, size: 25pt, font: "Montserrat")
  body
}

#let juliafy(string) = {
  let colors = (JULIA_RED, JULIA_GREEN, JULIA_PURPLE, JULIA_BLUE)
  string.split().enumerate().map(item => {
    let (i, t) = item
    text(fill: colors.at(calc.rem(i, colors.len())), t)
  }).join(" ")
}

#let title-slide(
  title: none,
  authors: (),
  where: none,
  date: datetime.today(),
) = {
  set page(
    fill: SECONDARY_COLOR,
    margin: 1em,
  )
  set text(fill: TEXT_COLOR, weight: "bold")

  let author = authors.join(h(1em))

  logic.polylux-slide[
    #rect(inset:(top: 1em), width:100%, height: 74%, stroke:none)[
      #align(right)[
          #title
      ]
    ]
    #v(-0.6em)

    #line(length: 100%, stroke: 5mm + TEXT_COLOR)
    #v(-0.5em)
    #grid(
      columns: (70%, 30%),
      row-gutter: 15pt,
      author,
      move(dx:0.2em, where),
      align(left, text(size: 20pt, weight: "regular")[University of Bristol]),
      align(right, text(size: 20pt, weight: "regular",
      date.display("[day] [month repr:long] [year]")
      )),
    )
    #v(-0.1em)
    #line(length: 100%, stroke: 8mm + TEXT_COLOR)
  ]
}

// eh good enough
#let global_date = datetime(year: 2024, month: 4, day: 26)

#let slide(title: none, title-size: 50pt,body) = {
  set page(
    fill: SECONDARY_COLOR,
    margin: (top: 1em, bottom: 1.5em, left: 1em, right: 1em)
  )
  let header = align(top, locate( loc => {
    set text(size: 20pt)
    grid(
    columns: (1fr, 1fr),
      align(horizon + right, grid(
        columns: 1, rows: 1em,
        title,
        utils.current-section,
      ))
    )
  }))

  let footer = locate( loc => {
    block(
      stroke: ( top: 1mm + TEXT_COLOR ), width: 100%, inset: ( y: .4em ),
      text(.5em, {
        "Fergus Baker"
        h(2em)
        "/"
        h(2em)
        "Astro Dev Group"
        h(2em)
        "/"
        h(2em)
        global_date.display("[day] [month repr:long] [year]")
        h(1fr)
        logic.logical-slide.display()
      })
    )
  })

  set page(
    footer: footer,
    footer-descent: 0em,
    header-ascent: 1.5em,
  )

  let content = {
    block(spacing: 0.0em, text(size: title-size, weight: "black", juliafy(title)))
    body
  }

  logic.polylux-slide(content)
}

