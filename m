Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705BEE728DE
	for <selinux@archiver.kernel.org>; Fri, 29 Sep 2023 19:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjI2T4e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Sep 2023 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjI2T4d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Sep 2023 15:56:33 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED21B5
        for <selinux@vger.kernel.org>; Fri, 29 Sep 2023 12:56:30 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7741c5bac51so828982585a.1
        for <selinux@vger.kernel.org>; Fri, 29 Sep 2023 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696017389; x=1696622189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=byqpavbILXZ6Lw1C5pRdfybb7UXiJOp5Qjs56r7yTuU=;
        b=bXhdMS+ngyFQsBkvcmV7b+wpeE96OaPcv6n5yQFhx7ViS43FLfDhwGUjGxG825ZXFM
         7QLhW6c+Zl53xYezbJQ5Qlefhav5lWQuex8hG8k3Sd/kjhvPkfrSnAgFj0XpmWKUrINR
         AJw3e9IWQ6ziFh6ReNfcCqhK7BlKhMPk2t8RbZEWtsUp2Ui1hyfbR9FOgCOF0uFdwXw4
         NsKi6+dr/3MyIGn3cDAtkD/RVpzJbE+dYVg+OYTdFSgiOlmNde7LKAUp70gRZ3/assNH
         vPAObenZ5nxmptiNqyg/0h71TyouHpDfBOROz1pl1rcWmlySRYa04HqbwHEcos4MnEhR
         XPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696017389; x=1696622189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byqpavbILXZ6Lw1C5pRdfybb7UXiJOp5Qjs56r7yTuU=;
        b=e084h9gDeXBi5IsFIIT4fGiny+9UHjtaKjdIDsARXVIsGGdn4n3fJLIk+jNg8BwCIr
         yAgHw/m+myg3ow7+kUzHqTgSD7YyYfLHv9paVWA2R9uVCkwhpXN2guA4PYK1uM+3I8Sl
         wmylyus0omrMG2SHZRG6isD5SoqK9IofagPhIK3sHJ0ooF4gtkneFYp6OAMasSF7BPQ3
         zd6d6rIyAjAq9CqUK3OJYRWAFaueKDgJOxYfAXg5xYoAfON3p5RKIhRgcxN+8nxWJzoW
         7+mQ59ENqzKosTdJukqofrit3Jk1PaotEzOnkIcrx+q0QnIZsgMX0fVpznMXxft+Xkwj
         uFcQ==
X-Gm-Message-State: AOJu0YzNh5V1Uq1Vj19jFYGVHwbYFIxVHjviw4ZEZlYrYL5GGttNVQST
        xs51LQndwpxSo1fn5MsDciCHDLg1Aik=
X-Google-Smtp-Source: AGHT+IHh2MSU5FTKlv04NYJzM/P/InqFuUYM0A4jzSPAMbo/9VirPi44TwWmnaC3eC1qZw13nhFaTw==
X-Received: by 2002:a05:620a:f05:b0:76f:19fd:5064 with SMTP id v5-20020a05620a0f0500b0076f19fd5064mr5238234qkl.33.1696017388836;
        Fri, 29 Sep 2023 12:56:28 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a034600b00767e98535b7sm5795291qkm.67.2023.09.29.12.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:56:28 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v2 0/4] selinux: avtab arrays and refactors
Date:   Fri, 29 Sep 2023 19:56:11 +0000
Message-ID: <20230929195617.65120-1-jsatterfield.linux@gmail.com>
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
was a good target for optimizations. Running "perf record" on the
"load_policy" command shows that a majority of time is spent adding
rules into the avtab.

This patch series is an at optimizing these hot spots within the
security server implementation to help it scale with  additional rules
in the future.

All patches are independent of each other.

Patches 1-3 are a series of refactors of the internal avtab.c
interfaces and code paths with no logic changes. It removes duplicative
code and homogenizes access patterns.

Patch 4 changes avtab to use arrays instead of a kmem_cache for
individual nodes of the hastable.

Jacob Satterfield (4):
  selinux: simplify avtab_insert_node() prototype
  selinux: refactor avtab_node comparisons
  selinux: avtab iteration macros
  selinux: use arrays for avtab hashtable nodes

 security/selinux/ss/avtab.c       | 206 ++++++++++++++----------------
 security/selinux/ss/avtab.h       |   4 +-
 security/selinux/ss/conditional.c |  37 ++++--
 security/selinux/ss/conditional.h |   2 +-
 4 files changed, 123 insertions(+), 126 deletions(-)

-- 
2.41.0

