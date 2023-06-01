Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932CBC77B7E
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 14:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjFAOk0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 10:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjFAOkX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 10:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958E1A4
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685630369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fw7dANvWf+cpw3hCkgH2v1XD1WrlM5Vf2PxU7nyhywI=;
        b=Gw91eSgldOZeVVI4VECmBBr6QeQxwcyDoJUV85tAnpZDXWO/ugWqSeUDC19a+19QCL3N1G
        PcxuRiza5e52CgX0e/Q97raAiF5axcKEPkZyMmKEkKPIEvBrLammN5dMeoeKf/t6ZinTlk
        tQX5sYnLmVGeVWsPfgAKJgO20x1geFw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-ZpGbSwloMZ-lAJMxdTAZrQ-1; Thu, 01 Jun 2023 10:39:28 -0400
X-MC-Unique: ZpGbSwloMZ-lAJMxdTAZrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 414CF29AA385
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 14:39:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D257014171BB
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 14:39:27 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 4/5] checkpolicy: Add examples to man pages
Date:   Thu,  1 Jun 2023 16:39:14 +0200
Message-Id: <20230601143915.2051922-4-vmojzis@redhat.com>
In-Reply-To: <20230601143915.2051922-1-vmojzis@redhat.com>
References: <87ttvsk0qx.fsf@redhat.com>
 <20230601143915.2051922-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 checkpolicy/checkpolicy.8 | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 2984c238..7843569b 100644
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
+# checkpolicy -b -M -F /etc/selinux/targeted/policy/policy.33 -o policy.conf
+Recompile system policy so that unknown permissions are denied (uses policy.conf from ^^).
+Note that binary policy extension represents its version, which is subject to change
+# checkpolicy -M -U deny -o /etc/selinux/targeted/policy/policy.33 policy.conf
+# load_policy
+Generate CIL representation of current system policy
+# checkpolicy -b -M -C /etc/selinux/targeted/policy/policy.33 -o policy.out
+
 .SH "SEE ALSO"
 SELinux Reference Policy documentation at https://github.com/SELinuxProject/refpolicy/wiki
 
-- 
2.40.0

