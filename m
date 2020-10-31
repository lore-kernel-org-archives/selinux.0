Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D64C388F7
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 13:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276742071A
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 13:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUP4dQsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgJaNc6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727436AbgJaNc6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 09:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604151177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=19AfFAg729T/1R1LKxgAwRhjcqGpqA8Q8NJZr4MVo1U=;
        b=PUP4dQsq605yiTRPf1MGpoQAh08VWMT71v0B0F9YEQdsYaqsBmhED1MM++N11k6p9QeGmi
        l1EozCdGN7jA85V/+N1Aq8sBotlQIPtnknkDjT9dp1ijJ6jyLL5u02aWE28I9zS6HbQAl4
        g0mZB/CvKF8jx7cnTqMT2Xkb9KjlvXo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-HQJOAUZpPt-03YVqFjrh_A-1; Sat, 31 Oct 2020 09:32:54 -0400
X-MC-Unique: HQJOAUZpPt-03YVqFjrh_A-1
Received: by mail-ed1-f69.google.com with SMTP id b16so3894901edn.6
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 06:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19AfFAg729T/1R1LKxgAwRhjcqGpqA8Q8NJZr4MVo1U=;
        b=ToWwm6wkyLAkRQFDeleILEf5ZpW+XjhueAARzmnj3f9AxBUyAyqb6rVkzBj3Dx1woM
         X+zTbaPzP5O7xz4PlDJAOlEAbIsfcMwQSXdAQSZaLprHH0VIeahWAHKwFeOyPra17uL+
         tXBEio4D/DyrOnDsK7N8x9/5+1xZFKM/5t9XflrePC326BelNcMWoOkZR5oTzqdF98CT
         a6Xn2FXUewqQ9OJRUf0bcC5AdxLizdx37EkMvUqu4LWw1AuS9+SVer6j6Kzm3zpalCb4
         T6kPZn/ljLVYEasZZ6qnTBjeuHSMCvIqeUCm/ZNa+OrmzIfwHxaHKnrNrCkMXoeQkkMc
         a2kQ==
X-Gm-Message-State: AOAM5327oTkdmxbkMOqnrSC2lVfXJbXsiEYnoYKyNx0HBtJl9vstX3KW
        BsxjQ3h7rJcRCCDa87/EPGVLw+ea9BysX3f1b/rp4IXMks21jl1u3cRjN0bw4246cl5ppbBp4Ea
        tnncnwoRcNBuyx7cu1g==
X-Received: by 2002:a05:6402:28e:: with SMTP id l14mr7590079edv.157.1604151173491;
        Sat, 31 Oct 2020 06:32:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5S/p4Xak40zrPEPdlP30Dax3y5CMLHQHERHvIhLhID2Daao0EGg1SPYoIVDwARTy73gISSQ==
X-Received: by 2002:a05:6402:28e:: with SMTP id l14mr7590060edv.157.1604151173301;
        Sat, 31 Oct 2020 06:32:53 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id a1sm5355682edk.52.2020.10.31.06.32.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:32:52 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] travis: bump stable fedora version to 33
Date:   Sat, 31 Oct 2020 14:32:51 +0100
Message-Id: <20201031133251.186982-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The kernel that comes with the F32 image has a bug in XFS quota
handling, which will be exposed once we start testing all filesystems.
Since Fedora 33 has been released recently and has a much newer kernel
in its stock VM image, let's switch to it.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index dcac54d..cba7462 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -4,7 +4,7 @@ dist: bionic
 
 env:
   matrix:
-    - FEDORA_KIND="releases" FEDORA_MAJOR="32"
+    - FEDORA_KIND="releases" FEDORA_MAJOR="33"
     - FEDORA_KIND="development" FEDORA_MAJOR="rawhide"
 
 addons:
-- 
2.26.2

