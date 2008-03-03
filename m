Date: Mon, 3 Mar 2008 13:21:27 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200803031821.m23ILRte000742@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: PATH: minor checkpolicy cleanup
Cc: sds@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Minor checkpolicy cleanup.  Remove the unused DEBUG define, move
handle_unknown to checkpolicy.c and checkmodule.c since it is not used
in policy_parse.y.  Also change COND_ERR to be (avrule_t *)-1 since that
is guaranteed to not be a valid address.

This is in preparation for a much larger diff.

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

 checkmodule.c  |    2 +-
 checkpolicy.c  |    2 +-
 policy_parse.y |    6 +-----
 3 files changed, 3 insertions(+), 7 deletions(-)

Index: trunk/checkpolicy/policy_parse.y
===================================================================
--- trunk/checkpolicy/policy_parse.y	(revision 2828)
+++ trunk/checkpolicy/policy_parse.y	(working copy)
@@ -57,8 +57,7 @@
  * when we have a parse error for a conditional rule.  We can't check 
  * for NULL (ie 0) because that is a potentially valid return.
  */
-static avrule_t *conditional_unused_error_code;
-#define COND_ERR (avrule_t *)&conditional_unused_error_code
+#define COND_ERR (avrule_t *)-1
 
 #define TRUE 1
 #define FALSE 0
@@ -68,7 +67,6 @@
 static unsigned int pass;
 char *curfile = 0;
 int mlspol = 0;
-int handle_unknown = 0;
 
 extern unsigned long policydb_lineno;
 extern unsigned long source_lineno;
@@ -860,8 +858,6 @@
 	va_end(ap);
 }
 
-#define DEBUG 1
-
 static int insert_separator(int push)
 {
 	int error;
Index: trunk/checkpolicy/checkmodule.c
===================================================================
--- trunk/checkpolicy/checkmodule.c	(revision 2828)
+++ trunk/checkpolicy/checkmodule.c	(working copy)
@@ -39,8 +39,8 @@
 static sidtab_t sidtab;
 
 extern int mlspol;
-extern int handle_unknown;
 
+static int handle_unknown = SEPOL_DENY_UNKNOWN;
 static char *txtfile = "policy.conf";
 static char *binfile = "policy";
 
Index: trunk/checkpolicy/checkpolicy.c
===================================================================
--- trunk/checkpolicy/checkpolicy.c	(revision 2828)
+++ trunk/checkpolicy/checkpolicy.c	(working copy)
@@ -90,8 +90,8 @@
 
 extern policydb_t *policydbp;
 extern int mlspol;
-extern int handle_unknown;
 
+static int handle_unknown = SEPOL_DENY_UNKNOWN;
 static char *txtfile = "policy.conf";
 static char *binfile = "policy";
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
