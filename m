Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9396C433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Sep 2021 16:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9627961100
	for <selinux@archiver.kernel.org>; Thu,  9 Sep 2021 16:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbhIIQqZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Sep 2021 12:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234862AbhIIQqX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Sep 2021 12:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631205913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t7M3RxP1Oiuk/Zqk5owCkcD91WVw7hrBHPYgaymT/aU=;
        b=JK2YgPGLX2QX4cmRK1hvlNvgEjfMt7gL5WnsJq+w+llSdUULuLzKH7g1ov2rmWL94rWzYx
        tzmojee//z6JiCU8XpeHFBr/IEA0236Dtmbj+cDVLReSfqtXmrQMkfbKvJ0uAjgr3I7c4g
        UvLDeH38/M/vgDMhCzYrvwjGBGQuCJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-idy-TcnOMsiU0il3JfgIAw-1; Thu, 09 Sep 2021 12:45:12 -0400
X-MC-Unique: idy-TcnOMsiU0il3JfgIAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A84C11015DDC
        for <selinux@vger.kernel.org>; Thu,  9 Sep 2021 16:44:46 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DADFC2C00F;
        Thu,  9 Sep 2021 16:44:45 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libsepol/cil: Fix detected RESOURCE_LEAK (CWE-772)
Date:   Thu,  9 Sep 2021 18:44:41 +0200
Message-Id: <20210909164441.354970-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

libsepol/cil/src/cil_binary.c:4823: alloc_arg: "bounds_check_type" allocates memory that is stored into "bad".
libsepol/cil/src/cil_binary.c:4840: var_assign: Assigning: "cur" = "bad".
libsepol/cil/src/cil_binary.c:4844: noescape: Resource "cur" is not freed or pointed-to in "cil_avrule_from_sepol".
libsepol/cil/src/cil_binary.c:4847: leaked_storage: Variable "cur" going out of scope leaks the storage it points to.
libsepol/cil/src/cil_binary.c:4847: leaked_storage: Variable "bad" going out of scope leaks the storage it points to.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsepol/cil/src/cil_binary.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 43c37fc24686..4a80cb562424 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4842,6 +4842,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 				rc = cil_avrule_from_sepol(pdb, cur, &target, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
 				if (rc != SEPOL_OK) {
 					cil_log(CIL_ERR, "Failed to convert sepol avrule to CIL\n");
+					bounds_destroy_bad(bad);
 					goto exit;
 				}
 				__cil_print_rule("  ", "allow", &target);
-- 
2.32.0

