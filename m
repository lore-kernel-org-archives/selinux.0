Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B5EC4338F
	for <selinux@archiver.kernel.org>; Fri, 30 Jul 2021 11:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9996260EE6
	for <selinux@archiver.kernel.org>; Fri, 30 Jul 2021 11:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbhG3LxP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jul 2021 07:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238617AbhG3LxO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jul 2021 07:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627645989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kVvx4+V33n8zFyOl5+3d6FwBPTTq6ChN3hm1N29EQk4=;
        b=f3RjrwMF6h2xFh5hFzbh/8IUNJg86kWVie5B9wRwaDSUjF2R0NorCydxn/MdNFXUqU/VLT
        v+442Rr0mTb801IHd5kHcPZ8YY001XbI8yrngfBHI8KMO0PgviP9Bw/m1Bzbi7x8BFTFoh
        Ed1sHTnC9+zdNKxAIYQVzF4ZFvIlHY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-9To1VzR8Ofep5AI_MDvRiA-1; Fri, 30 Jul 2021 07:53:08 -0400
X-MC-Unique: 9To1VzR8Ofep5AI_MDvRiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B6BA801AE7
        for <selinux@vger.kernel.org>; Fri, 30 Jul 2021 11:53:07 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 617CF1057F64;
        Fri, 30 Jul 2021 11:53:06 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] python/sepolicy: Fix COPY_PASTE_ERROR (CWE-398)
Date:   Fri, 30 Jul 2021 13:52:56 +0200
Message-Id: <20210730115256.411543-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
    Error: COPY_PASTE_ERROR (CWE-398): [#def3]
    selinux/python/sepolicy/sepolicy/__init__.py:1032: original: ""_key_t"" looks like the original copy.
    selinux/python/sepolicy/sepolicy/__init__.py:1035: copy_paste_error: ""_key_t"" looks like a copy-paste error.
    selinux/python/sepolicy/sepolicy/__init__.py:1035: remediation: Should it say ""_secret_t"" instead?
    # 1033|
    # 1034|       if f.endswith("_secret_t"):
    # 1035|->         return txt + "treat the files as %s secret data." % prettyprint(f, "_key_t")
    # 1036|
    # 1037|       if f.endswith("_ra_t"):

    Error: COPY_PASTE_ERROR (CWE-398): [#def4]
    selinux/python/sepolicy/sepolicy/__init__.py:1065: original: ""_tmp_t"" looks like the original copy.
    selinux/python/sepolicy/sepolicy/__init__.py:1067: copy_paste_error: ""_tmp_t"" looks like a copy-paste error.
    selinux/python/sepolicy/sepolicy/__init__.py:1067: remediation: Should it say ""_etc_t"" instead?
    # 1065|           return txt + "store %s temporary files in the /tmp directories." % prettyprint(f, "_tmp_t")
    # 1066|       if f.endswith("_etc_t"):
    # 1067|->         return txt + "store %s files in the /etc directories." % prettyprint(f, "_tmp_t")
    # 1068|       if f.endswith("_home_t"):
    # 1069|           return txt + "store %s files in the users home directory." % prettyprint(f, "_home_t")

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index df773a6b314e..6b6160a449df 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -1039,7 +1039,7 @@ def get_description(f, markup=markup):
         return txt + "treat the files as %s key data." % prettyprint(f, "_key_t")
 
     if f.endswith("_secret_t"):
-        return txt + "treat the files as %s secret data." % prettyprint(f, "_key_t")
+        return txt + "treat the files as %s secret data." % prettyprint(f, "_secret_t")
 
     if f.endswith("_ra_t"):
         return txt + "treat the files as %s read/append content." % prettyprint(f, "_ra_t")
@@ -1071,7 +1071,7 @@ def get_description(f, markup=markup):
     if f.endswith("_tmp_t"):
         return txt + "store %s temporary files in the /tmp directories." % prettyprint(f, "_tmp_t")
     if f.endswith("_etc_t"):
-        return txt + "store %s files in the /etc directories." % prettyprint(f, "_tmp_t")
+        return txt + "store %s files in the /etc directories." % prettyprint(f, "_etc_t")
     if f.endswith("_home_t"):
         return txt + "store %s files in the users home directory." % prettyprint(f, "_home_t")
     if f.endswith("_tmpfs_t"):
-- 
2.32.0

