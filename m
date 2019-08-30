Return-Path: <SRS0=26Hx=W2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CA2C3A59B
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 15:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EAD23407
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 15:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="gY4+Od/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3PmC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:42:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39447 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3PmC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Aug 2019 11:42:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so6497673qki.6
        for <selinux@vger.kernel.org>; Fri, 30 Aug 2019 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZn9oMK/GOAi4UAPA2H5zE5W7cGG/mvdUGWpo93Qug4=;
        b=gY4+Od/wVyd0lsxQgncHW/OyzeLxqhNL6BfAife+rLhHHTI6/1ambZ9L5CSkj/aFL4
         dgbhdAm30ATLi7pU4IFYrY/ESTb3ObH77e9FdugAsbLy+jMJlpVPKdBMLJbYhBU1b+g4
         pWOwKfLsW+PXU4BIS6qGXtLdwNU14QbVtn7JUjmgAv0VlWLZBlQqGc9S7/YSq5TUWVrL
         uYRxkffS722wQvbAyZpkafK7YJUzDhZ1D59negqiS8++dtaE9dwCso2DW1y3gvcqC+9L
         vFmRPdSgf1KDh080imxWpuyvh7qgV1Lz9whvu0czOxDULQv1RaNpnnSdE0HJyNCWC5dH
         M4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZn9oMK/GOAi4UAPA2H5zE5W7cGG/mvdUGWpo93Qug4=;
        b=NAoX5Buesigw4gAXwDI7VYZF7uU0j08ux390qsOD8shZlg0YOSHNIqLGrnLlngvun9
         IQEO1szWgAV0bjb1d0qWobx2c5ZpTHztZ04dBjxLfFBK5DSPCrxBZkCielzvivvYv+xR
         RaADXXKBU3PQb3aI+oyNqc1nR76uUhZPO9FEtZRtWB+x4LbuJZHcJcOqJYHVKbHeIoV9
         HjHMXlztAsOLE0BM/qdlaCoiTKIcHy1gEH8UW8++9UuyvVRrE91Sr2h4o1AIfrw82xP3
         kiRFIlDkfXY0c4Dtizx3TcANd1QkzaRw8fEqGbGb1/ltwUG+W3DGIGIRtLautoo1NyVl
         Dtig==
X-Gm-Message-State: APjAAAUpI8/myZ8cZ8drMp8Qa5JA9e1cK0esK03FkXrFKjzWMSgTKcPi
        jasxnpIbm6gej+eA016jNQT8Cgu6A1M=
X-Google-Smtp-Source: APXvYqz0Vhjn14tz0s0oZ7GHCdxGF3mpJnaeCfL+Z6sSCNQdo+Ih0VI+wA0FXT7A7rYmpDBrDyDRnQ==
X-Received: by 2002:a37:7b06:: with SMTP id w6mr15995934qkc.436.1567179721061;
        Fri, 30 Aug 2019 08:42:01 -0700 (PDT)
Received: from fedora30.localdomain (pool-71-121-242-40.bltmmd.fios.verizon.net. [71.121.242.40])
        by smtp.gmail.com with ESMTPSA id y1sm2811505qti.49.2019.08.30.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 08:42:00 -0700 (PDT)
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH v2] Add default_range glblub support
Date:   Fri, 30 Aug 2019 08:41:40 -0700
Message-Id: <20190830154139.28214-1-joshua.brindle@crunchydata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Policy developers can set a default_range default to glblub and
computed contexts will be the intersection of the ranges of the
source and target contexts. This can be used by MLS userspace
object managers to find the range of clearances that two contexts
have in common. An example usage is computing a transition between
the network context and the context of a user logging into an MLS
application.

For example, one can add a default with
this cil:

(defaultrange db_table glblub);

or in te (base module only):

default_range db_table glblub;

and then test using the compute_create utility:

$ ./compute_create system_u:system_r:kernel_t:s0:c1,c2,c5-s0:c1.c20 system_u:system_r:kernel_t:s0:c0.c20-s0:c0.c36 db_table
system_u:object_r:kernel_t:s0:c1,c2,c5-s0:c1.c20

Some example range transitions are:

    User Permitted Range | Network Device Label | Computed Label
    ---------------------|----------------------|----------------
    S0-S1:c0.c12         | S0                   | S0
    S0-S1:c0.c12         | S0-S1:c0.c1024       | S0-S1:c0.c12
    S0-S4:c0.c512        | S1-S1:c0.c1024       | S1-S1:c0.c512
    S0-S16:c0,c2         | S4-S6:c0.c128        | S4-S6:c0,c2
    S0-S4                | S2-S6                | S2-S4
    S0-S4                | S5-S8                | INVALID
    S5-S8                | S0-S4                | INVALID
    S6:c0,c2-S7:c4,c5    | S0:c2,c4-S6:c5.c100  | S6:c2-S6:c5

Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
---
 checkpolicy/policy_parse.y                  |  4 +++-
 checkpolicy/policy_scan.l                   |  2 ++
 libsepol/cil/src/cil.c                      |  1 +
 libsepol/cil/src/cil_build_ast.c            | 11 +++++----
 libsepol/cil/src/cil_internal.h             |  2 ++
 libsepol/cil/src/cil_policy.c               |  3 +++
 libsepol/include/sepol/policydb/context.h   |  5 +++++
 libsepol/include/sepol/policydb/mls_types.h | 25 +++++++++++++++++++++
 libsepol/include/sepol/policydb/policydb.h  |  7 ++++--
 libsepol/src/kernel_to_cil.c                |  3 +++
 libsepol/src/kernel_to_conf.c               |  3 +++
 libsepol/src/mls.c                          |  2 ++
 libsepol/src/module_to_cil.c                |  1 +
 libsepol/src/policydb.c                     | 22 ++++++++++++++++++
 libsepol/src/write.c                        | 12 ++++++++++
 15 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 247bd4ee..abb7d885 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -155,7 +155,7 @@ typedef int (* require_func_t)(int pass);
 %token PERMISSIVE
 %token FILESYSTEM
 %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
-%token LOW_HIGH LOW HIGH
+%token LOW_HIGH LOW HIGH GLBLUB
 
 %left OR
 %left XOR
@@ -247,6 +247,8 @@ default_range_def	: DEFAULT_RANGE names SOURCE LOW ';'
 			{if (define_default_range(DEFAULT_TARGET_HIGH)) return -1; }
 			| DEFAULT_RANGE names TARGET LOW_HIGH ';'
 			{if (define_default_range(DEFAULT_TARGET_LOW_HIGH)) return -1; }
+			| DEFAULT_RANGE names GLBLUB';'
+			{if (define_default_range(DEFAULT_GLBLUB)) return -1; }
 			;
 opt_mls			: mls
                         | 
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index e93ccb64..e2f676e4 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -256,6 +256,8 @@ high |
 HIGH				{ return(HIGH); }
 low |
 LOW				{ return(LOW); }
+glblub |
+GLBLUB				{ return(GLBLUB); }
 "/"[^ \n\r\t\f]*	        { return(PATH); }
 \""/"[^\"\n]*\" 		{ return(QPATH); }
 \"[^"/"\"\n]+\"	{ return(FILENAME); }
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 2a7ec063..de729cf8 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -227,6 +227,7 @@ static void cil_init_keys(void)
 	CIL_KEY_LOW = cil_strpool_add("low");
 	CIL_KEY_HIGH = cil_strpool_add("high");
 	CIL_KEY_LOW_HIGH = cil_strpool_add("low-high");
+	CIL_KEY_GLBLUB = cil_strpool_add("glblub");
 	CIL_KEY_ROOT = cil_strpool_add("<root>");
 	CIL_KEY_NODE = cil_strpool_add("<node>");
 	CIL_KEY_PERM = cil_strpool_add("perm");
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index b90b0f60..ee1c51ce 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5894,7 +5894,7 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 		CIL_SYN_STRING,
 		CIL_SYN_STRING | CIL_SYN_LIST,
 		CIL_SYN_STRING,
-		CIL_SYN_STRING,
+		CIL_SYN_STRING | CIL_SYN_END,
 		CIL_SYN_END
 	};
 	int syntax_len = sizeof(syntax)/sizeof(*syntax);
@@ -5917,8 +5917,8 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 	}
 
 	object = parse_current->next->next->data;
-	range = parse_current->next->next->next->data;
 	if (object == CIL_KEY_SOURCE) {
+		range = parse_current->next->next->next->data;
 		if (range == CIL_KEY_LOW) {
 			def->object_range = CIL_DEFAULT_SOURCE_LOW;
 		} else if (range == CIL_KEY_HIGH) {
@@ -5930,7 +5930,8 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 			rc = SEPOL_ERR;
 			goto exit;
 		}
-	} else if (parse_current->next->next->data == CIL_KEY_TARGET) {
+	} else if (object == CIL_KEY_TARGET) {
+		range = parse_current->next->next->next->data;
 		if (range == CIL_KEY_LOW) {
 			def->object_range = CIL_DEFAULT_TARGET_LOW;
 		} else if (range == CIL_KEY_HIGH) {
@@ -5942,8 +5943,10 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 			rc = SEPOL_ERR;
 			goto exit;
 		}
+	} else if (object == CIL_KEY_GLBLUB) {
+		def->object_range = CIL_DEFAULT_GLBLUB;
 	} else {
-		cil_log(CIL_ERR,"Expected either \'source\' or \'target\'\n");
+		cil_log(CIL_ERR,"Expected \'source\', \'target\', or \'glblub\'\n");
 		rc = SEPOL_ERR;
 		goto exit;
 	}
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 6ff32285..30fab649 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -149,6 +149,7 @@ char *CIL_KEY_TARGET;
 char *CIL_KEY_LOW;
 char *CIL_KEY_HIGH;
 char *CIL_KEY_LOW_HIGH;
+char *CIL_KEY_GLBLUB;
 char *CIL_KEY_HANDLEUNKNOWN;
 char *CIL_KEY_HANDLEUNKNOWN_ALLOW;
 char *CIL_KEY_HANDLEUNKNOWN_DENY;
@@ -941,6 +942,7 @@ enum cil_default_object_range {
 	CIL_DEFAULT_TARGET_LOW      = DEFAULT_TARGET_LOW,
 	CIL_DEFAULT_TARGET_HIGH     = DEFAULT_TARGET_HIGH,
 	CIL_DEFAULT_TARGET_LOW_HIGH = DEFAULT_TARGET_LOW_HIGH,
+	CIL_DEFAULT_GLBLUB          = DEFAULT_GLBLUB,
 };
 
 /* Default labeling behavior for range */
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 1adf22a3..06d7d74e 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -834,6 +834,9 @@ static void cil_default_ranges_to_policy(FILE *out, struct cil_list *defaults)
 		case CIL_DEFAULT_TARGET_LOW_HIGH:
 			fprintf(out," %s %s", CIL_KEY_TARGET, CIL_KEY_LOW_HIGH);
 			break;
+		case CIL_DEFAULT_GLBLUB:
+			fprintf(out," %s", CIL_KEY_GLBLUB);
+			break;
 		default:
 			break;
 		}
diff --git a/libsepol/include/sepol/policydb/context.h b/libsepol/include/sepol/policydb/context.h
index c27c3341..37cdc591 100644
--- a/libsepol/include/sepol/policydb/context.h
+++ b/libsepol/include/sepol/policydb/context.h
@@ -92,6 +92,11 @@ out:
 	return rc;
 }
 
+static inline int mls_context_glblub(context_struct_t *dst, context_struct_t *c1, context_struct_t *c2)
+{
+	return mls_range_glblub(&dst->range, &c1->range, &c2->range);
+}
+
 static inline int mls_context_cmp(context_struct_t * c1, context_struct_t * c2)
 {
 	return (mls_level_eq(&c1->range.level[0], &c2->range.level[0]) &&
diff --git a/libsepol/include/sepol/policydb/mls_types.h b/libsepol/include/sepol/policydb/mls_types.h
index a06723be..450c9564 100644
--- a/libsepol/include/sepol/policydb/mls_types.h
+++ b/libsepol/include/sepol/policydb/mls_types.h
@@ -32,6 +32,7 @@
 
 #include <stdint.h>
 #include <stdlib.h>
+#include <sys/param.h>
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/flask_types.h>
 
@@ -48,6 +49,30 @@ typedef struct mls_range {
 	mls_level_t level[2];	/* low == level[0], high == level[1] */
 } mls_range_t;
 
+static inline int mls_range_glblub(struct mls_range *dst, struct mls_range *r1, struct mls_range *r2)
+{
+	if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens) {
+		// These ranges have no common sensitivities
+		return -1;
+	}
+
+	// Take the greatest of the low
+	dst->level[0].sens = MAX(r1->level[0].sens, r2->level[0].sens);
+	// Take the least of the high
+	dst->level[1].sens = MIN(r1->level[1].sens, r2->level[1].sens);
+
+	if (ebitmap_and(&dst->level[0].cat, &r1->level[0].cat, &r2->level[0].cat) < 0) {
+		return -1;
+	}
+
+	if (ebitmap_and(&dst->level[1].cat, &r1->level[1].cat, &r2->level[1].cat) < 0) {
+		return -1;
+	}
+
+	return 0;
+}
+
+
 static inline int mls_level_cpy(struct mls_level *dst, struct mls_level *src)
 {
 
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index a279382e..b0d2fdfc 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -130,6 +130,7 @@ typedef struct class_datum {
 #define DEFAULT_TARGET_LOW	4
 #define DEFAULT_TARGET_HIGH	5
 #define DEFAULT_TARGET_LOW_HIGH	6
+#define DEFAULT_GLBLUB 		7
 	char default_range;
 } class_datum_t;
 
@@ -741,10 +742,11 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_XEN_DEVICETREE		30 /* Xen-specific */
 #define POLICYDB_VERSION_XPERMS_IOCTL	30 /* Linux-specific */
 #define POLICYDB_VERSION_INFINIBAND		31 /* Linux-specific */
+#define POLICYDB_VERSION_GLBLUB		32
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_INFINIBAND
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_GLBLUB
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
@@ -765,9 +767,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_CONSTRAINT_NAMES  17
 #define MOD_POLICYDB_VERSION_XPERMS_IOCTL  18
 #define MOD_POLICYDB_VERSION_INFINIBAND		19
+#define MOD_POLICYDB_VERSION_GLBLUB		20
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_INFINIBAND
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_GLBLUB
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 320af37b..01f5bc5b 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -698,6 +698,9 @@ static int write_default_range_to_cil(FILE *out, char *class_name, class_datum_t
 	case DEFAULT_TARGET_LOW_HIGH:
 		dft = "target low-high";
 		break;
+	case DEFAULT_GLBLUB:
+		dft = "glblub";
+		break;
 	default:
 		sepol_log_err("Unknown default type value: %i", class->default_range);
 		return -1;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 930bafab..a44ba30a 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -673,6 +673,9 @@ static int write_default_range_to_conf(FILE *out, char *class_name, class_datum_
 	case DEFAULT_TARGET_LOW_HIGH:
 		dft = "target low-high";
 		break;
+	case DEFAULT_GLBLUB:
+		dft = "glblub";
+		break;
 	default:
 		sepol_log_err("Unknown default type value: %i", class->default_range);
 		return -1;
diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index 63ad1bcb..6ff9a846 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -643,6 +643,8 @@ int mls_compute_sid(policydb_t * policydb,
 			return mls_context_cpy_high(newcontext, tcontext);
 		case DEFAULT_TARGET_LOW_HIGH:
 			return mls_context_cpy(newcontext, tcontext);
+		case DEFAULT_GLBLUB:
+			return mls_context_glblub(newcontext, scontext, tcontext);
 		}
 
 		/* Fallthrough */
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 1af166c9..c48a897d 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2033,6 +2033,7 @@ static int class_to_cil(int indent, struct policydb *pdb, struct avrule_block *U
 		case DEFAULT_TARGET_LOW:		dflt = "target low";	break;
 		case DEFAULT_TARGET_HIGH:		dflt = "target high";	break;
 		case DEFAULT_TARGET_LOW_HIGH:	dflt = "target low-high";	break;
+		case DEFAULT_GLBLUB:		dflt = "glblub";		break;
 		default:
 			log_err("Unknown default range value: %i", class->default_range);
 			rc = -1;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 69bcb4d5..67037b6d 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -194,6 +194,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_GLBLUB,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBENDPORT + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -306,6 +313,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_GLBLUB,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBENDPORT + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -418,6 +432,14 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_GLBLUB,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+
 };
 
 #if 0
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index dee7b4a3..c6be2be2 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -46,6 +46,11 @@
 #include "private.h"
 #include "mls.h"
 
+#define glblub_version ((p->policy_type == POLICY_KERN && \
+		     p->policyvers >= POLICYDB_VERSION_GLBLUB) || \
+		    (p->policy_type == POLICY_BASE && \
+		     p->policyvers >= MOD_POLICYDB_VERSION_GLBLUB))
+
 struct policy_data {
 	struct policy_file *fp;
 	struct policydb *p;
@@ -1034,6 +1039,13 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	     p->policyvers >= MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS)) {
 		buf[0] = cpu_to_le32(cladatum->default_user);
 		buf[1] = cpu_to_le32(cladatum->default_role);
+		if (!glblub_version && cladatum->default_range == DEFAULT_GLBLUB) {
+			WARN(fp->handle,
+                             "class %s default_range set to GLBLUB but policy version is %d (%d required), discarding",
+                             p->p_class_val_to_name[cladatum->s.value - 1], p->policyvers,
+                             p->policy_type == POLICY_KERN? POLICYDB_VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
+                        cladatum->default_range = 0;
+                }
 		buf[2] = cpu_to_le32(cladatum->default_range);
 		items = put_entry(buf, sizeof(uint32_t), 3, fp);
 		if (items != 3)
-- 
2.21.0

