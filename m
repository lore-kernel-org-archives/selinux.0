Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFEBC7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 12:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjCTMkv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjCTMku (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 08:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5667A5BA7
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679316001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iSnmrbK/gasbBK5RY5GHj1AtMNZuKYv4m4MXNFRlk2w=;
        b=JUy3Tj1500OpF21/oERmgJ3ipm7d4fZeY29bOGRIsdAPRNik7YthpRGuWtyPr3oBSQpdaO
        49NSoU6+7yUSO0ssigHsz/ZEt5BQ7EZeDiguty8i2Rj5BLZtEK1rDiD1DxvE/P8nPkUglZ
        6PqykfwTCnbJQP5cnwaadP2ciH4AOZA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-OfrWiPJgMqOYYxH2an_xAg-1; Mon, 20 Mar 2023 08:40:00 -0400
X-MC-Unique: OfrWiPJgMqOYYxH2an_xAg-1
Received: by mail-ed1-f69.google.com with SMTP id s30-20020a508d1e000000b005005cf48a93so6113988eds.8
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 05:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679315998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSnmrbK/gasbBK5RY5GHj1AtMNZuKYv4m4MXNFRlk2w=;
        b=YRcod2poGoLT4n2X1y/9rruTFyo05Ak8EEY2V4gHxtSKZWhHA5EPuU7Zup8JYykHoA
         oAq5uf4koxP7/NjhHpTR24TK8mQ6YRm+wquiL2yri8qAzLP3XHv5pYON97w3kUC+B6qg
         1A1Ky0BvbYQwF0I3qTdLh6NHVOjini6BDnlmi/L2rxaBu03ZHaS7BQUrbk2JzDVbkYmd
         OLI3pyqcojBTwNHZMgdjAEwwCr1Z60+30yTtYfVgTuHm+fR3IvcTDZC8jvJSglUDQ8KS
         MSULSaVgEF/zJ34lOEVzJtkr39OekkYb+uqU4Qn/yJKloe4iSnhYw2clv2l2kZIP9cW/
         jpOw==
X-Gm-Message-State: AO0yUKVEzR4h09ZhbK7Ddcp+Bk1EF4VQEJre3PW4ZVstcSQyOxWCwgtd
        jxTYvaOJcHskyQxD36Zt+W74UyUV2gAl4GqRk0gkp+4pf92abn3WVjKq2vKabstydPrhLytv3uJ
        bpGc2YJNv/+Q6vwY5WeQKLScZz20Wro4EQaLk3vQQcr4Y5R7/C3MEbMU8Io6he0/5shAek6a0z2
        QG3GVz
X-Received: by 2002:a17:906:edc5:b0:8b1:e791:faef with SMTP id sb5-20020a170906edc500b008b1e791faefmr8331589ejb.67.1679315998730;
        Mon, 20 Mar 2023 05:39:58 -0700 (PDT)
X-Google-Smtp-Source: AK7set9gk08ogPaFCfemP9qNxZ3PbjaXz+j9L82jetBMmxVvcHLuUqipkiofUPT+R4LF1pAxm/WkZA==
X-Received: by 2002:a17:906:edc5:b0:8b1:e791:faef with SMTP id sb5-20020a170906edc500b008b1e791faefmr8331570ejb.67.1679315998335;
        Mon, 20 Mar 2023 05:39:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id p25-20020a170906499900b008b2aba5fb22sm4349531eju.206.2023.03.20.05.39.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 05:39:57 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] scripts/ci: install rdma-core-devel for selinux-testsuite
Date:   Mon, 20 Mar 2023 13:39:56 +0100
Message-Id: <20230320123956.181765-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It is required to build it as of commit 4b4922e115e2
("tests/infiniband*: simplify test activation").

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 scripts/ci/fedora-test-runner.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
index 7676f6ea..331b9ec7 100755
--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -61,6 +61,7 @@ dnf install -y \
     e2fsprogs \
     jfsutils \
     dosfstools \
+    rdma-core-devel \
     kernel-devel-"$(uname -r)" \
     kernel-modules-"$(uname -r)"
 
-- 
2.39.2

