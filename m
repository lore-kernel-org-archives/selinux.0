Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BFCC433F5
	for <selinux@archiver.kernel.org>; Thu,  3 Feb 2022 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352440AbiBCQxl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:53:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229983AbiBCQxl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Feb 2022 11:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643907220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhTfptieMVl3CFrY6zESlhyRzHzMdxp8Ej64SRLmy6Q=;
        b=hFyOi/9OYBaEpYhHVtj8oNnit5AtuSDuonPTH0aTlui+EGCvSGRSbM/bAOMReZ3zoHRp0+
        npYq9offN9s+s7FFGqg37Iq0j5lLaYHYhvBNhncJZi+ztc57aHG9eoUWWjVza2j6PZogGd
        z8hYZT6OmDc07cVZ4XbRvtTo9tFzywE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-pDhrdETJMuGH3XnU6i5FCg-1; Thu, 03 Feb 2022 11:53:39 -0500
X-MC-Unique: pDhrdETJMuGH3XnU6i5FCg-1
Received: by mail-ed1-f71.google.com with SMTP id w3-20020a50c443000000b0040696821132so1740466edf.22
        for <selinux@vger.kernel.org>; Thu, 03 Feb 2022 08:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhTfptieMVl3CFrY6zESlhyRzHzMdxp8Ej64SRLmy6Q=;
        b=mtCTZ+Wl5CvO4VkXum4qnqJ1Wqyckgc5fvifhvBrthltCKOR87l8PLI9HSbGbmJ+VH
         OkL/s6WZQuXWm93zXV+13+DuX3vz/1mk6WAkUh+LT7Cx5mVNrgNKLAiE4YJBmIx0nKtX
         lhY9vd+duYS5zgzwwYstSavflf1z5JxnNohgNdyKL8jywi6r4gjI1xPkaNxxVCccTlAz
         gpMZb0IjhGvwQ6q9ou/AMf9ZkE3CQCFIcQ7kNVHG6I2TrJCS7jdAImXTBquy8I3zS62a
         qJQwxTxfNhxGCGjgEtvcXpdn+Q7kUOUCenayLnDfsKdHs+voMtk7v37dl1IuvaI7a4i/
         ZOnQ==
X-Gm-Message-State: AOAM533Zu6MOQeG1PKCDaN1nsnxYitTVtB/FYrkJIN3Xxms9Jlr+Slgu
        IvCUqt7OYw/rQV2c+STybqa/JSEXovfiW6VsBJHqBkhRPpR8lfnca/gaDf7hQFHIyexAfTcoac8
        tDYP5okX/LtyBO+0TAKvcJ7XVWk94IuA3+zBXJQIg1IUY2F/qID6x3Zvq0FvfFvsSrtY9DQ==
X-Received: by 2002:a17:907:2d1e:: with SMTP id gs30mr29788778ejc.14.1643907217756;
        Thu, 03 Feb 2022 08:53:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzl1Jm/MxIhZ7gSTZHRCqMASIdRO+lw9yfR/Yir/0IkWYHam3jYPHngkxx6AxtiJ7ie7WebBQ==
X-Received: by 2002:a17:907:2d1e:: with SMTP id gs30mr29788769ejc.14.1643907217568;
        Thu, 03 Feb 2022 08:53:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id bs4sm18141027edb.84.2022.02.03.08.53.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:53:37 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 1/6] libsemanage: add missing include to boolean_record.c
Date:   Thu,  3 Feb 2022 17:53:22 +0100
Message-Id: <20220203165327.213601-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203165327.213601-1-omosnace@redhat.com>
References: <20220203165327.213601-1-omosnace@redhat.com>
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

