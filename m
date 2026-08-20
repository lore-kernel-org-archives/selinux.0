Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EF391501
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235738; cv=none; b=aFitVNtvCO5JNV5K/mAtUOhOCNQ1Ct37xCAMn7svehQxSxeb7GSnd8CynfkwgGxmc20Lsv2I8ZnrqOGNh/P36Sj8turuH7SFuaAVy2zN7FYpy2c24R17O9xIF3zRiLSjla2otTdWI1fbmmHMUUPm4uhX2de+B1WNoi/wv6YuCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235738; c=relaxed/simple;
	bh=9PS0gP7vBhOcoeSiYuOg2uOHBWLwOkLyOaSLRZgAHyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+h2QpAplGjgI1qz9hKw6H8hcuzQ9pqp0n7V02bGlHaVccynnbJczM68+B/sEQfQqKi6q6Rg2RKziMjqMZs84lZsFzWRjaXSiyWHXzap53ftpNjQChbRdYG+OmQPkd/1jfH7vpbY5Nf14oP+k2IbINSY9/sv7rSImWiFrjw5a60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBjt8rku; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBjt8rku"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-902e4af2d9dso7086646d6.0
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787235735; x=1787840535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YCwRI3QfvHY20jWbjQAioNf3tnuuDpjtLWLQ7ibBcCw=;
        b=BBjt8rkuxRnjW0Wvx6Jon5SYmzDEimaIHMlJnBDLBrmprfAERDb8L5CQRCVGSj5pp+
         UhHvvrF922JZ3QBqoaj9zBgFZwv5PO0WCcfgLmAcLWiTDg5vi/Fb0OwWHzyjM6uVCBDL
         AlpLTegHfFL6qDhumxSMSQAaQILzQWpMS1zWB1Uqo9NDrvQEKdCKpzgTekjI+QxI26ZA
         xBGLdC3xPuzVKqMfTDPBvsT3oHgGqhlK4cYUUwzWVpm964B9ug8KAWYrXk7R7fDeQ7xi
         9Q7/CNS4/iVkEe+TECQr56gOJo2mnI5J+NV+Z7H66hdHXVjcvOE1xnTRuoRikHSEuQWe
         OuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787235735; x=1787840535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YCwRI3QfvHY20jWbjQAioNf3tnuuDpjtLWLQ7ibBcCw=;
        b=nySNr99bz3HdzSGMKY5ffDmY7VbiPa3TYxKectVHWs77Pt/Q/HOZJbRcHAuW4tVezw
         BbmA9JM1dYDNtk+sEu1xmpFsB8aW5Zm0cStDcEjxMQpKgUb1dTRMRmdL+TYLjJeSpRwS
         3j/nj9/r9rRcuLzUc6GdRBeVK05XqeyMzhSf+Sm95rq66GgVLEh1jEbbZd/aFtEc2bFK
         nTpM7BmxqMiPQThhABe8D1RYDoQIsSx/0XJndQIXhYZnQKlAN2ZWJu9xrccHeFQwcgbK
         xujtznJhyEBwt9vhhgv7lFO7j6/qbXXwZibYKRZO9xn94c9rQIQ08gDaNY5251dBCpSb
         wVug==
X-Gm-Message-State: AOJu0YzDcS/snhVoP2H/ouux9glK3ujyQL+GK/9XNFPBb6lyLduY2PLz
	ZsMODLyyh7uGFgVhnk+xT9NFZdd8jjAVTQSNOJ3dmxwP+kDzIT50f5O7ulEpxQ==
X-Gm-Gg: AR+sD13TVcfc2vfKmQfz/PRNx9xtVqYj2+8BiQFPWZH9dY9cJWQXu9Wn+J4KZWXRRzN
	hAoe+/7dn39hDps7yjq7T/POIVqplTNfQ25I/QoqCo1CPQ+5OE4glnJkZ5nhKU5rhjC4Nm97B7B
	LLO2if36gkwQUCMflGIFJdWBY7hiPycJ+0kQCfUQoe6U+RD6lol5pBbMD2yCZSVeh+ozdXmtKXr
	4mKF1Wm03jzgWNjw4A94jjeIZS5Ig9Ce3CM46Bd3sTU2C2fGQYP0zAT/XJXHZ7lRrs+1zU4i8+c
	jO0MMVvMIlEBgvHBS0bGjLU9Jx+Kaen9I5AsEafukXYEg2ubhxyoBGdPuD9xDHDbgQ7AcyapBJW
	lGh6ILOaTL9wvL2wAzELLtqfGs8KzITUnQ0YgO3nrkhrjtI15Rshjo8D+a0kVvTZ02t8eHP+ukD
	01tFu1+z2rDytYhMwKfKkYCkzqTY5T2TbcVOApCtFx2jeJzKeGLitOBzRfhLkPpcLGMFEvwkUI8
	f7PyFVIMhALP0eNBbn0vgl878J1yHgK64wf8ICO234JBdWCXfQ1Tg1V8/P4EOFv
X-Received: by 2002:ad4:5961:0:b0:8f1:fba2:d4aa with SMTP id 6a1803df08f44-90c6ac01335mr68723616d6.16.1787235734258;
        Thu, 20 Aug 2026 07:22:14 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2c4717sm39512796d6.49.2026.08.20.07.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:22:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] libsepol: drop support for policy versions before xperms_ioctl/xen_devicetree
Date: Thu, 20 Aug 2026 10:21:50 -0400
Message-ID: <20260820142149.15226-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC-only at this time since this would also increase our minimum
supported kernel version from v3.0 to v4.3 and might break very old
long term support distro releases that predate the kernel or libsepol
versions that support policy 30. That said, I doubt those distro
releases would ever update to latest libsepol.

Drop support for kernel and module policy versions before the
xperms_ioctl support (SELinux kernel policy version 30, modular policy
version 18) and xen_devicetree support (Xen policy version 30). Kernel
policy version 30 was first supported in Linux v4.3, Xen 4.6, and
libsepol 2.5 (20160223). Modular policy version 18 was first supported
in libsepol 2.7 aka selinux userspace release (20170804).

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md                                  |  25 ++-
 libsepol/cil/src/cil_binary.c              |  39 ++--
 libsepol/include/sepol/policydb/policydb.h |  18 +-
 libsepol/src/conditional.c                 |   6 +-
 libsepol/src/policydb.c                    | 229 ++-------------------
 libsepol/src/policydb_validate.c           |  10 +-
 libsepol/src/services.c                    |  10 +-
 libsepol/src/write.c                       | 126 +++---------
 8 files changed, 77 insertions(+), 386 deletions(-)

diff --git a/README.md b/README.md
index 3069e1a5..7e8631aa 100644
--- a/README.md
+++ b/README.md
@@ -25,9 +25,8 @@ for more information.
 
 Minimum Supported Kernel Version
 --------------------------------
-The minimum supported kernel version is Linux v3.0 (for the
-/sys/fs/selinux mount point directory) for libselinux and anything
-that uses libselinux to access selinuxfs.
+The minimum supported kernel version is Linux v4.3 to match the
+minimum supported kernel policy version by libsepol.
 
 Note that the policy build toolchain (e.g. libsepol, checkpolicy,
 checkmodule, secilc, semodule_package/expand/link) does not link with
@@ -38,16 +37,16 @@ successfully been built and run on non-Linux platforms as well
 
 Minimum Supported Policy Versions
 ---------------------------------
-The minimum kernel policy version is 24 (boundary) for the SELinux and
-Xen targets. Support for this policy version first shipped in libsepol
-2.0.34 (userspace release 20090403), Linux v2.6.28, and Xen
-4.0.0. libsepol dropped support for kernel policy versions older than
-24 starting with libsepol 3.12.
+The minimum kernel policy version is 30 (xperms_ioctl for SELinux,
+xen_devicetree for Xen). Support for this policy version first shipped
+in libsepol 2.5 (userspace release 20160223), Linux v4.3, and Xen
+4.6. libsepol dropped support for kernel policy versions older than 30
+starting with libsepol 3.12.
 
-The minimum modular policy version is 10 (boundary alias). Support for
-this modular policy version first shipped in libsepol 2.0.35
-(userspace release 20090403). libsepol dropped support for modular
-policies older than 10 starting with libsepol 3.12
+The minimum modular policy version is 18 (xperms_ioctl). Support for
+this modular policy version first shipped in libsepol 2.7 (userspace
+release 20170804). libsepol dropped support for modular policies older
+than 18 starting with libsepol 3.12.
 
 These minimum policy versions in libsepol affect:
 1. The policy build toolchain. For example, checkpolicy, checkmodule,
@@ -60,7 +59,7 @@ the minimum.
 3. SELinux policy analysis tools. For example, setools cannot read a
 policy with a version less the minimum.
 4. The Xen hypervisor, which compiles its XSM/Flask policies using
-checkpolicy, and only currently supports kernel policy versions 24 and
+checkpolicy, and only currently supports kernel policy version
 30 for the Xen target. Xen does not use binary policy modules so it is
 unaffected by changes to the minimum modular policy version.
 5. Android, which is on kernel policy version 30. There has not been
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index e99405b4..545aacdf 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2425,14 +2425,6 @@ static int __cil_cond_to_policydb_helper(struct cil_tree_node *node,
 		}
 		break;
 	case CIL_AVRULEX:
-		if (db->policy_version < POLICYDB_VERSION_COND_XPERMS) {
-			cil_tree_log(
-				node, CIL_ERR,
-				"Extended permission rules are not supported in policy version %d\n",
-				db->policy_version);
-			rc = SEPOL_ERR;
-			goto exit;
-		}
 		cil_avrule = node->data;
 		rc = cil_avrulex_to_hashtable(pdb, db, cil_avrule,
 					      &args->avrulex_xperm_tables);
@@ -3189,28 +3181,23 @@ static int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb,
 		ebitmap_node_t *tnode;
 		unsigned int i;
 
-		if (pdb->policyvers >= POLICYDB_VERSION_CONSTRAINT_NAMES) {
-			rc = __cil_get_sepol_type_datum(pdb, item->data,
-							&sepol_type);
-			if (rc != SEPOL_OK) {
-				if (FLAVOR(item->data) == CIL_TYPEATTRIBUTE) {
-					struct cil_typeattribute *attr =
-						item->data;
-					if (!attr->keep) {
-						rc = 0;
-					}
+		rc = __cil_get_sepol_type_datum(pdb, item->data, &sepol_type);
+		if (rc != SEPOL_OK) {
+			if (FLAVOR(item->data) == CIL_TYPEATTRIBUTE) {
+				struct cil_typeattribute *attr = item->data;
+				if (!attr->keep) {
+					rc = 0;
 				}
 			}
+		}
 
-			if (sepol_type) {
-				rc = ebitmap_set_bit(&expr->type_names->types,
-						     sepol_type->s.value - 1,
-						     1);
-			}
+		if (sepol_type) {
+			rc = ebitmap_set_bit(&expr->type_names->types,
+					     sepol_type->s.value - 1, 1);
+		}
 
-			if (rc != SEPOL_OK) {
-				goto exit;
-			}
+		if (rc != SEPOL_OK) {
+			goto exit;
 		}
 
 		rc = __cil_expand_type(item->data, &type_bitmap);
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 8390874d..fa7b5791 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -752,12 +752,6 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define PERM_SYMTAB_SIZE 32
 
 /* Identify specific policy version changes */
-#define POLICYDB_VERSION_BOUNDARY 24
-#define POLICYDB_VERSION_FILENAME_TRANS 25
-#define POLICYDB_VERSION_ROLETRANS 26
-#define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS 27
-#define POLICYDB_VERSION_DEFAULT_TYPE 28
-#define POLICYDB_VERSION_CONSTRAINT_NAMES 29
 #define POLICYDB_VERSION_XEN_DEVICETREE 30 /* Xen-specific */
 #define POLICYDB_VERSION_XPERMS_IOCTL 30 /* Linux-specific */
 #define POLICYDB_VERSION_INFINIBAND 31 /* Linux-specific */
@@ -768,18 +762,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_NEVERAUDIT 35 /* neveraudit domains */
 
 /* Range of policy versions we understand*/
-#define POLICYDB_VERSION_MIN POLICYDB_VERSION_BOUNDARY
+#define POLICYDB_VERSION_MIN POLICYDB_VERSION_XPERMS_IOCTL
 #define POLICYDB_VERSION_MAX POLICYDB_VERSION_NEVERAUDIT
 
 /* Module versions and specific changes*/
-#define MOD_POLICYDB_VERSION_BOUNDARY_ALIAS 10
-#define MOD_POLICYDB_VERSION_FILENAME_TRANS 11
-#define MOD_POLICYDB_VERSION_ROLETRANS 12
-#define MOD_POLICYDB_VERSION_ROLEATTRIB 13
-#define MOD_POLICYDB_VERSION_TUNABLE_SEP 14
-#define MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS 15
-#define MOD_POLICYDB_VERSION_DEFAULT_TYPE 16
-#define MOD_POLICYDB_VERSION_CONSTRAINT_NAMES 17
 #define MOD_POLICYDB_VERSION_XPERMS_IOCTL 18
 #define MOD_POLICYDB_VERSION_INFINIBAND 19
 #define MOD_POLICYDB_VERSION_GLBLUB 20
@@ -788,7 +774,7 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_NEVERAUDIT 23
 #define MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS 24
 
-#define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BOUNDARY_ALIAS
+#define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_XPERMS_IOCTL
 #define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS
 
 #define POLICYDB_CONFIG_MLS 1
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index a8070a6a..55d10344 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -592,8 +592,7 @@ int cond_read_bool(policydb_t *p, hashtab_t h, struct policy_file *fp)
 	if (str_read(&key, fp, len))
 		goto err;
 
-	if (p->policy_type != POLICY_KERN &&
-	    p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
+	if (p->policy_type != POLICY_KERN) {
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
 			goto err;
@@ -808,8 +807,7 @@ static int cond_read_node(policydb_t *p, cond_node_t *node, void *fp)
 			goto err;
 	}
 
-	if (p->policy_type != POLICY_KERN &&
-	    p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
+	if (p->policy_type != POLICY_KERN) {
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
 			goto err;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 3dd3ac4f..25d27879 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -62,13 +62,6 @@ const char *const policydb_target_strings[] = { POLICYDB_STRING,
 
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static const struct policydb_compat_info policydb_compat[] = {
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_BOUNDARY,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_XEN_PCIDEVICE + 1,
-		.target_platform = SEPOL_TARGET_XEN,
-	},
 	{
 		.type = POLICY_KERN,
 		.version = POLICYDB_VERSION_XEN_DEVICETREE,
@@ -76,48 +69,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 		.ocon_num = OCON_XEN_DEVICETREE + 1,
 		.target_platform = SEPOL_TARGET_XEN,
 	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_BOUNDARY,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_FILENAME_TRANS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_ROLETRANS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_NEW_OBJECT_DEFAULTS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_DEFAULT_TYPE,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_KERN,
-		.version = POLICYDB_VERSION_CONSTRAINT_NAMES,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
 	{
 		.type = POLICY_KERN,
 		.version = POLICYDB_VERSION_XPERMS_IOCTL,
@@ -160,62 +111,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 		.ocon_num = OCON_IBENDPORT + 1,
 		.target_platform = SEPOL_TARGET_SELINUX,
 	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_FILENAME_TRANS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_ROLETRANS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_ROLEATTRIB,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_TUNABLE_SEP,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_DEFAULT_TYPE,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_BASE,
-		.version = MOD_POLICYDB_VERSION_CONSTRAINT_NAMES,
-		.sym_num = SYM_NUM,
-		.ocon_num = OCON_NODE6 + 1,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
 	{
 		.type = POLICY_BASE,
 		.version = MOD_POLICYDB_VERSION_XPERMS_IOCTL,
@@ -265,62 +160,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 		.ocon_num = OCON_IBENDPORT + 1,
 		.target_platform = SEPOL_TARGET_SELINUX,
 	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_FILENAME_TRANS,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_ROLETRANS,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_ROLEATTRIB,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_TUNABLE_SEP,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_DEFAULT_TYPE,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
-	{
-		.type = POLICY_MOD,
-		.version = MOD_POLICYDB_VERSION_CONSTRAINT_NAMES,
-		.sym_num = SYM_NUM,
-		.ocon_num = 0,
-		.target_platform = SEPOL_TARGET_SELINUX,
-	},
 	{
 		.type = POLICY_MOD,
 		.version = MOD_POLICYDB_VERSION_XPERMS_IOCTL,
@@ -2046,9 +1885,8 @@ bad:
 	return -1;
 }
 
-static int read_cons_helper(policydb_t *p, constraint_node_t **nodep,
-			    unsigned int ncons, int allowxtarget,
-			    struct policy_file *fp)
+static int read_cons_helper(constraint_node_t **nodep, unsigned int ncons,
+			    int allowxtarget, struct policy_file *fp)
 {
 	constraint_node_t *c, *lc;
 	constraint_expr_t *e, *le;
@@ -2120,13 +1958,7 @@ static int read_cons_helper(policydb_t *p, constraint_node_t **nodep,
 				depth++;
 				if (ebitmap_read(&e->names, fp))
 					return -1;
-				if (p->policy_type != POLICY_KERN &&
-				    type_set_read(e->type_names, fp))
-					return -1;
-				else if (p->policy_type == POLICY_KERN &&
-					 p->policyvers >=
-						 POLICYDB_VERSION_CONSTRAINT_NAMES &&
-					 type_set_read(e->type_names, fp))
+				if (type_set_read(e->type_names, fp))
 					return -1;
 				break;
 			default:
@@ -2196,7 +2028,7 @@ static int class_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 			goto bad;
 	}
 
-	if (read_cons_helper(p, &cladatum->constraints, ncons, 0, fp))
+	if (read_cons_helper(&cladatum->constraints, ncons, 0, fp))
 		goto bad;
 
 	if ((p->policy_type == POLICY_KERN) ||
@@ -2206,26 +2038,18 @@ static int class_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 		if (rc < 0)
 			goto bad;
 		ncons = le32_to_cpu(buf[0]);
-		if (read_cons_helper(p, &cladatum->validatetrans, ncons, 1, fp))
+		if (read_cons_helper(&cladatum->validatetrans, ncons, 1, fp))
 			goto bad;
 	}
 
-	if ((p->policy_type == POLICY_KERN &&
-	     p->policyvers >= POLICYDB_VERSION_NEW_OBJECT_DEFAULTS) ||
-	    (p->policy_type == POLICY_BASE &&
-	     p->policyvers >= MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS)) {
+	if ((p->policy_type == POLICY_KERN) ||
+	    (p->policy_type == POLICY_BASE)) {
 		rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
 		if (rc < 0)
 			goto bad;
 		cladatum->default_user = le32_to_cpu(buf[0]);
 		cladatum->default_role = le32_to_cpu(buf[1]);
 		cladatum->default_range = le32_to_cpu(buf[2]);
-	}
-
-	if ((p->policy_type == POLICY_KERN &&
-	     p->policyvers >= POLICYDB_VERSION_DEFAULT_TYPE) ||
-	    (p->policy_type == POLICY_BASE &&
-	     p->policyvers >= MOD_POLICYDB_VERSION_DEFAULT_TYPE)) {
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
 			goto bad;
@@ -2277,8 +2101,7 @@ static int role_read(policydb_t *p, hashtab_t h, struct policy_file *fp)
 			goto bad;
 	}
 
-	if (p->policy_type != POLICY_KERN &&
-	    p->policyvers >= MOD_POLICYDB_VERSION_ROLEATTRIB) {
+	if (p->policy_type != POLICY_KERN) {
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
 			goto bad;
@@ -2386,8 +2209,6 @@ static int role_trans_read(policydb_t *p, struct policy_file *fp)
 	uint32_t buf[3], nel;
 	role_trans_t *tr, *ltr;
 	int rc;
-	int new_roletr = (p->policy_type == POLICY_KERN &&
-			  p->policyvers >= POLICYDB_VERSION_ROLETRANS);
 
 	rc = next_entry(buf, fp, sizeof(uint32_t));
 	if (rc < 0)
@@ -2410,13 +2231,10 @@ static int role_trans_read(policydb_t *p, struct policy_file *fp)
 		tr->role = le32_to_cpu(buf[0]);
 		tr->type = le32_to_cpu(buf[1]);
 		tr->new_role = le32_to_cpu(buf[2]);
-		if (new_roletr) {
-			rc = next_entry(buf, fp, sizeof(uint32_t));
-			if (rc < 0)
-				return -1;
-			tr->tclass = le32_to_cpu(buf[0]);
-		} else
-			tr->tclass = p->process_class;
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			return -1;
+		tr->tclass = le32_to_cpu(buf[0]);
 		ltr = tr;
 	}
 	return 0;
@@ -3532,8 +3350,7 @@ int avrule_read_list(policydb_t *p, avrule_t **avrules, struct policy_file *fp)
 	return 0;
 }
 
-static int role_trans_rule_read(policydb_t *p, role_trans_rule_t **r,
-				struct policy_file *fp)
+static int role_trans_rule_read(role_trans_rule_t **r, struct policy_file *fp)
 {
 	uint32_t buf[1], nel;
 	unsigned int i;
@@ -3564,16 +3381,8 @@ static int role_trans_rule_read(policydb_t *p, role_trans_rule_t **r,
 		if (type_set_read(&tr->types, fp))
 			return -1;
 
-		if (p->policyvers >= MOD_POLICYDB_VERSION_ROLETRANS) {
-			if (ebitmap_read(&tr->classes, fp))
-				return -1;
-		} else {
-			if (!p->process_class)
-				return -1;
-			if (ebitmap_set_bit(&tr->classes, p->process_class - 1,
-					    1))
-				return -1;
-		}
+		if (ebitmap_read(&tr->classes, fp))
+			return -1;
 
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
@@ -3772,13 +3581,12 @@ static int avrule_decl_read(policydb_t *p, avrule_decl_t *decl,
 	decl->enabled = le32_to_cpu(buf[1]);
 	if (cond_read_list(p, &decl->cond_list, fp) == -1 ||
 	    avrule_read_list(p, &decl->avrules, fp) == -1 ||
-	    role_trans_rule_read(p, &decl->role_tr_rules, fp) == -1 ||
+	    role_trans_rule_read(&decl->role_tr_rules, fp) == -1 ||
 	    role_allow_rule_read(&decl->role_allow_rules, fp) == -1) {
 		return -1;
 	}
 
-	if (p->policyvers >= MOD_POLICYDB_VERSION_FILENAME_TRANS &&
-	    filename_trans_rule_read(p, &decl->filename_trans_rules, fp))
+	if (filename_trans_rule_read(p, &decl->filename_trans_rules, fp))
 		return -1;
 
 	if (range_trans_rule_read(&decl->range_tr_rules, fp) == -1) {
@@ -4227,8 +4035,7 @@ int policydb_read(policydb_t *p, struct policy_file *fp, unsigned verbose)
 			goto bad;
 		if (role_allow_read(&p->role_allow, fp))
 			goto bad;
-		if (r_policyvers >= POLICYDB_VERSION_FILENAME_TRANS &&
-		    filename_trans_read(p, fp))
+		if (filename_trans_read(p, fp))
 			goto bad;
 	} else {
 		/* first read the AV rule blocks, then the scope tables */
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index fe8bf1cf..4d7983d5 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1586,11 +1586,6 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 					if (octx->u.iomem.low_iomem >
 					    octx->u.iomem.high_iomem)
 						goto bad;
-					if (p->policyvers <
-						    POLICYDB_VERSION_XEN_DEVICETREE &&
-					    octx->u.iomem.high_iomem >
-						    0xFFFFFFFFULL)
-						goto bad;
 					break;
 				case OCON_XEN_DEVICETREE:
 					if (validate_string_field(octx->u.name))
@@ -2088,9 +2083,8 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 			goto bad;
 		if (validate_role_allows(handle, p->role_allow, flavors))
 			goto bad;
-		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS)
-			if (validate_filename_trans_hashtab(handle, p, flavors))
-				goto bad;
+		if (validate_filename_trans_hashtab(handle, p, flavors))
+			goto bad;
 	} else {
 		if ((p->policy_type == POLICY_MOD) && (p->p_commons.nprim > 0))
 			goto bad;
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 3e8bd38b..fdd84078 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -202,12 +202,10 @@ static void cat_expr_buf(char *e_buf, const char *string)
 }
 
 /*
- * If the POLICY_KERN version is >= POLICYDB_VERSION_CONSTRAINT_NAMES,
- * then for 'types' only, read the types_names->types list as it will
+ * For 'types' only, read the types_names->types list as it will
  * contain a list of types and attributes that were defined in the
  * policy source.
- * For user and role plus types (for policy vers <
- * POLICYDB_VERSION_CONSTRAINT_NAMES) just read the e->names list.
+ * For user and role just read the e->names list.
  */
 static void get_name_list(constraint_expr_t *e, int type, const char *src,
 			  const char *op, int failed)
@@ -218,9 +216,7 @@ static void get_name_list(constraint_expr_t *e, int type, const char *src,
 	char tmp_buf[128];
 	int counter = 0;
 
-	if (policydb->policy_type == POLICY_KERN &&
-	    policydb->policyvers >= POLICYDB_VERSION_CONSTRAINT_NAMES &&
-	    type == CEXPR_TYPE)
+	if (policydb->policy_type == POLICY_KERN && type == CEXPR_TYPE)
 		types = &e->type_names->types;
 	else
 		types = &e->names;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index a0c9af85..7b76aa4a 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -347,41 +347,26 @@ static int role_trans_write(policydb_t *p, struct policy_file *fp)
 	role_trans_t *tr;
 	uint32_t buf[3];
 	size_t nel, items;
-	int new_roletr = (p->policy_type == POLICY_KERN &&
-			  p->policyvers >= POLICYDB_VERSION_ROLETRANS);
-	int warning_issued = 0;
 
 	nel = 0;
 	for (tr = r; tr; tr = tr->next)
-		if (new_roletr || tr->tclass == p->process_class)
-			nel++;
+		nel++;
 
 	buf[0] = cpu_to_le32(nel);
 	items = put_entry(buf, sizeof(uint32_t), 1, fp);
 	if (items != 1)
 		return POLICYDB_ERROR;
 	for (tr = r; tr; tr = tr->next) {
-		if (!new_roletr && tr->tclass != p->process_class) {
-			if (!warning_issued)
-				WARN(fp->handle,
-				     "Discarding role_transition "
-				     "rules for security classes other than "
-				     "\"process\"");
-			warning_issued = 1;
-			continue;
-		}
 		buf[0] = cpu_to_le32(tr->role);
 		buf[1] = cpu_to_le32(tr->type);
 		buf[2] = cpu_to_le32(tr->new_role);
 		items = put_entry(buf, sizeof(uint32_t), 3, fp);
 		if (items != 3)
 			return POLICYDB_ERROR;
-		if (new_roletr) {
-			buf[0] = cpu_to_le32(tr->tclass);
-			items = put_entry(buf, sizeof(uint32_t), 1, fp);
-			if (items != 1)
-				return POLICYDB_ERROR;
-		}
+		buf[0] = cpu_to_le32(tr->tclass);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
 	}
 
 	return POLICYDB_SUCCESS;
@@ -500,9 +485,6 @@ static int filename_trans_write(struct policydb *p, void *fp)
 	uint32_t buf[1];
 	int rc;
 
-	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
-		return 0;
-
 	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
 		buf[0] = cpu_to_le32(p->filename_trans_count);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
@@ -579,8 +561,7 @@ static int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	if (items != len)
 		return POLICYDB_ERROR;
 
-	if (p->policy_type != POLICY_KERN &&
-	    p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
+	if (p->policy_type != POLICY_KERN) {
 		buf[0] = cpu_to_le32(booldatum->flags);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
@@ -678,8 +659,7 @@ static int cond_write_node(policydb_t *p, cond_node_t *node,
 			return POLICYDB_ERROR;
 	}
 
-	if (p->policy_type != POLICY_KERN &&
-	    p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
+	if (p->policy_type != POLICY_KERN) {
 		buf[0] = cpu_to_le32(node->flags);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
@@ -796,8 +776,8 @@ static int common_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	return POLICYDB_SUCCESS;
 }
 
-static int write_cons_helper(policydb_t *p, constraint_node_t *node,
-			     int allowxtarget, struct policy_file *fp)
+static int write_cons_helper(constraint_node_t *node, int allowxtarget,
+			     struct policy_file *fp)
 {
 	constraint_node_t *c;
 	constraint_expr_t *e;
@@ -829,12 +809,7 @@ static int write_cons_helper(policydb_t *p, constraint_node_t *node,
 				if (ebitmap_write(&e->names, fp)) {
 					return POLICYDB_ERROR;
 				}
-				if ((p->policy_type != POLICY_KERN &&
-				     type_set_write(e->type_names, fp)) ||
-				    (p->policy_type == POLICY_KERN &&
-				     (p->policyvers >=
-				      POLICYDB_VERSION_CONSTRAINT_NAMES) &&
-				     type_set_write(e->type_names, fp))) {
+				if (type_set_write(e->type_names, fp)) {
 					return POLICYDB_ERROR;
 				}
 				break;
@@ -896,7 +871,7 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	if (hashtab_map(cladatum->permissions.table, perm_write, pd))
 		return POLICYDB_ERROR;
 
-	if (write_cons_helper(p, cladatum->constraints, 0, fp))
+	if (write_cons_helper(cladatum->constraints, 0, fp))
 		return POLICYDB_ERROR;
 
 	if ((p->policy_type == POLICY_KERN) ||
@@ -910,14 +885,11 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
 			return POLICYDB_ERROR;
-		if (write_cons_helper(p, cladatum->validatetrans, 1, fp))
+		if (write_cons_helper(cladatum->validatetrans, 1, fp))
 			return POLICYDB_ERROR;
 	}
 
-	if ((p->policy_type == POLICY_KERN &&
-	     p->policyvers >= POLICYDB_VERSION_NEW_OBJECT_DEFAULTS) ||
-	    (p->policy_type == POLICY_BASE &&
-	     p->policyvers >= MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS)) {
+	if (p->policy_type == POLICY_KERN || p->policy_type == POLICY_BASE) {
 		char default_range = cladatum->default_range;
 
 		buf[0] = cpu_to_le32(cladatum->default_user);
@@ -939,10 +911,7 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 			return POLICYDB_ERROR;
 	}
 
-	if ((p->policy_type == POLICY_KERN &&
-	     p->policyvers >= POLICYDB_VERSION_DEFAULT_TYPE) ||
-	    (p->policy_type == POLICY_BASE &&
-	     p->policyvers >= MOD_POLICYDB_VERSION_DEFAULT_TYPE)) {
+	if (p->policy_type == POLICY_KERN || p->policy_type == POLICY_BASE) {
 		buf[0] = cpu_to_le32(cladatum->default_type);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
@@ -970,10 +939,7 @@ static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	 *
 	 * Their numbers would be deducted in policydb_write().
 	 */
-	if ((role->flavor == ROLE_ATTRIB) &&
-	    ((p->policy_type == POLICY_KERN) ||
-	     (p->policy_type != POLICY_KERN &&
-	      p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB)))
+	if (role->flavor == ROLE_ATTRIB && p->policy_type == POLICY_KERN)
 		return POLICYDB_SUCCESS;
 
 	len = strlen(key);
@@ -1016,8 +982,7 @@ static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 			return POLICYDB_ERROR;
 	}
 
-	if (p->policy_type != POLICY_KERN &&
-	    p->policyvers >= MOD_POLICYDB_VERSION_ROLEATTRIB) {
+	if (p->policy_type != POLICY_KERN) {
 		buf[0] = cpu_to_le32(role->flavor);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
@@ -1676,58 +1641,27 @@ static int avrule_write_list(policydb_t *p, avrule_t *avrules,
 	return POLICYDB_SUCCESS;
 }
 
-static int only_process(ebitmap_t *in, struct policydb *p)
-{
-	unsigned int i, value;
-	ebitmap_node_t *node;
-
-	if (!p->process_class)
-		return 0;
-
-	value = p->process_class - 1;
-
-	ebitmap_for_each_positive_bit(in, node, i) {
-		if (i != value)
-			return 0;
-	}
-	return 1;
-}
-
-static int role_trans_rule_write(policydb_t *p, role_trans_rule_t *t,
-				 struct policy_file *fp)
+static int role_trans_rule_write(role_trans_rule_t *t, struct policy_file *fp)
 {
 	int nel = 0;
 	size_t items;
 	uint32_t buf[1];
 	role_trans_rule_t *tr;
-	int warned = 0;
-	int new_role = p->policyvers >= MOD_POLICYDB_VERSION_ROLETRANS;
 
 	for (tr = t; tr; tr = tr->next)
-		if (new_role || only_process(&tr->classes, p))
-			nel++;
+		nel++;
 
 	buf[0] = cpu_to_le32(nel);
 	items = put_entry(buf, sizeof(uint32_t), 1, fp);
 	if (items != 1)
 		return POLICYDB_ERROR;
 	for (tr = t; tr; tr = tr->next) {
-		if (!new_role && !only_process(&tr->classes, p)) {
-			if (!warned)
-				WARN(fp->handle,
-				     "Discarding role_transition "
-				     "rules for security classes other than "
-				     "\"process\"");
-			warned = 1;
-			continue;
-		}
 		if (role_set_write(&tr->roles, fp))
 			return POLICYDB_ERROR;
 		if (type_set_write(&tr->types, fp))
 			return POLICYDB_ERROR;
-		if (new_role)
-			if (ebitmap_write(&tr->classes, fp))
-				return POLICYDB_ERROR;
+		if (ebitmap_write(&tr->classes, fp))
+			return POLICYDB_ERROR;
 		buf[0] = cpu_to_le32(tr->new_role);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
@@ -1873,13 +1807,12 @@ static int avrule_decl_write(avrule_decl_t *decl, int num_scope_syms,
 	}
 	if (cond_write_list(p, decl->cond_list, fp) == -1 ||
 	    avrule_write_list(p, decl->avrules, fp, 0) == -1 ||
-	    role_trans_rule_write(p, decl->role_tr_rules, fp) == -1 ||
+	    role_trans_rule_write(decl->role_tr_rules, fp) == -1 ||
 	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
 		return POLICYDB_ERROR;
 	}
 
-	if (p->policyvers >= MOD_POLICYDB_VERSION_FILENAME_TRANS &&
-	    filename_trans_rule_write(p, decl->filename_trans_rules, fp))
+	if (filename_trans_rule_write(p, decl->filename_trans_rules, fp))
 		return POLICYDB_ERROR;
 
 	if (range_trans_rule_write(decl->range_tr_rules, fp) == -1) {
@@ -2120,10 +2053,7 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 		 * when the pp's version is not big enough. So deduct
 		 * their numbers from p_roles.table->nel.
 		 */
-		if ((i == SYM_ROLES) &&
-		    ((p->policy_type == POLICY_KERN) ||
-		     (p->policy_type != POLICY_KERN &&
-		      p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB)))
+		if (i == SYM_ROLES && p->policy_type == POLICY_KERN)
 			(void)hashtab_map(p->symtab[i].table, role_attr_uncount,
 					  &buf[1]);
 
@@ -2144,14 +2074,8 @@ int policydb_write(policydb_t *p, struct policy_file *fp)
 			return POLICYDB_ERROR;
 		if (role_allow_write(p->role_allow, fp))
 			return POLICYDB_ERROR;
-		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS) {
-			if (filename_trans_write(p, fp))
-				return POLICYDB_ERROR;
-		} else {
-			if (p->filename_trans)
-				WARN(fp->handle,
-				     "Discarding filename type transition rules");
-		}
+		if (filename_trans_write(p, fp))
+			return POLICYDB_ERROR;
 	} else {
 		if (avrule_block_write(p->global, num_syms, p, fp) == -1) {
 			return POLICYDB_ERROR;
-- 
2.55.0

