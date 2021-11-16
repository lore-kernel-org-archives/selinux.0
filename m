Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E6FC433F5
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 18:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 704EF6322C
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 18:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbhKPSaz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbhKPSax (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Nov 2021 13:30:53 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6695C061764
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 10:27:55 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id l22so55651143lfg.7
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 10:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmUF+XHt5UMmvtXjqccnnrTICQvOpLQ3BMx1RPbwk2g=;
        b=BHqEPqd/dHPJNc9yqmx57DQl9GrYALFnDShsnob6UVxWdUZyQYMHacQeNHUnSLI4ZA
         sqa+hK18Jz9sRr2Baxp5mAHyI9aZLmUhnAFnKAg+OcaQsL89Ihtue7m6tEMbrP8QqD+W
         R00CywLRPWb8w51eYuuS/7FjwSQkcI7aW0iI8c3zyscw8CkKsg/oJUNva6/1ijZdkZZ5
         SDbwv97ZxclXYsg/co55tsleixdHxT9eHdej8YO3eoYk/E06pDRb9CyilUo8Wr/IVBYl
         02WLxRnQ/+PfmI97cl41w0PXX7oQRLEfu36xzWVM3YPWghiZCmiJt1/ufuFQhuuBgK72
         TXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmUF+XHt5UMmvtXjqccnnrTICQvOpLQ3BMx1RPbwk2g=;
        b=T3IYkAOgzLaYfolOQj+h2Dfz9ccMEoszBEuAgpwFpaF64ne8h3sq8NV2s5pzInYSiw
         GrtIYY26Zfgi6yJiLs53KZm/td+bxYT7NcXP9ew7FAdQP4Lx1hRaakyDVgjkdsq31ehB
         rcZ30nRnw5Y5TNILCJvrGOfHz8PStmIExEfcS/NSfsi+x9z2NwlvkP8JwucisuM8b9mt
         JkVMpf1J2UBoThAA1gIiOyTZVvi3pJ0KnO5ICyK03SuTWA2T529CBvrbN/ENmU1rrOSX
         YN+ro4/Fu0drd5BNAOkJZnm4Agtr797n7WdkkPeNdHCZwD0vaRSnQqQc20aqlwgVwzXa
         8EZg==
X-Gm-Message-State: AOAM533ytgtg6cwsjV0ykmNLZgKjmNXkSOY3pyIAtzE/9HlSWI3VTOUg
        MTaujeJ1UlJm2a6Cjii+R4B0EosG+n6EZTxY1xPtLmpFRsQ=
X-Google-Smtp-Source: ABdhPJx9+J/QE2JwvJwaGAX+6PMo4b25s+AIx1dRprLGlelQLazarhz8vMuuyQuox/v7bXSC7kd7OPyO/35Y5z6T+IQ=
X-Received: by 2002:a05:6512:31d1:: with SMTP id j17mr8517288lfe.395.1637087274064;
 Tue, 16 Nov 2021 10:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20211110111308.3463879-1-brambonne@google.com> <CAEjxPJ5ZiVHuYNXBgkKLb2CLCkpUqo-20mAm-sqbk=zt9NH-MQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5ZiVHuYNXBgkKLb2CLCkpUqo-20mAm-sqbk=zt9NH-MQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 16 Nov 2021 13:27:43 -0500
Message-ID: <CAEjxPJ7866ixbN28shuy8BoH_tjXqn61CYpmNBEM-DDHJjoW-A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add netlink xperm support
To:     Bram Bonne <brambonne@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 16, 2021 at 10:41 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Nov 10, 2021 at 6:13 AM Bram Bonne <brambonne@google.com> wrote:
> >
> > Reuse the existing extended permissions infrastructure to support
> > sepolicy for different netlink message types.
> >
> > When individual netlink message types are omitted only the existing
> > permissions are checked. As is the case for ioctl xperms, this feature
> > is intended to provide finer granularity for nlmsg_read and nlmsg_write
> > permissions, as they may be too imprecise. For example, a single
> > NETLINK_ROUTE socket may provide access to both an interface's IP
> > address and to its ARP table, which might have different privacy
> > implications. In addition, the set of message types has grown over time,
> > so even if the current list is acceptable, future additions might not be.
> > It was suggested before on the mailing list [1] that extended permissions
> > would be a good fit for this purpose.
> >
> > Existing policy using the nlmsg_read and nlmsg_write permissions will
> > continue to work as-is. Similar to ioctl xperms, netlink xperms allow
> > for a more fine-grained policy where needed.
> >
> > Example policy on Android, preventing regular apps from accessing the
> > device's MAC address and ARP table, but allowing this access to
> > privileged apps, looks as follows:
> >
> > allow netdomain self:netlink_route_socket {
> >         create read getattr write setattr lock append connect getopt
> >         setopt shutdown nlmsg_read
> > };
> > allowxperm netdomain self:netlink_route_socket nlmsg ~{
> >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > };
> > allowxperm priv_app self:netlink_route_socket nlmsg {
> >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > };
> >
> > Android currently uses code similar to [1] as a temporary workaround to
> > limit access to certain netlink message types; our hope is that this patch
> > will allow us to move back to upstream code with an approach that works for
> > everyone.
> >
> > [1] https://lore.kernel.org/selinux/CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com/
> >
> > Signed-off-by: Bram Bonne <brambonne@google.com>
> > ---
> >  security/selinux/hooks.c       | 24 +++++++++++++++++++++++-
> >  security/selinux/ss/avtab.h    |  1 +
> >  security/selinux/ss/services.c | 23 ++++++++++++++++++++++-
> >  3 files changed, 46 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index e7ebd45ca345..a503865fabed 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4662,6 +4662,28 @@ static int sock_has_perm(struct sock *sk, u32 perms)
> >                             &ad);
> >  }
> >
> > +static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_type)
> > +{
> > +       struct sk_security_struct *sksec = sk->sk_security;
> > +       struct common_audit_data ad;
> > +       struct lsm_network_audit net = {0,};
> > +       u8 xperm;
> > +
> > +       if (sksec->sid == SECINITSID_KERNEL)
> > +               return 0;
> > +
> > +       ad.type = LSM_AUDIT_DATA_NET;
> > +       ad.u.net = &net;
> > +       ad.u.net->sk = sk;
> > +
> > +       // nlmsg_types comfortably fit into a single driver, see RTM_MAX in uapi/linux/rtnetlink.h
> > +       xperm = nlmsg_type & 0xff;
>
> This seems like a dangerous assumption; obviously not all netlink
> users are rtnetlink. Even if all existing netlink users follow this,
> nothing prevents userspace from creating a netlink message that
> violates it AFAIK, at which point you will just silently discard the
> higher bits. If we think we can get away with this restriction, then
> we need to enforce it here (i.e. return an error if they do not fit);
> if not,
> then we likely need to support multiple drivers with a simple mapping
> of the upper bits to driver.

Also, it would be very helpful if you were to add a test to the
selinux-testsuite [1] for this new checking.
There are some tests of the ioctl xperms checking there [2].

[1] https://github.com/selinuxproject/selinux-testsuite
[2] https://github.com/SELinuxProject/selinux-testsuite/commit/b6e5e01a282582322185d67eb628569ac1a9f2dc
