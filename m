Subject: [PATCH] checkpolicy policy version warnings
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-bqbzpEd5gAEwoVHjwRrP"
Date: Thu, 22 Sep 2005 16:49:50 -0400
Message-Id: <1127422190.21806.34.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-bqbzpEd5gAEwoVHjwRrP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

These patches add a global is_building_modules variable to checkmodule,
checkpolicy and the parser. It is used to determine whether a kernel
policy is being built so that NETLINK class warnings are only caused
when building a kernel policy. This will also be necessary to know whether
policycon statements are allowed (for the policy server).

Joshua Brindle

--=-bqbzpEd5gAEwoVHjwRrP
Content-Disposition: attachment; filename=1-checkmodule-policyver.patch
Content-Type: text/x-patch; name=1-checkmodule-policyver.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- checkpolicy/checkmodule.c	2005-09-22 09:41:18.000000000 -0400
+++ checkpolicy/checkmodule.c	2005-09-21 11:27:28.000000000 -0400
@@ -49,8 +49,10 @@ static char *txtfile = "policy.conf";
 static char *binfile = "policy";
 
 unsigned int policy_type = POLICY_BASE;
-unsigned int policyvers = POLICYDB_VERSION_MAX;
+unsigned int policyvers = MOD_POLICYDB_VERSION_MAX;
 unsigned int mlspol = 0;
+/* always set to 0 for checkpolicy, set to 1 for checkmodule */
+unsigned int is_building_modules = 1;
 
 static int read_binary_policy(policydb_t *p, char *file, char *progname)
 {
--- checkpolicy/checkpolicy.c	2005-09-22 09:41:18.000000000 -0400
+++ checkpolicy/checkpolicy.c	2005-09-21 11:27:28.000000000 -0400
@@ -103,6 +103,9 @@ static char *binfile = "policy";
 unsigned int policyvers = POLICYDB_VERSION_MAX;
 unsigned int mlspol = 0;
 
+/* always set to 0 for checkpolicy, set to 1 for checkmodule */
+unsigned int is_building_modules = 0;
+
 void usage(char *progname)
 {
 	printf("usage:  %s [-b] [-d] [-M] [-c policyvers (%d-%d)] [-o output_file] [input_file]\n",

--=-bqbzpEd5gAEwoVHjwRrP
Content-Disposition: attachment; filename=2-parse-modulever.patch
Content-Type: text/x-patch; name=2-parse-modulever.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- checkpolicy/policy_parse.y	2005-09-22 09:41:18.000000000 -0400
+++ checkpolicy/policy_parse.y	2005-09-22 10:10:37.000000000 -0400
@@ -70,6 +70,7 @@ extern unsigned long policydb_lineno;
 extern unsigned long source_lineno;
 extern unsigned int policydb_errors;
 extern unsigned int policyvers;
+extern int is_building_modules;
 
 extern char yytext[];
 extern int yylex(void);
@@ -2006,7 +2007,8 @@ static int define_compute_type_helper(in
 			yyerror(errormsg);
 			goto bad;
 		}
-                if (policyvers < POLICYDB_VERSION_NLCLASS &&
+                if (!is_building_modules &&
+                    policyvers < POLICYDB_VERSION_NLCLASS &&
 		    (cladatum->value >= SECCLASS_NETLINK_ROUTE_SOCKET &&
 		     cladatum->value <= SECCLASS_NETLINK_DNRT_SOCKET)) {
 			sprintf(errormsg, "remapping class %s to netlink_socket "
@@ -2270,7 +2272,8 @@ static int define_te_avtab_helper(int wh
 			ret = -1;
 			goto out;
 		}
-                if (policyvers < POLICYDB_VERSION_NLCLASS &&
+                if (!is_building_modules &&
+                    policyvers < POLICYDB_VERSION_NLCLASS &&
 		    (cladatum->value >= SECCLASS_NETLINK_ROUTE_SOCKET &&
 		     cladatum->value <= SECCLASS_NETLINK_DNRT_SOCKET)) {
 			sprintf(errormsg, "remapping class %s to netlink_socket "

--=-bqbzpEd5gAEwoVHjwRrP--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
