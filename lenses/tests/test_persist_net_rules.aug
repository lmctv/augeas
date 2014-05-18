(* Test for Persist_Net_Rules module *)
module Test_persist_net_rules = 

let rules_static = "# My ethernet fake card - with a locally administered address
SUBSYSTEM==\"net\", ACTION==\"add\", DRIVERS==\"?*\", ATTR{address}==\"06:ff:66:cf:db:54\", ATTR{dev_id}==\"0x0\", ATTR{type}==\"1\", KERNEL==\"eth*\", NAME=\"fketh0\"
"

test Persist_Net_Rules.lns get rules_static =
  { "#comment" = "My ethernet fake card - with a locally administered address" }
  { "fketh0"
    { "SUBSYSTEM" = "net" }
    { "ACTION" = "add" }
    { "DRIVERS" = "?*" }
    { "ATTR{address}" = "06:ff:66:cf:db:54" }
    { "ATTR{dev_id}" = "0x0" }
    { "ATTR{type}" = "1" }
    { "KERNEL" = "eth*" }
  }
