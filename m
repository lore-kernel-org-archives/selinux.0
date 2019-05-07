Return-Path: <SRS0=AGaA=TH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B234C004C9
	for <selinux@archiver.kernel.org>; Tue,  7 May 2019 17:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D62B205ED
	for <selinux@archiver.kernel.org>; Tue,  7 May 2019 17:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HTAWHY9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEGRXQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 May 2019 13:23:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44734 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfEGRXQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 May 2019 13:23:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id e13so466178ljl.11
        for <selinux@vger.kernel.org>; Tue, 07 May 2019 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=o8VtjTD6U9Es50KJbjcJKdSYXX43ladKltot7A5aRyM=;
        b=HTAWHY9hwy56emh+CK2+bMmDxMoIxqs7yaCFxdjRv6TNrbkDzU+GpDNJiqF1S678bN
         UVo8m3llYZNo6trwCxHMjBzX5YmAy9fwvLhUjTaYadgOK4HHBNokanXtg5eV11CSgm9D
         EWIU2GrCrBpogPhVYdfdYf15tyQFJ3OryvjAlx6Nd2uOKscK2csV9p3CdPFCekiOrCpE
         6Q2yA4xwAESmVD3exgUN5/In46ri/902r0wC8jaDBw/DywThbLmmTWn4p+Llicpye6lV
         +05Yuskd31Da9OqUwP2ALzLpHpDWmN5NsxOjdjy+YfRE+MwLhG/aQ8e1MSHQBcXWZKSQ
         x5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=o8VtjTD6U9Es50KJbjcJKdSYXX43ladKltot7A5aRyM=;
        b=d7JNB6Qu/VjzfUdeT+mWD4HIqRgT3tn4F0vK4fbZ5iliKnxYEdeNeN7+c0/qHNK3s5
         xAGhIZXce61K5mNV6k1ZzZfUmwh77EDKvrFhs2cjxAA0S1Y+K5jEfchINWhk0YBQputc
         +n5Qwo+cnXPLM7xBrpCwMKHRirtzpukIy1+ro3Yn0fs4rjEnm1ca0TDekZ6YWiOpyAvR
         MkDJlpL3/6XSER1CVCAEvMeYi0jXxc9ekq/zRe2rIrEJzs5e5k1OHpC+t//M6hAxaW+8
         m4eH6PaJnBBbXsKXZlCBwuNLEG/GZSq6vWbZXoNETR+eZccrvVGObW3/kI2hoqMSUXUe
         cm4g==
X-Gm-Message-State: APjAAAWF+dEGc9aTyiqPZsTwMAdIcnoOXnDDqVOxzD+faC6k46uiTVye
        boSaKnb0DxKSvZapeexu+TymyLyv4Ogm3f/GwJC8
X-Google-Smtp-Source: APXvYqyIqydtKKpDZ9uwQ/0+Oi3WDAYlzeGo4LdM9WqIB/E5OzCvGAw7Mehyq+xk0Of58S8AP3H/YhKTpE2Bv/MJDsA=
X-Received: by 2002:a2e:9350:: with SMTP id m16mr17769667ljh.38.1557249794156;
 Tue, 07 May 2019 10:23:14 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 May 2019 13:23:03 -0400
Message-ID: <CAHC9VhSkOmRGvOje3HycoauPL+ZW9g9zZ3dqiPDmQTPUPnhCPg@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

We've got a few SELinux patches for the v5.2 merge window, the
highlights are below:

- Add LSM hooks, and the SELinux implementation, for proper labeling
of kernfs.  While we are only including the SELinux implementation
here, the rest of the LSM folks have given the hooks a thumbs-up.

- Update the SELinux mdp (Make Dummy Policy) script to actually work
on a modern system.

- Disallow userspace to change the LSM credentials via /proc/self/attr
when the task's credentials are already overridden.  The change was
made in procfs because all the LSM folks agreed this was the Right
Thing To Do and duplicating it across each LSM was going to be
annoying.

As a FYI, you will likely run into a minor merge problem with
scripts/selinux/mdp.c due to patches sent up during the v5.1-rcX
cycle, but it is pretty trivial to resolve (just make sure the
kconfig.h include is included).  If you have any questions about the
merge, you know where to find us.

Please pull this for v5.2,
-Paul

--
The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

 Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190507

for you to fetch changes up to 35a196bef449b5824033865b963ed9a43fb8c730:

 proc: prevent changes to overridden credentials (2019-04-29 09:51:21 -0400)

----------------------------------------------------------------
selinux/stable-5.2 PR 20190507

----------------------------------------------------------------
Arnd Bergmann (1):
     selinux: avoid uninitialized variable warning

Ondrej Mosnacek (10):
     kernfs: clean up struct kernfs_iattrs
     kernfs: do not alloc iattrs in kernfs_xattr_get
     selinux: try security xattr after genfs for kernfs filesystems
     kernfs: use simple_xattrs for security attributes
     LSM: add new hook for kernfs node initialization
     selinux: implement the kernfs_init_security hook
     kernfs: initialize security of newly created nodes
     LSM: lsm_hooks.h - fix missing colon in docstring
     selinux: remove useless assignments
     kernfs: fix xattr name handling in LSM helpers

Paul Moore (2):
     MAINTAINERS: update SELinux file patterns
     proc: prevent changes to overridden credentials

Paulo Alcantara (1):
     selinux: use kernel linux/socket.h for genheaders and mdp

Stephen Smalley (2):
     scripts/selinux: modernize mdp
     scripts/selinux: fix build

Tetsuo Handa (1):
     selinux: Check address length before reading address family

YueHaibing (1):
     selinux: Make selinux_kernfs_init_security static

MAINTAINERS                             |   2 +-
fs/kernfs/dir.c                         |  24 ++--
fs/kernfs/inode.c                       | 162 +++++++++--------------
fs/kernfs/kernfs-internal.h             |   8 +-
fs/kernfs/symlink.c                     |   4 +-
fs/proc/base.c                          |   5 +
include/linux/kernfs.h                  |  13 ++
include/linux/lsm_hooks.h               |  13 ++
include/linux/security.h                |   9 ++
scripts/selinux/genheaders/genheaders.c |   1 -
scripts/selinux/install_policy.sh       |  92 +++++++------
scripts/selinux/mdp/Makefile            |   2 +-
scripts/selinux/mdp/mdp.c               | 166 ++++++++++++++++++++----
security/security.c                     |   6 +
security/selinux/hooks.c                | 229 +++++++++++++++++++++----------
security/selinux/include/classmap.h     |   1 +
security/selinux/include/security.h     |   1 +
security/selinux/netlabel.c             |  14 +-
security/selinux/ss/services.c          |   7 +-
19 files changed, 488 insertions(+), 271 deletions(-)

-- 
paul moore
www.paul-moore.com
