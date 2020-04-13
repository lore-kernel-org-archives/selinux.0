Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECA4C2BA19
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 13:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C962072C
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 13:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClZFkw1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgDMNDO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727954AbgDMNDO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 09:03:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4BDC0A3BE2
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 06:03:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np9so3799796pjb.4
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 06:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bhGxa8/BsJXmYNu/avTJZdI46VSdtL1iMSMz+/eHO3U=;
        b=ClZFkw1B/iqkPyFdUiwVuCPjQOrAuOYPD/drN1hHtztK+PI1vms8Pgw3Ub4KgVu+A0
         Bp0qm8yIhIWSMSuhZXy7JJFYmOpbdLc7GQrq8tJW/ACG0DHl8dxf4FFM+fiSRx33iPZ8
         WWPcbW5MOYz7obKmgQY67Cvmn+K6OT258ilyBYwcX0fEHdNVObNVIvneN+SQIgZSrdes
         RaEtEDGW0jS8Oj/Gpb4HUcItH1y3qXglND82V29FuPyHnM3QmxEOue8CqwSALUBrO4Ll
         dMwsWz5x+3ivJYQS0Zz6vPSNpZB+tLUry2DRnYCUzWdUNMXKMc8xH1uaveYwuUxGH3jP
         zqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bhGxa8/BsJXmYNu/avTJZdI46VSdtL1iMSMz+/eHO3U=;
        b=lEqWU0sBLYVzIyAA0chjiomU7a/cRVCy6rMo63pK0em2d57FvONbXtLvs7aUdpVhwC
         TFVT4jefIqdemz76XNOGPHx7bpk/q07FtDRzaM3/Jt+ADMVAVdNFpWVm3JAC1WtqeZ0U
         9n5yEoC8MxPmVB+aS70Z71zoC1FvAOk9qr5trm9Y1haBSxglvN8IRCdcL6rDnXCjj07x
         VuWLAZzVDyHOWaJRgBfgb2ULu2IufPaMIC4Mu8mgC29eStDdJGMoR/7fXyeL+4bjxVqe
         ctjJ4euWtz3lJvPbK7MmkeRQp7OxdhTNBlZy89xGsJn00t/88D3+axNbSuBpEgG04Ufn
         b8mw==
X-Gm-Message-State: AGi0PuYhqF0ke/OmSDgyLCcdvVcbayTLUpvav6YcYWDdwNToQsGook3c
        6jrfWCKgfxzI36/oCD2c9XU=
X-Google-Smtp-Source: APiQypK9PK6iKaAKn8y9/8NnbXqkrT4F+WYpeXZ0NSOJiW1Iiu+6C/HFf+C3KrQXwHqjx0mhN/uHyQ==
X-Received: by 2002:a17:90a:22e9:: with SMTP id s96mr19564906pjc.46.1586782992132;
        Mon, 13 Apr 2020 06:03:12 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id b21sm3622856pfb.130.2020.04.13.06.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 06:03:11 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     nicolas.iooss@m4x.org, selinux@vger.kernel.org,
        william.c.roberts@intel.com
Subject: [PATCH 1/2] libsemanage: fix linker script symbol versions
Date:   Mon, 13 Apr 2020 08:02:47 -0500
Message-Id: <20200413130248.25296-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFftDdrJcmNoU6cJ56HRGeg-R6T3bfcxU1zU5xBEmMtxnHNgfw@mail.gmail.com>
References: <CAFftDdrJcmNoU6cJ56HRGeg-R6T3bfcxU1zU5xBEmMtxnHNgfw@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

In previous work to cleanup the exports and linker scripts, I introduced
a regression causing symbols to be named in both the 1.0 and 1.1
sections. This went un-noticed and was reported by
nicolas.iooss@m4x.org.

Previous patches checked for correctness by:
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
 libsemanage/src/libsemanage.map | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index ff5977b9f483..8ba2746deaa2 100644
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
-- 
2.17.1

