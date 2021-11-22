Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6292BC433EF
	for <selinux@archiver.kernel.org>; Mon, 22 Nov 2021 23:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhKVXPj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhKVXPj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Nov 2021 18:15:39 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC6C061714
        for <selinux@vger.kernel.org>; Mon, 22 Nov 2021 15:12:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z5so83999761edd.3
        for <selinux@vger.kernel.org>; Mon, 22 Nov 2021 15:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=REZjJzImo0urMLsHkk1FhwZ6/JcD/HZVY+MHOZ/2jwY=;
        b=HjDsbVia0MjsS0/rjFNG7+q5bgPGSRTtbGBIFrYpBj0xh2fuagVhgfwedC7UBbJvp3
         46x+6Lx1ykJzBWxRDatYikY37AxrrsHAKRRGnOMp44OSa7V4vO6GGXIuGZFxOOJ9O4Xc
         TVH2sTyM4IBeYWduqZa9y/NTr9kiF4HCNAV9VFqa/wWOU6YpjXJsQLYNTpSv8w4PB01U
         h9gjwgZlCBunQ3xnJLUbZ0eiAPuA8lg/Jm+i1Rann8spp68+/XZ14niDo6MzSAeCedpd
         hSiIKevlXv/Ws9XKxMigY8dkYjRGsbk4lXBTzjOzSIU745333xAG3B0HuzKiqvyNgu0n
         5j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=REZjJzImo0urMLsHkk1FhwZ6/JcD/HZVY+MHOZ/2jwY=;
        b=vjOnO5Pw+MfDvBiXvIE/7epcvhaP1EbhgJVorqtGvRZD+88cSBnK7QtQN/LDEbZvW2
         zwLmCY17JdCfnSA3lLFFm2sQvPLG4SsYeUJc+z4f5X83zF5uYZkfHzBSCJLWR/8h9nF6
         aMVRkTHdLJO3Nn+PPhUgwe1pyV7UOJga+6VviiA7/nbRDx/YhU1ufDxcCWxJ04Y4XghU
         KzI0tvb2VLWwAQkmH1QkVPKHZlh7Mr8uLrwiaoMjkXnBBS6o90jIqLEkt0qqs1RWIwpC
         pYoBAJKXLfm2anRdAFBTBi2OLBJyjckO/weY9AHzfr6ydHTmPhBzolNVa3Xe0NEYc0b/
         kGBg==
X-Gm-Message-State: AOAM533galrQ/ttMevALPiEz/C35BqQwq7TBaal+gFe++KWYIamsJUv8
        j3f5t26ZaegJ4GSdlE03lH37n3F8zktvnz2/KWVjW+MN7w==
X-Google-Smtp-Source: ABdhPJxMHenxMDLlm8BniUBEzOyYhjy4M0Piuusda0Fgi1gC9JAoy30H9TVKqRPScVCg88GjmQ83s568d3niAWChcjk=
X-Received: by 2002:aa7:c30e:: with SMTP id l14mr1362840edq.370.1637622749992;
 Mon, 22 Nov 2021 15:12:29 -0800 (PST)
MIME-Version: 1.0
References: <163294304032.208242.9097581875096098591.stgit@olly> <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com>
In-Reply-To: <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Nov 2021 18:12:19 -0500
Message-ID: <CAHC9VhREpJ3bkcU+cOz_Cg7KaF=QokngvXyhCpus--=d8HSP_g@mail.gmail.com>
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() -> security_current_getsecid_subj()
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 19, 2021 at 5:52 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > The security_task_getsecid_subj() LSM hook invites misuse by allowing
> > callers to specify a task even though the hook is only safe when the
> > current task is referenced.  Fix this by removing the task_struct
> > argument to the hook, requiring LSM implementations to use the
> > current task.  While we are changing the hook declaration we also
> > rename the function to security_current_getsecid_subj() in an effort
> > to reinforce that the hook captures the subjective credentials of the
> > current task and not an arbitrary task on the system.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/lsm_hook_defs.h         |    3 +--
> >  include/linux/lsm_hooks.h             |    8 +++-----
> >  include/linux/security.h              |    4 ++--
> >  kernel/audit.c                        |    4 ++--
> >  kernel/auditfilter.c                  |    3 +--
> >  kernel/auditsc.c                      |   10 +++++++++-
> >  net/netlabel/netlabel_unlabeled.c     |    2 +-
> >  net/netlabel/netlabel_user.h          |    2 +-
> >  security/apparmor/lsm.c               |   13 ++++++++++---
> >  security/integrity/ima/ima_appraise.c |    2 +-
> >  security/integrity/ima/ima_main.c     |   14 +++++++-------
> >  security/security.c                   |    6 +++---
> >  security/selinux/hooks.c              |   19 +++----------------
> >  security/smack/smack.h                |   16 ----------------
> >  security/smack/smack_lsm.c            |    9 ++++-----
> >  15 files changed, 48 insertions(+), 67 deletions(-)
>
> I never saw any comments, positive or negative, on this patch so I'll
> plan on merging it early next week.  If you've got objections, now is
> the time to speak up.

I just merged this patch, with the AppArmor tweak suggested by Serge,
into selinux/next.  Thanks everyone.

-- 
paul moore
www.paul-moore.com
