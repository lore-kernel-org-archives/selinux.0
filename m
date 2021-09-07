Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8940FC433EF
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 13:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDF360E97
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 13:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344625AbhIGNmD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344760AbhIGNmC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Sep 2021 09:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631022056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U/sFCHdSzUFiOG5T2HcjkfPbQywY/ivPHxe1BnXjvd8=;
        b=aHwC3mhM1SQoO/SOqpEn3H1ycqM8zKm4xXMozvtGVu1/coppd9qSxSD33e0lR4npoZdSxV
        q+cuJ3Ez3S6fm/xwlftqGx/viNZfBtgtTHTJk9x0t9RvDOblt7TlUt9LyaQR0iMYCorZgJ
        5ABxKHZVI1rKJg0N18eUphg4KUgijx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-xC8Q6ro7OMO-3sf93RJubg-1; Tue, 07 Sep 2021 09:40:54 -0400
X-MC-Unique: xC8Q6ro7OMO-3sf93RJubg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2471F824FA7
        for <selinux@vger.kernel.org>; Tue,  7 Sep 2021 13:40:54 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.193.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 576986F7EF;
        Tue,  7 Sep 2021 13:40:53 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libsepol: Fix detected RESOURCE_LEAKs
Date:   Tue,  7 Sep 2021 15:40:48 +0200
Message-Id: <20210907134048.282918-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
Error: RESOURCE_LEAK (CWE-772): [#def5]
libsepol/src/kernel_to_cil.c:2380: alloc_arg: "strs_init" allocates memory that is stored into "strs".
libsepol/src/kernel_to_cil.c:2386: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
libsepol/src/kernel_to_cil.c:2386: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
libsepol/src/kernel_to_cil.c:2386: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
libsepol/src/kernel_to_cil.c:2507: leaked_storage: Variable "strs" going out of scope leaks the storage it points to.

libsepol/src/kernel_to_conf.c:2315: alloc_arg: "strs_init" allocates memory that is stored into "strs".
libsepol/src/kernel_to_conf.c:2321: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
libsepol/src/kernel_to_conf.c:2321: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
libsepol/src/kernel_to_conf.c:2321: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
libsepol/src/kernel_to_conf.c:2385: leaked_storage: Variable "strs" going out of scope leaks the storage it points to.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsepol/src/kernel_to_cil.c  | 5 +++--
 libsepol/src/kernel_to_conf.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 81427e65f9a1..305567a5ef1e 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2497,9 +2497,10 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 		sepol_printf(out, ")\n");
 	}
 
-	strs_destroy(&strs);
-
 exit:
+	if (strs)
+		strs_destroy(&strs);
+
 	if (rc != 0) {
 		sepol_log_err("Error writing user declarations to CIL\n");
 	}
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 179f0ad1a5d1..eb72e4ac983e 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2375,9 +2375,10 @@ static int write_user_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 		sepol_printf(out, ";\n");
 	}
 
-	strs_destroy(&strs);
-
 exit:
+	if (strs)
+		strs_destroy(&strs);
+
 	if (rc != 0) {
 		sepol_log_err("Error writing user declarations to policy.conf\n");
 	}
-- 
2.32.0

