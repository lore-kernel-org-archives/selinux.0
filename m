From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 09/15] [src-policy] semodule: remove base module support
Date: Tue, 26 Jan 2010 17:08:15 -0500
Message-Id: <1264543701-20638-10-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-9-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
 <1264543701-20638-2-git-send-email-ccase@tresys.com>
 <1264543701-20638-3-git-send-email-ccase@tresys.com>
 <1264543701-20638-4-git-send-email-ccase@tresys.com>
 <1264543701-20638-5-git-send-email-ccase@tresys.com>
 <1264543701-20638-6-git-send-email-ccase@tresys.com>
 <1264543701-20638-7-git-send-email-ccase@tresys.com>
 <1264543701-20638-8-git-send-email-ccase@tresys.com>
 <1264543701-20638-9-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch removes the base module flag from semodule, updates the man
page to reflect this, and has semodule output an error message if -b is
used.
---
 policycoreutils/semodule/semodule.8 |    3 ---
 policycoreutils/semodule/semodule.c |    8 ++++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 4b52a63..5fc10b3 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -32,9 +32,6 @@ install/replace a module package
 .B  \-u,\-\-upgrade=MODULE_PKG
 upgrade an existing module package, or install if the module does not exist
 .TP
-.B  \-b,\-\-base=MODULE_PKG   
-install/replace base module package
-.TP
 .B  \-r,\-\-remove=MODULE_NAME
 remove existing module
 .TP
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 569b808..c6b0d3c 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -1,8 +1,9 @@
 /* Authors: Karl MacMillan <kmacmillan@tresys.com>
  *          Joshua Brindle <jbrindle@tresys.com>
  *          Jason Tang <jtang@tresys.com>
+ *          Caleb Case <ccase@tresys.com>
  *
- * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2004-2005,2010 Tresys Technology, LLC
  *      This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License as
  *      published by the Free Software Foundation, version 2.
@@ -109,7 +110,6 @@ static void usage(char *progname)
 	printf("  -B, --build		    build and reload policy\n");
 	printf("  -i,--install=MODULE_PKG   install a new module\n");
 	printf("  -u,--upgrade=MODULE_PKG   upgrades or install module to a newer version\n");
-	printf("  -b,--base=MODULE_PKG      install new base module\n");
 	printf("  -r,--remove=MODULE_NAME   remove existing module\n");
 	printf("  -l,--list-modules=[KIND]  display list of installed modules\n");
 	printf("     KIND:  standard  list highest priority, enabled, non-base modules\n");
@@ -378,8 +378,8 @@ int main(int argc, char *argv[])
 					    ("Attempting to install base module '%s':\n",
 					     mode_arg);
 				}
-				result =
-				    semanage_module_install_base_file(sh, mode_arg);
+				fprintf(stderr, "Error: attempting to install deprecated base module.\n");
+				result = -1;
 				break;
 			}
 		case REMOVE_M:{
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
