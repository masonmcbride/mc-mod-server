terraform {
  required_providers {
    fly = {
      source = "fly-apps/fly"
      version = "0.0.16"
    }
  }
}

provider "fly" {}

resource "fly_app" "minecraft" {
  name = "mc-mod-server"
  org  = "personal"
}

resource "fly_ip" "mcIP" {
  app  = "mc-mod-server"
  type = "v4"

  depends_on = [fly_app.minecraft]
}

resource "fly_machine" "mcServer" {
  name   = "mc-server"
  region = "sjc"
  app    = "mc-mod-server"
  image  = "itzg/minecraft-server:latest"

  env = {
    EULA                    = "TRUE"
#    TYPE                    = "FABRIC" 
#    VERSION                 = "1.20.1"
    MEMORY                  = "7G"
    ENABLE_AUTOSTOP         = "TRUE"
    AUTOSTOP_TIMEOUT_EST    = 120
    AUTOSTOP_TIMEOUT_INIT   = 120
    MEMORY                  = "7G"
    AUTOSTOP_PKILL_USE_SUDO = "TRUE"
  }

  services = [
    {
      ports = [
        {
          port = 25565
        }
      ]
      protocol      = "tcp"
      internal_port = 25565
    }
  ]

  mounts = [
    { path   = "/data"
      volume = "vol_v88we78odzyl8n1v"
    }
  ]

  cpus     = 4
  memorymb = 8192

  depends_on = [fly_app.minecraft]
}
