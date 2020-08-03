Return-Path: <SRS0=5Yje=BN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F55C433DF
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 23:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E542420786
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 23:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="U3y1piV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgHCXQZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgHCXQZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 19:16:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6712EC061757
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 16:16:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l4so40314202ejd.13
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RVPV7oxVS93iXefV8KQ0bKUcXLAvqUAHupIudOdk4DQ=;
        b=U3y1piV/vs4p2cFmwFCj+by9kLDR7TX3YB4ZXXse0JO6mC48hufglIAmDp/1g9uIBs
         6bsztBElrfuBb4hbJPfuLqZSxGJNSvj3/G4tM5tKjtd/+mJ3xHaLyMfG/xEXB0gSEnrx
         +Ho6EB6vdUJfqAfUm9UIxvOml5mFY53nl3mWOdgnYADlDiIG9mv6Y3pEcDXf8uh8pN4v
         lEUXWqwbSqYq3slPqu1zwYKeZNcHsx2O/SpnoafrqasFD6/YGwr8lJe/O/l7KqRj8hw7
         fFIOLe8D2C4MlVvFUVRfyPQrYDBVsN0zOgTAJMNadcjyHptvP336kbT6Bk6BFB6uJfGy
         FInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RVPV7oxVS93iXefV8KQ0bKUcXLAvqUAHupIudOdk4DQ=;
        b=bK4hQWneoZJUEOAVVnR+CQJ1MlPE8U1+RUDz6l99lIVAdwg4qBXePnzevhHNIAemiP
         uEkI/TcKYR6N1Q8R5RbUblGLyqVR8cAQX+QwSouyKW61e7RcxIcigswCOAqhFB8jg5lF
         /9MLbmP0XmRYdnx95k1oYre+b4MQL+08q2V/F/fY5zi7Euza48s+O/D512KCKjonbtT9
         6YhrgVuvV/AVBj9RRlSv9RlN47tdNy5BEllUBNpqlZLj8jwGPbW8NKoHGNbkp+s+tW8/
         Xpy5rfIWXy0rVZtj3cuBjdWqHPIkNuwn7ekMsamkxF24cUlrzKKqF8TJHUjTfFXF2Ogl
         v8Ig==
X-Gm-Message-State: AOAM5304L+HBTdbZ7FkPPyr/zHVhExUHDc8WmvvuQIQJkZzVongztzN2
        SwzeTAYA0boUC2Hp18eED/MWbuL+lKzSc/ULpYRX
X-Google-Smtp-Source: ABdhPJzbjZ+13fbSX2hywI8tfmTickIarJs8hvmSCpKZYozNkrcWSZ9Sw/Fd/U/iaB60GIdz7Me9Kr3ZxTHvXOaQ8Q8=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr17799685eje.431.1596496582017;
 Mon, 03 Aug 2020 16:16:22 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Aug 2020 19:16:10 -0400
Message-ID: <CAHC9VhTy5xcOqx2SRjsyC-H-xvj3vvbHDt7O-S7TLYhXjANZGw@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Here is the SELinux pull request for the v5.9 release.  All the
patches pass our test suite and earlier this evening they merged
cleanly with your tree.

Beyond the usual smattering of bug fixes, we've got three small
improvements worth highlighting:

- Improved SELinux policy symbol table performance due to a reworking
of the insert and search functions

- Allow reading of SELinux labels before the policy is loaded,
allowing for some more "exotic" initramfs approaches

- Improved checking an error reporting about process class/permissions
during SELinux policy load

Please merge these for v5.9.  Thanks,
-Paul

--
The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

 Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20200803

for you to fetch changes up to 54b27f9287a7b3dfc85549f01fc9d292c92c68b9:

 selinux: complete the inlining of hashtab functions
   (2020-07-09 19:08:16 -0400)

----------------------------------------------------------------
selinux/stable-5.9 PR 20200803

----------------------------------------------------------------
Ethan Edwards (1):
     selinux: fixed a checkpatch warning with the sizeof macro

Jonathan Lebon (1):
     selinux: allow reading labels before policy is loaded

Ondrej Mosnacek (3):
     selinux: specialize symtab insert and search functions
     selinux: prepare for inlining of hashtab functions
     selinux: complete the inlining of hashtab functions

Stephen Smalley (2):
     scripts/selinux/mdp: fix initial SID handling
     selinux: log error messages on required process class / permissions

lihao (1):
     selinux: Fix spelling mistakes in the comments

scripts/selinux/mdp/mdp.c         |  23 ++++--
security/selinux/hooks.c          |   7 +-
security/selinux/netif.c          |   2 +-
security/selinux/netnode.c        |   2 +-
security/selinux/netport.c        |   2 +-
security/selinux/ss/conditional.c |   8 +--
security/selinux/ss/conditional.h |   2 +-
security/selinux/ss/hashtab.c     |  59 ++-------------
security/selinux/ss/hashtab.h     |  77 ++++++++++++++++----
security/selinux/ss/mls.c         |  23 +++---
security/selinux/ss/policydb.c    | 148 ++++++++++++++++++++++------------
security/selinux/ss/policydb.h    |   9 +++
security/selinux/ss/services.c    |  38 +++++-----
security/selinux/ss/symtab.c      |  21 ++++--
security/selinux/ss/symtab.h      |   3 +
15 files changed, 258 insertions(+), 166 deletions(-)

-- 
paul moore
www.paul-moore.com
