Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DE6C35E04
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536A520658
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzGtUFJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgBYUDD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:03:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33853 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBYUDC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:03:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so256397plt.1
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X6mxsecS5OmCBlwdVuO1Wh9Zjl8/zVi/pAYNTBsF9Pc=;
        b=YzGtUFJ+NlJPCzmb2gs2FsYnOCl5Y1JpjHoENIx6SNIv4bZwcdOYrlV66Vy3kQO38J
         5npgbuDwRauRHGOpeARbQVDhHRMQMQtLpcvM5b6ORz18KuiB51fN8BvrPMXEOCm2tem6
         PkB6326takoFzQ99AehLeA1J8aBWrsI6rPn8sVidrYOR9e6C6+o3fxTTboGKce6VDSkw
         QB0ZrIo5/L1n9OUo50pEbmow8O1fGFmw4zvjFMuM9Ec5kuBal+i2qbMqxe7Gt6Pzhvg9
         wnunA3TVi9KMAThrobIDXWVPcQibzNOEV+SC+b5XMgP7f7Y6OYi9dQql8fu5DXhG3dnj
         SkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X6mxsecS5OmCBlwdVuO1Wh9Zjl8/zVi/pAYNTBsF9Pc=;
        b=ugD71LlrQ/qCiRllqwbT4Z/Ea7FXjog6RkDBbD0tNmQPb6j4S9bUvdHiO6Iyv3aeUF
         eWabyIb06ZEccoorVDfQQu72SPobwH+ZwmYfUHo4v1OmN4gCmIferXUGPHvWg3JSVcgr
         CQJlZKjHhubjv411sXC9vUkpPOQ+EPk2lb8tpWi1MSOqcXTsnaVHBchyVRgChrLOaxK4
         6ZqIoSFP1SKfDoJq4U2rc7UMunHyR28uWVGIKKGRYQHsbPTm4WaMvXe/eiRhzWGP55Go
         MvbsmOepjdKT4s4zs3uRA+/9zcfxdeuOOcxVzJ/GFWkTF75M1/Txon0ruiJWDUtLR6Ez
         rlcA==
X-Gm-Message-State: APjAAAVc7uPz9RGNY0QcUJf/uCcYdaV/CB8Q4PKdKCO1o1va+Yxol/UF
        wuewRGs95k9krDXmDqSkw5Q=
X-Google-Smtp-Source: APXvYqzfp9q3GsThLfi/3TMa2nk6GH3TPzcwhacLfKIdk1KqwyIz9yiO74RNU4YmrB1HtQi7/SLTjw==
X-Received: by 2002:a17:90a:26e1:: with SMTP id m88mr739405pje.101.1582660981308;
        Tue, 25 Feb 2020 12:03:01 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:03:00 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 13/17] src/selinux_internal.h: fix hidden_proto indents
Date:   Tue, 25 Feb 2020 14:02:15 -0600
Message-Id: <20200225200219.6163-14-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/selinux_internal.h | 190 +++++++++++++++---------------
 1 file changed, 95 insertions(+), 95 deletions(-)

diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 61b78aaa7c10..f6a50cd36f63 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -3,107 +3,107 @@
 #include "dso.h"
 
 hidden_proto(selinux_mkload_policy)
-    hidden_proto(fini_selinuxmnt)
-    hidden_proto(set_selinuxmnt)
-    hidden_proto(selinuxfs_exists)
-    hidden_proto(security_disable)
-    hidden_proto(security_policyvers)
-    hidden_proto(security_load_policy)
-    hidden_proto(security_get_boolean_active)
-    hidden_proto(security_get_boolean_names)
-    hidden_proto(security_set_boolean)
-    hidden_proto(security_commit_booleans)
-    hidden_proto(security_check_context)
-    hidden_proto(security_check_context_raw)
-    hidden_proto(security_canonicalize_context)
-    hidden_proto(security_canonicalize_context_raw)
-    hidden_proto(security_compute_av)
-    hidden_proto(security_compute_av_raw)
-    hidden_proto(security_compute_av_flags)
-    hidden_proto(security_compute_av_flags_raw)
-    hidden_proto(security_compute_user)
-    hidden_proto(security_compute_user_raw)
-    hidden_proto(security_compute_create)
-    hidden_proto(security_compute_create_raw)
-    hidden_proto(security_compute_create_name)
-    hidden_proto(security_compute_create_name_raw)
-    hidden_proto(security_compute_member_raw)
-    hidden_proto(security_compute_relabel_raw)
-    hidden_proto(security_validatetrans)
-    hidden_proto(security_validatetrans_raw)
-    hidden_proto(is_selinux_enabled)
-    hidden_proto(is_selinux_mls_enabled)
-    hidden_proto(freecon)
-    hidden_proto(freeconary)
-    hidden_proto(getprevcon)
-    hidden_proto(getprevcon_raw)
-    hidden_proto(getcon)
-    hidden_proto(getcon_raw)
-    hidden_proto(setcon_raw)
-    hidden_proto(getpeercon_raw)
-    hidden_proto(getpidcon_raw)
-    hidden_proto(getexeccon_raw)
-    hidden_proto(getfilecon)
-    hidden_proto(getfilecon_raw)
-    hidden_proto(lgetfilecon_raw)
-    hidden_proto(fgetfilecon_raw)
-    hidden_proto(setfilecon_raw)
-    hidden_proto(lsetfilecon_raw)
-    hidden_proto(fsetfilecon_raw)
-    hidden_proto(setexeccon)
-    hidden_proto(setexeccon_raw)
-    hidden_proto(getfscreatecon_raw)
-    hidden_proto(getkeycreatecon_raw)
-    hidden_proto(getsockcreatecon_raw)
-    hidden_proto(setfscreatecon_raw)
-    hidden_proto(setkeycreatecon_raw)
-    hidden_proto(setsockcreatecon_raw)
-    hidden_proto(security_getenforce)
-    hidden_proto(security_setenforce)
-    hidden_proto(security_deny_unknown)
-    hidden_proto(security_reject_unknown)
-    hidden_proto(security_get_checkreqprot)
-    hidden_proto(selinux_boolean_sub)
-    hidden_proto(selinux_current_policy_path)
-    hidden_proto(selinux_binary_policy_path)
-    hidden_proto(selinux_booleans_subs_path)
-    hidden_proto(selinux_default_context_path)
-    hidden_proto(selinux_securetty_types_path)
-    hidden_proto(selinux_failsafe_context_path)
-    hidden_proto(selinux_removable_context_path)
-    hidden_proto(selinux_virtual_domain_context_path)
-    hidden_proto(selinux_virtual_image_context_path)
-    hidden_proto(selinux_lxc_contexts_path)
-    hidden_proto(selinux_file_context_path)
-    hidden_proto(selinux_file_context_homedir_path)
-    hidden_proto(selinux_file_context_local_path)
-    hidden_proto(selinux_file_context_subs_dist_path)
-    hidden_proto(selinux_file_context_subs_path)
-    hidden_proto(selinux_netfilter_context_path)
-    hidden_proto(selinux_homedir_context_path)
-    hidden_proto(selinux_user_contexts_path)
-    hidden_proto(selinux_booleans_path)
-    hidden_proto(selinux_customizable_types_path)
-    hidden_proto(selinux_media_context_path)
-    hidden_proto(selinux_x_context_path)
-    hidden_proto(selinux_sepgsql_context_path)
-    hidden_proto(selinux_openrc_contexts_path)
-    hidden_proto(selinux_openssh_contexts_path)
-    hidden_proto(selinux_snapperd_contexts_path)
-    hidden_proto(selinux_systemd_contexts_path)
-    hidden_proto(selinux_path)
-    hidden_proto(selinux_check_passwd_access)
-    hidden_proto(selinux_check_securetty_context)
-    hidden_proto(matchpathcon_init_prefix)
-    hidden_proto(selinux_users_path)
-    hidden_proto(selinux_usersconf_path);
+hidden_proto(fini_selinuxmnt)
+hidden_proto(set_selinuxmnt)
+hidden_proto(selinuxfs_exists)
+hidden_proto(security_disable)
+hidden_proto(security_policyvers)
+hidden_proto(security_load_policy)
+hidden_proto(security_get_boolean_active)
+hidden_proto(security_get_boolean_names)
+hidden_proto(security_set_boolean)
+hidden_proto(security_commit_booleans)
+hidden_proto(security_check_context)
+hidden_proto(security_check_context_raw)
+hidden_proto(security_canonicalize_context)
+hidden_proto(security_canonicalize_context_raw)
+hidden_proto(security_compute_av)
+hidden_proto(security_compute_av_raw)
+hidden_proto(security_compute_av_flags)
+hidden_proto(security_compute_av_flags_raw)
+hidden_proto(security_compute_user)
+hidden_proto(security_compute_user_raw)
+hidden_proto(security_compute_create)
+hidden_proto(security_compute_create_raw)
+hidden_proto(security_compute_create_name)
+hidden_proto(security_compute_create_name_raw)
+hidden_proto(security_compute_member_raw)
+hidden_proto(security_compute_relabel_raw)
+hidden_proto(security_validatetrans)
+hidden_proto(security_validatetrans_raw)
+hidden_proto(is_selinux_enabled)
+hidden_proto(is_selinux_mls_enabled)
+hidden_proto(freecon)
+hidden_proto(freeconary)
+hidden_proto(getprevcon)
+hidden_proto(getprevcon_raw)
+hidden_proto(getcon)
+hidden_proto(getcon_raw)
+hidden_proto(setcon_raw)
+hidden_proto(getpeercon_raw)
+hidden_proto(getpidcon_raw)
+hidden_proto(getexeccon_raw)
+hidden_proto(getfilecon)
+hidden_proto(getfilecon_raw)
+hidden_proto(lgetfilecon_raw)
+hidden_proto(fgetfilecon_raw)
+hidden_proto(setfilecon_raw)
+hidden_proto(lsetfilecon_raw)
+hidden_proto(fsetfilecon_raw)
+hidden_proto(setexeccon)
+hidden_proto(setexeccon_raw)
+hidden_proto(getfscreatecon_raw)
+hidden_proto(getkeycreatecon_raw)
+hidden_proto(getsockcreatecon_raw)
+hidden_proto(setfscreatecon_raw)
+hidden_proto(setkeycreatecon_raw)
+hidden_proto(setsockcreatecon_raw)
+hidden_proto(security_getenforce)
+hidden_proto(security_setenforce)
+hidden_proto(security_deny_unknown)
+hidden_proto(security_reject_unknown)
+hidden_proto(security_get_checkreqprot)
+hidden_proto(selinux_boolean_sub)
+hidden_proto(selinux_current_policy_path)
+hidden_proto(selinux_binary_policy_path)
+hidden_proto(selinux_booleans_subs_path)
+hidden_proto(selinux_default_context_path)
+hidden_proto(selinux_securetty_types_path)
+hidden_proto(selinux_failsafe_context_path)
+hidden_proto(selinux_removable_context_path)
+hidden_proto(selinux_virtual_domain_context_path)
+hidden_proto(selinux_virtual_image_context_path)
+hidden_proto(selinux_lxc_contexts_path)
+hidden_proto(selinux_file_context_path)
+hidden_proto(selinux_file_context_homedir_path)
+hidden_proto(selinux_file_context_local_path)
+hidden_proto(selinux_file_context_subs_dist_path)
+hidden_proto(selinux_file_context_subs_path)
+hidden_proto(selinux_netfilter_context_path)
+hidden_proto(selinux_homedir_context_path)
+hidden_proto(selinux_user_contexts_path)
+hidden_proto(selinux_booleans_path)
+hidden_proto(selinux_customizable_types_path)
+hidden_proto(selinux_media_context_path)
+hidden_proto(selinux_x_context_path)
+hidden_proto(selinux_sepgsql_context_path)
+hidden_proto(selinux_openrc_contexts_path)
+hidden_proto(selinux_openssh_contexts_path)
+hidden_proto(selinux_snapperd_contexts_path)
+hidden_proto(selinux_systemd_contexts_path)
+hidden_proto(selinux_path)
+hidden_proto(selinux_check_passwd_access)
+hidden_proto(selinux_check_securetty_context)
+hidden_proto(matchpathcon_init_prefix)
+hidden_proto(selinux_users_path)
+hidden_proto(selinux_usersconf_path);
 hidden_proto(selinux_translations_path);
 hidden_proto(selinux_colors_path);
 hidden_proto(selinux_getenforcemode);
 hidden_proto(selinux_getpolicytype);
 hidden_proto(selinux_raw_to_trans_context);
 hidden_proto(selinux_trans_to_raw_context);
-    hidden_proto(selinux_raw_context_to_color);
+hidden_proto(selinux_raw_context_to_color);
 hidden_proto(security_get_initial_context);
 hidden_proto(security_get_initial_context_raw);
 hidden_proto(selinux_reset_config);
-- 
2.17.1

