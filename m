Return-Path: <SRS0=wb4z=OV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4BAC65BAF
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1682080F
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 15:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1682080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeLLP2e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:28:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeLLP2e (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Dec 2018 10:28:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 944123084218
        for <selinux@vger.kernel.org>; Wed, 12 Dec 2018 15:28:34 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E09845D70A;
        Wed, 12 Dec 2018 15:28:33 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] python/sepolicy: search() also for dontaudit rules
Date:   Wed, 12 Dec 2018 16:28:26 +0100
Message-Id: <20181212152826.24140-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Dec 2018 15:28:34 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

dontaudit rules were accidentally dropped during rewrite to SETools 4 API in
97d5f6a2

Fixes:
>>> import sepolicy
>>> sepolicy.search(['dontaudit'])
[]

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

Same patch as https://lore.kernel.org/selinux/20180918134401.22956-1-plautrba@redhat.com/
but with a slightly reworded commit message

 python/sepolicy/sepolicy/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index cd7af7cf..fbeb731d 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -344,6 +344,8 @@ def search(types, seinfo=None):
         tertypes.append(NEVERALLOW)
     if AUDITALLOW in types:
         tertypes.append(AUDITALLOW)
+    if DONTAUDIT in types:
+        tertypes.append(DONTAUDIT)
 
     if len(tertypes) > 0:
         q = setools.TERuleQuery(_pol,
-- 
2.19.2

