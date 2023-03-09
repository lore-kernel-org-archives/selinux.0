Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F574C6FD19
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 21:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCIVvV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCIVvU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 16:51:20 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4EFAFBF
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 13:51:18 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id bo10so2415395qvb.12
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nKz/36ZExwg0+ibdxh/MlxGrqN8P9jXrcVpwBASe8wk=;
        b=jHH5eJyG6sRrhu1UQNDeMqwMFpG094xpl4ve0TqEOsU/ynjOk0CpEVGOjNDEoqfuMB
         ho7Wq2x5WiREAfsThsCNsuYkgD5Ffl0LmZDa+aWWdCw3JbUCha4k+S5upNOX1x4wyDor
         XNzof1O3XrEUB8+yo9vlhQXD1TXAIl/3WUWuGKy98FtU/Q+bZjGLONi6xuFd22DgJv6j
         cb7OffCDnT5jX6q2AMrja17B7rnulEwrUFlja6U8RBKMp+DZFKtw+9bzRN6Q0ee2zAxF
         5/0zekDNpqCGE0GhM1ezeFXjZl+62Np+2Ce9aRe7pWgOwMUPi5wuyV0xuM6aF/CXpotF
         r5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKz/36ZExwg0+ibdxh/MlxGrqN8P9jXrcVpwBASe8wk=;
        b=fN84U7plL432W1wWv4BFkbLBy6uqR9nYr2ITJzFNQ85Z/vr7PAhMz9IKOc7XWC26a/
         Zr5rEbqfIXVdmeT/UhVG+/Y1NsftbnEIobXgHQx0aCtzEfYxGwzIL/ZcaNTSCbw3ZvFF
         vARAkkxciuQMqxJ0HFdPNBWeGCfpMP5Ue6Uh4TiXuE8pcMxvIeo7XG73+eU0TtS6CQUA
         BuMzs/lxAUxU+vPR3rJ7ojqlUPq7mJ7tltWR88lQ7njdMepPOB3+Vq0zxVMj45x13oXB
         HsR6IseEL/Rpto9MqOjOFFZ38tQG3p6NAkAwcBHBIGaPnXWyItnGf07f2g2Fn4bdPG1t
         1l4w==
X-Gm-Message-State: AO0yUKU0iSKw8+OfnjPqQTdk3iv34a5rcF/7OzP5He8MPm0FNrDWgwTZ
        S3rMgseyeuVqtyx0SfIqMco2GAtvKhM=
X-Google-Smtp-Source: AK7set/pJ8FNLqj0Pc3QwTOZwF3IYw4/vaTp7u7YWQjcRwc9TromfC+/T7xJQRsUcuTi/OXjmLZ+6A==
X-Received: by 2002:a05:6214:27c7:b0:56f:d8:dbb4 with SMTP id ge7-20020a05621427c700b0056f00d8dbb4mr38558809qvb.2.1678398677506;
        Thu, 09 Mar 2023 13:51:17 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b007422fa6376bsm25731qkk.77.2023.03.09.13.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:51:16 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 0/9 v2] Add CIL Deny Rule
Date:   Thu,  9 Mar 2023 16:51:05 -0500
Message-Id: <20230309215114.357831-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is the last RFC patch. Once the notself patches are merged, I will work on
a new set of patches that includes support for notself and other.
 
This series of patches implements a deny rule in CIL. A deny rule will remove
the stated permissions in it from the policy. CIL does this by searching for
allow rules that match the deny rule and then writing new allow rules that
correspond to the matched allow rule with the permissions from the deny rule
removed. The rule uses the same syntax as an allow rule, but with "deny"
instead of "allow".

  (deny SRC TGT (CLASS (PERMS)))

Deny rules are processed during post processing (after the AST is resolved,
but before the binary policy is written). This means that neverallow checking
is done after deny rules are resolved. Deny rules are complimentary to
neverallow checking. When an allow rule is found that matches, a deny rule
removes permissions while a neverallow rule reports an error.

Patch 4 is biggest and most complex since it is the one doing the processing.

Changes for v2
- Renamed cil_tree_remove_node() as cil_tree_node_remove() to fit the naming
  convention in cil_tree.c
- Have cil_tree_node_remove() call cil_tree_node_destroy() to destroy the
  node after it has been removed as suggested by Daniel Burgener.
- Renamed cil_classperms_match() to cil_classperms_match_any()
- Renamed cil_classperms_list_match() cil_classperms_list_match_any()
- Added function cil_classperms_match_all()
- Added function cil_classperms_list_match_all()
- Updated cil_classperms_andnot() to use the cil_classperms_match_any() and
  cil_classperms_list_match_any() functions.
- Added function cil_classperms_and()
- Added function cil_classperms_map_and()
- Added function cil_classperms_set_and()
- Added function cil_classperms_list_and()
- Fixed problem in error handling in cil_create_and_insert_attribute_and_set()
  that was found by Daniel Burgener.
- Fixed problem in error handling in cil_create_attribute_d1_and_not_d2()
  that was found by Daniel Burgener.
- Change cil_create_and_add_avrule() to copy the classperms list, so the
  caller doesn't have to do it.
- Completely changed the logic of cil_remove_permissions_from_rule() to
  eliminate the problem of excessive overlap in the new rules that was
  found by Daniel Burgener.
- Changed and added deny rule tests.
- Fixed the formating problems in the CIL documenation of the deny rule
  that was found by Daniel Burgener.


James Carter (9):
  libsepol/cil: Parse and add deny rule to AST, but do not process
  libsepol/cil: Add cil_list_is_empty macro
  libsepol/cil: Add cil_tree_node_remove function
  libsepol/cil: Process deny rules
  libsepol/cil: Add cil_write_post_ast function
  libsepol: Export the cil_write_post_ast function
  secilc/secil2tree: Add option to write CIL AST after post processing
  secilc/test: Add deny rule tests
  secilc/docs: Add deny rule to CIL documentation

 libsepol/cil/include/cil/cil.h         |    1 +
 libsepol/cil/src/cil.c                 |   68 ++
 libsepol/cil/src/cil_build_ast.c       |   56 ++
 libsepol/cil/src/cil_build_ast.h       |    2 +
 libsepol/cil/src/cil_copy_ast.c        |   19 +
 libsepol/cil/src/cil_copy_ast.h        |    1 +
 libsepol/cil/src/cil_deny.c            | 1132 ++++++++++++++++++++++++
 libsepol/cil/src/cil_deny.h            |   36 +
 libsepol/cil/src/cil_flavor.h          |    1 +
 libsepol/cil/src/cil_internal.h        |   10 +
 libsepol/cil/src/cil_list.h            |    3 +
 libsepol/cil/src/cil_post.c            |    7 +
 libsepol/cil/src/cil_reset_ast.c       |    8 +
 libsepol/cil/src/cil_resolve_ast.c     |   44 +
 libsepol/cil/src/cil_resolve_ast.h     |    1 +
 libsepol/cil/src/cil_tree.c            |   28 +
 libsepol/cil/src/cil_tree.h            |    1 +
 libsepol/cil/src/cil_verify.c          |    9 +
 libsepol/cil/src/cil_write_ast.c       |   10 +
 libsepol/cil/src/cil_write_ast.h       |    1 +
 libsepol/src/libsepol.map.in           |    5 +
 secilc/docs/cil_access_vector_rules.md |   67 ++
 secilc/secil2tree.c                    |    8 +-
 secilc/test/deny_rule_test.cil         |  946 ++++++++++++++++++++
 24 files changed, 2463 insertions(+), 1 deletion(-)
 create mode 100644 libsepol/cil/src/cil_deny.c
 create mode 100644 libsepol/cil/src/cil_deny.h
 create mode 100644 secilc/test/deny_rule_test.cil

-- 
2.39.2

