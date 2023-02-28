Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9EEC6FA8E
	for <selinux@archiver.kernel.org>; Tue, 28 Feb 2023 14:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjB1ONp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjB1ONo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Feb 2023 09:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9704EEC
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677593573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUBux0vBmZ4YIMCUZLV6ctufZZ8MEusMxC91CoZ5h5Y=;
        b=dRSgfFZ1yDW6yeV0FQ2XfH3BV5ghbAkgvbOyyhRWpK3RYtjkIVexnIyso/CWLPTbYKQ7bx
        qmplVdO3GLoK3sas6RjJxyaDXy+yYTh3erlio1ZFNAPGXESAd5SLtkntB2hgNs+jxgD7eG
        X6lmy4O3qWPsXDL0PrIVrrFpJB0pAkM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-9hMcekzpOOSRtLl3e-raLw-1; Tue, 28 Feb 2023 09:12:51 -0500
X-MC-Unique: 9hMcekzpOOSRtLl3e-raLw-1
Received: by mail-wr1-f70.google.com with SMTP id q7-20020a05600000c700b002cd9188abe5so341673wrx.3
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 06:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUBux0vBmZ4YIMCUZLV6ctufZZ8MEusMxC91CoZ5h5Y=;
        b=QNGLc8lnXbpYjnoXVMbRimY4I91QTmTFtmxE7WTUqpZsF6ffVs0wpEruECKAloNjVC
         QXmS1xa3Ufy9s2jEZmNoKoz5B915CfUzDe/y1wd/yZZF42uCZXGzyM2qYHatSheo2nqC
         rO4TjR/pQa7FWLZeMTRfMV4C/l0u0Yov698YrmDyzrGrvHBGKS5NWy+MuHQFgiOLDjKQ
         fNUapBnfVSWlMAKE0CBlv/M89ABCxzbP5mqLxZAK33TIOlJL2RYm1nTKpwxGqOHxfYp3
         q4P7ug/ZohCrB0RkN+wjY2J+gxSvIvXZeAVQqrwb3ftl79AfztKY0u8Quc0q0ycf3DKG
         UIOA==
X-Gm-Message-State: AO0yUKWNLEuGhnwo5RxAnQLfVaDawYOL0l7DIGfmUyiBmB68c5XWAn1T
        nvRnAsHO7QxdXsKt44kI4qnShY91KLNHIAq5xoCbJIrhjOVi9zgt3eL6FnbZCnkruXxm/VhC2i3
        +wOLSECkyykN9i3YDEBZsOlkBb5fcwfqvKmvCDIyXYIMhBAMq3QzdCcd7TPKtGKuvEjCBxnl0oC
        9lwA==
X-Received: by 2002:a05:600c:4ab0:b0:3eb:395b:19dc with SMTP id b48-20020a05600c4ab000b003eb395b19dcmr2281556wmp.9.1677593570499;
        Tue, 28 Feb 2023 06:12:50 -0800 (PST)
X-Google-Smtp-Source: AK7set8Vti5fJAZqAgxBajITUW1KdQnsSxd4vxch8+a0ulFNV5sqiwqj8ZW3PN6zA5hyrqKhyikLUw==
X-Received: by 2002:a05:600c:4ab0:b0:3eb:395b:19dc with SMTP id b48-20020a05600c4ab000b003eb395b19dcmr2281542wmp.9.1677593570180;
        Tue, 28 Feb 2023 06:12:50 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003eb20d4d4a8sm12161129wmk.44.2023.02.28.06.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:12:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH testsuite 1/3] policy: make sure test_ibpkey_access_t can lock enough memory
Date:   Tue, 28 Feb 2023 15:12:45 +0100
Message-Id: <20230228141247.626736-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228141247.626736-1-omosnace@redhat.com>
References: <20230228141247.626736-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The ibv_create_cq() operation requires the caller to be able to lock
enough memory (RLIMIT_MEMLOCK). In some environments (such as RHEL-8)
the default resource limits may not be enough, requiring CAP_IPC_LOCK to
go above the limit. To make sure the test works also under stricter
resource limits, grant CAP_IPC_LOCK to test_ibpkey_access_t.

Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_ibpkey.te | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
index 863ff16..97f0c3c 100644
--- a/policy/test_ibpkey.te
+++ b/policy/test_ibpkey.te
@@ -10,6 +10,8 @@ type test_ibpkey_access_t;
 testsuite_domain_type(test_ibpkey_access_t)
 typeattribute test_ibpkey_access_t ibpkeydomain;
 
+allow test_ibpkey_access_t self:capability ipc_lock;
+
 dev_rw_infiniband_dev(test_ibpkey_access_t)
 dev_rw_sysfs(test_ibpkey_access_t)
 
-- 
2.39.2

