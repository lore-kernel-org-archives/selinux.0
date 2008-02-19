Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1JFmlxY025384
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 10:48:47 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1JFmkSg026848
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 15:48:46 GMT
Subject: [PATCH] invalid memory allocation in policydb_index_others()
From: "J. Tang" <jtang@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 10:48:44 -0500
Message-Id: <1203436124.31208.9.camel@venom.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is an error in libsepol's policydb_index_others().  If a policy
is lacking symbols of some kind (e.g., a policy with no booleans),
then the function will attempt a calloc() of 0, which is undefined.
The following patch checks for this condition and explicitly sets the
field upon zero symbols.

Index: libsepol/src/policydb.c
===================================================================
--- libsepol/src/policydb.c	(revision 2804)
+++ libsepol/src/policydb.c	(working copy)
@@ -820,14 +820,16 @@
 	cond_init_bool_indexes(p);
 
 	for (i = SYM_ROLES; i < SYM_NUM; i++) {
-		if (p->sym_val_to_name[i])
-			free(p->sym_val_to_name[i]);
-		p->sym_val_to_name[i] = (char **)
-		    calloc(p->symtab[i].nprim, sizeof(char *));
-		if (!p->sym_val_to_name[i])
-			return -1;
-		if (hashtab_map(p->symtab[i].table, index_f[i], p))
-			return -1;
+		free(p->sym_val_to_name[i]);
+		p->sym_val_to_name[i] = NULL;
+		if (p->symtab[i].nprim) {
+			p->sym_val_to_name[i] = (char **)
+			    calloc(p->symtab[i].nprim, sizeof(char *));
+			if (!p->sym_val_to_name[i])
+				return -1;
+			if (hashtab_map(p->symtab[i].table, index_f[i], p))
+				return -1;
+		}
 	}
 
 	/* This pre-expands the roles and users for context validity checking */


-- 
Jason Tang / jtang@tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
