Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B03AC47090
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 11:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DCD61026
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 11:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhEJLWU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbhEJLGE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 07:06:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7962CC06175F
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 03:56:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j26so14499706edf.9
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2aT6UagI7ywkM4BJI0sKc+mPlqXh0V87uCcnB78AK0=;
        b=CDTqUUu8r6l3LumLRIUntQgmjR2Zw4cXr+9lybLi3C1nTFknq73O1017k0XxSWhlkb
         HtvsSkBOhE8uX2EqLNb6qL2wsAAbXTmQNTn4X/XnT7/73khiWFo1v1oU4P8kTY8HSNuT
         GGgMF4D7jFrzATezIXd31Zt5NADYUtXhR57tdlzmdH958LDkGVmjdu8ijrHqG1mRl0t5
         JSbGKqRew0L3sh1XbHgc6wiSKZtLP1trGgvCMmHF1GnptnluHJWuh05cqx1xip0S48YS
         OkjiT/dt8On+83geX3Yecw/A3mwNcrcr2/dlDptGd9MBtFtqnknzA0CBDwWsUkywu+G6
         3z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2aT6UagI7ywkM4BJI0sKc+mPlqXh0V87uCcnB78AK0=;
        b=gWubakGCULfK7OBp74vrmTxjmRTrDiSmJK2+rogR3Ib4F54fWqq52Kgx8eMY0+eAS0
         Ebpb+Ss+OtYW//j8OS5UPRjxFsqGySQcYIgML/PrYVETI8vHZJzjD14mwa/A6te7KU4g
         fzPh8GlYS3jKLkfv0geHUAZveKQ5Fu7Z8TkoLCYmsi+ySv+o5hjt9aVsG6fGXsKyTSI1
         q9sjBz349wuNiUtTt8sAM4JEPkqW0mM6ZPUnFru9ohx3ER20HluxScKES4YPgEauF51h
         wLrOE2JN+tr02b2sEwJDFQK426OopfxCmQPFTFGhP+Ng/e4hj5aVu3zMwbQC1/IHiimE
         EPaA==
X-Gm-Message-State: AOAM5310raTUE9zRGqCtH7P/GdLQyOX0sBpwXmdrbUEVX2syAr1ngOfW
        5kZm4//15yrsywhbR2eYrE6NMOdstUkZkTFz
X-Google-Smtp-Source: ABdhPJwhtA/gEkyec181ia0ezm88XQy7CqOqNZ3BInXdpXAOGCaPJ1hUQaN4tafEOZXUpDG03h354g==
X-Received: by 2002:a05:6402:36d:: with SMTP id s13mr28973144edw.103.1620644210221;
        Mon, 10 May 2021 03:56:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-162-005.77.3.pool.telefonica.de. [77.3.162.5])
        by smtp.gmail.com with ESMTPSA id z17sm8884162eju.65.2021.05.10.03.56.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:56:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/3] libselinux: quirks of the status page
Date:   Mon, 10 May 2021 12:56:45 +0200
Message-Id: <20210510105648.14635-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick Grift made me over IRC aware of the issue that systemd on
Fedora 34 no longer updates its selabel database automatically on
SELinux policy reloads.
The issue is caused by libselinux 3.2 defaulting to use the status page
instead of a netlink socket for reload/enforcing change queries[1].
I prepared a patch for systemd over at [2].

While writing the patch I noticed two possible issues:

1. selinux_status_open(3) is not reentrant
selinux_status_open() unconditionally calls mmap(2), regardless whether
the page is already opened.
selinux_status_open() might get called multiple times by a client
application unintentionally, e.g. once manually to be able to call
selinux_status_updated(3) and react to changes, and indirectly by
calling selinux_check_access(3), which calls avc_open(3), which since
3.2[1] also calls selinux_status_open().

2. In fallback mode selinux_status_open(3) sets internal callbacks
If selinux_status_open() gets called with fallback enabled and the
fallback is actually used, it sets the two callbacks for
SELINUX_CB_SETENFORCE and SELINUX_CB_POLICYLOAD.
These might be later overridden by client applications, which want to
install their own callbacks.
avc_open(3) since 3.2 calls selinux_status_open() with fallback mode
enabled.

[1]: https://github.com/SELinuxProject/selinux/commit/05bdc03130d741e53e1fb45a958d0a2c184be503
[2]: https://github.com/systemd/systemd/pull/19551

Christian Göttsche (3):
  libselinux: avc_destroy(3) closes status page
  libselinux: make selinux_status_open(3) reentrant
  libselinux: do not use status page fallback mode internally

 libselinux/man/man3/avc_open.3 | 3 +++
 libselinux/src/avc.c           | 2 +-
 libselinux/src/sestatus.c      | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.31.1

