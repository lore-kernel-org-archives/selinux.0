Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AA8C4167D
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 15:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376916AbjKBPpz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376864AbjKBPpv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 11:45:51 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54318FB
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 08:45:48 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778a108ae49so178785685a.0
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698939947; x=1699544747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGoh9HHARUcgsEbh145PlCWwwqfzarrGayaqPIx86Og=;
        b=L5opE/CYifOw+3c6+ctM+w9fdATfGPzA6qr9Avqnyf2rxa7VPG3kIUMLGvNPp6u+Ub
         Ug/lXfRwA+jQ1dYEXN0PpXzZC2DsLABD9Dt9m8bymkmBsFDsjB5ad4TFPIdPYG3P/rsu
         jb5+6cX6/Kw22SsxX+AWE2LZ8RQfwkcI5/ouQU2jxA214w9Fk/tV9u37RUDVRAkI+8rL
         frOe2ZNu1v2h/cFI/+fhTM5yIE9W2egSylRtzXW454c3B1zY6nAbcQ2sDWIxa0zoRmgs
         mNmq6BwfBxLErON1+NbPuXBQKlkiIwY5C521mNXDSbcOHVcRhmb6yF6q9THBzoEhtNYj
         Tjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939947; x=1699544747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGoh9HHARUcgsEbh145PlCWwwqfzarrGayaqPIx86Og=;
        b=r99ZATT5Ms4JBR+uYch8PW558SwLpsK33CVBhi+7ML6ejXAGPOluVyigj3j+SJ0EE2
         wujb9zvvwjEIHkHqUZaDoV5NKNxAqe2zVK9XSnxBPl2suen3m9HwcHPUXb6ZhFfrI5J2
         Kr/OZm+W0esuhJ5mCZKkUD6Lp0ZKv6ClTvXWeoRASlMznbNvHNktS6NBxAFtYz9BTQns
         JVow4q4qVdlPE5CvzYCJIvTgrdYJeuThLq8+qx7/vv0zYSbIWiPCveZwvUisVUQmFVDP
         zQk2esmslNx8myM0xuM+tzFR+wHdrI6coYQfzglvKuKUSOLWxyaGHb1Iz51qBS/6Nvge
         SqPg==
X-Gm-Message-State: AOJu0Yyj600HJlHmGuORtSrowi6QGwhBvw5G/dbOqpWe52bd1uawSmTq
        M/FWozLV4cTal2K+XIdvBulS71f3EQU=
X-Google-Smtp-Source: AGHT+IHiMEPrWp0wlafEMeeweFA3jSnGoH/N4tx9NZivN0UN1GPmTQdx8exr40NpGH0TQqKZglfFtw==
X-Received: by 2002:a05:620a:19a6:b0:773:aa77:91d5 with SMTP id bm38-20020a05620a19a600b00773aa7791d5mr292248qkb.33.1698939946922;
        Thu, 02 Nov 2023 08:45:46 -0700 (PDT)
Received: from ip-10-113-85-151.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a210100b0076e1e2d6496sm37691qkl.104.2023.11.02.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:45:46 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v4 0/3] selinux: avtab arrays and refactors
Date:   Thu,  2 Nov 2023 15:45:21 +0000
Message-Id: <20231102154524.12006-1-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
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
the security server implementation to help it scale with additional
rules in the future.

Patch 1 refactors the internal avtab.c to remove duplicative code
and homogenize comparisons between data structures.

Patch 2 computes the number of conditional avtab rules instead of
using the regular avtab table size as a hint to avtab_alloc() to get
a properly sized hashtable. 

Patch 3 changes avtab to use arrays instead of a kmem_cache for the
individual nodes of the hashtable and depends on patch 3 due to the
pre-allocation of the array to prevent growing or shrinking it.

Changelog:

v4:
- selinux: avtab iteration macros
  - dropped from the patch series until the use-case for it becomes
    more apparent in future patches
- selinux: refactor avtab_node comparisons
  - unchanged
- selinux: fix conditional avtab slot hint
  - created from "use arrays for avtab hashtable nodes" patch
  - added comments in avtab.c explaining the use of the nrules param
- selinux: use arrays for avtab hashtable nodes
  - split independent code to "fix conditional avtab slot hint" patch
    to ease reviewing and allow independent merging
  - fixed an edge case exercised by this patch that causes a NULL
    deref in avtab_destroy(); discovered by clang-analyzer

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

Jacob Satterfield (4):
  selinux: refactor avtab_node comparisons
  selinux: avtab iteration macros
  selinux: fix conditional avtab slot hint
  selinux: use arrays for avtab hashtable nodes

 security/selinux/ss/avtab.c       | 179 ++++++++++++++----------------
 security/selinux/ss/avtab.h       |   4 +-
 security/selinux/ss/conditional.c |  38 ++++---
 security/selinux/ss/conditional.h |   2 +-
 4 files changed, 115 insertions(+), 108 deletions(-)

-- 
2.34.1

