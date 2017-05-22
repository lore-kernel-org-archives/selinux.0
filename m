Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MD8oLb011891
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 09:08:50 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v3 1/9] checkpolicy: Add support for ibpkeycon labels
Date: Mon, 22 May 2017 16:08:23 +0300
Message-Id: <1495458511-46724-2-git-send-email-danielj@mellanox.com>
In-Reply-To: <1495458511-46724-1-git-send-email-danielj@mellanox.com>
References: <1495458511-46724-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Add checkpolicy support for scanning and parsing ibpkeycon labels. Also
create a new ocontext for Infiniband Pkeys and define a new policydb
version for infiniband support.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

---
v1:
Stephen Smalley:
- Always use s6_addr instead of s6_addr32.
- Add comment about POLICYDB_VERSION_INFINIBAND being linux specific.

v2:
Stephen Smalley:
- Store subnet_prefix as 8 bytes.
---
 checkpolicy/policy_define.c                | 107 +++++++++++++++++++++++++++++
 checkpolicy/policy_define.h                |   1 +
 checkpolicy/policy_parse.y                 |  15 +++-
 checkpolicy/policy_scan.l                  |   3 +
 libsepol/include/sepol/policydb/policydb.h |  30 +++++---
 5 files changed, 144 insertions(+), 12 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 8fab214b..e73ec8f7 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -20,6 +20,7 @@
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2008 Tresys Technology, LLC
  * Copyright (C) 2007 Red Hat Inc.
+ * Copyright (C) 2017 Mellanox Techonologies Inc.
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
@@ -5057,6 +5058,112 @@ int define_port_context(unsigned int low, unsigned int high)
 	return -1;
 }
 
+int define_ibpkey_context(unsigned int low, unsigned int high)
+{
+	ocontext_t *newc, *c, *l, *head;
+	struct in6_addr subnet_prefix;
+	char *id;
+	int rc = 0;
+
+	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
+		yyerror("ibpkeycon not supported for target");
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
+	id = queue_remove(id_queue);
+	if (!id) {
+		yyerror("failed to read the subnet prefix");
+		rc = -1;
+		goto out;
+	}
+
+	rc = inet_pton(AF_INET6, id, &subnet_prefix);
+	free(id);
+	if (rc < 1) {
+		yyerror("failed to parse the subnet prefix");
+		if (rc == 0)
+			rc = -1;
+		goto out;
+	}
+
+	if (subnet_prefix.s6_addr[2] || subnet_prefix.s6_addr[3]) {
+		yyerror("subnet prefix should be 0's in the low order 64 bits.");
+		rc = -1;
+		goto out;
+	}
+
+	if (low > 0xffff || high > 0xffff) {
+		yyerror("pkey value too large, pkeys are 16 bits.");
+		rc = -1;
+		goto out;
+	}
+
+	memcpy(&newc->u.ibpkey.subnet_prefix, &subnet_prefix.s6_addr[0],
+	       sizeof(newc->u.ibpkey.subnet_prefix));
+
+	newc->u.ibpkey.low_pkey = low;
+	newc->u.ibpkey.high_pkey = high;
+
+	if (low > high) {
+		yyerror2("low pkey %d exceeds high pkey %d", low, high);
+		rc = -1;
+		goto out;
+	}
+
+	rc = parse_security_context(&newc->context[0]);
+	if (rc)
+		goto out;
+
+	/* Preserve the matching order specified in the configuration. */
+	head = policydbp->ocontexts[OCON_IBPKEY];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+		unsigned int low2, high2;
+
+		low2 = c->u.ibpkey.low_pkey;
+		high2 = c->u.ibpkey.high_pkey;
+
+		if (low == low2 && high == high2 &&
+		    c->u.ibpkey.subnet_prefix == newc->u.ibpkey.subnet_prefix) {
+			yyerror2("duplicate ibpkeycon entry for %d-%d ",
+				 low, high);
+			rc = -1;
+			goto out;
+		}
+		if (low2 <= low && high2 >= high &&
+		    c->u.ibpkey.subnet_prefix == newc->u.ibpkey.subnet_prefix) {
+			yyerror2("ibpkeycon entry for %d-%d hidden by earlier entry for %d-%d",
+				 low, high, low2, high2);
+			rc = -1;
+			goto out;
+		}
+	}
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_IBPKEY] = newc;
+
+	return 0;
+
+out:
+	free(newc);
+	return rc;
+}
+
 int define_netif_context(void)
 {
 	ocontext_t *newc, *c, *head;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 9f4b6d0d..75e3683b 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -43,6 +43,7 @@ int define_level(void);
 int define_netif_context(void);
 int define_permissive(void);
 int define_polcap(void);
+int define_ibpkey_context(unsigned int low, unsigned int high);
 int define_port_context(unsigned int low, unsigned int high);
 int define_pirq_context(unsigned int pirq);
 int define_iomem_context(uint64_t low, uint64_t high);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 1ac1c96b..35b433bd 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -21,6 +21,7 @@
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2008 Tresys Technology, LLC
  * Copyright (C) 2007 Red Hat Inc.
+ * Copyright (C) 2017 Mellanox Technologies Inc.
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
@@ -135,6 +136,7 @@ typedef int (* require_func_t)(int pass);
 %token TARGET
 %token SAMEUSER
 %token FSCON PORTCON NETIFCON NODECON 
+%token IBPKEYCON
 %token PIRQCON IOMEMCON IOPORTCON PCIDEVICECON DEVICETREECON
 %token FSUSEXATTR FSUSETASK FSUSETRANS
 %token GENFSCON
@@ -170,7 +172,7 @@ base_policy             : { if (define_policy(pass, 0) == -1) return -1; }
 			  opt_default_rules opt_mls te_rbac users opt_constraints 
                          { if (pass == 1) { if (policydb_index_bools(policydbp)) return -1;}
 			   else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) return -1;}}
-			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts
+			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts opt_ibpkey_contexts
 			;
 classes			: class_def 
 			| classes class_def
@@ -713,6 +715,17 @@ port_context_def	: PORTCON identifier number security_context_def
 			| PORTCON identifier number '-' number security_context_def
 			{if (define_port_context($3,$5)) return -1;}
 			;
+opt_ibpkey_contexts     : ibpkey_contexts
+                        |
+                        ;
+ibpkey_contexts		: ibpkey_context_def
+			| ibpkey_contexts ibpkey_context_def
+			;
+ibpkey_context_def	: IBPKEYCON ipv6_addr number security_context_def
+			{if (define_ibpkey_context($3,$3)) return -1;}
+			| IBPKEYCON ipv6_addr number '-' number security_context_def
+			{if (define_ibpkey_context($3,$5)) return -1;}
+			;
 opt_netif_contexts      : netif_contexts 
                         |
                         ;
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 028bd25e..f742939a 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -12,6 +12,7 @@
  *	Added support for binary policy modules
  *
  * Copyright (C) 2003-5 Tresys Technology, LLC
+ * Copyright (C) 2017 Mellanox Technologies Inc.
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
@@ -183,6 +184,8 @@ INCOMP |
 incomp				{ return(INCOMP);}
 fscon |
 FSCON                           { return(FSCON);}
+ibpkeycon |
+IBPKEYCON			{ return(IBPKEYCON);}
 portcon |
 PORTCON				{ return(PORTCON);}
 netifcon |                     
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 99e49902..d06d2153 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -24,6 +24,7 @@
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  * Copyright (C) 2003 - 2004 Red Hat, Inc.
+ * Copyright (C) 2017 Mellanox Techonolgies Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -358,6 +359,11 @@ typedef struct ocontext {
 			uint32_t low_ioport;
 			uint32_t high_ioport;
 		} ioport;
+		struct {
+			uint64_t subnet_prefix;
+			uint16_t low_pkey;
+			uint16_t high_pkey;
+		} ibpkey;
 	} u;
 	union {
 		uint32_t sclass;	/* security class for genfs */
@@ -386,14 +392,14 @@ typedef struct genfs {
 #define SYM_NUM     8
 
 /* object context array indices */
-#define OCON_ISID  0		/* initial SIDs */
-#define OCON_FS    1		/* unlabeled file systems */
-#define OCON_PORT  2		/* TCP and UDP port numbers */
-#define OCON_NETIF 3		/* network interfaces */
-#define OCON_NODE  4		/* nodes */
-#define OCON_FSUSE 5		/* fs_use */
-#define OCON_NODE6 6		/* IPv6 nodes */
-#define OCON_GENFS 7            /* needed for ocontext_supported */
+#define OCON_ISID  0	/* initial SIDs */
+#define OCON_FS    1	/* unlabeled file systems */
+#define OCON_PORT  2	/* TCP and UDP port numbers */
+#define OCON_NETIF 3	/* network interfaces */
+#define OCON_NODE  4	/* nodes */
+#define OCON_FSUSE 5	/* fs_use */
+#define OCON_NODE6 6	/* IPv6 nodes */
+#define OCON_IBPKEY 7	/* Infiniband PKEY */
 
 /* object context array indices for Xen */
 #define OCON_XEN_ISID  	    0    /* initial SIDs */
@@ -404,7 +410,7 @@ typedef struct genfs {
 #define OCON_XEN_DEVICETREE 5    /* device tree node */
 
 /* OCON_NUM needs to be the largest index in any platform's ocontext array */
-#define OCON_NUM   7
+#define OCON_NUM   8
 
 /* section: module information */
 
@@ -726,10 +732,11 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
 #define POLICYDB_VERSION_XEN_DEVICETREE		30 /* Xen-specific */
 #define POLICYDB_VERSION_XPERMS_IOCTL	30 /* Linux-specific */
+#define POLICYDB_VERSION_INFINIBAND		31 /* Linux-specific */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_XPERMS_IOCTL
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_INFINIBAND
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
@@ -749,9 +756,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_DEFAULT_TYPE	16
 #define MOD_POLICYDB_VERSION_CONSTRAINT_NAMES  17
 #define MOD_POLICYDB_VERSION_XPERMS_IOCTL  18
+#define MOD_POLICYDB_VERSION_INFINIBAND		19
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_XPERMS_IOCTL
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_INFINIBAND
 
 #define POLICYDB_CONFIG_MLS    1
 
-- 
2.12.2
