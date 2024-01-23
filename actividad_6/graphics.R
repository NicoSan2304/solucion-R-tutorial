library(highcharter)
highchart() |>
  hc_chart(
    plotBackgroundColor = NULL,
    plotBorderWidth = NULL,
    plotShadow = FALSE,
    type = 'pie'
  ) |>
  hc_title(
    text = 'Browser market shares in February, 2022',
    align = 'left'
  ) |>
  hc_tooltip(
    pointFormat = '{series.name}: <b>{point.percentage:.1f}%</b>'
  ) |>
  hc_plotOptions(
    pie = list(
      allowPointSelect = TRUE,
      cursor = 'pointer',borderRadius = 5,
      dataLabels = list(
        enabled = TRUE,
        format = '<b>{point.name}</b><br>{point.percentage:.1f} %',
        distance = -50,
        filter = list(
          property = 'percentage',
          operator = '>',
          value = 4
        )
      )
    )
  ) |>
  hc_add_series(
    name = 'Share',
    data = list(
      list(name = 'Chrome', y = 74.03),
      list(name ='Edge', y = 12.66),
      list(name ='Firefox', y = 4.96),
      list(name ='Safari', y = 2.49),
      list(name ='Internet Explorer', y = 2.31),
      list(name ='Other', y = 3.398 )
    )
  )
