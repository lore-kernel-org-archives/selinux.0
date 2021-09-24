Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047AEC433EF
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 16:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D039A610C7
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 16:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhIXQkM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229974AbhIXQkK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 12:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632501517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BAoeSV/gWKp90OlTS/oKUoIoYx4ruuJQtmHlX2sdiRk=;
        b=hbgRG+1zWVNUrtYO7Gz+7ssktWQYaoa4M21fQACbsDOnSqtkcKw21R21smXrXP7qfKlaWR
        51flZ92iXYAvxr9fdZL7N2D9AEHCfQYR5V1dpkBqSVieQn8/OW/mqzzvdpXldb9XgnBbiO
        8Pn+PBmEiKrn9xo18tSxiaro8RLsSaM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-3x-AoAW8OHWmeLev5uU2CA-1; Fri, 24 Sep 2021 12:38:35 -0400
X-MC-Unique: 3x-AoAW8OHWmeLev5uU2CA-1
Received: by mail-yb1-f198.google.com with SMTP id d81-20020a251d54000000b005b55772ca97so4022586ybd.19
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 09:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAoeSV/gWKp90OlTS/oKUoIoYx4ruuJQtmHlX2sdiRk=;
        b=4OtE7Tip2uhtcpMAxYXK30hfMln5l4g1MECjRlMIvIVD/moOF3Wpam9M1PywfKOEet
         eMTnnm4d75pfVqx3+VnBIVcra9Db0vM1hxUQ5rsAIWJT1bWfwElbtSJ35ASS6r7zCG1E
         LvbEDOTucHs21l6PLlHJVWze46ges16sbnk/gDSzaS0crO9twD3CIaT4EdnsvepaV+iV
         DYAZnFaIHIpZTm2tp7vQOKKZcMtnyrvbJ+3ojpxeoJkCTt72MLs0r1ymhCTDXes6Nu6N
         6UukUh78NNrMSoMrTR01NieK2Qui8m/UVk6EZiBD5MCm8spQjX404GaOEJopvklGcVPr
         KGtg==
X-Gm-Message-State: AOAM531+a0rZqwwbkyY87oOSbVYOoO7yAVxQcxjxWV6JKN/LW18w3pwa
        9KEmySjboiFmsFseSD+pT6yO82FzDZKUwrqr7LWW63qY2JRIcYQSwurH5+52pXP/a75dvGN5pJp
        0jn3uuJ5UJnvSXKLiH+HooBnKDF2CdpLVWw==
X-Received: by 2002:a25:51c2:: with SMTP id f185mr13141334ybb.479.1632501515325;
        Fri, 24 Sep 2021 09:38:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXT0QTHlMOQqK4Nq42Ews7JRzO88xJmZgxveX6k6xYL8YyTgVDQy/gP/pNRWU8fnOFjG4ijBG5jfaeL5VaCLM=
X-Received: by 2002:a25:51c2:: with SMTP id f185mr13141305ybb.479.1632501515002;
 Fri, 24 Sep 2021 09:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <163243191040.178880.4295195865966623164.stgit@olly>
 <CAEjxPJ5pxox=oE0TxmEFA-PkFGPDbAjtK_nqM3y-xaT0e3or0w@mail.gmail.com>
 <CAHC9VhTAY0povyGpv3QhiE9n4WDmnSYTi9Cq8ZnVO_AkH8M6EA@mail.gmail.com> <CAEjxPJ7wkCyPZb7h3C_U3zVmJtiVtm4FAi5K+6U7kS63g0Vm-w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7wkCyPZb7h3C_U3zVmJtiVtm4FAi5K+6U7kS63g0Vm-w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 24 Sep 2021 18:38:23 +0200
Message-ID: <CAFqZXNvM_RkaubR6pbAQVUyWjTgc-PTN5NZzOAk3sQ2q199hBg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: use SECINITSID_KERNEL as the subj/obj in the
 lockdown hook
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 24, 2021 at 5:12 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Sep 24, 2021 at 10:22 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Fri, Sep 24, 2021 at 9:08 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Sep 23, 2021 at 5:18 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > The original SELinux lockdown implementation in 59438b46471a
> > > > ("security,lockdown,selinux: implement SELinux lockdown") used the
> > > > current task's credentials as both the subject and object in the
> > > > SELinux lockdown hook, selinux_lockdown().  Unfortunately that
> > > > proved to be incorrect in a number of cases as the core kernel was
> > > > calling the LSM lockdown hook in places where the credentials from
> > > > the "current" task_struct were not the correct credentials to use
> > > > in the SELinux access check.
> > > >
> > > > Attempts were made to resolve this by adding a credential pointer
> > > > to the LSM lockdown hook as well as suggesting that the single hook
> > > > be split into two: one for user tasks, one for kernel tasks; however
> > > > neither approach was deemed acceptable by Linus.
> > > >
> > > > In order to resolve the problem of an incorrect SELinux domain being
> > > > used in the lockdown check, this patch makes the decision to perform
> > > > all of the lockdown access control checks against the
> > > > SECINITSID_KERNEL domain.  This is far from ideal, but it is what
> > > > we have available to us at this point in time.
> > > >
> > > > Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > --
> > > >
> > > > NOTES: While trivial, this patch is completely untested; I'm posting
> > > > this simply to see what comments there may be within the SELinux
> > > > community to such an approach as the current code is flawed and needs
> > > > to be corrected.
> > > > ---
> > > >  security/selinux/hooks.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 6517f221d52c..4f016a49e3a6 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -7016,7 +7016,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
> > > >  static int selinux_lockdown(enum lockdown_reason what)
> > > >  {
> > > >         struct common_audit_data ad;
> > > > -       u32 sid = current_sid();
> > > > +       u32 sid = SECINITSID_KERNEL;
> > > >         int invalid_reason = (what <= LOCKDOWN_NONE) ||
> > > >                              (what == LOCKDOWN_INTEGRITY_MAX) ||
> > > >                              (what >= LOCKDOWN_CONFIDENTIALITY_MAX);
> > >
> > > Kind of begs the question of whether it is even worth keeping the check at all.
> >
> > Yes, it does, especially considering that Linus seems to be rejecting
> > lockdown implementations that differ from the lockdown LSM.  The only
> > argument I can see for keeping the SELinux lockdown check is if people
> > wanted to be able to include it as part of a policy analysis, although
> > given the limited nature of the control I'm not sure how useful that
> > would be in practice.
> >
> > > This could potentially break an existing policy where lockdown has
> > > been defined and only allowed as needed but I suspect it is already
> > > allowed in Fedora and Android.
> >
> > This was one of the reasons for the "untested!" warning.  Like you, I
> > suspect the kernel domain has already been granted the necessary
> > permissions in deployed policies (I will be amazed if there are no
> > kernel threads which end up triggering a lockdown check), but even if
> > it did we need to make some sort of change to the existing code.
>
> Looks like Fedora policy allowed both permissions unconditionally (no
> boolean) to all unconfined domains.
> So SECINITSID_KERNEL checks will pass but are rather pointless unless
> Fedora decides to define separate
> integrity/confidentiality rules and wrap them each with a boolean
> (e.g. allow_kernel_integrity_violation,
> allow_kernel_confidentiality_violation) so that an admin can disable
> them to enforce lockdown independently
> of the lockdown module.
>
> Android policy allows all domains :lockdown confidentiality but
> prohibits (neverallow) integrity permission from
> being allowed on user (production) builds. They do allow apps
> :lockdown integrity on debug builds for debugfs
> kcov usage, so that rule would need to be fixed if switching to always
> using SECINITSID_KERNEL or the checks will
> start failing.
>
> Did all the issues around invoking audit from arbitrary contexts in
> which security_locked_down() is called get sorted?
> If not, we'll still have that as a potential problem if permission is
> denied or an auditallow rule is defined on lockdown.
>
> Can we get Linux distro and Android folks to speak as to whether they
> consider the check in this reduced form to still be useful or whether
> we should just remove it altogether?

I would vote for just removing it rather than basically duplicating
the Lockdown LSM functionality. It likely wouldn't even be complete as
a couple of the security_locked_down() calls happen at __init time,
where SELinux wouldn't get a chance to deny them (no policy loaded
yet).

(Well... I *tried* to make this thing work, but it really feels like
too much hassle to reasonably tweak all the existing callers to
fulfill the SELinux expectations to be worth it. I admit I'll be kind
of relieved to see the lockdown class go - it brought me nothing but
pain :) It would be a nice feature if done right, but that would have
to be a new patch that somehow deals with all the intricacies...
Either someone finds enough motivation to do it, or it just shouldn't
be there, IMHO.)

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

