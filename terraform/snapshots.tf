resource "yandex_compute_snapshot_schedule" "snaps" {
  schedule_policy {
	expression = "0 2 * * *"
  }

  retention_period = "168h"

}