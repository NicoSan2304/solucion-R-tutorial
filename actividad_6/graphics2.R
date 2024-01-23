library(highcharter)
highchart() |>
  hc_chart(
    plotBackgroundColor = NULL,
    plotBorderWidth = NULL,
    plotShadow = FALSE,
    type = "pie"
  ) |>
  
  hc_title(
    text = "U.S Solar Employment Growth",
    align = "left"
  ) |>
  
  hc_subtitle(
    text = "By Job Category.",
    align = "left"
  ) |>
  
  hc_yAxis(hc_title(
    text: "Number of Employees"
  )) |>
  
  hc_xAxis(hc_title(
    categories ="Number of Employees"
  )) |>
  
  hc_legend(
    layout = "vertical",
    align = "right",
    verticalAlign = "middle"
  ) |>
  hc_responsive(
    rules = list(
      list(
        condition = list(maxWidth = 500),
        chartOptions = list(legend = list(align = "center", verticalAlign = "bottom", layout = "horizontal")
        )
      ))
  ) |>
  hc_add_series(
    name = 'Share',
    data = list(
      list(name = "Installation & Developer", y = c(43934, 48656, 65165, 81827, 112143, 142383, 171533, 165174, 155157, 161454, 154610),
      list(name ="Manufacturing", y = c(24916, 37941, 29742, 29851, 32490, 30282,38121, 36885, 33726, 34243, 3105)),
      list(name ="Sales & Distribution", y = c(11744, 30000, 16005, 19771, 20185, 24377, 32147, 30912, 29243, 29213, 2566)),
      list(name ="Operations & Maintenance", y = c(11744, 30000, 16005, 19771, 20185, 24377, 32147, 30912, 29243, 29213, 25663)),
      list(name ="Other", y = c(0, 0, 0, 0, 0, 0, 0, 0, 11164, 11218, 10077))
    )
  )
  )