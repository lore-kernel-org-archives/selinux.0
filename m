Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476ACC33CB1
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 08:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1722820728
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 08:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ1IWc99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgAQI2H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:28:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44828 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgAQI2H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 03:28:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so1770770ljj.11
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 00:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6vnz+Pn2pq+eJZDyFozEgm8JdknLWIc505/mS8ilIk=;
        b=GJ1IWc99z2lHDs1BJe5jBU1IyPq6BIfG8RO1Dp+TrCNd+HzILNTJO80vXMiky/TACb
         E4ILlY6JP4mAdbMiS+q3xdGYjsqc5HJl+HoNz7yufzi/dhSOyqp1LWPxDA5uyykkLECc
         Sv4GOzHNRWtjAthg4yZygimiN/GwQ0CQfgSCDdVU4pCIby4N2VZy1gesst22n73F5xl6
         yiHnjXhvaHjHk3uMzFVs9wUhD8bfZVGlD+gUGmGwGjIdhZqW3ioupq2z1v5dashz+v88
         8I3JRAt9zJuG/0yH/Z20/Qxh/7qXGRVBTc30DR1H/L3Zt7dcxme7h+SJ+8WrVrOpBOEC
         BeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6vnz+Pn2pq+eJZDyFozEgm8JdknLWIc505/mS8ilIk=;
        b=iwu0T7ctYcBG/8n06j4fjn/28tj4gppvBbV3dF5DaCdwZwFfMoBuBygHAwCoQl7AJ2
         toZJdmBGhJiDr3xkJkDhQQQQhdWjh+QvNsyYLV7xNG2JevwNokQbaSc0rRGc5NP+boZ2
         nsWsjCOJRrhqoVZfu2skvIniFFcczke/VQnHntFcsYwebYfHPJvU9JcNf3Nws/8u8pql
         2WB3UbYqBElIYQ33L6S5jwOic/prjYDECnZGhhIem/EuNBLX47/ohS2IjXo3ro2xvUxk
         RkJZ+vuCi+/JZvdI101BWtu9RD2xBEt0OUuh47gdfmCHuidAoZ8evxfq0rfcw39S3xdn
         ECFg==
X-Gm-Message-State: APjAAAUAku/HgS8Paj2hhV1w0FkFTKhh+8fh0FrvyNa30zX2CUTaQSuB
        TH8OF8lhcRDtYY0S2uQwu6QUArN8hSCOw5gU9NimR0ipzdQ=
X-Google-Smtp-Source: APXvYqzISa+ZzOmjuPyXHceEtbvv3kDDY0th+JLTOKcuIIYHwG0kfap07TzSV1GXiIDmBOIwJfkvyME9kn4AHLSsaHQ=
X-Received: by 2002:a2e:8916:: with SMTP id d22mr4612134lji.19.1579249685111;
 Fri, 17 Jan 2020 00:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20200116142653.61738-1-jeffv@google.com> <CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com>
In-Reply-To: <CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Fri, 17 Jan 2020 09:27:53 +0100
Message-ID: <CABXk95Au74Dg8PvxochStgUwhurDtokntvg9WD-WaJmMhHJ+hw@mail.gmail.com>
Subject: Re: [PATCH] selinux: map RTM_GETLINK to a privileged permission
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 1:32 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Jan 16, 2020 at 9:27 AM Jeff Vander Stoep <jeffv@google.com> wrote:
> > Persistent device identifiers like MAC addresses are sensitive
> > because they are (usually) unique and can be used to
> > identify/track a device or user [1]. The MAC address is
> > accessible via the RTM_GETLINK request message type of a netlink
> > route socket[2] which returns the RTM_NEWLINK message.
> > Mapping RTM_GETLINK to a separate permission enables restricting
> > access to the MAC address without changing the behavior for
> > other RTM_GET* message types.
> >
> > [1] https://adamdrake.com/mac-addresses-udids-and-privacy.html
> > [2] Other access vectors like ioctl(SIOCGIFHWADDR) are already covered
> > by existing LSM hooks.
> >
> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> > ---
> >  security/selinux/include/classmap.h |  2 +-
> >  security/selinux/include/security.h |  9 +++++++++
> >  security/selinux/nlmsgtab.c         | 26 +++++++++++++++++++++++++-
> >  security/selinux/ss/services.c      |  4 +++-
> >  4 files changed, 38 insertions(+), 3 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> > index c97fdae8f71b..aa7064a629a0 100644
> > --- a/security/selinux/nlmsgtab.c
> > +++ b/security/selinux/nlmsgtab.c
> > @@ -25,7 +25,7 @@ struct nlmsg_perm {
> >         u32     perm;
> >  };
> >
> > -static const struct nlmsg_perm nlmsg_route_perms[] =
> > +static struct nlmsg_perm nlmsg_route_perms[] =
> >  {
> >         { RTM_NEWLINK,          NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
> >         { RTM_DELLINK,          NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
> > @@ -208,3 +208,27 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
> >
> >         return err;
> >  }
> > +
> > +static void nlmsg_set_getlink_perm(u32 perm)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < sizeof(nlmsg_route_perms)/sizeof(nlmsg_perm); i++) {
> > +               if (nlmsg_route_perms[i].nlmsg_type == RTM_GETLINK) {
> > +                       nlmsg_route_perms[i].perm = perm;
> > +                       break;
> > +               }
> > +       }
> > +}
> > +
> > +/**
> > + * The value permission guarding RTM_GETLINK changes if nlroute_getlink
> > + * policy capability is set.
> > + */
> > +void selinux_nlmsg_init(void)
> > +{
> > +       if (selinux_policycap_nlroute_getlink())
> > +               nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READPRIV);
> > +       else
> > +               nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READ);
> > +}
>
> Two comments, with the first being rather trivial:
>
> It might be nice to rename this to selinux_policycaps_init() or
> something similar; that way we have some hope of collecting similar
> policycaps related tweaks in one place.
>
> Our current handling of netlink messages is rather crude, especially
> when you consider the significance of the netlink messages and the
> rather coarse granularity when compared to other SELinux object
> classes.  I believe some (most? all?) of this is due to the number of
> netlink messages compared to the maximum number of permissions in an
> object class.  Back when xperms were added, one of the motivations for
> making it a general solution was to potentially use them for netlink;
> we obviously haven't made the change in the netlink controls, but I
> think this might be the right time to do it.

That's a very large change with some unanswered questions - like how to handle
generic netlink. I will have time later this year to make that change.

In the meantime, this change is small (ideal for backporting) and
consistent with
how we differentiate between levels of sensitivity on netlink_audit messages.
Would you consider taking v3 of this change with your suggested adjustment to
selinux_policycaps_init()?

(Apologies for the resend, gmail switched out of "plain text" mode so my initial
response wasn't delivered to the mailing list).

>
>
> --
> paul moore
> www.paul-moore.com
