Return-Path: <SRS0=/sJJ=RP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC084C43381
	for <selinux@archiver.kernel.org>; Tue, 12 Mar 2019 23:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B43C2087C
	for <selinux@archiver.kernel.org>; Tue, 12 Mar 2019 23:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DbCsVLRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfCLXND (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:13:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42628 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfCLXND (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Mar 2019 19:13:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id p1so30243lfk.9
        for <selinux@vger.kernel.org>; Tue, 12 Mar 2019 16:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kv+IpuE8uhKkAeCRq+EUgrdWk4JSgDpUpl0p5lmX99c=;
        b=DbCsVLRI7Rzb1qFJBmylu0TkkOCC0GrWU42XnTvHdfNKGun6F/S5sJ7BSIr5gCFBg7
         b0Np6SdkzlbqQrFpuDIKhyR9YaAw0abSVFjyITC0HswDuQuNOHtckwszyiAXGWsN2fqA
         ZhMcQBzj0w9C4hmh7wZHgFe5mmLHPDjbNyjAgxGx3pfvNwPGXMlgWhFFpuJHwsjdsasE
         sFbveHhYK/tfmTxgOU3k5ipnf3G0AeAxsG1Ns2Qf59qWQHuFBYqdXLTiEQrBg3Wq/8PM
         1iAtYQHuPtJM6iyz4yQvQ41LojtAWQeU4WZm8qlpeSDQqEaH+y6v940Sw5YudnGTjJ5C
         nfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kv+IpuE8uhKkAeCRq+EUgrdWk4JSgDpUpl0p5lmX99c=;
        b=U1FxpBFNAcUcn6g+xt2vLQtLY/LQbh4+6Vb8cScjNFuTCZkpFqqJCagDb3B074vOGF
         YvfmCZocOv348X+bEz6umlfSXsuK5sZ04uFLPybaivbUgxJ/0Tit4zlLC9QeJX7cUBB2
         PuGeDN4oUZB75IsIUkToCZhmIZdE9saU+cOmEQ95uANdhgvntVbDFa3aNN4yw6uThmw8
         vhacUrs823OXVwQhNTMXV7lfmsAk4tESpJ5jGrp+bVYSB2BWTVZWMgjL4LE79UxJXPJg
         y+l7eokUQI+q837V9/dAhCONSUI/kf0R0Cc9jmTkWSSh26p0Vi2bxhUvl9I2xd7yGrzI
         q9Og==
X-Gm-Message-State: APjAAAWRJJkOTOgiEWbI9lXRb9eyOixV1gz8WEpU7KLAWheZeHAD6hN7
        WMQPJgzHi/bNW4s7VhvUeXLDOi3I+MLBd0aXDa8V
X-Google-Smtp-Source: APXvYqzpQxT+BBNyzwnOKQ3hXZ2wyAi5055PXgoi8dlhpluTarvFUAV4NSC4tnwEFJ6OVlGudllaz3nRHtuEME3QcPs=
X-Received: by 2002:ac2:42da:: with SMTP id n26mr15461113lfl.91.1552432380824;
 Tue, 12 Mar 2019 16:13:00 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Mar 2019 19:12:50 -0400
Message-ID: <CAHC9VhTNWou2axPZ5SeCD0pML_r6=r1Wok1U=ggONUR14O+mQw@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.1 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Two small fixes for SELinux in v5.1: one adds a buffer length check to
the SELinux SCTP code, the other ensures that the SELinux labeling for
a NFS mount is not disabled if the filesystem is mounted twice.
Please pull for v5.1-rc1.

Thanks,
-Paul

--
The following changes since commit 45189a1998e00f6375ebd49d1e18161acddd73de:

 selinux: fix avc audit messages (2019-02-05 12:34:33 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190312

for you to fetch changes up to 3815a245b50124f0865415dcb606a034e97494d4:

 security/selinux: fix SECURITY_LSM_NATIVE_LABELS on reused superblock
   (2019-03-11 16:13:17 -0400)

----------------------------------------------------------------
selinux/stable-5.1 PR 20190312

----------------------------------------------------------------
J. Bruce Fields (1):
     security/selinux: fix SECURITY_LSM_NATIVE_LABELS on reused superblock

Xin Long (1):
     selinux: add the missing walk_size + len check in
              selinux_sctp_bind_connect

security/selinux/hooks.c | 8 +++++++-
1 file changed, 7 insertions(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
