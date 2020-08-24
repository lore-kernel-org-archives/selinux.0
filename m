Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFFCC433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73DDC2078D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 12:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUI5BkAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHXMxL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgHXMxJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 08:53:09 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FA2C061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 05:53:08 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id e6so8124328oii.4
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyoUCG9iFcx+jMyvj8uFOEMuL8jSK1oDSfaH7COVLjc=;
        b=aUI5BkAt+XqY5eZKF4M55ekhMv+dbZ+H9ZD/LxDwZiJ3hNIHrN9urXdTDB9xeBSxwF
         I7FQ06d/HUGMOOm/ztzqYyJxVdx3cLw7vkS8XpqMTe5Qr4lZTURoPjQSP/LFdqQ/m180
         hys4I3NnmzJuwbHxjb8gGYhimMOcvzSqLAXLko0iPq/8dYQsCLbA6NOjL04QkhVHS27Y
         Xi2D4279v+vQk4z1TRe2l7J5FnxehKGpfzSN3Onbgz7t/YdmCC9NvQLqtBPuwy65gQDH
         RqfpFRj+0v9ZdeBusPBz0pqEg8T4WKSkk8LAQAtw3zSQ0ZAfUE+F7cS1BATROQrRpxu0
         hMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyoUCG9iFcx+jMyvj8uFOEMuL8jSK1oDSfaH7COVLjc=;
        b=bCr63Y82XTjZKYWD7kU/Az9brh3oPtatex9LUHe0ZEukicNoShOkSVMG3Ef0JmTYtv
         iFaynrJI13g1En7847yZoDJEwBPWbTFHR6QvOTrWr9484Yk3EB2geS/ld+V6QL1i13xA
         iuLmpLEH/kIY4+UrI0WFsRXpXStZY8iG3NYaqLkVQXSLkWqYsxofKExX1Ylh0swJgkn7
         ASI0GESxVscQrRgFB7fQEywmj1nOtv2HCxZqu5GS8xnPHAferMylHpmgCat3qxrFs97m
         2oEuDhLdSQhnZFCLX7mp8PZHrIU3QSCer3QRulFYAbfyfm77RVRnRT0DJkLb87bFZaLp
         XIxg==
X-Gm-Message-State: AOAM532T0RByEC/BpcFHekRX41QusBaUxJCsJa0QCmglxTZ/antWRCJJ
        RDjjevSZwV/cSV+f8xgWFhQlCyPT2bzyfZeXrdE=
X-Google-Smtp-Source: ABdhPJz9IqZtFDpAH0QE4T2HSY0reLnHxTBaUbr7JUtvFZHPqbCkKTm0iqZLwTqfS5TZK0B+mV83YoWK8K94rgS5Fds=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr2830264oic.92.1598273588298;
 Mon, 24 Aug 2020 05:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200824113015.1375857-1-omosnace@redhat.com> <20200824113015.1375857-2-omosnace@redhat.com>
 <CAEjxPJ6sTB+SCKQFg=4uMHMih1gAnCTYdcPUJ=FGMpYZwYYo5Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ6sTB+SCKQFg=4uMHMih1gAnCTYdcPUJ=FGMpYZwYYo5Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 08:52:57 -0400
Message-ID: <CAEjxPJ4j3+C0tCCuMPc5a8Y9-Yp=n3Xc+217OkNV7i=CC6P=Uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: fix a race condition in security_read_policy()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 8:47 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 24, 2020 at 7:30 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > In security_read_policy(), the policy length is computed using
> > security_policydb_len(), which does a separate transaction, and then
> > another transaction is done to write the policydb into a buffer of this
> > length.
> >
> > The bug is that the policy might be re-loaded in between the two
> > transactions and so the length can be wrong. In case the new length is
> > lower than the old length, the length is corrected at the end of the
> > function. In case the new length is higher than the old one, an error is
> > returned.
> >
> > Since we can't call vmalloc_user() under read_lock(), fix it by checking
> > if the allocated buffer is sufficiently large after doing the allocation
> > and taking the read lock and if not, retry the whole operation with the
> > new size.
> >
> > Fixes: cee74f47a6ba ("SELinux: allow userspace to read policy back out of the kernel")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/services.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index a48fc1b337ba9..2c9072f095985 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -3849,14 +3849,22 @@ int security_read_policy(struct selinux_state *state,
> >
> >         *len = security_policydb_len(state);
> >
> > +again:
> >         *data = vmalloc_user(*len);
> >         if (!*data)
> >                 return -ENOMEM;
> >
> > +       read_lock(&state->ss->policy_rwlock);
> > +       if (*len < state->ss->policy->policydb.len) {
> > +               *len = state->ss->policy->policydb.len;
> > +               read_unlock(&state->ss->policy_rwlock);
> > +               vfree(*data);
> > +               goto again;
> > +       }
> > +
> >         fp.data = *data;
> >         fp.len = *len;
> >
> > -       read_lock(&state->ss->policy_rwlock);
> >         rc = policydb_write(&state->ss->policy->policydb, &fp);
> >         read_unlock(&state->ss->policy_rwlock);
> >
>
> security_read_policy() is called with fsi->mutex held by selinuxfs, so
> policy reload cannot occur in between the length computation and the
> writing of the policydb.  Right?  It's another case where we could
> pass down the mutex as in my rcu patches for a lockdep assertion.

If my RCU patches are merged, we could modify security_read_policy()
to take the mutex too and use rcu_dereference_protected() there,
likewise getting rid of the separate security_policydb_len().  Or I
could re-spin them to do that if any other changes are needed.
Waiting to see if Paul wants any changes to either of those.
