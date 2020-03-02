Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A18C3F2CD
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC4121D56
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG7SYflS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCBQlb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:41:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40796 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBQla (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 11:41:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so4410857plp.7
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wB+20VaQ2sP4h9Xw+dqFKTiJM22nVqs+rJhlE7M4M0k=;
        b=XG7SYflSNeUj6Ys3FPFbp/33slAkeXeKctv48GZX1PhEmwh/+HyZCDy3CDPmCk+uPi
         SvzoCBEotBL7suJga4WXp5ExA1j/rY3wO5On4YBhXwZpkvqdLZ946Z+OmdQuzYbPvQsd
         qJf/4DRWBBlHbCERIbF9CqySdLm86wwvfhueIBxcwFQ0pFuyzg3KGeHoCOHPm8Yj9r/F
         UlTjwjuBydk7xDs5vi7ir5fLCt6O1RO/W8OQrIeLSrU92CFcyTmEQ3EqXvvaqn/84pyh
         JeD9bIm3gGgDy5J0KXYqBUMYFmLdD8yeYqp8TVrxuSPevuaJGf2a9mHa7Xz4Q0j9ggKE
         Ilbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wB+20VaQ2sP4h9Xw+dqFKTiJM22nVqs+rJhlE7M4M0k=;
        b=QK0fZIN/uRG95r7OgtUt+Pmx4+G9nq9sD8c+GtyM3hqQPockYWAurqKIznZpVacdma
         ckYbuGNJi53hbFqDu905FdDr/TTltHWhBcXxIO9X/XVpKcHSti6CK2xgcKQO5iZcI+/0
         ibfC78OTliU1qdal6pgLhJonb+m7rHp9ATeoHNs+++SbpG/mF37qPta3MsPrUX4fgOuc
         erjYQoUwYcSV7UH8H7JgkfJ01IOPSedQyRcEEYa1/BumubBX3DCjZm6dXYmmTWuesucn
         CZXez0n+p9ez5gIyHnLcSNnW+sxYm6/SlP8rRaP8PWty6MJVE2cpWeBHGYHahaxk0h4k
         h9XQ==
X-Gm-Message-State: ANhLgQ2Vtuso4tfUPQzo98XRB3SqdAEM+gX+J3uIIGhCWxDxA3nN26TI
        sl2OR5PTrC1XL0O319yozK4=
X-Google-Smtp-Source: ADFU+vtn5tK57afhRKG8iiUPcIUPZ3Sp53f4Ix7IyIljLWKeaYFj0sme7UNg1UP2LBWUNN4sPDI4Tg==
X-Received: by 2002:a17:90a:21ca:: with SMTP id q68mr451959pjc.41.1583167287918;
        Mon, 02 Mar 2020 08:41:27 -0800 (PST)
Received: from localhost.localdomain ([192.55.55.41])
        by smtp.gmail.com with ESMTPSA id o6sm23331087pfg.180.2020.03.02.08.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 08:41:27 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, drepper@redhat.com, omosnace@redhat.com,
        plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: [PATCH v4 3/4] Makefile: add linker script to minimize exports
Date:   Mon,  2 Mar 2020 10:41:11 -0600
Message-Id: <20200302164112.10669-4-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302164112.10669-1-william.c.roberts@intel.com>
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Add a linker script that exports only what was previosly exported by
libselinux.

This was checked by generating an old export map (from master):
nm --defined-only -g ./src/libselinux.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map

Then creating a new one for this library after this patch is applied:
nm --defined-only -g ./src/libselinux.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map

And diffing them:
diff old.map new.map

Fixes: #179

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/Makefile       |   2 +-
 libselinux/src/libselinux.map | 249 ++++++++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/src/libselinux.map

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index c76110fbc650..2d1c654ee24d 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -90,7 +90,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Werror -Wno-aggregate-return -Wno-redundant-decls \
           $(EXTRA_CFLAGS)
 
-LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
+LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro
 
 ifeq ($(OS), Darwin)
 override CFLAGS += -I/opt/local/include
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
new file mode 100644
index 000000000000..73f4c072af02
--- /dev/null
+++ b/libselinux/src/libselinux.map
@@ -0,0 +1,249 @@
+LIBSELINUX_1.0 {
+  global:
+    avc_add_callback;
+    avc_audit;
+    avc_av_stats;
+    avc_cache_stats;
+    avc_cleanup;
+    avc_compute_create;
+    avc_compute_member;
+    avc_context_to_sid;
+    avc_context_to_sid_raw;
+    avc_destroy;
+    avc_get_initial_sid;
+    avc_has_perm;
+    avc_has_perm_noaudit;
+    avc_init;
+    avc_netlink_acquire_fd;
+    avc_netlink_check_nb;
+    avc_netlink_close;
+    avc_netlink_loop;
+    avc_netlink_open;
+    avc_netlink_release_fd;
+    avc_open;
+    avc_reset;
+    avc_sid_stats;
+    avc_sid_to_context;
+    avc_sid_to_context_raw;
+    checkPasswdAccess;
+    context_free;
+    context_new;
+    context_range_get;
+    context_range_set;
+    context_role_get;
+    context_role_set;
+    context_str;
+    context_type_get;
+    context_type_set;
+    context_user_get;
+    context_user_set;
+    dir_xattr_list;
+    fgetfilecon;
+    fgetfilecon_raw;
+    fini_selinuxmnt;
+    freecon;
+    freeconary;
+    fsetfilecon;
+    fsetfilecon_raw;
+    getcon;
+    getcon_raw;
+    get_default_context;
+    get_default_context_with_level;
+    get_default_context_with_role;
+    get_default_context_with_rolelevel;
+    get_default_type;
+    getexeccon;
+    getexeccon_raw;
+    getfilecon;
+    getfilecon_raw;
+    getfscreatecon;
+    getfscreatecon_raw;
+    getkeycreatecon;
+    getkeycreatecon_raw;
+    get_ordered_context_list;
+    get_ordered_context_list_with_level;
+    getpeercon;
+    getpeercon_raw;
+    getpidcon;
+    getpidcon_raw;
+    getprevcon;
+    getprevcon_raw;
+    getseuser;
+    getseuserbyname;
+    getsockcreatecon;
+    getsockcreatecon_raw;
+    is_context_customizable;
+    is_selinux_enabled;
+    is_selinux_mls_enabled;
+    lgetfilecon;
+    lgetfilecon_raw;
+    lsetfilecon;
+    lsetfilecon_raw;
+    manual_user_enter_context;
+    map_class;
+    map_decision;
+    map_perm;
+    matchmediacon;
+    matchpathcon;
+    matchpathcon_checkmatches;
+    matchpathcon_filespec_add;
+    matchpathcon_filespec_destroy;
+    matchpathcon_filespec_eval;
+    matchpathcon_fini;
+    matchpathcon_index;
+    matchpathcon_init;
+    matchpathcon_init_prefix;
+    mode_to_security_class;
+    myprintf_compat;
+    print_access_vector;
+    query_user_context;
+    realpath_not_final;
+    rpm_execcon;
+    security_av_perm_to_string;
+    security_av_string;
+    security_canonicalize_context;
+    security_canonicalize_context_raw;
+    security_check_context;
+    security_check_context_raw;
+    security_class_to_string;
+    security_commit_booleans;
+    security_compute_av;
+    security_compute_av_flags;
+    security_compute_av_flags_raw;
+    security_compute_av_raw;
+    security_compute_create;
+    security_compute_create_name;
+    security_compute_create_name_raw;
+    security_compute_create_raw;
+    security_compute_member;
+    security_compute_member_raw;
+    security_compute_relabel;
+    security_compute_relabel_raw;
+    security_compute_user;
+    security_compute_user_raw;
+    security_deny_unknown;
+    security_disable;
+    security_get_boolean_active;
+    security_get_boolean_names;
+    security_get_boolean_pending;
+    security_get_checkreqprot;
+    security_getenforce;
+    security_get_initial_context;
+    security_get_initial_context_raw;
+    security_load_booleans;
+    security_load_policy;
+    security_policyvers;
+    security_reject_unknown;
+    security_set_boolean;
+    security_set_boolean_list;
+    security_setenforce;
+    security_validatetrans;
+    security_validatetrans_raw;
+    selabel_close;
+    selabel_cmp;
+    selabel_digest;
+    selabel_get_digests_all_partial_matches;
+    selabel_hash_all_partial_matches;
+    selabel_lookup;
+    selabel_lookup_best_match;
+    selabel_lookup_best_match_raw;
+    selabel_lookup_raw;
+    selabel_open;
+    selabel_partial_match;
+    selabel_stats;
+    selinux_binary_policy_path;
+    selinux_booleans_path;
+    selinux_booleans_subs_path;
+    selinux_boolean_sub;
+    selinux_check_access;
+    selinux_check_passwd_access;
+    selinux_check_securetty_context;
+    selinux_colors_path;
+    selinux_contexts_path;
+    selinux_current_policy_path;
+    selinux_customizable_types_path;
+    selinux_default_context_path;
+    selinux_default_type_path;
+    selinux_failsafe_context_path;
+    selinux_file_context_cmp;
+    selinux_file_context_homedir_path;
+    selinux_file_context_local_path;
+    selinux_file_context_path;
+    selinux_file_context_subs_dist_path;
+    selinux_file_context_subs_path;
+    selinux_file_context_verify;
+    selinux_flush_class_cache;
+    selinuxfs_exists;
+    selinux_get_callback;
+    selinux_getenforcemode;
+    selinux_getpolicytype;
+    selinux_homedir_context_path;
+    selinux_init_load_policy;
+    selinux_lsetfilecon_default;
+    selinux_lxc_contexts_path;
+    selinux_media_context_path;
+    selinux_mkload_policy;
+    selinux_mnt;
+    selinux_netfilter_context_path;
+    selinux_openrc_contexts_path;
+    selinux_openssh_contexts_path;
+    selinux_path;
+    selinux_policy_root;
+    selinux_raw_context_to_color;
+    selinux_raw_to_trans_context;
+    selinux_removable_context_path;
+    selinux_reset_config;
+    selinux_restorecon;
+    selinux_restorecon_default_handle;
+    selinux_restorecon_set_alt_rootpath;
+    selinux_restorecon_set_exclude_list;
+    selinux_restorecon_set_sehandle;
+    selinux_restorecon_xattr;
+    selinux_securetty_types_path;
+    selinux_sepgsql_context_path;
+    selinux_set_callback;
+    selinux_set_mapping;
+    selinux_set_policy_root;
+    selinux_snapperd_contexts_path;
+    selinux_status_close;
+    selinux_status_deny_unknown;
+    selinux_status_getenforce;
+    selinux_status_open;
+    selinux_status_policyload;
+    selinux_status_updated;
+    selinux_systemd_contexts_path;
+    selinux_translations_path;
+    selinux_trans_to_raw_context;
+    selinux_user_contexts_path;
+    selinux_usersconf_path;
+    selinux_users_path;
+    selinux_virtual_domain_context_path;
+    selinux_virtual_image_context_path;
+    selinux_x_context_path;
+    setcon;
+    setcon_raw;
+    setexeccon;
+    setexeccon_raw;
+    setexecfilecon;
+    setfilecon;
+    setfilecon_raw;
+    setfscreatecon;
+    setfscreatecon_raw;
+    setkeycreatecon;
+    setkeycreatecon_raw;
+    set_matchpathcon_canoncon;
+    set_matchpathcon_flags;
+    set_matchpathcon_invalidcon;
+    set_matchpathcon_printf;
+    set_selinuxmnt;
+    setsockcreatecon;
+    setsockcreatecon_raw;
+    sidget;
+    sidput;
+    string_to_av_perm;
+    string_to_security_class;
+    unmap_class;
+    unmap_perm;
+  local:
+    *;
+};
-- 
2.17.1

