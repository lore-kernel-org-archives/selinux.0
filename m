Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760AAC18E5B
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E18822522
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ9tKajW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCJVJK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:09:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40075 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgCJVJK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Mar 2020 17:09:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id l184so42267pfl.7
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2020 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fhzx7LABj10WHNDCd5+l58vTXwAnQjLzYJ4ZXRcsBuI=;
        b=jZ9tKajWH9SS0NmVGB/glKxchrP4z/hJatVDBYfTfvC0ddkEQm9j5uOgPxFNF9JMlu
         bbNcAKqZ7OyQfezgg7Kkw8HQGTBUr8b/OffoRfHzFnBougw6a1aqXzn2MircYPrf0wKQ
         XGvgD8Ji8syX/i7Per9CnIYiRPcF+c5ZJtLQhDDKP5hn4SCGpOe2ZQX3poIHruv2Dvw4
         SzDltqh2ssnMAIjJhgPveIUXzti1G+ctyxlnO4IROwCaKnV097Y2r+N12/3uTobuROae
         e8QfsO68DDfY3ZhiXzG1s3x8ICBfRAxr7CWxRbFzgpocNMEFXnlQkqGU0QHIDRRVT4Zc
         gYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fhzx7LABj10WHNDCd5+l58vTXwAnQjLzYJ4ZXRcsBuI=;
        b=bgMJ++BHk6mkggUaYrpAUyLTqAtx9iM+IpgW6g4oEyFzd6fZ2c+w107+ul6pAY1egx
         6o4mgXycRw1dc9yXdv2PimBwUJDsr6zYvqkoeDJ5VD/jQgq2wi3LyAHcgWlKtH3Fgua8
         czl3CYetY8ETY3eWuLTZrs62ZjGPa8GlfDEEH5XGJcGQSeMJZDh5wJM8ZBFV6xbdCiAt
         g31z+gl5JOtrOBzY7xOj4Ou0XB0rPJZ/SdJbUaxCFTEhfHc/xu2G0bRxzkEkn9j+ptNB
         +9WVY7zhKz4Cb1/L94eBOWya9/7scHRVfDM0vLTOkMBzpRyr8nvSKTILXXKIhZoPF2z6
         /6CQ==
X-Gm-Message-State: ANhLgQ0myZ85WE6kXWgaRtLVDava+EMajLXSjZ8RssPqNSCcE1OKA0nb
        2Nkz9kWllZDo6w2FQ+EBnfg=
X-Google-Smtp-Source: ADFU+vtas43NAgd3taGEvrYWqxJdRDQevLUvAdc1dV90k0vx2lF+RKEIKmCS+C94vac6crJhFnaj4g==
X-Received: by 2002:a63:b508:: with SMTP id y8mr23000859pge.225.1583874548158;
        Tue, 10 Mar 2020 14:09:08 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id s11sm19378807pfh.7.2020.03.10.14.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:09:07 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org, selinux@vger.kernel.org
Cc:     bill.c.roberts@gmail.com, drepper@redhat.com, omosnace@redhat.com,
        plautrba@redhat.com, stephen.smalley.work@gmail.com,
        william.c.roberts@intel.com
Subject: [PATCH v2 3/3] lbespol: remove wild cards in mapfile
Date:   Tue, 10 Mar 2020 16:08:54 -0500
Message-Id: <20200310210854.466-4-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310210854.466-1-william.c.roberts@intel.com>
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

With the old hidden_def and hidden_proto DSO infrastructure removed,
correctness of the map file becomes paramount, as it is what filters out
public API. Because of this, the wild cards should not be used, as it
lets some functions through that should not be made public API. Thus
remove the wild cards, and sort the list.

Additionally, verify that nothing changed in external symbols as well:

This was checked by generating an old export map (from master):
nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map

Then creating a new one for this library after this patch is applied:
nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map

And diffing them:
diff old.map new.map

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/libsepol.map.in | 275 +++++++++++++++++++++++++++++++----
 1 file changed, 245 insertions(+), 30 deletions(-)

diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index f4946a79cae7..f08c2a861693 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -1,39 +1,254 @@
 LIBSEPOL_1.0 {
-  global: 
-	expand_module_avrules;
-	sepol_module_package_*; sepol_link_modules; sepol_expand_module; sepol_link_packages;
-	sepol_bool_*; sepol_genbools*; 
-	sepol_context_*; sepol_mls_*; sepol_check_context;
-	sepol_iface_*; 
-	sepol_port_*;
-	sepol_ibpkey_*;
-	sepol_ibendport_*;
-	sepol_node_*;
-	sepol_user_*; sepol_genusers; sepol_set_delusers;
-	sepol_msg_*; sepol_debug;
-	sepol_handle_*;
-	sepol_policydb_*; sepol_set_policydb_from_file; 
-	sepol_policy_kern_*;
-	sepol_policy_file_*;
-	sepol_get_disable_dontaudit;
-	sepol_set_disable_dontaudit;
-	sepol_set_expand_consume_base;
-	sepol_get_preserve_tunables; sepol_set_preserve_tunables;
+  global:
+	cil_add_file;
+	cil_build_policydb;
+	cil_compile;
+	cil_db_destroy;
 	cil_db_init;
+	cil_filecons_to_string;
+	cil_selinuxusers_to_string;
 	cil_set_disable_dontaudit;
 	cil_set_disable_neverallow;
-	cil_set_preserve_tunables;
 	cil_set_handle_unknown;
-	cil_db_destroy;
-	cil_add_file;
-	cil_compile;
-	cil_build_policydb;
-	cil_userprefixes_to_string;
-	cil_selinuxusers_to_string;
-	cil_filecons_to_string;
-	cil_set_log_level;
 	cil_set_log_handler;
-	cil_set_malloc_error_handler;
+	cil_set_log_level;
+	cil_set_preserve_tunables;
+	cil_userprefixes_to_string;
+	expand_module_avrules;
+	sepol_bool_clone;
+	sepol_bool_compare;
+	sepol_bool_compare2;
+	sepol_bool_count;
+	sepol_bool_create;
+	sepol_bool_exists;
+	sepol_bool_free;
+	sepol_bool_get_name;
+	sepol_bool_get_value;
+	sepol_bool_iterate;
+	sepol_bool_key_create;
+	sepol_bool_key_extract;
+	sepol_bool_key_free;
+	sepol_bool_key_unpack;
+	sepol_bool_query;
+	sepol_bool_set;
+	sepol_bool_set_name;
+	sepol_bool_set_value;
+	sepol_check_context;
+	sepol_context_check;
+	sepol_context_clone;
+	sepol_context_create;
+	sepol_context_free;
+	sepol_context_from_string;
+	sepol_context_get_mls;
+	sepol_context_get_role;
+	sepol_context_get_type;
+	sepol_context_get_user;
+	sepol_context_set_mls;
+	sepol_context_set_role;
+	sepol_context_set_type;
+	sepol_context_set_user;
+	sepol_context_to_string;
+	sepol_debug;
+	sepol_expand_module;
+	sepol_genbools;
+	sepol_genbools_array;
+	sepol_genusers;
+	sepol_get_disable_dontaudit;
+	sepol_get_preserve_tunables;
+	sepol_handle_create;
+	sepol_handle_destroy;
+	sepol_ibendport_alloc_ibdev_name;
+	sepol_ibendport_clone;
+	sepol_ibendport_compare;
+	sepol_ibendport_compare2;
+	sepol_ibendport_count;
+	sepol_ibendport_create;
+	sepol_ibendport_exists;
+	sepol_ibendport_free;
+	sepol_ibendport_get_con;
+	sepol_ibendport_get_ibdev_name;
+	sepol_ibendport_get_port;
+	sepol_ibendport_iterate;
+	sepol_ibendport_key_create;
+	sepol_ibendport_key_extract;
+	sepol_ibendport_key_free;
+	sepol_ibendport_key_unpack;
+	sepol_ibendport_modify;
+	sepol_ibendport_query;
+	sepol_ibendport_set_con;
+	sepol_ibendport_set_ibdev_name;
+	sepol_ibendport_set_port;
+	sepol_ibpkey_clone;
+	sepol_ibpkey_compare;
+	sepol_ibpkey_compare2;
+	sepol_ibpkey_count;
+	sepol_ibpkey_create;
+	sepol_ibpkey_exists;
+	sepol_ibpkey_free;
+	sepol_ibpkey_get_con;
+	sepol_ibpkey_get_high;
+	sepol_ibpkey_get_low;
+	sepol_ibpkey_get_subnet_prefix;
+	sepol_ibpkey_get_subnet_prefix_bytes;
+	sepol_ibpkey_iterate;
+	sepol_ibpkey_key_create;
+	sepol_ibpkey_key_extract;
+	sepol_ibpkey_key_free;
+	sepol_ibpkey_key_unpack;
+	sepol_ibpkey_modify;
+	sepol_ibpkey_query;
+	sepol_ibpkey_set_con;
+	sepol_ibpkey_set_pkey;
+	sepol_ibpkey_set_range;
+	sepol_ibpkey_set_subnet_prefix;
+	sepol_ibpkey_set_subnet_prefix_bytes;
+	sepol_iface_clone;
+	sepol_iface_compare;
+	sepol_iface_compare2;
+	sepol_iface_count;
+	sepol_iface_create;
+	sepol_iface_exists;
+	sepol_iface_free;
+	sepol_iface_get_ifcon;
+	sepol_iface_get_msgcon;
+	sepol_iface_get_name;
+	sepol_iface_iterate;
+	sepol_iface_key_create;
+	sepol_iface_key_extract;
+	sepol_iface_key_free;
+	sepol_iface_key_unpack;
+	sepol_iface_modify;
+	sepol_iface_query;
+	sepol_iface_set_ifcon;
+	sepol_iface_set_msgcon;
+	sepol_iface_set_name;
+	sepol_link_modules;
+	sepol_link_packages;
+	sepol_mls_check;
+	sepol_mls_contains;
+	sepol_module_package_create;
+	sepol_module_package_free;
+	sepol_module_package_get_file_contexts;
+	sepol_module_package_get_file_contexts_len;
+	sepol_module_package_get_netfilter_contexts;
+	sepol_module_package_get_netfilter_contexts_len;
+	sepol_module_package_get_policy;
+	sepol_module_package_get_seusers;
+	sepol_module_package_get_seusers_len;
+	sepol_module_package_get_user_extra;
+	sepol_module_package_get_user_extra_len;
+	sepol_module_package_info;
+	sepol_module_package_read;
+	sepol_module_package_set_file_contexts;
+	sepol_module_package_set_netfilter_contexts;
+	sepol_module_package_set_seusers;
+	sepol_module_package_set_user_extra;
+	sepol_module_package_write;
+	sepol_msg_get_channel;
+	sepol_msg_get_fname;
+	sepol_msg_get_level;
+	sepol_msg_set_callback;
+	sepol_node_clone;
+	sepol_node_compare;
+	sepol_node_compare2;
+	sepol_node_count;
+	sepol_node_create;
+	sepol_node_exists;
+	sepol_node_free;
+	sepol_node_get_addr;
+	sepol_node_get_addr_bytes;
+	sepol_node_get_con;
+	sepol_node_get_mask;
+	sepol_node_get_mask_bytes;
+	sepol_node_get_proto;
+	sepol_node_get_proto_str;
+	sepol_node_iterate;
+	sepol_node_key_create;
+	sepol_node_key_extract;
+	sepol_node_key_free;
+	sepol_node_key_unpack;
+	sepol_node_modify;
+	sepol_node_query;
+	sepol_node_set_addr;
+	sepol_node_set_addr_bytes;
+	sepol_node_set_con;
+	sepol_node_set_mask;
+	sepol_node_set_mask_bytes;
+	sepol_node_set_proto;
+	sepol_policydb_compat_net;
+	sepol_policydb_create;
+	sepol_policydb_free;
+	sepol_policydb_from_image;
+	sepol_policydb_mls_enabled;
+	sepol_policydb_read;
+	sepol_policydb_set_handle_unknown;
+	sepol_policydb_set_target_platform;
+	sepol_policydb_set_typevers;
+	sepol_policydb_set_vers;
+	sepol_policydb_to_image;
+	sepol_policydb_write;
+	sepol_policy_file_create;
+	sepol_policy_file_free;
+	sepol_policy_file_get_len;
+	sepol_policy_file_set_fp;
+	sepol_policy_file_set_handle;
+	sepol_policy_file_set_mem;
+	sepol_policy_kern_vers_max;
+	sepol_policy_kern_vers_min;
+	sepol_port_clone;
+	sepol_port_compare;
+	sepol_port_compare2;
+	sepol_port_count;
+	sepol_port_create;
+	sepol_port_exists;
+	sepol_port_free;
+	sepol_port_get_con;
+	sepol_port_get_high;
+	sepol_port_get_low;
+	sepol_port_get_proto;
+	sepol_port_get_proto_str;
+	sepol_port_iterate;
+	sepol_port_key_create;
+	sepol_port_key_extract;
+	sepol_port_key_free;
+	sepol_port_key_unpack;
+	sepol_port_modify;
+	sepol_port_query;
+	sepol_port_set_con;
+	sepol_port_set_port;
+	sepol_port_set_proto;
+	sepol_port_set_range;
+	sepol_set_delusers;
+	sepol_set_disable_dontaudit;
+	sepol_set_expand_consume_base;
+	sepol_set_policydb_from_file;
+	sepol_set_preserve_tunables;
+	sepol_user_add_role;
+	sepol_user_clone;
+	sepol_user_compare;
+	sepol_user_compare2;
+	sepol_user_count;
+	sepol_user_create;
+	sepol_user_del_role;
+	sepol_user_exists;
+	sepol_user_free;
+	sepol_user_get_mlslevel;
+	sepol_user_get_mlsrange;
+	sepol_user_get_name;
+	sepol_user_get_num_roles;
+	sepol_user_get_roles;
+	sepol_user_has_role;
+	sepol_user_iterate;
+	sepol_user_key_create;
+	sepol_user_key_extract;
+	sepol_user_key_free;
+	sepol_user_key_unpack;
+	sepol_user_modify;
+	sepol_user_query;
+	sepol_user_set_mlslevel;
+	sepol_user_set_mlsrange;
+	sepol_user_set_name;
+	sepol_user_set_roles;
   local: *;
 };
 
-- 
2.17.1

