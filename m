Return-Path: <SRS0=0U01=5I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC999C54FCE
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B662D2072E
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXaUk/SJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgCWRuz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:50:55 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35080 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgCWRuz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Mar 2020 13:50:55 -0400
Received: by mail-pj1-f67.google.com with SMTP id g9so171102pjp.0
        for <selinux@vger.kernel.org>; Mon, 23 Mar 2020 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gB/uemBVf3Q7IBqayTdi30dYvQsxjgC7rF2HZ00OFtg=;
        b=EXaUk/SJ/i6RWyUgtaNUO2BZfI5iIH0UopJhEupIgoZgocalR4JrTZtlPBnj1VT/OG
         OmMqHHXCI9cI2/PY/bWVHgzJIriryqHoD2gK1rUw1txBtl5F4sQ58X4DYdWU0g9s2Nvl
         Sebv0nTZGst0aNXbHY39xhmhoepaCfOF0n9luc+SAfZP3SuNms87naDo7c+/JtmrDNvx
         NgRc+gp2yU2UFi8QqxOXQDJHweqZOp6Z4kToD0xnhKtEPDGm3fBan6/yreCfNwvdw4lu
         SX36W+Q6u/lEct7lMomQ+J+peY17A3b9bPz0ukZTjDYozhMRV9c8ht7gDeE8PmqM8uqf
         Er5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gB/uemBVf3Q7IBqayTdi30dYvQsxjgC7rF2HZ00OFtg=;
        b=EEr0vdtwzSX3I2heE5iWOIyZ3Zl+TG3tAyQL5H2K8bSToN0orWvv82m3RUwyXZuKLG
         yOuyMgIjttQ6j069BunlCVY5GG+Xh8QsrMCaZsJ6zJzeJG1SpK6sCtA3AGUZZ5x8QkuQ
         8Te+6klqhNIY8OlYX6KLNdOYQvTiDg10yCSRmpBSf5Sk3X+O3ueD7H5YByhqhejOlbxd
         vYCpM/3yJ1kLaXLaTOcdsFhJHb/mzwksLB2H4/JwSyGXdbzFaxrJiXAHXRLv+sCYgEN9
         WlOG0pxbi9biGDP0VPkRxh+YRpLSmffXCEr/HfRIR3Q9BKfLuPhOZ5E6KlinLuGUFTw2
         saHA==
X-Gm-Message-State: ANhLgQ1rQ2FGTQqbhtEhKFi5PTeN2fCIQwCzG6LNl5CNjOnYAZMHZiWG
        gJ8QmSi+t4WcxvrsXO+i6MQ=
X-Google-Smtp-Source: ADFU+vsKuBZs7W6zlA9NgLb08aOdIMEBHFz1E+nABeiqN9C1xORG6+OzG6mwkIKGQ/CLTCLBKMSLcw==
X-Received: by 2002:a17:90a:a511:: with SMTP id a17mr554567pjq.178.1584985853837;
        Mon, 23 Mar 2020 10:50:53 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id j126sm13963979pfg.60.2020.03.23.10.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:50:53 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     drepper@redhat.com, nicolas.iooss@m4x.org, omosnace@redhat.com,
        plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: [PATCH 3/4] libsemanage: update linker script
Date:   Mon, 23 Mar 2020 12:50:36 -0500
Message-Id: <20200323175037.19170-4-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323175037.19170-1-william.c.roberts@intel.com>
References: <20200323175037.19170-1-william.c.roberts@intel.com>
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
nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map

Then creating a new one for this library after this patch is applied:
nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map

And diffing them:
diff old.map new.map

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsemanage/src/libsemanage.map | 372 +++++++++++++++++++++++++++++---
 1 file changed, 345 insertions(+), 27 deletions(-)

diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 020366967745..e1861ccbebe1 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -1,31 +1,349 @@
 LIBSEMANAGE_1.0 {
-  global: semanage_handle_create; semanage_handle_destroy; 
-          semanage_is_managed; semanage_connect; semanage_disconnect; 
-	  semanage_msg_*;
-          semanage_begin_transaction; semanage_commit;
-	  semanage_module_install; semanage_module_install_file;
-	  semanage_module_upgrade; semanage_module_upgrade_file;
-	  semanage_module_install_base; semanage_module_install_base_file;
-	  semanage_module_enable;
-	  semanage_module_disable;
-	  semanage_module_remove;
-	  semanage_module_list; semanage_module_info_datum_destroy;
-	  semanage_module_list_nth; semanage_module_get_name;
-	  semanage_module_get_version; semanage_select_store;
-	  semanage_module_get_enabled;
-	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
-	  semanage_set_root;
-	  semanage_root;
-	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
-	  semanage_iface_*; semanage_port_*; semanage_context_*;
-	  semanage_ibpkey_*;
-	  semanage_ibendport_*;
-	  semanage_node_*;
-	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
-	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
-	  semanage_mls_enabled;
-	  semanage_set_check_contexts;
-	  semanage_get_preserve_tunables; semanage_set_preserve_tunables;
+  global:
+    semanage_access_check;
+    semanage_begin_transaction;
+    semanage_bool_clone;
+    semanage_bool_compare;
+    semanage_bool_compare2;
+    semanage_bool_count;
+    semanage_bool_count_active;
+    semanage_bool_count_local;
+    semanage_bool_create;
+    semanage_bool_del_local;
+    semanage_bool_exists;
+    semanage_bool_exists_active;
+    semanage_bool_exists_local;
+    semanage_bool_free;
+    semanage_bool_get_name;
+    semanage_bool_get_value;
+    semanage_bool_iterate;
+    semanage_bool_iterate_active;
+    semanage_bool_iterate_local;
+    semanage_bool_key_create;
+    semanage_bool_key_extract;
+    semanage_bool_key_free;
+    semanage_bool_list;
+    semanage_bool_list_active;
+    semanage_bool_list_local;
+    semanage_bool_modify_local;
+    semanage_bool_query;
+    semanage_bool_query_active;
+    semanage_bool_query_local;
+    semanage_bool_set_active;
+    semanage_bool_set_name;
+    semanage_bool_set_value;
+    semanage_commit;
+    semanage_connect;
+    semanage_context_clone;
+    semanage_context_create;
+    semanage_context_free;
+    semanage_context_from_string;
+    semanage_context_get_mls;
+    semanage_context_get_role;
+    semanage_context_get_type;
+    semanage_context_get_user;
+    semanage_context_set_mls;
+    semanage_context_set_role;
+    semanage_context_set_type;
+    semanage_context_set_user;
+    semanage_context_to_string;
+    semanage_disconnect;
+    semanage_fcontext_clone;
+    semanage_fcontext_compare;
+    semanage_fcontext_compare2;
+    semanage_fcontext_count;
+    semanage_fcontext_count_local;
+    semanage_fcontext_create;
+    semanage_fcontext_del_local;
+    semanage_fcontext_exists;
+    semanage_fcontext_exists_local;
+    semanage_fcontext_free;
+    semanage_fcontext_get_con;
+    semanage_fcontext_get_expr;
+    semanage_fcontext_get_type;
+    semanage_fcontext_get_type_str;
+    semanage_fcontext_iterate;
+    semanage_fcontext_iterate_local;
+    semanage_fcontext_key_create;
+    semanage_fcontext_key_extract;
+    semanage_fcontext_key_free;
+    semanage_fcontext_list;
+    semanage_fcontext_list_homedirs;
+    semanage_fcontext_list_local;
+    semanage_fcontext_modify_local;
+    semanage_fcontext_query;
+    semanage_fcontext_query_local;
+    semanage_fcontext_set_con;
+    semanage_fcontext_set_expr;
+    semanage_fcontext_set_type;
+    semanage_get_default_priority;
+    semanage_get_disable_dontaudit;
+    semanage_get_hll_compiler_path;
+    semanage_get_ignore_module_cache;
+    semanage_get_preserve_tunables;
+    semanage_handle_create;
+    semanage_handle_destroy;
+    semanage_ibendport_clone;
+    semanage_ibendport_compare;
+    semanage_ibendport_compare2;
+    semanage_ibendport_count;
+    semanage_ibendport_count_local;
+    semanage_ibendport_create;
+    semanage_ibendport_del_local;
+    semanage_ibendport_exists;
+    semanage_ibendport_exists_local;
+    semanage_ibendport_free;
+    semanage_ibendport_get_con;
+    semanage_ibendport_get_ibdev_name;
+    semanage_ibendport_get_port;
+    semanage_ibendport_iterate;
+    semanage_ibendport_iterate_local;
+    semanage_ibendport_key_create;
+    semanage_ibendport_key_extract;
+    semanage_ibendport_key_free;
+    semanage_ibendport_list;
+    semanage_ibendport_list_local;
+    semanage_ibendport_modify_local;
+    semanage_ibendport_query;
+    semanage_ibendport_query_local;
+    semanage_ibendport_set_con;
+    semanage_ibendport_set_ibdev_name;
+    semanage_ibendport_set_port;
+    semanage_ibpkey_clone;
+    semanage_ibpkey_compare;
+    semanage_ibpkey_compare2;
+    semanage_ibpkey_count;
+    semanage_ibpkey_count_local;
+    semanage_ibpkey_create;
+    semanage_ibpkey_del_local;
+    semanage_ibpkey_exists;
+    semanage_ibpkey_exists_local;
+    semanage_ibpkey_free;
+    semanage_ibpkey_get_con;
+    semanage_ibpkey_get_high;
+    semanage_ibpkey_get_low;
+    semanage_ibpkey_get_subnet_prefix;
+    semanage_ibpkey_get_subnet_prefix_bytes;
+    semanage_ibpkey_iterate;
+    semanage_ibpkey_iterate_local;
+    semanage_ibpkey_key_create;
+    semanage_ibpkey_key_extract;
+    semanage_ibpkey_key_free;
+    semanage_ibpkey_list;
+    semanage_ibpkey_list_local;
+    semanage_ibpkey_modify_local;
+    semanage_ibpkey_query;
+    semanage_ibpkey_query_local;
+    semanage_ibpkey_set_con;
+    semanage_ibpkey_set_pkey;
+    semanage_ibpkey_set_range;
+    semanage_ibpkey_set_subnet_prefix;
+    semanage_ibpkey_set_subnet_prefix_bytes;
+    semanage_iface_clone;
+    semanage_iface_compare;
+    semanage_iface_compare2;
+    semanage_iface_count;
+    semanage_iface_count_local;
+    semanage_iface_create;
+    semanage_iface_del_local;
+    semanage_iface_exists;
+    semanage_iface_exists_local;
+    semanage_iface_free;
+    semanage_iface_get_ifcon;
+    semanage_iface_get_msgcon;
+    semanage_iface_get_name;
+    semanage_iface_iterate;
+    semanage_iface_iterate_local;
+    semanage_iface_key_create;
+    semanage_iface_key_extract;
+    semanage_iface_key_free;
+    semanage_iface_list;
+    semanage_iface_list_local;
+    semanage_iface_modify_local;
+    semanage_iface_query;
+    semanage_iface_query_local;
+    semanage_iface_set_ifcon;
+    semanage_iface_set_msgcon;
+    semanage_iface_set_name;
+    semanage_is_connected;
+    semanage_is_managed;
+    semanage_mls_enabled;
+    semanage_module_disable;
+    semanage_module_enable;
+    semanage_module_extract;
+    semanage_module_get_enabled;
+    semanage_module_get_module_info;
+    semanage_module_get_name;
+    semanage_module_get_version;
+    semanage_module_info_create;
+    semanage_module_info_datum_destroy;
+    semanage_module_info_destroy;
+    semanage_module_info_get_enabled;
+    semanage_module_info_get_lang_ext;
+    semanage_module_info_get_name;
+    semanage_module_info_get_priority;
+    semanage_module_info_set_enabled;
+    semanage_module_info_set_lang_ext;
+    semanage_module_info_set_name;
+    semanage_module_info_set_priority;
+    semanage_module_install;
+    semanage_module_install_base;
+    semanage_module_install_base_file;
+    semanage_module_install_file;
+    semanage_module_install_info;
+    semanage_module_key_create;
+    semanage_module_key_destroy;
+    semanage_module_key_get_name;
+    semanage_module_key_get_priority;
+    semanage_module_key_set_name;
+    semanage_module_key_set_priority;
+    semanage_module_list;
+    semanage_module_list_all;
+    semanage_module_list_nth;
+    semanage_module_remove;
+    semanage_module_remove_key;
+    semanage_module_set_enabled;
+    semanage_module_upgrade;
+    semanage_module_upgrade_file;
+    semanage_msg_get_channel;
+    semanage_msg_get_fname;
+    semanage_msg_get_level;
+    semanage_msg_set_callback;
+    semanage_node_clone;
+    semanage_node_compare;
+    semanage_node_compare2;
+    semanage_node_count;
+    semanage_node_count_local;
+    semanage_node_create;
+    semanage_node_del_local;
+    semanage_node_exists;
+    semanage_node_exists_local;
+    semanage_node_free;
+    semanage_node_get_addr;
+    semanage_node_get_addr_bytes;
+    semanage_node_get_con;
+    semanage_node_get_mask;
+    semanage_node_get_mask_bytes;
+    semanage_node_get_proto;
+    semanage_node_get_proto_str;
+    semanage_node_iterate;
+    semanage_node_iterate_local;
+    semanage_node_key_create;
+    semanage_node_key_extract;
+    semanage_node_key_free;
+    semanage_node_list;
+    semanage_node_list_local;
+    semanage_node_modify_local;
+    semanage_node_query;
+    semanage_node_query_local;
+    semanage_node_set_addr;
+    semanage_node_set_addr_bytes;
+    semanage_node_set_con;
+    semanage_node_set_mask;
+    semanage_node_set_mask_bytes;
+    semanage_node_set_proto;
+    semanage_port_clone;
+    semanage_port_compare;
+    semanage_port_compare2;
+    semanage_port_count;
+    semanage_port_count_local;
+    semanage_port_create;
+    semanage_port_del_local;
+    semanage_port_exists;
+    semanage_port_exists_local;
+    semanage_port_free;
+    semanage_port_get_con;
+    semanage_port_get_high;
+    semanage_port_get_low;
+    semanage_port_get_proto;
+    semanage_port_get_proto_str;
+    semanage_port_iterate;
+    semanage_port_iterate_local;
+    semanage_port_key_create;
+    semanage_port_key_extract;
+    semanage_port_key_free;
+    semanage_port_list;
+    semanage_port_list_local;
+    semanage_port_modify_local;
+    semanage_port_query;
+    semanage_port_query_local;
+    semanage_port_set_con;
+    semanage_port_set_port;
+    semanage_port_set_proto;
+    semanage_port_set_range;
+    semanage_reload_policy;
+    semanage_root;
+    semanage_select_store;
+    semanage_set_check_contexts;
+    semanage_set_create_store;
+    semanage_set_default_priority;
+    semanage_set_disable_dontaudit;
+    semanage_set_ignore_module_cache;
+    semanage_set_preserve_tunables;
+    semanage_set_rebuild;
+    semanage_set_reload;
+    semanage_set_root;
+    semanage_set_store_root;
+    semanage_seuser_clone;
+    semanage_seuser_compare;
+    semanage_seuser_compare2;
+    semanage_seuser_count;
+    semanage_seuser_count_local;
+    semanage_seuser_create;
+    semanage_seuser_del_local;
+    semanage_seuser_exists;
+    semanage_seuser_exists_local;
+    semanage_seuser_free;
+    semanage_seuser_get_mlsrange;
+    semanage_seuser_get_name;
+    semanage_seuser_get_sename;
+    semanage_seuser_iterate;
+    semanage_seuser_iterate_local;
+    semanage_seuser_key_create;
+    semanage_seuser_key_extract;
+    semanage_seuser_key_free;
+    semanage_seuser_list;
+    semanage_seuser_list_local;
+    semanage_seuser_modify_local;
+    semanage_seuser_query;
+    semanage_seuser_query_local;
+    semanage_seuser_set_mlsrange;
+    semanage_seuser_set_name;
+    semanage_seuser_set_sename;
+    semanage_user_add_role;
+    semanage_user_clone;
+    semanage_user_compare;
+    semanage_user_compare2;
+    semanage_user_count;
+    semanage_user_count_local;
+    semanage_user_create;
+    semanage_user_del_local;
+    semanage_user_del_role;
+    semanage_user_exists;
+    semanage_user_exists_local;
+    semanage_user_free;
+    semanage_user_get_mlslevel;
+    semanage_user_get_mlsrange;
+    semanage_user_get_name;
+    semanage_user_get_num_roles;
+    semanage_user_get_prefix;
+    semanage_user_get_roles;
+    semanage_user_has_role;
+    semanage_user_iterate;
+    semanage_user_iterate_local;
+    semanage_user_key_create;
+    semanage_user_key_extract;
+    semanage_user_key_free;
+    semanage_user_list;
+    semanage_user_list_local;
+    semanage_user_modify_local;
+    semanage_user_query;
+    semanage_user_query_local;
+    semanage_user_set_mlslevel;
+    semanage_user_set_mlsrange;
+    semanage_user_set_name;
+    semanage_user_set_prefix;
+    semanage_user_set_roles;
   local: *;
 };
 
-- 
2.17.1

