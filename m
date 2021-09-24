Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9544CC433EF
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F65D61164
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 14:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346674AbhIXOYg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345603AbhIXOYd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 10:24:33 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A679DC061571
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 07:22:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x7so22102185edd.6
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mbOmjH+GIC7xC+tEHPwSvr0bdESLHd9DFogfmpjKRI=;
        b=aoSdR/JiIrlikUXaUpjTKFfj8Ge25UUg0BGFcdZgnPC90Rt5TpQ4NHaE2ku8ftAhqj
         bo8QtDg3Uu+bJkxHTUm98LXXXe2iwsQPO4l7U+cgKMWhHCGijyDGihfA838MGvGdb/8N
         p1RPTjI84wZA76DXVp9G/ls3INZ8HWemDmitE6Galb82XxIagFX1fSyzWd73dRS9zPPs
         CagZtLZde4Cvf6FljjF9eG3AgAMBh84bAdw/sQ6bIueJ91wHFOY0IQ3S9ftfar6xcKOj
         9f4YdRUvzcndYKVTOc1YBUxNe8zvfXBu4zoXEByj/XGpat7/+feIWz3NzVswUd5u8pwt
         xIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mbOmjH+GIC7xC+tEHPwSvr0bdESLHd9DFogfmpjKRI=;
        b=VmyrHVBmJDU0Bm6/RAK8HBfaI0IEObo+Kts34s9yCG2clHqCRdSjHD+t6VWi0fVYP8
         FyT7taL0m5ep/0tFJgTr78pjo7Y62+8xUmQ0jAptCzA+cveFFLCH84MgA7+LBnxY/3T0
         JOmucqcaEsogDZE0j3nK0IBR5PZIu6hICDmQElUx9nF3+1MMIaE4byJ382I4LZsttqdP
         nClp2hxIxd3D00vsC3QtfEiT7/9rcYOX7JlCKSDvp8RbKHbjM13aXcF2A45Wj++RYs4D
         YIzV61SPRePuV5GBRUSBB56gv/W3nvwzC+imM30aArKskMZJxsJZ5VUtc/yDS/RCQjSB
         jjwg==
X-Gm-Message-State: AOAM530f/YzE4y5CiwrWExIQUqcX9UNwYQWUWUeA7HcpeM+BUPvv/o+I
        syhGGYwj8Em8c1uZonnV0YbAL/SK6FkP0LAwa7NbAhYtuQ==
X-Google-Smtp-Source: ABdhPJygI93cZHpekqbLJNF1LUb3vZoXJO2PtnZZzC5R19yut4DFm/fu5H3aOuo94Q5muPhmzf3cII6D3eK1ocHDToA=
X-Received: by 2002:a50:ab18:: with SMTP id s24mr5398381edc.88.1632493378128;
 Fri, 24 Sep 2021 07:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <163243191040.178880.4295195865966623164.stgit@olly> <CAEjxPJ5pxox=oE0TxmEFA-PkFGPDbAjtK_nqM3y-xaT0e3or0w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5pxox=oE0TxmEFA-PkFGPDbAjtK_nqM3y-xaT0e3or0w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Sep 2021 10:22:47 -0400
Message-ID: <CAHC9VhTAY0povyGpv3QhiE9n4WDmnSYTi9Cq8ZnVO_AkH8M6EA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: use SECINITSID_KERNEL as the subj/obj in the
 lockdown hook
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 24, 2021 at 9:08 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 23, 2021 at 5:18 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > The original SELinux lockdown implementation in 59438b46471a
> > ("security,lockdown,selinux: implement SELinux lockdown") used the
> > current task's credentials as both the subject and object in the
> > SELinux lockdown hook, selinux_lockdown().  Unfortunately that
> > proved to be incorrect in a number of cases as the core kernel was
> > calling the LSM lockdown hook in places where the credentials from
> > the "current" task_struct were not the correct credentials to use
> > in the SELinux access check.
> >
> > Attempts were made to resolve this by adding a credential pointer
> > to the LSM lockdown hook as well as suggesting that the single hook
> > be split into two: one for user tasks, one for kernel tasks; however
> > neither approach was deemed acceptable by Linus.
> >
> > In order to resolve the problem of an incorrect SELinux domain being
> > used in the lockdown check, this patch makes the decision to perform
> > all of the lockdown access control checks against the
> > SECINITSID_KERNEL domain.  This is far from ideal, but it is what
> > we have available to us at this point in time.
> >
> > Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > --
> >
> > NOTES: While trivial, this patch is completely untested; I'm posting
> > this simply to see what comments there may be within the SELinux
> > community to such an approach as the current code is flawed and needs
> > to be corrected.
> > ---
> >  security/selinux/hooks.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6517f221d52c..4f016a49e3a6 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -7016,7 +7016,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
> >  static int selinux_lockdown(enum lockdown_reason what)
> >  {
> >         struct common_audit_data ad;
> > -       u32 sid = current_sid();
> > +       u32 sid = SECINITSID_KERNEL;
> >         int invalid_reason = (what <= LOCKDOWN_NONE) ||
> >                              (what == LOCKDOWN_INTEGRITY_MAX) ||
> >                              (what >= LOCKDOWN_CONFIDENTIALITY_MAX);
>
> Kind of begs the question of whether it is even worth keeping the check at all.

Yes, it does, especially considering that Linus seems to be rejecting
lockdown implementations that differ from the lockdown LSM.  The only
argument I can see for keeping the SELinux lockdown check is if people
wanted to be able to include it as part of a policy analysis, although
given the limited nature of the control I'm not sure how useful that
would be in practice.

> This could potentially break an existing policy where lockdown has
> been defined and only allowed as needed but I suspect it is already
> allowed in Fedora and Android.

This was one of the reasons for the "untested!" warning.  Like you, I
suspect the kernel domain has already been granted the necessary
permissions in deployed policies (I will be amazed if there are no
kernel threads which end up triggering a lockdown check), but even if
it did we need to make some sort of change to the existing code.

-- 
paul moore
www.paul-moore.com
