Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AC7CCA480
	for <selinux@archiver.kernel.org>; Thu, 16 Jun 2022 13:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376631AbiFPNOT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376977AbiFPNOR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jun 2022 09:14:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006A33A18A
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 06:14:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x62so2123048ede.10
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1VQk7uSarjgterSt9hTn1PKGN1dHxFTjyiiltAudmPE=;
        b=ObIJfOuwuGyRDIdeMy1af4dyjGC2iNyFQ8jpa++I6xatYr40+zEO/EHk4pO3Om7oxz
         wUtvawwjlR44ga5aBnKEfUrpXtPlHetWhLJhJqpZ0NwbCRJZxvmyCAEAx32rsmzJbr+I
         bdqVGE0WlI20OfjsqBCs1vMUvCHn1iPeYyjgQFWQB8pxAYDIwwedED2jx2YrjCu0Y0tu
         FqQPTXMNMMiHomz4aSyWtjVYlZVYH//bchDvTh41C7bh03OksY5LE7B9vb5lTebdmhP+
         wa+7675sxlacnJz0/YSmmQXkjcOBa8b3NfVSzEvMt6ZnDxiPSCBsGdCKtCnTbsnONbTW
         FaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VQk7uSarjgterSt9hTn1PKGN1dHxFTjyiiltAudmPE=;
        b=FdhHoyqHTaaBeP8/ZYe4iRclQEeYTVZruyIy5ZYTaZF+2MQ9ASUiiEfcKKBcf7wJRd
         WhU6XTPyiOA/rwX+4cZgKDPjg4hr71pk9Ji2ZejVixCA99+Z403i1Hua3uW9Nc+h5KT7
         XyZ1Ljq3VwMhsOhdowrPaVNPqDj7UuaYMwlemVSBAbicWYrG5mf+Urw0F3YSw1o0777Q
         xJalD5NsLzRzq4xNHXPSi/EsCVYvF/jdfz0ZZ65Iw1fjHEeK1ATU3hfMiPgZcqF0Cm3r
         YqphOsjrBPZiGwych4Pk0D7zLJkTZt77yqr4HdjV/DwHGokScIf3l3fPcZiKPzE1z5Ux
         T6KQ==
X-Gm-Message-State: AJIora/irUnLDa8vKaF8bl4r69GA11urw3OYHv/pUjYgO4WCrpjzqDOM
        55RmPGUKar5M5eQRD0Hjn7BTrp2b2IyK/A==
X-Google-Smtp-Source: AGRyM1uKYarBzrGR+ICh4aGUjxgzW5G8M7sTz9P7AOz+teGJIHTBXzWsPvSdIHH6GVsj1vrQaetLCw==
X-Received: by 2002:a05:6402:27cf:b0:431:54d9:28ed with SMTP id c15-20020a05640227cf00b0043154d928edmr6378472ede.81.1655385254190;
        Thu, 16 Jun 2022 06:14:14 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-158-068.77.8.pool.telefonica.de. [77.8.158.68])
        by smtp.gmail.com with ESMTPSA id y11-20020a056402270b00b0042e1cbc4471sm1831530edd.3.2022.06.16.06.14.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:14:13 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 3/4] libsepol: add compile-time constraint for mutual exclusive attributes
Date:   Thu, 16 Jun 2022 15:14:08 +0200
Message-Id: <20220616131409.23271-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616131409.23271-1-cgzones@googlemail.com>
References: <20220616131409.23271-1-cgzones@googlemail.com>
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

        libsepol.check_segregate_attributes: segregate_attributes violated by type dnssec_t associated with attributes security_file_type and non_security_file_type

    ibendport_type, packet_type, sysctl_type, device_node, ibpkey_type,
    sysfs_types, domain, boolean_type, netif_type, file_type, node_type,
    proc_type, port_type:

        libsepol.check_segregate_attributes: segregate_attributes violated by type virt_content_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type sysctl_fs_t associated with attributes sysctl_type and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type initrc_devpts_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type qemu_image_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type user_devpts_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type dockerc_t associated with attributes domain and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type cpu_online_t associated with attributes sysfs_types and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type cardmgr_dev_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type sysctl_t associated with attributes sysctl_type and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type bootloader_tmp_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type xen_image_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type svirt_prot_exec_image_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type xen_devpts_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type proc_t associated with attributes file_type and proc_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type sysfs_t associated with attributes sysfs_types and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type proc_xen_t associated with attributes file_type and proc_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type svirt_image_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type virt_image_t associated with attributes device_node and file_type
        libsepol.check_segregate_attributes: segregate_attributes violated by type container_file_t associated with attributes device_node and file_type

    libsepol.check_assertions: 20 segregate attribute failures occurred

Closes: https://github.com/SELinuxProject/selinux/issues/42

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/policydb.h | 18 +++++-
 libsepol/src/assertion.c                   | 59 ++++++++++++++++-
 libsepol/src/expand.c                      | 56 +++++++++++++++-
 libsepol/src/link.c                        | 57 ++++++++++++++++
 libsepol/src/policydb.c                    | 75 ++++++++++++++++++++++
 libsepol/src/policydb_validate.c           | 29 +++++++++
 libsepol/src/write.c                       | 34 +++++++++-
 7 files changed, 323 insertions(+), 5 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index de0068a6..b4a78e2f 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -192,6 +192,16 @@ typedef struct type_datum {
 	uint32_t bounds;	/* bounds type, if exist */
 } type_datum_t;
 
+/* Mutual exclusive attributes */
+typedef struct segregate_attribute {
+	ebitmap_t attrs;	/* mutual exclusive attributes */
+	unsigned long line;	/* line number from policy.conf where this rule originated  */
+	/* source file name and line number (e.g. .te file) */
+	char *source_filename;
+	unsigned long source_line;
+	struct segregate_attribute *next;
+} segregate_attribute_t;
+
 /*
  * Properties of type_datum
  * available on the policy version >= (MOD_)POLICYDB_VERSION_BOUNDARY
@@ -605,6 +615,9 @@ typedef struct policydb {
 	   bitmaps.  Someday the 0 bit may be used for global permissive */
 	ebitmap_t permissive_map;
 
+	/* mutual exclusive attributes (not preserved in kernel policy) */
+	segregate_attribute_t *segregate_attributes;
+
 	unsigned policyvers;
 
 	unsigned handle_unknown;
@@ -696,6 +709,8 @@ extern void level_datum_init(level_datum_t * x);
 extern void level_datum_destroy(level_datum_t * x);
 extern void cat_datum_init(cat_datum_t * x);
 extern void cat_datum_destroy(cat_datum_t * x);
+extern void segregate_attribute_init(segregate_attribute_t * x);
+extern void segregate_attribute_destroy(segregate_attribute_t * x);
 extern int check_assertion(policydb_t *p, avrule_t *avrule);
 extern int check_assertions(sepol_handle_t * handle,
 			    policydb_t * p, avrule_t * avrules);
@@ -783,9 +798,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_INFINIBAND		19
 #define MOD_POLICYDB_VERSION_GLBLUB		20
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
+#define MOD_POLICYDB_VERSION_SEGREGATEATTRIBUTE	22
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_SELF_TYPETRANS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_SEGREGATEATTRIBUTE
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 161874c3..28a9c55f 100644
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
@@ -535,6 +535,53 @@ int check_assertion(policydb_t *p, avrule_t *avrule)
 	return rc;
 }
 
+static int check_segregate_attributes(sepol_handle_t *handle, const policydb_t *p)
+{
+	int errors = 0;
+	const segregate_attribute_t *sattr;
+
+	for (sattr = p->segregate_attributes; sattr; sattr = sattr->next) {
+		ebitmap_node_t *first_node;
+		unsigned int first_bit;
+
+		ebitmap_for_each_positive_bit(&sattr->attrs, first_node, first_bit) {
+			ebitmap_node_t *second_node;
+			unsigned int second_bit;
+
+			ebitmap_for_each_positive_bit_starting(&sattr->attrs, first_node, first_bit, second_node, second_bit) {
+				ebitmap_t attr_union;
+				ebitmap_node_t *type_node;
+				unsigned int type_bit;
+
+				if (ebitmap_and(&attr_union, &p->attr_type_map[first_bit], &p->attr_type_map[second_bit]))
+					return -1;
+
+				ebitmap_for_each_positive_bit(&attr_union, type_node, type_bit) {
+					if (sattr->source_filename)
+						ERR(handle, "segregate_attributes on line %lu of %s (or line %lu of %s) violated by "
+							"type %s associated with attributes %s and %s",
+							sattr->source_line, sattr->source_filename, sattr->line, policy_name(p),
+							p->p_type_val_to_name[type_bit], p->p_type_val_to_name[first_bit], p->p_type_val_to_name[second_bit]);
+					else if (sattr->line)
+						ERR(handle, "segregate_attributes on line %lu of %s violated by "
+							"type %s associated with attributes %s and %s",
+							sattr->line, policy_name(p),
+							p->p_type_val_to_name[type_bit], p->p_type_val_to_name[first_bit], p->p_type_val_to_name[second_bit]);
+					else
+						ERR(handle, "segregate_attributes violated by "
+							"type %s associated with attributes %s and %s",
+							p->p_type_val_to_name[type_bit], p->p_type_val_to_name[first_bit], p->p_type_val_to_name[second_bit]);
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
@@ -570,5 +617,15 @@ int check_assertions(sepol_handle_t * handle, policydb_t * p,
 	if (errors)
 		ERR(handle, "%lu neverallow failures occurred", errors);
 
+	rc = check_segregate_attributes(handle, p);
+	if (rc < 0) {
+		ERR(handle, "Error occurred while checking segregate attributes");
+		return -1;
+	}
+	if (rc) {
+		ERR(handle, "%d segregate attribute failures occurred", rc);
+		errors += rc;
+	}
+
 	return errors ? -1 : 0;
 }
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8d19850e..483f6905 100644
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
@@ -2341,6 +2341,56 @@ static int genfs_copy(expand_state_t * state)
 	return 0;
 }
 
+static int segregate_attribute_copy(expand_state_t *state)
+{
+	const segregate_attribute_t *old;
+	segregate_attribute_t *list = NULL;
+
+	for (old = state->base->segregate_attributes; old; old = old->next) {
+		segregate_attribute_t *new;
+
+		new = calloc(1, sizeof(segregate_attribute_t));
+		if (!new) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		new->next = NULL;
+		new->line = old->line;
+		new->source_line = old->source_line;
+		if (old->source_filename) {
+			new->source_filename = strdup(old->source_filename);
+			if (!new->source_filename) {
+				ERR(state->handle, "Out of memory!");
+				free(new);
+				return -1;
+			}
+		}
+
+		if (map_ebitmap(&old->attrs, &new->attrs, state->typemap)) {
+			ERR(state->handle, "out of memory");
+			ebitmap_destroy(&new->attrs);
+			free(new->source_filename);
+			free(new);
+			return -1;
+		}
+
+		if (list)
+			list->next = new;
+		else {
+			if (state->out->segregate_attributes) {
+				segregate_attribute_t *s;
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
@@ -3173,6 +3223,10 @@ int expand_module(sepol_handle_t * handle,
 	if (genfs_copy(&state))
 		goto cleanup;
 
+	/* copy segregate attributes */
+	if (segregate_attribute_copy(&state))
+		goto cleanup;
+
 	/* Build the type<->attribute maps and remove attributes. */
 	state.out->attr_type_map = calloc(state.out->p_types.nprim,
 					  sizeof(ebitmap_t));
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index cbe4cea4..04f8b2cf 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1857,6 +1857,58 @@ static int scope_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	return -1;
 }
 
+static int copy_segregate_attributes(link_state_t * state, const policy_module_t *module)
+{
+	const segregate_attribute_t *src_sattr;
+	segregate_attribute_t *list = NULL;
+
+	for (src_sattr = module->policy->segregate_attributes; src_sattr; src_sattr = src_sattr->next) {
+		segregate_attribute_t *new_sattr;
+
+		new_sattr = calloc(1, sizeof(segregate_attribute_t));
+		if (!new_sattr) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		ebitmap_init(&new_sattr->attrs);
+		if (ebitmap_convert(&src_sattr->attrs, &new_sattr->attrs, module->map[SYM_TYPES])) {
+			ebitmap_destroy(&new_sattr->attrs);
+			free(new_sattr);
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		new_sattr->line = src_sattr->line;
+
+		if (src_sattr->source_filename) {
+			new_sattr->source_filename = strdup(src_sattr->source_filename);
+			if (!new_sattr->source_filename) {
+				ebitmap_destroy(&new_sattr->attrs);
+				free(new_sattr);
+				ERR(state->handle, "Out of memory!");
+				return -1;
+			}
+		}
+
+		new_sattr->source_line = src_sattr->source_line;
+
+		if (list)
+			list->next = new_sattr;
+		else {
+			if (state->base->segregate_attributes) {
+				segregate_attribute_t *s;
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
@@ -1891,6 +1943,11 @@ static int copy_module(link_state_t * state, policy_module_t * module)
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
index fc260eb6..356e8268 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -334,6 +334,13 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_SEGREGATEATTRIBUTE,
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
+	 .version = MOD_POLICYDB_VERSION_SEGREGATEATTRIBUTE,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 };
 
 #if 0
@@ -760,6 +774,21 @@ void avrule_list_destroy(avrule_t * x)
 	}
 }
 
+void segregate_attribute_init(segregate_attribute_t * x)
+{
+	memset(x, 0, sizeof(segregate_attribute_t));
+	ebitmap_init(&x->attrs);
+}
+
+
+void segregate_attribute_destroy(segregate_attribute_t * x)
+{
+	if (!x)
+		return;
+	ebitmap_destroy(&x->attrs);
+	free(x->source_filename);
+}
+
 /* 
  * Initialize the role table by implicitly adding role 'object_r'.  If
  * the policy is a module, set object_r's scope to be SCOPE_REQ,
@@ -1492,6 +1521,7 @@ void policydb_destroy(policydb_t * p)
 	unsigned int i;
 	role_allow_t *ra, *lra = NULL;
 	role_trans_t *tr, *ltr = NULL;
+	segregate_attribute_t *sattr, *sattr_next;
 
 	if (!p)
 		return;
@@ -1585,6 +1615,12 @@ void policydb_destroy(policydb_t * p)
 		free(p->attr_type_map);
 	}
 
+	for (sattr = p->segregate_attributes; sattr; sattr = sattr_next) {
+		sattr_next = sattr->next;
+		segregate_attribute_destroy(sattr);
+		free(sattr);
+	}
+
 	return;
 }
 
@@ -4174,6 +4210,39 @@ static int scope_read(policydb_t * p, int symnum, struct policy_file *fp)
 	return -1;
 }
 
+static int segregate_attributes_read(policydb_t * p, struct policy_file *fp)
+{
+	segregate_attribute_t *list = NULL;
+	uint32_t buf, nel, i;
+	int rc;
+
+	rc = next_entry(&buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	nel = le32_to_cpu(buf);
+	for (i = 0; i < nel; i++) {
+		segregate_attribute_t *sattr;
+
+		sattr = calloc(1, sizeof(segregate_attribute_t));
+		if (!sattr)
+			return -1;
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
@@ -4570,6 +4639,12 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		}
 	}
 
+	if (p->policyvers >= MOD_POLICYDB_VERSION_SEGREGATEATTRIBUTE &&
+	    p->policy_type != POLICY_KERN) {
+		if (segregate_attributes_read(p, fp))
+			return POLICYDB_ERROR;
+	}
+
 	if (validate_policydb(fp->handle, p))
 		goto bad;
 
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 99d4eb7f..be969036 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1270,6 +1270,32 @@ bad:
 	return -1;
 }
 
+static int validate_segregate_attributes(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	segregate_attribute_t *sattr;
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
+	ERR(handle, "Invalid segregate attribute definition");
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
index 48ed21ea..d5c6df16 100644
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
@@ -2189,6 +2189,30 @@ static int role_attr_uncount(hashtab_key_t key __attribute__ ((unused)),
 	return 0;
 }
 
+static int segregate_attributes_write(const policydb_t *p, struct policy_file *fp)
+{
+	const segregate_attribute_t *sattr;
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
@@ -2411,5 +2435,11 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 		}
 	}
 
+	if (p->policyvers >= MOD_POLICYDB_VERSION_SEGREGATEATTRIBUTE &&
+	    p->policy_type != POLICY_KERN) {
+		if (segregate_attributes_write(p, fp))
+			return POLICYDB_ERROR;
+	}
+
 	return POLICYDB_SUCCESS;
 }
-- 
2.36.1

