Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4760EC433F5
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 20:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A5861241
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 20:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243151AbhIWU0G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243102AbhIWU0G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Sep 2021 16:26:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F3AC061757
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 13:24:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c21so27041390edj.0
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nMzcp/8joR6kTSo7ETzEZ9Ek7QuPuXXM7c+XEqSTszY=;
        b=k90zC2dDnOWMj1ojN2z5cwtMiHENl0n9hahhuAs1vIhflh5w2sgJiZjW+bYqbmccNz
         S6I9ng3ak36HQ9v5edxRLITAwXPL1rgimE5JYeB0Y552u6dwI/MeDUfSEupeeKpmK4A3
         ix1Hkwffoj6vEl/v65bX7Q1IRmRdKEps54qSHER6Q9hN575KY6nAc71x0DRCRVly5u09
         PZmZg4XEc50XIwGLJvgiVcE4/mc6mRxOa7DjThJH9QUCsABo2COmmgEam0tOga94fIkW
         qCicuafOMTP7lqVoITloVlQQHd2A1OsuSo2jjmrGUDYh1O8rjAr4JWkEtRLz03xkpXGl
         qmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nMzcp/8joR6kTSo7ETzEZ9Ek7QuPuXXM7c+XEqSTszY=;
        b=UXzT2t41p3/E7O1dfYbOXrqe72s3eYzJdw8XvQYuAW91Lw1vLcs3YGden5KiR7UF/u
         q9pQRzAgT6UAFGdZax4i+t6h9HNBfwF81g2ld3acG/0xSqiXTq9yO0+XqxbZCWUc2b1q
         QreQGHtetWH5gYtR0roCDfJUKNPfPITrbsUTX4sefh2FEPAV2Gww8Y+geNuTYNMnx4bS
         1hNEKAz8eoR7lv/VWTzVurG/xc5eZejjcPplNrJFmTecJtcQG3vxiiTRCzkK1tNm4H/r
         vx+YKi014DwdJ9yCClcjijAXtykOOcfHJLvpuhsYWplwWPDI3Pvieh8wS9Ups9JtUN3y
         8p6A==
X-Gm-Message-State: AOAM530yAOneR1/R7uzQzSWrtKxxImWmB4zOO0TtXYFfJynkKAynYm3N
        g8ixaswbxfHGKGP/5tbwvYvCtIIfdUAOi0It4rsf
X-Google-Smtp-Source: ABdhPJzjfVn2kJzHgPgX66bIldWuZc1mF4G8aWl7bssVGl4Ij9cybr/bXTM1hHJq4NbXfqrofi44jEvLdRy+HCvc0Ng=
X-Received: by 2002:a05:6402:3587:: with SMTP id y7mr866912edc.362.1632428672314;
 Thu, 23 Sep 2021 13:24:32 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Sep 2021 16:24:21 -0400
Message-ID: <CAHC9VhSDOQpQPfzMfvEd+hCZeyJiZ4WbvjjG7rGgYAUS=7vZBQ@mail.gmail.com>
Subject: [GIT PULL] SELinux/Smack fixes for v5.15 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Another one patch PR for SELinux, as well as Smack, that should be
merged during the v5.15-rcX cycle.  It fixes some credential misuse
and is explained reasonably well in the patch description.  Please
merge.

-Paul
--
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

 Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20210923

for you to fetch changes up to a3727a8bac0a9e77c70820655fd8715523ba3db7:

 selinux,smack: fix subjective/objective credential use mixups
   (2021-09-23 12:30:59 -0400)

----------------------------------------------------------------
selinux/stable-5.15 PR 20210923

----------------------------------------------------------------
Paul Moore (1):
     selinux,smack: fix subjective/objective credential use mixups

security/selinux/hooks.c   | 4 ++--
security/smack/smack_lsm.c | 4 ++--
2 files changed, 4 insertions(+), 4 deletions(-)

-- 
paul moore
www.paul-moore.com
