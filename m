Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9FDC4360C
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 07:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4BF20842
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 07:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfI3HtI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:49:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbfI3HtI (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 30 Sep 2019 03:49:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61C1DC049E23
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2019 07:49:08 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5C9D5D6D0
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2019 07:49:07 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/semanage: fix moduleRecords.customized()
Date:   Mon, 30 Sep 2019 09:49:04 +0200
Message-Id: <20190930074904.25219-1-vmojzis@redhat.com>
In-Reply-To: <CAJfZ7=nBDUZYO95PN4p5FaXh_KAa3SeHu6yq4CteFGgyPkjEUw@mail.gmail.com>
References: <CAJfZ7=nBDUZYO95PN4p5FaXh_KAa3SeHu6yq4CteFGgyPkjEUw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 30 Sep 2019 07:49:08 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Return value of "customized" has to be iterable.

Fixes:
   "semanage export" with no modules in the system (eg. monolithic policy)
   crashes:

   Traceback (most recent call last):
     File "/usr/sbin/semanage", line 970, in <module>
       do_parser()
     File "/usr/sbin/semanage", line 949, in do_parser
       args.func(args)
     File "/usr/sbin/semanage", line 771, in handleExport
       for c in OBJECT.customized():
   TypeError: 'NoneType' object is not iterable

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 5e9e3eb5..f4c29854 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -380,7 +380,7 @@ class moduleRecords(semanageRecords):
     def customized(self):
         all = self.get_all()
         if len(all) == 0:
-            return
+            return []
         return ["-d %s" % x[0] for x in [t for t in all if t[1] == 0]]
 
     def list(self, heading=1, locallist=0):
-- 
2.21.0

