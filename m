Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22010C433E0
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43C0233F8
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 12:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbhAMM1m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:27:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbhAMM1m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 07:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610540775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6EHn29AwV4S2CbaqsDCsAP6h4VdaOhJ5dUgPtK+2a+c=;
        b=LfeTb7O+vwmPjwCvDIjHtpOdkJoBT/ISUid8qV32NOh1X9FViYsmiuRK5g2FNgYRWzAMaX
        3OjlpbUMXuvlo99z7IqCrO4TAAMNWSRR/IOl3x5ayM8Vek9HThTdiXpwmbwq6Mp6AYVFb3
        3UZUmE1RZG04BAuDkaV9m5jPCqLGNTM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-wJexQnfEOuO_yTpH8L9mOg-1; Wed, 13 Jan 2021 07:26:12 -0500
X-MC-Unique: wJexQnfEOuO_yTpH8L9mOg-1
Received: by mail-ed1-f70.google.com with SMTP id x13so786980edi.7
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 04:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6EHn29AwV4S2CbaqsDCsAP6h4VdaOhJ5dUgPtK+2a+c=;
        b=i0fqhFrhMVuAehxkxlJqC+Srq6290fQGPdPoeHIEYPSNkva0cdNmzmgFFktle2kFED
         IQfusryt7RTHO/tAqtBmzp5DI4HRI5D9aJFArfn5BnkuphKmwSaAh7kcm40PfQkMOHGU
         tGSKmCoFNCmCDiNFehHUvfXhiPI0E9YVNwse3q3r/bJEpwQghpfz6u8SNPLY0CL2e3BN
         /f7agM9wCVR3gTEUbzuIncH3gTYwvBGZxmQn2FnNeNdzg1Bjb5g63IZrywk9qCv2je8/
         xchN/tmf1yMTMCQLcb+Yr4YeO/+8tc6/DiamYSAwQSTcxQAgJW1vOmbhrjMZtOst6Ytb
         TWEg==
X-Gm-Message-State: AOAM532FLXV0gsFxNkj6Jz8CJitHYZSi9XSnEfhlGjgyKwpMuuRhsRGx
        Ua46HVvSuF4oNzH2oy7Fm9bxw2TdYFMF7kpKbDST8IbZTimkqbDl68ve9759hUbemkpKYncJlEj
        ldAFuBECPcG9hfnzWF9pcLgL/op6rOpZ/l5tHF+ddw5Rn43TY8Emfb32RBfWCjDFhI9QSqQ==
X-Received: by 2002:a05:6402:1593:: with SMTP id c19mr1607529edv.269.1610540770816;
        Wed, 13 Jan 2021 04:26:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz++od85rZ7Kso1NrsN+G4PnAiQkzHcK0nkyB/t0q4g2ttOVPGB3dRc1Wuf2CvLrmZ/nZY7Ow==
X-Received: by 2002:a05:6402:1593:: with SMTP id c19mr1607511edv.269.1610540770562;
        Wed, 13 Jan 2021 04:26:10 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id a10sm656238ejk.92.2021.01.13.04.26.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 04:26:10 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/sysctl: use vm.swappiness instead of kernel.modprobe
Date:   Wed, 13 Jan 2021 13:26:09 +0100
Message-Id: <20210113122609.62703-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

/proc/sys/kernel/modprobe is labeled as usermode_helper_t on Fedora and
all domains are allowed to read that type now [1] so that crash handling
can proceed without denials.

While the underlying issue might be a kernel bug (I suspect these files
should be read under kernel credentials, not the crashing process),
let's use a different sysctl for testing for now.

Since vm.swappiness will be more strict about what values can be set,
rework the test a bit so that it works correctly regardless of the
original value and restores the original setting at the end.

[1] https://github.com/fedora-selinux/selinux-policy/pull/528

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/sysctl/test | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tests/sysctl/test b/tests/sysctl/test
index a726e96..d6f8c0f 100755
--- a/tests/sysctl/test
+++ b/tests/sysctl/test
@@ -3,21 +3,30 @@
 use Test;
 BEGIN { plan tests => 4 }
 
-$sysctl = "kernel.modprobe";
+$sysctl = "vm.swappiness";
+$val1   = "20";
+$val2   = "21";
+$val3   = "22";
 $oldval = `/sbin/sysctl -n $sysctl`;
 
+# set to a known value
+system "/sbin/sysctl -w $sysctl=$val1";
+
 $result = system "runcon -t test_sysctl_t -- /sbin/sysctl -n $sysctl 2>&1";
 ok( $result, 0 );
 
 $result =
-  system "runcon -t test_sysctl_t -- /sbin/sysctl -w $sysctl=$oldval 2>&1";
+  system "runcon -t test_sysctl_t -- /sbin/sysctl -w $sysctl=$val2 2>&1";
 ok( $result, 0 );
 
 $result = system "runcon -t test_nosysctl_t -- /sbin/sysctl -n $sysctl 2>&1";
 ok($result);
 
 $result =
-  system "runcon -t test_nosysctl_t -- /sbin/sysctl -w $sysctl=foobar 2>&1";
+  system "runcon -t test_nosysctl_t -- /sbin/sysctl -w $sysctl=$val3 2>&1";
 ok($result);
 
+# restore original value
+system "/sbin/sysctl -w $sysctl=$oldval";
+
 exit;
-- 
2.29.2

