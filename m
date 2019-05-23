Return-Path: <SRS0=8MrU=TX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4141CC282DD
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 10:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B36D21019
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 10:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfEWKYy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 May 2019 06:24:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38423 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWKYy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 May 2019 06:24:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so5648299wrs.5
        for <selinux@vger.kernel.org>; Thu, 23 May 2019 03:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TIwTJsEftNw1qhvNshyCVy8wTcWBTiGjIydPkV14cM=;
        b=IaOGuERpm4HOnmVYP3PgFIjYOVxtlp6uf7DxfcW3Zne3kgGzp+guRFwOFMJIdpCA7a
         wE/42pFu5Mm5ArQh54r67C69EnErQPXAAGkIvAufL+gUxVGprCIF7TMbWCZ+3mEqTmzl
         rqdSW7+xO/StVFSye8XrDWFT+amnwkrcBgTalKFsyMOY2j4Q5VwHg3bqDrJUHLK9JWZO
         1dzZy5o14eVccdXKWWnQSw1T83s4IPoz/UwUkM0wt0dYz6lJ/zg62zJ6vw3PQQ/WoNKc
         upslPMHGwKZfcHpsYEM5r6CSlIL9EK+u8YwRDepp98DjpJfsNxqqsR+k3qJlIXpzy90B
         GMNQ==
X-Gm-Message-State: APjAAAUSXfw/Hb9hOmw8pP4uqVRw9N5oFyJuPcEWLQr5N4/XUMRm/FFL
        4v3UOp1e05mK3PrD2hC+nVwEKFg5FQU=
X-Google-Smtp-Source: APXvYqycDnAKRFChuXQ4gCPZRINicnl94VeUTVjW1XDHYp5mDQ1vq5dH5GUEIqmnHxgdkkQKfI5IAA==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr4772006wrq.58.1558607092379;
        Thu, 23 May 2019 03:24:52 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x22sm10423388wmi.4.2019.05.23.03.24.51
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 03:24:51 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 0/4] Remove redundant rules when building policydb
Date:   Thu, 23 May 2019 12:24:45 +0200
Message-Id: <20190523102449.9621-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series implements an optional optimization step when building
a policydb via semodule or secilc, which identifies and removes rules
that are redundant -- i.e. they are already covered by a more general
rule based on attribute inheritance.

Since the performance penalty of this additional step is very small
(it adds about 1 s to the current running time of ~20-30 s [1]) and
it can have a big positive effect on the number of rules in policy
(it manages to remove ~40% AV rules from Fedora 29 policy), the
optimization is enabled by default and can be turned off using a
command-line option (--no-optimize) in secilc and semodule [2].

The optimization routine eliminates:
 * all allow/neverallow/dontaudit/auditallow rules (including xperm
   variants) that are covered by another more general rule,
 * all conditional versions of the above rules that are covered by a
   more general rule either in the unconditional table or in the same
   branch of the same conditional.

The optimization doesn't process other rules, since they currently
do not support attributes. There is some room left for more precise
optimization of conditional rules, but it would likely bring only
little additional benefit.

When the policy is mostly or fully expanded, the optimization should
be turned off. If it isn't, the policy build time will increase a lot
for no benefit. However, the complexity of optimization will be only
linear w.r.t. the number of rules and so the impact should not be
catastrophic. (When testing with secilc on a subset of Fedora policy
with -X 100000 the build time was 1.7 s with optimization vs. 1 s
without it.)

Tested live on my Fedora 29 devel machine under normal use. No unusual
AVCs were observed with optimized policy loaded.

Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/536157427

NOTE: The xperm rule support wasn't tested -- I would welcome some
      peer review/testing of this part.

[1] As measured on my machine (Fedora 29 policy, x86_64).
[2] I have no problem with switching it to opt-in if that is preferred.

Ondrej Mosnacek (4):
  libsepol: add a function to optimize kernel policy
  secilc: optimize policy before writing
  libsemanage: optimize policy on rebuild
  semodule: add flag to disable policy optimization

 libsemanage/include/semanage/handle.h      |   4 +
 libsemanage/src/direct_api.c               |   7 +
 libsemanage/src/handle.c                   |  13 +
 libsemanage/src/handle.h                   |   1 +
 libsemanage/src/libsemanage.map            |   5 +
 libsepol/include/sepol/policydb.h          |   5 +
 libsepol/include/sepol/policydb/policydb.h |   2 +
 libsepol/src/libsepol.map.in               |   5 +
 libsepol/src/optimize.c                    | 370 +++++++++++++++++++++
 libsepol/src/policydb_public.c             |   5 +
 policycoreutils/semodule/semodule.c        |  12 +-
 secilc/secilc.c                            |  16 +-
 12 files changed, 442 insertions(+), 3 deletions(-)
 create mode 100644 libsepol/src/optimize.c

-- 
2.20.1

