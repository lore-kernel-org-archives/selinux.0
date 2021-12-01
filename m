Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA6FC433EF
	for <selinux@archiver.kernel.org>; Wed,  1 Dec 2021 22:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbhLAWk6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343789AbhLAWkx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Dec 2021 17:40:53 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12AC061574
        for <selinux@vger.kernel.org>; Wed,  1 Dec 2021 14:37:31 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x6so107745200edr.5
        for <selinux@vger.kernel.org>; Wed, 01 Dec 2021 14:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvFYScnIiZpe7L5B2ESaQ5vLC1FYUUg118LAtBXizmU=;
        b=6Qqe8qyGlRgPKSqgx8BGmDAMfTZwHhed+t7gZHUl/ylBSGl38WA/z4dbaoBNfYuU2M
         oKWW5byF6LD3rfqwOAHOb/oLHvBttnRam8KbdpQm26Fx6uxGn9baK09U21QX49Jl99GS
         ppfd0zS/lrnF/yvexM2cd7VLtPkWJIWRF8XHxdjBP+Y2MQQ4wHY+a0lVC71tp9+SE5dW
         uylKsmIYrEORKJxyQg+GFXkIjb9FTZA1kJu9NwRIlfLSlDkWyH5olw8n0e/GeZW+9RXw
         T8NQ4s2UJSspfGimNr0QAFd7D3ckUaq4ZxOhDySrG6yiEFrO38tlbORc22p4i2S2R9Gt
         UGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvFYScnIiZpe7L5B2ESaQ5vLC1FYUUg118LAtBXizmU=;
        b=AEhNIQ22pJ/rLSs0XNy7dfRQdRKSl9e6EMEj9UIpXhnieER9gA8Ys2/X4GoBVsH2WX
         oKCK0a8TvavGp5r5/s8W1Wu9N79kn3W2SUw5+Hj+k9b6vmKb02b0Gx6cCFmRFCadmoiw
         NApcsQUNi7uMMYDHzRVqCOUlYAKq/9vp47rAV2/Ewww2CMJx4P82uX9W1NIYKyAyU9ik
         UuR48CUfDsBPPFGNs69CAtStZK8OmBgLlnubo7ksrDitKQIZwBFWPzldKXyACTN8Hpdp
         H58vRrR6af7qQPoM4W8CR5M/4Zw+sG4e5zfV8OgYHq41pBukteYgApzPjEmOPEP0vdPj
         zx/g==
X-Gm-Message-State: AOAM533CRBAlPY9uB1rTuhvIH1MppXA60JQLibgCy/2YagGhZuDwkOPy
        DzfaBykpUeDoFepDJ3nm6+J528X+HOeakObraeATf3RO6g==
X-Google-Smtp-Source: ABdhPJzIEed3i6BPJbCdFenIa9ELQQl4ItSqlfZIBYnELqxRsTrf1Y5966lZaRXTXsU1x689uhSEhdnsvLjsHjthWb8=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr10493046ejc.24.1638398250187;
 Wed, 01 Dec 2021 14:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20211110111308.3463879-1-brambonne@google.com>
 <CAEjxPJ5ZiVHuYNXBgkKLb2CLCkpUqo-20mAm-sqbk=zt9NH-MQ@mail.gmail.com> <CAEjxPJ6AFuND6uyph4m4FcZxQS38d-vf9z2ypC-h3vb6o5=gqg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6AFuND6uyph4m4FcZxQS38d-vf9z2ypC-h3vb6o5=gqg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Dec 2021 17:37:19 -0500
Message-ID: <CAHC9VhSFAj5Nr010pURESOX13kfAuj3NYGmG3Xt4bCRPYuJuiA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add netlink xperm support
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Bram Bonne <brambonne@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 18, 2021 at 9:46 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Nov 16, 2021 at 10:41 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Nov 10, 2021 at 6:13 AM Bram Bonne <brambonne@google.com> wrote:
> > >
> > > Reuse the existing extended permissions infrastructure to support
> > > sepolicy for different netlink message types.
> > >
> > > When individual netlink message types are omitted only the existing
> > > permissions are checked. As is the case for ioctl xperms, this feature
> > > is intended to provide finer granularity for nlmsg_read and nlmsg_write
> > > permissions, as they may be too imprecise. For example, a single
> > > NETLINK_ROUTE socket may provide access to both an interface's IP
> > > address and to its ARP table, which might have different privacy
> > > implications. In addition, the set of message types has grown over time,
> > > so even if the current list is acceptable, future additions might not be.
> > > It was suggested before on the mailing list [1] that extended permissions
> > > would be a good fit for this purpose.
> > >
> > > Existing policy using the nlmsg_read and nlmsg_write permissions will
> > > continue to work as-is. Similar to ioctl xperms, netlink xperms allow
> > > for a more fine-grained policy where needed.
> > >
> > > Example policy on Android, preventing regular apps from accessing the
> > > device's MAC address and ARP table, but allowing this access to
> > > privileged apps, looks as follows:
> > >
> > > allow netdomain self:netlink_route_socket {
> > >         create read getattr write setattr lock append connect getopt
> > >         setopt shutdown nlmsg_read
> > > };
> > > allowxperm netdomain self:netlink_route_socket nlmsg ~{
> > >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > > };
> > > allowxperm priv_app self:netlink_route_socket nlmsg {
> > >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > > };
> > >
> > > Android currently uses code similar to [1] as a temporary workaround to
> > > limit access to certain netlink message types; our hope is that this patch
> > > will allow us to move back to upstream code with an approach that works for
> > > everyone.
> > >
> > > [1] https://lore.kernel.org/selinux/CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com/
> > >
> > > Signed-off-by: Bram Bonne <brambonne@google.com>
> > > ---
> > >  security/selinux/hooks.c       | 24 +++++++++++++++++++++++-
> > >  security/selinux/ss/avtab.h    |  1 +
> > >  security/selinux/ss/services.c | 23 ++++++++++++++++++++++-
> > >  3 files changed, 46 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index e7ebd45ca345..a503865fabed 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -4662,6 +4662,28 @@ static int sock_has_perm(struct sock *sk, u32 perms)
> > >                             &ad);
> > >  }
> > >
> > > +static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_type)
> > > +{
> > > +       struct sk_security_struct *sksec = sk->sk_security;
> > > +       struct common_audit_data ad;
> > > +       struct lsm_network_audit net = {0,};
> > > +       u8 xperm;
> > > +
> > > +       if (sksec->sid == SECINITSID_KERNEL)
> > > +               return 0;
> > > +
> > > +       ad.type = LSM_AUDIT_DATA_NET;
> > > +       ad.u.net = &net;
> > > +       ad.u.net->sk = sk;
> > > +
> > > +       // nlmsg_types comfortably fit into a single driver, see RTM_MAX in uapi/linux/rtnetlink.h
> > > +       xperm = nlmsg_type & 0xff;
> >
> > This seems like a dangerous assumption; obviously not all netlink
> > users are rtnetlink. Even if all existing netlink users follow this,
> > nothing prevents userspace from creating a netlink message that
> > violates it AFAIK, at which point you will just silently discard the
> > higher bits. If we think we can get away with this restriction, then
> > we need to enforce it here (i.e. return an error if they do not fit);
> > if not,
> > then we likely need to support multiple drivers with a simple mapping
> > of the upper bits to driver.
>
> Looks like generic netlink puts the family id into the message type
> field, with the actual command in the separate generic netlink header
> in the payload. generic netlink family ids appear to be dynamically
> allocated, with GENL_MAX_ID defined as 1023. genl-ctrl-list on a
> sample Linux system reports ids from 0x10 through 0x1f so those would
> fit but there isn't anything in the code to prevent higher ids from
> being allocated up to the max. And if someday you want to be able to
> filter generic netlink messages at the per-command level, you'd
> further need to deal with the separate cmd field.

There is also NETLINK_AUDIT which currently has message types defined
up to 2000.  The netlink message header format allows for 16 bit
message types (look at the nlmsghdr struct) and I think it would be a
mistake if the SELinux netlink/xperms code didn't support a full 16
bits for the message type.

As far as NETLINK_GENERIC is concerned, yes, that's a bit of a
nuisance both with the dynamic family IDs and buried message types.
On the plus side, there are existing kernel functions that will
resolve the generic netlink family IDs to a genl_family struct but
those are currently private to the generic netlink code; I imagine if
there was a need those functions (or something similar) could be made
available outside of the genetlink.c.  Once you've matched on
NETLINK_GENERIC and done the family resolution, it should just be a
matter of doing the generic netlink command lookup in the context of
the family, which really shouldn't be much different than looking up
the message type of a conventional netlink message.

-- 
paul moore
www.paul-moore.com
