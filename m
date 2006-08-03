Subject: [PATCH 3/2] update return code checks for callers of
	expand_*rule_helper
From: "Jeremy A. Mowery" <jmowery@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, selinux-dev@tresys.com
Content-Type: text/plain
Date: Thu, 03 Aug 2006 13:21:23 -0400
Message-Id: <1154625684.12897.52.camel@Bishop.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch applies over the previous two and replaces the hard coded 
expand_*rule_helper() != 1 with a check for EXPAND_RULE_SUCCESS.

Jeremy A. Mowery
Tresys Technology
410-290-1411 x148

Index: trunk/libsepol/src/expand.c
===================================================================
--- trunk/libsepol/src/expand.c	(revision 1020)
+++ trunk/libsepol/src/expand.c	(working copy)
@@ -1221,7 +1221,8 @@
 							  specified, cond, i, i,
 							  source_rule->perms,
 							  dest_avtab,
-							  enabled)) != 1) {
+							  enabled)) !=
+				    EXPAND_RULE_SUCCESS) {
 					return retval;
 				}
 			} else {
@@ -1233,7 +1234,8 @@
 							  other, i, i,
 							  source_rule->perms,
 							  dest_avtab,
-							  enabled)) != 1) {
+							  enabled)) !=
+				    EXPAND_RULE_SUCCESS) {
 					return retval;
 				}
 			}
@@ -1248,7 +1250,8 @@
 							  specified, cond, i, j,
 							  source_rule->perms,
 							  dest_avtab,
-							  enabled)) != 1) {
+							  enabled)) !=
+				    EXPAND_RULE_SUCCESS) {
 					return retval;
 				}
 			} else {
@@ -1260,7 +1263,8 @@
 							  other, i, j,
 							  source_rule->perms,
 							  dest_avtab,
-							  enabled)) != 1) {
+							  enabled)) !=
+				    EXPAND_RULE_SUCCESS) {
 					return retval;
 				}
 			}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
