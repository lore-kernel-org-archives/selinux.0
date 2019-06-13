Return-Path: <SRS0=L/M1=UM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC2AC31E4A
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172E5206BB
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfFMP0W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:26:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35752 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbfFMLqD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jun 2019 07:46:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so9808960wml.0
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2019 04:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0IOJ5mTiW9Di+6byx/XFd8J4wj9ksF3QCX6IatyZ6Mo=;
        b=pSt62Hu+NG4H0BB7bLrkuNoTC4Lp7ojAg2VJy56DHdaLvClmEQSXCbG455l1xLzYqL
         TOANTDtYTCzyxiCq2t4Z3e9u37Ans/RcgwMx19/SLLuL5mLsXPc9tKLbQPO8XIpJ+b1m
         pkHdpPGKkxtbTX/aRPdI3j0t6Qy8YVP8l3afe87InqCiPY6RMXsso5Sfn3znfvggo9px
         ZCPbcPz4/apXf+jQXFYZQpVpyg9Y+y1MqwyrPxAzDxc0WTZCxIFp1G6ARiD1x3F1M8D/
         LElli/TBwAIiXUleShiiS58PG91OEty+NEJFuqvdTU7wKR4zS5RrcQyPl4sf9WmVY0EN
         TzzA==
X-Gm-Message-State: APjAAAWjAsED0DiPRN+VACq3E9jKmRbGJ0YpfppWH+cekpFe/3UDufvI
        Gj5mZqItPqLVqHcaLozvCKXGRP13qrM=
X-Google-Smtp-Source: APXvYqwzes/bglPWM052LJlwdpB3TSI/iM57lSwoj2QawTMZJW2S0EgkAJdw9s0xZNoGVN2twW/NOg==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr3215540wmj.99.1560426361126;
        Thu, 13 Jun 2019 04:46:01 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b203sm2906357wmd.41.2019.06.13.04.46.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:46:00 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v4 0/4] Remove redundant rules when building policydb
Date:   Thu, 13 Jun 2019 13:45:54 +0200
Message-Id: <20190613114558.32621-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Changes in v4:
 * fix deallocation in error path in build_type_map()
 * fix leaked cond nodes
 * also update the man pages
 * use UINT32_C for 0xFFFFFFFF constant
 * squash in the RFC patches & drop the semodule patch
v3: https://lore.kernel.org/selinux/20190529073759.20548-1-omosnace@redhat.com/T/

Changes in v3:
 * fix bad patch squashing
 * rename secilc --optimize-policy option to --optimize (to be simpler
   and consistent with checkpolicy and semodule)
v2: https://lore.kernel.org/selinux/20190528145912.13827-1-omosnace@redhat.com/T/

Changes in v2:
 * fix handling of dontaudit (AVTAB_DENY) rules
 * switch optimization from opt-out to opt-in everywhere
 * add a patch from jwcart2 that adds optimization support to
   checkpolicy as well
 * add two RFC modifications (see log messages for details):
   * one improves the optimization to detect also rules covered by the
     union of two or more other rules (on permission set level)
   * the other one drops libsemanage/semodule run-time enabling/
     disabling of optimization in favor of a global config option
v1: https://lore.kernel.org/selinux/20190523102449.9621-1-omosnace@redhat.com/T/

This series implements an optional optimization step when building a
policydb via semodule or secilc, which identifies and removes rules that
are redundant -- i.e. they are already covered by a more general rule
based on the type attribute hierarchy.

Since the optimization might not always be useful (e.g. when care is
taken to not have redundant rules or when the attributes are
aggressively expanded) and might even drastically increase policy build
times under some cicumstances (for example with the DSSP standard policy
[1]), the optimization is applied only when requested explictly.

The optimization routine eliminates:
 * all allow/dontaudit/auditallow(/neverallow) rules (including xperm
   variants) that are covered by another more general rule (or by a
   union of other rules),
 * all conditional versions of the above rules that are covered by a
   more general rule either in the unconditional table or in the same
   branch of the same conditional.

The optimization doesn't process other rules, since they currently do
not support attributes. There is some room left for more precise
optimization of conditional rules, but it would likely bring only little
additional benefit.

Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/545184071

Tested:
 * live on my Fedora 29 devel machine under normal use (no unusual AVCs
   observed with the optimized policy loaded)
 * using: https://gitlab.com/omos/selinux-misc/blob/master/opt_test.sh
   * tests also xperm rules
   * doesn't test conditionals

[1] https://github.com/DefenSec/dssp2-standard

James Carter (1):
  checkpolicy: add flag to enable policy optimization

Ondrej Mosnacek (3):
  libsepol: add a function to optimize kernel policy
  libsemanage: optionally optimize policy on rebuild
  secilc: add flag to enable policy optimization

 checkpolicy/checkpolicy.8                  |   3 +
 checkpolicy/checkpolicy.c                  |  16 +-
 libsemanage/man/man5/semanage.conf.5       |   5 +
 libsemanage/src/conf-parse.y               |  15 +-
 libsemanage/src/conf-scan.l                |   1 +
 libsemanage/src/direct_api.c               |   7 +
 libsemanage/src/semanage_conf.h            |   1 +
 libsepol/include/sepol/policydb.h          |   5 +
 libsepol/include/sepol/policydb/policydb.h |   2 +
 libsepol/src/libsepol.map.in               |   5 +
 libsepol/src/optimize.c                    | 378 +++++++++++++++++++++
 libsepol/src/policydb_public.c             |   5 +
 secilc/secilc.8.xml                        |   5 +
 secilc/secilc.c                            |  16 +-
 14 files changed, 460 insertions(+), 4 deletions(-)
 create mode 100644 libsepol/src/optimize.c

-- 
2.20.1

