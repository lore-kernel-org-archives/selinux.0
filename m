Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE45C77B7A
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 01:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjFBBNs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 21:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFBBNr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 21:13:47 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C8418D
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 18:13:45 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-565a3cdba71so16580527b3.0
        for <selinux@vger.kernel.org>; Thu, 01 Jun 2023 18:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685668424; x=1688260424;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4nydeH8fGmYfEq//3RT6MGqc1Z4XWdWvcyC0fJTwhtM=;
        b=JFBun+Pik8MgDtLxGed2bleSGjQCew45jQglAUHqtG3l9V53YpgjD3ZokHdpg2u95+
         nR3woVnNJRgAcLxwgbda8dkLv7dMAMIbAlzoqLQJUEsKtUYBApsyTpqbc7P042Sygxxd
         h7m4VmiGKxlLVAj7GLE9wuDHP+uMeFHB8rslF/yhflnSNcewswQICHjPdlKOn/CzSLi0
         avgCmxnCuYQslsl6cyl+JmCfP2xp9u5BWKAuUdpiMomu6oGeT0n594nYyRhKfCj0ifuw
         1UyLccigYVvCOx7oT453wNtRcR5Rgw1d1JSSharO0tegFGxPuP4VBIk6ifiO5wKy7r1+
         T8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668424; x=1688260424;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nydeH8fGmYfEq//3RT6MGqc1Z4XWdWvcyC0fJTwhtM=;
        b=kIFFcEtnMP90HlibrLEhtHerFFSM+OVJVDnqdNzgH+aJWIuTXulyru+SZsfKa529jn
         hwVY+rbOi7WFBgxSHRGrjLRPzaziFXDmY99s0IethoQ+pMoKYvso2ZX0FHHm+f/rBAkB
         KshMwXQg6DbRC59ZrcQs60746KMfkUFfrgjdQAbLCBCtMrcH9I9uISElUetytKj3571j
         XT6wDp3GLXoukkTyhzXRK/J0PTOgAVVSfX34XAm7PH0i9pASMK1kfi+gfNxxy1W95+WC
         QCLytAPsQaYt+2W2anRo7qH5cNJxkUuv/ZcRbWMIt0JsUOLfEJjSkLwCLbDkPEq6DZeM
         YWcQ==
X-Gm-Message-State: AC+VfDz+7aSPFlVMUUnouSQ6DfBXOAvcn5w+qd0GDcokE0Ys9VCc8wqQ
        XeGnPL7zhjGXzeDD9zbyXA4Z44i2GLddiIleU47X
X-Google-Smtp-Source: ACHHUZ7orX0SaNZQ72ZLc51WkA3Dy6WwNhQoWx2L0nYgKXT4snf9ah6BwBrapuvf/G9Xsr9zVyKYPNl1JmUAZdSPl3g=
X-Received: by 2002:a0d:e801:0:b0:561:e8d7:ac6b with SMTP id
 r1-20020a0de801000000b00561e8d7ac6bmr10789383ywe.49.1685668424300; Thu, 01
 Jun 2023 18:13:44 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 21:13:33 -0400
Message-ID: <CAHC9VhQPMmWZwS-S9FQpU5rETcizcDPK0Nm1mwXeWpykUdDLFw@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v6.4 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

A small SELinux Makefile fix to resolve a problem seen when building
the kernel with older versions of make.  The fix is pretty trivial and
effectively reverts a patch that was merged during the last merge
window.  As usual, the commit description has more information.

Thanks,
-Paul
--
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

 Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230601

for you to fetch changes up to 42c4e97e06a839b07d834f640a10911ad84ec8b3:

 selinux: don't use make's grouped targets feature yet
   (2023-06-01 13:56:13 -0400)

----------------------------------------------------------------
selinux/stable-6.4 PR 20230601

----------------------------------------------------------------
Paul Moore (1):
     selinux: don't use make's grouped targets feature yet

security/selinux/Makefile | 6 +++++-
1 file changed, 5 insertions(+), 1 deletion(-)

-- 
paul-moore.com
