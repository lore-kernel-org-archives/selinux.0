Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AF1C433F5
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 11:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbiCKLyo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 06:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiCKLyn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 06:54:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FE9A4339D
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 03:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646999618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DPaeHit7JWfzg59qyNWM/r/bWi2KW/wj5ZAoHsf1WSE=;
        b=Ck6lsYKLMH6sn5GNfnltqKwMkwBL2rioGySUjNXOnFMbT9DQe4zF2gtok23xh6YiLYPCNH
        CLAqnFS14O2h8Lf0NvmoxdHiAcUJJsSKeqDeIMq/7XWTZyimig69+/IFDo0AydfIfOiVmw
        VS08rrXC7VkzuMsw11tkPshoseSs+As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-q8VRpnWLMdaSwds-p5pYeA-1; Fri, 11 Mar 2022 06:53:37 -0500
X-MC-Unique: q8VRpnWLMdaSwds-p5pYeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F271824FA6
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 11:53:36 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC18D6C934;
        Fri, 11 Mar 2022 11:53:34 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux: Close leaked FILEs
Date:   Fri, 11 Mar 2022 12:53:30 +0100
Message-Id: <20220311115330.922386-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
label_media.c:94:24: warning: leak of FILE ‘fopen (path_28, "re")’ [CWE-775] [-Wanalyzer-file-leak]
label_x.c:121:24: warning: leak of FILE ‘fopen (path_28, "re")’ [CWE-775] [-Wanalyzer-file-leak]

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/label_media.c | 4 ++--
 libselinux/src/label_x.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index eb27deaf510e..3137c18edc19 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -95,10 +95,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 
 	if (fstat(fileno(fp), &sb) < 0)
-		return -1;
+		goto finish;
 	if (!S_ISREG(sb.st_mode)) {
 		errno = EINVAL;
-		return -1;
+		goto finish;
 	}
 	rec->spec_file = strdup(path);
 
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index e9fa063fafff..e6e8d9f60bff 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -122,10 +122,10 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 
 	if (fstat(fileno(fp), &sb) < 0)
-		return -1;
+		goto finish;
 	if (!S_ISREG(sb.st_mode)) {
 		errno = EINVAL;
-		return -1;
+		goto finish;
 	}
 	rec->spec_file = strdup(path);
 
-- 
2.35.1

