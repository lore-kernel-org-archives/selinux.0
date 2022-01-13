Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D49C433EF
	for <selinux@archiver.kernel.org>; Thu, 13 Jan 2022 14:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiAMOjt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jan 2022 09:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235721AbiAMOjs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jan 2022 09:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642084787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhTfptieMVl3CFrY6zESlhyRzHzMdxp8Ej64SRLmy6Q=;
        b=X6xLPm9485E+il9RYYPevu1ZE6SZFYKoXW70q4FN/kIEzOff2G8TfUhfwhVoVGYnjzlsNc
        143j1wgdMBdF2zL0X8I2lm8UFxtfwD1UrY91W0kjMRQKyEBJVE/NYV3AqFWiAcQ5uS6adG
        TbkrL0r9SccE/RNs5bVxTPNM49wTpjA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-7sInULP8MCyt_1SSPsZFIQ-1; Thu, 13 Jan 2022 09:39:46 -0500
X-MC-Unique: 7sInULP8MCyt_1SSPsZFIQ-1
Received: by mail-ed1-f72.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so5555505edz.1
        for <selinux@vger.kernel.org>; Thu, 13 Jan 2022 06:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhTfptieMVl3CFrY6zESlhyRzHzMdxp8Ej64SRLmy6Q=;
        b=BYtrziER0gx9hITLGQRDwe9OZr/LxDfCGu5iTiK2TQk4qdIPTx8C6JKpo7GRXMcL88
         akQPqwSI0B0muCHreO27bSzp701w0BXuMZ1GwgmWC7NLMjolkADQBnRkiZsaI1Zg/lHB
         uOSrPMXS5mGjK1L17dgjwc1wpSVwH/swZBzRfwogWpK2kXzvrw16oh31xq+R33JiG2zw
         2WGYiD41PZ1Ba8ev4pjelu/+CCc7fcyVKG7hN56dQ3GC6b9ZZxZZoFbuk7lXGEMtwwkc
         GUCReycE0EsZ7mTXFwZil7mZcU6JQeD3UPcxLl5pGpMylXeSrtokFqT1oPnpiCip4HNU
         e0jQ==
X-Gm-Message-State: AOAM531KgowMRlJ5HKOUAOggv11O4bT2NaQHfLR/WEWAf1R49WJtemiR
        GhOj3HVDaE8icX/gqcu2Le8R+8t4BOtUR1sgZuqMn8wNYc/xRH4AuTSxGvvPUg3+NCX4UF+uIWK
        GzuQpUAaJM2IKgZul9kerE6JHba50w4xDWjtZn/pZ5OrqCqhXEhERm0/XPmpDm3qpKrM3Fw==
X-Received: by 2002:a05:6402:190d:: with SMTP id e13mr4418415edz.414.1642084784882;
        Thu, 13 Jan 2022 06:39:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw//HIcjmXOvSpE5GwJcwQFuN7Z+2NIECY6Rz59BeeWdX2tqBhPGWCoj42P9u7exHVramxBbw==
X-Received: by 2002:a05:6402:190d:: with SMTP id e13mr4418399edz.414.1642084784665;
        Thu, 13 Jan 2022 06:39:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:d5c1:b1da:9874:b302])
        by smtp.gmail.com with ESMTPSA id sc7sm964242ejc.87.2022.01.13.06.39.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 06:39:44 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 1/5] libsemanage: add missing include to boolean_record.c
Date:   Thu, 13 Jan 2022 15:39:31 +0100
Message-Id: <20220113143935.195125-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113143935.195125-1-omosnace@redhat.com>
References: <20220113143935.195125-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It uses asprintf(3), but doesn't directly include <stdio.h> - fix it.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/src/boolean_record.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
index 95f3a862..40dc6545 100644
--- a/libsemanage/src/boolean_record.c
+++ b/libsemanage/src/boolean_record.c
@@ -7,6 +7,9 @@
  */
 
 #include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+
 #include <sepol/boolean_record.h>
 
 typedef sepol_bool_t semanage_bool_t;
@@ -20,7 +23,6 @@ typedef semanage_bool_key_t record_key_t;
 #include "boolean_internal.h"
 #include "handle.h"
 #include "database.h"
-#include <stdlib.h>
 #include <selinux/selinux.h>
 
 /* Key */
-- 
2.34.1

