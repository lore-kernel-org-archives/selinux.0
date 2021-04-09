Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB05C43461
	for <selinux@archiver.kernel.org>; Fri,  9 Apr 2021 11:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FEA6100B
	for <selinux@archiver.kernel.org>; Fri,  9 Apr 2021 11:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhDILNR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233852AbhDILNQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Apr 2021 07:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617966783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LlwhhPpg7/dsLVztmTdE1jlVBmRFkdvw6ZvqHL4cSJY=;
        b=HoTHzA3xvJh3OJhJ1nh2rQsUTRG2B4iHTFdeecrqp6HvhRMfufgCBIzDB5t5Gu0cgfBZx1
        hNhWswdJyLp8dCWHbvZOj6DZI2H8sYaagv6Z164kIUDdqGulEbECk5+RfbadOgx2iXPOQN
        2GaH6lsRDDUAP+4DdzhWKIW5cEerP/0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-6-7mUCTzPF2L7rf3aRDmWQ-1; Fri, 09 Apr 2021 07:13:00 -0400
X-MC-Unique: 6-7mUCTzPF2L7rf3aRDmWQ-1
Received: by mail-ej1-f71.google.com with SMTP id gv58so2040918ejc.6
        for <selinux@vger.kernel.org>; Fri, 09 Apr 2021 04:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlwhhPpg7/dsLVztmTdE1jlVBmRFkdvw6ZvqHL4cSJY=;
        b=KBPa7g506WVGFIKE8c57IxOjycoZOxCL8BhTm7BBTvwWPfNc9a+b6mc3qytOTrVJrR
         tDJBYGsRZgnBhYpFSgHuFqhqGFhkW+4XjH4cFjBlP0mJuRNrIryyWQ/NwN+fQDcRai/n
         XlRhHDOIln1V8dVhWHB1UGA2N2LWohde/+Gpa9Nzyr7A9uW22mm1z1w4IrbhoISTfgA3
         /b9cqeNjxxiC/0Hn8WgmnOhB42A1vtWk/40psDzegIONGTo7N7jH4fLsEE0Czmj4Y/lh
         IFELtOKu51XjV2RDedwcPNxy6dDfXDNyZbeGwAwEshXlf5kfYkMLIABixNBg1EDUYnyX
         zYdw==
X-Gm-Message-State: AOAM532V7r1QA2NoBALnZ0SOvQbH8FX99xuk+rAkG1+MTiabRQxAOT++
        s7E8Swi2TXlLSYtYxz2D9d5XgdGq4K7Y6EM0oQHk9GwrrSk7meMvJG/IQhx5V6b8IOAyrAvDACE
        9GLZIJ5U07uxQ4GV1qw==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr16886098edj.178.1617966778459;
        Fri, 09 Apr 2021 04:12:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9DN2Sw6T+TRJMgdrKflu/6Pq2gsJ2XI7RSTKrE+UZAOitmzvCa6P+n4y7usKpGVJqkST9ag==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr16886085edj.178.1617966778324;
        Fri, 09 Apr 2021 04:12:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id w18sm1046854ejq.58.2021.04.09.04.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:12:57 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/2] vfs/security/NFS/btrfs: clean up and fix LSM option handling
Date:   Fri,  9 Apr 2021 13:12:52 +0200
Message-Id: <20210409111254.271800-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series attempts to clean up part of the mess that has grown around
the LSM mount option handling across different subsystems.

The original motivation was to fix a NFS+SELinux bug that I found while
trying to get the NFS part of the selinux-testsuite [1] to work, which
is fixed by patch 2.

The first patch paves the way for the second one by eliminating the
special case workaround in selinux_set_mnt_opts(), while also
simplifying BTRFS's LSM mount option handling.

I tested the patches by running the NFS part of the SELinux testsuite
(which is now fully passing). I also added the pending patch for
broken BTRFS LSM options support with fsconfig(2) [2] and ran the
proposed BTRFS SELinux tests for selinux-testsuite [3] (still passing
with all patches).

[1] https://github.com/SELinuxProject/selinux-testsuite/
[2] https://lore.kernel.org/selinux/20210401065403.GA1363493@infradead.org/T/
[3] https://lore.kernel.org/selinux/20201103110121.53919-2-richard_c_haines@btinternet.com/
    ^^ the original patch no longer applies - a rebased version is here:
    https://github.com/WOnder93/selinux-testsuite/commit/212e76b5bd0775c7507c1996bd172de3bcbff139.patch

Ondrej Mosnacek (2):
  vfs,LSM: introduce the FS_HANDLES_LSM_OPTS flag
  selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount

 fs/btrfs/super.c         | 35 ++++++-----------------------------
 fs/nfs/fs_context.c      |  6 ++++--
 fs/super.c               | 10 ++++++----
 include/linux/fs.h       |  3 ++-
 security/selinux/hooks.c | 32 +++++++++++++++++---------------
 5 files changed, 35 insertions(+), 51 deletions(-)

-- 
2.30.2

