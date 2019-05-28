Return-Path: <SRS0=POVk=T4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C20C04AB6
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BCD2133F
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfE1O7R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 May 2019 10:59:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34680 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1O7R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 May 2019 10:59:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id e19so2519291wme.1
        for <selinux@vger.kernel.org>; Tue, 28 May 2019 07:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVUVounL7DiFbb3kGefIgF4gGhP9sB+J4TFqQvnZFPc=;
        b=p5HZdpsGbarSex8KtQiF34429jS9mBUvhB8Heh024M/JoN92cjvZ0Ih1wENpwz35OM
         JkPdV7GW88imQOmWLLOBzSc9SG6WnSnHx2ponKjkZ3QtZxnoMEapuXNJsH/tvytpv+wl
         evv4lN8/GLQmkfAGnxetmhEm8v96HSqc94lVw/cK6qOmATgdCAv/jj/BBELk9EdoCJ4h
         1q+IxFgb+tYbcvugLYIrUnt8vU+oYjU4bApjQnb9YY3Fo7voV00BlRfNFiomuh7k/olv
         VZ9s1h5/iomPfJD7Q8oDHaRMEb7LbU+XI3QwKyWLTwt6HPaNgIVnqJxQBXNR9teIqwli
         ifzQ==
X-Gm-Message-State: APjAAAUP7AJxzDj/tGLeNFgPmVEWKy4mGz8f5OpFujRScekBVXav/1tp
        Fz7FC6v4ysmbPl/1hRwH226XGrjbMW8=
X-Google-Smtp-Source: APXvYqyYu2I9bXzVQi4Pk2d6b8FrG0K7LttzDp+2bJO6Q01BLZZ49YGpTr7MiJ7Gwljf7GS8S69zhg==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr3756233wmb.112.1559055554909;
        Tue, 28 May 2019 07:59:14 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p17sm14118849wrq.95.2019.05.28.07.59.13
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 07:59:14 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 0/7] Remove redundant rules when building policydb
Date:   Tue, 28 May 2019 16:59:05 +0200
Message-Id: <20190528145912.13827-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

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
   variants) that are covered by another more general rule,
 * all conditional versions of the above rules that are covered by a
   more general rule either in the unconditional table or in the same
   branch of the same conditional.

The optimization doesn't process other rules, since they currently do
not support attributes. There is some room left for more precise
optimization of conditional rules, but it would likely bring only little
additional benefit.

Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/537683392

Tested:
 * live on my Fedora 29 devel machine under normal use (no unusual AVCs
   observed with the optimized policy loaded)
 * using: https://gitlab.com/omos/selinux-misc/blob/master/opt_test.sh
   * tests also xperm rules
   * doesn't test conditionals (yet)

[1] https://github.com/DefenSec/dssp2-standard

James Carter (1):
  checkpolicy: add flag to enable policy optimization

Ondrej Mosnacek (6):
  libsepol: add a function to optimize kernel policy
  libsemanage: optionally optimize policy on rebuild
  semodule: add flag to enable policy optimization
  secilc: add flag to enable policy optimization
  [RFC] lisepol: slightly more thorough optimization
  [RFC] libsemanage: switch to config file entry

 checkpolicy/checkpolicy.c                  |  16 +-
 libsemanage/src/conf-parse.y               |  15 +-
 libsemanage/src/conf-scan.l                |   1 +
 libsemanage/src/direct_api.c               |   7 +
 libsemanage/src/semanage_conf.h            |   1 +
 libsepol/include/sepol/policydb.h          |   5 +
 libsepol/include/sepol/policydb/policydb.h |   2 +
 libsepol/src/libsepol.map.in               |   5 +
 libsepol/src/optimize.c                    | 376 +++++++++++++++++++++
 libsepol/src/policydb_public.c             |   5 +
 secilc/secilc.c                            |  16 +-
 11 files changed, 445 insertions(+), 4 deletions(-)
 create mode 100644 libsepol/src/optimize.c

-- 
2.20.1

