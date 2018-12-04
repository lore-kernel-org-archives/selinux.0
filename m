Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25717C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B9B206B7
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B9B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeLDQo7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:44:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbeLDQo7 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 4 Dec 2018 11:44:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F49430016EF
        for <selinux@vger.kernel.org>; Tue,  4 Dec 2018 16:44:59 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-239.brq.redhat.com [10.40.204.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91C081054FC9
        for <selinux@vger.kernel.org>; Tue,  4 Dec 2018 16:44:58 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/semanage: Start exporting "ibendport" and "ibpkey" entries
Date:   Tue,  4 Dec 2018 17:44:55 +0100
Message-Id: <20181204164455.13353-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 04 Dec 2018 16:44:59 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Include "ibendport" and "ibpkey" entries in "semanage export".

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/semanage | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index f4be9750..a192fac8 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -776,7 +776,7 @@ def setupDontauditParser(subparsers):
 
 
 def handleExport(args):
-    manageditems = ["boolean", "login", "interface", "user", "port", "node", "fcontext", "module"]
+    manageditems = ["boolean", "login", "interface", "user", "port", "node", "fcontext", "module", "ibendport", "ibpkey"]
     for i in manageditems:
         print("%s -D" % i)
     for i in manageditems:
-- 
2.17.2

