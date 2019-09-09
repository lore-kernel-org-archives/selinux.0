Return-Path: <SRS0=qD/R=XE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C278CC4740C
	for <selinux@archiver.kernel.org>; Mon,  9 Sep 2019 18:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C7C206A5
	for <selinux@archiver.kernel.org>; Mon,  9 Sep 2019 18:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="iIqAqabv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfIISGI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:06:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46979 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfIISGH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Sep 2019 14:06:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id v11so17177992qto.13
        for <selinux@vger.kernel.org>; Mon, 09 Sep 2019 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+DZgyduNGSMybG27tPN8+Wt9ibYQ/Tk2fGlZhQki28=;
        b=iIqAqabvQZDSR7axT5PNw7aemijEjfYsNZBlb/x/4mgMWwhvqdVz1TbeXWxEdfFSAc
         +LO1uIUJ8Wb2nDtVDHvL4JeXeBaCyLPzokNytTptTBLLfVVTUoRwqaHofhZfIQRk+Y9Z
         +Tsbn2BEIUot05KQ4BxOaohTgOx9Kyr7p+w57bY3tQ1rNuwRc5j+1X0TRaq9VeMEyNL+
         aG7xJyQ2B9wan0pqMv0jT+H/8EjNGsnFEDPj+Fy7WT1d53weX3BUvkSzzC6ABMti2aab
         OSErPI02FkpbogmK6Z8K9RKum7SfB/7luYH68MwEphhBixxjoE/mPjeJsiQ9nePflKDV
         rWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+DZgyduNGSMybG27tPN8+Wt9ibYQ/Tk2fGlZhQki28=;
        b=ooSKpuPLCGGdLL7W+ZmiNbEKe9CjiB4GnfxaIvSFdBeo2P/9lpcCdWuH76fncDcg8z
         VhwPGEz7s9tvD7JLJN2/vURgqDFwyMYhcxI32+gWCKlRzGc0K0BRDaXbrKFyX71xJ+J5
         Q+ZyTP5LVK/MpfDUi1irseiC6E/zo37C+RtFI52aO0Q1n/xeeBL4yYc5fEaIPdEmfzNs
         KIDNz1fjdGzlt09usu1Nbbu/ieqruU3heQpz1NVTsIy8BM5lp99JdHSVtX+uQ+fsipFq
         jG15gay6APGHryvJ3SzeG6o8YXaW47xLK/4WT2HLJCmfSAwBBv3ypcthDaf2fV2olrAi
         /ncw==
X-Gm-Message-State: APjAAAUveexDdaY+aWvvVZ1QC3S0FyXG6Vx/PRVK275ruHfGfd38HxzB
        JR+U5fK9Rk52OrTRxaqLNe9SLtNXuNM=
X-Google-Smtp-Source: APXvYqwWibqdRRMV12q1i+TW7i3P0frkaE95qwemC4EPimcVfeY0tsp/h2UXrW1Tnjy1aJbi35CKIg==
X-Received: by 2002:ac8:1633:: with SMTP id p48mr12226146qtj.236.1568052364899;
        Mon, 09 Sep 2019 11:06:04 -0700 (PDT)
Received: from fedora30.localdomain (pool-71-121-242-40.bltmmd.fios.verizon.net. [71.121.242.40])
        by smtp.gmail.com with ESMTPSA id j80sm7283988qke.94.2019.09.09.11.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:06:04 -0700 (PDT)
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov,
        Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH v4] Add default_range glblub support
Date:   Mon,  9 Sep 2019 11:05:57 -0700
Message-Id: <20190909180557.8093-1-joshua.brindle@crunchydata.com>
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

(defaultrange db_table glblub)

or in te (base module only):

default_range db_table glblub;

and then test using the compute_create utility:

$ ./compute_create system_u:system_r:kernel_t:s0:c1,c2,c5-s0:c1.c20 system_u:system_r:kernel_t:s0:c0.c20-s0:c0.c36 db_table
system_u:object_r:kernel_t:s0:c1,c2,c5-s0:c1.c20

Some example range transitions are:

User Permitted Range | Network Device Label | Computed Label
---------------------|----------------------|----------------
s0-s1:c0.c12         | s0                   | s0
s0-s1:c0.c12         | s0-s1:c0.c1023       | s0-s1:c0.c12
s0-s4:c0.c512        | s1-s1:c0.c1023       | s1-s1:c0.c512
s0-s15:c0,c2         | s4-s6:c0.c128        | s4-s6:c0,c2
s0-s4                | s2-s6                | s2-s4
s0-s4                | s5-s8                | INVALID
s5-s8                | s0-s4                | INVALID

Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
---
 checkpolicy/policy_parse.y                   |  4 ++-
 checkpolicy/policy_scan.l                    |  2 ++
 libsepol/cil/src/cil.c                       |  1 +
 libsepol/cil/src/cil_build_ast.c             | 11 ++++++---
 libsepol/cil/src/cil_internal.h              |  2 ++
 libsepol/cil/src/cil_policy.c                |  3 +++
 libsepol/include/sepol/policydb/context.h    |  5 ++++
 libsepol/include/sepol/policydb/mls_types.h  | 26 ++++++++++++++++++++
 libsepol/include/sepol/policydb/policydb.h   |  7 ++++--
 libsepol/src/kernel_to_cil.c                 |  3 +++
 libsepol/src/kernel_to_conf.c                |  3 +++
 libsepol/src/mls.c                           |  2 ++
 libsepol/src/module_to_cil.c                 |  1 +
 libsepol/src/policydb.c                      | 22 +++++++++++++++++
 libsepol/src/write.c                         | 12 +++++++++
 secilc/docs/cil_default_object_statements.md | 12 ++++++---
 16 files changed, 105 insertions(+), 11 deletions(-)

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
index a06723be..0ba6d9de 100644
--- a/libsepol/include/sepol/policydb/mls_types.h
+++ b/libsepol/include/sepol/policydb/mls_types.h
@@ -30,8 +30,10 @@
 #ifndef _SEPOL_POLICYDB_MLS_TYPES_H_
 #define _SEPOL_POLICYDB_MLS_TYPES_H_
 
+#include <errno.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <sys/param.h>
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/flask_types.h>
 
@@ -48,6 +50,30 @@ typedef struct mls_range {
 	mls_level_t level[2];	/* low == level[0], high == level[1] */
 } mls_range_t;
 
+static inline int mls_range_glblub(struct mls_range *dst, struct mls_range *r1, struct mls_range *r2)
+{
+	if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens) {
+		/* These ranges have no common sensitivities */
+		return -EINVAL;
+	}
+
+	/* Take the greatest of the low */
+	dst->level[0].sens = MAX(r1->level[0].sens, r2->level[0].sens);
+	/* Take the least of the high */
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
diff --git a/secilc/docs/cil_default_object_statements.md b/secilc/docs/cil_default_object_statements.md
index 73d84d6d..80ccabe7 100644
--- a/secilc/docs/cil_default_object_statements.md
+++ b/secilc/docs/cil_default_object_statements.md
@@ -143,11 +143,11 @@ When creating a new `socket` object, the [`type`](cil_type_statements.md#type) c
 defaultrange
 ------------
 
-Allows the default level or range to be taken from the source or target context when computing a new context for the object [`class`](cil_class_and_permission_statements.md#class) identifier. Requires policy version 27.
+Allows the default level or range to be taken from the source, target, or both contexts when computing a new context for the object [`class`](cil_class_and_permission_statements.md#class) identifier. Requires policy version 27. glblub as the default requires policy version 32.
 
 **Statement definition:**
 
-    (defaultrange class_id default range)
+    (defaultrange class_id default <range>)
 
 **Where:**
 
@@ -167,11 +167,11 @@ Allows the default level or range to be taken from the source or target context
 </tr>
 <tr class="odd">
 <td align="left"><p><code>default</code></p></td>
-<td align="left"><p>A keyword of either <code>source</code> or <code>target</code>.</p></td>
+<td align="left"><p>A keyword of either <code>source</code>, <code>target</code>, or <code>glblub</code>.</p></td>
 </tr>
 <tr class="even">
 <td align="left"><p><code>range</code></p></td>
-<td align="left"><p>A keyword of either <code>low</code>, <code>high</code> or <code>low-high</code>.</p></td>
+<td align="left"><p>A keyword of either <code>low</code>, <code>high</code>, or <code>low-high</code>.</p></td>
 </tr>
 </tbody>
 </table>
@@ -181,3 +181,7 @@ Allows the default level or range to be taken from the source or target context
 When creating a new `file` object, the appropriate `range` component of the new security context will be taken from the `target` context:
 
     (defaultrange file target low_high)
+
+MLS userspace object managers may need to compute the common parts of a range such that the object is created with the range common to the subject and containing object:
+
+    (defaultrange db_table glblub)
-- 
2.21.0

