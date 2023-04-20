Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFCBC7618E
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 23:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjDTXxB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 19:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjDTXxA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 19:53:00 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543B5258
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 16:52:57 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b8f66ec3188so1216846276.0
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 16:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682034776; x=1684626776;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wvvZw4OMAoT8728L3uMpQDq3dxXhgrODEret94ZJ66c=;
        b=b66fqzLoGth9vlIFoZBRLof+IuGCZwspZ6mIziw2F4m/YzHwhhFdcNICRpLbUzreBY
         6UYGzgci0S8vKedngwUuAX60PWCFjsZ3OO3ZdY1MxNfAyvCB8/OcFoB5sfu1O95GOoQT
         +AXqGAN1qGU3UGjsRLOI43u7RqPKeCuWKUqJ9SAtTuT3P6D1ojAvZYcVeQT4XYguw9Cm
         woxIpEXsQ/W2KQtv9QLIhB0OBPcI5idXMv/iORiK5NzL7H0DAjhlClnih8s6HVKJLk1P
         TaX7A020zr81QxsvIhzkuvxWgrXlL40Zh9H7EmaCzc0chnF5mXQOR9eE0rsMC/Mb4UHW
         Uv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682034776; x=1684626776;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvvZw4OMAoT8728L3uMpQDq3dxXhgrODEret94ZJ66c=;
        b=RGppjLs1bUyPxc9M6bMUZhPGYwf08yoThv9jUtnU3WazDgUH1N/CX1voLM5E/uwv3S
         wK3M8v4agRWcPOfc0Cnc1SBSXznKPYfrmI+bxhIgTn7gcrtXyN41HRKErX0N3pXZm9Nc
         QxwBiwK9ZgyJ5m6fvrxPR7YNWPFo0hzmMP4VAy1+hwznDrABdt06g04TBXUrcqlDYrSA
         7ugVtcjBpb+hmhrFbzI55a2TM5zi026KaZOuu33wqRf8yvGl3cSo8l4e25y/PJcLYsVc
         j5w9CLIe8ql69p17lwuH4Cq6jMPJqqIOVDPoH26gof09uecNydauE5gwR5QeVU33IHZ4
         T9zg==
X-Gm-Message-State: AAQBX9eS6Sl+Pfv1TzWFp4rCYhlFxoh5HE32RB3MHG0cTg6fQY6g2XaO
        SxfPCg9Pv3xLRCaHwzDw/33S3wVHktAGhh3DSUhE
X-Google-Smtp-Source: AKy350YBsSQs9YDnkhiCwBsX/wSb4T9zfIt4JiAQRFfHo1xHpauPdXxT/ybGpv//woj8xEcFCpHFHKCEcf0wuTEKF+0=
X-Received: by 2002:a25:b097:0:b0:b97:f46:a2b8 with SMTP id
 f23-20020a25b097000000b00b970f46a2b8mr745289ybj.17.1682034776291; Thu, 20 Apr
 2023 16:52:56 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Apr 2023 19:52:45 -0400
Message-ID: <CAHC9VhQEXm3XG7B1wJBVsd15xFNpMjyuyxWDEcTAGrSN6zWoaA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Due to some personal logistics challenges over the next few days I'm
sending the SELinux pull request for Linux v6.4 a bit early.  Here is
a quick summary of the changes:

* Stop passing the 'selinux_state' pointers as function arguments
As discussed during the end of the last development cycle, passing a
selinux_state pointer through the SELinux code has a noticeable impact
on performance, and with the current code it is not strictly
necessary.  With this PR we simplify things by referring directly to
the single selinux_state global variable which should help improve
SELinux performance.  This change is responsible for most of the
diffstat in this PR.

* Uninline the unlikely portions of avc_has_perm_noaudit()
This change was also based on a discussion from the last development
cycle, and is heavily based on an initial proof of concept patch from
you.  The core issue was that avc_has_perm_noaudit() was not able to
be inlined, as intended, due to its size.  We solved this issue by
extracting the less frequently hit portions of avc_has_perm_noaudit()
into a separate function, reducing the size of avc_has_perm_noaudit()
to the point where the compiler began inlining the function.  We also
took the opportunity to clean up some ugly RCU locking in the code
that became uglier with the change.

* Remove the runtime disable functionality
After several years of work by the userspace and distro folks, we are
finally in a place where we feel comfortable removing the runtime
disable functionality which we initially deprecated at the start of
2020.  There is plenty of information in the kernel's deprecation (now
removal) notice, but the main motivation was to be able to safely mark
the LSM hook structures as '__ro_after_init'.  LWN also wrote a good
summary of the deprecation this morning which offers a more detailed
history:
- https://lwn.net/SubscriberLink/927463/dcfa0d4ed2872f03

* Remove the checkreqprot functionality
The original checkreqprot deprecation notice stated that the removal
would happen no sooner than June 2021, which means this falls hard
into the "better late than never" bucket.  The Kconfig and deprecation
notice has more detail on this setting, but the basic idea is that we
want to ensure that the SELinux policy allows for the memory
protections actually applied by the kernel, and not those requested by
the process.  While we haven't found anyone running a supported distro
that is affected by this deprecation/removal, anyone who is affected
would only need to update their policy to reflect the reality of their
applications' mapping protections.

* Minor Makefile improvements
Some minor Makefile improvements to correct some dependency issues
likely only ever seen by SELinux developers.  I expect we will have at
least one more tweak to the Makefile during the next merge window, but
it didn't quite make the cutoff this time around.

Please merge, thanks.
-Paul

--
The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

 Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230420

for you to fetch changes up to 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5:

 selinux: ensure av_permissions.h is built when needed
   (2023-04-12 19:46:35 -0400)

----------------------------------------------------------------
selinux/stable-6.4 PR 20230420

----------------------------------------------------------------
Lukas Bulwahn (1):
     selinux: clean up dead code after removing runtime disable

Ondrej Mosnacek (1):
     selinux: fix Makefile dependencies of flask.h

Paul Moore (5):
     selinux: uninline unlikely parts of avc_has_perm_noaudit()
     selinux: remove the 'checkreqprot' functionality
     selinux: remove the runtime disable functionality
     selinux: update the file list in MAINTAINERS
     selinux: ensure av_permissions.h is built when needed

Stephen Smalley (2):
     selinux: stop passing selinux_state pointers and their offspring
     selinux: stop returning node from avc_insert()

.../sysfs-selinux-checkreqprot                     |   3 +
.../{obsolete => removed}/sysfs-selinux-disable    |   3 +
MAINTAINERS                                        |   4 +-
include/linux/lsm_hooks.h                          |  30 -
security/Kconfig                                   |   5 -
security/apparmor/lsm.c                            |   6 +-
security/bpf/hooks.c                               |   4 +-
security/commoncap.c                               |   2 +-
security/landlock/cred.c                           |   2 +-
security/landlock/fs.c                             |   2 +-
security/landlock/ptrace.c                         |   2 +-
security/landlock/setup.c                          |   4 +-
security/loadpin/loadpin.c                         |   2 +-
security/lockdown/lockdown.c                       |   2 +-
security/security.c                                |   4 +-
security/selinux/Kconfig                           |  47 --
security/selinux/Makefile                          |   4 +-
security/selinux/avc.c                             | 276 +++++-----
security/selinux/hooks.c                           | 612 +++++------------
security/selinux/ibpkey.c                          |   2 +-
security/selinux/ima.c                             |  37 +-
security/selinux/include/avc.h                     |  29 +-
security/selinux/include/avc_ss.h                  |   3 +-
security/selinux/include/conditional.h             |   4 +-
security/selinux/include/ima.h                     |  10 +-
security/selinux/include/security.h                | 185 ++-----
security/selinux/netif.c                           |   2 +-
security/selinux/netlabel.c                        |  17 +-
security/selinux/netnode.c                         |   4 +-
security/selinux/netport.c                         |   2 +-
security/selinux/selinuxfs.c                       | 258 +++------
security/selinux/ss/services.c                     | 346 +++++-------
security/selinux/ss/services.h                     |   1 -
security/selinux/status.c                          |  44 +-
security/selinux/xfrm.c                            |  20 +-
security/smack/smack_lsm.c                         |   4 +-
security/tomoyo/tomoyo.c                           |   6 +-
security/yama/yama_lsm.c                           |   2 +-
38 files changed, 735 insertions(+), 1255 deletions(-)
rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-checkreqprot (90%)
rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-disable (90%)

-- 
paul-moore.com
