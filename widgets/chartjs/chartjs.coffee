class Dashing.Chartjs extends Dashing.Widget

  constructor: ->
    super
    @id = @get("id")
    @type = @get("type")
    @labels = @get("labels") && @get("labels").split(",")
    @datasets = @get("datasets") && @get("datasets").split(",")
    @colorNames = @get("colornames") && @get("colornames").split(",")

  ready: ->
    switch @type
      when 'pie', 'doughnut', 'polarArea'
        @circularChart @id, type: @type, labels: @labels, colors: @colorNames, datasets: @datasets
      when 'line', 'bar', 'radar'
        @linearChart @id, type: @type, labels: @labels, colors: @colorNames, datasets: @datasets
      else
        return

  circularChart: (id, { type, labels, colors, datasets, options={} }) ->
    data = @merge labels: labels, datasets: [@merge data: datasets, @colors(colors)]
    new Chart(document.getElementById(id), { type: type, data: data }, options)

  linearChart: (id, { type, labels, colors, datasets, options={} }) ->
    data = @merge labels: labels, datasets: [@merge(@colors(colors), data: datasets)]
    new Chart(document.getElementById(id), { type: type, data: data }, options)

  merge: (xs...) =>
    if xs?.length > 0
      @tap {}, (m) -> m[k] = v for k, v of x for x in xs

  tap: (o, fn) -> fn(o); o

  colorCode: ->
    blue: "151, 187, 205"
    cyan:  "0, 255, 255"
    darkgray: "77, 83, 96"
    gray: "148, 159, 177"
    green: "70, 191, 189"
    lightgray: "220, 220, 220"
    magenta: "255, 0, 255"
    red: "247, 70, 74"
    yellow: "253, 180, 92"

  colors: (colorNames) ->
    backgroundColor: colorNames.map (colorName) => @backgroundColor(colorName)
    borderColor: colorNames.map (colorName) => @borderColor(colorName)
    borderWidth: colorNames.map (colorName) -> 1
    pointBackgroundColor: colorNames.map (colorName) => @pointBackgroundColor(colorName)
    pointBorderColor: colorNames.map (colorName) => @pointBorderColor(colorName)
    pointHoverBackgroundColor: colorNames.map (colorName) => @pointHoverBackgroundColor(colorName)
    pointHoverBorderColor: colorNames.map (colorName) => @pointHoverBorderColor(colorName)

  backgroundColor: (colorName) -> "rgba(#{ @colorCode()[colorName] }, 0.2)"
  borderColor: (colorName) -> "rgba(#{ @colorCode()[colorName] }, 1)"
  pointBackgroundColor: (colorName) -> "rgba(#{ @colorCode()[colorName] }, 1)"
  pointBorderColor: (colorName) -> "rgba(#{ @colorCode()[colorName] }, 1)"
  pointHoverBackgroundColor: -> "fff"
  pointHoverBorderColor: (colorName) -> "rgba(#{ @colorCode()[colorName] }, 0.8)"

  circleColor: (colorName) ->
    backgroundColor: "rgba(#{ @colorCode()[colorName] }, 0.2)"
    borderColor: "rgba(#{ @colorCode()[colorName] }, 1)"
    borderWidth: 1
    hoverBackgroundColor: "#fff"
    hoverBorderColor: "rgba(#{ @colorCode()['blue'] },0.8)"
