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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BA5C54FD0
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4077B20714
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxzMJAf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgCWRu6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:50:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41173 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgCWRu5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Mar 2020 13:50:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so6216550plr.8
        for <selinux@vger.kernel.org>; Mon, 23 Mar 2020 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YLZOqM9ng4NNDqfTkJr2kNSz3HYuUJym2C41/J8u3pg=;
        b=rxzMJAf/3N1DcgStQLY23MKT6kLyqaE06gqnM8DZLr/FQyJQbUpN+zYtlZk52vGgMk
         +qY5o6PSprYLNw+oEyU42CVusXO5nQxGRmXFWP9k97iTftqDKpd6X0lB8S7JSH9cD5uK
         MEdlAJahv5siedALtBJMKeAVKyVkH7VwjmLWdt2/FPqrHBk+fcnA9cW1pAS4Uj4T58uP
         rn9U6rxHWBtfmFGMn+GUGMLeP5DlPoM9qKZPfAHoEpQyDVyoM2KYaglX5/a6GcrD5OSk
         OfSwmThvSTY8+ohD++TnmFON3vxQEKe4FJASyNl4xfI38rK9aIG+dbD7dU7mvUQijsTk
         EMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YLZOqM9ng4NNDqfTkJr2kNSz3HYuUJym2C41/J8u3pg=;
        b=M0hlkVJe1BhUoIpWhk8fYn3EBLAKUR7yneOiGHSl/XQal4sluY0pPr5INPnb/K6zmM
         1pjlRZTAbE5JNI63ZId1UomMqpfmdqSWcwLC/Hqkd9GejYR0W2M7F+pDUFJEgl4pQuBR
         IQfITS7oSortQ6X6TmzNXd6fUgewGaUyAkAKcr4URucfkPI54kDnpgLiAIIKrvyBUlrf
         Tskskx/lDTnrlZvVXYp3ZePqSHHXzFb9sZDz3/CoEpDiXsKm2I3WkC5N0igoU7YoD5WZ
         riCG0fwQC8ZGsLZlQR8OxcyVIpOgPCIksdkNjRvkzjrXs9TsyeLGIKFxFE3AYqsJsU2m
         faAQ==
X-Gm-Message-State: ANhLgQ0Dfrm+2P9KPmgckW3YN/dXeSIF/xStlIm3RRjObdfVInkNmrnk
        MqvQTIcjc7sxRRIVc6NYBONeks1Uv7w=
X-Google-Smtp-Source: ADFU+vu2f97D7ZFTuBJq2UsA/EKSl+qpJ7IVPaFdWUVIrxihiD4GWxFBKT3VO4EnVOUP97rBLNqMEw==
X-Received: by 2002:a17:90a:d585:: with SMTP id v5mr552385pju.168.1584985856104;
        Mon, 23 Mar 2020 10:50:56 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id j126sm13963979pfg.60.2020.03.23.10.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:50:55 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     drepper@redhat.com, nicolas.iooss@m4x.org, omosnace@redhat.com,
        plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: [PATCH 4/4] libsemanage: cleanup linker map file
Date:   Mon, 23 Mar 2020 12:50:37 -0500
Message-Id: <20200323175037.19170-5-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323175037.19170-1-william.c.roberts@intel.com>
References: <20200323175037.19170-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

The linker map file had inconsistent style in the 1_1 versions.
Drop the mixed tabs and spaces and use the consistent spacing indent
of two spaces.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsemanage/src/libsemanage.map | 62 ++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index e1861ccbebe1..ff5977b9f483 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -349,35 +349,35 @@ LIBSEMANAGE_1.0 {
 
 LIBSEMANAGE_1.1 {
   global:
-	  semanage_module_install;
-	  semanage_module_extract;
-	  semanage_get_hll_compiler_path;
-	  semanage_get_ignore_module_cache;
-	  semanage_set_ignore_module_cache;
-	  semanage_get_default_priority;
-	  semanage_set_default_priority;
-	  semanage_module_info_create;
-	  semanage_module_info_destroy;
-	  semanage_module_info_get_priority;
-	  semanage_module_info_get_name;
-	  semanage_module_info_get_lang_ext;
-	  semanage_module_info_get_enabled;
-	  semanage_module_info_set_priority;
-	  semanage_module_info_set_name;
-	  semanage_module_info_set_lang_ext;
-	  semanage_module_info_set_enabled;
-	  semanage_module_key_create;
-	  semanage_module_key_destroy;
-	  semanage_module_key_get_priority;
-	  semanage_module_key_get_name;
-	  semanage_module_key_set_priority;
-	  semanage_module_key_set_name;
-	  semanage_module_get_module_info;
-	  semanage_module_list_all;
-	  semanage_module_get_enabled;
-	  semanage_module_set_enabled;
-	  semanage_module_install_info;
-	  semanage_module_upgrade_info;
-	  semanage_module_remove_key;
-	  semanage_set_store_root;
+    semanage_module_install;
+    semanage_module_extract;
+    semanage_get_hll_compiler_path;
+    semanage_get_ignore_module_cache;
+    semanage_set_ignore_module_cache;
+    semanage_get_default_priority;
+    semanage_set_default_priority;
+    semanage_module_info_create;
+    semanage_module_info_destroy;
+    semanage_module_info_get_priority;
+    semanage_module_info_get_name;
+    semanage_module_info_get_lang_ext;
+    semanage_module_info_get_enabled;
+    semanage_module_info_set_priority;
+    semanage_module_info_set_name;
+    semanage_module_info_set_lang_ext;
+    semanage_module_info_set_enabled;
+    semanage_module_key_create;
+    semanage_module_key_destroy;
+    semanage_module_key_get_priority;
+    semanage_module_key_get_name;
+    semanage_module_key_set_priority;
+    semanage_module_key_set_name;
+    semanage_module_get_module_info;
+    semanage_module_list_all;
+    semanage_module_get_enabled;
+    semanage_module_set_enabled;
+    semanage_module_install_info;
+    semanage_module_upgrade_info;
+    semanage_module_remove_key;
+    semanage_set_store_root;
 } LIBSEMANAGE_1.0;
-- 
2.17.1

