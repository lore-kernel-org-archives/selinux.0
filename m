Subject: Re: [patch 2/2] Fix memory leaks in libsepol/checkpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1123879848.23483.124.camel@moss-spartans.epoch.ncsc.mil>
References: <1123879137.23483.117.camel@moss-spartans.epoch.ncsc.mil>
	 <1123879848.23483.124.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 12:51:49 -0400
Message-Id: <1124124709.15009.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Additional memory leak fixes.  This patch for checkpolicy fixes leakage
of the id by get_local_type when the type has already been defined, and
leakage of constraint expressions (caused by my prior patch that cloned
constraint expressions to avoid pointer aliasing, so that we can use
policydb_destroy on the parse policy).

---

 module_compiler.c |    4 +++-
 policy_parse.y    |    8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

Index: checkpolicy/module_compiler.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/module_compiler.c,v
retrieving revision 1.4
diff -u -p -r1.4 module_compiler.c
--- checkpolicy/module_compiler.c	12 Aug 2005 21:10:38 -0000	1.4
+++ checkpolicy/module_compiler.c	15 Aug 2005 16:07:30 -0000
@@ -447,7 +447,9 @@ type_datum_t *get_local_type(char *id, u
                         return NULL;
                 }
   
-        }
+        } else {
+		free(id);
+	}
         return dest_typdatum;
 }
 
Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.40
diff -u -p -r1.40 policy_parse.y
--- checkpolicy/policy_parse.y	12 Aug 2005 21:10:38 -0000	1.40
+++ checkpolicy/policy_parse.y	15 Aug 2005 15:44:50 -0000
@@ -2830,6 +2830,7 @@ static int define_constraint(constraint_
 	constraint_expr_t *e;
 	unsigned int i;
 	int depth;
+	unsigned char useexpr = 1;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2906,7 +2907,12 @@ static int define_constraint(constraint_
 			return -1;
 		}
 		memset(node, 0, sizeof(constraint_node_t));
-		node->expr = constraint_expr_clone(expr);
+		if (useexpr) {
+			node->expr = expr;
+			useexpr = 0;
+		} else {
+			node->expr = constraint_expr_clone(expr);
+		}
 		if (!node->expr) {
 			yyerror("out of memory");
 			return -1;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
