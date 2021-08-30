Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB88BC432BE
	for <selinux@archiver.kernel.org>; Mon, 30 Aug 2021 16:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B3A60E90
	for <selinux@archiver.kernel.org>; Mon, 30 Aug 2021 16:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhH3Qhs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbhH3Qhr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Aug 2021 12:37:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D573EC06175F
        for <selinux@vger.kernel.org>; Mon, 30 Aug 2021 09:36:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g21so22547985edw.4
        for <selinux@vger.kernel.org>; Mon, 30 Aug 2021 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Hlf7A8r7y7wi73uxDoVnlmq0Xmtbe53qsJnuN57thhs=;
        b=NvOyTT8PfwGmcWoey1yZKLubCMBsgXts99GWu40fcXrSdRBTezFURGBL6hHDwGeO3x
         2x3uLwM7jE2PZoA2CcsMORXWQF34gzKHZGtBLixA1k4Z1xueXopLZZHbfgzYmTk2sgRl
         HIwHEVh6kYp/4h2yDS2NmWA/tdVQ0eac9OevEZHi2LAALWCaGUoMOSXuo18ST2K+nbPk
         liQrdmS25m3mnT5JKNQmcTtiIyyLh4cn6+RRCoMBw3/z7nSYYaoE/b4xsKnmX0dCcK87
         +P0prVrTYhdwpkSJMDuvyzyAnNtcNDU/Z7yLE+lXMVyPMxtwjQ1lXUPt+ZD3Yo1A+dwP
         Ti8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Hlf7A8r7y7wi73uxDoVnlmq0Xmtbe53qsJnuN57thhs=;
        b=i7XD3gvjc2xIa2OxP+sxQs1fOmyZYNlvvjQ3ENyIxqMWUG0pk8Gq4CHG1Ag93lGqFp
         UVP48eermx64iUK1vM29kLpBEriBgIoz/huPtZkbWkwwG2Z4A3GXeZyZyjfQfExTT9FH
         nK45eWbTznYCV3OZMp3/GR8LPMQaokZ9ixlXNOUY+zHO/vBny5hFOsQWwQGwotgD1S7U
         rjKxovSb+AvWYsDyizeA5nERiQHbxvQ7Pdti95Ui6eVUTAxW5C2fvtWwmj5rzncnPzEU
         Ga6uiRoQxpmeaHCWehoRavkufKMmrbaXNCmaKfW1W9CBWzmFKDPlYDRAJV4HmmfDmgGl
         dv9g==
X-Gm-Message-State: AOAM531opNkT19jPTUgE7jCe3q5M6s9XJdL6YyLavZDkVlS9xyYKwDDK
        GxfO/Kdnob8yDhY/8M2XDsfkLvZx8FEFVkfeY2II
X-Google-Smtp-Source: ABdhPJzF3xU+nWY0Q4n+AxqozWuahCxrfBiesnS+gniNXKzfSVXZyGIy79UQX3KOlxif1YA+eKaOE7GTVEOsPJJWTJA=
X-Received: by 2002:aa7:d9d2:: with SMTP id v18mr25608229eds.128.1630341412379;
 Mon, 30 Aug 2021 09:36:52 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Aug 2021 12:36:41 -0400
Message-ID: <CAHC9VhQDQ2WF+gsRdC+3g6FLa19nvbka99zE0s_ZbupucpmJmQ@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

We've got an unusually small SELinux pull request for v5.15 that
consists of only one (?!) patch that is really pretty minor when you
look at it.  Unsurprisingly it passes all of our tests and merges
cleanly on top of your tree right now, please merge this for v5.15.

Thanks,
-Paul

--
The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

 Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20210830

for you to fetch changes up to 893c47d1964f5c9b00c5468f2cd1a1e9351fbb6a:

 selinux: return early for possible NULL audit buffers
   (2021-07-14 15:25:27 -0400)

----------------------------------------------------------------
selinux/stable-5.15 PR 20210830

----------------------------------------------------------------
Austin Kim (1):
     selinux: return early for possible NULL audit buffers

security/selinux/hooks.c       | 4 ++++
security/selinux/ss/services.c | 2 ++
2 files changed, 6 insertions(+)

-- 
paul moore
www.paul-moore.com
