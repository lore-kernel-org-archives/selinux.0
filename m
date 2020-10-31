Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25752C388F7
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC0520724
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQrGIiBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgJaL4K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 07:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727028AbgJaL4K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 07:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604145368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aWO8fIupEbNo0p6i9n93Cvrg5czHemHOdjZ1afjjEkk=;
        b=gQrGIiBxEqowoc6I5P95g+xgRx5KAyXQjMKSrbHf4PaTFACZt3+tWP3emUE0XKv74LnARU
        3NGnqh6USSaYQ1/L+r93sCrm2rxadD/d/cfpnq07RWLA+KJM0IWFiPU5BerSECUyS1AkQT
        gjvgnwtkvw1Eyv+EyckcdSCep9iQX6Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-vYlb8ScNNyKbku3RGvgLsQ-1; Sat, 31 Oct 2020 07:56:05 -0400
X-MC-Unique: vYlb8ScNNyKbku3RGvgLsQ-1
Received: by mail-ej1-f71.google.com with SMTP id p18so3222059ejl.14
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 04:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWO8fIupEbNo0p6i9n93Cvrg5czHemHOdjZ1afjjEkk=;
        b=VIDnFYrGy5JOZRUWZdk3uvuBJj/JJAIfZ56q+3+3NCORTejRPCDKE3RK3BEx97wnTe
         yBaraQuXmg8JvKG3EGetEe1CPOYoNuj/8l2WMdHbquVSnSN2Z4uY9FHmOmnSGmWEGtKv
         GjI7S/v/yrrExZqEXAibWSuhraH0B5aM2W42kDZCjT2scVU0LCyituc/03CJKtO020cG
         mPWm0X4psmbM2MeNpFORG2e2sQV5b1oDGhXnqngLGjIax34a8WZ3QqkXFP86x9/gN0zg
         6vkpz/0+eqf/2hMe0HwfOJvuga444y/Uy+j9zycfSxEYocBwJRDme2X7FXDuRw/7nVNB
         mwXw==
X-Gm-Message-State: AOAM530XYZrC8GIhxZnTgXSjuHc5KFKEMDAnz8WaeqLT6Hk0CsXjaGD4
        EEUlGBl2gyNgMwLCNxAJFKz/gTdEqQN90ymXq8BfYnUWr/tJ3TlYPpNRI4DxR86lZ1+Y4QmoHQ0
        +gpdfCfiBy776med10A==
X-Received: by 2002:a17:906:134e:: with SMTP id x14mr6801350ejb.173.1604145363815;
        Sat, 31 Oct 2020 04:56:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQujCE7DHaT/ki2ec7uFpHb+1cOAQw3ib4b+Khxe9rMxPn0yD5DiDjW01Sl/3+/AO7JxhYig==
X-Received: by 2002:a17:906:134e:: with SMTP id x14mr6801335ejb.173.1604145363588;
        Sat, 31 Oct 2020 04:56:03 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id y14sm4770746edo.69.2020.10.31.04.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 04:56:03 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite 0/3] Test all filesystems by default
Date:   Sat, 31 Oct 2020 12:55:58 +0100
Message-Id: <20201031115601.157591-1-omosnace@redhat.com>
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
required mkfs.* programs and fixes the mkfs.* invocation to not get
stuck when testing jfs.

Note: The F32 CI will start failing after this and the kernel update
patches are merged (the old kernel on the image doesn't have the XFS
quota fix). It will be necessary to bump the stable Fedora testing to
F33.

Ondrej Mosnacek (3):
  README,travis: add e2fsprogs, jfsutils, and dosfstools to deps
  tests/filesystem: pipe "yes" to mkfs.* to fix jfs test
  tests/[fs_]filesystem: test all filesystems

 README.md                      |  6 ++++++
 tests/Makefile                 |  8 ++++++--
 tests/filesystem/Filesystem.pm |  2 +-
 tests/filesystem/ext4          |  1 +
 tests/filesystem/jfs           |  1 +
 tests/filesystem/test          | 14 ++++++++++++--
 tests/filesystem/vfat          |  1 +
 tests/filesystem/xfs           |  1 +
 tests/fs_filesystem/ext4       |  1 +
 tests/fs_filesystem/jfs        |  1 +
 tests/fs_filesystem/test       | 14 ++++++++++++--
 tests/fs_filesystem/vfat       |  1 +
 tests/fs_filesystem/xfs        |  1 +
 travis-ci/run-testsuite.sh     |  3 +++
 14 files changed, 48 insertions(+), 7 deletions(-)
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

