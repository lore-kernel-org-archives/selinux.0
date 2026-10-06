Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A194582FE
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291885; cv=none; b=BYt+TIXtiVvLx4tykLXoSy1vERJAnAIyYc4Kyhunc1tUaDC4NgcPUmHJ9st9RlQKUEqzAESAx4biAxcRTskYiDGIBw6eCpjcvU/Uq1R3klfcAwZcWFur/fcaQjd6fRoefnFqvEzBs4vJAo/ztr21GqOLgjvGO33OT3UGfRBUfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291885; c=relaxed/simple;
	bh=tCq6J+z93+9lI/VgmQjmDslJL6vvjFVFXFa6/QdzIbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tC8KiQnr26og1yqNI2O6ATczvhkxymH1erbbMB06KP6slqzzPdcgwm2cdBd5J8V6EU2pdde1F9YNANniHjz+kBjLX0sbEJCf0yp8WB0RlJJQIBfkadDV8YODstRhKybbTTo64l9PLSKriAZ5tur4ht0ypJIMJ/YNKxrrrau//eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjD8LcmQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjD8LcmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgmHMArzEutaMUXxsodTJnIlMDX+GdLr29m5RaI0m8c=;
	b=CjD8LcmQ+GMSeqe0hWE872L1ywplS2Mj9NkO8dPyHRG9wyF6sy9U+SY0E1Bxczth8p2jW8
	zjolfjC0JSVskdKKZnwWiZnNt4ZEqvTJP46TDiWY24RrDuj9u3yNNhJcS2v8N9IsmRXdkw
	4pgTvjMgUHY+xikGGt7tzTC/LCRr3oA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-BrOii4dqOROeF5aQO60h3Q-1; Tue,
 06 Oct 2026 09:04:40 -0400
X-MC-Unique: BrOii4dqOROeF5aQO60h3Q-1
X-Mimecast-MFC-AGG-ID: BrOii4dqOROeF5aQO60h3Q_1791291880
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA4EA1865DA2
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:39 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EF0319373D8;
	Tue,  6 Oct 2026 13:04:38 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>
Subject: [RFC PATCH userspace 17/17] libsepol: add symbol map entries and umbrella header for new public API
Date: Tue,  6 Oct 2026 15:02:15 +0200
Message-ID: <20261006130215.128405-18-jjanasek@redhat.com>
In-Reply-To: <20261006130215.128405-1-jjanasek@redhat.com>
References: <20261006130215.128405-1-jjanasek@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add all new public symbols to libsepol.map.in under a new version
block. Update sepol/sepol.h umbrella header to include all 20 new
public headers.

Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/sepol.h |  59 +++--
 libsepol/src/libsepol.map.in   | 379 +++++++++++++++++++++++++++++++++
 2 files changed, 418 insertions(+), 20 deletions(-)

diff --git a/libsepol/include/sepol/sepol.h b/libsepol/include/sepol/sepol.h
index 32b4dc57..7104632b 100644
--- a/libsepol/include/sepol/sepol.h
+++ b/libsepol/include/sepol/sepol.h
@@ -4,31 +4,50 @@
 #include <stddef.h>
 #include <stdio.h>
 
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <sepol/user_record.h>
-#include <sepol/context_record.h>
-#include <sepol/iface_record.h>
-#include <sepol/ibpkey_record.h>
-#include <sepol/ibendport_record.h>
-#include <sepol/port_record.h>
+#include <sepol/av_rule.h>
 #include <sepol/boolean_record.h>
-#include <sepol/node_record.h>
-
 #include <sepol/booleans.h>
-#include <sepol/interfaces.h>
-#include <sepol/ibpkeys.h>
+#include <sepol/cat_set.h>
+#include <sepol/class_record.h>
+#include <sepol/classes.h>
+#include <sepol/common_perm.h>
+#include <sepol/conditional.h>
+#include <sepol/constants.h>
+#include <sepol/context.h>
+#include <sepol/context_record.h>
+#include <sepol/debug.h>
+#include <sepol/filename_trans.h>
+#include <sepol/flask.h>
+#include <sepol/handle.h>
+#include <sepol/ibendport_record.h>
 #include <sepol/ibendports.h>
-#include <sepol/ports.h>
+#include <sepol/ibpkey_record.h>
+#include <sepol/ibpkeys.h>
+#include <sepol/iface_record.h>
+#include <sepol/interfaces.h>
+#include <sepol/mls_iter.h>
+#include <sepol/module.h>
+#include <sepol/node_record.h>
 #include <sepol/nodes.h>
-#include <sepol/users.h>
-#include <sepol/handle.h>
-#include <sepol/debug.h>
+#include <sepol/ocontext.h>
+#include <sepol/permissive.h>
+#include <sepol/polcap.h>
 #include <sepol/policydb.h>
-#include <sepol/module.h>
-#include <sepol/context.h>
+#include <sepol/port_record.h>
+#include <sepol/ports.h>
+#include <sepol/range_trans.h>
+#include <sepol/role_record.h>
+#include <sepol/role_rule.h>
+#include <sepol/roles.h>
+#include <sepol/sid_table.h>
+#include <sepol/type_record.h>
+#include <sepol/types.h>
+#include <sepol/user_record.h>
+#include <sepol/users.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
 
 /* Set internal policydb from a file for subsequent service calls. */
 extern int sepol_set_policydb_from_file(FILE *fp);
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 8785cff1..6c07baa8 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -300,3 +300,382 @@ LIBSEPOL_3.11 {
 	sepol_kernel_policydb_decls_to_cil;
 	cil_check_neverallows_against_pdb;
 } LIBSEPOL_3.6;
+
+LIBSEPOL_3.12 {
+  global:
+	sepol_avtab_iter_create;
+	sepol_avtab_iter_destroy;
+	sepol_avtab_iter_get_av_data;
+	sepol_avtab_iter_get_type_data;
+	sepol_avtab_iter_get_xperm_driver;
+	sepol_avtab_iter_get_xperm_type;
+	sepol_avtab_iter_next;
+	sepol_bool_iter_create;
+	sepol_bool_iter_destroy;
+	sepol_bool_iter_next;
+	sepol_bool_query_by_value;
+	sepol_bool_value_to_name;
+	sepol_cat_iter_create;
+	sepol_cat_iter_destroy;
+	sepol_cat_iter_next;
+	sepol_cat_set_iter_destroy;
+	sepol_cat_set_iter_next;
+	sepol_cat_value_to_name;
+	sepol_class_add_constraint;
+	sepol_class_add_perm;
+	sepol_class_add_validatetrans;
+	sepol_class_clone;
+	sepol_class_compare;
+	sepol_class_compare2;
+	sepol_class_count;
+	sepol_class_create;
+	sepol_class_del_constraint;
+	sepol_class_del_perm;
+	sepol_class_del_validatetrans;
+	sepol_class_exists;
+	sepol_class_free;
+	sepol_class_get_common;
+	sepol_class_get_constraints;
+	sepol_class_get_default_range;
+	sepol_class_get_default_role;
+	sepol_class_get_default_type;
+	sepol_class_get_default_user;
+	sepol_class_get_name;
+	sepol_class_get_perms;
+	sepol_class_get_validatetrans;
+	sepol_class_has_perm;
+	sepol_class_iter_create;
+	sepol_class_iter_destroy;
+	sepol_class_iter_next;
+	sepol_class_key_create;
+	sepol_class_key_extract;
+	sepol_class_key_free;
+	sepol_class_key_unpack;
+	sepol_class_perm_value_to_name;
+	sepol_class_query;
+	sepol_class_query_by_value;
+	sepol_class_set_common;
+	sepol_class_set_default_range;
+	sepol_class_set_default_role;
+	sepol_class_set_default_type;
+	sepol_class_set_default_user;
+	sepol_class_set_name;
+	sepol_class_value_to_name;
+	sepol_common_iter_create;
+	sepol_common_iter_destroy;
+	sepol_common_iter_next;
+	sepol_common_perm_iter_create;
+	sepol_common_perm_iter_destroy;
+	sepol_common_perm_iter_next;
+	sepol_common_value_to_name;
+	sepol_cond_expr_iter_create;
+	sepol_cond_expr_iter_destroy;
+	sepol_cond_expr_iter_next;
+	sepol_cond_iter_create;
+	sepol_cond_iter_destroy;
+	sepol_cond_iter_next;
+	sepol_cond_rule_iter_create;
+	sepol_cond_rule_iter_destroy;
+	sepol_cond_rule_iter_get_av_data;
+	sepol_cond_rule_iter_get_type_data;
+	sepol_cond_rule_iter_get_xperm_driver;
+	sepol_cond_rule_iter_get_xperm_type;
+	sepol_cond_rule_iter_next;
+	sepol_cond_rule_xperm_iter_create;
+	sepol_constraint_add_perm;
+	sepol_constraint_clone;
+	sepol_constraint_create;
+	sepol_constraint_del_perm;
+	sepol_constraint_expr_add_name;
+	sepol_constraint_expr_clear_attr;
+	sepol_constraint_expr_clone;
+	sepol_constraint_expr_create;
+	sepol_constraint_expr_del_name;
+	sepol_constraint_expr_free;
+	sepol_constraint_expr_get_names;
+	sepol_constraint_expr_get_op;
+	sepol_constraint_expr_get_type;
+	sepol_constraint_expr_has_attr;
+	sepol_constraint_expr_has_name;
+	sepol_constraint_expr_set_attr;
+	sepol_constraint_expr_set_op;
+	sepol_constraint_expr_set_type;
+	sepol_constraint_expr_unset_attr;
+	sepol_constraint_free;
+	sepol_constraint_get_exprs;
+	sepol_constraint_get_perms;
+	sepol_constraint_has_perm;
+	sepol_constraint_insert_expr;
+	sepol_constraint_remove_expr;
+	sepol_devicetreecon_iter_create;
+	sepol_devicetreecon_iter_destroy;
+	sepol_devicetreecon_iter_get_context_role;
+	sepol_devicetreecon_iter_get_context_type;
+	sepol_devicetreecon_iter_get_context_user;
+	sepol_devicetreecon_iter_get_mls_range_high_cat;
+	sepol_devicetreecon_iter_get_mls_range_high_sens;
+	sepol_devicetreecon_iter_get_mls_range_low_cat;
+	sepol_devicetreecon_iter_get_mls_range_low_sens;
+	sepol_devicetreecon_iter_next;
+	sepol_filename_trans_iter_create;
+	sepol_filename_trans_iter_destroy;
+	sepol_filename_trans_iter_next;
+	sepol_fsuse_iter_create;
+	sepol_fsuse_iter_destroy;
+	sepol_fsuse_iter_get_context_role;
+	sepol_fsuse_iter_get_context_type;
+	sepol_fsuse_iter_get_context_user;
+	sepol_fsuse_iter_get_mls_range_high_cat;
+	sepol_fsuse_iter_get_mls_range_high_sens;
+	sepol_fsuse_iter_get_mls_range_low_cat;
+	sepol_fsuse_iter_get_mls_range_low_sens;
+	sepol_fsuse_iter_next;
+	sepol_genfscon_iter_create;
+	sepol_genfscon_iter_destroy;
+	sepol_genfscon_iter_get_context_role;
+	sepol_genfscon_iter_get_context_type;
+	sepol_genfscon_iter_get_context_user;
+	sepol_genfscon_iter_get_mls_range_high_cat;
+	sepol_genfscon_iter_get_mls_range_high_sens;
+	sepol_genfscon_iter_get_mls_range_low_cat;
+	sepol_genfscon_iter_get_mls_range_low_sens;
+	sepol_genfscon_iter_next;
+	sepol_ibendportcon_iter_create;
+	sepol_ibendportcon_iter_destroy;
+	sepol_ibendportcon_iter_get_context_role;
+	sepol_ibendportcon_iter_get_context_type;
+	sepol_ibendportcon_iter_get_context_user;
+	sepol_ibendportcon_iter_get_mls_range_high_cat;
+	sepol_ibendportcon_iter_get_mls_range_high_sens;
+	sepol_ibendportcon_iter_get_mls_range_low_cat;
+	sepol_ibendportcon_iter_get_mls_range_low_sens;
+	sepol_ibendportcon_iter_next;
+	sepol_ibpkeycon_iter_create;
+	sepol_ibpkeycon_iter_destroy;
+	sepol_ibpkeycon_iter_get_context_role;
+	sepol_ibpkeycon_iter_get_context_type;
+	sepol_ibpkeycon_iter_get_context_user;
+	sepol_ibpkeycon_iter_get_mls_range_high_cat;
+	sepol_ibpkeycon_iter_get_mls_range_high_sens;
+	sepol_ibpkeycon_iter_get_mls_range_low_cat;
+	sepol_ibpkeycon_iter_get_mls_range_low_sens;
+	sepol_ibpkeycon_iter_next;
+	sepol_iomemcon_iter_create;
+	sepol_iomemcon_iter_destroy;
+	sepol_iomemcon_iter_get_context_role;
+	sepol_iomemcon_iter_get_context_type;
+	sepol_iomemcon_iter_get_context_user;
+	sepol_iomemcon_iter_get_mls_range_high_cat;
+	sepol_iomemcon_iter_get_mls_range_high_sens;
+	sepol_iomemcon_iter_get_mls_range_low_cat;
+	sepol_iomemcon_iter_get_mls_range_low_sens;
+	sepol_iomemcon_iter_next;
+	sepol_ioportcon_iter_create;
+	sepol_ioportcon_iter_destroy;
+	sepol_ioportcon_iter_get_context_role;
+	sepol_ioportcon_iter_get_context_type;
+	sepol_ioportcon_iter_get_context_user;
+	sepol_ioportcon_iter_get_mls_range_high_cat;
+	sepol_ioportcon_iter_get_mls_range_high_sens;
+	sepol_ioportcon_iter_get_mls_range_low_cat;
+	sepol_ioportcon_iter_get_mls_range_low_sens;
+	sepol_ioportcon_iter_next;
+	sepol_isid_iter_create;
+	sepol_isid_iter_destroy;
+	sepol_isid_iter_get_context_role;
+	sepol_isid_iter_get_context_type;
+	sepol_isid_iter_get_context_user;
+	sepol_isid_iter_get_mls_range_high_cat;
+	sepol_isid_iter_get_mls_range_high_sens;
+	sepol_isid_iter_get_mls_range_low_cat;
+	sepol_isid_iter_get_mls_range_low_sens;
+	sepol_isid_iter_get_name;
+	sepol_isid_iter_next;
+	sepol_netifcon_iter_create;
+	sepol_netifcon_iter_destroy;
+	sepol_netifcon_iter_get_context_role;
+	sepol_netifcon_iter_get_context_type;
+	sepol_netifcon_iter_get_context_user;
+	sepol_netifcon_iter_get_mls_range_high_cat;
+	sepol_netifcon_iter_get_mls_range_high_sens;
+	sepol_netifcon_iter_get_mls_range_low_cat;
+	sepol_netifcon_iter_get_mls_range_low_sens;
+	sepol_netifcon_iter_get_msg_context_role;
+	sepol_netifcon_iter_get_msg_context_type;
+	sepol_netifcon_iter_get_msg_context_user;
+	sepol_netifcon_iter_get_msg_mls_range_high_cat;
+	sepol_netifcon_iter_get_msg_mls_range_high_sens;
+	sepol_netifcon_iter_get_msg_mls_range_low_cat;
+	sepol_netifcon_iter_get_msg_mls_range_low_sens;
+	sepol_netifcon_iter_next;
+	sepol_nodecon6_iter_create;
+	sepol_nodecon6_iter_destroy;
+	sepol_nodecon6_iter_get_context_role;
+	sepol_nodecon6_iter_get_context_type;
+	sepol_nodecon6_iter_get_context_user;
+	sepol_nodecon6_iter_get_mls_range_high_cat;
+	sepol_nodecon6_iter_get_mls_range_high_sens;
+	sepol_nodecon6_iter_get_mls_range_low_cat;
+	sepol_nodecon6_iter_get_mls_range_low_sens;
+	sepol_nodecon6_iter_next;
+	sepol_nodecon_iter_create;
+	sepol_nodecon_iter_destroy;
+	sepol_nodecon_iter_get_context_role;
+	sepol_nodecon_iter_get_context_type;
+	sepol_nodecon_iter_get_context_user;
+	sepol_nodecon_iter_get_mls_range_high_cat;
+	sepol_nodecon_iter_get_mls_range_high_sens;
+	sepol_nodecon_iter_get_mls_range_low_cat;
+	sepol_nodecon_iter_get_mls_range_low_sens;
+	sepol_nodecon_iter_next;
+	sepol_pcidevicecon_iter_create;
+	sepol_pcidevicecon_iter_destroy;
+	sepol_pcidevicecon_iter_get_context_role;
+	sepol_pcidevicecon_iter_get_context_type;
+	sepol_pcidevicecon_iter_get_context_user;
+	sepol_pcidevicecon_iter_get_mls_range_high_cat;
+	sepol_pcidevicecon_iter_get_mls_range_high_sens;
+	sepol_pcidevicecon_iter_get_mls_range_low_cat;
+	sepol_pcidevicecon_iter_get_mls_range_low_sens;
+	sepol_pcidevicecon_iter_next;
+	sepol_perm_iter_create;
+	sepol_perm_iter_destroy;
+	sepol_perm_iter_next;
+	sepol_permissive_iter_create;
+	sepol_permissive_iter_destroy;
+	sepol_permissive_iter_next;
+	sepol_pirqcon_iter_create;
+	sepol_pirqcon_iter_destroy;
+	sepol_pirqcon_iter_get_context_role;
+	sepol_pirqcon_iter_get_context_type;
+	sepol_pirqcon_iter_get_context_user;
+	sepol_pirqcon_iter_get_mls_range_high_cat;
+	sepol_pirqcon_iter_get_mls_range_high_sens;
+	sepol_pirqcon_iter_get_mls_range_low_cat;
+	sepol_pirqcon_iter_get_mls_range_low_sens;
+	sepol_pirqcon_iter_next;
+	sepol_polcap_iter_create;
+	sepol_polcap_iter_destroy;
+	sepol_polcap_iter_next;
+	sepol_policydb_av_to_string;
+	sepol_policydb_extended_perms_to_string;
+	sepol_policydb_get_handle_unknown;
+	sepol_policydb_get_target_platform;
+	sepol_policydb_get_vers;
+	sepol_policydb_rebuild_attr_map;
+	sepol_policydb_sid_to_context_record;
+	sepol_policydb_sid_to_context_string;
+	sepol_policydb_set_permissive_flags;
+	sepol_portcon_iter_create;
+	sepol_portcon_iter_destroy;
+	sepol_portcon_iter_get_context_role;
+	sepol_portcon_iter_get_context_type;
+	sepol_portcon_iter_get_context_user;
+	sepol_portcon_iter_get_mls_range_high_cat;
+	sepol_portcon_iter_get_mls_range_high_sens;
+	sepol_portcon_iter_get_mls_range_low_cat;
+	sepol_portcon_iter_get_mls_range_low_sens;
+	sepol_portcon_iter_next;
+	sepol_range_trans_iter_create;
+	sepol_range_trans_iter_destroy;
+	sepol_range_trans_iter_get_high_cat;
+	sepol_range_trans_iter_get_high_sens;
+	sepol_range_trans_iter_get_low_cat;
+	sepol_range_trans_iter_get_low_sens;
+	sepol_range_trans_iter_next;
+	sepol_role_add_subrole;
+	sepol_role_add_type;
+	sepol_role_allow_iter_create;
+	sepol_role_allow_iter_destroy;
+	sepol_role_allow_iter_next;
+	sepol_role_clone;
+	sepol_role_compare;
+	sepol_role_compare2;
+	sepol_role_count;
+	sepol_role_create;
+	sepol_role_del_subrole;
+	sepol_role_del_type;
+	sepol_role_exists;
+	sepol_role_free;
+	sepol_role_get_bounds;
+	sepol_role_get_flavor;
+	sepol_role_get_name;
+	sepol_role_get_subroles;
+	sepol_role_get_types;
+	sepol_role_has_type;
+	sepol_role_iter_create;
+	sepol_role_iter_destroy;
+	sepol_role_iter_next;
+	sepol_role_key_create;
+	sepol_role_key_extract;
+	sepol_role_key_free;
+	sepol_role_key_unpack;
+	sepol_role_query;
+	sepol_role_query_by_value;
+	sepol_role_set_bounds;
+	sepol_role_set_flavor;
+	sepol_role_set_name;
+	sepol_role_trans_iter_create;
+	sepol_role_trans_iter_destroy;
+	sepol_role_trans_iter_next;
+	sepol_role_value_to_name;
+	sepol_sens_iter_create;
+	sepol_sens_iter_destroy;
+	sepol_sens_iter_get_level_cat;
+	sepol_sens_iter_next;
+	sepol_sens_value_to_name;
+	sepol_sid_table_free;
+	sepol_sid_table_load_isids;
+	sepol_sid_table_new;
+	sepol_sid_table_set_opaque;
+	sepol_sid_to_context_record;
+	sepol_type_add_subtype;
+	sepol_type_clone;
+	sepol_type_compare;
+	sepol_type_compare2;
+	sepol_type_count;
+	sepol_type_create;
+	sepol_type_del_subtype;
+	sepol_type_exists;
+	sepol_type_free;
+	sepol_type_get_alias_of;
+	sepol_type_get_bounds;
+	sepol_type_get_flavor;
+	sepol_type_get_name;
+	sepol_type_get_subtypes;
+	sepol_type_has_flag;
+	sepol_type_has_subtype;
+	sepol_type_iter_create;
+	sepol_type_iter_destroy;
+	sepol_type_iter_next;
+	sepol_type_key_create;
+	sepol_type_key_extract;
+	sepol_type_key_free;
+	sepol_type_key_unpack;
+	sepol_type_modify;
+	sepol_type_query;
+	sepol_type_query_by_value;
+	sepol_type_set_alias_of;
+	sepol_type_set_bounds;
+	sepol_type_set_flag;
+	sepol_type_set_flavor;
+	sepol_type_set_name;
+	sepol_type_unset_flag;
+	sepol_type_value_to_name;
+	sepol_user_get_dflt_level_cat;
+	sepol_user_get_dflt_level_sens;
+	sepol_user_get_range_high_cat;
+	sepol_user_get_range_high_sens;
+	sepol_user_get_range_low_cat;
+	sepol_user_get_range_low_sens;
+	sepol_user_iter_create;
+	sepol_user_iter_destroy;
+	sepol_user_iter_next;
+	sepol_user_query_by_value;
+	sepol_user_value_to_name;
+	sepol_values_to_context_record;
+	sepol_values_to_context_string;
+	sepol_xperm_iter_create;
+	sepol_xperm_iter_destroy;
+	sepol_xperm_iter_next;
+} LIBSEPOL_3.11;
-- 
2.55.0

