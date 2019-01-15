Return-Path: <SRS0=jgNJ=PX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E6C43387
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 13:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BD420656
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 13:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfAONgo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:36:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbfAONgn (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 15 Jan 2019 08:36:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CB542D7F7
        for <selinux@vger.kernel.org>; Tue, 15 Jan 2019 13:36:43 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DAA060606;
        Tue, 15 Jan 2019 13:36:40 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux/audit2why.so: Filter out non-python related symbols
Date:   Tue, 15 Jan 2019 14:36:29 +0100
Message-Id: <20190115133629.21263-1-plautrba@redhat.com>
In-Reply-To: <353f9889-d43c-9a14-4605-5ba1eac22284@tycho.nsa.gov>
References: <353f9889-d43c-9a14-4605-5ba1eac22284@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 15 Jan 2019 13:36:43 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

audit2why.so used to export libsepol.a symbols. We only need Python related
symbols:

- initaudit2why for python 2
- PyInit_audit2why for python3

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/Makefile      | 2 +-
 libselinux/src/audit2why.map | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/src/audit2why.map

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 8891086e..92e30738 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -165,7 +165,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
-	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(LDLIBS_LIBSEPOLA) $(PYLIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(LDLIBS_LIBSEPOLA) $(PYLIBS) -Wl,-soname,audit2why.so,--version-script=audit2why.map,-z,defs
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
diff --git a/libselinux/src/audit2why.map b/libselinux/src/audit2why.map
new file mode 100644
index 00000000..65989a8d
--- /dev/null
+++ b/libselinux/src/audit2why.map
@@ -0,0 +1,6 @@
+AUDIT2WHY_2.9 {
+  global:
+    initaudit2why;
+    PyInit_audit2why;
+  local: *;
+};
-- 
2.20.1

