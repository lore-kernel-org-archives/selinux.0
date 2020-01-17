Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF7BC33CB1
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C982073A
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 14:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhwTErbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAQOEX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:04:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39178 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAQOEX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 09:04:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id l2so26528337lja.6
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 06:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6JnhYzXah78fKArkGz8CnUAm+xkDvkuvu1en6BFlzA=;
        b=vhwTErbe73hyjHonatjq4NHXz7ll1gVwQWA+Ntr7n9N7/RNobTt9qyB5Ca5Os9W6HK
         PGNh5XI/2JPDnayi/RdJ/4GzJlfgMNgBWAHz4XlJyZ1O866LYaD3AdunxGpbl6uJLTuz
         ZRpbhv7wrL1fmWcPJqtLfdTgXrw9g5z+n/VL5ag4wF+QEPJrZl2ii5NATSlAWSbG1320
         Hg/BayxZ40ODzkJdRmCKbWqJ8NizsryfuG2/RHCfvPgBO7a5H2cVS3oew9P2CcqTfChJ
         Dm2ilX9Dvf/UrCfSamhetNnpaFZhJCapA2Qo4tesWBVDPaAlY9PBTvrHkrLbTPgmaONC
         ED1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6JnhYzXah78fKArkGz8CnUAm+xkDvkuvu1en6BFlzA=;
        b=dzj4RL4lSlHw4ygP32PIjFeJ5JyXbYGKTcIThTlDayD0SL7a29Ad8PQzkFLBLoE+te
         p7XuwgKYMulCtT1suuml6TdkRGw6ULCzpF1xs6AMV21NTo2jTBwruQ6PzYW4rgBcjF4L
         AGFFgqmVB/i7qOpxvXo+fpiy/cj+rNkH+QhzGTAjM0hYKjXx/orR8jLTyiNEhSi3ygzc
         L6XsH0282iewGO1EhfcMWPusSO0+BKEn4NiPsUWFyi1dnAgVeR5VVuI5HHkjHao1YVMR
         hw8aOkys7tSRYTt+umWJPrXFDOyd7eVHonnmAOwagvNwFncXsP7VoOGEW8ttCxI0knf+
         c96A==
X-Gm-Message-State: APjAAAWxbBpkX1CDXOA0IDyu+0KrdIqotwmZ7Otr/u5FSvyiN9ew8DQA
        TbJuD2+fyBQsWLNt10t8xahEiX2eGdbz39Ds9L2EDM81gAA=
X-Google-Smtp-Source: APXvYqxTIyrgecxA9hwpwiD/YzBxhgZ/kvWehYkMsuRl6SnPni+7ar+PKYbLWeZGOCUCPJq4USHT7PMmXHGUBeTljd0=
X-Received: by 2002:a2e:805a:: with SMTP id p26mr5760443ljg.242.1579269860974;
 Fri, 17 Jan 2020 06:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20200116142653.61738-1-jeffv@google.com> <CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com>
 <CABXk95Au74Dg8PvxochStgUwhurDtokntvg9WD-WaJmMhHJ+hw@mail.gmail.com> <87d0bii7h9.fsf@gmail.com>
In-Reply-To: <87d0bii7h9.fsf@gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Fri, 17 Jan 2020 15:04:09 +0100
Message-ID: <CABXk95D6=fnM073XKpSiwEkLP3oEMVJDjhKTse7646GOhzu6qg@mail.gmail.com>
Subject: Re: [PATCH] selinux: map RTM_GETLINK to a privileged permission
To:     Dominick Grift <dac.override@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 1:38 PM Dominick Grift <dac.override@gmail.com> wrote:
>
> Jeffrey Vander Stoep <jeffv@google.com> writes:
>
> > On Fri, Jan 17, 2020 at 1:32 AM Paul Moore <paul@paul-moore.com> wrote:
> >>
> >> On Thu, Jan 16, 2020 at 9:27 AM Jeff Vander Stoep <jeffv@google.com> wrote:
> >> > Persistent device identifiers like MAC addresses are sensitive
> >> > because they are (usually) unique and can be used to
> >> > identify/track a device or user [1]. The MAC address is
> >> > accessible via the RTM_GETLINK request message type of a netlink
> >> > route socket[2] which returns the RTM_NEWLINK message.
> >> > Mapping RTM_GETLINK to a separate permission enables restricting
> >> > access to the MAC address without changing the behavior for
> >> > other RTM_GET* message types.
> >> >
> >> > [1] https://adamdrake.com/mac-addresses-udids-and-privacy.html
> >> > [2] Other access vectors like ioctl(SIOCGIFHWADDR) are already covered
> >> > by existing LSM hooks.
> >> >
> >> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>
> Pardon my intrusion but I am trying to determine whether I would be able
> to leverage this functionality and I would appreciate any comments,
> suggestions etc.
>
> I have two commits:
>
> 1. Adding nlmsg_readpriv to netlink_route_socket, and adding the
> netlink_route_getlink policy capability.
>
> This commit effectively changes nothing whether I have the polcap
> enabled or not.

Yes, this change is necessary but not sufficient. You must also block other
access vectors.

>
> https://defensec.nl/gitweb/dssp2.git/commitdiff/83162d18c6f829de418921339269fa41b4e61882
>
> 2. leveraging nlmsg_readpriv
>
> This adds a permissionx for "all netlink_route_socket ioctl except
> SIOCGIFHWADDR and two classpermissions that are basically the
> r_netlink_route_socket_perms and create_netlink_route_socket_perms
> equivalents but without ioctl and nlmsg_readpriv.
>
> https://defensec.nl/gitweb/dssp2.git/commit/1ab25105ede7a085f85c1b11b3abbc8e5b80dae5
>
> The idea is that domains that shouldnt have access to mac addresses (I
> suppose the majority) will use for example ...
>
> (allow mydomain self r_netlink_route_except_ioctl_and_nlmsg_readpriv_socket_perms)
> (allowx mydomain self netlink_route_socket_ioctl_except_SIOCGIFHWADDR)
>
> ... whereas everything else will keep using the existing
> r_netlink_route_socket_perms or create_netlink_route_socket_perms
>
> Does this make sense to you, and are these all the *direct* access
> vectors to get mac addresses?

I restrict three vectors
1. RTM_GETLINK on netlink_route sockets
2. bind() on netlink_route sockets.
3. SIOCGIFHWADDR ioctl for all sockets

That's sufficient on Android.
>
> I guess there would be indirect ways to get it from an entity that does
> have access to netlink_route_socket nlmsg_readpriv and SIOCGIFHWADDR but
> that is a different story.

Yes, laundering of permissions is a separate issue unrelated to this patch.

>
> >> > ---
> >> >  security/selinux/include/classmap.h |  2 +-
> >> >  security/selinux/include/security.h |  9 +++++++++
> >> >  security/selinux/nlmsgtab.c         | 26 +++++++++++++++++++++++++-
> >> >  security/selinux/ss/services.c      |  4 +++-
> >> >  4 files changed, 38 insertions(+), 3 deletions(-)
> >>
> >> ...
> >>
> >> > diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> >> > index c97fdae8f71b..aa7064a629a0 100644
> >> > --- a/security/selinux/nlmsgtab.c
> >> > +++ b/security/selinux/nlmsgtab.c
> >> > @@ -25,7 +25,7 @@ struct nlmsg_perm {
> >> >         u32     perm;
> >> >  };
> >> >
> >> > -static const struct nlmsg_perm nlmsg_route_perms[] =
> >> > +static struct nlmsg_perm nlmsg_route_perms[] =
> >> >  {
> >> >         { RTM_NEWLINK,          NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
> >> >         { RTM_DELLINK,          NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
> >> > @@ -208,3 +208,27 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
> >> >
> >> >         return err;
> >> >  }
> >> > +
> >> > +static void nlmsg_set_getlink_perm(u32 perm)
> >> > +{
> >> > +       int i;
> >> > +
> >> > +       for (i = 0; i < sizeof(nlmsg_route_perms)/sizeof(nlmsg_perm); i++) {
> >> > +               if (nlmsg_route_perms[i].nlmsg_type == RTM_GETLINK) {
> >> > +                       nlmsg_route_perms[i].perm = perm;
> >> > +                       break;
> >> > +               }
> >> > +       }
> >> > +}
> >> > +
> >> > +/**
> >> > + * The value permission guarding RTM_GETLINK changes if nlroute_getlink
> >> > + * policy capability is set.
> >> > + */
> >> > +void selinux_nlmsg_init(void)
> >> > +{
> >> > +       if (selinux_policycap_nlroute_getlink())
> >> > +               nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READPRIV);
> >> > +       else
> >> > +               nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READ);
> >> > +}
> >>
> >> Two comments, with the first being rather trivial:
> >>
> >> It might be nice to rename this to selinux_policycaps_init() or
> >> something similar; that way we have some hope of collecting similar
> >> policycaps related tweaks in one place.
> >>
> >> Our current handling of netlink messages is rather crude, especially
> >> when you consider the significance of the netlink messages and the
> >> rather coarse granularity when compared to other SELinux object
> >> classes.  I believe some (most? all?) of this is due to the number of
> >> netlink messages compared to the maximum number of permissions in an
> >> object class.  Back when xperms were added, one of the motivations for
> >> making it a general solution was to potentially use them for netlink;
> >> we obviously haven't made the change in the netlink controls, but I
> >> think this might be the right time to do it.
> >
> > That's a very large change with some unanswered questions - like how to handle
> > generic netlink. I will have time later this year to make that change.
> >
> > In the meantime, this change is small (ideal for backporting) and
> > consistent with
> > how we differentiate between levels of sensitivity on netlink_audit messages.
> > Would you consider taking v3 of this change with your suggested adjustment to
> > selinux_policycaps_init()?
> >
> > (Apologies for the resend, gmail switched out of "plain text" mode so my initial
> > response wasn't delivered to the mailing list).
> >
> >>
> >>
> >> --
> >> paul moore
> >> www.paul-moore.com
>
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
