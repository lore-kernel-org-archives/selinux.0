Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ACFC433FE
	for <selinux@archiver.kernel.org>; Mon,  1 Nov 2021 23:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00F760F45
	for <selinux@archiver.kernel.org>; Mon,  1 Nov 2021 23:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhKBABt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhKBABs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Nov 2021 20:01:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E00C061714
        for <selinux@vger.kernel.org>; Mon,  1 Nov 2021 16:59:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g10so69474814edj.1
        for <selinux@vger.kernel.org>; Mon, 01 Nov 2021 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=K4EseFA8vx94o+u4jK5p4o6Cj7+9NdZWBd6x9LbNad0=;
        b=gJqk0PamyixZx3d1yZSh05INbMWIXicy/Uv5Hq38C14kH+jd5v9JOW+Ix5MgMoj8pE
         QGt1Zd+zKIYAXqJKCs/JhS2wNSPWdoBBknaAbrTGxaDITUHVkNzkOyVJznhbWrmX+MSn
         vSJJbqfB+kJwf9VhSZS/ZNAwYBy27iR7H8YE5u/r1BZ66sT87uQqWLDMsGH85kicPNoD
         7PsjOnX5jYxrrN1mM6Q+IWdJId2w/ufik/xKOOH+TSctN747o5fsfpIkKp/B++XTmZoH
         gQLBGidwWGTjtmFqvTmAhjwiWwjP0UnmBnRUXGsQ37ddgkvw4NF3zjtX89GtVtj+hPjH
         2iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=K4EseFA8vx94o+u4jK5p4o6Cj7+9NdZWBd6x9LbNad0=;
        b=1J2RGFHGv1LF9/YwRgEuSt5gzHAYP1Ui7R9WLOt2+3eKDz8JJxUwo9bU/sY9Z+t59g
         TltW5/qok74JiNDAQZfjBO3lxsqhPCzp69sm0YJP4XWYPRGoibwrQyVEwaSLOyBYVr9l
         gbtLIjd3CzaFHOx8XbvPVk2xibmt4pVCaus6YY3mXgp4LE1yqhbaTj1OVQF6/EoejmvG
         TTIgfpV8UEhCoimInZenukU7bzFseO0rlXqLkc49L3ezqMtfjHB3Wcs2RjKhI64x4hGa
         2q5Ff6dUqkDPH0dvQnStl4IrrQg395OUeSBZEwLQSlKAfgBD1XSCihWeuFalpDQqcDE8
         u+jA==
X-Gm-Message-State: AOAM531pCml9CIgUJCzWD72uGYZe8SYnFbbJVjhoizh35KvSUxgjjVok
        FTt0wrPZh3Q/SLAVYsCGzQWx+Ts4/4q+KiNLaoc47G3K6WN2
X-Google-Smtp-Source: ABdhPJy2n5zGlLinbMjNWj29hh72LjbTuOfDbCdwOCGz/QxNd5GXExoKeDPtm6Pv66ojSfK+AaXF98ozLoKRGetuT1k=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr20818871ejc.126.1635811153258;
 Mon, 01 Nov 2021 16:59:13 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Nov 2021 19:59:02 -0400
Message-ID: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Below is the SELinux pull request for v5.16 with a note about merge
conflicts following the highlight reel (you'll see something similar
on the audit pull request, and hopefully the io_uring and block/dm
trees but I have no idea if they track the LSM/audit work - likely
not).

** Highlights

- Add LSM/SELinux/Smack controls and auditing for io-uring.  As usual,
the individual commit descriptions have more detail, but we were
basically missing two things which we're adding here: establishment of
a proper audit context so that auditing of io-uring ops works
similarly to how it does for syscalls (with some io-uring additions
because io-uring ops are *not* syscalls), additional LSM hooks to
enable access control points for some of the more unusual io-uring
features, e.g. credential overrides.  The additional audit callouts
and LSM hooks were done in conjunction with the io-uring folks, based
on conversations and RFC patches earlier in the year.

- Fixup the binder credential handling so that the proper credentials
are used in the LSM hooks; the
commit description and the code comment which is removed in these
patches are helpful to understand the background and why this is the
proper fix.

- Enable SELinux genfscon policy support for securityfs, allowing
improved SELinux filesystem labeling for other subsystems which make
use of securityfs, e.g. IMA.

** Merge Notes

- I'm expecting three trees to add new audit record types during this
merge window: SELinux, block/device-mapper, and audit.  I've already
talked with the different maintainers and there shouldn't be any
duplicated values, but I expect you will see some merge conflicts in
include/uapi/linux/audit.h; the "correct" values should end up as:

  +#define AUDIT_URINGOP   1336 /* io_uring operation */
  +#define AUDIT_OPENAT2   1337 /* Record showing openat2 how args */
  +#define AUDIT_DM_CTRL   1338 /* Device Mapper target control */
  +#define AUDIT_DM_EVENT  1339 /* Device Mapper events */

- Based on your tree from this afternoon you will see a merge conflict
in fs/io-wq.c, but it's just an include collision, the fixup is
trivial.

- Based on your tree from this afternoon you will see a merge conflict
in fs/io_uring.c in the io_op_def struct definition; the fixup is also
pretty easy, just make sure the "audit_skip" field is added to the
struct.

Thanks,
-Paul

--
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f=
:

 Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20211101

for you to fetch changes up to 15bf32398ad488c0df1cbaf16431422c87e4feea:

 security: Return xattr name from security_dentry_init_security()
   (2021-10-20 08:17:08 -0400)

----------------------------------------------------------------
selinux/stable-5.16 PR 20211101

----------------------------------------------------------------
Casey Schaufler (1):
     Smack: Brutalist io_uring support

Christian G=C3=B6ttsche (1):
     selinux: enable genfscon labeling for securityfs

Florian Westphal (1):
     selinux: remove unneeded ipv6 hook wrappers

Kees Cook (1):
     LSM: Avoid warnings about potentially unused hook variables

Ondrej Mosnacek (1):
     selinux: fix race condition when computing ocontext SIDs

Paul Moore (11):
     audit: prepare audit_context for use in calling contexts beyond syscal=
ls
     audit,io_uring,io-wq: add some basic audit support to io_uring
     audit: add filtering for io_uring records
     fs: add anon_inode_getfile_secure() similar to anon_inode_getfd_secure=
()
     io_uring: convert io_uring to the secure anon inode interface
     lsm,io_uring: add LSM hooks to io_uring
     selinux: add support for the io_uring access controls
     selinux: remove the SELinux lockdown implementation
     selinux: make better use of the nf_hook_state passed to the NF hooks
     selinux: fix all of the W=3D1 build warnings
     selinux: fix a sock regression in selinux_ip_postroute_compat()

Todd Kjos (3):
     binder: use euid from cred instead of using task
     binder: use cred instead of task for selinux checks
     binder: use cred instead of task for getsecid

Vivek Goyal (1):
     security: Return xattr name from security_dentry_init_security()

drivers/android/binder.c            |  27 +--
drivers/android/binder_internal.h   |   4 +
fs/anon_inodes.c                    |  29 +++
fs/ceph/xattr.c                     |   3 +-
fs/io-wq.c                          |   4 +
fs/io_uring.c                       |  69 +++++-
fs/nfs/nfs4proc.c                   |   3 +-
include/linux/anon_inodes.h         |   4 +
include/linux/audit.h               |  26 ++
include/linux/lsm_hook_defs.h       |  22 +-
include/linux/lsm_hooks.h           |  30 ++-
include/linux/security.h            |  55 +++--
include/uapi/linux/audit.h          |   4 +-
kernel/audit.h                      |   7 +-
kernel/audit_tree.c                 |   3 +-
kernel/audit_watch.c                |   3 +-
kernel/auditfilter.c                |  15 +-
kernel/auditsc.c                    | 468 +++++++++++++++++++++++++-----
security/security.c                 |  35 ++-
security/selinux/avc.c              |  13 +-
security/selinux/hooks.c            | 239 +++++++-----------
security/selinux/include/classmap.h |   4 +-
security/selinux/netlabel.c         |   7 +-
security/selinux/netport.c          |   2 +-
security/selinux/ss/hashtab.c       |   1 +
security/selinux/ss/mls.c           |   4 +
security/selinux/ss/services.c      | 176 +++++++-------
security/smack/smack_lsm.c          |  46 ++++
28 files changed, 882 insertions(+), 421 deletions(-)

--=20
paul moore
www.paul-moore.com
