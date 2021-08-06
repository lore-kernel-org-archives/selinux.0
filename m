Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB0BC4338F
	for <selinux@archiver.kernel.org>; Fri,  6 Aug 2021 08:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506B76103B
	for <selinux@archiver.kernel.org>; Fri,  6 Aug 2021 08:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhHFIeF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231526AbhHFIeF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Aug 2021 04:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628238829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OjyVxTHfBPpzbqGizL/N7xT+aSY1CtQ1nw5yija+r4A=;
        b=PWLOy4aUTdxIS69nxfp5moH1LOKGMOCsauZiTHwGwGEZj4eAYpeCZFvdfK0XmTrvv7tuv6
        JnbXSREyfSgloiFoOERXUDxvqS06F2i5YREatgVOh/MdXbL1LxZ/oP9Mqef5r6PVzV0v5O
        oPcK9q5pRB94DOL/vAcWM0N5/IlGwP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-sns0ETF7O6SCjVUGgu_yPg-1; Fri, 06 Aug 2021 04:33:48 -0400
X-MC-Unique: sns0ETF7O6SCjVUGgu_yPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58DF5101C8C6
        for <selinux@vger.kernel.org>; Fri,  6 Aug 2021 08:33:47 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47E0C3AC1;
        Fri,  6 Aug 2021 08:33:43 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] mcstrans: Improve mlstrans-test output
Date:   Fri,  6 Aug 2021 10:33:40 +0200
Message-Id: <20210806083340.160333-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
    trans: a:b:c:s9 -> a:b:c:TOP SECRET != a:b:c:TOP SECRET SUCCESS
    untrans: a:b:c:T O P S E C R E T -> a:b:c:s9 != a:b:c:s9 SUCCESS

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 mcstrans/share/util/mlstrans-test | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/mlstrans-test
index 085fa82ddd25..df34e0e67c84 100644
--- a/mcstrans/share/util/mlstrans-test
+++ b/mcstrans/share/util/mlstrans-test
@@ -15,7 +15,7 @@ def untrans(trans, val):
         errors += 1
     else:
         if verbose:
-            print("untrans: %s -> %s != %s SUCCESS" % (trans, raw, val))
+            print("untrans: '%s' -> '%s' == '%s' SUCCESS" % (trans, raw, val))
 
 
 def trans(raw, val):
@@ -26,7 +26,7 @@ def trans(raw, val):
         errors += 1
     else:
         if verbose:
-            print("trans: %s -> %s != %s SUCCESS" % (raw, trans, val))
+            print("trans: '%s' -> '%s' == '%s' SUCCESS" % (raw, trans, val))
 
 
 if len(sys.argv) > 1 and sys.argv[1] == "-v":
-- 
2.32.0

