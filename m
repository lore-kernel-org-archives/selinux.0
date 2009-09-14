Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8EDRIpQ001139
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 09:27:18 -0400
Received: from [144.51.25.66] (moss-stripedbass [144.51.25.66])
	by facesaver.epoch.ncsc.mil (8.13.8/8.13.1) with ESMTP id n8EDRH3R016123
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 09:27:17 -0400
Subject: [PATCH] libsepol/checkpolicy: Add support for multiple target OSes
From: pjnuzzi <pjnuzzi@tycho.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 14 Sep 2009 09:22:38 -0400
Message-Id: <1252934558.2379.14.camel@moss-stripedbass.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support for multiple target OSes to libsepol and checkpolicy, where
the particular target OS is selected using a new -t target option to
checkpolicy.  The default target remains SELinux.  A new target and
support is introduced for Xen.  The target OS is identified in the
policy image by using different policy string identifiers in the header.
At present, policy string identifiers are required to have the same
length for ease of parsing the header and to preserve file(1) parsing of
subsequent fields after the string identifier.  For SELinux, the string
identifier remains "SE Linux".  For Xen, the string identifier is
"XenFlask".  The latent support for just "Flask" in the policy reading
code that was introduced for FMAC is dropped; a separate identifier for
Solaris (e.g. "SolFlask") will be introduced later using this new target
mechanism if needed.  The same support can easily be extended for other
OSes.

Based on the selected target, the source and binary policies may be
parsed differently.  For SELinux vs. Xen, the current difference is the
interpretation of object context records.  New object context records
for object contexts for pirqs, iomem ranges, ioport ranges, and pci
devices are enabled if building for the Xen target.  The SELinux object
context records other than initial SIDs are disabled if building for the
Xen target.  checkpolicy will generate an error if an attempt is made to
build a policy that has invalid object context records for the selected
target, and libsepol will likewise reject a binary policy if its object
context records are invalid for the target identified by its string
identifier.

No changes are required to the SELinux kernel code to support this
change; the SELinux kernel will continue to accept only policies with
the "SE Linux" identifier.  A patch for the Xen Flask module will be
submitted after this patch to enable it to accept policies built with
either string identifier (for compatibility with existing policies),
where the new object context record support will only be enabled if the
policy was built for the Xen target.

Support for selecting the target platform for libsemanage will be added
later. 

Signed-off-by: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>

---
checkpolicy/checkpolicy.c                  |   20 +-
checkpolicy/policy_define.c                |  262 +++++++++++++++++++++++++++++
checkpolicy/policy_define.h                |    4
checkpolicy/policy_parse.y                 |   29 +++
checkpolicy/policy_scan.l                  |   10 -
libsepol/include/sepol/policydb/policydb.h |   28 ++-
libsepol/src/expand.c                      |   85 ++++++++-
libsepol/src/policydb.c                    |  178 ++++++++++++++++---
libsepol/src/policydb_internal.h           |    1
libsepol/src/write.c                       |   90 +++++++++
sepolgen/src/sepolgen/refparser.py         |   54 +++++
sepolgen/src/sepolgen/refpolicy.py         |   35 +++
12 files changed, 755 insertions(+), 41 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index d7772d5..76d8ed3 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -100,7 +100,9 @@ unsigned int policyvers = POLICYDB_VERSION_MAX;
 void usage(char *progname)
 {
 	printf
-	    ("usage:  %s [-b] [-d] [-U handle_unknown (allow,deny,reject) [-M] [-c policyvers (%d-%d)] [-o output_file] [input_file]\n",
+	    ("usage:  %s [-b] [-d] [-U handle_unknown (allow,deny,reject) [-M]"
+	     "[-c policyvers (%d-%d)] [-o output_file] [-t platform]"
+	     "[input_file]\n",
 	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
 }
@@ -381,7 +383,7 @@ int main(int argc, char **argv)
 	unsigned int protocol, port;
 	unsigned int binary = 0, debug = 0;
 	struct val_to_name v;
-	int ret, ch, fd;
+	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
 	unsigned int nel, uret;
 	struct stat sb;
 	void *map;
@@ -391,11 +393,22 @@ int main(int argc, char **argv)
 	int show_version = 0;
 	struct policy_file pf;
 
-	while ((ch = getopt(argc, argv, "o:dbU:MVc:")) != EOF) {
+	while ((ch = getopt(argc, argv, "o:t:dbU:MVc:")) != EOF) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
 			break;
+		case 't':
+			if (!strcasecmp(optarg, "Xen"))
+				target = SEPOL_TARGET_XEN;
+			else if (!strcasecmp(optarg, "SELinux"))
+				target = SEPOL_TARGET_SELINUX;
+			else{
+				fprintf(stderr, "%s:  Unknown target platform:"
+					"%s\n", argv[0], optarg);
+				exit(1);
+			}
+			break;
 		case 'b':
 			binary = 1;
 			file = binfile;
@@ -528,6 +541,7 @@ int main(int argc, char **argv)
 			exit(1);
 		/* We build this as a base policy first since that is all the parser understands */
 		parse_policy.policy_type = POLICY_BASE;
+		policydb_set_target_platform(&parse_policy, target);
 
 		/* Let sepol know if we are dealing with MLS support */
 		parse_policy.mls = mlspol;
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 17b84ce..1e19bda 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3372,12 +3372,254 @@ int define_fs_context(unsigned int major, unsigned int minor)
 	return 0;
 }
 
+int define_pirq_context(unsigned int pirq)
+{
+	ocontext_t *newc, *c, *l, *head;
+	char *id;
+
+	if (policydbp->target_type != SEPOL_TARGET_XEN) {
+		yyerror("pirqcon only supported for target Xen");
+		return -1;
+	}
+
+	if (pass == 1) {
+		id = (char *) queue_remove(id_queue);
+		free(id);
+		parse_security_context(NULL);
+		return 0;
+	}
+
+	newc = malloc(sizeof(ocontext_t));
+	if (!newc) {
+		yyerror("out of memory");
+		return -1;
+	}
+	memset(newc, 0, sizeof(ocontext_t));
+
+	newc->u.pirq = pirq;
+
+	if (parse_security_context(&newc->context[0])) {
+		free(newc);
+		return -1;
+	}
+
+	head = policydbp->ocontexts[OCON_PIRQ];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+		unsigned int pirq2;
+
+		pirq2 = c->u.pirq;
+		if (pirq == pirq2) {
+			yyerror2("duplicate pirqcon entry for %d ", pirq);
+			goto bad;
+		}
+	}
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_PIRQ] = newc;
+
+	return 0;
+
+bad:
+	free(newc);
+	return -1;
+}
+
+int define_iomem_context(unsigned long low, unsigned long high)
+{
+	ocontext_t *newc, *c, *l, *head;
+	char *id;
+
+	if (policydbp->target_type != SEPOL_TARGET_XEN) {
+		yyerror("iomemcon only supported for target Xen");
+		return -1;
+	}
+
+	if (pass == 1) {
+		id = (char *)queue_remove(id_queue);
+		free(id);
+		parse_security_context(NULL);
+		return 0;
+	}
+
+	newc = malloc(sizeof(ocontext_t));
+	if (!newc) {
+		yyerror("out of memory");
+		return -1;
+	}
+	memset(newc, 0, sizeof(ocontext_t));
+
+	newc->u.iomem.low_iomem  = low;
+	newc->u.iomem.high_iomem = high;
+
+	if (low > high) {
+		yyerror2("low memory 0x%x exceeds high memory 0x%x", low, high);
+		free(newc);
+		return -1;
+	}
+
+	if (parse_security_context(&newc->context[0])) {
+		free(newc);
+		return -1;
+	}
+
+	head = policydbp->ocontexts[OCON_IOMEM];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+		unsigned int low2, high2;
+
+		low2 = c->u.iomem.low_iomem;
+		high2 = c->u.iomem.high_iomem;
+		if (low <= high2 && low2 <= high) {
+			yyerror2("iomemcon entry for 0x%x-0x%x overlaps with "
+				"earlier entry 0x%x-0x%x", low, high,
+				low2, high2);
+			goto bad;
+		}
+	}
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_IOMEM] = newc;
+
+	return 0;
+
+bad:
+	free(newc);
+	return -1;
+}
+
+int define_ioport_context(unsigned long low, unsigned long high)
+{
+	ocontext_t *newc, *c, *l, *head;
+	char *id;
+
+	if (policydbp->target_type != SEPOL_TARGET_XEN) {
+		yyerror("ioportcon only supported for target Xen");
+		return -1;
+	}
+
+	if (pass == 1) {
+		id = (char *)queue_remove(id_queue);
+		free(id);
+		parse_security_context(NULL);
+		return 0;
+	}
+
+	newc = malloc(sizeof(ocontext_t));
+	if (!newc) {
+		yyerror("out of memory");
+		return -1;
+	}
+	memset(newc, 0, sizeof(ocontext_t));
+
+	newc->u.ioport.low_ioport  = low;
+	newc->u.ioport.high_ioport = high;
+
+	if (low > high) {
+		yyerror2("low ioport 0x%x exceeds high ioport 0x%x", low, high);
+		free(newc);
+		return -1;
+	}
+
+	if (parse_security_context(&newc->context[0])) {
+		free(newc);
+		return -1;
+	}
+
+	head = policydbp->ocontexts[OCON_IOPORT];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+		unsigned int low2, high2;
+
+		low2 = c->u.ioport.low_ioport;
+		high2 = c->u.ioport.high_ioport;
+		if (low <= high2 && low2 <= high) {
+			yyerror2("ioportcon entry for 0x%x-0x%x overlaps with"
+				"earlier entry 0x%x-0x%x", low, high,
+				low2, high2);
+			goto bad;
+		}
+	}
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_IOPORT] = newc;
+
+	return 0;
+
+bad:
+	free(newc);
+	return -1;
+}
+
+int define_pcidevice_context(unsigned long device)
+{
+	ocontext_t *newc, *c, *l, *head;
+	char *id;
+
+	if (policydbp->target_type != SEPOL_TARGET_XEN) {
+		yyerror("pcidevicecon only supported for target Xen");
+		return -1;
+	}
+
+	if (pass == 1) {
+		id = (char *) queue_remove(id_queue);
+		free(id);
+		parse_security_context(NULL);
+		return 0;
+	}
+
+	newc = malloc(sizeof(ocontext_t));
+	if (!newc) {
+		yyerror("out of memory");
+		return -1;
+	}
+	memset(newc, 0, sizeof(ocontext_t));
+
+	newc->u.device = device;
+
+	if (parse_security_context(&newc->context[0])) {
+		free(newc);
+		return -1;
+	}
+
+	head = policydbp->ocontexts[OCON_DEVICE];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+		unsigned int device2;
+
+		device2 = c->u.device;
+		if (device == device2) {
+			yyerror2("duplicate pcidevicecon entry for 0x%x ",
+				 device);
+			goto bad;
+		}
+	}
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_DEVICE] = newc;
+
+	return 0;
+
+bad:
+	free(newc);
+	return -1;
+}
+
 int define_port_context(unsigned int low, unsigned int high)
 {
 	ocontext_t *newc, *c, *l, *head;
 	unsigned int protocol;
 	char *id;
 
+	if (policydbp->target_type != SEPOL_TARGET_SELINUX) {
+		yyerror("portcon only supported for target SELinux");
+		return -1;
+	}
+
 	if (pass == 1) {
 		id = (char *)queue_remove(id_queue);
 		free(id);
@@ -3460,6 +3702,11 @@ int define_netif_context(void)
 {
 	ocontext_t *newc, *c, *head;
 
+	if (policydbp->target_type != SEPOL_TARGET_SELINUX) {
+		yyerror("netifcon only supported for target SELinux");
+		return -1;
+	}
+
 	if (pass == 1) {
 		free(queue_remove(id_queue));
 		parse_security_context(NULL);
@@ -3516,6 +3763,11 @@ int define_ipv4_node_context()
 	struct in_addr addr, mask;
 	ocontext_t *newc, *c, *l, *head;
 
+	if (policydbp->target_type != SEPOL_TARGET_SELINUX) {
+		yyerror("nodecon only supported for target SELinux");
+		return -1;
+	}
+
 	if (pass == 1) {
 		free(queue_remove(id_queue));
 		free(queue_remove(id_queue));
@@ -3597,6 +3849,11 @@ int define_ipv6_node_context(void)
 	struct in6_addr addr, mask;
 	ocontext_t *newc, *c, *l, *head;
 
+	if (policydbp->target_type != SEPOL_TARGET_SELINUX) {
+		yyerror("nodecon only supported by target SELinux");
+		return -1;
+	}
+
 	if (pass == 1) {
 		free(queue_remove(id_queue));
 		free(queue_remove(id_queue));
@@ -3677,6 +3934,11 @@ int define_fs_use(int behavior)
 {
 	ocontext_t *newc, *c, *head;
 
+	if (policydbp->target_type != SEPOL_TARGET_SELINUX) {
+		yyerror("unsupported target");
+		return -1;
+	}
+
 	if (pass == 1) {
 		free(queue_remove(id_queue));
 		parse_security_context(NULL);
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index b5a972e..5ac6667 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -39,6 +39,10 @@ int define_netif_context(void);
 int define_permissive(void);
 int define_polcap(void);
 int define_port_context(unsigned int low, unsigned int high);
+int define_pirq_context(unsigned int pirq);
+int define_iomem_context(unsigned long low, unsigned long high);
+int define_ioport_context(unsigned long low, unsigned long high);
+int define_pcidevice_context(unsigned long device);
 int define_range_trans(int class_specified);
 int define_role_allow(void);
 int define_role_trans(void);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 5ca7101..8d1bc37 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -123,6 +123,7 @@ typedef int (* require_func_t)();
 %token TARGET
 %token SAMEUSER
 %token FSCON PORTCON NETIFCON NODECON 
+%token PIRQCON IOMEMCON IOPORTCON PCIDEVICECON
 %token FSUSEXATTR FSUSETASK FSUSETRANS
 %token GENFSCON
 %token U1 U2 U3 R1 R2 R3 T1 T2 T3 L1 L2 H1 H2
@@ -154,7 +155,7 @@ base_policy             : { if (define_policy(pass, 0) == -1) return -1; }
 			  opt_mls te_rbac users opt_constraints 
                          { if (pass == 1) { if (policydb_index_bools(policydbp)) return -1;}
 			   else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) return -1;}}
-			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts 
+			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts
 			;
 classes			: class_def 
 			| classes class_def
@@ -562,6 +563,32 @@ initial_sid_contexts	: initial_sid_context_def
 initial_sid_context_def	: SID identifier security_context_def
 			{if (define_initial_sid_context()) return -1;}
 			;
+opt_dev_contexts	: dev_contexts |
+			;
+dev_contexts		: dev_context_def
+			| dev_contexts dev_context_def
+			;
+dev_context_def		: pirq_context_def |
+			  iomem_context_def |
+			  ioport_context_def |
+			  pci_context_def
+			;
+pirq_context_def 	: PIRQCON number security_context_def
+		        {if (define_pirq_context($2)) return -1;}
+		        ;
+iomem_context_def	: IOMEMCON number security_context_def
+		        {if (define_iomem_context($2,$2)) return -1;}
+		        | IOMEMCON number '-' number security_context_def
+		        {if (define_iomem_context($2,$4)) return -1;}
+		        ;
+ioport_context_def	: IOPORTCON number security_context_def
+			{if (define_ioport_context($2,$2)) return -1;}
+			| IOPORTCON number '-' number security_context_def
+			{if (define_ioport_context($2,$4)) return -1;}
+			;
+pci_context_def  	: PCIDEVICECON number security_context_def
+		        {if (define_pcidevice_context($2)) return -1;}
+		        ;
 opt_fs_contexts         : fs_contexts 
                         |
                         ;
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index b55c659..48128a8 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -169,6 +169,14 @@ netifcon |
 NETIFCON			{ return(NETIFCON);}
 nodecon |                     
 NODECON				{ return(NODECON);}
+pirqcon |
+PIRQCON  		        { return(PIRQCON);}
+iomemcon |
+IOMEMCON            		{ return(IOMEMCON);}
+ioportcon |
+IOPORTCON           		{ return(IOPORTCON);}
+pcidevicecon |
+PCIDEVICECON           		{ return(PCIDEVICECON);}
 fs_use_xattr |
 FS_USE_XATTR			{ return(FSUSEXATTR);}
 fs_use_task |
@@ -209,7 +217,7 @@ permissive |
 PERMISSIVE			{ return(PERMISSIVE); }
 "/"({alnum}|[_\.\-/])*	        { return(PATH); }
 {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
-{digit}+                        { return(NUMBER); }
+{digit}+|0x{hexval}+            { return(NUMBER); }
 {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 0105cf4..2013238 100644
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
@@ -313,6 +323,17 @@ typedef struct genfs {
 #define OCON_NODE6 6		/* IPv6 nodes */
 #define OCON_NUM   7
 
+/* object context array indices for Xen */
+#define OCON_ISID    0    /* initial SIDs */
+#define OCON_PIRQ    1    /* physical irqs */
+#define OCON_IOPORT  2    /* io ports */
+#define OCON_IOMEM   3    /* io memory */
+#define OCON_DEVICE  4    /* pci devices */
+#define OCON_DUMMY1  5    /* reserved */
+#define OCON_DUMMY2  6    /* reserved */
+#define OCON_NUM     7
+
+
 /* section: module information */
 
 /* scope_index_t holds all of the symbols that are in scope in a
@@ -400,6 +421,7 @@ typedef struct policydb {
 	uint32_t policy_type;
 	char *name;
 	char *version;
+	uint32_t target_type;
 
 	/* Set when the policydb is modified such that writing is unsupported */
 	int unsupported_format;
@@ -593,6 +615,7 @@ extern int avrule_read_list(policydb_t * p, avrule_t ** avrules,
 			    struct policy_file *fp);
 
 extern int policydb_write(struct policydb *p, struct policy_file *pf);
+extern int policydb_set_target_platform(policydb_t *p, int platform);
 
 #define PERM_SYMTAB_SIZE 32
 
@@ -651,9 +674,12 @@ extern int policydb_write(struct policydb *p, struct policy_file *pf);
 
 #define POLICYDB_MAGIC SELINUX_MAGIC
 #define POLICYDB_STRING "SE Linux"
-#define POLICYDB_ALT_STRING "Flask"
+#define POLICYDB_XEN_STRING "XenFlask"
 #define POLICYDB_MOD_MAGIC SELINUX_MOD_MAGIC
 #define POLICYDB_MOD_STRING "SE Linux Module"
+#define SEPOL_TARGET_SELINUX 0
+#define SEPOL_TARGET_XEN     1
+
 
 #endif				/* _POLICYDB_H_ */
 
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index e9cd986..38e2481 100644
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
+			}
+			switch (i) {
+			case OCON_ISID:
+				n->sid[0] = c->sid[0];
+				break;
+			case OCON_PIRQ:
+				n->u.pirq = c->u.pirq;
+				break;
+			case OCON_IOPORT:
+				n->u.ioport.low_ioport = c->u.ioport.low_ioport;
+				n->u.ioport.high_ioport =
+					c->u.ioport.high_ioport;
+				break;
+			case OCON_IOMEM:
+				n->u.iomem.low_iomem  = c->u.iomem.low_iomem;
+				n->u.iomem.high_iomem = c->u.iomem.high_iomem;
+				break;
+			case OCON_DEVICE:
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
 			}
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
+	out->target_type = base->target_type;
+
 	/* Copy policy capabilities */
 	if (ebitmap_cpy(&out->policycaps, &base->policycaps)) {
 		ERR(handle, "Out of memory!");
@@ -2576,7 +2649,7 @@ int expand_module(sepol_handle_t * handle,
 	evaluate_conds(state.out);
 
 	/* copy ocontexts */
-	if (ocontext_copy(&state))
+	if (ocontext_copy(&state, out->target_type))
 		goto cleanup;
 
 	/* copy genfs */
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 85ddefc..a66a007 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -54,6 +54,9 @@
 #include "debug.h"
 #include "mls.h"
 
+#define POLICYDB_TARGET_SZ   ARRAY_SIZE(policydb_target_strings)
+char *policydb_target_strings[] = { POLICYDB_STRING, POLICYDB_XEN_STRING };
+
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static struct policydb_compat_info policydb_compat[] = {
 	{
@@ -1079,9 +1082,13 @@ void policydb_destroy(policydb_t * p)
 			c = c->next;
 			context_destroy(&ctmp->context[0]);
 			context_destroy(&ctmp->context[1]);
-			if (i == OCON_ISID || i == OCON_FS || i == OCON_NETIF
-			    || i == OCON_FSUSE)
+			if (i == OCON_ISID)
+				free(ctmp->u.name);
+			if (p->target_type == SEPOL_TARGET_SELINUX &&
+				(i == OCON_FS || i == OCON_NETIF ||
+				i == OCON_FSUSE))
 				free(ctmp->u.name);
+
 			free(ctmp);
 		}
 	}
@@ -2102,7 +2109,88 @@ int role_allow_read(role_allow_t ** r, struct policy_file *fp)
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
+			case OCON_ISID:
+				rc = next_entry(buf, fp, sizeof(uint32_t));
+				if (rc < 0)
+					return -1;
+				c->sid[0] = le32_to_cpu(buf[0]);
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
+			case OCON_PIRQ:
+				rc = next_entry(buf, fp, sizeof(uint32_t));
+				if (rc < 0)
+					return -1;
+				c->u.pirq = le32_to_cpu(buf[0]);
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
+			case OCON_IOPORT:
+				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+				if (rc < 0)
+					return -1;
+				c->u.ioport.low_ioport = le32_to_cpu(buf[0]);
+				c->u.ioport.high_ioport = le32_to_cpu(buf[1]);
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
+			case OCON_IOMEM:
+				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+				if (rc < 0)
+					return -1;
+				c->u.iomem.low_iomem = le32_to_cpu(buf[0]);
+				c->u.iomem.high_iomem = le32_to_cpu(buf[1]);
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
+			case OCON_DEVICE:
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
@@ -2197,23 +2285,25 @@ static int ocontext_read(struct policydb_compat_info *info,
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
@@ -2221,6 +2311,23 @@ static int ocontext_read(struct policydb_compat_info *info,
 	return 0;
 }
 
+static int ocontext_read(struct policydb_compat_info *info,
+	policydb_t *p, struct policy_file *fp)
+{
+	int rc = -1;
+	switch (p->target_type) {
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
@@ -3070,7 +3177,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	unsigned int i, j, r_policyvers;
 	uint32_t buf[5], config;
 	size_t len, nprim, nel;
-	char *policydb_str, *target_str = NULL, *alt_target_str = NULL;
+	char *policydb_str, *target_str = NULL;
 	struct policydb_compat_info *info;
 	unsigned int policy_type, bufindex;
 	ebitmap_node_t *tnode;
@@ -3088,7 +3195,6 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	if (buf[0] == POLICYDB_MAGIC) {
 		policy_type = POLICY_KERN;
 		target_str = POLICYDB_STRING;
-		alt_target_str = POLICYDB_ALT_STRING;
 	} else if (buf[0] == POLICYDB_MOD_MAGIC) {
 		policy_type = POLICY_MOD;
 		target_str = POLICYDB_MOD_STRING;
@@ -3100,8 +3206,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	}
 
 	len = buf[1];
-	if (len != strlen(target_str) &&
-	    (!alt_target_str || len != strlen(alt_target_str))) {
+	if (len != strlen(target_str)) {
 		ERR(fp->handle, "policydb string length %zu does not match "
 		    "expected length %zu", len, strlen(target_str));
 		return POLICYDB_ERROR;
@@ -3120,13 +3225,21 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		return POLICYDB_ERROR;
 	}
 	policydb_str[len] = 0;
-	if (strcmp(policydb_str, target_str) &&
-	    (!alt_target_str || strcmp(policydb_str, alt_target_str))) {
-		ERR(fp->handle, "policydb string %s does not match "
-		    "my string %s", policydb_str, target_str);
+
+	for (i = 0; i < POLICYDB_TARGET_SZ; i++) {
+		if ((strcmp(policydb_str, policydb_target_strings[i]) == 0)) {
+			policydb_set_target_platform(p, i);
+			break;
+		}
+	}
+
+	if (i == POLICYDB_TARGET_SZ) {
+		ERR(fp->handle, "cannot find a valid target for policy "
+			"my string %s", policydb_str);
 		free(policydb_str);
 		return POLICYDB_ERROR;
 	}
+
 	/* Done with policydb_str. */
 	free(policydb_str);
 	policydb_str = NULL;
@@ -3391,3 +3504,16 @@ void policy_file_init(policy_file_t *pf)
 {
 	memset(pf, 0, sizeof(policy_file_t));
 }
+
+int policydb_set_target_platform(policydb_t *p, int platform)
+{
+	if (platform == SEPOL_TARGET_SELINUX)
+		p->target_type = SEPOL_TARGET_SELINUX;
+	else if (platform == SEPOL_TARGET_XEN)
+		p->target_type = SEPOL_TARGET_XEN;
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
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 66b35ec..a557c2e 100644
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
+			case OCON_ISID:
+				buf[0] = cpu_to_le32(c->sid[0]);
+				items = put_entry(buf, sizeof(uint32_t), 1, fp);
+				if (items != 1)
+					return POLICYDB_ERROR;
+				if (context_write(p, &c->context[0], fp))
+					return POLICYDB_ERROR;
+				break;
+			case OCON_PIRQ:
+				buf[0] = cpu_to_le32(c->u.pirq);
+				items = put_entry(buf, sizeof(uint32_t), 1, fp);
+				if (items != 1)
+					return POLICYDB_ERROR;
+				if (context_write(p, &c->context[0], fp))
+					return POLICYDB_ERROR;
+				break;
+			case OCON_IOPORT:
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
+			case OCON_IOMEM:
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
+			case OCON_DEVICE:
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
+	switch (p->target_type) {
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
+		len = strlen(policydb_target_strings[p->target_type]);
+		policydb_str = policydb_target_strings[p->target_type];
 	} else {
 		buf[items++] = cpu_to_le32(POLICYDB_MOD_MAGIC);
 		len = strlen(POLICYDB_MOD_STRING);
diff --git a/sepolgen/src/sepolgen/refparser.py b/sepolgen/src/sepolgen/refparser.py
index 65d1d90..23beb39 100644
--- a/sepolgen/src/sepolgen/refparser.py
+++ b/sepolgen/src/sepolgen/refparser.py
@@ -83,6 +83,10 @@ tokens = (
     'PORTCON',
     'NODECON',
     'NETIFCON',
+    'PIRQCON',
+    'IOMEMCON',
+    'IOPORTCON',
+    'PCIDEVICECON',
     #   object classes
     'CLASS',
     #   types and attributes
@@ -140,6 +144,10 @@ reserved = {
     'portcon' : 'PORTCON',
     'nodecon' : 'NODECON',
     'netifcon' : 'NETIFCON',
+    'pirqcon' : 'PIRQCON',
+    'iomemcon' : 'IOMEMCON',
+    'ioportcon' : 'IOPORTCON',
+    'pcidevicecon' : 'PCIDEVICECON',
     # object classes
     'class' : 'CLASS',
     # types and attributes
@@ -495,6 +503,10 @@ def p_policy_stmt(p):
                    | portcon
                    | nodecon
                    | netifcon
+                   | pirqcon
+                   | iomemcon
+                   | ioportcon
+                   | pcidevicecon
     '''
     if p[1]:
         p[0] = [p[1]]
@@ -631,6 +643,48 @@ def p_netifcon(p):
 
     p[0] = n
 
+def p_pirqcon(p):
+    'pirqcon : PIRQCON NUMBER context'
+    c = refpolicy.PirqCon()
+    c.pirq_number = p[2]
+    c.context = p[3]
+
+    p[0] = c
+
+def p_iomemcon(p):
+    '''iomemcon : IOMEMCON NUMBER context
+                | IOMEMCON NUMBER MINUS NUMBER context'''
+    c = refpolicy.IomemCon()
+    if len(p) == 4:
+        c.device_mem = p[2]
+        c.context = p[3]
+    else:
+        c.device_mem = p[2] + "-" + p[3]
+        c.context = p[4]
+
+    p[0] = c
+
+def p_ioportcon(p):
+    '''ioportcon : IOPORTCON NUMBER context
+                | IOPORTCON NUMBER MINUS NUMBER context'''
+    c = refpolicy.IoportCon()
+    if len(p) == 4:
+        c.ioport = p[2]
+        c.context = p[3]
+    else:
+        c.ioport = p[2] + "-" + p[3]
+        c.context = p[4]
+
+    p[0] = c
+
+def p_pcidevicecon(p):
+    'pcidevicecon : PCIDEVICECON NUMBER context'
+    c = refpolicy.PciDeviceCon()
+    c.device = p[2]
+    c.context = p[3]
+
+    p[0] = c
+
 def p_mls_range_def(p):
     '''mls_range_def : mls_level_def MINUS mls_level_def
                      | mls_level_def
diff --git a/sepolgen/src/sepolgen/refpolicy.py b/sepolgen/src/sepolgen/refpolicy.py
index 724b870..b138e3d 100644
--- a/sepolgen/src/sepolgen/refpolicy.py
+++ b/sepolgen/src/sepolgen/refpolicy.py
@@ -618,6 +618,41 @@ class NetifCon(Leaf):
     def to_string(self):
         return "netifcon %s %s %s" % (self.interface, str(self.interface_context),
                                    str(self.packet_context))
+class PirqCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.pirq_number = ""
+        self.context = None
+
+    def to_string(self):
+        return "pirqcon %s %s" % (self.pirq_number, str(self.context))
+
+class IomemCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.device_mem = ""
+        self.context = None
+
+    def to_string(self):
+        return "iomemcon %s %s" % (self.device_mem, str(self.context))
+
+class IoportCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.ioport = ""
+        self.context = None
+
+    def to_string(self):
+        return "ioportcon %s %s" % (self.ioport, str(self.context))
+
+class PciDeviceCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.device = ""
+        self.context = None
+
+    def to_string(self):
+        return "pcidevicecon %s %s" % (self.device, str(self.context))
 
 # Reference policy specific types
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
