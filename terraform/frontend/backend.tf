terraform {
  cloud {
    organization = "vinmclean42"
    workspaces {
      name = "frontend"
    }
  }
}