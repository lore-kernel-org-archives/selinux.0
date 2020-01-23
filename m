Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDBAC33CB6
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 12:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C7224125
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 12:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVQhKoVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAWM50 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:57:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29337 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726170AbgAWM50 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 07:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579784245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8ZaCM7bdq/CkFeMDtbL8WdIlXEbdg+xTYAfqBBIVoU=;
        b=PVQhKoVbQZKwBP5A74BJRbFo+pYAf8uHPeNo+YKVfiLzsGXylHPUN4SM91e30/Ha+3LFML
        0cjvQIQ/LIpNbwXjJZVTPFK+3kbrkuwE7yjqzVyEN6t1HmlwrlIUib7Zh4PZypQiTGl4qd
        kAdfRXImIs6nKW+krhsWErUmcr4Cf1U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-UnIzFFb-O0O0RAEjvZaQzA-1; Thu, 23 Jan 2020 07:57:23 -0500
X-MC-Unique: UnIzFFb-O0O0RAEjvZaQzA-1
Received: by mail-wr1-f69.google.com with SMTP id z10so1628159wrt.21
        for <selinux@vger.kernel.org>; Thu, 23 Jan 2020 04:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8ZaCM7bdq/CkFeMDtbL8WdIlXEbdg+xTYAfqBBIVoU=;
        b=ffa1hIpMuU1YrT2iS6vJGA8wK3xEMoJmsqMvMi5E4Kk58DvUrUuNdgg1DZIJU2OnTb
         1oPq3E33rj7SjZ+0t6hfYGzQVF7YJr0HZ+5deHkc8TrMPZKjV7tXkdu0uINS5CI7rKBa
         e+6kFULPTSytK4cam+mjQSyvGZTa1VtFUkdF90ry+Hu5CVtV16JIjF3KyWO8AQjcZphV
         tSQT2o+SS9W4pF/ys7hG5prJWoikP+XfFwvaNEyaE/6pm0Kii+cA5udAhU/qVsfIz7Vd
         f8VYGASrPN/vvkxeWBumJFzgdoIzzyZOIEthN6583xqvahkxO6fRSnppJN1vBIX0vifZ
         WIJg==
X-Gm-Message-State: APjAAAUjlv9qCTHZU0+Wl2dEOJRzZ0SQbjpkJBPTKZRP899DEgKO1Rf4
        k1XcLuvY1/ZVz7xNkYS5IV8nnycrjze/L4DCkuKCSmGg4e8ccjOPCu/cW3zkmZDJMsQlJ81TH8V
        9gR9Y06Wro/PBh3Sakg==
X-Received: by 2002:adf:e609:: with SMTP id p9mr17261673wrm.397.1579784241529;
        Thu, 23 Jan 2020 04:57:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxc2CZkQZNUmMKvKbtOiWJGkDku8vdv8V5zyWLL/DCfXo/4M3EZijVorJe0zqywgUVRq7G5qQ==
X-Received: by 2002:adf:e609:: with SMTP id p9mr17261652wrm.397.1579784241271;
        Thu, 23 Jan 2020 04:57:21 -0800 (PST)
Received: from omos.redhat.com (ip-46.34.233.121.o2inet.sk. [46.34.233.121])
        by smtp.gmail.com with ESMTPSA id d8sm2821028wrx.71.2020.01.23.04.57.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 04:57:20 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 3/4] checkpolicy: remove unused te_assertions
Date:   Thu, 23 Jan 2020 13:57:15 +0100
Message-Id: <20200123125716.12662-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123125716.12662-1-omosnace@redhat.com>
References: <20200123125716.12662-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This variable is declared in a header file, but never defined or used.
The te_assert structure definition is only used in this declaration, so
remove both.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 checkpolicy/checkpolicy.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/checkpolicy/checkpolicy.h b/checkpolicy/checkpolicy.h
index 3868f1fa..f127687e 100644
--- a/checkpolicy/checkpolicy.h
+++ b/checkpolicy/checkpolicy.h
@@ -1,20 +1,6 @@
 #ifndef _CHECKPOLICY_H_
 #define _CHECKPOLICY_H_
 
-#include <sepol/policydb/ebitmap.h>
-
-typedef struct te_assert {
-	ebitmap_t stypes;
-	ebitmap_t ttypes;
-	ebitmap_t tclasses;
-	int self;
-	sepol_access_vector_t *avp;
-	unsigned long line;
-	struct te_assert *next;
-} te_assert_t;
-
-te_assert_t *te_assertions;
-
 extern unsigned int policyvers;
 
 #endif
-- 
2.24.1

