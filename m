Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7071C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 08:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D79206F0
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 08:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfrQc/RA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgHXIdr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbgHXIdq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 04:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598258024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VAhUK5lBz4eEBfuvp/4/iD/CAHiSDRQ2eZ+qkIGBUAg=;
        b=YfrQc/RAOrwwbJ2GZedVKyQyBqcdpND9GrQc8tgdTqxxSEan9eCcn/kc1bvhYZHZtjT6Ay
        fKo1OS4mwPwDyitK10lE8yc7RWxvfsT4RmoWvPIbE4eh0poHauXnZTGQHNjj+2f4f73FIl
        fX5049iSz99dM58/NMf01wqX359fhfE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-tUHD0C6OOeOESTA33-IT7g-1; Mon, 24 Aug 2020 04:33:40 -0400
X-MC-Unique: tUHD0C6OOeOESTA33-IT7g-1
Received: by mail-lj1-f198.google.com with SMTP id d2so2537705lja.18
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 01:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAhUK5lBz4eEBfuvp/4/iD/CAHiSDRQ2eZ+qkIGBUAg=;
        b=Lv1PEOjBn2MeZ6Ms4u8wjqPSpWqXHWHJyngBLCoGP+j7s8xaUKETfP4rdM8nRHXoF0
         xQL9WM0eph4rbJJUf1YVNwOkMy2wDSS7rD1Vud258oD1C3ptEEGlwezuu4zmpMBqC/CT
         NdWtbiildhagz9Oql7AsORATfojYg/cT7bWw+uuuWSL3ies6CSEodzf4BiyZ7Y6SMhqt
         C8zNWmB2mCoXulOi3a5zBDFbdshDrjz4zbgzOWwIE98h3pqumQ7I6YwYkhWbzqe55/SE
         TWnoLzYnTl4tPNFG0MmZ+04UCG4YjxcmQy/dXW4F+c5I/LQV67Xe8ZOgKqdORdlFP+Jd
         33hw==
X-Gm-Message-State: AOAM531+h2HZycg3DyYw2urFNSdAhLArm6yJpdHv0H8OHV5UHtxGlBj3
        k4NrFhoCNC9O4OhNqIRj0Lj1SCd8zhHh57ERSPNnSHjcP5hthzKWpuc3ZXP+6ln2sFAwcysJxML
        /xjxEb5OVB0FBo/wXrutXYIBNy30INEpd0Q==
X-Received: by 2002:a2e:7010:: with SMTP id l16mr2056253ljc.38.1598258019324;
        Mon, 24 Aug 2020 01:33:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ/lENihwAPgr49A28IrwxXH4pHlDdFWo6EnEjCBqdOlJRlSBaRCMRzvpSWv60tOLxKjsbD+/FHfw20i+SpCY=
X-Received: by 2002:a2e:7010:: with SMTP id l16mr2056248ljc.38.1598258019093;
 Mon, 24 Aug 2020 01:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200821154704.1214330-1-omosnace@redhat.com> <CAEjxPJ5gZhE2RB7A4LQyBOi5FQF5PLw_vs6gHeiwsiB1-j6Rog@mail.gmail.com>
In-Reply-To: <CAEjxPJ5gZhE2RB7A4LQyBOi5FQF5PLw_vs6gHeiwsiB1-j6Rog@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 24 Aug 2020 10:33:28 +0200
Message-ID: <CAFqZXNvdtpxveqesYMz3ZxoWGd_vi5euqy6c9gzhmdkKgbU-Fg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a race condition in security_read_policy()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 21, 2020 at 7:39 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Aug 21, 2020 at 11:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
> > Fix it by doing everything in a single transaction and getting the
> > length directly from policydb instead of calling
> > security_policydb_len().
> >
> > Fixes: cee74f47a6ba ("SELinux: allow userspace to read policy back out of the kernel")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/services.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index a48fc1b337ba9..ab4de2a01634a 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -3842,22 +3842,25 @@ int security_read_policy(struct selinux_state *state,
> >                          void **data, size_t *len)
> >  {
> >         int rc;
> > +       struct policydb *policydb;
> >         struct policy_file fp;
> >
> >         if (!selinux_initialized(state))
> >                 return -EINVAL;
> >
> > -       *len = security_policydb_len(state);
> > +       read_lock(&state->ss->policy_rwlock);
> > +       policydb = &state->ss->policy->policydb;
> >
> > +       *len = policydb->len;
> >         *data = vmalloc_user(*len);
>
> I don't believe you can hold a read_lock() across a vmalloc.  That's
> why this is done the way it is now.

Fair point. Then I guess the only option is to keep retrying the
allocation until the allocated size is >= the size we are about to
write. I'll send a revised patch soon.

>
> > -       if (!*data)
> > -               return -ENOMEM;
> > -
> > -       fp.data = *data;
> > -       fp.len = *len;
> > +       if (!*data) {
> > +               rc = -ENOMEM;
> > +       } else {
> > +               fp.data = *data;
> > +               fp.len = *len;
> >
> > -       read_lock(&state->ss->policy_rwlock);
> > -       rc = policydb_write(&state->ss->policy->policydb, &fp);
> > +               rc = policydb_write(policydb, &fp);
> > +       }
> >         read_unlock(&state->ss->policy_rwlock);
> >
> >         if (rc)
> > --
> > 2.26.2
> >
>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

