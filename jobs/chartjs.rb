SCHEDULER.every "2s" do |job|
  send_event("chart", {
  	type: "bar",
  	header: "Calories Burned",
  	labels: ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"],
  	colorNames: ["yellow", "yellow", "yellow", "yellow", "yellow"],
  	datasets: [210, 339, 220, 494, 109]
  })
end
