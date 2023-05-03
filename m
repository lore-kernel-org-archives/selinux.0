Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E65C77B7F
	for <selinux@archiver.kernel.org>; Wed,  3 May 2023 12:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjECMGJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 May 2023 08:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjECMGI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 May 2023 08:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C990C558D
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683115525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xf9zsBEYmsgsZO0okODB3lcOUUm3bxhsaINBbj+PJds=;
        b=bFimXk3LnMmuRx3edQBb1RrR1/iWRunqg4YGLl/x+ER6FPQOyB1Ahp9biJOlwItfctW/7O
        eUuRoi9NGShQHh0p5Usg6+9jKm6IWVD1OFDcjtQIL3qdjhwTlMJJsRQOp6cbNkzB+8/SOq
        CA4GqTdHBcdY2jSyptLbYkAKGEVyRpo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-Sazo9rLlOhGlj8Z78__czg-1; Wed, 03 May 2023 08:05:23 -0400
X-MC-Unique: Sazo9rLlOhGlj8Z78__czg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77D981066541
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 12:05:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AA291410F29
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 12:05:22 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] python/audit2allow: Add missing options to man page
Date:   Wed,  3 May 2023 14:03:31 +0200
Message-Id: <20230503120332.699464-3-vmojzis@redhat.com>
In-Reply-To: <20230503120332.699464-1-vmojzis@redhat.com>
References: <20230503120332.699464-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

---
 python/audit2allow/audit2allow.1 | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
index 04ec3239..b7d30918 100644
--- a/python/audit2allow/audit2allow.1
+++ b/python/audit2allow/audit2allow.1
@@ -40,26 +40,36 @@
 Read input from audit and message log, conflicts with \-i
 .TP
 .B "\-b" | "\-\-boot"
-Read input from audit messages since last boot conflicts with \-i
+Read input from audit messages since last boot, conflicts with \-i
 .TP
 .B "\-d" | "\-\-dmesg"
-Read input from output of 
+Read input from output of
 .I /bin/dmesg.
 Note that all audit messages are not available via dmesg when
 auditd is running; use "ausearch \-m avc | audit2allow"  or "\-a" instead.
 .TP
+.B "\-\-debug"
+Leave generated modules for -M
+.TP
 .B "\-D" | "\-\-dontaudit"
 Generate dontaudit rules (Default: allow)
 .TP
+.B "\-e" | "\-\-explain"
+Fully explain generated output
+.TP
 .B "\-h" | "\-\-help"
 Print a short usage message
 .TP
 .B "\-i  <inputfile>" | "\-\-input <inputfile>"
-read input from 
+Read input from
 .I <inputfile>
 .TP
+.B "\-\-interface-info=<interface_info_file>"
+Read interface information from
+.I <interface_info_file>
+.TP
 .B "\-l" | "\-\-lastreload"
-read input only after last policy reload
+Read input only after last policy reload
 .TP
 .B "\-m <modulename>" | "\-\-module <modulename>"
 Generate module/require output <modulename>
@@ -70,8 +80,12 @@ Generate loadable module package, conflicts with \-o
 .B "\-p <policyfile>"  | "\-\-policy <policyfile>"
 Policy file to use for analysis
 .TP
+.B "\-\-perm-map <perm_map_file>"
+Read permission map from
+.I <perm_map_file>
+.TP
 .B "\-o <outputfile>"  | "\-\-output <outputfile>"
-append output to 
+Append output to
 .I <outputfile>
 .TP
 .B "\-r" | "\-\-requires"
@@ -85,6 +99,9 @@ This is the default behavior.
 Generate reference policy using installed macros.
 This attempts to match denials against interfaces and may be inaccurate.
 .TP
+.B "\-t <type_regex>" | "\-\-type=<type_regex>"
+Only process messages with a type that matches this regex
+.TP
 .B "\-x" | "\-\-xperms"
 Generate extended permission access vector rules
 .TP
-- 
2.40.0

