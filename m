Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2676EC433EF
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 19:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0066F61505
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 19:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346547AbhI2TVP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Sep 2021 15:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345142AbhI2TVO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Sep 2021 15:21:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5642CC061764
        for <selinux@vger.kernel.org>; Wed, 29 Sep 2021 12:19:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g8so12856076edt.7
        for <selinux@vger.kernel.org>; Wed, 29 Sep 2021 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JMtOTrplDvFfeNYGyrJ/J6i2JTh/PixwMka1xBwXDXk=;
        b=g+mVIFzhjhtRHCRqkW9mWTlicacgsZPX0dE0hBUVwGbAqbtDGhrMCzDxPB5YlDAq2J
         gEpi/ET6eOOeSuhpVZULYgHCo6OpktnB5yCY321LD5n2SlidUzLRRWPr3+DvpKVGJBRO
         N6c6PLOp8+AYkC3dh8Z/U5bzhc9KO78TU/1/J0DMEIpnbXHASE1zVlZiwQASNClUX2/7
         fUqFxCccvSrZ0VBHGVqNDdSe+PsAI50a5vjssbHu/aqMP7Ju6H6zGkzMerja5cBn7Iq4
         IF+0vpDY8VZo4zvnYxHUdqp3jRguXyjfIBtextcBcskrAr3nAgNtSbM0gjL4ibexg6Hw
         1ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JMtOTrplDvFfeNYGyrJ/J6i2JTh/PixwMka1xBwXDXk=;
        b=y8JDO7RRz5MyHFBaApr4vg8R81w2Rxpw3NpqcKXhhm9F51ukVtsZYywJPq89NkCarC
         JpH870+gqDxYkmlBWahUaalxITZX5Fde2PCc9k3MEVUM824mURcAkrGBNWZq3nqU4Sj4
         d9dtvJHsQ3MRUxGPjx99J2b4bFmNxE7cpz/GpE3rr3SsVeqTmFpIVorXL22A2MyJEAEU
         UVu7By1Ahi/5EMaWUDdAhk5BfomwMIjRVWLz/42xWHGOCOQrFYlxtb6OQAivQb48sFYh
         Q+pr7b4G8mUrgIFsl2OygDwolEViXIVAKsg/kWVSmSOhLV1PeLi/qYF1PNHmD2h5dC1O
         omwg==
X-Gm-Message-State: AOAM532MS+4JRHzQN5JXMifYZ7066HoGGKxc0xUjFunCAbwdvuWr9LJ2
        VO8R40wMFrKJufzNaOLiUvhAoxyF3ngE/DN22qfLX2oGHw==
X-Google-Smtp-Source: ABdhPJx3cpmGhALXBTZIpW26/jyXlQ1paVrzbkRsVfmfNguooKFe00gnVDUhCPlU7yRwHlsqjbEVMF634hH7HjphquE=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr1750058ejc.69.1632943171484;
 Wed, 29 Sep 2021 12:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <163294304032.208242.9097581875096098591.stgit@olly>
In-Reply-To: <163294304032.208242.9097581875096098591.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Sep 2021 15:19:20 -0400
Message-ID: <CAHC9VhSbBCtb72b+kCDJsC9vF=m+zjQ-pfqqe+2jE==4boQqaw@mail.gmail.com>
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() -> security_current_getsecid_subj()
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The security_task_getsecid_subj() LSM hook invites misuse by allowing
> callers to specify a task even though the hook is only safe when the
> current task is referenced.  Fix this by removing the task_struct
> argument to the hook, requiring LSM implementations to use the
> current task.  While we are changing the hook declaration we also
> rename the function to security_current_getsecid_subj() in an effort
> to reinforce that the hook captures the subjective credentials of the
> current task and not an arbitrary task on the system.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h         |    3 +--
>  include/linux/lsm_hooks.h             |    8 +++-----
>  include/linux/security.h              |    4 ++--
>  kernel/audit.c                        |    4 ++--
>  kernel/auditfilter.c                  |    3 +--
>  kernel/auditsc.c                      |   10 +++++++++-
>  net/netlabel/netlabel_unlabeled.c     |    2 +-
>  net/netlabel/netlabel_user.h          |    2 +-
>  security/apparmor/lsm.c               |   13 ++++++++++---
>  security/integrity/ima/ima_appraise.c |    2 +-
>  security/integrity/ima/ima_main.c     |   14 +++++++-------
>  security/security.c                   |    6 +++---
>  security/selinux/hooks.c              |   19 +++----------------
>  security/smack/smack.h                |   16 ----------------
>  security/smack/smack_lsm.c            |    9 ++++-----
>  15 files changed, 48 insertions(+), 67 deletions(-)

FYI, this patch is based on v5.15-rc3 as it needs the LSM subj/obj
credential fix present in the v5.15-rcX releases.  Applying it on top
of previous releases will result in compilation errors.

-- 
paul moore
www.paul-moore.com
