Return-Path: <SRS0=naTH=RO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DAAC43381
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 15:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D03A2075C
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 15:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfCKPAu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:00:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfCKPAu (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 11 Mar 2019 11:00:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69F712D7E7
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2019 15:00:50 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B151E6013A;
        Mon, 11 Mar 2019 15:00:49 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux: Do not define gettid() if glibc >= 2.30 is used
Date:   Mon, 11 Mar 2019 16:00:41 +0100
Message-Id: <20190311150041.373-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 11 Mar 2019 15:00:50 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since version 2.30 glibc implements gettid() system call wrapper, see
https://sourceware.org/bugzilla/show_bug.cgi?id=6399

Fixes:
cc -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I../include -D_GNU_SOURCE  -DNO_ANDROID_BACKEND   -c -o procattr.o procattr.c
procattr.c:28:14: error: static declaration of ‘gettid’ follows non-static declaration
   28 | static pid_t gettid(void)
      |              ^~~~~~
In file included from /usr/include/unistd.h:1170,
                 from procattr.c:2:
/usr/include/bits/unistd_ext.h:34:16: note: previous declaration of ‘gettid’ was here
   34 | extern __pid_t gettid (void) __THROW;
      |                ^~~~~~

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/procattr.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 48dd8aff..c6799ef2 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -22,8 +22,19 @@ static pthread_key_t destructor_key;
 static int destructor_key_initialized = 0;
 static __thread char destructor_initialized;
 
-#ifndef __BIONIC__
-/* Bionic declares this in unistd.h and has a definition for it */
+/* Bionic and glibc >= 2.30 declare gettid() system call wrapper in unistd.h and
+ * has a definition for it */
+#ifdef __BIONIC__
+  #define OVERRIDE_GETTID 0
+#elif !defined(__GLIBC_PREREQ)
+  #define OVERRIDE_GETTID 1
+#elif !__GLIBC_PREREQ(2,30)
+  #define OVERRIDE_GETTID 1
+#else
+  #define OVERRIDE_GETTID 0
+#endif
+
+#if OVERRIDE_GETTID
 static pid_t gettid(void)
 {
 	return syscall(__NR_gettid);
-- 
2.21.0

