Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90294C00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3236A206DC
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYZI6pr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgKBIfX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 03:35:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727806AbgKBIfX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 03:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604306122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YOmxD0d1jlnY7ox1hLMLjRKTSJbcFjuHDIY9ZfpjcdA=;
        b=BYZI6pr8uebkBvPtzoVMCcGFF47qDC/pNALAl1zePQRNOkjhd21PYQXFpxPPUkOfTMOYPp
        xBSQCR75GOXJTVYEx3DK6xO10wEEX4EBaBIbWx3vnp9zGWdSxHPQAiHPjfQBiK3rLV/ze/
        Mm9eyYb9D3OVs+EOD1czF+J7w9c0QH4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-uy-f6hINNHSCpGPdCCIWCw-1; Mon, 02 Nov 2020 03:35:20 -0500
X-MC-Unique: uy-f6hINNHSCpGPdCCIWCw-1
Received: by mail-ej1-f69.google.com with SMTP id dx19so3438710ejb.7
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 00:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOmxD0d1jlnY7ox1hLMLjRKTSJbcFjuHDIY9ZfpjcdA=;
        b=Szpse6TuIBy+Q68AJ4fYnKUhrCBuGGV/6pKlqhOq+e3Q34hmAcKWtVdPvz71L8DgsX
         TGWnmrH/uUxmPnbN/+szcFVc/2+sEU0IK5BMMTIVViAt4XMcBbo97pnjW0SYdDXIGBP5
         aFgwrD70oTEHcEVURcbno75OjLDn+8xGfZXa6yFH1OBug/gRSbNaBJHJbjrxPefuMGiC
         ojHZtRADYRLC2Rq9GdxbFgPNgGXxNUcmuSCa+mhvOW0tfaIV825WFmWkP+PL7rG95+zl
         q8Gf4zDN5R7PRgwqIkTtffPe020jPz7lSK3lAk2KExSS0wIkVaChLonR68PIcWOc6U9b
         NJ7w==
X-Gm-Message-State: AOAM530989Y6SQzSpjRDU2svk7Jion09CU0I2K+ihQktBi1i5dl4Y0t2
        m5ovGQz1RUVFtwPcE+qLdyDbMgFAGlmhaEFSMsrwqvp9Yc5Bw3ZSLdn5wKtyxNlITEnC9Fu8KQZ
        FTqGFj0K1PNKSa4cZiQ==
X-Received: by 2002:a05:6402:2292:: with SMTP id cw18mr15868540edb.112.1604306119245;
        Mon, 02 Nov 2020 00:35:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUJTI8idoJMFF/hZ5WILQ5g6W7AJ2gekaR1qFmg3kVDxFbvTeuGizdSHil6BB+ZPh0nK1M4w==
X-Received: by 2002:a05:6402:2292:: with SMTP id cw18mr15868527edb.112.1604306119017;
        Mon, 02 Nov 2020 00:35:19 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id bk13sm9293716ejb.58.2020.11.02.00.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:35:18 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite v2 0/4] Test all filesystems by default
Date:   Mon,  2 Nov 2020 09:35:12 +0100
Message-Id: <20201102083516.477149-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series enables testing all filesystems currently supported by the
testsuite (ext4, xfs, jfs, vfat) using the [fs_]filesystem subtests
without the need to run the tests manually or move to a different
filesystem. The filesystems not available on the tested kernel are
automatically excluded.

The series also updates dependencies with the packages containing the
required mkfs.* programs, fixes the mkfs.* invocation to not get stuck
when testing jfs, and fixes error output appearing during a successful
vfat test.

Note: The F32 CI will start failing after this and the kernel update
patches are merged (the old kernel on the image doesn't have the XFS
quota fix). It will be necessary to bump the stable Fedora testing to
F33.

v2 changes:
 - added a patch to fix the vfat tests output
 - fixed behavior when fs tests are executed directly
 - simplified the code changed/added by the last patch

Ondrej Mosnacek (4):
  README,travis: add e2fsprogs, jfsutils, and dosfstools to deps
  tests/filesystem: pipe "yes" to mkfs.* to fix jfs test
  tests/[fs_]filesystem: fix unwanted error output when testing vfat
  tests/[fs_]filesystem: test all filesystems

 README.md                      |  6 ++++
 tests/Makefile                 |  8 +++--
 tests/filesystem/Filesystem.pm |  2 +-
 tests/filesystem/ext4          |  1 +
 tests/filesystem/jfs           |  1 +
 tests/filesystem/test          | 58 +++++++++++++++---------------
 tests/filesystem/vfat          |  1 +
 tests/filesystem/xfs           |  1 +
 tests/fs_filesystem/ext4       |  1 +
 tests/fs_filesystem/jfs        |  1 +
 tests/fs_filesystem/test       | 64 ++++++++++++++++------------------
 tests/fs_filesystem/vfat       |  1 +
 tests/fs_filesystem/xfs        |  1 +
 travis-ci/run-testsuite.sh     |  3 ++
 14 files changed, 83 insertions(+), 66 deletions(-)
 create mode 120000 tests/filesystem/ext4
 create mode 120000 tests/filesystem/jfs
 create mode 120000 tests/filesystem/vfat
 create mode 120000 tests/filesystem/xfs
 create mode 120000 tests/fs_filesystem/ext4
 create mode 120000 tests/fs_filesystem/jfs
 create mode 120000 tests/fs_filesystem/vfat
 create mode 120000 tests/fs_filesystem/xfs

-- 
2.26.2

