resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "my-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/CloudFront", "4xxErrorRate", "DistributionId", "YOUR_DISTRIBUTION_ID", "Region", "Global"]

          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "CloudFront 4xx Error Rate"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          title  = "CloudFront Total Requests"
          view   = "timeSeries"
          region = "us-east-1"
          metrics = [
            ["AWS/CloudFront", "Requests", "DistributionId", "YOUR_DISTRIBUTION_ID", "Region", "Global"]
          ]
          stat   = "Sum"
          period = 300
        }
      }
    ]
  })
}