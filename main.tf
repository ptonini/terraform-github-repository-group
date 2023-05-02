locals {
  base_query = "org:${var.owner} archived:false ${var.extra_query_params}"
  query      = var.language == null ? local.base_query : "${local.base_query} language:${var.language}"
}

data "github_repositories" "this" {
  for_each = toset(var.topics)
  query    = "${each.value} in:topics ${local.base_query}"
}

data "github_repository" "this" {
  for_each = toset(flatten([for t in var.topics : [for r in data.github_repositories.this[t].names : r]]))
  name     = each.value
}