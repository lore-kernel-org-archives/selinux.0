Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972CAC433F5
	for <selinux@archiver.kernel.org>; Sun, 21 Nov 2021 20:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhKUUfn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Nov 2021 15:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhKUUfn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Nov 2021 15:35:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379E0C061574
        for <selinux@vger.kernel.org>; Sun, 21 Nov 2021 12:32:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x7so12168639pjn.0
        for <selinux@vger.kernel.org>; Sun, 21 Nov 2021 12:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaqJl1RkL8lgNEY2z4Xq6gMlaPsWjviHxRSk7vUcEBU=;
        b=OXOVWx4TNbzxO8lhAJo6qeFik3RjLVuffuFMSSHTjmjlXmZnpSIDIPqyP2oB7jOiLG
         1A8G9q0nCz0b63WA+ltBZD5NOYwrfoo8xHrF4riQ2Xar2s7+0qJy9ClFaYINxD06tlmE
         Q9fPB8bRouIc5pKsSOoraJ2qqhLyQ+15lkxBiaj+DML+aUxHdpWmQ9TsnVqAA2biAjGf
         qqvNCwH3op/o/aC6FjUQ2VRvxZKGdIz7S7BT2uDgYz1KaGOnRng5paV4tpM+SmzSghww
         lpzMAwG5ZNA+XPphrp5/dBIY0gAZdwMzzoH/a6Jl4yj+f4dzqAgN4WtEws5+OhUP+oPs
         Vmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaqJl1RkL8lgNEY2z4Xq6gMlaPsWjviHxRSk7vUcEBU=;
        b=KucA1C4KCZwQoKqu1de7kHe2VmSUTsljJDofXJZDgkZifB3ZTJrH/BvIp/0snI2Z2i
         R4ykjs2SwwEFtWljLp2ud4jKIsFgyMU/0f0XiVZqiclaCH4O6V5yMbhGhVOomhL7dTgM
         orqntsc5gOeHp8XKpdDUw+lbyhuOi7d9UfkWLAPlH7GEP/UOYKLYHPWswGMc1MfS54sC
         Ow/qx+Nxl7ByWAb1sOSPIVWvFxgMPsFeCaYL46Kmvt/AA3Q/IqfQLMxr2LwJ4aTR9Pkp
         F2hXbcynHXKBrYxJ/P3vK+IaGeWwJ0y8qOkwwge8jEi0DIVspF8fGn+oc0WRKIKTdHFJ
         rLSA==
X-Gm-Message-State: AOAM531U2AXuJkURDUCZqARPrwN+9yUPvcYk4nSvFn0w2+ouX4XwpVf6
        fNz3kT32RIG76qdI6RKbSO06RNw5nXBG0pIV
X-Google-Smtp-Source: ABdhPJxbRW3AH3Fze8ORxHRVqy80uEAm4yDN1epkcYJLr/CxLGR1RR+jJgZRPfMhEITkzFILP7hFOA==
X-Received: by 2002:a17:902:d2cd:b0:141:fbe2:b658 with SMTP id n13-20020a170902d2cd00b00141fbe2b658mr100867314plc.49.1637526756369;
        Sun, 21 Nov 2021 12:32:36 -0800 (PST)
Received: from localhost (136-24-42-138.cab.webpass.net. [136.24.42.138])
        by smtp.gmail.com with ESMTPSA id g20sm6767823pfj.12.2021.11.21.12.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 12:32:35 -0800 (PST)
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Cc:     Jason Zaman <jason@perfinion.com>
Subject: [PATCH 1/2] selinux: Add map perms
Date:   Sun, 21 Nov 2021 12:32:30 -0800
Message-Id: <20211121203231.3625-1-jason@perfinion.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Lots of libselinux functions now map /sys/fs/selinux/status so add map
perms to other interfaces as well.

$ passwd user1
passwd: avc.c:73: avc_context_to_sid_raw: Assertion `avc_running'
failed.
Aborted

avc: denied { map } for pid=325 comm="passwd"
path="/sys/fs/selinux/status" dev="selinuxfs" ino=19 scontext=root:
sysadm_r:passwd_t tcontext=system_u:object_r:security_t tclass=file
permissive=1

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policy/modules/kernel/selinux.if | 18 +++++++++---------
 policy/modules/kernel/selinux.te |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/policy/modules/kernel/selinux.if b/policy/modules/kernel/selinux.if
index 13aa1e052..cb610c449 100644
--- a/policy/modules/kernel/selinux.if
+++ b/policy/modules/kernel/selinux.if
@@ -295,7 +295,7 @@ interface(`selinux_get_enforce_mode',`
 
 	dev_search_sysfs($1)
 	allow $1 security_t:dir list_dir_perms;
-	allow $1 security_t:file read_file_perms;
+	allow $1 security_t:file mmap_read_file_perms;
 ')
 
 ########################################
@@ -363,7 +363,7 @@ interface(`selinux_read_policy',`
 
 	dev_search_sysfs($1)
 	allow $1 security_t:dir list_dir_perms;
-	allow $1 security_t:file read_file_perms;
+	allow $1 security_t:file mmap_read_file_perms;
 	allow $1 security_t:security read_policy;
 ')
 
@@ -533,7 +533,7 @@ interface(`selinux_validate_context',`
 
 	dev_search_sysfs($1)
 	allow $1 security_t:dir list_dir_perms;
-	allow $1 security_t:file rw_file_perms;
+	allow $1 security_t:file mmap_rw_file_perms;
 	allow $1 security_t:security check_context;
 ')
 
@@ -554,7 +554,7 @@ interface(`selinux_dontaudit_validate_context',`
 	')
 
 	dontaudit $1 security_t:dir list_dir_perms;
-	dontaudit $1 security_t:file rw_file_perms;
+	dontaudit $1 security_t:file mmap_rw_file_perms;
 	dontaudit $1 security_t:security check_context;
 ')
 
@@ -577,7 +577,7 @@ interface(`selinux_compute_access_vector',`
 	dev_search_sysfs($1)
 	allow $1 self:netlink_selinux_socket create_socket_perms;
 	allow $1 security_t:dir list_dir_perms;
-	allow $1 security_t:file rw_file_perms;
+	allow $1 security_t:file mmap_rw_file_perms;
 	allow $1 security_t:security compute_av;
 ')
 
@@ -599,7 +599,7 @@ interface(`selinux_compute_create_context',`
 
 	dev_search_sysfs($1)
 	allow $1 security_t:dir list_dir_perms;
-	allow $1 security_t:file rw_file_perms;
+	allow $1 security_t:file mmap_rw_file_perms;
 	allow $1 security_t:security compute_create;
 ')
 
@@ -621,7 +621,7 @@ interface(`selinux_compute_member',`
 
 	dev_search_sysfs($1)
 	allow $1 security_t:dir list_dir_perms;
-	allow $1 security_t:file rw_file_perms;
+	allow $1 security_t:file mmap_rw_file_perms;
 	allow $1 security_t:security compute_member;
 ')
 
@@ -651,7 +651,7 @@ interface(`selinux_compute_relabel_context',`
 
 	dev_search_sysfs($1)
 	allow $1 security_t:dir list_dir_perms;
-	allow $1 security_t:file rw_file_perms;
+	allow $1 security_t:file mmap_rw_file_perms;
 	allow $1 security_t:security compute_relabel;
 ')
 
@@ -672,7 +672,7 @@ interface(`selinux_compute_user_contexts',`
 
 	dev_search_sysfs($1)
 	allow $1 security_t:dir list_dir_perms;
-	allow $1 security_t:file rw_file_perms;
+	allow $1 security_t:file mmap_rw_file_perms;
 	allow $1 security_t:security compute_user;
 ')
 
diff --git a/policy/modules/kernel/selinux.te b/policy/modules/kernel/selinux.te
index 0726fc448..707517e52 100644
--- a/policy/modules/kernel/selinux.te
+++ b/policy/modules/kernel/selinux.te
@@ -53,7 +53,7 @@ genfscon securityfs / gen_context(system_u:object_r:security_t,s0)
 neverallow ~{ selinux_unconfined_type can_setenforce } security_t:security setenforce;
 
 allow can_setenforce security_t:dir list_dir_perms;
-allow can_setenforce security_t:file rw_file_perms;
+allow can_setenforce security_t:file mmap_rw_file_perms;
 
 dev_search_sysfs(can_setenforce)
 
@@ -71,7 +71,7 @@ if(secure_mode_policyload) {
 neverallow ~{ selinux_unconfined_type can_load_policy } security_t:security load_policy;
 
 allow can_load_policy security_t:dir list_dir_perms;
-allow can_load_policy security_t:file rw_file_perms;
+allow can_load_policy security_t:file mmap_rw_file_perms;
 
 dev_search_sysfs(can_load_policy)
 
@@ -89,7 +89,7 @@ if(secure_mode_policyload) {
 neverallow ~{ selinux_unconfined_type can_setsecparam } security_t:security setsecparam;
 
 allow can_setsecparam security_t:dir list_dir_perms;
-allow can_setsecparam security_t:file rw_file_perms;
+allow can_setsecparam security_t:file mmap_rw_file_perms;
 allow can_setsecparam security_t:security setsecparam;
 auditallow can_setsecparam security_t:security setsecparam;
 
@@ -102,7 +102,7 @@ dev_search_sysfs(can_setsecparam)
 
 # use SELinuxfs
 allow selinux_unconfined_type security_t:dir list_dir_perms;
-allow selinux_unconfined_type security_t:file rw_file_perms;
+allow selinux_unconfined_type security_t:file mmap_rw_file_perms;
 allow selinux_unconfined_type boolean_type:file read_file_perms;
 
 # Access the security API.
-- 
2.32.0

