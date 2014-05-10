module Test_Gshadow =

let conf = "root:x::
uucp:x::
sudo:x:suadmin1,suadmin2:coadmin1,coadmin2
"

test Gshadow.lns get conf =
  { "root"
    { "password" = "x" }
    { "admins" }
    { "members" } }
  { "uucp"
    { "password" = "x" }
    { "admins" }
    { "members" } }
  { "sudo"
    { "password" = "x" }
    { "admins"
      { "admin" = "suadmin1" }
      { "admin" = "suadmin2" } }
    { "members"
      { "member" = "coadmin1" }
      { "member" = "coadmin2" } } }
