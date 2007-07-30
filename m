Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6UJ8YIm012181
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 15:08:34 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6UJ8XT4019337
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 19:08:34 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6UJ8XfS027110
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 15:08:33 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6UJ8WwM000643
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 15:08:32 -0400
Received: from [10.11.231.215] (dhcp231-215.rdu.redhat.com [10.11.231.215])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6UJ8VeU006229
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 15:08:32 -0400
Subject: [PATCHES] kernel: checkpolicy: libsepol: allow unknown
	classes/perms in kernel
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-FvmWsaqN6AR6Zvlp6bel"
Date: Mon, 30 Jul 2007 15:08:26 -0400
Message-Id: <1185822506.3727.16.camel@dhcp231-215.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-FvmWsaqN6AR6Zvlp6bel
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

After many months its back!  Allow the base policy module to tell the
kernel how it should handle policies which do not define all of the
classes and permissions the kernel knows about.

0 = deny security checks for which policy has no knowledge (default)
1 = reject loading any policy which does not define all classes/perms
2 = all security check for which policy has no knowledge

The biggest place this is relevant is for the times when people upgrade
their kernel but don't upgrade their policy.  I'd expect most users of
the default targeted policy would rather allow unknown security checks
than deny them and users with custom policy would rather deny or reject
the policy based on their security requirements.

To make the setting one uses checkmodule (or checkpolicy for monolithic)
with the -U option which building the base.mod.

Patches below to kernel, checkpolicy, and libsepol.  I remember there
were comments on my libsepol posting months ago but i kinda forgot them
and couldn't find the mail so it's largely the same.

-Eric

--=-FvmWsaqN6AR6Zvlp6bel
Content-Disposition: attachment; filename=libsepol-handle-unknown.patch
Content-Type: text/x-patch; name=libsepol-handle-unknown.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naupr libsepol-2.0.3/include/sepol/policydb/policydb.h libsepol-2.0.3.handle_unknown/include/sepol/policydb/policydb.h
--- libsepol-2.0.3/include/sepol/policydb/policydb.h	2007-04-17 08:34:08.000000000 -0400
+++ libsepol-2.0.3.handle_unknown/include/sepol/policydb/policydb.h	2007-04-27 15:29:30.000000000 -0400
@@ -469,6 +469,8 @@ typedef struct policydb {
 	ebitmap_t *attr_type_map;	/* not saved in the binary policy */
 
 	unsigned policyvers;
+
+	unsigned handle_unknown;
 } policydb_t;
 
 struct sepol_policydb {
@@ -599,6 +601,15 @@ extern int policydb_write(struct policyd
 
 #define POLICYDB_CONFIG_MLS    1
 
+/* the config flags related to unknown classes/perms are bits 2 and 3 */
+#define POLICYDB_CONFIG_UNKNOWN_MASK   6
+#define POLICYDB_CONFIG_UNKNOWN_SHIFT  1
+
+enum policy_with_unknown_perms {
+	 DENY_UNKNOWN = 0,
+	 REJECT_UNKNOWN = 1,
+	 ALLOW_UNKNOWN = 2
+};
 #define OBJECT_R "object_r"
 #define OBJECT_R_VAL 1
 
--- libsepol-2.0.3/src/policydb.c	2007-04-17 08:34:08.000000000 -0400
+++ libsepol-2.0.3.handle_unknown/src/policydb.c	2007-05-02 14:35:13.000000000 -0400
@@ -3057,6 +3057,9 @@ int policydb_read(policydb_t * p, struct
 		p->mls = 0;
 	}
 
+	p->handle_unknown = buf[bufindex] & POLICYDB_CONFIG_UNKNOWN_MASK;
+	p->handle_unknown >>= POLICYDB_CONFIG_UNKNOWN_SHIFT;
+
 	bufindex++;
 
 	info = policydb_lookup_compat(r_policyvers, policy_type);
diff -Naupr libsepol-2.0.3/src/write.c libsepol-2.0.3.handle_unknown/src/write.c
--- libsepol-2.0.3/src/write.c	2007-04-17 08:34:08.000000000 -0400
+++ libsepol-2.0.3.handle_unknown/src/write.c	2007-04-27 15:41:17.000000000 -0400
@@ -1533,6 +1533,9 @@ int policydb_write(policydb_t * p, struc
 	config = 0;
 	if (p->mls)
 		config |= POLICYDB_CONFIG_MLS;
+	i = POLICYDB_CONFIG_UNKNOWN_MASK & (p->handle_unknown << POLICYDB_CONFIG_UNKNOWN_SHIFT);
+	if (i)
+		config |= i;
 
 	/* Write the magic number and string identifiers. */
 	items = 0;
--- libsepol-2.0.4/src/expand.c	2007-06-21 05:17:01.000000000 -0400
+++ /tmp/expand.c	2007-07-27 15:58:55.000000000 -0400
@@ -2248,6 +2248,7 @@ int expand_module(sepol_handle_t * handl
 
 	/* Copy mls state from base to out */
 	out->mls = base->mls;
+	out->handle_unknown = base->handle_unknown;
 
 	if ((state.typemap =
 	     (uint32_t *) calloc(state.base->p_types.nprim,

--=-FvmWsaqN6AR6Zvlp6bel
Content-Disposition: attachment; filename=checkpolicy-handle-unknown.patch
Content-Type: text/x-patch; name=checkpolicy-handle-unknown.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naup checkpolicy-2.0.3.old/checkmodule.c checkpolicy-2.0.3/checkmodule.c
--- checkpolicy-2.0.3.old/checkmodule.c	2007-07-26 19:03:19.000000000 -0400
+++ checkpolicy-2.0.3/checkmodule.c	2007-07-31 13:30:38.000000000 -0400
@@ -39,6 +39,7 @@ extern int optind;
 static sidtab_t sidtab;
 
 extern int mlspol;
+extern int handle_unknown;
 
 static char *txtfile = "policy.conf";
 static char *binfile = "policy";
@@ -121,6 +122,7 @@ static int write_binary_policy(policydb_
 
 	p->policy_type = policy_type;
 	p->policyvers = policyvers;
+	p->handle_unknown = handle_unknown;
 
 	pf.type = PF_USE_STDIO;
 	pf.fp = outfp;
@@ -135,13 +137,18 @@ static int write_binary_policy(policydb_
 
 static void usage(char *progname)
 {
-	printf("usage:  %s [-V] [-b] [-m] [-M] [-o FILE] [INPUT]\n", progname);
+	printf("usage:  %s [-V] [-b] [-U handle_unknown] [-m] [-M] [-o FILE] [INPUT]\n", progname);
 	printf("Build base and policy modules.\n");
 	printf("Options:\n");
 	printf("  INPUT      build module from INPUT (else read from \"%s\")\n",
 	       txtfile);
 	printf("  -V         show policy versions created by this program\n");
 	printf("  -b         treat input as a binary policy file\n");
+	printf("  -U %d-%d     How the kernel should handle unknown classes and permissions\n",
+			DENY_UNKNOWN, ALLOW_UNKNOWN);
+	printf("               %d: Deny unknown kernel checks\n", DENY_UNKNOWN);
+	printf("               %d: Reject loading of policy with unknowns\n", REJECT_UNKNOWN);
+	printf("               %d: Allow unknown kernel checks\n", ALLOW_UNKNOWN);
 	printf("  -m         build a policy module instead of a base module\n");
 	printf("  -M         enable MLS policy\n");
 	printf("  -o FILE    write module to FILE (else just check syntax)\n");
@@ -156,7 +163,7 @@ int main(int argc, char **argv)
 	int show_version = 0;
 	policydb_t modpolicydb;
 
-	while ((ch = getopt(argc, argv, "ho:dbVmM")) != EOF) {
+	while ((ch = getopt(argc, argv, "ho:dbVU:mM")) != EOF) {
 		switch (ch) {
 		case 'h':
 			usage(argv[0]);
@@ -171,6 +178,12 @@ int main(int argc, char **argv)
 		case 'V':
 			show_version = 1;
 			break;
+		case 'U':
+			handle_unknown = strtol(optarg, (char **) NULL, 10);
+			if ((handle_unknown < DENY_UNKNOWN) ||
+			    (handle_unknown > ALLOW_UNKNOWN))
+				usage(argv[0]);
+			break;
 		case 'm':
 			policy_type = POLICY_MOD;
 			policyvers = MOD_POLICYDB_VERSION_MAX;
@@ -189,6 +202,12 @@ int main(int argc, char **argv)
 		exit(0);
 	}
 
+	if (handle_unknown && (policy_type != POLICY_BASE)) {
+		printf("Handling of unknown classes and permissions is only ");
+		printf("valid in the base modules\n");
+		exit(1);
+	}
+
 	if (optind != argc) {
 		file = argv[optind++];
 		if (optind != argc)
@@ -214,6 +233,7 @@ int main(int argc, char **argv)
 
 		modpolicydb.policy_type = policy_type;
 		modpolicydb.mls = mlspol;
+		modpolicydb.handle_unknown = handle_unknown;
 
 		if (read_source_policy(&modpolicydb, file, argv[0]) == -1) {
 			exit(1);
diff -Naup checkpolicy-2.0.3.old/checkpolicy.c checkpolicy-2.0.3/checkpolicy.c
--- checkpolicy-2.0.3.old/checkpolicy.c	2007-07-26 19:03:19.000000000 -0400
+++ checkpolicy-2.0.3/checkpolicy.c	2007-07-27 17:42:39.000000000 -0400
@@ -90,6 +90,7 @@ static sidtab_t sidtab;
 
 extern policydb_t *policydbp;
 extern int mlspol;
+extern int handle_unknown;
 
 static char *txtfile = "policy.conf";
 static char *binfile = "policy";
@@ -99,8 +100,8 @@ unsigned int policyvers = POLICYDB_VERSI
 void usage(char *progname)
 {
 	printf
-	    ("usage:  %s [-b] [-d] [-M] [-c policyvers (%d-%d)] [-o output_file] [input_file]\n",
-	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
+	    ("usage:  %s [-b] [-d] [-U handle unknwon (%d-%d) [-M] [-c policyvers (%d-%d)] [-o output_file] [input_file]\n",
+	     progname, DENY_UNKNOWN, ALLOW_UNKNOWN, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
 }
 
@@ -390,7 +391,7 @@ int main(int argc, char **argv)
 	int show_version = 0;
 	struct policy_file pf;
 
-	while ((ch = getopt(argc, argv, "o:dbMVc:")) != EOF) {
+	while ((ch = getopt(argc, argv, "o:dbU:MVc:")) != EOF) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
@@ -405,6 +406,12 @@ int main(int argc, char **argv)
 		case 'V':
 			show_version = 1;
 			break;
+		case 'U':
+			handle_unknown = strtol(optarg, (char **) NULL, 10);
+			if ((handle_unknown < DENY_UNKNOWN) ||
+			    (handle_unknown > ALLOW_UNKNOWN))
+				usage(argv[0]);
+			break;
 		case 'M':
 			mlspol = 1;
 			break;
@@ -515,6 +522,7 @@ int main(int argc, char **argv)
 
 		/* Let sepol know if we are dealing with MLS support */
 		parse_policy.mls = mlspol;
+		parse_policy.handle_unknown = handle_unknown;
 
 		policydbp = &parse_policy;
 
diff -Naup checkpolicy-2.0.3.old/policy_parse.y checkpolicy-2.0.3/policy_parse.y
--- checkpolicy-2.0.3.old/policy_parse.y	2007-07-26 19:03:19.000000000 -0400
+++ checkpolicy-2.0.3/policy_parse.y	2007-07-26 21:11:36.000000000 -0400
@@ -67,6 +67,7 @@ queue_t id_queue = 0;
 static unsigned int pass;
 char *curfile = 0;
 int mlspol = 0;
+int handle_unknown = 0;
 
 extern unsigned long policydb_lineno;
 extern unsigned long source_lineno;

--=-FvmWsaqN6AR6Zvlp6bel
Content-Disposition: attachment; filename=kernel-handle-unknown.patch
Content-Type: text/x-patch; name=kernel-handle-unknown.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f05f97a..d290bb3 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -677,6 +677,8 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(p->type_attr_map);
 
+	kfree(p->undefined_perms);
+
 	return;
 }
 
@@ -1530,6 +1532,13 @@ int policydb_read(struct policydb *p, void *fp)
 			goto bad;
 		}
 	}
+	p->handle_unknown = le32_to_cpu(buf[1]) & POLICYDB_CONFIG_UNKNOWN_MASK;
+	p->handle_unknown >>= POLICYDB_CONFIG_UNKNOWN_SHIFT;
+
+	if (p->handle_unknown > ALLOW_UNKNOWN) {
+		printk(KERN_ERR "selinux: invalid options for handle_unknown\n");
+		goto bad;
+	}
 
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 8319d5f..b92324f 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -242,6 +242,9 @@ struct policydb {
 	struct ebitmap *type_attr_map;
 
 	unsigned int policyvers;
+
+	int handle_unknown;
+	u32 *undefined_perms;
 };
 
 extern void policydb_destroy(struct policydb *p);
@@ -253,6 +256,16 @@ extern int policydb_read(struct policydb *p, void *fp);
 
 #define POLICYDB_CONFIG_MLS    1
 
+/* the config flags related to unknown classes/perms are bits 2 and 3 */
+#define POLICYDB_CONFIG_UNKNOWN_MASK 	6
+#define POLICYDB_CONFIG_UNKNOWN_SHIFT 	1
+
+enum policy_with_unknown_perms {
+        DENY_UNKNOWN = 0,
+        REJECT_UNKNOWN = 1,
+        ALLOW_UNKNOWN = 2
+};
+
 #define OBJECT_R "object_r"
 #define OBJECT_R_VAL 1
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 0ae032f..dd460b5 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -292,6 +292,7 @@ static int context_struct_compute_av(struct context *scontext,
 	struct class_datum *tclass_datum;
 	struct ebitmap *sattr, *tattr;
 	struct ebitmap_node *snode, *tnode;
+	const struct selinux_class_perm *kdefs = &selinux_class_perm;
 	unsigned int i, j;
 
 	/*
@@ -305,13 +306,6 @@ static int context_struct_compute_av(struct context *scontext,
 		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
 			tclass = SECCLASS_NETLINK_SOCKET;
 
-	if (!tclass || tclass > policydb.p_classes.nprim) {
-		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
-		       tclass);
-		return -EINVAL;
-	}
-	tclass_datum = policydb.class_val_to_struct[tclass - 1];
-
 	/*
 	 * Initialize the access vectors to the default values.
 	 */
@@ -322,6 +316,38 @@ static int context_struct_compute_av(struct context *scontext,
 	avd->seqno = latest_granting;
 
 	/*
+	 * Check for all the invalid cases.
+	 * - tclass 0
+	 * - tclass > policy and > kernel
+	 * - tclass > policy but is a userspace class
+	 * - tclass > policy but we do not allow unknowns
+	 */
+	if (unlikely(!tclass))
+		goto inval_class;
+	if (unlikely(tclass > policydb.p_classes.nprim))
+		if (tclass > kdefs->cts_len || 
+		    !kdefs->class_to_string[tclass - 1] ||
+		    policydb.handle_unknown != ALLOW_UNKNOWN)
+			goto inval_class;
+
+	/* 
+	 * Kernel class and we ALLOW_UNKNOWN so pad the allow decision 
+	 * the pad will be all 1 for unknown classes.
+	 */
+	if (tclass <= kdefs->cts_len && (policydb.handle_unknown == ALLOW_UNKNOWN))
+		avd->allowed = policydb.undefined_perms[tclass - 1];
+
+	/*
+	 * Kernel class not in policy and we ALLOW_UNKNOWN.  Since decision is 
+	 * completed return.
+	 */
+	if (unlikely(tclass > policydb.p_classes.nprim &&
+		     tclass <= kdefs->cts_len))
+		return 0;
+
+	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+
+	/*
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
 	 */
@@ -387,6 +413,10 @@ static int context_struct_compute_av(struct context *scontext,
 	}
 
 	return 0;
+
+inval_class:
+	printk(KERN_ERR "security_compute_av:  unrecognized class %d\n", tclass);
+	return -EINVAL;
 }
 
 static int security_validtrans_handle_fail(struct context *ocontext,
@@ -1054,6 +1084,13 @@ static int validate_classes(struct policydb *p)
 	const char *def_class, *def_perm, *pol_class;
 	struct symtab *perms;
 
+	if (p->handle_unknown == ALLOW_UNKNOWN) {
+		u32 num_classes = kdefs->cts_len;
+		p->undefined_perms = kcalloc(num_classes, sizeof(u32), GFP_KERNEL);
+		if (!p->undefined_perms)
+			return -ENOMEM;
+	}
+
 	for (i = 1; i < kdefs->cts_len; i++) {
 		def_class = kdefs->class_to_string[i];
 		if (!def_class)
@@ -1062,6 +1099,10 @@ static int validate_classes(struct policydb *p)
 			printk(KERN_INFO
 			       "security:  class %s not defined in policy\n",
 			       def_class);
+			if (p->handle_unknown == ALLOW_UNKNOWN)
+				p->undefined_perms[i-1] = ~0U;
+			if (p->handle_unknown == REJECT_UNKNOWN)
+				return -EINVAL;
 			continue;
 		}
 		pol_class = p->p_class_val_to_name[i-1];
@@ -1087,12 +1128,16 @@ static int validate_classes(struct policydb *p)
 			printk(KERN_INFO
 			       "security:  permission %s in class %s not defined in policy\n",
 			       def_perm, pol_class);
+			if (p->handle_unknown == ALLOW_UNKNOWN)
+				p->undefined_perms[class_val-1] |= perm_val;
+			else if (p->handle_unknown == REJECT_UNKNOWN)
+				return -EINVAL;
 			continue;
 		}
 		perdatum = hashtab_search(perms->table, def_perm);
 		if (perdatum == NULL) {
 			printk(KERN_ERR
-			       "security:  permission %s in class %s not found in policy\n",
+			       "security:  permission %s in class %s not found in policy, bad policy\n",
 			       def_perm, pol_class);
 			return -EINVAL;
 		}
@@ -1130,12 +1175,16 @@ static int validate_classes(struct policydb *p)
 				printk(KERN_INFO
 				       "security:  permission %s in class %s not defined in policy\n",
 				       def_perm, pol_class);
+				if (p->handle_unknown == ALLOW_UNKNOWN)
+					p->undefined_perms[class_val-1] |= (1 << j);
+				else if (p->handle_unknown == REJECT_UNKNOWN)
+					return -EINVAL;
 				continue;
 			}
 			perdatum = hashtab_search(perms->table, def_perm);
 			if (perdatum == NULL) {
 				printk(KERN_ERR
-				       "security:  permission %s in class %s not found in policy\n",
+				       "security:  permission %s in class %s not found in policy, bad policy\n",
 				       def_perm, pol_class);
 				return -EINVAL;
 			}

--=-FvmWsaqN6AR6Zvlp6bel--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
