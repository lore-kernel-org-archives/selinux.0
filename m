Return-Path: <SRS0=FN9z=54=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDEBC2BA2B
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 17:07:44 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBA620673
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 17:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5yBFWwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBA620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgDLRHn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgDLRHn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Apr 2020 13:07:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBFEC0A3BF1
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 10:07:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so2596687plk.7
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dD7NJ5ZcktGbWOvbY046+tCJu1WMnCT7gN6O8KS45rw=;
        b=X5yBFWwJ4R4a3OYKols+aknOUXvKKRGmHPJGgH+m2YK1eE5tBGDcEGwXRyCoukLr1K
         OKoe0S8/gDWc6ymML6gOP+4xMyu6BP1ukeGbWlPpIFrfI7UXv0ik9WeNZKvy/2690eH8
         Lg1DJFWS875FSxgizhF/lV/Sv81DkCRYSRHBwVKQjyziUMIoD0zse6r+wObmGQw6WCR4
         Xue8htJa2taoD7fZ2OBlqqhsvATqNcgy7qJxFmHz6uxdHNFkUJ/1O5liyYhgvuWUoNZo
         Hq4XZ3zRAA6ovwtfzDt6JhsYtmOo/f6GY9xa7CFJW6EAG5Mjb977szUHl1bp6Vqqor/u
         Fnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dD7NJ5ZcktGbWOvbY046+tCJu1WMnCT7gN6O8KS45rw=;
        b=nJI1nuCyveVkGzbIBz7jqGPW7kwJ8pr9kFYR3U6LMA7GlIViKHhsrlu76jldIhvCJc
         yu/yY/qnedOisp2EVJ5xuw4QQTLekwx5auERu2xcCbsotKeaDh6fISW7max6DFy+3c1S
         jZXgmt8Es3Ra/frF6Z6EHBQIpxXbj6dB70oKGE7pIeXd95V0mFPf8fWk/cmJH5OYRYvO
         XWLVLkvoDBnZrBENs8atErc8Ur/Fgjd9zlO+mND5MObqGBd7FEhfa5j/IRZOhCfXHRKu
         6YqfsOMpiW6cybCe3LANk95z93PFPN0p7Tzo8QmssfYopbAWFXXoHD76GwYV9DKkL3m8
         QgsA==
X-Gm-Message-State: AGi0PuaeubNxKFoyFSDRYTbJU2/U9Pn2U5IK7GjzwJjLJibjSzWIQX2k
        tRaVsMISjyTRrSg0EeTn5PM=
X-Google-Smtp-Source: APiQypIPro0JpMKV6H6RExjCOehLGO+L6RduFV1ai1ELCPnOfV4it68/BMxip2JkwrgsQNh6wlvNSQ==
X-Received: by 2002:a17:902:d70f:: with SMTP id w15mr13919253ply.138.1586711261269;
        Sun, 12 Apr 2020 10:07:41 -0700 (PDT)
Received: from localhost.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.55.39])
        by smtp.gmail.com with ESMTPSA id w90sm7020453pjj.2.2020.04.12.10.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 10:07:40 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     nicolas.iooss@m4x.org, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] libsemanage: fix linker script symbol versions
Date:   Sun, 12 Apr 2020 12:07:31 -0500
Message-Id: <20200412170731.5432-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFftDdohqX3vdg=VCSEu_1BQhOUv0ry0vRYtchAFecYZOPK-qQ@mail.gmail.com>
References: <CAFftDdohqX3vdg=VCSEu_1BQhOUv0ry0vRYtchAFecYZOPK-qQ@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

In previous work to cleanup the exports and linker scripts, I introduced
a regression causing symbols to be named in both the 1.0 and 1.1
sections. This went un-noticed and was reported by
nicolas.iooss@m4x.org.

In previous patched checked for correctness by:
This was checked by generating an old export map (from master):
nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map

Then creating a new one for this library after this patch is applied:
nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map

And diffing them:
diff old.map new.map

However, this discards the version information. Nicolas points out a
better way, by using objdump so we can see the version information. A
better sequence of commands for checking is as follows:

git checkout 1967477913f6e
objdump -T ./src/libsemanage.so | grep LIBSEMANAGE | cut -d' ' -f 8- | sed 's/^ //' > map.old

git checkout origin/master
objdump -T ./src/libsemanage.so | grep LIBSEMANAGE | cut -d' ' -f 8- | sed 's/^ //' > map.new

diff map.old map.new

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsemanage/src/libsemanage.map | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index ff5977b9f483..79aa8e693389 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -76,10 +76,7 @@ LIBSEMANAGE_1.0 {
     semanage_fcontext_set_con;
     semanage_fcontext_set_expr;
     semanage_fcontext_set_type;
-    semanage_get_default_priority;
     semanage_get_disable_dontaudit;
-    semanage_get_hll_compiler_path;
-    semanage_get_ignore_module_cache;
     semanage_get_preserve_tunables;
     semanage_handle_create;
     semanage_handle_destroy;
@@ -170,39 +167,17 @@ LIBSEMANAGE_1.0 {
     semanage_mls_enabled;
     semanage_module_disable;
     semanage_module_enable;
-    semanage_module_extract;
     semanage_module_get_enabled;
-    semanage_module_get_module_info;
     semanage_module_get_name;
     semanage_module_get_version;
-    semanage_module_info_create;
     semanage_module_info_datum_destroy;
-    semanage_module_info_destroy;
-    semanage_module_info_get_enabled;
-    semanage_module_info_get_lang_ext;
-    semanage_module_info_get_name;
-    semanage_module_info_get_priority;
-    semanage_module_info_set_enabled;
-    semanage_module_info_set_lang_ext;
-    semanage_module_info_set_name;
-    semanage_module_info_set_priority;
     semanage_module_install;
     semanage_module_install_base;
     semanage_module_install_base_file;
     semanage_module_install_file;
-    semanage_module_install_info;
-    semanage_module_key_create;
-    semanage_module_key_destroy;
-    semanage_module_key_get_name;
-    semanage_module_key_get_priority;
-    semanage_module_key_set_name;
-    semanage_module_key_set_priority;
     semanage_module_list;
-    semanage_module_list_all;
     semanage_module_list_nth;
     semanage_module_remove;
-    semanage_module_remove_key;
-    semanage_module_set_enabled;
     semanage_module_upgrade;
     semanage_module_upgrade_file;
     semanage_msg_get_channel;
@@ -276,14 +251,11 @@ LIBSEMANAGE_1.0 {
     semanage_select_store;
     semanage_set_check_contexts;
     semanage_set_create_store;
-    semanage_set_default_priority;
     semanage_set_disable_dontaudit;
-    semanage_set_ignore_module_cache;
     semanage_set_preserve_tunables;
     semanage_set_rebuild;
     semanage_set_reload;
     semanage_set_root;
-    semanage_set_store_root;
     semanage_seuser_clone;
     semanage_seuser_compare;
     semanage_seuser_compare2;
@@ -366,6 +338,7 @@ LIBSEMANAGE_1.1 {
     semanage_module_info_set_name;
     semanage_module_info_set_lang_ext;
     semanage_module_info_set_enabled;
+    semanage_module_install_info;
     semanage_module_key_create;
     semanage_module_key_destroy;
     semanage_module_key_get_priority;
@@ -376,7 +349,6 @@ LIBSEMANAGE_1.1 {
     semanage_module_list_all;
     semanage_module_get_enabled;
     semanage_module_set_enabled;
-    semanage_module_install_info;
     semanage_module_upgrade_info;
     semanage_module_remove_key;
     semanage_set_store_root;
-- 
2.17.1

