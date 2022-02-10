Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE580C433EF
	for <selinux@archiver.kernel.org>; Thu, 10 Feb 2022 18:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiBJSwk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:52:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiBJSwk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Feb 2022 13:52:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916CF01
        for <selinux@vger.kernel.org>; Thu, 10 Feb 2022 10:52:40 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cn6so12505731edb.5
        for <selinux@vger.kernel.org>; Thu, 10 Feb 2022 10:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+srpHDz7CPZlQqVCRFFOR4Wso90T6cv/aufdHR1zKUI=;
        b=qKyC4QcsMXTAIMdD26IoX8sLOD4MsOzRZlKj4dURBMSzoJLkH1pmVhG9tK2113Pbn/
         TDc9p+BguLFSbfYzALxWKZ6nfp2QBIMyUMbKx//UUTl1qCDWeY5fn/KH2F0uYvy3ohI6
         2oLtkq1bRcQVd//2ivj1yhSdLBieXRpmHVUcVaXEGdK4eGJ6OcmJzycsLp3Y5aK6Tdc5
         WxwIvxf8KtTH4IX1JJ9sBV4JkrCxcaiB/oqQnEodzF6b7xpLhGjtU/QLSW5lwaadxVEZ
         7kHgxAfxaNpc3VajuAvYa+C2+Q51DERMlfAH4qYxvWgHHXaIKT+CCBwPNFI6woaAarfU
         YaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+srpHDz7CPZlQqVCRFFOR4Wso90T6cv/aufdHR1zKUI=;
        b=uhu8Bowocsw6CF1rJy5pwIZ/22DboYzncdIjG6its9QETT9p6W5P27PGRNGvKlth4/
         kI6hTfJSZn1RVGUUGNsCvuVGFmOWfXIWUTgP4KEy873E2y2eJ8Rv2U0EB96GjUSaBdY+
         D6PfwKjHLadQG6W4n/8IzrNVy7HTGsAlDPackDp8+cVzx/QvzXu1MVOYgNiXj65OFG6c
         9JGr29fNRSr5GTN4bvDKZmdwztdTo5ltRoFZw1nimHfOOMXhed4BDXnNuTCghBEwIg6h
         9WugT7HOSx5rrVh9GbzXWkfiT55Xgtbe15a7DIa2e4jO56y37NMAISZGVa+cJfvFijds
         5ogg==
X-Gm-Message-State: AOAM533YmyGq4XZacl7EMFZtNEXJ0IP4pZ6PW+YFSt39XWPr//givia7
        WxdpZxCIVK6jiuHK8BC1EnlT4GNShso=
X-Google-Smtp-Source: ABdhPJyAg7wpvuew1REcAfVob45NofQMlBd8qJbr3nFP+uGD2lz2RORg0Akk49Rfn5qIEEEUvw8dTw==
X-Received: by 2002:aa7:dbcc:: with SMTP id v12mr9684147edt.263.1644519159232;
        Thu, 10 Feb 2022 10:52:39 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-131-054.77.0.pool.telefonica.de. [77.0.131.54])
        by smtp.gmail.com with ESMTPSA id gi15sm4666070ejc.139.2022.02.10.10.52.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 10:52:38 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libsepol: use correct error type to please UBSAN
Date:   Thu, 10 Feb 2022 19:52:32 +0100
Message-Id: <20220210185234.41362-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The callback function apply in hashtap_map has a return type of int and
can return -1 on error.  Use int as type to save the return value to
avoid implicit conversions:

    hashtab.c:236:10: runtime error: implicit conversion from type 'int' of value -1 (32-bit, signed) to type 'unsigned int' changed the value to 4294967295 (32-bit, unsigned)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/hashtab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index 2eb35212..3ecaf165 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -224,8 +224,9 @@ int hashtab_map(hashtab_t h,
 		int (*apply) (hashtab_key_t k,
 			      hashtab_datum_t d, void *args), void *args)
 {
-	unsigned int i, ret;
+	unsigned int i;
 	hashtab_ptr_t cur;
+	int ret;
 
 	if (!h)
 		return SEPOL_OK;
-- 
2.34.1

