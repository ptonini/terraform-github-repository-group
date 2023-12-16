data "github_repositories" "this" {
  for_each = toset(var.topics)
  query    = "${each.value} in:topics org:${var.owner} archived:false ${var.extra_query_params}"
}

data "github_repository" "this" {
  for_each = toset(flatten([for t in var.topics : [for r in data.github_repositories.this[t].names : r]]))
  name     = each.value
}