Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784F3CCA488
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiGUPFa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiGUPF2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:05:28 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD061276E
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ss3so3599273ejc.11
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I2pjEZKi3YN9/tCoiKl1+mGLsWzgLkTV/pN9wXFBnVQ=;
        b=i5tixb45LbFbSLvAwagPpwOLl1P6jiBKWowa35VQTk8c604XC9z9GozsJMmlEOQ28L
         TpjZDjz3tuYHmH9lN//ACwWTPKOcWvZrHXo4eVv8ZVABdlxM8BHIlZsBz2q1klPhYFfH
         iOHLGe+CSrkWwTO1lD0JFRbDTtlDXhNuCgWe3R87+HiSv0Jiph5M8obP4L0dDsHEmEBq
         T6QeaPvSfHy56/Wmdb4To5VQm1YLXy/nHtRXwqqsGyHe0Hgqrxz+Ji7hxYb1Cd5SR0p1
         G5mcrAwHAYw0KtkrFoPCngGS0E4SIaZ7iOion9KF7n3aQRh47APFEkz3fJWl8lz+m+RA
         xZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2pjEZKi3YN9/tCoiKl1+mGLsWzgLkTV/pN9wXFBnVQ=;
        b=3J8mNZR7IFdqO+8Yb5Btv76nYNNipgoGd3LXobrXXGa90IuD6WxGT0V2dcNUm6IiAu
         cjaQiIq0wFrrJuSHyZeSJIdixFeecfsh8MxjsDaRghFcf3sBcKpTg/spTMHhf4gTpd8p
         3PdPPUdXt/VL3XSG9VihfsIYgT4FQ+1Tl3VQUmv0M5QHBH36VpLWOoPT02YNPoQWotX7
         SW1ssf08T9feT7oW6mrrt6OHCZctB7wx8hU46BE0FjKfgWb55D0xD9jptLqEaQhKx/MF
         CcIQJzAPfS6vdSEMKXaTYqzFaLbRBIwfNjSp4Ogpy/+460BSv6y3D2wWd4AcEuHfGEDs
         5Qxw==
X-Gm-Message-State: AJIora8IKWuomjLdnlkmQOkE6ibtybHZpetvJZusmWRlyYWb0i1lRJiR
        D9/jereOKZmMamLmRIt+lSSUyXeDNDiqTg==
X-Google-Smtp-Source: AGRyM1vgFUpqd9v3yL3BuFKhpKKNYTeKjtzWqVHv7ybsP5+c3JLni82xy+O/syqgVPjxE8cX4ERWtA==
X-Received: by 2002:a17:907:b04:b0:72b:5cf4:4631 with SMTP id h4-20020a1709070b0400b0072b5cf44631mr42061969ejl.180.1658415923551;
        Thu, 21 Jul 2022 08:05:23 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0043a1255bc68sm1120992edr.94.2022.07.21.08.05.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:05:23 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 3/8] libsepol: add compile-time constraint for mutual exclusive attributes
Date:   Thu, 21 Jul 2022 17:05:10 +0200
Message-Id: <20220721150515.19843-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721150515.19843-1-cgzones@googlemail.com>
References: <20220721150515.19843-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a new compile-time constraint, similar to neverallow, which enables
to specify two or more type attributes to be mutual exclusive.  This
means no type can be associated with more than one of them.

The constraints are stored as a linked-list in the policy for modular
policies, by a new modular policy version, and are discarded in kernel
policies, not needing any kernel support.

Some Reference Policy examples:

    unpriv_userdomain, admindomain:

        <no violations>

    client_packet_type, server_packet_type:

        <no violations>

    auth_file_type, non_auth_file_type:

        <no violations>

    pseudofs, xattrfs, noxattrfs:

         <no violations>

    reserved_port_type, unreserved_port_type:

         <no violations>

    security_file_type, non_security_file_type:

        libsepol.check_segregate_attributes: Segregate Attributes violation, type dnssec_t associated with attributes security_file_type and non_security_file_type

    ibendport_type, packet_type, sysctl_type, device_node, ibpkey_type,
    sysfs_types, domain, boolean_type, netif_type, file_type, node_type,
    proc_type, port_type:

        libsepol.check_segregate_attributes: Segregate Attributes violation, type sysctl_fs_t associated with attributes sysctl_type and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type sysctl_t associated with attributes sysctl_type and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type virt_content_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type initrc_devpts_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type qemu_image_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type user_devpts_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type cardmgr_dev_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type bootloader_tmp_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type xen_image_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type svirt_prot_exec_image_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type xen_devpts_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type svirt_image_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type virt_image_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type container_file_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type cpu_online_t associated with attributes sysfs_types and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type sysfs_t associated with attributes sysfs_types and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type dockerc_t associated with attributes domain and file_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type proc_t associated with attributes file_type and proc_type
        libsepol.check_segregate_attributes: Segregate Attributes violation, type proc_xen_t associated with attributes file_type and proc_type

    libsepol.check_assertions: 20 Segregate Attributes failures occurred

Closes: https://github.com/SELinuxProject/selinux/issues/42

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
   - drop source location information:
     this information was already lost for binary modular policies and
     CIL policies; also typeattribute statements have none and the few
     segregate_attributes statements can be easily grepped
   - misc renaming
v2:
   rebase onto _after suffix change
---
 libsepol/include/sepol/policydb/policydb.h | 15 ++++-
 libsepol/src/assertion.c                   | 57 +++++++++++++---
 libsepol/src/expand.c                      | 45 ++++++++++++-
 libsepol/src/kernel_to_conf.c              | 38 ++++++++++-
 libsepol/src/link.c                        | 44 +++++++++++++
 libsepol/src/policydb.c                    | 76 ++++++++++++++++++++++
 libsepol/src/policydb_validate.c           | 29 +++++++++
 libsepol/src/write.c                       | 34 +++++++++-
 8 files changed, 325 insertions(+), 13 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index de0068a6..d62d030c 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -192,6 +192,12 @@ typedef struct type_datum {
 	uint32_t bounds;	/* bounds type, if exist */
 } type_datum_t;
 
+/* Mutual exclusive attributes */
+typedef struct segregate_attributes_rule {
+	ebitmap_t attrs;	/* mutual exclusive attributes */
+	struct segregate_attributes_rule *next;
+} segregate_attributes_rule_t;
+
 /*
  * Properties of type_datum
  * available on the policy version >= (MOD_)POLICYDB_VERSION_BOUNDARY
@@ -605,6 +611,10 @@ typedef struct policydb {
 	   bitmaps.  Someday the 0 bit may be used for global permissive */
 	ebitmap_t permissive_map;
 
+	/* mutual exclusive attributes (not preserved in kernel policy).
+	   stored as linked list */
+	segregate_attributes_rule_t *segregate_attributes;
+
 	unsigned policyvers;
 
 	unsigned handle_unknown;
@@ -696,6 +706,8 @@ extern void level_datum_init(level_datum_t * x);
 extern void level_datum_destroy(level_datum_t * x);
 extern void cat_datum_init(cat_datum_t * x);
 extern void cat_datum_destroy(cat_datum_t * x);
+extern void segregate_attributes_rule_init(segregate_attributes_rule_t * x);
+extern void segregate_attributes_rule_destroy(segregate_attributes_rule_t * x);
 extern int check_assertion(policydb_t *p, avrule_t *avrule);
 extern int check_assertions(sepol_handle_t * handle,
 			    policydb_t * p, avrule_t * avrules);
@@ -783,9 +795,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_INFINIBAND		19
 #define MOD_POLICYDB_VERSION_GLBLUB		20
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
+#define MOD_POLICYDB_VERSION_SEGREGATE_ATTRIBUTES	22
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_SELF_TYPETRANS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_SEGREGATE_ATTRIBUTES
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 161874c3..a6dda570 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -36,7 +36,7 @@ struct avtab_match_args {
 	unsigned long errors;
 };
 
-static const char* policy_name(policydb_t *p) {
+static const char* policy_name(const policydb_t *p) {
 	const char *policy_file = "policy.conf";
 	if (p->name) {
 		policy_file = p->name;
@@ -535,6 +535,44 @@ int check_assertion(policydb_t *p, avrule_t *avrule)
 	return rc;
 }
 
+static int check_segregate_attributes(sepol_handle_t *handle, const policydb_t *p)
+{
+	const segregate_attributes_rule_t *sattr;
+	int errors = 0, rc;
+
+	for (sattr = p->segregate_attributes; sattr; sattr = sattr->next) {
+		ebitmap_node_t *first_node;
+		unsigned int first_bit;
+
+		ebitmap_for_each_positive_bit(&sattr->attrs, first_node, first_bit) {
+			ebitmap_node_t *second_node;
+			unsigned int second_bit;
+
+			ebitmap_for_each_positive_bit_after(&sattr->attrs, second_node, second_bit, first_node, first_bit) {
+				ebitmap_t attr_union;
+				ebitmap_node_t *type_node;
+				unsigned int type_bit;
+
+				rc = ebitmap_and(&attr_union, &p->attr_type_map[first_bit], &p->attr_type_map[second_bit]);
+				if (rc < 0)
+					return rc;
+
+				ebitmap_for_each_positive_bit(&attr_union, type_node, type_bit) {
+					ERR(handle, "Segregate Attributes violation, type %s associated with attributes %s and %s",
+					            p->p_type_val_to_name[type_bit],
+					            p->p_type_val_to_name[first_bit],
+					            p->p_type_val_to_name[second_bit]);
+					errors++;
+				}
+
+				ebitmap_destroy(&attr_union);
+			}
+		}
+	}
+
+	return errors;
+}
+
 int check_assertions(sepol_handle_t * handle, policydb_t * p,
 		     avrule_t * avrules)
 {
@@ -542,13 +580,6 @@ int check_assertions(sepol_handle_t * handle, policydb_t * p,
 	avrule_t *a;
 	unsigned long errors = 0;
 
-	if (!avrules) {
-		/* Since assertions are stored in avrules, if it is NULL
-		   there won't be any to check. This also prevents an invalid
-		   free if the avtabs are never initialized */
-		return 0;
-	}
-
 	for (a = avrules; a != NULL; a = a->next) {
 		if (!(a->specified & (AVRULE_NEVERALLOW | AVRULE_XPERMS_NEVERALLOW)))
 			continue;
@@ -570,5 +601,15 @@ int check_assertions(sepol_handle_t * handle, policydb_t * p,
 	if (errors)
 		ERR(handle, "%lu neverallow failures occurred", errors);
 
+	rc = check_segregate_attributes(handle, p);
+	if (rc < 0) {
+		ERR(handle, "Error occurred while checking Segregate Attributes");
+		return -1;
+	}
+	if (rc) {
+		ERR(handle, "%d Segregate Attributes failures occurred", rc);
+		errors += rc;
+	}
+
 	return errors ? -1 : 0;
 }
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8d19850e..6f52d1ff 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -56,7 +56,7 @@ static void expand_state_init(expand_state_t * state)
 	memset(state, 0, sizeof(expand_state_t));
 }
 
-static int map_ebitmap(ebitmap_t * src, ebitmap_t * dst, uint32_t * map)
+static int map_ebitmap(const ebitmap_t * src, ebitmap_t * dst, const uint32_t * map)
 {
 	unsigned int i;
 	ebitmap_node_t *tnode;
@@ -2341,6 +2341,45 @@ static int genfs_copy(expand_state_t * state)
 	return 0;
 }
 
+static int segregate_attributes_copy(expand_state_t *state)
+{
+	const segregate_attributes_rule_t *old;
+	segregate_attributes_rule_t *list = NULL;
+
+	for (old = state->base->segregate_attributes; old; old = old->next) {
+		segregate_attributes_rule_t *new;
+
+		new = malloc(sizeof(segregate_attributes_rule_t));
+		if (!new) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		segregate_attributes_rule_init(new);
+
+		if (map_ebitmap(&old->attrs, &new->attrs, state->typemap)) {
+			ERR(state->handle, "out of memory");
+			ebitmap_destroy(&new->attrs);
+			free(new);
+			return -1;
+		}
+
+		if (list)
+			list->next = new;
+		else {
+			if (state->out->segregate_attributes) {
+				segregate_attributes_rule_t *s;
+				for (s = state->out->segregate_attributes; s->next; s = s->next) {}
+				s->next = new;
+			} else
+				state->out->segregate_attributes = new;
+		}
+		list = new;
+	}
+
+	return 0;
+}
+
 static int type_attr_map(hashtab_key_t key
 			 __attribute__ ((unused)), hashtab_datum_t datum,
 			 void *ptr)
@@ -3173,6 +3212,10 @@ int expand_module(sepol_handle_t * handle,
 	if (genfs_copy(&state))
 		goto cleanup;
 
+	/* copy segregate attributes */
+	if (segregate_attributes_copy(&state))
+		goto cleanup;
+
 	/* Build the type<->attribute maps and remove attributes. */
 	state.out->attr_type_map = calloc(state.out->p_types.nprim,
 					  sizeof(ebitmap_t));
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 63dffd9b..f119d572 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1839,6 +1839,33 @@ exit:
 	return rc;
 }
 
+static int write_segregate_attributes_to_conf(FILE *out, const struct policydb *pdb)
+{
+	const segregate_attributes_rule_t *sattr;
+
+	for (sattr = pdb->segregate_attributes; sattr; sattr = sattr->next) {
+		struct ebitmap_node *node;
+		unsigned int bit;
+		int first = 1;
+
+		sepol_printf(out, "segregate_attributes ");
+
+		ebitmap_for_each_positive_bit(&sattr->attrs, node, bit) {
+			if (first) {
+				first = 0;
+			} else {
+				sepol_printf(out, ", ");
+			}
+
+			sepol_printf(out, "%s", pdb->p_type_val_to_name[bit - 1]);
+		}
+
+		sepol_printf(out, ";\n");
+	}
+
+	return 0;
+}
+
 struct map_filename_trans_args {
 	struct policydb *pdb;
 	struct strs *strs;
@@ -3200,7 +3227,16 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 	if (rc != 0) {
 		goto exit;
 	}
-	write_filename_trans_rules_to_conf(out, pdb);
+
+	rc = write_segregate_attributes_to_conf(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = write_filename_trans_rules_to_conf(out, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
 
 	if (pdb->mls) {
 		rc = write_range_trans_rules_to_conf(out, pdb);
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index cbe4cea4..1650a9c0 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1857,6 +1857,45 @@ static int scope_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	return -1;
 }
 
+static int copy_segregate_attributes(link_state_t * state, const policy_module_t *module)
+{
+	const segregate_attributes_rule_t *src_sattr;
+	segregate_attributes_rule_t *list = NULL;
+
+	for (src_sattr = module->policy->segregate_attributes; src_sattr; src_sattr = src_sattr->next) {
+		segregate_attributes_rule_t *new_sattr;
+
+		new_sattr = malloc(sizeof(segregate_attributes_rule_t));
+		if (!new_sattr) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		segregate_attributes_rule_init(new_sattr);
+
+		if (ebitmap_convert(&src_sattr->attrs, &new_sattr->attrs, module->map[SYM_TYPES])) {
+			ebitmap_destroy(&new_sattr->attrs);
+			free(new_sattr);
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		if (list)
+			list->next = new_sattr;
+		else {
+			if (state->base->segregate_attributes) {
+				segregate_attributes_rule_t *s;
+				for (s = state->base->segregate_attributes; s->next; s = s->next) {}
+				s->next = new_sattr;
+			} else
+				state->base->segregate_attributes = new_sattr;
+		}
+		list = new_sattr;
+	}
+
+	return 0;
+}
+
 /* Copy a module over to a base, remapping all values within.  After
  * all identifiers and rules are done, copy the scoping information.
  * This is when it checks for duplicate declarations. */
@@ -1891,6 +1930,11 @@ static int copy_module(link_state_t * state, policy_module_t * module)
 		}
 	}
 
+	ret = copy_segregate_attributes(state, module);
+	if (ret) {
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index fc260eb6..9dbb9f44 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -334,6 +334,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_SEGREGATE_ATTRIBUTES,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBENDPORT + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -460,6 +467,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = 0,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_SEGREGATE_ATTRIBUTES,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 };
 
 #if 0
@@ -760,6 +774,20 @@ void avrule_list_destroy(avrule_t * x)
 	}
 }
 
+void segregate_attributes_rule_init(segregate_attributes_rule_t * x)
+{
+	ebitmap_init(&x->attrs);
+	x->next = NULL;
+}
+
+
+void segregate_attributes_rule_destroy(segregate_attributes_rule_t * x)
+{
+	if (!x)
+		return;
+	ebitmap_destroy(&x->attrs);
+}
+
 /* 
  * Initialize the role table by implicitly adding role 'object_r'.  If
  * the policy is a module, set object_r's scope to be SCOPE_REQ,
@@ -1492,6 +1520,7 @@ void policydb_destroy(policydb_t * p)
 	unsigned int i;
 	role_allow_t *ra, *lra = NULL;
 	role_trans_t *tr, *ltr = NULL;
+	segregate_attributes_rule_t *sattr, *sattr_next;
 
 	if (!p)
 		return;
@@ -1585,6 +1614,12 @@ void policydb_destroy(policydb_t * p)
 		free(p->attr_type_map);
 	}
 
+	for (sattr = p->segregate_attributes; sattr; sattr = sattr_next) {
+		sattr_next = sattr->next;
+		segregate_attributes_rule_destroy(sattr);
+		free(sattr);
+	}
+
 	return;
 }
 
@@ -4174,6 +4209,41 @@ static int scope_read(policydb_t * p, int symnum, struct policy_file *fp)
 	return -1;
 }
 
+static int segregate_attributes_read(policydb_t * p, struct policy_file *fp)
+{
+	segregate_attributes_rule_t *list = NULL;
+	uint32_t buf, nel, i;
+	int rc;
+
+	rc = next_entry(&buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	nel = le32_to_cpu(buf);
+	for (i = 0; i < nel; i++) {
+		segregate_attributes_rule_t *sattr;
+
+		sattr = malloc(sizeof(segregate_attributes_rule_t));
+		if (!sattr)
+			return -1;
+
+		segregate_attributes_rule_init(sattr);
+
+		if (ebitmap_read(&sattr->attrs, fp) < 0) {
+			ebitmap_destroy(&sattr->attrs);
+			free(sattr);
+			return -1;
+		}
+
+		if (list)
+			list->next = sattr;
+		else
+			p->segregate_attributes = sattr;
+		list = sattr;
+	}
+
+	return 0;
+}
+
 static sepol_security_class_t policydb_string_to_security_class(
 	struct policydb *policydb,
 	const char *class_name)
@@ -4570,6 +4640,12 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		}
 	}
 
+	if (p->policyvers >= MOD_POLICYDB_VERSION_SEGREGATE_ATTRIBUTES &&
+	    p->policy_type != POLICY_KERN) {
+		if (segregate_attributes_read(p, fp))
+			return POLICYDB_ERROR;
+	}
+
 	if (validate_policydb(fp->handle, p))
 		goto bad;
 
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 99d4eb7f..6331c3ce 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1270,6 +1270,32 @@ bad:
 	return -1;
 }
 
+static int validate_segregate_attributes(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	segregate_attributes_rule_t *sattr;
+	ebitmap_node_t *node;
+	unsigned int i;
+
+	for (sattr = p->segregate_attributes; sattr; sattr = sattr->next) {
+		if (ebitmap_cardinality(&sattr->attrs) < 2)
+			goto bad;
+
+		if (validate_ebitmap(&sattr->attrs, &flavors[SYM_TYPES]))
+			goto bad;
+
+		ebitmap_for_each_positive_bit(&sattr->attrs, node, i) {
+			if (p->type_val_to_struct[i]->flavor != TYPE_ATTRIB)
+				goto bad;
+		}
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid segregate attributes definition");
+	return -1;
+}
+
 static int validate_properties(sepol_handle_t *handle, policydb_t *p)
 {
 	switch (p->policy_type) {
@@ -1376,6 +1402,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_permissives(handle, p, flavors))
 		goto bad;
 
+	if (validate_segregate_attributes(handle, p, flavors))
+		goto bad;
+
 	validate_array_destroy(flavors);
 
 	return 0;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index a9fdf93a..81323df9 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -58,9 +58,9 @@ struct policy_data {
 static int avrule_write_list(policydb_t *p,
 			     avrule_t * avrules, struct policy_file *fp);
 
-static int ebitmap_write(ebitmap_t * e, struct policy_file *fp)
+static int ebitmap_write(const ebitmap_t * e, struct policy_file *fp)
 {
-	ebitmap_node_t *n;
+	const ebitmap_node_t *n;
 	uint32_t buf[32], bit, count;
 	uint64_t map;
 	size_t items;
@@ -2191,6 +2191,30 @@ static int role_attr_uncount(hashtab_key_t key __attribute__ ((unused)),
 	return 0;
 }
 
+static int segregate_attributes_write(const policydb_t *p, struct policy_file *fp)
+{
+	const segregate_attributes_rule_t *sattr;
+	size_t items;
+	uint32_t buf, count = 0;
+
+	for (sattr = p->segregate_attributes; sattr; sattr = sattr->next) {
+		if (__builtin_add_overflow(count, 1, &count))
+			return POLICYDB_ERROR;
+	}
+
+	buf = cpu_to_le32(count);
+	items = put_entry(&buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return POLICYDB_ERROR;
+
+	for (sattr = p->segregate_attributes; sattr; sattr = sattr->next) {
+		if (ebitmap_write(&sattr->attrs, fp))
+			return POLICYDB_ERROR;
+	}
+
+	return POLICYDB_SUCCESS;
+}
+
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
@@ -2413,5 +2437,11 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 		}
 	}
 
+	if (p->policyvers >= MOD_POLICYDB_VERSION_SEGREGATE_ATTRIBUTES &&
+	    p->policy_type != POLICY_KERN) {
+		if (segregate_attributes_write(p, fp))
+			return POLICYDB_ERROR;
+	}
+
 	return POLICYDB_SUCCESS;
 }
-- 
2.36.1

