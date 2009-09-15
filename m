Subject: [PATCH 2/3] checkpolicy: Add support for multiple target OSes
From: pjnuzzi <pjnuzzi@tycho.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1253031316.3209.116.camel@moss-stripedbass.epoch.ncsc.mil>
References: <1253031316.3209.116.camel@moss-stripedbass.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 12:37:12 -0400
Message-Id: <1253032632.3209.118.camel@moss-stripedbass.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support for multiple target OSes by adding the -t target option to
checkpolicy.  Implemented the new Xen ocontext identifiers pirqcon,
pcidevicecon, iomemcon and ioportcon.  

Signed-off-by: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>

---
checkpolicy/checkpolicy.c   |   20 ++-
checkpolicy/policy_define.c |  262
++++++++++++++++++++++++++++++++++++++++++++
checkpolicy/policy_define.h |    4
checkpolicy/policy_parse.y  |   29 ++++
checkpolicy/policy_scan.l   |   10 +
5 files changed, 320 insertions(+), 5 deletions(-)

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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
