Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8FACDB47E
	for <selinux@archiver.kernel.org>; Wed, 18 Oct 2023 17:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJRR7L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Oct 2023 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbjJRR65 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Oct 2023 13:58:57 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8941713
        for <selinux@vger.kernel.org>; Wed, 18 Oct 2023 10:58:33 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so45514666d6.0
        for <selinux@vger.kernel.org>; Wed, 18 Oct 2023 10:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697651912; x=1698256712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XeRHgOrmEPGzik32gSn3xxnEIZX/DsTK1wkMv66YWlc=;
        b=b28Ske5fRH9A1pDa798qp4JAruLtTU57O1iLJdhuwsdD7pxmHWNxLaIleGVFwhkTHY
         Qc3krKKiBSFazdnFOzsGP6c7+JUXzyF41jlP1Pza0rZJAp/HiyeORFORBLyly/ZLi2yF
         q3CijWWpyz4JuoyrkLjHvy4oOcGZJLxAhGtN/6g4QDlcLU6YF1Dc+a31vAfAjbHYUgrN
         L6h0WRBas2kCwEAJDpA2gzoHOZ9lzHctzl4QdMapgIC9zLO0HVmZVfLqOTQXH8rU0Zl3
         iVz/MuTn1CZ0AVOYdzKjQdANKZu9lmdxTMoxRs7EXsktEdJ+RW7lskLbrWjdRyyta3I4
         /X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651912; x=1698256712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeRHgOrmEPGzik32gSn3xxnEIZX/DsTK1wkMv66YWlc=;
        b=W1FnEb3aXrJAb+mrljbLqzuf1+yVwYUElfTfTIw+gmTted5WV+6inQ+RCiZFVwjBTZ
         9yubLlaOkCDQqMPCUC+UzShQj4LUHq13XXrNDD+xlk051qrA8Wz4X8NgK9RHLindJfjC
         1Q6Te/QoDxjXHmpMjo/OqnWih0eb0gcdRegqEI2cgDAfCmYAjdCW+77DxC51NKH08r+j
         4xVSgDdHo6RvbxdIo1Ox5xHoFuIhmb+lEmzltoXQkQXLwDqh6ae1AXPTYcXlctKOj6ij
         Hm/TqtzPZML/voERZWdzwV98Bhyn0wlodBLJhUDRJaTU6qyUNYBFjtiy3aT1QBRHa9E9
         2yOw==
X-Gm-Message-State: AOJu0Yzw70KzOPRUAimSK9Op83LZA9LxMajYcymUGJuJA5i97hpvnwno
        mwEEwtcSGxjQbfHE3Tn2ZupipMREhOA=
X-Google-Smtp-Source: AGHT+IEbspyi0Xok6SsRte/72WOc/DCOSbq+voDkbqu93xHo2c07i4dP1P5zANMgpk2EA70dOINvhg==
X-Received: by 2002:a05:6214:c4d:b0:66d:3a89:8133 with SMTP id r13-20020a0562140c4d00b0066d3a898133mr5932667qvj.64.1697651911762;
        Wed, 18 Oct 2023 10:58:31 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id k15-20020a0cfa4f000000b00655d711180dsm133289qvo.17.2023.10.18.10.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:58:30 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v3 0/3] selinux: avtab arrays and refactors
Date:   Wed, 18 Oct 2023 17:57:33 +0000
Message-ID: <20231018175744.39667-1-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As the refpolicy and the default Fedora policy continue to grow in
size, especially with regard to rules / access vectors, the memory
usage of the policydb and runtime to search through it increases.
Looking at /proc/slabinfo indicates that the avtab_node_cachep
kmem_cache is significantly responsible for overall memory usage and
was a good target for optimizations. Running "perf stat" on the
"load_policy" command shows that a majority of time is spent adding
rules into the avtab.

This patch series is an attempt at optimizing these hot spots within
the security server implementation to help it scale with  additional
rules in the future.

All patches are independent of each other.

Patches 1-2 are refactors of the internal avtab.c interfaces and code
paths with no logic changes. It removes duplicative code and
homogenizes access patterns.

Patch 3 changes avtab to use arrays instead of a kmem_cache for the
individual nodes of the hashtable.

Changelog:

v3:
- selinux: simplify avtab_insert_node() prototype
  - dropped, already merged
- selinux: avtab iteration macros
  - reverted changes to avtab_destroy() which created a UAF bug
- selinux: refactor avtab_node comparisons
  - fixed indent issues in avtab_node_cmp()
  - removed unlikely() macro in avtab_insert()

v2:
- selinux: use arrays for avtab hashtable nodes
  - rewritten to use pointers instead of indices
  - NULL_NODE_IDX and NODES_ARRAY_IDX macros removed
  - getter functions removed
  - two-pass algorithm used to compute cond. table size prior to
    allocating the array
- selinux: hweight optimization in avtab_read_item
  - dropped, already merged
- selinux: shrink conditional avtab node array
  - dropped, not needed due to new allocation approach
- selinux: refactor avtab_node comparisons
  - newly added
- selinux: avtab iteration macros
  - newly added
- selinux: simplify avtab_insert_node() prototype
  - newly added

Jacob Satterfield (3):
  selinux: refactor avtab_node comparisons
  selinux: avtab iteration macros
  selinux: use arrays for avtab hashtable nodes

 security/selinux/ss/avtab.c       | 176 ++++++++++++++----------------
 security/selinux/ss/avtab.h       |   4 +-
 security/selinux/ss/conditional.c |  37 +++++--
 security/selinux/ss/conditional.h |   2 +-
 4 files changed, 112 insertions(+), 107 deletions(-)

-- 
2.41.0

