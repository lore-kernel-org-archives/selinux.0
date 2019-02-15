Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECB3C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80FC21927
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391023AbfBOQAd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:00:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390625AbfBOQAd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 15 Feb 2019 11:00:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E94BF13982C
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 16:00:32 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.205.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 194595C3FD;
        Fri, 15 Feb 2019 16:00:31 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 1/3] python/semanage: Drop python shebang from seobject.py
Date:   Fri, 15 Feb 2019 17:00:23 +0100
Message-Id: <20190215160025.9810-1-plautrba@redhat.com>
In-Reply-To: <pjdtvh5m8i4.fsf@redhat.com>
References: <pjdtvh5m8i4.fsf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 15 Feb 2019 16:00:33 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

seobject.py is not supposed to be used as entrypoint therefore the shebang is
unnecessary. It also doesn't need execute bits.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/Makefile    | 2 +-
 python/semanage/seobject.py | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 2e262ef8..37065268 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -27,7 +27,7 @@ install: all
 		fi ; \
 	done
 	test -d $(DESTDIR)/$(PACKAGEDIR) || install -m 755 -d $(DESTDIR)/$(PACKAGEDIR)
-	install -m 755 seobject.py $(DESTDIR)/$(PACKAGEDIR)
+	install -m 644 seobject.py $(DESTDIR)/$(PACKAGEDIR)
 	-mkdir -p $(DESTDIR)$(BASHCOMPLETIONDIR)
 	install -m 644 $(BASHCOMPLETIONS) $(DESTDIR)$(BASHCOMPLETIONDIR)/semanage
 
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index b31a90c1..13fdf531 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1,4 +1,3 @@
-#! /usr/bin/python -Es
 # Copyright (C) 2005-2013 Red Hat
 # see file 'COPYING' for use and warranty information
 #
-- 
2.20.1

