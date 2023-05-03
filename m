Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590FBC7EE22
	for <selinux@archiver.kernel.org>; Wed,  3 May 2023 12:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjECMGK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 May 2023 08:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjECMGI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 May 2023 08:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9915592
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683115522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZjGLNUP4sS9m6sXEARGb2cqASz0ULXmjIO25ehRl4Q=;
        b=HbwfvOj8SW3wLt7yspBtctv4by9JEHqAbyqLVzj8DSB5M4+ZB3ZYZIfOgallvR//idPPZI
        KKsx1lZbNqxsJ1jiIcTn027OXwiK1KeDA1mTIGtGJ7x35SsIODtbbFtADroi+rO2HVUaaI
        IfUMbLa4rfs/2tN/9lFft6M1JgzpmSI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-JihmGPSVOju-0jlVNdIedw-1; Wed, 03 May 2023 08:05:20 -0400
X-MC-Unique: JihmGPSVOju-0jlVNdIedw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EC743825BB0
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 12:05:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4ACF1410F29
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 12:05:19 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] python/chcat: Improve man pages
Date:   Wed,  3 May 2023 14:03:30 +0200
Message-Id: <20230503120332.699464-2-vmojzis@redhat.com>
In-Reply-To: <20230503120332.699464-1-vmojzis@redhat.com>
References: <20230503120332.699464-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Explain applying range/list of categories
- "-d" removes all categories of given file/user
- Add examples

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/chcat/chcat.8 | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/python/chcat/chcat.8 b/python/chcat/chcat.8
index d095a255..ae65fef1 100644
--- a/python/chcat/chcat.8
+++ b/python/chcat/chcat.8
@@ -1,6 +1,6 @@
 .TH CHCAT "8" "September 2005" "chcat" "User Commands"
 .SH NAME
-chcat \- change file SELinux security category
+chcat \- change SELinux security categories of files/users
 .SH SYNOPSIS
 .B chcat
 \fIcategory file\fR...
@@ -25,23 +25,33 @@ chcat \- change file SELinux security category
 .br
 .SH DESCRIPTION
 .PP
-Change/Remove the security \fIcategory\fR for each \fIfile\fR or \fIuser\fR.
-.PP
-Use +/- to add/remove categories from a \fIfile\fR or \fIuser\fR.
+Use +/- to add/remove categories from a \fIfile\fR or \fIuser\fR (only a single category can be specified at a time). Or specify the desired list/range of categories to be applied (replacing the existing categories).
 .PP
 .B
 Note:
-When removing a category you must specify '\-\-' on the command line before using the \-Category syntax.  This tells the command that you have finished entering options and are now specifying a category name instead.
+When removing a category you must specify '\-\-' on the command line before using the \-Category syntax. This tells the command that you have finished entering options and are now specifying a category name instead.
 
 .TP
 \fB\-d\fR
-delete the category from each FILE/USER.
+delete all categories from given FILE/USER.
 .TP
 \fB\-L\fR
 list available categories.
 .TP
 \fB\-l\fR
 Tells chcat to operate on users instead of files.
+
+.SH EXAMPLE
+.nf
+Replace categories of user "test" with c0.c6
+# chcat -l c0.c6 test
+Add category c1023 to user "test"
+# chcat -l +c1023 test
+Remove category c5 from file "file"
+# chcat -- -c5 file
+Remove all categories from file "file"
+# sudo chcat -d file
+
 .SH "SEE ALSO"
 .TP
 chcon(1), selinux(8), semanage(8)
@@ -52,4 +62,3 @@ When operating on files this script wraps the chcon command.
 /etc/selinux/{SELINUXTYPE}/setrans.conf 
 .br
 /etc/selinux/{SELINUXTYPE}/seusers
-
-- 
2.40.0

