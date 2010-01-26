From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH] [src-policy] libsemanage: fix semanage_module_get_module_info export in map
Date: Tue, 26 Jan 2010 16:24:18 -0500
Message-Id: <1264541058-17845-1-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes libsemanage.map which has the wrong export line for
semanage_module_get_module_info.
---
 libsemanage/src/libsemanage.map |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 3526256..1414ce5 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -37,7 +37,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_key_get_name;
 	  semanage_module_key_set_priority;
 	  semanage_module_key_set_name;
-	  semanage_module_get_module;
+	  semanage_module_get_module_info;
 	  semanage_module_list_all;
 	  semanage_module_get_enabled;
 	  semanage_module_set_enabled;
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
