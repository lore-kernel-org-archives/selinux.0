Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4FKo4PO023984
 for <selinux@tycho.nsa.gov>; Mon, 15 May 2017 16:50:04 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v1 4/9] checkpolicy: Add support for ibendportcon labels
Date: Mon, 15 May 2017 23:42:36 +0300
Message-Id: <1494880961-73481-5-git-send-email-danielj@mellanox.com>
In-Reply-To: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Add checkpolicy support for scanning and parsing ibendportcon labels.
Also create a new ocontext for IB end ports.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

---
v1:
Stephen Smalley:
- Check IB device name length when parsing policy.
- Use strcmp vs strncmp to compare device names.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
---
 checkpolicy/policy_define.c                | 75 ++++++++++++++++++++++++++++++
 checkpolicy/policy_define.h                |  1 +
 checkpolicy/policy_parse.y                 | 14 +++++-
 checkpolicy/policy_scan.l                  |  2 +
 libsepol/include/sepol/policydb/policydb.h |  9 +++-
 5 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index ffdc5f8..239ca37 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5162,6 +5162,81 @@ out:
 	return rc;
 }
 
+int define_ibendport_context(unsigned int port)
+{
+	ocontext_t *newc, *c, *l, *head;
+	char *id;
+	int rc = 0;
+
+	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
+		yyerror("ibendportcon not supported for target");
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
+	newc = malloc(sizeof(*newc));
+	if (!newc) {
+		yyerror("out of memory");
+		return -1;
+	}
+	memset(newc, 0, sizeof(*newc));
+
+	newc->u.ibendport.dev_name = queue_remove(id_queue);
+	if (!newc->u.ibendport.dev_name) {
+		yyerror("failed to read infiniband device name.");
+		rc = -1;
+		goto out;
+	}
+
+	if (strlen(newc->u.ibendport.dev_name) > IB_DEVICE_NAME_MAX - 1) {
+		yyerror("infiniband device name exceeds max length of 63.");
+		rc = -1;
+		goto out;
+	}
+
+	newc->u.ibendport.port = port;
+
+	if (parse_security_context(&newc->context[0])) {
+		free(newc);
+		return -1;
+	}
+
+	/* Preserve the matching order specified in the configuration. */
+	head = policydbp->ocontexts[OCON_IBENDPORT];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+		unsigned int port2;
+
+		port2 = c->u.ibendport.port;
+
+		if (port == port2 &&
+		    !strcmp(c->u.ibendport.dev_name,
+			     newc->u.ibendport.dev_name)) {
+			yyerror2("duplicate ibendportcon entry for %s port %u",
+				 newc->u.ibendport.dev_name, port);
+			rc = -1;
+			goto out;
+		}
+	}
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_IBENDPORT] = newc;
+
+	return 0;
+
+out:
+	free(newc->u.ibendport.dev_name);
+	free(newc);
+	return rc;
+}
+
 int define_netif_context(void)
 {
 	ocontext_t *newc, *c, *head;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 75e3683..50a7ba7 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -44,6 +44,7 @@ int define_netif_context(void);
 int define_permissive(void);
 int define_polcap(void);
 int define_ibpkey_context(unsigned int low, unsigned int high);
+int define_ibendport_context(unsigned int port);
 int define_port_context(unsigned int low, unsigned int high);
 int define_pirq_context(unsigned int pirq);
 int define_iomem_context(uint64_t low, uint64_t high);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 35b433b..6b406c8 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -137,6 +137,7 @@ typedef int (* require_func_t)(int pass);
 %token SAMEUSER
 %token FSCON PORTCON NETIFCON NODECON 
 %token IBPKEYCON
+%token IBENDPORTCON
 %token PIRQCON IOMEMCON IOPORTCON PCIDEVICECON DEVICETREECON
 %token FSUSEXATTR FSUSETASK FSUSETRANS
 %token GENFSCON
@@ -172,7 +173,7 @@ base_policy             : { if (define_policy(pass, 0) == -1) return -1; }
 			  opt_default_rules opt_mls te_rbac users opt_constraints 
                          { if (pass == 1) { if (policydb_index_bools(policydbp)) return -1;}
 			   else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) return -1;}}
-			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts opt_ibpkey_contexts
+			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts opt_ibpkey_contexts opt_ibendport_contexts
 			;
 classes			: class_def 
 			| classes class_def
@@ -702,7 +703,7 @@ fs_contexts		: fs_context_def
 fs_context_def		: FSCON number number security_context_def security_context_def
 			{if (define_fs_context($2,$3)) return -1;}
 			;
-net_contexts		: opt_port_contexts opt_netif_contexts opt_node_contexts 
+net_contexts		: opt_port_contexts opt_netif_contexts opt_node_contexts
 			;
 opt_port_contexts       : port_contexts
                         |
@@ -726,6 +727,15 @@ ibpkey_context_def	: IBPKEYCON ipv6_addr number security_context_def
 			| IBPKEYCON ipv6_addr number '-' number security_context_def
 			{if (define_ibpkey_context($3,$5)) return -1;}
 			;
+opt_ibendport_contexts	: ibendport_contexts
+			|
+			;
+ibendport_contexts	: ibendport_context_def
+                        | ibendport_contexts ibendport_context_def
+                        ;
+ibendport_context_def	: IBENDPORTCON identifier number security_context_def
+                        {if (define_ibendport_context($3)) return -1;}
+                        ;
 opt_netif_contexts      : netif_contexts 
                         |
                         ;
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index f742939..e6c4898 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -186,6 +186,8 @@ fscon |
 FSCON                           { return(FSCON);}
 ibpkeycon |
 IBPKEYCON			{ return(IBPKEYCON);}
+ibendportcon |
+IBENDPORTCON			{ return(IBENDPORTCON);}
 portcon |
 PORTCON				{ return(PORTCON);}
 netifcon |                     
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 844191c..ed5730b 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -73,6 +73,8 @@
 extern "C" {
 #endif
 
+#define IB_DEVICE_NAME_MAX 64
+
 /*
  * A datum type is defined for each kind of symbol 
  * in the configuration data:  individual permissions, 
@@ -364,6 +366,10 @@ typedef struct ocontext {
 			uint16_t low_pkey;
 			uint16_t high_pkey;
 		} ibpkey;
+		struct {
+			char *dev_name;
+			uint8_t port;
+		} ibendport;
 	} u;
 	union {
 		uint32_t sclass;	/* security class for genfs */
@@ -400,6 +406,7 @@ typedef struct genfs {
 #define OCON_FSUSE 5	/* fs_use */
 #define OCON_NODE6 6	/* IPv6 nodes */
 #define OCON_IBPKEY 7	/* Infiniband PKEY */
+#define OCON_IBENDPORT 8	/* Infiniband End Port */
 
 /* object context array indices for Xen */
 #define OCON_XEN_ISID  	    0    /* initial SIDs */
@@ -410,7 +417,7 @@ typedef struct genfs {
 #define OCON_XEN_DEVICETREE 5    /* device tree node */
 
 /* OCON_NUM needs to be the largest index in any platform's ocontext array */
-#define OCON_NUM   8
+#define OCON_NUM   9
 
 /* section: module information */
 
-- 
2.7.4
