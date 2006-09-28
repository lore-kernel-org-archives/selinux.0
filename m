Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SLVk3Q031182
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 17:31:46 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8SLVCin006455
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 21:31:12 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] libsemanage: add genhomedircon path to semanage.conf parsing
Date: Thu, 28 Sep 2006 17:31:46 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588052618@exchange.columbia.tresys.com>
From: "James Athey" <jathey@tresys.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the ability to specify a path to genhomedircon in semanage.conf, similar to specifying a path to setfiles or load_policy.  For example:

[genhomedircon]
path = /usr/local/sbin/genhomedircon_modified
args = -t $@
[end]

Index: libsemanage/src/conf-parse.y
===================================================================
--- libsemanage/src/conf-parse.y        (revision 2032)
+++ libsemanage/src/conf-parse.y        (working copy)
@@ -1,6 +1,7 @@
-/* Author: Jason Tang     <jtang@tresys.com>
+/* Authors: Jason Tang     <jtang@tresys.com>
+ *          James Athey    <jathey@tresys.com>
  *
- * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2004-2006 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -56,7 +57,7 @@
 }

 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE
-%token LOAD_POLICY_START SETFILES_START
+%token LOAD_POLICY_START SETFILES_START GENHOMEDIRCON_START
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
@@ -137,6 +138,14 @@
                                 YYABORT;
                         }
                 }
+        |       GENHOMEDIRCON_START {
+                        semanage_conf_external_prog_destroy(current_conf->genhomedircon);
+                        current_conf->genhomedircon = NULL;
+                        if (new_external_prog(&current_conf->genhomedircon) == -1) {
+                                parse_errors++;
+                                YYABORT;
+                        }
+                }
         ;

 verify_block:   verify_start external_opts BLOCK_END  {
Index: libsemanage/src/conf-scan.l
===================================================================
--- libsemanage/src/conf-scan.l (revision 2032)
+++ libsemanage/src/conf-scan.l (working copy)
@@ -1,6 +1,7 @@
-/* Author: Jason Tang     <jtang@tresys.com>
+/* Authors: Jason Tang     <jtang@tresys.com>
+ *          James Athey    <jathey@tresys.com>
  *
- * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2004-2006 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -43,6 +44,7 @@
 file-mode         return FILE_MODE;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
+"[genhomedircon]" return GENHOMEDIRCON_START;
 "[verify module]" return VERIFY_MOD_START;
 "[verify linked]" return VERIFY_LINKED_START;
 "[verify kernel]" return VERIFY_KERNEL_START;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
