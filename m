Return-Path: <SRS0=VF96=T5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F4C04AB3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DB5208C3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfE2HiF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 May 2019 03:38:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44035 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfE2HiF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 May 2019 03:38:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so883731wru.11
        for <selinux@vger.kernel.org>; Wed, 29 May 2019 00:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ajoxegz7SZl6Clxj/qTbfBPfVfwK3XvHqwJOGvkKipc=;
        b=rAONM5WEqRULc77tH+nfE/GOBl5Hoe6ylnr6ZQqc49judkGqGzYmiFza8iqsTw60kE
         hp5tMTjCjsyoGheyMr96vuxIQxAML+Ew4zfdRsqtiE9eAM8JZwLP/PzKS7o+a7iIXglv
         fP0G/hKxYGwIMrNjwTcxf/FQFocdu+DZAL8+Xeo30MndHrpaqr3z69RPTun3/qCSadQ+
         6rH+JmHDbuKUSElGY8Is2Ph/r33TulHIkTpKtEyNGTKi0chRCd+GL0OLf32HLFeqSWz9
         ce5K1MtYh1JUi1vyFj01x6btuS07y7q7rWGPc8TPlgw63GlMrK2QpVSUe0U3NcDw8AEx
         c5Qw==
X-Gm-Message-State: APjAAAV7E30n9UWzBiLuBwjO2kF9nEyEZkN5TgEKSIdVpE8BWRmA3DjL
        lyRWRmHJclz7H9pb6iIduSFEKH1rWkM=
X-Google-Smtp-Source: APXvYqw1/6KeUItqZeiknQGtPsfk6OqKLcVyZEr6gWsFuXhY+OJuSwMjZfi9PxnE+U2N+5XTFEsq5A==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr30057770wrt.96.1559115483044;
        Wed, 29 May 2019 00:38:03 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p16sm32024877wrg.49.2019.05.29.00.38.01
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:38:02 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 0/7] Remove redundant rules when building policydb
Date:   Wed, 29 May 2019 09:37:52 +0200
Message-Id: <20190529073759.20548-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

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
   variants) that are covered by another more general rule,
 * all conditional versions of the above rules that are covered by a
   more general rule either in the unconditional table or in the same
   branch of the same conditional.

The optimization doesn't process other rules, since they currently do
not support attributes. There is some room left for more precise
optimization of conditional rules, but it would likely bring only little
additional benefit.

Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/538601363

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

