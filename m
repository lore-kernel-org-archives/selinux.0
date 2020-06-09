Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B10EC433DF
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 15:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA5642074B
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 15:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAkZX7en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgFIPSy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgFIPSx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 11:18:53 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA518C05BD1E
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 08:18:53 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so17888747qtg.4
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2020 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QBBZ0BFRnJH9EiL5bRcKHrIjytQoAiF+WJsEaUQCrd4=;
        b=iAkZX7en3m1n5G0dfvMoY2ON6gbGPYAkJxwKq/BaNXuVO934Eezl6gRNMTjybukfYC
         am/O33vaJ94fuwPgolNbkBdv/HIdRmeMOzj5wG3uLt6bnCqajSb4qhle7+aP9YtNC3zE
         rkV9Wgz6v7dDgXeOPRolBiSd4Vg9vPGvS+yYI9TpM34gZy79dTd4Du2ONhBRqv/oclAQ
         DmIvFWjVgqqVLMspu4omzaqBe9+foFgx63U9FVbKjb7CZGFXr/mwTqIOKByaP6Ksdazu
         z93NwApA6+6OfBPBkUIteNMr8mIMdZaB2/m9GX14vSjges2f1CkmYynHjIpH1wVVLUp7
         J5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QBBZ0BFRnJH9EiL5bRcKHrIjytQoAiF+WJsEaUQCrd4=;
        b=NsjasE4PjQ3GhK/SHYowVbWOB+yiDyU2wndBAR3sQI565xuedZ1tS7mGSxAF3f3EHq
         IUI9b5DHbTiWnVfKtVGWUrdAd4bAXU1KUnWRMzS5jXHlITai6yVSODQaaQBO6eBIk1WB
         yxpdQr9RRkwpRsDcYvIwDMUJxDzKU7FHmwrM5OvZoGdKtAvAUzbQsHg8aFzFBHnXSi9b
         bcErkpn1DYN07JOx/HlivRdi11/OSQuL7a8Az67H5boLXnQ5yiWVhf6KYkTzn4RNXHny
         5ULoOVZaGmrlAJ/lij7MZWc2zbmAf8aPqBPaqrCiCFij/c/q/rUDWJt5VYvdAUEHzkln
         x67Q==
X-Gm-Message-State: AOAM531T3ClG2kLR6blwQhN+hr2EWuJKhFbHjZOpvOJA6li6/AN87CnI
        L5Z5CzletDjY8kyAyDaAyhx4iQGQ7k4=
X-Google-Smtp-Source: ABdhPJybbx+s7IbXeQ2Qdf3WTP0cEf5ens3h/YB1z4IkdMjQUrSICT+THMjnt2HV6WARS7YGoi0Nlw==
X-Received: by 2002:ac8:969:: with SMTP id z38mr29310527qth.77.1591715932301;
        Tue, 09 Jun 2020 08:18:52 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id a5sm9922704qtw.22.2020.06.09.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 08:18:50 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] defconfig: add NETFILTER_XT_MATCH_STATE and NFS_V4_1
Date:   Tue,  9 Jun 2020 11:18:33 -0400
Message-Id: <20200609151833.43523-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When generating a kernel config for testing per the README.md instructions
based on localmodconfig followed by merge_config.sh with this defconfig
fragment, I found that certain tests were failing due to missing options.
We need NETFILTER_XT_MATCH_STATE for some of the tests/inet_socket tests
and NFS_V4_1 as a dependency for enabling NFS_V4_2 for the labeled nfs
tests.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/defconfig b/defconfig
index 00bf9f3..0c96408 100644
--- a/defconfig
+++ b/defconfig
@@ -21,6 +21,7 @@ CONFIG_NETWORK_SECMARK=y
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
 CONFIG_NETFILTER_XT_TARGET_SECMARK=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m # used for testing sctp
 
 # Filesystem security labeling support.
@@ -99,6 +100,7 @@ CONFIG_QFMT_V2=y
 # This is not required for SELinux operation itself.
 CONFIG_NFS_FS=m
 CONFIG_NFS_V4=m
+CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_NFS_V4_SECURITY_LABEL=y
 CONFIG_NFSD=m
-- 
2.25.1

