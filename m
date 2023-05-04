Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C02C7EE23
	for <selinux@archiver.kernel.org>; Thu,  4 May 2023 12:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEDMFu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 May 2023 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjEDMFt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 May 2023 08:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71912619F
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683201903;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufGzUx9hvz65Q+SFDbxFCHICo8XZdAevI5YlMVrFweI=;
        b=ZemA1JPUIe9tNWkHEh/btf1c2lVhUDLKv8H1V2uoC8PDc/IO0basFPdRoV+b9peV0bQTca
        ZM7JqClUjaA557wi0vtvQTRq5zxNuY7p3YBjEn2+/ZgOOeczdYAufz/CzfSHMPgOIXWRVm
        NMdyeRG2GrTTinK57K/n12hNr/lomzY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-Bu9OmTSvPD6Fjfl8HiQffg-1; Thu, 04 May 2023 08:05:02 -0400
X-MC-Unique: Bu9OmTSvPD6Fjfl8HiQffg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE3AF101A550
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 12:05:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 622D8492C3E
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 12:05:01 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/4] python/audit2allow: Add missing options to man page
Date:   Thu,  4 May 2023 14:04:48 +0200
Message-Id: <20230504120450.771407-3-vmojzis@redhat.com>
In-Reply-To: <20230504120450.771407-1-vmojzis@redhat.com>
References: <CAP+JOzQBSknYVqAqhu6WGwnTDBCXc-P1B73+MnfbcEyGi621CA@mail.gmail.com>
 <20230504120450.771407-1-vmojzis@redhat.com>
Reply-To: <CAP+JOzQBSknYVqAqhu6WGwnTDBCXc-P1B73+MnfbcEyGi621CA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/audit2allow/audit2allow.1 | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
index 04ec3239..c31021d3 100644
--- a/python/audit2allow/audit2allow.1
+++ b/python/audit2allow/audit2allow.1
@@ -40,10 +40,10 @@
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
@@ -51,15 +51,22 @@ auditd is running; use "ausearch \-m avc | audit2allow"  or "\-a" instead.
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
@@ -70,8 +77,12 @@ Generate loadable module package, conflicts with \-o
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
@@ -85,6 +96,9 @@ This is the default behavior.
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

