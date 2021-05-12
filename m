Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483A1C433B4
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 10:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB45613F7
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 10:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhELK0n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 May 2021 06:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230292AbhELK0n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 May 2021 06:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620815135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VBW7xdLds6ZX6IZgcBF2YARwo05VwOO7xDlLVJlaqoc=;
        b=WmKyQ45rNI7ZnhqGP6Xs+uv3p65vuSxYW+D4NHFe7aWIzH06lt25SHNHBM0964TTiiX4zi
        96ohAOli5alrSqjQJrZpM13QMvidEP1ZRpTn+CUzvhZUD/pzJhXa6Dct0krU3TQcBfL22s
        u9JuQsMk2MEbvlE0QAuSb+AeLsfoO98=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-akYbpjerMOChppaAo6D-Wg-1; Wed, 12 May 2021 06:25:33 -0400
X-MC-Unique: akYbpjerMOChppaAo6D-Wg-1
Received: by mail-ed1-f71.google.com with SMTP id z12-20020aa7d40c0000b0290388179cc8bfso12517714edq.21
        for <selinux@vger.kernel.org>; Wed, 12 May 2021 03:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBW7xdLds6ZX6IZgcBF2YARwo05VwOO7xDlLVJlaqoc=;
        b=XtrO6Mu3xuZwohCbKIMWNnRJqjRcKCWYCQqkzowKvEWrEgdxhXrOBBbHm0+YF3vz5o
         3SIwRqnrGYZov17Wo6b9ePi/ZGfqSiuW0hq7o3kqcdlOewSFk7xK2S3ilkqtlSP0GArM
         ogGi4nOL1MhXDqitLCx8EFOzgSigWR3tP1KDOgyFG8B+Qemnw6m/dqH2Cd7SXOA3J+Ww
         vs/kdoFUUezj77EqA1Zx9S0MEoN+UyZsVSd79CcxKG6sPTrdrfDscFyOwao2ryrjsEqv
         s0V6CF0Jz81m4c2mZvjFkqx4HI6SUJlWHIlXCGJ4rXGlpSGqEJ6bjjEf3xSIWCmtThyI
         lqKA==
X-Gm-Message-State: AOAM533nJ183FQInFGDsjlXuEySXeMoxJv90YMCuTslGMb35vKzuxwhR
        G1wIHdybcbUXVml8IYkBkDfvXYNsC54aIAFWZkAhkqQqMaEv2lIzs/8R5TN49uLnHQ2WLvJKlnl
        mKM9BBNkbm1ZkVPu5k8qmbKaOe97SQUMNY1lCZOqlcziFfm26DnQ/Ar2xANceY+QwCaFAWQ==
X-Received: by 2002:a17:906:564f:: with SMTP id v15mr35924372ejr.96.1620815131963;
        Wed, 12 May 2021 03:25:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG53KcU7PNwrX4xgvZMOnuQUqtQKQyYdt8rapaJopozL5bR/FimS9JLxPmgnbdsSzO5EQNRg==
X-Received: by 2002:a17:906:564f:: with SMTP id v15mr35924348ejr.96.1620815131711;
        Wed, 12 May 2021 03:25:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id cw6sm13518716ejb.32.2021.05.12.03.25.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 03:25:31 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 0/2] Bump testsuite CI image to F34
Date:   Wed, 12 May 2021 12:25:27 +0200
Message-Id: <20210512102529.122753-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Run the testsuite on Fedora 34 to both keep with the flow and make the
vsock_socket test pass. Also fix an invalid free bug found by GCC 11
(needed for the build to succeed on F34).

The GitHub Actions CI now passes as verified on my GH fork.

Ondrej Mosnacek (2):
  libselinux: fix invalid free in store_stem()/load_mmap()
  scripts/ci: use F34 image instead of F33

 libselinux/src/label_file.c |  3 +--
 libselinux/src/label_file.h | 12 +++++++-----
 scripts/ci/Vagrantfile      |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.31.1

