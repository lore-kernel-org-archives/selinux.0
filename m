Subject: Re: [RFC] Ability to allow undefined permissions and classes -v3
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, csellers@tresys.com
In-Reply-To: <1177592402.24282.310.camel@moss-spartans.epoch.ncsc.mil>
References: <1177537171.4221.25.camel@dhcp59-235.rdu.redhat.com>
	 <1177592402.24282.310.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 15:59:20 -0400
Message-Id: <1177617561.3885.12.camel@dhcp59-235.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-26 at 09:00 -0400, Stephen Smalley wrote:
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 1e52356..03728fa 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -59,6 +59,7 @@
> >  
> >  extern void selnl_notify_policyload(u32 seqno);
> >  unsigned int policydb_loaded_version;
> > +int selinux_allow_unknown = 0;
> 
> Just to note, this will become a policydb flag rather than a global when
> you turn this behavior into a policy config option.  And a tristate,
> right?  reject-policy-at-load, accept-policy-but-deny-unknown,
> accept-policy-and-allow-unknown

Here is my first stab at a completed kernel half.  As I write this
e-mail I have a thought, if it's set for rejecting policy should I
promote the printk's about missing classes/perms to something higher
than INFO?

I'm going to start working on how to make this new set of bits work in
userspace so I can actually test that any of this works.  Although I
must admit seeing something like

int policydb_write(policydb_t * p, struct policy_file *fp)

makes me want to gouge my eyes out.  to struct or to typedef?  Why
decide, just do both randomly!  *smile*

-Eric

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 0ac1021..a419ad0 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -670,6 +670,8 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(p->type_attr_map);
 
+	kfree(p->undefined_perms);
+
 	return;
 }
 
@@ -1523,6 +1525,8 @@ int policydb_read(struct policydb *p, void *fp)
 			goto bad;
 		}
 	}
+	p->allow_unknown = le32_to_cpu(buf[1]) & POLICYDB_CONFIG_UNKNOWN_MASK;
+	p->allow_unknown >>= POLICYDB_CONFIG_UNKNOWN_SHIFT;
 
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 8319d5f..4583f98 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -242,6 +242,9 @@ struct policydb {
 	struct ebitmap *type_attr_map;
 
 	unsigned int policyvers;
+
+	int allow_unknown;
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
index 1e52356..4c783c0 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -293,6 +293,7 @@ static int context_struct_compute_av(struct context *scontext,
 	struct class_datum *tclass_datum;
 	struct ebitmap *sattr, *tattr;
 	struct ebitmap_node *snode, *tnode;
+	const struct selinux_class_perm *kdefs = &selinux_class_perm;
 	unsigned int i, j;
 
 	/*
@@ -306,13 +307,6 @@ static int context_struct_compute_av(struct context *scontext,
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
@@ -323,6 +317,40 @@ static int context_struct_compute_av(struct context *scontext,
 	avd->seqno = latest_granting;
 
 	/*
+	 * Check if the class in question is a kernel class and if it
+	 * is defined in policy.  If yes to both it will pad the allow
+	 * for undefined perms if appropriate.
+	 */
+	if (unlikely(!tclass))
+		goto inval_class;
+	if (unlikely(tclass > policydb.p_classes.nprim)) {
+		if (tclass > kdefs->cts_len || (policydb.allow_unknown == DENY_UNKNOWN))
+			goto inval_class;
+		/* 
+		 * kernel class not in policy, but we
+		 * allow unknown, so let everything through
+		 */
+		if (kdefs->class_to_string[tclass - 1]) {
+			avd->allowed = 0xffffffff;
+			return 0;
+		}
+		/* 
+		 * this is a 'hole' in policy where a userspace
+		 * class exists
+		 */
+		goto inval_class;
+	}
+	if (tclass < kdefs->cts_len && (policydb.allow_unknown == ALLOW_UNKNOWN))
+		/* 
+		 * kernel class, defined in policy, allow unknown.
+		 * might have undefined permissions, so default 
+		 * those perms to allow
+		 */
+		avd->allowed = policydb.undefined_perms[tclass - 1];
+
+	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+
+	/*
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
 	 */
@@ -388,6 +416,10 @@ static int context_struct_compute_av(struct context *scontext,
 	}
 
 	return 0;
+
+inval_class:
+	printk(KERN_ERR "security_compute_av:  unrecognized class %d\n", tclass);
+	return -EINVAL;
 }
 
 static int security_validtrans_handle_fail(struct context *ocontext,
@@ -1048,12 +1080,21 @@ static int validate_classes(struct policydb *p)
 	const char *def_class, *def_perm, *pol_class;
 	struct symtab *perms;
 
+	if (p->allow_unknown == ALLOW_UNKNOWN) {
+		u32 num_classes = kdefs->cts_len;
+		p->undefined_perms = kcalloc(num_classes, sizeof(u32), GFP_KERNEL);
+		if (!p->undefined_perms)
+			return -ENOMEM;
+	}
+
 	for (i = 1; i < kdefs->cts_len; i++) {
 		def_class = kdefs->class_to_string[i];
 		if (i > p->p_classes.nprim) {
 			printk(KERN_INFO
 			       "security:  class %s not defined in policy\n",
 			       def_class);
+			if (p->allow_unknown == REJECT_UNKNOWN)
+				return -EINVAL;
 			continue;
 		}
 		pol_class = p->p_class_val_to_name[i-1];
@@ -1079,14 +1120,22 @@ static int validate_classes(struct policydb *p)
 			printk(KERN_INFO
 			       "security:  permission %s in class %s not defined in policy\n",
 			       def_perm, pol_class);
+			if (p->allow_unknown == ALLOW_UNKNOWN)
+				p->undefined_perms[class_val-1] |= perm_val;
+			else if (p->allow_unknown == REJECT_UNKNOWN)
+				return -EINVAL;
 			continue;
 		}
 		perdatum = hashtab_search(perms->table, def_perm);
 		if (perdatum == NULL) {
-			printk(KERN_ERR
+			printk(KERN_INFO
 			       "security:  permission %s in class %s not found in policy\n",
 			       def_perm, pol_class);
-			return -EINVAL;
+			if (p->allow_unknown == ALLOW_UNKNOWN)
+				p->undefined_perms[class_val-1] |= perm_val;
+			else if (p->allow_unknown == REJECT_UNKNOWN)
+				return -EINVAL;
+			continue;
 		}
 		pol_val = 1 << (perdatum->value - 1);
 		if (pol_val != perm_val) {
@@ -1122,14 +1171,22 @@ static int validate_classes(struct policydb *p)
 				printk(KERN_INFO
 				       "security:  permission %s in class %s not defined in policy\n",
 				       def_perm, pol_class);
+				if (p->allow_unknown == ALLOW_UNKNOWN)
+					p->undefined_perms[class_val-1] |= (1 << j);
+				else if (p->allow_unknown == REJECT_UNKNOWN)
+					return -EINVAL;
 				continue;
 			}
 			perdatum = hashtab_search(perms->table, def_perm);
 			if (perdatum == NULL) {
-				printk(KERN_ERR
+				printk(KERN_INFO
 				       "security:  permission %s in class %s not found in policy\n",
 				       def_perm, pol_class);
-				return -EINVAL;
+				if (p->allow_unknown == ALLOW_UNKNOWN)
+					p->undefined_perms[class_val-1] |= (1 << j);
+				else if (p->allow_unknown == REJECT_UNKNOWN)
+					return -EINVAL;
+				continue;
 			}
 			if (perdatum->value != j + 1) {
 				printk(KERN_ERR



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
