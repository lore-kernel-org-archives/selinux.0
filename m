Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEA7C43457
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB96122248
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 13:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWASjFnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgJINBI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387996AbgJINBI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Oct 2020 09:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602248467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YuYcG/VuIumVTcwv4wGEyKkJ3Y9RUfEx/+s7JmSJr8=;
        b=OWASjFnz6P6lL2NKpJVXQA/OJYCZZhQ28nQOGx1SmpSrmNyiXR/VhCwIH9gzqJtnEAR9oE
        4YTg9dgtfgH87pQxRVXaNTEWJzO84IcvqPfgqw82GxgYcko/uwkklm3t1794QmIEaBDS3f
        dN6PVIYqqBSKA+wQKs5KO9LNZjVbyb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-cWkcASu7PhiRdG8i7QKAiA-1; Fri, 09 Oct 2020 09:01:05 -0400
X-MC-Unique: cWkcASu7PhiRdG8i7QKAiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A0CA802B4E
        for <selinux@vger.kernel.org>; Fri,  9 Oct 2020 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A26E876642;
        Fri,  9 Oct 2020 13:01:03 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 5/6] libsemanage: Drop deprecated functions
Date:   Fri,  9 Oct 2020 15:00:51 +0200
Message-Id: <20201009130052.52409-6-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-1-plautrba@redhat.com>
References: <20201009130052.52409-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

semanage_module_enable() and semanage_module_disable() were deprecated
by commit 9fbc6d14418f ("libsemanage: add back original module
enable/disable functions for ABI compatability") in 2014 in order to
preserve ABI compatibility. As we the libsemanage ABI is changed by the
previous commit, it makes sense to drop them completely.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/libsemanage.map |  2 --
 libsemanage/src/modules.c       | 56 ---------------------------------
 2 files changed, 58 deletions(-)

diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 4bec06aaae27..3ea7b60f97bb 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -165,8 +165,6 @@ LIBSEMANAGE_1.0 {
     semanage_is_connected;
     semanage_is_managed;
     semanage_mls_enabled;
-    semanage_module_disable;
-    semanage_module_enable;
     semanage_module_get_name;
     semanage_module_get_version;
     semanage_module_info_datum_destroy;
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 8b36801038df..b6dd456cac32 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -734,62 +734,6 @@ int semanage_module_set_enabled(semanage_handle_t *sh,
 }
 
 
-/* This function exists only for ABI compatibility. It has been deprecated and
- * should not be used. Instead, use semanage_module_set_enabled() */
-int semanage_module_enable(semanage_handle_t *sh, char *module_name)
-{
-	int rc = -1;
-	semanage_module_key_t *modkey = NULL;
-
-	rc = semanage_module_key_create(sh, &modkey);
-	if (rc != 0)
-		goto exit;
-
-	rc = semanage_module_key_set_name(sh, modkey, module_name);
-	if (rc != 0)
-		goto exit;
-
-	rc = semanage_module_set_enabled(sh, modkey, 1);
-	if (rc != 0)
-		goto exit;
-
-	rc = 0;
-
-exit:
-	semanage_module_key_destroy(sh, modkey);
-	free(modkey);
-
-	return rc;
-}
-
-/* This function exists only for ABI compatibility. It has been deprecated and
- * should not be used. Instead, use semanage_module_set_enabled() */
-int semanage_module_disable(semanage_handle_t *sh, char *module_name)
-{
-	int rc = -1;
-	semanage_module_key_t *modkey = NULL;
-
-	rc = semanage_module_key_create(sh, &modkey);
-	if (rc != 0)
-		goto exit;
-
-	rc = semanage_module_key_set_name(sh, modkey, module_name);
-	if (rc != 0)
-		goto exit;
-
-	rc = semanage_module_set_enabled(sh, modkey, 0);
-	if (rc != 0)
-		goto exit;
-
-	rc = 0;
-
-exit:
-	semanage_module_key_destroy(sh, modkey);
-	free(modkey);
-
-	return rc;
-}
-
 /* Converts a string to a priority
  *
  * returns -1 if str is not a valid priority.
-- 
2.28.0

