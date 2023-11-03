Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ACAC4167B
	for <selinux@archiver.kernel.org>; Fri,  3 Nov 2023 17:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjKCRaa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Nov 2023 13:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjKCRaa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Nov 2023 13:30:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7BF13E
        for <selinux@vger.kernel.org>; Fri,  3 Nov 2023 10:30:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-778927f2dd3so126336185a.2
        for <selinux@vger.kernel.org>; Fri, 03 Nov 2023 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699032625; x=1699637425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENtuIoEPQ+cOa/OEIxaH4FNDE14wPJtX7U86hbmxxyI=;
        b=d/kG4MoCSLkpcQW72pA7rKAtzd/+ft1r2CHHXzjaKhPZiNTIwA6lsGIIP0K6bNyqZG
         iiMRd9btPfP5GsxV+8pM8aXl97eC8T1GXqea8DPAostQay50ZgyCRI1kncvElERqTwb+
         CZYk/FCkY8OaTrCEMYgedUmZ1hjTbISbaFasVjWDWQT9sw46OXoV/4gGtEb7ykbuQQnW
         JICxizaqM0BxQyEPycwVAsp+l+KQsTaSU2Hf+wq5rbp/RoRA79gTjWxuoVQziSJwtdj6
         eQ8lVQQPMFX9ni4YziD+0VRRLsvM3CAQuoxoX7JZ0UGIMj+ED1pskN6Zk8llBYmsJdtP
         lZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699032625; x=1699637425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENtuIoEPQ+cOa/OEIxaH4FNDE14wPJtX7U86hbmxxyI=;
        b=pD8plc6kzdwqjwm6JeAb1p3vXtT93yoXg/PbM1poc4H+YUsXKTIKVqeAoF43hbGool
         bmqKWsPaOk7K1UdYHhyGhM3MDvhZ6EiChm/ONMMSHaAeovNFK4ZxK3VxDql1jnIUNwjM
         z4lePysBv5DnQ5jWqdGcP2jYTMX3iIpZEhvp5aWD10J+FduNwHqKh/Ct8Ms7OaqQppRW
         2cprfAhau5FhimLH2lIHRCUFiHxSu/v67nFMeZ/so+eJr5uT0q4yzkYR92T3JsPggOZx
         M6u8UMD/EIRUOszMs/92C0kHQUVBVpICi1PEmSYMX9Yt1vDWHl7fz6jL7H3r35EgP8gj
         BaSQ==
X-Gm-Message-State: AOJu0YxqreSqVDMG4JekaEPCBFc2eGWvxyD9GuGxBJKItcxLzF4vq0/V
        rzcRicgC7YyafBYa69cFC1oRmkMw6p8=
X-Google-Smtp-Source: AGHT+IFOhLAMOJhR+4+dPZdYp6auicItK27xvwTv1eru/S0821dgtuNJgpjgiL/i3SKywU6Pg+yxeQ==
X-Received: by 2002:a05:620a:1337:b0:777:fec:5741 with SMTP id p23-20020a05620a133700b007770fec5741mr21262708qkj.33.1699032625331;
        Fri, 03 Nov 2023 10:30:25 -0700 (PDT)
Received: from ip-10-113-85-151.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a291200b007789a3499casm901426qkp.115.2023.11.03.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:30:24 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v5 0/3] selinux: avtab arrays and refactors
Date:   Fri,  3 Nov 2023 17:29:50 +0000
Message-Id: <20231103172953.24667-1-jsatterfield.linux@gmail.com>
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

v5:
- No code changes, only patch hash updates

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

Jacob Satterfield (3):
  selinux: refactor avtab_node comparisons
  selinux: fix conditional avtab slot hint
  selinux: use arrays for avtab hashtable nodes

 security/selinux/ss/avtab.c       | 152 +++++++++++++++---------------
 security/selinux/ss/avtab.h       |   4 +-
 security/selinux/ss/conditional.c |  38 +++++---
 security/selinux/ss/conditional.h |   2 +-
 4 files changed, 103 insertions(+), 93 deletions(-)

-- 
2.34.1

