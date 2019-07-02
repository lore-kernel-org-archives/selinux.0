Return-Path: <SRS0=labB=U7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26A5C06510
	for <selinux@archiver.kernel.org>; Tue,  2 Jul 2019 17:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10FA20989
	for <selinux@archiver.kernel.org>; Tue,  2 Jul 2019 17:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="m7rTfVa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfGBR2u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:28:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43765 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfGBR2u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jul 2019 13:28:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so17705291ljv.10
        for <selinux@vger.kernel.org>; Tue, 02 Jul 2019 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=a0+afBeFhXMaSDxEXuOeB1KzgbW6mX8UltDVbEoXcC0=;
        b=m7rTfVa3GhKeyQ1tRHrfNrMSFYuDu7GJwEl2I8ZuQW275CgGZ1b5kmqwNchjZxNVUz
         Z3/tpQA+vn/rY37OkxEty2h5lfcc4iFSQ+Qvd2H8Y+2kAgKxI6/JH+XbTvbeMEzRhq9H
         6i46/wS7jgLZhBeqCIHIfz8LmkyBBOQ6gLfDUtZ7Qk6vU32G7GhJh1DMVKsFgGX6X4Pv
         oHlmwqRSO8d7E0D6QRwEKbrbhqrl1Gv927x2QrexmySa0Qvz2vQY88xysgBeUTqbUa2O
         jiIIEH4hS6oBddwyzaxlo/aRP8JGqGWD2GTVfgJEDREV5WuHwg/FRlaJGZ8JOb0jxbyJ
         4QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=a0+afBeFhXMaSDxEXuOeB1KzgbW6mX8UltDVbEoXcC0=;
        b=pTPTBBsNGatUu6iomLSQ51lANnKQTpfcHworAXQk4rmhNz8fCCLTxJV8TUg8BR1G+o
         UJHLnebxieKBWhxlDxQXvX5PW61EToTPwQ6EE2z4OCygWhU9vnE0JZdTfCU2ZIWrOarN
         eQ8/D1XrbrDOAzmbIrWlCid5Ga/X0EtMKYBt6cEo9Q6awBbwxn3cr29ttm2638bhrNS4
         Jgr3ibwTxtM+cfKnFJoeOEZc8VCF61n8hgAd45xFaiKaod+m7OOhK9afshPDLYDwnGrU
         cYu4SF4BTFZgx+SABa2IwCd9qQAEFO8479C6HiaPPaLim+yoWLHt9ZI76baP89aRWuGt
         VHIA==
X-Gm-Message-State: APjAAAWonSle9blr1UNAhe8BEdlvSvTNXzjasXJrsajcRCyUU41fcXp9
        k65gwjHNTGuVYycESrvRfNqSJvPpzqr7FZ4CB7tyWUqDRoxD
X-Google-Smtp-Source: APXvYqyJx55tXOysFh5O10sG7PB2CO7dlcMfdmcjMB52mnL5E3vkpkQXx9TgV2Li3nPU5lrlR3PvSldFb+Qu4UAotD0=
X-Received: by 2002:a2e:86c3:: with SMTP id n3mr4206972ljj.129.1562088527957;
 Tue, 02 Jul 2019 10:28:47 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Jul 2019 13:28:37 -0400
Message-ID: <CAHC9VhSERNCM2d42y8fBT236D62mco=B_ZM_vytEoBP1qicvCA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Like the audit PR this is a little early due to some upcoming vacation
plans and uncertain network access while I'm away.  Also like the
audit PR, the list of patches here is pretty minor, the highlights
include:

- Explicitly use __le variables to make sure "sparse" can verify
proper byte endian handling.

- Remove some BUG_ON()s that are no longer needed.

- Allow zero-byte writes to the "keycreate" procfs attribute without
requiring key:create to make it easier for userspace to reset the
keycreate label.

- Consistently log the "invalid_context" field as an untrusted string
in the AUDIT_SELINUX_ERR audit records.

Please pull this once the merge window opens,
-Paul

--
The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

 Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190702

for you to fetch changes up to ea74a685ad819aeed316a9bae3d2a5bf762da82d:

 selinux: format all invalid context as untrusted
   (2019-07-01 16:29:05 -0400)

----------------------------------------------------------------
selinux/stable-5.3 PR 20190702

----------------------------------------------------------------
Nicholas Mc Guire (1):
     selinux: provide __le variables explicitly

Ondrej Mosnacek (2):
     selinux: remove some no-op BUG_ONs
     selinux: fix empty write to keycreate file

Richard Guy Briggs (1):
     selinux: format all invalid context as untrusted

security/selinux/hooks.c       | 11 ++++++-----
security/selinux/ss/ebitmap.c  | 10 ++++++----
security/selinux/ss/services.c | 33 +++++++++++++++++++--------------
3 files changed, 31 insertions(+), 23 deletions(-)

-- 
paul moore
www.paul-moore.com
