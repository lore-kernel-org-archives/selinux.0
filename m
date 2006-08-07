Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k77EpKJQ000648
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 10:51:20 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k77EpDCS008866
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 14:51:13 GMT
Subject: [PATCH 3/3] corrected return code checking
From: "Jeremy A. Mowery" <jmowery@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 07 Aug 2006 10:51:42 -0400
Message-Id: <1154962303.12897.100.camel@Bishop.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(As per Karl's request, this is a resend of this patch set.)

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
