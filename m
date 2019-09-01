Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AEAC3A5A4
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C94A2190F
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfIASGw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:06:52 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:53666 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfIASGw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 14:06:52 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D81B4564880
        for <selinux@vger.kernel.org>; Sun,  1 Sep 2019 20:06:49 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/9] Fix issues found by static analyzers
Date:   Sun,  1 Sep 2019 20:06:27 +0200
Message-Id: <20190901180636.31586-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep  1 20:06:50 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

In August I ran several free static analyzers in order to find new
issues in the userspace code. I used:

* clang's static analyzer (with scripts/run-scan-build)
* https://lgtm.com/ (I wrote a simple configuration file to analyze the
  C code, the results are available on
  https://lgtm.com/projects/g/fishilico/selinux-for-lgtm/ )
* Facebook's Infer (https://fbinfer.com/, I wrote a script to invoke it
  like clang's static analyzer)

Each analyzer gave many results, with several true bugs in them. Here
are patches that fix some of them. I will post the configuration files
and scripts I used separately.

Thanks,
Nicolas

Nicolas Iooss (9):
  semodule-utils: fix comparison with argc
  libsepol/cil: help static analyzers by aborting when an allocation
    fails
  libsepol: do not dereference a failed allocated pointer
  libsepol: do not dereference scope if it can be NULL
  libsepol: reset *p to NULL if sepol_module_package_create fails
  libsepol/cil: do not dereference perm_value_to_cil when it has not
    been allocated
  python/chcat: remove unnecessary assignment
  python/sepolicy: remove unnecessary pass statement
  libsepol/tests: do not dereference a NULL pointer

 libsepol/cil/src/cil_binary.c                        | 10 ++++++----
 libsepol/cil/src/cil_mem.c                           |  5 +++++
 libsepol/src/avrule_block.c                          |  3 ++-
 libsepol/src/kernel_to_cil.c                         |  8 +++++---
 libsepol/src/kernel_to_conf.c                        |  8 +++++---
 libsepol/src/module.c                                |  4 +++-
 libsepol/tests/test-common.c                         | 11 +++++++----
 python/chcat/chcat                                   |  1 -
 python/sepolicy/sepolicy/__init__.py                 |  1 -
 semodule-utils/semodule_package/semodule_unpackage.c |  2 +-
 10 files changed, 34 insertions(+), 19 deletions(-)

-- 
2.22.0

