Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFA8C77B7A
	for <selinux@archiver.kernel.org>; Wed, 24 May 2023 11:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjEXLQs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 May 2023 07:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEXLQo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 May 2023 07:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F8C5
        for <selinux@vger.kernel.org>; Wed, 24 May 2023 04:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684926954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scr5o3e2Q+QzVUd7TiFOcq1Kf7ELGeWL22rpBIIy9VA=;
        b=h9wSkpuhbMo1biGfBwyj6ylY/UnMqqsiw6IOhjdmQ0DNi4tpg3rTze+ayNqbu3KCX8vG6u
        vzTyO9P/yOaFT+E2sz5OgL7Fnva0FeHmEW+/1bg1AdsZng9VUW542CTtBmW7dTvZqls7LM
        1YJi42mt+IKpnON8qK5Jfm/yQh8Hw2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-KwPqNytiM62YIXFwbMkC7A-1; Wed, 24 May 2023 07:15:53 -0400
X-MC-Unique: KwPqNytiM62YIXFwbMkC7A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3813101A53B
        for <selinux@vger.kernel.org>; Wed, 24 May 2023 11:15:52 +0000 (UTC)
Received: from fedora.. (unknown [10.43.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E128492B00
        for <selinux@vger.kernel.org>; Wed, 24 May 2023 11:15:52 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/5] checkpolicy: Add examples to man pages
Date:   Wed, 24 May 2023 13:15:34 +0200
Message-Id: <20230524111535.1743163-4-vmojzis@redhat.com>
In-Reply-To: <20230524111535.1743163-1-vmojzis@redhat.com>
References: <20230524111535.1743163-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 checkpolicy/checkpolicy.8 | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 2984c238..aefa148c 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -12,8 +12,8 @@ command.
 .PP
 .B checkpolicy
 is a program that checks and compiles a SELinux security policy configuration
-into a binary representation that can be loaded into the kernel.  If no 
-input file name is specified,
+into a binary representation that can be loaded into the kernel.
+If no input file name is specified,
 .B checkpolicy
 will attempt to read from policy.conf or policy, depending on whether the \-b
 flag is specified.
@@ -64,6 +64,17 @@ Show version information.
 .B \-h,\-\-help
 Show usage information.
 
+.SH EXAMPLE
+.nf
+Generate policy.conf based on the system policy
+# checkpolicy -b -M -F /etc/selinux/targeted/policy/policy.* -o policy.conf
+Recompile system policy so that unknown permissions are denied (uses policy.conf from ^^).
+Note that binary policy extension represents its version, which is subject to change
+# checkpolicy -M -U deny -o /etc/selinux/targeted/policy/policy.33 policy.conf
+# load_policy
+Generate CIL representation of current system policy
+# checkpolicy -b -M -C /etc/selinux/targeted/policy/policy.* -o policy.out
+
 .SH "SEE ALSO"
 SELinux Reference Policy documentation at https://github.com/SELinuxProject/refpolicy/wiki
 
-- 
2.40.0

