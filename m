Return-Path: <SRS0=k4Wl=RH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BECC43381
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 16:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7591F206B8
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 16:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfCDQiM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:38:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfCDQiL (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 4 Mar 2019 11:38:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D538A3082207
        for <selinux@vger.kernel.org>; Mon,  4 Mar 2019 16:38:11 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.205.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B35B608C1;
        Mon,  4 Mar 2019 16:38:10 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux: Add security_reject_unknown(3) man page
Date:   Mon,  4 Mar 2019 17:37:35 +0100
Message-Id: <20190304163735.29563-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 04 Mar 2019 16:38:11 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit c19395d7 added a new interface security_reject_unknown() which needs to
be documented.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/man/man3/security_getenforce.3     | 9 ++++++++-
 libselinux/man/man3/security_reject_unknown.3 | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/man/man3/security_reject_unknown.3

diff --git a/libselinux/man/man3/security_getenforce.3 b/libselinux/man/man3/security_getenforce.3
index 29cf3de7..8d72afb6 100644
--- a/libselinux/man/man3/security_getenforce.3
+++ b/libselinux/man/man3/security_getenforce.3
@@ -1,6 +1,7 @@
 .TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
-security_getenforce, security_setenforce, security_deny_unknown, security_get_checkreqprot\- get or set the enforcing state of SELinux
+security_getenforce, security_setenforce, security_deny_unknown, security_reject_unknown,
+security_get_checkreqprot\- get or set the enforcing state of SELinux
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -11,6 +12,8 @@ security_getenforce, security_setenforce, security_deny_unknown, security_get_ch
 .sp
 .B int security_deny_unknown(void);
 .sp
+.B int security_reject_unknown(void);
+.sp
 .B int security_get_checkreqprot(void);
 .
 .SH "DESCRIPTION"
@@ -27,6 +30,10 @@ returned.
 returns 0 if SELinux treats policy queries on undefined object classes or
 permissions as being allowed, 1 if such queries are denied, and \-1 on error.
 
+.BR security_reject_unknown ()
+returns 0 if SELinux allows to load a policy which doesn't define all object
+classes and permissions, 1 if loading such policy is rejected, and \-1 on error.
+
 .BR security_get_checkreqprot ()
 can be used to determine whether SELinux is configured to check the
 protection requested by the application or the actual protection that will
diff --git a/libselinux/man/man3/security_reject_unknown.3 b/libselinux/man/man3/security_reject_unknown.3
new file mode 100644
index 00000000..d59e5c2c
--- /dev/null
+++ b/libselinux/man/man3/security_reject_unknown.3
@@ -0,0 +1 @@
+.so man3/security_getenforce.3
-- 
2.20.1

