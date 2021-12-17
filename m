Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90994C433F5
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 20:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhLQUCr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 15:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhLQUCq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 15:02:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A01C061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 12:02:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z9so12126240edb.5
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 12:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=m1TN1vSbPdjQ1kBpJQ5Rf4PvO87o3O/21wRtoQilZgQ=;
        b=gYNhCu1O0aMAZRG4asiGAf3e55Wf0o8FiVDtuR4GK67gevvc+S23mgtPgBOUk9MQ+p
         AwjGB/D1aX5GSxz3Kzx3lznRpbrAY6BylqKKHX0JfjztBu2Lnz+hG//gA7wXdYfBSMno
         7SzlhlRIC4jfjeFMXxHEjJ0inehsh9ZLVlNZb3eo6HM/jQMabMIzvzRw4Z8qGTnJ2TgV
         DRlc5TnGJEjSz41zhLExjgBuqbQeXOL6KDxwZgTYzsxqARsZYJkVbxiPmiWgwzsXZwKn
         ca3hVEzZY3pMcHME24WzHqBgkdwJ8WIlANkm9zQ+eWexkhmpsp8U5wmPc3ZApG/lrrih
         PIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=m1TN1vSbPdjQ1kBpJQ5Rf4PvO87o3O/21wRtoQilZgQ=;
        b=bTYZgCemu38eKUsZSTs8dc0VC+hxpYcyRxTO8byZg7SWR0QaqcXpnpfwrsFIORompM
         Ks9IKr4oVqh21AfEkigbaDVRvln8YCIQRNB0vbK31f1FPse1DF+WOd/N9MlpP2N9ey0G
         y2+g8/uHMA3vE7jVDwRQOTzw7hLij1OCOZtXnmhB3OvsqXnF/s58icZ30DBm/eHe1Oo9
         D2I7rheuFTLyBB/K1c6cOHaCsixULR+vZbK0e1JWJ+4Bv4289q3+1jJ2dSOQds7rm8BC
         I4O8f7GqnHioLiu7Od9k1FkM6TSx41601wMh/FkSkdzPkmIHMY2Faf/CGHKxDAjTMEEi
         ertA==
X-Gm-Message-State: AOAM532nEzurpp94nUs80NzJuxsc6RvwCJ8Y71Hx+aDlje9y/+T3ADbn
        pguIsaVrs7qwNpnDP2zj4EZ81wvnZMlmbBjhGHtlCMJFyHcZ
X-Google-Smtp-Source: ABdhPJz47oCNv1M/lwln/9SrzEuMxNVfX8UYIa8EV2amYt65ZLYqQOF9wuRoDLTDVWlFZC9gBnfE8kBxAUhsOvNsy10=
X-Received: by 2002:a17:906:3a8c:: with SMTP id y12mr3541460ejd.517.1639771364930;
 Fri, 17 Dec 2021 12:02:44 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Dec 2021 15:02:34 -0500
Message-ID: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.16 (#3)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Another small SELinux fix for v5.16 to ensure that we don't block on
memory allocations while holding a spinlock.  This passes all our
tests without problem, please merge this for the next v5.16-rcX
release.

Thanks,
-Paul

--
The following changes since commit dc27f3c5d10c58069672215787a96b4fae01818b:

 selinux: fix NULL-pointer dereference when hashtab allocation fails
   (2021-11-19 16:11:39 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20211217

for you to fetch changes up to cc274ae7763d9700a56659f3228641d7069e7a3f:

 selinux: fix sleeping function called from invalid context
   (2021-12-16 17:47:39 -0500)

----------------------------------------------------------------
selinux/stable-5.16 PR 20211217

----------------------------------------------------------------
Scott Mayhew (1):
     selinux: fix sleeping function called from invalid context

security/selinux/hooks.c | 33 +++++++++++++++++++--------------
1 file changed, 19 insertions(+), 14 deletions(-)

-- 
paul moore
www.paul-moore.com
