Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE23C4332F
	for <selinux@archiver.kernel.org>; Mon, 12 Dec 2022 17:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiLLRpC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Dec 2022 12:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiLLRoz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Dec 2022 12:44:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C1FD01
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670867034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jtcJLqzHbvkSDIwV6TCyk7RsBDT+4p3FI2Z5XpojnwA=;
        b=Nft0CJNaP4BVuwB8FKLrPM/vEptZG3mNW1ZN0KcTCzGhSzC29ET71WXx7IZw5ADkBtT1qw
        Wkth4RsexRjSCiusTVHwQbfo9Tux3VYJpGAVxZSr2IJf7jilM0MpgCFMeu+Z+adB6vXPKT
        Lu48WOitklPsLBSald5beLsHmfOyX2w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-hqZSLU2fMTudpQwkn_ZgOg-1; Mon, 12 Dec 2022 12:43:52 -0500
X-MC-Unique: hqZSLU2fMTudpQwkn_ZgOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63EF63C02183
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-193-138.brq.redhat.com [10.40.193.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD60AC15BA0;
        Mon, 12 Dec 2022 17:43:51 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] sepolicy: Call os.makedirs() with exist_ok=True
Date:   Mon, 12 Dec 2022 18:43:49 +0100
Message-Id: <20221212174349.714152-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since commit 7494bb1298b3 ("sepolicy: generate man pages in parallel")
man pages are generated in parallel and there's a race between
os.path.exists() and os.makedirs().

The check os.path.exists() is not necessary when os.makedirs() is called
with exist_ok=True.

Fixes:
/usr/bin/sepolicy manpage -a -p /__w/usr/share/man/man8/ -w -r /__w/
FileExistsError: [Errno 17] File exists: '/__w/usr/share/man/man8/'

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/sepolicy/sepolicy/manpage.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index edeb3b77e759..1bff8f9acb49 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -376,8 +376,7 @@ class ManPage:
 
         self.fcdict = sepolicy.get_fcdict(self.fcpath)
 
-        if not os.path.exists(path):
-            os.makedirs(path)
+        os.makedirs(path, exist_ok=True)
 
         self.path = path
 
-- 
2.38.1

