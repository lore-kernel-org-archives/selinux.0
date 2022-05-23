Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B6C433F5
	for <selinux@archiver.kernel.org>; Mon, 23 May 2022 14:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiEWONU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 May 2022 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbiEWONU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 May 2022 10:13:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2201F48319
        for <selinux@vger.kernel.org>; Mon, 23 May 2022 07:13:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso6856549wmn.4
        for <selinux@vger.kernel.org>; Mon, 23 May 2022 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=wMd3MAVGTEWvLDECRQj4k5EQPlSx82n3nZY69Crfbkk=;
        b=p2KwDuenh3ZqtcMrAp2PcV50hZl16VaDpOUHQfDrGTKFZo+sBapEL/vCFhO0fUJI00
         2Gl33276R5kI/N/lATZXOvvaFKLG5EtAPp1YqX0WIkTYmo8A2HpkBQNULEQeoCLHjyEi
         CyGVdO+Spun3Fqzf3KcuqElqI5Phplf0f+nX2gRVrak35ZFX9pVhrhy+nvALMxN/0YcF
         Qi9hzvZgeoBLkXtP4DBCJehmuMgNVbXVAG4ZF7fKuCg7fnllo/mb/WU9CQ7PMB9qxcUw
         yVHLHPY8cuagGCiNtk+wjbDfpJN+zW6m0ykAPjS4no+aK+Ni8qQh8ZuHe4QNKBoAvSAr
         xBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=wMd3MAVGTEWvLDECRQj4k5EQPlSx82n3nZY69Crfbkk=;
        b=w+K3Tr381p6fUHw8D/tBTgjFwhYb8faSIHzTrH7Kx5yU0qM62GaKm/w/PMJzeQuUin
         v6KoZJJETP+WO+VzSHcPDfO2dDHC6Clu2BFV7ipxvHQ1/ubRwbVm1sQvoazG68C7ZsrP
         /3SKzjZZy4iN0MJVAhH4dRVKAVImTQ4F6U5Ln3tABjQVPCI7ZqzG0BmB3TrzFsE8Wxom
         lAkeProMSiIiWNXvEHXBUOaEK6xmOTNuc1L+3mpYviCqoSQ2OJfqfkgHJFSVnsy0F4ip
         2HtOipQGqoWy9WYvozEOgJQhLLz+ysT3Lh9IpD5oqIJ1MaYhvDLXp6pKQ8CKwNqVlW94
         VxZw==
X-Gm-Message-State: AOAM5304wDwPh43Mdlf7lw0fHOCsJNKO3BY9SF1VZOpaumQ3MaV4KNSS
        BsvEddY9o/7xX53vm9YQH3fIfRw6ULKY7cnslZo/
X-Google-Smtp-Source: ABdhPJwWjOXbK0Xh4wF+Je/K9mbXv1GGVKfDI7BUiK8RXyiuAS+iMDEoxi0ZDPvFouhLymQvkgFVCtXkHM0ao9xLxGw=
X-Received: by 2002:a7b:ce8a:0:b0:397:37c9:254a with SMTP id
 q10-20020a7bce8a000000b0039737c9254amr15349128wmj.96.1653315194616; Mon, 23
 May 2022 07:13:14 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 May 2022 10:13:04 -0400
Message-ID: <CAHC9VhTFMrc3yRiQ=fnw0-qWCTuUcH3iD1txSvLUh71WFsLrFw@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Linus,

We've got twelve patches queued for v5.19, with most being fairly
minor.  The highlights are below:

- The checkreqprot and runtime disable knobs have been deprecated for
some time with no active users that we can find.  In an effort to move
things along we are adding a pause when the knobs are used to help
make the deprecation more noticeable in case anyone is still using
these hacks in the shadows.

- We've added the anonymous inode class name to the AVC audit records
when anonymous inodes are involved.  This should make writing policy
easier when anonymous inodes are involved.

- More constification work.  This is fairly straightforward and the
source of most of the diffstat.

- The usual minor cleanups: remove unnecessary assignments, assorted
style/checkpatch fixes, kdoc fixes, macro while-loop encapsulations,
#include tweaks, etc.

Please merge for v5.19.
-Paul

--
The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17=
:

 Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20220523

for you to fetch changes up to 1af0e4a0233fea7e8226cb977d379dc20f9bbe11:

 security: declare member holding string literal const
   (2022-05-13 14:51:06 -0400)

----------------------------------------------------------------
selinux/stable-5.19 PR 20220523

----------------------------------------------------------------
Christian G=C3=B6ttsche (8):
     selinux: resolve checkpatch errors
     selinux: update parameter documentation
     selinux: avoid extra semicolon
     selinux: include necessary headers in headers
     selinux: fix indentation level of mls_ops block
     selinux: declare data arrays const
     selinux: log anon inode class name
     security: declare member holding string literal const

Michal Orzel (1):
     selinux: Remove redundant assignments

Paul Moore (3):
     selinux: runtime disable is deprecated, add some ssleep() discomfort
     selinux: checkreqprot is deprecated, add some ssleep() discomfort
     selinux: don't sleep when
              CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE is true

include/linux/lsm_audit.h                        |  2 +
include/linux/lsm_hooks.h                        |  4 +-
scripts/selinux/genheaders/genheaders.c          | 75 ++++++++++++--------
scripts/selinux/mdp/mdp.c                        |  4 +-
security/lsm_audit.c                             |  3 +
security/security.c                              |  2 +-
security/selinux/avc.c                           |  6 +-
security/selinux/hooks.c                         |  9 +--
security/selinux/include/audit.h                 |  5 +-
security/selinux/include/avc.h                   |  1 +
security/selinux/include/avc_ss.h                |  4 +-
security/selinux/include/classmap.h              |  2 +-
security/selinux/include/ibpkey.h                |  2 +
security/selinux/include/initial_sid_to_string.h |  3 +-
security/selinux/include/netnode.h               |  2 +
security/selinux/include/netport.h               |  2 +
security/selinux/include/policycap.h             |  2 +-
security/selinux/include/policycap_names.h       |  2 +-
security/selinux/include/security.h              |  4 ++
security/selinux/include/xfrm.h                  |  2 +
security/selinux/nlmsgtab.c                      | 12 ++--
security/selinux/selinuxfs.c                     |  8 ++-
security/selinux/ss/avtab.c                      | 20 +++----
security/selinux/ss/policydb.c                   | 36 +++++-------
security/selinux/ss/services.c                   | 47 ++++++++-------
25 files changed, 144 insertions(+), 115 deletions(-)

--=20
paul-moore.com
