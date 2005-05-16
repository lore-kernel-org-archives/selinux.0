Subject: Re: Busted by constraints.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1115996428.3576.47.camel@moss-spartans.epoch.ncsc.mil>
References: <428368FF.2080603@redhat.com>
	 <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>
	 <42836C4C.6010301@redhat.com>
	 <1115996428.3576.47.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-kLv52dhPaPTemHdPPXrV"
Date: Mon, 16 May 2005 14:44:55 -0400
Message-Id: <1116269095.28782.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-kLv52dhPaPTemHdPPXrV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-05-13 at 11:00 -0400, Stephen Smalley wrote:
> Ok, just committed the two attached patches for libsepol and
> policycoreutils to introduce an audit2why utility.  A sample of the
> output of audit2why is below from running:
> $ /usr/sbin/audit2why < /var/log/audit/audit.log
> 
> type=KERNEL msg=audit(1115316525.803:399552): avc:  denied  { getattr } for  path=/home/sds dev=hda5 ino=1175041 scontext=root:secadm_r:secadm_t:s0-s9:c0.c127 tcontext=user_u:object_r:user_home_dir_t:s0 tclass=dir
> 	Was caused by:
> 		Missing TE allow rule for the type pair (use audit2allow).
> 
> type=KERNEL msg=audit(1115320071.648:606858): avc:  denied  { append } for  name=.bash_history dev=hda5 ino=1175047 scontext=user_u:user_r:user_t:s1-s9:c0.c127 tcontext=user_u:object_r:user_home_t:s0 tclass=file
> 	Was caused by:
> 		Constraint violation (add type attribute to domain to satisfy constraints or alter constraint).

Further patches to libsepol and audit2why so that audit2why can handle
boolean settings and local user definitions properly.

-- 
Stephen Smalley
National Security Agency

--=-kLv52dhPaPTemHdPPXrV
Content-Disposition: attachment; filename=libsepol.patch
Content-Type: text/x-patch; name=libsepol.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsepol/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/ChangeLog,v
retrieving revision 1.29
diff -u -p -r1.29 ChangeLog
--- libsepol/ChangeLog	13 May 2005 19:38:06 -0000	1.29
+++ libsepol/ChangeLog	16 May 2005 18:21:50 -0000
@@ -1,3 +1,7 @@
+1.5.9 2005-05-16
+	* Added sepol_genbools_policydb and sepol_genusers_policydb for
+	  audit2why.
+
 1.5.8 2005-05-13
 	* Added sepol_ prefix to Flask types to avoid 
 	  namespace collision with libselinux.
Index: libsepol/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/VERSION,v
retrieving revision 1.24
diff -u -p -r1.24 VERSION
--- libsepol/VERSION	13 May 2005 19:38:06 -0000	1.24
+++ libsepol/VERSION	16 May 2005 18:21:00 -0000
@@ -1 +1 @@
-1.5.8
+1.5.9
Index: libsepol/libsepol.spec
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/libsepol.spec,v
retrieving revision 1.26
diff -u -p -r1.26 libsepol.spec
--- libsepol/libsepol.spec	13 May 2005 19:38:06 -0000	1.26
+++ libsepol/libsepol.spec	16 May 2005 18:21:03 -0000
@@ -1,6 +1,6 @@
 Summary: SELinux binary policy manipulation library 
 Name: libsepol
-Version: 1.5.8
+Version: 1.5.9
 Release: 1
 License: GPL
 Group: System Environment/Libraries
Index: libsepol/include/sepol/policydb.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/policydb.h,v
retrieving revision 1.8
diff -u -p -r1.8 policydb.h
--- libsepol/include/sepol/policydb.h	13 May 2005 19:38:13 -0000	1.8
+++ libsepol/include/sepol/policydb.h	16 May 2005 17:33:49 -0000
@@ -263,6 +263,8 @@ extern int policydb_index_bools(policydb
 
 extern int policydb_index_others(policydb_t * p, unsigned int verbose);
 
+extern int policydb_reindex_users(policydb_t * p);
+
 extern int constraint_expr_destroy(constraint_expr_t * expr);
 
 extern void policydb_destroy(policydb_t * p);
Index: libsepol/include/sepol/services.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/services.h,v
retrieving revision 1.5
diff -u -p -r1.5 services.h
--- libsepol/include/sepol/services.h	13 May 2005 19:38:13 -0000	1.5
+++ libsepol/include/sepol/services.h	16 May 2005 17:33:49 -0000
@@ -25,6 +25,13 @@
 extern int sepol_set_policydb(policydb_t *p);
 extern int sepol_set_sidtab(sidtab_t *s);
 
+/* Modify a policydb for boolean settings. */
+int sepol_genbools_policydb(policydb_t *policydb, const char *booleans);
+
+/* Modify a policydb for user settings. */
+int sepol_genusers_policydb(policydb_t *policydb,
+			    const char *usersdir);
+
 /* Load the security policy. This initializes the policydb
    and sidtab based on the provided binary policy. */
 int sepol_load_policy(void * data, size_t len);
Index: libsepol/src/genbools.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/genbools.c,v
retrieving revision 1.13
diff -u -p -r1.13 genbools.c
--- libsepol/src/genbools.c	25 Apr 2005 19:55:30 -0000	1.13
+++ libsepol/src/genbools.c	16 May 2005 17:33:49 -0000
@@ -52,7 +52,7 @@ static int process_boolean(char *buffer,
 	return 1;
 }
 
-static int load_booleans(struct policydb *policydb, char *path) {
+static int load_booleans(struct policydb *policydb, const char *path) {
 	FILE *boolf;
 	char *buffer=NULL;
 	size_t size=0;
@@ -64,7 +64,7 @@ static int load_booleans(struct policydb
 
 	boolf = fopen(path,"r");
 	if (boolf == NULL) 
-		return -1;
+		goto localbool;
 
 	while (getline(&buffer, &size, boolf) > 0) {
 		int ret=process_boolean(buffer, name, sizeof(name), &val);
@@ -81,6 +81,7 @@ static int load_booleans(struct policydb
 		}
 	}
 	fclose(boolf);
+localbool:
 	snprintf(localbools,sizeof(localbools), "%s.local", path);
 	boolf = fopen(localbools,"r");
 	if (boolf != NULL) {
@@ -157,6 +158,18 @@ int sepol_genbools(void *data, size_t le
 	return -1;
 }
 
+int sepol_genbools_policydb(policydb_t *policydb, const char *booleans)
+{
+	int rc;
+
+	rc = load_booleans(policydb, booleans);
+	if (!rc)
+		rc = evaluate_conds(policydb);
+	if (rc)
+		errno = EINVAL;
+	return rc;
+}
+
 int sepol_genbools_array(void *data, size_t len, char **names, int *values, int nel)
 {
 	struct policydb policydb;
Index: libsepol/src/genusers.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/genusers.c,v
retrieving revision 1.11
diff -u -p -r1.11 genusers.c
--- libsepol/src/genusers.c	13 Apr 2005 14:30:18 -0000	1.11
+++ libsepol/src/genusers.c	16 May 2005 17:34:14 -0000
@@ -444,3 +444,34 @@ err:
 	policydb_destroy(&policydb);
 	return -1;
 }
+
+int sepol_genusers_policydb(policydb_t *policydb,
+			    const char *usersdir)
+{
+	char path[PATH_MAX];
+
+	/* Load base set of system users from the policy package. */
+	snprintf(path, sizeof path, "%s/system.users", usersdir);
+	if (load_users(policydb, path) < 0) {
+		__sepol_debug_printf("%s: Can't load system.users:  %s\n",
+				     __FUNCTION__, strerror(errno));
+		return -1;
+	}
+
+	/* Load locally defined users. */
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+	if (load_users(policydb, path) < 0) {
+		__sepol_debug_printf("%s:  Can't load local.users:  %s\n",
+				     __FUNCTION__, strerror(errno));
+		return -1;
+	}
+
+	if (policydb_reindex_users(policydb) < 0) {
+		__sepol_debug_printf("%s:  Can't reindex users:  %s\n",
+				     __FUNCTION__, strerror(errno));
+		return -1;
+
+	}
+
+	return 0;
+}
Index: libsepol/src/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/policydb.c,v
retrieving revision 1.8
diff -u -p -r1.8 policydb.c
--- libsepol/src/policydb.c	17 Feb 2005 14:59:27 -0000	1.8
+++ libsepol/src/policydb.c	16 May 2005 17:38:29 -0000
@@ -440,7 +440,6 @@ int policydb_index_others(policydb_t * p
 	return 0;
 }
 
-
 /*
  * The following *_destroy functions are used to
  * free any memory allocated for each kind of
@@ -1733,5 +1732,30 @@ bad:
 	return -1;
 }
 
+int policydb_reindex_users(policydb_t * p)
+{
+	unsigned int i = SYM_USERS;
+
+	if (p->user_val_to_struct)
+		free(p->user_val_to_struct);
+	if (p->sym_val_to_name[i])
+		free(p->sym_val_to_name[i]);
+
+	p->user_val_to_struct = (user_datum_t **)
+	    malloc(p->p_users.nprim * sizeof(user_datum_t *));
+	if (!p->user_val_to_struct)
+		return -1;
+
+	p->sym_val_to_name[i] = (char **)
+		malloc(p->symtab[i].nprim * sizeof(char *));
+	if (!p->sym_val_to_name[i])
+		return -1;
+
+	if (hashtab_map(p->symtab[i].table, index_f[i], p))
+		return -1;
+
+	return 0;
+}
+
 
 

--=-kLv52dhPaPTemHdPPXrV
Content-Disposition: attachment; filename=policycoreutils.patch
Content-Type: text/x-patch; name=policycoreutils.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/ChangeLog,v
retrieving revision 1.114
diff -u -p -r1.114 ChangeLog
--- policycoreutils/ChangeLog	13 May 2005 19:41:30 -0000	1.114
+++ policycoreutils/ChangeLog	16 May 2005 18:23:47 -0000
@@ -1,3 +1,7 @@
+1.23.10 2005-05-16
+	* Extended audit2why to incorporate booleans and local user 
+	  settings when analyzing audit messages.
+
 1.23.9 2005-05-13
 	* Updated audit2why for sepol_ prefixes on Flask types to
 	  avoid namespace collision with libselinux, and to 
Index: policycoreutils/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/VERSION,v
retrieving revision 1.53
diff -u -p -r1.53 VERSION
--- policycoreutils/VERSION	13 May 2005 19:41:30 -0000	1.53
+++ policycoreutils/VERSION	16 May 2005 18:23:04 -0000
@@ -1 +1 @@
-1.23.9
+1.23.10
Index: policycoreutils/policycoreutils.spec
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/policycoreutils.spec,v
retrieving revision 1.76
diff -u -p -r1.76 policycoreutils.spec
--- policycoreutils/policycoreutils.spec	13 May 2005 19:41:30 -0000	1.76
+++ policycoreutils/policycoreutils.spec	16 May 2005 18:23:02 -0000
@@ -1,6 +1,6 @@
 Summary: SELinux policy core utilities.
 Name: policycoreutils
-Version: 1.23.9
+Version: 1.23.10
 Release: 1
 License: GPL
 Group: System Environment/Base
Index: policycoreutils/audit2why/audit2why.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/audit2why/audit2why.c,v
retrieving revision 1.2
diff -u -p -r1.2 audit2why.c
--- policycoreutils/audit2why/audit2why.c	13 May 2005 19:41:37 -0000	1.2
+++ policycoreutils/audit2why/audit2why.c	16 May 2005 18:25:16 -0000
@@ -36,6 +36,9 @@ int main(int argc, char **argv) 
 	struct sepol_av_decision avd;
 	unsigned int reason;
 	int vers = 0;
+	sidtab_t sidtab;
+	policydb_t policydb;
+	struct policy_file pf;
 
 	while ((opt = getopt(argc, argv, "p:?h")) > 0) {
 		switch (opt) {
@@ -63,6 +66,10 @@ int main(int argc, char **argv) 
 			exit(1);
 		}
 		vers = security_policyvers();
+		if (vers < 0) {
+			fprintf(stderr, "%s:  Could not get policy version:  %s\n", argv[0], strerror(errno));
+			exit(1);
+		}
 		snprintf(path, PATH_MAX, "%s.%d", 
 			 selinux_binary_policy_path(), vers);
 		fp = fopen(path, "r");
@@ -80,14 +87,44 @@ int main(int argc, char **argv) 
 		}
 	}
 
-	rc = sepol_set_policydb_from_file(fp);
-	if (rc < 0) {
-		fprintf(stderr, "%s:  unable to load policy from %s:  %s\n",
-			argv[0], path, strerror(errno));
+	/* Set up a policydb directly so that we can mutate it later
+	   for booleans and user settings.  Otherwise we would just use
+	   sepol_set_policydb_from_file() here. */
+	pf.fp = fp;
+	pf.type = PF_USE_STDIO;
+	if (policydb_read(&policydb, &pf, 0)) {
+		fprintf(stderr, "%s:  invalid binary policy %s\n",
+			argv[0], path);
 		exit(1);
 	}
 	fclose(fp);
-	
+	sepol_set_policydb(&policydb);
+
+	if (!set_path) {
+		/* If they didn't specify a full path of a binary policy file,
+		   then also try loading any boolean settings and user
+		   definitions from the active locations.  Otherwise,
+		   they can use genpolbools and genpolusers to build a
+		   binary policy file that includes any desired settings
+		   and then apply audit2why -p to the resulting file. 
+		   Errors are non-fatal as such settings are optional. */
+		sepol_debug(0);
+		(void)sepol_genbools_policydb(&policydb, selinux_booleans_path());
+		(void)sepol_genusers_policydb(&policydb, selinux_users_path());
+	}
+
+
+	/* Initialize the sidtab for subsequent use by sepol_context_to_sid
+	   and sepol_compute_av_reason. */
+	rc = sepol_sidtab_init(&sidtab);
+	if (rc < 0) {
+		fprintf(stderr, "%s:  unable to init sidtab\n",
+			argv[0]);
+		exit(1);
+	}
+	sepol_set_sidtab(&sidtab);
+
+	/* Process the audit messages. */
 	while (getline(&buffer, &len, stdin) > 0) {
 		size_t len2 = strlen(buffer);
 
@@ -212,16 +249,31 @@ int main(int argc, char **argv) 
 			continue;
 		}
 
-		if (!reason)
-			continue; /* Denial would not occur under specified policy. */
-
 		printf("%s\n\tWas caused by:\n", bufcopy);
-		if (reason & SEPOL_COMPUTEAV_TE)
-			printf("\t\tMissing TE allow rule for the type pair (use audit2allow).\n");
-		if (reason & SEPOL_COMPUTEAV_CONS)
-			printf("\t\tConstraint violation (add type attribute to domain to satisfy constraints or alter constraint).\n");
-		if (reason & SEPOL_COMPUTEAV_RBAC)
-			printf("\t\tMissing role allow rule for the role pair (add role allow rule).\n");
+
+		if (!reason) {
+			printf("\t\tUnknown - would be allowed by %s policy\n", set_path ? "specified" : "active");
+			printf("\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n");
+			printf("\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n");
+		}
+
+		if (reason & SEPOL_COMPUTEAV_TE) {
+			printf("\t\tMissing or disabled TE allow rule.\n");
+			printf("\t\tAllow rules may exist but be disabled by boolean settings; check boolean settings.\n");
+			printf("\t\tYou can see the necessary allow rules by running audit2allow with this audit message as input.\n");
+		}
+
+		if (reason & SEPOL_COMPUTEAV_CONS) {
+			printf("\t\tConstraint violation.\n");
+			printf("\t\tCheck policy/constraints.\n");
+			printf("\t\tTypically, you just need to add a type attribute to the domain to satisfy the constraint.\n");
+		}
+
+		if (reason & SEPOL_COMPUTEAV_RBAC) {
+			printf("\t\tMissing role allow rule.\n");
+			printf("\t\tAdd allow rule for the role pair.\n");
+		}
+
 		printf("\n");
 	}
 	free(buffer);

--=-kLv52dhPaPTemHdPPXrV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
