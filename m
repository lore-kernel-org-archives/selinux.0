Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E38C433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 08:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC0E22B49
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 08:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b95B0oJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0IaZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:30:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56544 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726395AbgH0IaY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 04:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598517023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cNGZFLo7WFFNMapzyZNNCG7FHxb9upM6QyVS6Boe7+o=;
        b=b95B0oJYXbC7sjlAxh+ng659qRMFUmnmksRnE8wEQXiFy2dHg4T0IVMzhIeFXFe4y3gCnr
        /wK0WWM+xphlxo2XKd1oxssEmDGxUMtEXZv5mkECWy1Y5TenvzJ/K+ufwCxzsOfKP4SmSM
        4tuvWzbI04CiRiS7j7t02Wyxudv54p4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-4LHIx9lWMda2mxi54XGCiQ-1; Thu, 27 Aug 2020 04:30:20 -0400
X-MC-Unique: 4LHIx9lWMda2mxi54XGCiQ-1
Received: by mail-wr1-f71.google.com with SMTP id j2so1253476wrr.14
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 01:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cNGZFLo7WFFNMapzyZNNCG7FHxb9upM6QyVS6Boe7+o=;
        b=DRve19BUwxJjlohbjPicwaSYQPAqjknCKgSeqj2twGxC5Tw/heQbctKs7D7rzwGeAc
         z2Mz+aJTeeRMFzEhkvhPKg4mDBUeV5fmRPD6jjUe1hhc4BXe+nyPDoabFqqQhr7fQfnr
         SVdmMF14w2uWJLGaQZInEaTl97wYf+gj9ibKVnkEhnF088P7RzTh5y11CTixnL7MVxGT
         VkvvKJ1AtCe4fejuhrKcoFZw61AJqWt6Ke1ukuellaQM+4FPDUfBoIMv6/4W5FFrR/wM
         cW3UZgYyN3xFw0T5Nv6h9tvh5lfjehPL/mIh8Be6XWhsFBDeThC5xNIT6xzVnh0JawOK
         hsZA==
X-Gm-Message-State: AOAM531XKXpwZ0WO93g2fhkTYaGaBHgMcgWleXr7oC8aWvA1VDz0mTNH
        xTOzkMUTu8c7jJp0xQbDJ8fUwCuhKUUCk6HM3ObATIcUyHBHzHGIN/gsPJcKHlVIG04Du4r0ugr
        rV8/xDxBwwRQrIY0j6g==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr20265692wrx.277.1598517019341;
        Thu, 27 Aug 2020 01:30:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh4q3xjQUz+ZHk2BNGvjixXsUvYklDDjGrA2awD0YB9DBAB1bBrHs5o0eIm+azPCUaFkos+g==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr20265670wrx.277.1598517019073;
        Thu, 27 Aug 2020 01:30:19 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id g12sm4649532wro.80.2020.08.27.01.30.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 01:30:18 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] travis: add nftables to dependencies to run more tests
Date:   Thu, 27 Aug 2020 10:30:17 +0200
Message-Id: <20200827083017.1956255-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It is omitted from the official dependency list since it's optional, but
we want to (try to) install it in CI.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 travis-ci/run-testsuite.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
index c19b961..9b5f954 100755
--- a/travis-ci/run-testsuite.sh
+++ b/travis-ci/run-testsuite.sh
@@ -30,6 +30,7 @@ dnf install -y \
     libselinux-devel \
     net-tools \
     netlabel_tools \
+    nftables \
     iptables \
     lksctp-tools-devel \
     attr \
-- 
2.26.2

