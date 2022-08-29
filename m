Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D383ECAAD4
	for <selinux@archiver.kernel.org>; Mon, 29 Aug 2022 21:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiH2VCp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiH2VCn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Aug 2022 17:02:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5369F8A6DD
        for <selinux@vger.kernel.org>; Mon, 29 Aug 2022 14:02:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p5so9718924lfc.6
        for <selinux@vger.kernel.org>; Mon, 29 Aug 2022 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=Y0O6W1EIFYUAhWdC9TPBVXlgaxDiB7GTNtP+edapuQo=;
        b=z1OikuueYS/w0Ms/g7l8XX6nantHAtBYuktlpYNed16wdBkvtNYhV/2T37j9OnvEGV
         62aCxWPpRQ0M9/SHtnEOWLqp5cbpAMwuzazHYhP492gVBhJe6a10j2aO8dC88chrH4qL
         2c6itrZ3HONN0732sHty7A8HNTLifQEHne3XXeFn1sP+mPq4HPC4W6rPeQyWpeu1D7fT
         R470oPcWzvXdrerftAyvbtERdONXBDRAU7RgNu+FhLKoCgtkuBb4LVEOFeWSQi5IuS4O
         ZojnVDCCxdj6VuamYqz65Cz+gnzt+Q249o+EohlopMTY79KHsxxlILesdw8wSrXyl5Cc
         WI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Y0O6W1EIFYUAhWdC9TPBVXlgaxDiB7GTNtP+edapuQo=;
        b=iS7bgN1bBRvYD15kJ3uMFkAZt9S3EAFvuv4GO8iROkcH20QlfORXwNtgvDQojTTT7x
         FOZcZdKjBAJN4d3zAUHJRHau1Y5xFYVLeC/M9LUtQJ2l5OjCuGDsRGfkm45Ke56uKA3P
         FzASg5Eo7FTqWcuo1w0P04cGROdOqgIck7F7ghQf9r1mekEz9f/ztMeWWnRQs/Lboxbi
         JUzKK9/JXOwFIXutpv3n4W/rZEt67dOWulVFHqzcvsCGLpYMJAkz9uy0Btuh1dntj/qM
         F4BobhIHorJPgKFxI6oFNU/ETbfa8VRr7sqPdKksr5YxpE43z/quVZGURcjRE/jY/whP
         M0qA==
X-Gm-Message-State: ACgBeo2A02l6GAeBJKA32LEdjDFZKCJVqJPk7GNhnqRAp6yGb6KBlJNS
        ickdNLgn4fkgt6hrvlD+ylHq5wKX2WFYaIp62HFy
X-Google-Smtp-Source: AA6agR4AO1xvVTU52DvWOJGOcBJoURJDMNN0z6GXu4M3uNgUvRBfyu8JFpUs7A2QRuiTLLbJaIKbdwTImgBctS9F57g=
X-Received: by 2002:a05:6512:b1c:b0:492:8835:1e4c with SMTP id
 w28-20020a0565120b1c00b0049288351e4cmr6444944lfu.442.1661806959576; Mon, 29
 Aug 2022 14:02:39 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Aug 2022 17:02:28 -0400
Message-ID: <CAHC9VhQu7vuXMqpTzdZp2+M4pBZXDdWs7FtWdEt_3abW-ArUDA@mail.gmail.com>
Subject: [GIT PULL] LSM fixes for v6.0 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Linus,

Four patches to add SELinux and Smack controls to the io_uring
IORING_OP_URING_CMD.  Three of these patches are necessary as without
them the IORING_OP_URING_CMD remains outside the purview of the LSMs
(Luis' LSM patch, Casey's Smack patch, and my SELinux patch).  These
patches have been discussed at length with the io_uring folks, and
Jens has given his thumbs-up on the relevant patches (see the commit
descriptions).  There is one patch that is not strictly necessary, but
it makes testing much easier and is very trivial: the /dev/null
IORING_OP_URING_CMD patch.  If you have a problem accepting the
/dev/null patch in a rcX release, let me know and I'll remove it.

As of earlier today the tag merged cleanly with your tree, so there
should be no surprises.  Please merge for v6.0.

-Paul

--
The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

 Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20220829

for you to fetch changes up to dd9373402280cf4715fdc8fd5070f7d039e43511:

 Smack: Provide read control for io_uring_cmd
   (2022-08-26 14:56:35 -0400)

----------------------------------------------------------------
lsm/stable-6.0 PR 20220829

----------------------------------------------------------------
Casey Schaufler (1):
     Smack: Provide read control for io_uring_cmd

Luis Chamberlain (1):
     lsm,io_uring: add LSM hooks for the new uring_cmd file op

Paul Moore (2):
     selinux: implement the security_uring_cmd() LSM hook
     /dev/null: add IORING_OP_URING_CMD support

drivers/char/mem.c                  |  6 ++++++
include/linux/lsm_hook_defs.h       |  1 +
include/linux/lsm_hooks.h           |  3 +++
include/linux/security.h            |  5 +++++
io_uring/uring_cmd.c                |  5 +++++
security/security.c                 |  4 ++++
security/selinux/hooks.c            | 24 ++++++++++++++++++++++
security/selinux/include/classmap.h |  2 +-
security/smack/smack_lsm.c          | 32 ++++++++++++++++++++++++++++++
9 files changed, 81 insertions(+), 1 deletion(-)

-- 
paul-moore.com
