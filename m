Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDA2C433F5
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 15:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BCA61076
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 15:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346969AbhIXPOF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346962AbhIXPOF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 11:14:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE715C061571
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 08:12:31 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y28so41199268lfb.0
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOiMREPE7surHGU8wSxhV3dwHmJWg5PpF7KmI3aJzPE=;
        b=VxjmW/JDgsFNWGZf/1C6eAexyIQhfZNDq5mExfRsRw/njH2R3fT8jB51dNxeZYAVKo
         q0FEFUnAneQh4htrfXd//RZ18+NyUGo94lBSXmWaLxpl9VUuQlIul9mpK4OwuXsKbrs9
         XZP37WdhEFUVA8U0zd/QovAUDR6Beulwl1baS+bhxkev0tVTCfWXGP1bPNFrUzndHZyt
         ztVxIzwYuuIYhB6p4OmyQULs94ExBBubYrDVYd03D476LMCPyN1QdTSLAr79aCnl2xtZ
         UIjj2DWN7C0FNNb4MW3H7Pn8B1HsIAyeAVGDrjlveWyFE/B0LnOwC4G1Q42LlYvRyyfj
         3g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOiMREPE7surHGU8wSxhV3dwHmJWg5PpF7KmI3aJzPE=;
        b=LR/YIJ+Ta1tUfxX3bsZCCZ0Y5G3prMiKsY8CF5ZdqInS+oC6qU/mll7EoIIQ9DAYoa
         mTZ3FvKGt+zdB0QMwyVOobo7OIFK2WC6ho3GvCjg137WX8Eayy68kMjiIl22cezMVof1
         APAps3Yzb28ZwRKWJJWiKmfeSFWJmvkUZiWU0UyXVlQzU0kAHJybPMbB6op248Oakipd
         JLmxm+h1N/9m/9cQSkmXMK3vXIYNwZHjyFd/c3LMGlxzY3JAG0oekMMgSqXi01rokDdq
         YZ7qQbvVfrMvFMxvDTWCji7+wZ8OHH/EN/9uof9pj4P2dxAqzjSxBJnBXXg434yx/baC
         b7jA==
X-Gm-Message-State: AOAM531AjGwNS4Vv5/yvN3EsxhHyslgP0HUw+eVwigKE5MbmoclBkft3
        Pemf/g7H5y/asM79u69/Iwo6cxPROKwISz9MCU0=
X-Google-Smtp-Source: ABdhPJztMpdFWHEuoFR8o0DW4ucC9Z2RdTOssz5X6u09+9mb0JaRLz/1nc4Kq/OS/Jc64ognB+5gHINFIiOv9c7fVsA=
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr9606603lfo.70.1632496349886;
 Fri, 24 Sep 2021 08:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <163243191040.178880.4295195865966623164.stgit@olly>
 <CAEjxPJ5pxox=oE0TxmEFA-PkFGPDbAjtK_nqM3y-xaT0e3or0w@mail.gmail.com> <CAHC9VhTAY0povyGpv3QhiE9n4WDmnSYTi9Cq8ZnVO_AkH8M6EA@mail.gmail.com>
In-Reply-To: <CAHC9VhTAY0povyGpv3QhiE9n4WDmnSYTi9Cq8ZnVO_AkH8M6EA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Sep 2021 11:12:18 -0400
Message-ID: <CAEjxPJ7wkCyPZb7h3C_U3zVmJtiVtm4FAi5K+6U7kS63g0Vm-w@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: use SECINITSID_KERNEL as the subj/obj in the
 lockdown hook
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 24, 2021 at 10:22 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Sep 24, 2021 at 9:08 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Sep 23, 2021 at 5:18 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > The original SELinux lockdown implementation in 59438b46471a
> > > ("security,lockdown,selinux: implement SELinux lockdown") used the
> > > current task's credentials as both the subject and object in the
> > > SELinux lockdown hook, selinux_lockdown().  Unfortunately that
> > > proved to be incorrect in a number of cases as the core kernel was
> > > calling the LSM lockdown hook in places where the credentials from
> > > the "current" task_struct were not the correct credentials to use
> > > in the SELinux access check.
> > >
> > > Attempts were made to resolve this by adding a credential pointer
> > > to the LSM lockdown hook as well as suggesting that the single hook
> > > be split into two: one for user tasks, one for kernel tasks; however
> > > neither approach was deemed acceptable by Linus.
> > >
> > > In order to resolve the problem of an incorrect SELinux domain being
> > > used in the lockdown check, this patch makes the decision to perform
> > > all of the lockdown access control checks against the
> > > SECINITSID_KERNEL domain.  This is far from ideal, but it is what
> > > we have available to us at this point in time.
> > >
> > > Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > --
> > >
> > > NOTES: While trivial, this patch is completely untested; I'm posting
> > > this simply to see what comments there may be within the SELinux
> > > community to such an approach as the current code is flawed and needs
> > > to be corrected.
> > > ---
> > >  security/selinux/hooks.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 6517f221d52c..4f016a49e3a6 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -7016,7 +7016,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
> > >  static int selinux_lockdown(enum lockdown_reason what)
> > >  {
> > >         struct common_audit_data ad;
> > > -       u32 sid = current_sid();
> > > +       u32 sid = SECINITSID_KERNEL;
> > >         int invalid_reason = (what <= LOCKDOWN_NONE) ||
> > >                              (what == LOCKDOWN_INTEGRITY_MAX) ||
> > >                              (what >= LOCKDOWN_CONFIDENTIALITY_MAX);
> >
> > Kind of begs the question of whether it is even worth keeping the check at all.
>
> Yes, it does, especially considering that Linus seems to be rejecting
> lockdown implementations that differ from the lockdown LSM.  The only
> argument I can see for keeping the SELinux lockdown check is if people
> wanted to be able to include it as part of a policy analysis, although
> given the limited nature of the control I'm not sure how useful that
> would be in practice.
>
> > This could potentially break an existing policy where lockdown has
> > been defined and only allowed as needed but I suspect it is already
> > allowed in Fedora and Android.
>
> This was one of the reasons for the "untested!" warning.  Like you, I
> suspect the kernel domain has already been granted the necessary
> permissions in deployed policies (I will be amazed if there are no
> kernel threads which end up triggering a lockdown check), but even if
> it did we need to make some sort of change to the existing code.

Looks like Fedora policy allowed both permissions unconditionally (no
boolean) to all unconfined domains.
So SECINITSID_KERNEL checks will pass but are rather pointless unless
Fedora decides to define separate
integrity/confidentiality rules and wrap them each with a boolean
(e.g. allow_kernel_integrity_violation,
allow_kernel_confidentiality_violation) so that an admin can disable
them to enforce lockdown independently
of the lockdown module.

Android policy allows all domains :lockdown confidentiality but
prohibits (neverallow) integrity permission from
being allowed on user (production) builds. They do allow apps
:lockdown integrity on debug builds for debugfs
kcov usage, so that rule would need to be fixed if switching to always
using SECINITSID_KERNEL or the checks will
start failing.

Did all the issues around invoking audit from arbitrary contexts in
which security_locked_down() is called get sorted?
If not, we'll still have that as a potential problem if permission is
denied or an auditallow rule is defined on lockdown.

Can we get Linux distro and Android folks to speak as to whether they
consider the check in this reduced form to still be useful or whether
we should just remove it altogether?
