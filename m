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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27694C2BA19
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 13:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E732072C
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 13:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpqjJn6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgDMNEF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727954AbgDMNEF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 09:04:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A81C0A3BE2
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 06:04:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i3so392821pgk.1
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bhGxa8/BsJXmYNu/avTJZdI46VSdtL1iMSMz+/eHO3U=;
        b=kpqjJn6vqri2s8G87KxGTHnxung3YiDqq6mwQvpoxKatZYUU5I3E7t6afgQG32ZIaW
         /w0W+RAGjNxWBKqpOu2FhTEa0RfOO+vuHKyLMXGXQ+PYCP6JcZv7IJk9pdD4hEYoscC0
         Z5Z1/aodOVVVQ+E3aCZoSTUDkLVo+QcTN5071/pGUgi3opl25yw730doVJ2sdXD1OZBq
         iMYS8hyEUQAk/NQNwMcq9Ttdj//b5ghjbDB31zwX+eOSianlN+T8f+6u6nX6rj8V+PdN
         Oy+ATWnUTNZecfsHSMGMoZhMdzm3mtGBHuVHjTBagq4/yqPai3flC3YTMefScwPmNSTX
         t/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bhGxa8/BsJXmYNu/avTJZdI46VSdtL1iMSMz+/eHO3U=;
        b=d22MlpeUkEP6WBEH61ACPHee5QQ+Fb6vCzTYg+9dbgjTYkz1vWdSc1bfadFTsGCx5F
         WEQRroYra0OX3RVeSzhGG3xmhBKlUhlmbBjcF84mL1CGVhPS9a1ho01bsZKpkzbHz+Nl
         GDI7Qj5irJvRoywg/sr6gA52TPtyShwJI9EL1x81/uOCd40nFoOPGr79Q+9Fn7/ejh+z
         /3CehABYTAx1yESXfw5nikuYrAsqu4Tsx3DANF51InJA1C0vFH36299HExlj/yHImSMD
         5xKGChAOVYFXpjjCezJnVlE6H8Wnjzcy4e7DvzB4XTVu5LV10nXU/Azc+2QwXQHgysZD
         91Kw==
X-Gm-Message-State: AGi0Pual4A6fUkS4S3O+eUpOK25E1E7J7Xy/MuPsUBdAy2ncshoB6rDw
        uuhoDx/E9dtJ99q3ACiBM3E=
X-Google-Smtp-Source: APiQypL7DjUztostoMC0bP4znPm5fTZG7HdtzkGKXBS5nzw5jXlIkT/y4ebFInTgsRtZb2oyLMC1JQ==
X-Received: by 2002:a62:55c7:: with SMTP id j190mr17275177pfb.65.1586783044458;
        Mon, 13 Apr 2020 06:04:04 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id g3sm7909344pgd.64.2020.04.13.06.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 06:04:04 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     nicolas.iooss@m4x.org, selinux@vger.kernel.org,
        william.c.roberts@intel.com
Subject: [PATCH v2 1/2] libsemanage: fix linker script symbol versions
Date:   Mon, 13 Apr 2020 08:03:58 -0500
Message-Id: <20200413130359.25372-1-william.c.roberts@intel.com>
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

