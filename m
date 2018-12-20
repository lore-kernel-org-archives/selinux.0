Return-Path: <SRS0=ShWd=O5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BD7C43387
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 15:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F2421852
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 15:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbeLTPOh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:14:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbeLTPOg (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 20 Dec 2018 10:14:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA647227BB
        for <selinux@vger.kernel.org>; Thu, 20 Dec 2018 15:14:36 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CB7460169;
        Thu, 20 Dec 2018 15:14:36 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 4/4] python/semanage: Load a store policy and set the store SELinux policy root
Date:   Thu, 20 Dec 2018 16:14:20 +0100
Message-Id: <20181220151420.30878-5-plautrba@redhat.com>
In-Reply-To: <20181220151420.30878-1-plautrba@redhat.com>
References: <20181220151420.30878-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 20 Dec 2018 15:14:36 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When "store" is set, sepolicy needs to load a new policy file and selinux module
needs to set the new store root path.

With this patch, semanage is able to work correctly with non-default -S <store>
even when the default policy is not installed yet.

Fixes:
$ sudo semanage login -S minimum -m -s unconfined_u -r s0-s0:c0.c1023 __default__
libsemanage.dbase_llist_query: could not query record value
OSError: [Errno 0] Error

Related: https://bugzilla.redhat.com/show_bug.cgi?id=1558861

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/seobject.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 2b43b65c..7b9c68b1 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -260,6 +260,8 @@ class semanageRecords:
         if self.store == "" or self.store == localstore:
             self.mylog = logger()
         else:
+            sepolicy.load_store_policy(self.store)
+            selinux.selinux_set_policy_root("%s%s" % (selinux.selinux_path(), self.store))
             self.mylog = nulllogger()
 
     def set_reload(self, load):
-- 
2.20.1

