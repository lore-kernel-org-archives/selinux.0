Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0286C432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 19:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68CA214DA
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 19:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439244AbfIXTMf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:12:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437145AbfIXTMf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 24 Sep 2019 15:12:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C75830A7BB5
        for <selinux@vger.kernel.org>; Tue, 24 Sep 2019 19:12:35 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80D2119C58;
        Tue, 24 Sep 2019 19:12:34 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] gui: Fix remove module in system-config-selinux
Date:   Tue, 24 Sep 2019 21:12:21 +0200
Message-Id: <20190924191221.245789-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 24 Sep 2019 19:12:35 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When a user tried to remove a policy module with priority other than 400 via
GUI, it failed with a message:

libsemanage.semanage_direct_remove_key: Unable to remove module somemodule at priority 400. (No such file or directory).

This is fixed by calling "semodule -x PRIORITY -r NAME" instead of
"semodule -r NAME".

From Jono Hein <fredwacko40@hotmail.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 gui/modulesPage.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gui/modulesPage.py b/gui/modulesPage.py
index cb856b2d..0584acf9 100644
--- a/gui/modulesPage.py
+++ b/gui/modulesPage.py
@@ -125,9 +125,10 @@ class modulesPage(semanagePage):
     def delete(self):
         store, iter = self.view.get_selection().get_selected()
         module = store.get_value(iter, 0)
+        priority = store.get_value(iter, 1)
         try:
             self.wait()
-            status, output = getstatusoutput("semodule -r %s" % module)
+            status, output = getstatusoutput("semodule -X %s -r %s" % (priority, module))
             self.ready()
             if status != 0:
                 self.error(output)
-- 
2.23.0

