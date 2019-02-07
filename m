Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B981CC282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 10:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91308218FE
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 10:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBGKZu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:25:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfBGKZu (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 7 Feb 2019 05:25:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DC81C0C0572
        for <selinux@vger.kernel.org>; Thu,  7 Feb 2019 10:25:50 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 910DD17B5F
        for <selinux@vger.kernel.org>; Thu,  7 Feb 2019 10:25:49 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: Update manpage
Date:   Thu,  7 Feb 2019 11:25:45 +0100
Message-Id: <20190207102545.28580-1-vmojzis@redhat.com>
In-Reply-To: <CAJfZ7=nLOTU-o5Q9TBmgKqumk=BHC2qHz=6393S=6MY24Jxwxg@mail.gmail.com>
References: <CAJfZ7=nLOTU-o5Q9TBmgKqumk=BHC2qHz=6393S=6MY24Jxwxg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 07 Feb 2019 10:25:50 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Add description of -S option
- Sort the option descriptions based on the synopsis
- Add missing options to synopsis

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 checkpolicy/checkpolicy.8 | 19 +++++++++++--------
 checkpolicy/checkpolicy.c |  2 +-
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 1c8805d5..8f7dad41 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -3,7 +3,7 @@
 checkpolicy \- SELinux policy compiler
 .SH SYNOPSIS
 .B checkpolicy
-.I "[\-b[F]] [\-C] [\-d] [\-M] [\-c policyvers] [\-o output_file] [input_file]"
+.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-c policyvers] [\-o output_file] [\-S] [\-t target_platform (selinux,xen)] [\-V] [input_file]"
 .br
 .SH "DESCRIPTION"
 This manual page describes the
@@ -21,30 +21,33 @@ policy.conf or policy, depending on whether the \-b flag is specified.
 .B \-b,\-\-binary
 Read an existing binary policy file rather than a source policy.conf file.
 .TP
+.B \-F,\-\-conf
+Write policy.conf file rather than binary policy file. Can only be used with binary policy file.
+.TP
 .B \-C,\-\-cil
 Write CIL policy file rather than binary policy file.
 .TP
 .B \-d,\-\-debug
 Enter debug mode after loading the policy.
 .TP
-.B \-F,\-\-conf
-Write policy.conf file rather than binary policy file. Can only be used with binary policy file.
+.B \-U,\-\-handle-unknown <action>
+Specify how the kernel should handle unknown classes or permissions (deny, allow or reject).
 .TP
 .B \-M,\-\-mls
 Enable the MLS policy when checking and compiling the policy.
 .TP
+.B \-c policyvers
+Specify the policy version, defaults to the latest.
+.TP
 .B \-o,\-\-output filename
 Write a binary policy file to the specified filename.
 .TP
-.B \-c policyvers
-Specify the policy version, defaults to the latest.
+.B \-S,\-\-sort
+Sort ocontexts before writing out the binary policy. This option makes output of checkpolicy consistent with binary policies created by semanage and secilc.
 .TP
 .B \-t,\-\-target
 Specify the target platform (selinux or xen).
 .TP
-.B \-U,\-\-handle-unknown <action>
-Specify how the kernel should handle unknown classes or permissions (deny, allow or reject).
-.TP
 .B \-V,\-\-version
 Show version information.
 .TP
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 14dc91a3..e0a00f7c 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -113,7 +113,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	printf
 	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
 	     "[-c policyvers (%d-%d)] [-o output_file] [-S] "
-	     "[-t target_platform (selinux,xen)] [input_file]\n",
+	     "[-t target_platform (selinux,xen)] [-V] [input_file]\n",
 	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
 }
-- 
2.17.2

