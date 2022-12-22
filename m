Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAAFC4167B
	for <selinux@archiver.kernel.org>; Thu, 22 Dec 2022 01:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiLVBWG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Dec 2022 20:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiLVBWB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Dec 2022 20:22:01 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BE125C62
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 17:21:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l10so584499plb.8
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 17:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BsGteZHXfk/hlEOFVKOGXrUJJ1NMn/MU3BMrE2tpg98=;
        b=Jy7UxPV0MrOaAPJrOcljGWHWSi/zxdurx+cJSaKxaC/dl/CMIGx3mFjuUt5oKwKkUB
         qPIYyWhm1yRJGbngOJTwRTXT4BDqL/ater5fbeE700ZNxb7aQv5ueN5Lr2W9KJfXX1vD
         l81Isux/DOqLncZsZ0LjO0rB2MRrW3x+TJOchFaDbFOWbi+dbWpXGfJ3QmYmzyoeZnBT
         es7xaN6+5xwJS/9rMR83Iiy+W+XMKffeWw29cWhdcNH8u9TOOvvifLl+d0EFyP2ioKUy
         roJTMB19ON6AfhLIrYETIRjmSgAVL6SMa1ARn+AqC8TJf91Zcl0P+kuv1hvYfePsypij
         drkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsGteZHXfk/hlEOFVKOGXrUJJ1NMn/MU3BMrE2tpg98=;
        b=0d7tC1v2bce8boEgPWoCAKw5pLj5foVmkcFoWd7nAmZdJbuuxUv+GrXzTXTgrJBNyY
         6XxwVmr/sQLggLIupxmSAHoWx7UOKr097IdCC4IteQagLaHKOV35SDlJdKHkpsKGN4xS
         b6OVAF9m5Z70dbG/2veZsLzU1ckSB83vhXadOoLoj/u/dEwL8WmZwAGGlasSB9HE0PE3
         nfNJhC+ZT3RN+Jv/G4WHTLg2fHzKwNbGt/Nfyb4I7xfofInMbvDq7m4AFZAGx54fMTk5
         vWEU+7fSsiB1IfRWrQDhUMtQOAbCnYsvtCjIH3RFAIxCON438r4+Ua5eDthnK7YP/DPA
         qPsw==
X-Gm-Message-State: AFqh2ko/dKbUOHY3GPvIV8cN9XUUxr6j6p22KUHRpZmmuPNWCQrfVF40
        RrMwJ9s9GwVkXInafCJL/SsesN96RItGxp1aiL/A
X-Google-Smtp-Source: AMrXdXsXLNE5OwDnszGWJOUAwwbbdXlYhbtEfIpbTEfNdeC3G5kYgjtn/s2awg9R3cNFNZ0QfPoCp4S+Z4SGNpc6WdM=
X-Received: by 2002:a17:90b:87:b0:219:8ee5:8dc0 with SMTP id
 bb7-20020a17090b008700b002198ee58dc0mr339933pjb.72.1671672112623; Wed, 21 Dec
 2022 17:21:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671469167.git.pabeni@redhat.com> <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
 <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com> <944c4ab043713f75ad3bb512fc146e48de7b3e25.camel@redhat.com>
In-Reply-To: <944c4ab043713f75ad3bb512fc146e48de7b3e25.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Dec 2022 20:21:41 -0500
Message-ID: <CAHC9VhTZ-boJeMs3ir-6=rCxyfY3ROjZ4qeXyuoo5DRPBw6gew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 21, 2022 at 2:24 PM Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2022-12-20 at 17:07 -0500, Paul Moore wrote:
> > On Mon, Dec 19, 2022 at 12:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > >
> > > Newly added subflows should inherit the associated label
> > > from the current process context, regarless of the sk_kern_sock
> > > flag value.
> > >
> > > This patch implements the above resetting the subflow sid, deleting
> > > the existing subflow label, if any, and then re-creating a new one.
> > >
> > > The new helper reuses the selinux_netlbl_sk_security_free() function,
> > > and it can end-up being called multiple times with the same argument;
> > > we additionally need to make it idempotent.
> > >
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > v1 -> v2:
> > >  - fix build issue with !CONFIG_NETLABEL
> > > ---
> > >  security/selinux/hooks.c    | 27 +++++++++++++++++++++++++++
> > >  security/selinux/netlabel.c |  4 +++-
> > >  2 files changed, 30 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 3c5be76a9199..f785600b666a 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -5476,6 +5476,32 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
> > >         selinux_netlbl_sctp_sk_clone(sk, newsk);
> > >  }
> > >
> > > +static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> > > +{
> > > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > +       struct sk_security_struct *ssksec = ssk->sk_security;
> > > +       u16 sclass;
> > > +       u32 sid;
> > > +       int err;
> > > +
> > > +       /* create the sid using the current cred, regardless of the ssk kern
> > > +        * flag
> > > +        */
> > > +       sclass = socket_type_to_security_class(ssk->sk_family, ssk->sk_type,
> > > +                                              ssk->sk_protocol);
> > > +       err = socket_sockcreate_sid(tsec, sclass, &sid);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       ssksec->sid = sid;
> > > +
> > > +       /* replace the existing subflow label deleting the existing one
> > > +        * and re-recrating a new label using the current context
> > > +        */
> > > +       selinux_netlbl_sk_security_free(ssksec);
> > > +       return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
> > > +}
> >
> > I thought the idea was to ensure that new subflows of an existing
> > MPTCP connection would be created with the same label as the main
> > MPTCP connection socket?  The code above labels the new subflow based
> > on the current process, not the main MPTCP connection; it matches the
> > commit description, but not what we had previously discussed - or I am
> > horribly mis-remembering something? :)
>
> You are right, I picked a wrong turn.
>
> I just tested the other option and there is another problem :(

It's never easy, is it? ;)

> The first subflow creations happens inside af_inet->create, via the sk-
> >sk_prot->init() hook. The security_socket_post_create() call on the
> owning MPTCP sockets happens after that point. So we copy data from a
> not yet initialized security context (and the test fail badly).

Hmmm.  Let's come back to this later on down this email.

> There are a few options to cope with that:
> - [ugly hack] call  security_socket_post_create() on the mptcp code
> before creating the subflow. I experimented this just to double the
> problem and a possible solution.

I'm guessing "[ugly hack]" is probably a bit of an understatement.
Let's see if we can do better before we explore this option too much
further.

> - refactor the mptcp code to create the first subflow on later
> syscalls, as needed. This will require quite a bit of refactoring in
> the MPTCP protocol as we will need also to update the
> shutdown/disconnect accordingly (currently we keep the first subflow
> around, instead we will need to close it).

Let's see if we can avoid having to do this too.

> - use the code proposed in these patches as-is ;)

That's a non-starter from a SELinux perspective as the label is
incorrect.  It would be similar to saying that for each fork() call
the resulting child process would always run as root since we couldn't
figure out how to assign the credentials properly :)

> WDYT?

Let's go back to the the inet_create() case for a little bit.  I'm
thinking we might be able to do something by leveraging the
sk_alloc()->sk_prot_alloc()->security_sk_alloc() code path.  As
inet_create() is going to be called from task context here, it seems
like we could do the sock's sid/sclass determination here, cached in
separate fields in the sk_security_struct if necessary, and use those
in a new MPTCP subflow hook.  We could also update
selinux_socket_post_create() to take advantage of this as well.  We
could also possibly pass the proto struct into security_sk_alloc() if
we needed to identify IPPROTO_MPTCP there as well.

I'll admit to not chasing down all the details, but I suspect this may
be the cleanest option - thoughts?

--
paul-moore.com
