Subject: Re: [PATCH 1/3] libsepol: Add support for multiple target OSes
From: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <4AB0EF22.8070003@manicmethod.com>
References: <1253031316.3209.116.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4AB0EF22.8070003@manicmethod.com>
Content-Type: text/plain
Date: Tue, 29 Sep 2009 10:03:23 -0400
Message-Id: <1254233003.2466.59.camel@moss-stripedbass.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-16 at 09:58 -0400, Joshua Brindle wrote: 
> I'd rather have separate ocontext structs for each system. That way it 
> is very easy to understand which ones apply to which system and you 
> don't get a crazy out of context ocontext struct.
> 

I looked into having separate ocontext structs but that would involve
changing a lot of files making the patch much larger and more intrusive.

> >   	} u;
> >   	union {
> >   		uint32_t sclass;	/* security class for genfs */
> > @@ -313,6 +323,17 @@ typedef struct genfs {
> >   #define OCON_NODE6 6		/* IPv6 nodes */
> >   #define OCON_NUM   7
> >
> > +/* object context array indices for Xen */
> > +#define OCON_ISID    0    /* initial SIDs */
> > +#define OCON_PIRQ    1    /* physical irqs */
> > +#define OCON_IOPORT  2    /* io ports */
> > +#define OCON_IOMEM   3    /* io memory */
> > +#define OCON_DEVICE  4    /* pci devices */
> > +#define OCON_DUMMY1  5    /* reserved */
> > +#define OCON_DUMMY2  6    /* reserved */
> > +#define OCON_NUM     7
> > +
> > +
> >    
> Should these be namespaced? What if <random other system> has io port 
> objects? You'd have to align them with each other and you have a mess of 
> keeping the numbers the same (you already do this with OCON_ISID)

Variables have been namespaced and there is no more overlap with
OCON_ISID.

> Also we are relying on having the same number of OCON's which isn't good 
> I don't think. As much as I hate the policydb_compat_info (read: alot) 
> why aren't we using that to say how many ocons a xen policy really has?

OCON_NUM is now dynamically read through policydb_compat_info.


> This is messy, why not an ocontext_selinux_free() and 
> ocontext_xen_free() (note: I realize the xen_free() one won't do 
> anything except freep the ocontext_t)
> 

done.

> >
> >   	len = buf[1];
> > -	if (len != strlen(target_str)&&
> > -	    (!alt_target_str || len != strlen(alt_target_str))) {
> > -		ERR(fp->handle, "policydb string length %zu does not match "
> > -		    "expected length %zu", len, strlen(target_str));
> > +	if (len>  32) {
> >    
> 
> magic number 32?

#defined.

Thanks for your input.  Below is the updated patch for libsepol.  

----

 libsepol/include/sepol/policydb/policydb.h |   28 ++
 libsepol/src/expand.c                      |   85 +++++++-
 libsepol/src/policydb.c                    |  295
+++++++++++++++++++++++------
 libsepol/src/policydb_internal.h           |    1
 libsepol/src/private.h                     |    4
 libsepol/src/write.c                       |   93 ++++++++-
 6 files changed, 443 insertions(+), 63 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 0105cf4..e8991e2 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -276,6 +276,16 @@ typedef struct ocontext {
 			uint32_t addr[4]; /* network order */
 			uint32_t mask[4]; /* network order */
 		} node6;	/* IPv6 node information */
+		uint32_t device;
+		uint16_t pirq;
+		struct {
+			uint32_t low_iomem;
+			uint32_t high_iomem;
+		} iomem;
+		struct {
+			uint32_t low_ioport;
+			uint32_t high_ioport;
+		} ioport;
 	} u;
 	union {
 		uint32_t sclass;	/* security class for genfs */
@@ -311,6 +321,16 @@ typedef struct genfs {
 #define OCON_NODE  4		/* nodes */
 #define OCON_FSUSE 5		/* fs_use */
 #define OCON_NODE6 6		/* IPv6 nodes */
+#define OCON_GENFS 7            /* needed for ocontext_supported */
+
+/* object context array indices for Xen */
+#define OCON_XEN_ISID  	    0    /* initial SIDs */
+#define OCON_XEN_PIRQ       1    /* physical irqs */
+#define OCON_XEN_IOPORT     2    /* io ports */
+#define OCON_XEN_IOMEM	    3    /* io memory */
+#define OCON_XEN_PCIDEVICE  4    /* pci devices */
+
+/* OCON_NUM needs to be the largest index in any platform's ocontext array */
 #define OCON_NUM   7
 
 /* section: module information */
@@ -400,6 +420,7 @@ typedef struct policydb {
 	uint32_t policy_type;
 	char *name;
 	char *version;
+	int  target_platform;
 
 	/* Set when the policydb is modified such that writing is unsupported */
 	int unsupported_format;
@@ -593,6 +614,7 @@ extern int avrule_read_list(policydb_t * p, avrule_t ** avrules,
 			    struct policy_file *fp);
 
 extern int policydb_write(struct policydb *p, struct policy_file *pf);
+extern int policydb_set_target_platform(policydb_t *p, int platform);
 
 #define PERM_SYMTAB_SIZE 32
 
@@ -651,9 +673,13 @@ extern int policydb_write(struct policydb *p, struct policy_file *pf);
 
 #define POLICYDB_MAGIC SELINUX_MAGIC
 #define POLICYDB_STRING "SE Linux"
-#define POLICYDB_ALT_STRING "Flask"
+#define POLICYDB_XEN_STRING "XenFlask"
+#define POLICYDB_STRING_MAX_LENGTH 32
 #define POLICYDB_MOD_MAGIC SELINUX_MOD_MAGIC
 #define POLICYDB_MOD_STRING "SE Linux Module"
+#define SEPOL_TARGET_SELINUX 0
+#define SEPOL_TARGET_XEN     1
+
 
 #endif				/* _POLICYDB_H_ */
 
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index e9cd986..16d6bcb 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1819,9 +1819,9 @@ static int context_copy(context_struct_t * dst, context_struct_t * src,
 	return mls_context_cpy(dst, src);
 }
 
-static int ocontext_copy(expand_state_t * state)
+static int ocontext_copy_xen(expand_state_t *state)
 {
-	unsigned int i, j;
+	unsigned int i;
 	ocontext_t *c, *n, *l;
 
 	for (i = 0; i < OCON_NUM; i++) {
@@ -1833,11 +1833,63 @@ static int ocontext_copy(expand_state_t * state)
 				return -1;
 			}
 			memset(n, 0, sizeof(ocontext_t));
-			if (l) {
+			if (l)
 				l->next = n;
-			} else {
+			else
 				state->out->ocontexts[i] = n;
+			l = n;
+			if (context_copy(&n->context[0], &c->context[0],
+				state)) {
+				ERR(state->handle, "Out of memory!");
+				return -1;
 			}
+			switch (i) {
+			case OCON_XEN_ISID:
+				n->sid[0] = c->sid[0];
+				break;
+			case OCON_XEN_PIRQ:
+				n->u.pirq = c->u.pirq;
+				break;
+			case OCON_XEN_IOPORT:
+				n->u.ioport.low_ioport = c->u.ioport.low_ioport;
+				n->u.ioport.high_ioport =
+					c->u.ioport.high_ioport;
+				break;
+			case OCON_XEN_IOMEM:
+				n->u.iomem.low_iomem  = c->u.iomem.low_iomem;
+				n->u.iomem.high_iomem = c->u.iomem.high_iomem;
+				break;
+			case OCON_XEN_PCIDEVICE:
+				n->u.device = c->u.device;
+				break;
+			default:
+				/* shouldn't get here */
+				ERR(state->handle, "Unknown ocontext");
+				return -1;
+			}
+		}
+	}
+	return 0;
+}
+
+static int ocontext_copy_selinux(expand_state_t *state)
+{
+	unsigned int i, j;
+	ocontext_t *c, *n, *l;
+
+	for (i = 0; i < OCON_NUM; i++) {
+		l = NULL;
+		for (c = state->base->ocontexts[i]; c; c = c->next) {
+			n = malloc(sizeof(ocontext_t));
+			if (!n) {
+				ERR(state->handle, "Out of memory!");
+				return -1;
+			}
+			memset(n, 0, sizeof(ocontext_t));
+			if (l)
+				l->next = n;
+			else
+				state->out->ocontexts[i] = n;
 			l = n;
 			if (context_copy(&n->context[0], &c->context[0], state)) {
 				ERR(state->handle, "Out of memory!");
@@ -1885,13 +1937,31 @@ static int ocontext_copy(expand_state_t * state)
 				break;
 			default:
 				/* shouldn't get here */
-				assert(0);
+				ERR(state->handle, "Unknown ocontext");
+				return -1;
 			}
 		}
 	}
 	return 0;
 }
 
+static int ocontext_copy(expand_state_t *state, uint32_t target)
+{
+	int rc = -1;
+	switch (target) {
+	case SEPOL_TARGET_SELINUX:
+		rc = ocontext_copy_selinux(state);
+		break;
+	case SEPOL_TARGET_XEN:
+		rc = ocontext_copy_xen(state);
+		break;
+	default:
+		ERR(state->handle, "Unknown target");
+		return -1;
+	}
+	return rc;
+}
+
 static int genfs_copy(expand_state_t * state)
 {
 	ocontext_t *c, *newc, *l;
@@ -2418,6 +2488,9 @@ int expand_module(sepol_handle_t * handle,
 	out->mls = base->mls;
 	out->handle_unknown = base->handle_unknown;
 
+	/* Copy target from base to out */
+	out->target_platform = base->target_platform;
+
 	/* Copy policy capabilities */
 	if (ebitmap_cpy(&out->policycaps, &base->policycaps)) {
 		ERR(handle, "Out of memory!");
@@ -2576,7 +2649,7 @@ int expand_module(sepol_handle_t * handle,
 	evaluate_conds(state.out);
 
 	/* copy ocontexts */
-	if (ocontext_copy(&state))
+	if (ocontext_copy(&state, out->target_platform))
 		goto cleanup;
 
 	/* copy genfs */
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 85ddefc..dae05d3 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -54,151 +54,185 @@
 #include "debug.h"
 #include "mls.h"
 
+#define POLICYDB_TARGET_SZ   ARRAY_SIZE(policydb_target_strings)
+char *policydb_target_strings[] = { POLICYDB_STRING, POLICYDB_XEN_STRING };
+
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static struct policydb_compat_info policydb_compat[] = {
 	{
 	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_BOUNDARY,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_XEN_PCIDEVICE + 1,
+	 .target_platform = SEPOL_TARGET_XEN,
+	 },
+	{
+	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM - 3,
 	 .ocon_num = OCON_FSUSE + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_BOOL,
 	 .sym_num = SYM_NUM - 2,
 	 .ocon_num = OCON_FSUSE + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_IPV6,
 	 .sym_num = SYM_NUM - 2,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_NLCLASS,
 	 .sym_num = SYM_NUM - 2,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_MLS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_AVTAB,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_RANGETRANS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_POLCAP,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_PERMISSIVE,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
         {
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_BOUNDARY,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_MLS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_MLS_USERS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_POLCAP,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_PERMISSIVE,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BOUNDARY,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_MLS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_MLS_USERS,
 	 .sym_num = SYM_NUM,
-	 .ocon_num = 0
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_POLCAP,
 	 .sym_num = SYM_NUM,
-	 .ocon_num = 0
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_PERMISSIVE,
 	 .sym_num = SYM_NUM,
-	 .ocon_num = 0
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	 },
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BOUNDARY,
 	 .sym_num = SYM_NUM,
-	 .ocon_num = 0
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
 	 .sym_num = SYM_NUM,
-	 .ocon_num = 0
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
 };
 
@@ -225,14 +259,16 @@ static unsigned int symtab_sizes[SYM_NUM] = {
 };
 
 struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
-						    unsigned int type)
+						    unsigned int type,
+						unsigned int target_platform)
 {
 	unsigned int i;
 	struct policydb_compat_info *info = NULL;
 
 	for (i = 0; i < sizeof(policydb_compat) / sizeof(*info); i++) {
 		if (policydb_compat[i].version == version &&
-		    policydb_compat[i].type == type) {
+		    policydb_compat[i].type == type &&
+		    policydb_compat[i].target_platform == target_platform) {
 			info = &policydb_compat[i];
 			break;
 		}
@@ -1026,6 +1062,45 @@ static int (*destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
 common_destroy, class_destroy, role_destroy, type_destroy, user_destroy,
 	    cond_destroy_bool, sens_destroy, cat_destroy,};
 
+void ocontext_selinux_free(ocontext_t **ocontexts)
+{
+	ocontext_t *c, *ctmp;
+	int i;
+
+	for (i = 0; i < OCON_NUM; i++) {
+		c = ocontexts[i];
+		while (c) {
+			ctmp = c;
+			c = c->next;
+			context_destroy(&ctmp->context[0]);
+			context_destroy(&ctmp->context[1]);
+			if (i == OCON_ISID || i == OCON_FS || i == OCON_NETIF
+				|| i == OCON_FSUSE)
+				free(ctmp->u.name);
+			free(ctmp);
+		}
+	}
+}
+
+void ocontext_xen_free(ocontext_t **ocontexts)
+{
+	ocontext_t *c, *ctmp;
+	int i;
+
+	for (i = 0; i < OCON_NUM; i++) {
+		c = ocontexts[i];
+		while (c) {
+			ctmp = c;
+			c = c->next;
+			context_destroy(&ctmp->context[0]);
+			context_destroy(&ctmp->context[1]);
+			if (i == OCON_ISID)
+				free(ctmp->u.name);
+			free(ctmp);
+		}
+	}
+}
+
 /*
  * Free any memory allocated by a policy database structure.
  */
@@ -1072,19 +1147,10 @@ void policydb_destroy(policydb_t * p)
 
 	avtab_destroy(&p->te_avtab);
 
-	for (i = 0; i < OCON_NUM; i++) {
-		c = p->ocontexts[i];
-		while (c) {
-			ctmp = c;
-			c = c->next;
-			context_destroy(&ctmp->context[0]);
-			context_destroy(&ctmp->context[1]);
-			if (i == OCON_ISID || i == OCON_FS || i == OCON_NETIF
-			    || i == OCON_FSUSE)
-				free(ctmp->u.name);
-			free(ctmp);
-		}
-	}
+	if (p->target_platform == SEPOL_TARGET_SELINUX)
+		ocontext_selinux_free(p->ocontexts);
+	else if (p->target_platform == SEPOL_TARGET_XEN)
+		ocontext_xen_free(p->ocontexts);
 
 	g = p->genfs;
 	while (g) {
@@ -2102,7 +2168,88 @@ int role_allow_read(role_allow_t ** r, struct policy_file *fp)
 	return 0;
 }
 
-static int ocontext_read(struct policydb_compat_info *info,
+static int ocontext_read_xen(struct policydb_compat_info *info,
+	policydb_t *p, struct policy_file *fp)
+{
+	unsigned int i, j;
+	size_t nel;
+	ocontext_t *l, *c;
+	uint32_t buf[8];
+	int rc;
+
+	for (i = 0; i < info->ocon_num; i++) {
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			return -1;
+		nel = le32_to_cpu(buf[0]);
+		l = NULL;
+		for (j = 0; j < nel; j++) {
+			c = calloc(1, sizeof(ocontext_t));
+			if (!c)
+				return -1;
+			if (l)
+				l->next = c;
+			else
+				p->ocontexts[i] = c;
+			l = c;
+			switch (i) {
+			case OCON_XEN_ISID:
+				rc = next_entry(buf, fp, sizeof(uint32_t));
+				if (rc < 0)
+					return -1;
+				c->sid[0] = le32_to_cpu(buf[0]);
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
+			case OCON_XEN_PIRQ:
+				rc = next_entry(buf, fp, sizeof(uint32_t));
+				if (rc < 0)
+					return -1;
+				c->u.pirq = le32_to_cpu(buf[0]);
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
+			case OCON_XEN_IOPORT:
+				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+				if (rc < 0)
+					return -1;
+				c->u.ioport.low_ioport = le32_to_cpu(buf[0]);
+				c->u.ioport.high_ioport = le32_to_cpu(buf[1]);
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
+			case OCON_XEN_IOMEM:
+				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+				if (rc < 0)
+					return -1;
+				c->u.iomem.low_iomem = le32_to_cpu(buf[0]);
+				c->u.iomem.high_iomem = le32_to_cpu(buf[1]);
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
+			case OCON_XEN_PCIDEVICE:
+				rc = next_entry(buf, fp, sizeof(uint32_t));
+				if (rc < 0)
+					return -1;
+				c->u.device = le32_to_cpu(buf[0]);
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
+			default:
+				/* should never get here */
+				ERR(fp->handle, "Unknown Xen ocontext");
+				return -1;
+			}
+		}
+	}
+	return 0;
+}
+static int ocontext_read_selinux(struct policydb_compat_info *info,
 			 policydb_t * p, struct policy_file *fp)
 {
 	unsigned int i, j;
@@ -2197,23 +2344,25 @@ static int ocontext_read(struct policydb_compat_info *info,
 					return -1;
 				break;
 			case OCON_NODE6:{
-					int k;
-
-					rc = next_entry(buf, fp,
-							sizeof(uint32_t) * 8);
-					if (rc < 0)
-						return -1;
-					for (k = 0; k < 4; k++)
-						c->u.node6.addr[k] = buf[k]; /* network order */
-					for (k = 0; k < 4; k++)
-						c->u.node6.mask[k] = buf[k + 4]; /* network order */
-					if (context_read_and_validate
-					    (&c->context[0], p, fp))
-						return -1;
-					break;
+				int k;
+
+				rc = next_entry(buf, fp, sizeof(uint32_t) * 8);
+				if (rc < 0)
+					return -1;
+				for (k = 0; k < 4; k++)
+					 /* network order */
+					c->u.node6.addr[k] = buf[k];
+				for (k = 0; k < 4; k++)
+					/* network order */
+					c->u.node6.mask[k] = buf[k + 4];
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
 				}
 			default:{
-					assert(0);	/* should never get here */
+				ERR(fp->handle, "Unknown SELinux ocontext");
+				return -1;
 				}
 			}
 		}
@@ -2221,6 +2370,23 @@ static int ocontext_read(struct policydb_compat_info *info,
 	return 0;
 }
 
+static int ocontext_read(struct policydb_compat_info *info,
+	policydb_t *p, struct policy_file *fp)
+{
+	int rc = -1;
+	switch (p->target_platform) {
+	case SEPOL_TARGET_SELINUX:
+		rc = ocontext_read_selinux(info, p, fp);
+		break;
+	case SEPOL_TARGET_XEN:
+		rc = ocontext_read_xen(info, p, fp);
+		break;
+	default:
+		ERR(fp->handle, "Unknown target");
+	}
+	return rc;
+}
+
 static int genfs_read(policydb_t * p, struct policy_file *fp)
 {
 	uint32_t buf[1];
@@ -3070,7 +3236,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	unsigned int i, j, r_policyvers;
 	uint32_t buf[5], config;
 	size_t len, nprim, nel;
-	char *policydb_str, *target_str = NULL, *alt_target_str = NULL;
+	char *policydb_str;
 	struct policydb_compat_info *info;
 	unsigned int policy_type, bufindex;
 	ebitmap_node_t *tnode;
@@ -3087,11 +3253,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 
 	if (buf[0] == POLICYDB_MAGIC) {
 		policy_type = POLICY_KERN;
-		target_str = POLICYDB_STRING;
-		alt_target_str = POLICYDB_ALT_STRING;
 	} else if (buf[0] == POLICYDB_MOD_MAGIC) {
 		policy_type = POLICY_MOD;
-		target_str = POLICYDB_MOD_STRING;
 	} else {
 		ERR(fp->handle, "policydb magic number %#08x does not "
 		    "match expected magic number %#08x or %#08x",
@@ -3100,10 +3263,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	}
 
 	len = buf[1];
-	if (len != strlen(target_str) &&
-	    (!alt_target_str || len != strlen(alt_target_str))) {
-		ERR(fp->handle, "policydb string length %zu does not match "
-		    "expected length %zu", len, strlen(target_str));
+	if (len > POLICYDB_STRING_MAX_LENGTH) {
+		ERR(fp->handle, "policydb string length too long ");
 		return POLICYDB_ERROR;
 	}
 
@@ -3120,13 +3281,31 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		return POLICYDB_ERROR;
 	}
 	policydb_str[len] = 0;
-	if (strcmp(policydb_str, target_str) &&
-	    (!alt_target_str || strcmp(policydb_str, alt_target_str))) {
-		ERR(fp->handle, "policydb string %s does not match "
-		    "my string %s", policydb_str, target_str);
-		free(policydb_str);
-		return POLICYDB_ERROR;
+
+	if (policy_type == POLICY_KERN) {
+		for (i = 0; i < POLICYDB_TARGET_SZ; i++) {
+			if ((strcmp(policydb_str, policydb_target_strings[i])
+				== 0)) {
+				policydb_set_target_platform(p, i);
+				break;
+			}
+		}
+
+		if (i == POLICYDB_TARGET_SZ) {
+			ERR(fp->handle, "cannot find a valid target for policy "
+				"string %s", policydb_str);
+			free(policydb_str);
+			return POLICYDB_ERROR;
+		}
+	} else {
+		if (strcmp(policydb_str, POLICYDB_MOD_STRING)) {
+			ERR(fp->handle, "invalid string identifier %s",
+				policydb_str);
+			free(policydb_str);
+			return POLICYDB_ERROR;
+		}
 	}
+
 	/* Done with policydb_str. */
 	free(policydb_str);
 	policydb_str = NULL;
@@ -3195,7 +3374,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 
 	bufindex++;
 
-	info = policydb_lookup_compat(r_policyvers, policy_type);
+	info = policydb_lookup_compat(r_policyvers, policy_type,
+					p->target_platform);
 	if (!info) {
 		ERR(fp->handle, "unable to find policy compat info "
 		    "for version %d", r_policyvers);
@@ -3391,3 +3571,16 @@ void policy_file_init(policy_file_t *pf)
 {
 	memset(pf, 0, sizeof(policy_file_t));
 }
+
+int policydb_set_target_platform(policydb_t *p, int platform)
+{
+	if (platform == SEPOL_TARGET_SELINUX)
+		p->target_platform = SEPOL_TARGET_SELINUX;
+	else if (platform == SEPOL_TARGET_XEN)
+		p->target_platform = SEPOL_TARGET_XEN;
+	else
+		return -1;
+
+	return 0;
+}
+
diff --git a/libsepol/src/policydb_internal.h b/libsepol/src/policydb_internal.h
index 1eb99e5..8a31506 100644
--- a/libsepol/src/policydb_internal.h
+++ b/libsepol/src/policydb_internal.h
@@ -6,4 +6,5 @@
 
 hidden_proto(sepol_policydb_create)
     hidden_proto(sepol_policydb_free)
+extern char *policydb_target_strings[];
 #endif
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 594f736..b2b247e 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -36,10 +36,12 @@ struct policydb_compat_info {
 	unsigned int version;
 	unsigned int sym_num;
 	unsigned int ocon_num;
+	unsigned int target_platform;
 };
 
 extern struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
-							   unsigned int type);
+							   unsigned int type,
+						unsigned int target_platform);
 
 /* Reading from a policy "file". */
 extern int next_entry(void *buf, struct policy_file *fp, size_t bytes) hidden;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 66b35ec..9906e35 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1084,10 +1084,79 @@ static int (*write_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
 common_write, class_write, role_write, type_write, user_write,
 	    cond_write_bool, sens_write, cat_write,};
 
-static int ocontext_write(struct policydb_compat_info *info, policydb_t * p,
+static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
 			  struct policy_file *fp)
 {
 	unsigned int i, j;
+	size_t nel, items;
+	uint32_t buf[32];
+	ocontext_t *c;
+	for (i = 0; i < info->ocon_num; i++) {
+		nel = 0;
+		for (c = p->ocontexts[i]; c; c = c->next)
+			nel++;
+		buf[0] = cpu_to_le32(nel);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+		for (c = p->ocontexts[i]; c; c = c->next) {
+			switch (i) {
+			case OCON_XEN_ISID:
+				buf[0] = cpu_to_le32(c->sid[0]);
+				items = put_entry(buf, sizeof(uint32_t), 1, fp);
+				if (items != 1)
+					return POLICYDB_ERROR;
+				if (context_write(p, &c->context[0], fp))
+					return POLICYDB_ERROR;
+				break;
+			case OCON_XEN_PIRQ:
+				buf[0] = cpu_to_le32(c->u.pirq);
+				items = put_entry(buf, sizeof(uint32_t), 1, fp);
+				if (items != 1)
+					return POLICYDB_ERROR;
+				if (context_write(p, &c->context[0], fp))
+					return POLICYDB_ERROR;
+				break;
+			case OCON_XEN_IOPORT:
+				buf[0] = c->u.ioport.low_ioport;
+				buf[1] = c->u.ioport.high_ioport;
+				for (j = 0; j < 2; j++)
+					buf[j] = cpu_to_le32(buf[j]);
+				items = put_entry(buf, sizeof(uint32_t), 2, fp);
+				if (items != 2)
+					return POLICYDB_ERROR;
+				if (context_write(p, &c->context[0], fp))
+					return POLICYDB_ERROR;
+				break;
+			case OCON_XEN_IOMEM:
+				buf[0] = c->u.iomem.low_iomem;
+				buf[1] = c->u.iomem.high_iomem;
+				for (j = 0; j < 2; j++)
+					buf[j] = cpu_to_le32(buf[j]);
+				items = put_entry(buf, sizeof(uint32_t), 2, fp);
+				if (items != 2)
+					return POLICYDB_ERROR;
+				if (context_write(p, &c->context[0], fp))
+					return POLICYDB_ERROR;
+				break;
+			case OCON_XEN_PCIDEVICE:
+				buf[0] = cpu_to_le32(c->u.device);
+				items = put_entry(buf, sizeof(uint32_t), 1, fp);
+				if (items != 1)
+					return POLICYDB_ERROR;
+				if (context_write(p, &c->context[0], fp))
+					return POLICYDB_ERROR;
+				break;
+			}
+		}
+	}
+	return POLICYDB_SUCCESS;
+}
+
+static int ocontext_write_selinux(struct policydb_compat_info *info,
+	policydb_t *p, struct policy_file *fp)
+{
+	unsigned int i, j;
 	size_t nel, items, len;
 	uint32_t buf[32];
 	ocontext_t *c;
@@ -1176,6 +1245,21 @@ static int ocontext_write(struct policydb_compat_info *info, policydb_t * p,
 	return POLICYDB_SUCCESS;
 }
 
+static int ocontext_write(struct policydb_compat_info *info, policydb_t * p,
+	struct policy_file *fp)
+{
+	int rc = POLICYDB_ERROR;
+	switch (p->target_platform) {
+	case SEPOL_TARGET_SELINUX:
+		rc = ocontext_write_selinux(info, p, fp);
+		break;
+	case SEPOL_TARGET_XEN:
+		rc = ocontext_write_xen(info, p, fp);
+		break;
+	}
+	return rc;
+}
+
 static int genfs_write(policydb_t * p, struct policy_file *fp)
 {
 	genfs_t *genfs;
@@ -1610,8 +1694,8 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 	items = 0;
 	if (p->policy_type == POLICY_KERN) {
 		buf[items++] = cpu_to_le32(POLICYDB_MAGIC);
-		len = strlen(POLICYDB_STRING);
-		policydb_str = POLICYDB_STRING;
+		len = strlen(policydb_target_strings[p->target_platform]);
+		policydb_str = policydb_target_strings[p->target_platform];
 	} else {
 		buf[items++] = cpu_to_le32(POLICYDB_MOD_MAGIC);
 		len = strlen(POLICYDB_MOD_STRING);
@@ -1627,7 +1711,8 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 
 	/* Write the version, config, and table sizes. */
 	items = 0;
-	info = policydb_lookup_compat(p->policyvers, p->policy_type);
+	info = policydb_lookup_compat(p->policyvers, p->policy_type,
+					p->target_platform);
 	if (!info) {
 		ERR(fp->handle, "compatibility lookup failed for policy "
 		    "version %d", p->policyvers);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
