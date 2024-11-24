extends ProgressBar

func update_health(health):
	var healthbar = $healthbar
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
