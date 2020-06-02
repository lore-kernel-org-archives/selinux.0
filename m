Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B35CC433DF
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 01:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B232073B
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 01:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="g3P79kjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgFBBHB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFBBHA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Jun 2020 21:07:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ADFC05BD43
        for <selinux@vger.kernel.org>; Mon,  1 Jun 2020 18:07:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so11018566ejb.10
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2020 18:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bacYd6Xj63f6+mhdcMdTVJ2YDOuetS8awQOMSRyd60k=;
        b=g3P79kjvPSikCAVrOvBjMTJ1MhKHE5VPpEN91wi3kMamR76EyRhCW9QvW8uo4vgVeY
         4T/e+gLBxH1XD09jzNROz6FxUoHmrP7v9gVAhUpKD/OEEnkjrnz8yAKbp3vQGEGf8IOr
         r86eaWMmSva9QxMhxNWI7HqZHNI9gy9hAspDJ3MWp8Tj1XQF3/Vdffbuw8+0MOkTBCN+
         qw0F9UkTrdMj4I1Ao7kICX4j8WOagpY+oE0Y6vhkNXaAo9cahwHcCiwoYPrTxychDbB7
         aX4VoZrX1I1exEHTXOqkJTuflg7HRJS3lvG7ZwRA6PAAWPkD1BD99DE45/LjxwR012CP
         t/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bacYd6Xj63f6+mhdcMdTVJ2YDOuetS8awQOMSRyd60k=;
        b=sdXbsWt1YYEc1+2IK2hm+IFx9NnoUmeBNuMIkkn05cIMITatkkitJog87G7CluY7gp
         rfZRa39p3GfX42k9rqFcOhcbkGemrWm9uwp9ulZjqliYeMe7nXDT1K+zAO3RJ2q9HW9u
         yY2llecuY8caLsBO7uF5+ueCUGbH+YUA0tRHypOzhR8YPZ1aan6FbeJ8rPGGejyvPZ0A
         My+cJfvfqLpI3MuQfX0/L2GjpRG/+O3Ik79AJyzTc6xPP6R7RktH1dfMIpMatI/uZqv9
         AJsXl11dxoIbeFTpfmE8UEU+HGaebUTQG2O702+veFwHvZud9zpu1HT5xEtl4DGAmN9J
         ixTw==
X-Gm-Message-State: AOAM531Y/5lxZQquvN0zFFjaGhWA3myk3472P0SXGcrFN63PUD++QNr1
        /sICnmAC2PnQ0jJkNLFHCaI0uU+4k5ktc8dAvjbKb4uaoA==
X-Google-Smtp-Source: ABdhPJyKsQV/yosAgyJ5ku5AJYZrdaUYTfXNwFDdpTJsLDr6Wwl2VzwIzIBZoKOV8M4cuLJdwpCobc4TVnk8A/FK5xk=
X-Received: by 2002:a17:906:7395:: with SMTP id f21mr10789073ejl.178.1591060018671;
 Mon, 01 Jun 2020 18:06:58 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Jun 2020 21:06:48 -0400
Message-ID: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Here are the SELinux patches for v5.8.  All the patches pass our test
suite and as of about 15 minutes ago they apply cleanly to the top of
your tree.  Please merge into v5.8.

The highlights:

- A number of improvements to various SELinux internal data structures
to help improve performance.  We move the role transitions into a hash
table.  In the content structure we shift from hashing the content
string (aka SELinux label) to the structure itself, when it is valid.
This last change not only offers a speedup, but it helps us simplify
the code some as well.

- Add a new SELinux policy version which allows for a more space
efficient way of storing the filename transitions in the binary
policy.  Given the default Fedora SELinux policy with the unconfined
module enabled, this change drops the policy size from ~7.6MB to
~3.3MB.  The kernel policy load time dropped as well.

- Some fixes to the error handling code in the policy parser to
properly return error codes when things go wrong.

Thanks,
-Paul

--
The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

 Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20200601

for you to fetch changes up to fe5a90b8c14914397a3bb0c214d142103c1ba3bf:

 selinux: netlabel: Remove unused inline function (2020-05-12 20:16:33 -0400)

----------------------------------------------------------------
selinux/stable-5.8 PR 20200601

----------------------------------------------------------------
Ondrej Mosnacek (9):
     selinux: drop unnecessary smp_load_acquire() call
     selinux: store role transitions in a hash table
     selinux: hash context structure directly
     selinux: move context hashing under sidtab
     selinux: implement new format of filename transitions
     selinux: don't produce incorrect filename_trans_count
     selinux: simplify range_write()
     selinux: fix return value on error in policydb_read()
     selinux: do not allocate hashtabs dynamically

Wei Yongjun (1):
     selinux: fix error return code in policydb_read()

YueHaibing (1):
     selinux: netlabel: Remove unused inline function

Zou Wei (1):
     selinux: fix warning Comparison to bool

security/selinux/Makefile           |   2 +-
security/selinux/include/netlabel.h |   6 -
security/selinux/include/security.h |   3 +-
security/selinux/ss/context.c       |  32 +++
security/selinux/ss/context.h       |  11 +-
security/selinux/ss/ebitmap.c       |  14 ++
security/selinux/ss/ebitmap.h       |   1 +
security/selinux/ss/hashtab.c       |  51 ++--
security/selinux/ss/hashtab.h       |  13 +-
security/selinux/ss/mls.c           |  16 +-
security/selinux/ss/mls.h           |  11 +
security/selinux/ss/policydb.c      | 451 +++++++++++++++++++++++---------
security/selinux/ss/policydb.h      |  15 +-
security/selinux/ss/services.c      | 153 +++++-------
security/selinux/ss/services.h      |   3 -
security/selinux/ss/sidtab.c        |  35 +--
security/selinux/ss/sidtab.h        |   1 +
security/selinux/ss/symtab.c        |   5 +-
security/selinux/ss/symtab.h        |   2 +-
19 files changed, 499 insertions(+), 326 deletions(-)
create mode 100644 security/selinux/ss/context.c

-- 
paul moore
www.paul-moore.com
