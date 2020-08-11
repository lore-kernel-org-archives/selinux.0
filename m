Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F39C433DF
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 19:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6201320771
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 19:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vexFBpKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgHKTKn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTKn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 15:10:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B16EC06174A
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 12:10:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so2344848pjb.4
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9JfNN7o2N6/Rx7VmkunATb9Ya9auxljuCP17cdW98lY=;
        b=vexFBpKrlJWCLehdCMISIr9eZkBPwyG4fhNtHoCDLjHksF7mHy6SUaELCWmBo6VUhR
         we5sLTi256vKVz0hyq8Mbn6fi8emFTMJSmu+N59upkBT1R7cmBVURlDnboTfA+Nvpurp
         3NC5xYIEyhzvpjrPpRP7/Ht0Tc4OThKPdHvazqi+D9kL7j8KEImXjz1D/IDTbfAzbYcW
         ctYnkVAKFI740z1JMbdo5kiGNfQEQqO9M9swyTaI7H9WqJ1AkmhX5aVYpcs+10IdG8rN
         7k6YRp2iVdmWez0xTJTZQN11o/CbNZbjRsm5kvl/q0lX4X8xKZZne2mvH04YQwFCZ3Q/
         VnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9JfNN7o2N6/Rx7VmkunATb9Ya9auxljuCP17cdW98lY=;
        b=fPICnpPzWC37V+nTBaPZnk/F1gvmgLyWJ1hF+4o72GzQXXrGfEUOMttdrlGiXoNmCd
         RrJZ62oicc0jkAhz1PDd98GUvTyy8HsqyrgFS1ZZbQOUzzRsr1yWW1P2/duV2od3ynYm
         WOfVpvmHu2ggnFaYyM/Z/ttbTDN+y9KSdpmVCi9UrTxuCs//YAGcD0rDZeYXSKPCSbr9
         cBfsuFmOApayR7HeTYVPkQ820SGX2WvZN92XztxspG3dqBI/rEfjp6bMnCwNB0TxoPq6
         AnbK6fvvdNKpcxPlMHxkXWZC1WvRxgqtqyGiTjPg9SMYmJ+fy/FY5+xb3EPWT/0g6WA5
         t/yg==
X-Gm-Message-State: AOAM530p7toOBD2p3BfqTTCiVEV3Lojru7epVLzJ4zXC2cKSd98/R5jh
        IDu/LiaffO+bbfSg6ao01zvSuKKoAtk=
X-Google-Smtp-Source: ABdhPJyhGEdFsDfzZtvVh8FhWQjv68CWkpBj9E3Yz+UWD2zmxId82Sg3id036ncJBrsPQSRA2ZtKNA==
X-Received: by 2002:a17:90a:d249:: with SMTP id o9mr2447862pjw.233.1597173042431;
        Tue, 11 Aug 2020 12:10:42 -0700 (PDT)
Received: from wcrobert-MOBL1.netgear.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id e23sm12172102pgb.79.2020.08.11.12.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 12:10:41 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, plautrba@redhat.com,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] ci: fix stall on git log -1
Date:   Tue, 11 Aug 2020 14:10:35 -0500
Message-Id: <20200811191035.13948-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

git log -1 may use a pager to output long messages, and when the pager
is invoked, leads to stalls on the ci system waiting for user input.
Use --oneline to print the short part of the commit message and
the digest. This information is for debug/informational purposes only,
so truncating the output is sufficient.

Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: William Roberts <william.c.roberts@intel.com>
---

Thanks Ondrej for pointing out that the culprit was the pager, many
thanks for triaging this.

 scripts/ci/fedora-test-runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
index 0aaba87c421b..782189630569 100755
--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -67,7 +67,7 @@ dnf install -y \
 cd "$SELINUX_DIR"
 
 # Show HEAD commit for sanity checking
-git log -1
+git log --oneline -1
 
 #
 # Build and replace userspace components
-- 
2.17.1

