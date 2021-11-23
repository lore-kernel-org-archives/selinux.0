Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A915DC433F5
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 21:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhKWVzw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 16:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhKWVzv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 16:55:51 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33E7C061714
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 13:52:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y12so935737eda.12
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 13:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zFcNkIoq5muaZLvXLLeD4MHIH39egtBeCwO9IdlTd4E=;
        b=OUP1+BWbRR1b3WBE5EPf7wawaImps7sZtcKoV3aIlzMbRSpLTdQG3C6V5eAUdnQz/9
         2CN3GYtDOAcZGPN1DWHeKieWuvM6fsscrVPn1tpZheCvVPW62pegPbUdk8zxulX8OHE3
         ++cSeYIku3cn92qeP43g0JPUX1hlMW9eNNBuGCkMbpL4fTsUVUIf/j+21Kynbiml+gOP
         aDrfpp7FPHb3uc82Jz5aNyhzzm9/HP8WzBu6Dd6KXdneq3I6P68VNltjQQj2x1pc7eb2
         M7DsZ6O1IehRqJkYGU7CbSejCoRh0AdUJGhOGDZmp0c2BO7n69Szl8W8vzlj8XfTpIdk
         9fmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zFcNkIoq5muaZLvXLLeD4MHIH39egtBeCwO9IdlTd4E=;
        b=CI92rkjoweJozZ9JzLIE7RwBk0ORnWf2auACovHx21uFeBIqP2KrQVJfCvx/NDNr/m
         5Kt1cUOaYHS5jSnoIZf/SbNpgW19Hv/VUbZwaD3YfUENjhBBQeGDBCMjqxSBf0ThyIdS
         q9sbwiGiNgGEXqXWujrI5QxSqTHhLxrTulXh1NJpTO79oc2Ppcf93tBw6rbkkDMgULNz
         s8WpYkgEYbkoRBxd2E/K/FEVjf5GMXaYwwjnePGKaa6E2MRvP3b2AUJilSftFAQDROBZ
         9apAYHc0Mxr+ZzCNq7aRLFLlmOq+92huB4QdMBXL6qolluz1CiFnLi5sF12ybIsKp6Oj
         yjDw==
X-Gm-Message-State: AOAM533Q3jTXqH1yTmGq9/6YHmSyzZx9Bl5i7Mwzst/KBSWewFrXysGH
        qBfJNT3TKtp4j2p9PzvPRdVZWdjyPfE2p9Dl8+Z7w85zo2Yw
X-Google-Smtp-Source: ABdhPJwTLLnHLhScwB6svIWfEht4EV8Tpcy6SZUmpF3lSj+DYO8/zQWjYkw6wj7xPdoCdQ5T73OqDVj5c5I9dtLs4KQ=
X-Received: by 2002:a17:907:868f:: with SMTP id qa15mr12283769ejc.187.1637704361326;
 Tue, 23 Nov 2021 13:52:41 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Nov 2021 16:52:30 -0500
Message-ID: <CAHC9VhS2Hqg2rvS=Fbkpj++HEs5Cxf=4Xcmd7kdgvOykY1Os+A@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.16 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

A small SELinux fix for v5.16.  As usual the commit description has
more detail, but it's basically a fix to make sure things are handled
correctly when an allocation fails; please merge.

Thanks,
-Paul

--
The following changes since commit 32a370abf12f82c8383e430c21365f5355d8b288:

 net,lsm,selinux: revert the security_sctp_assoc_established() hook
   (2021-11-12 12:07:02 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20211123

for you to fetch changes up to dc27f3c5d10c58069672215787a96b4fae01818b:

 selinux: fix NULL-pointer dereference when hashtab allocation fails
   (2021-11-19 16:11:39 -0500)

----------------------------------------------------------------
selinux/stable-5.16 PR 20211123

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix NULL-pointer dereference when hashtab allocation fails

security/selinux/ss/hashtab.c | 17 ++++++++++++-----
1 file changed, 12 insertions(+), 5 deletions(-)

-- 
paul moore
www.paul-moore.com
