Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE45C33CB1
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 12:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF19420730
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 12:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueVgdR16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgAQMh7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:37:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35847 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgAQMh7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 07:37:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so22585151wru.3
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 04:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t8SV5g/N1Ujw8YXEiMA8goK6pHEl3rKDEVHVl/tTyA0=;
        b=ueVgdR161pdSmaEnjYV5DT2EXJ/PxEGHWSgaAL1s/xcEYVlsqoRRNNN4WF/YvJJK9s
         xN3wNinihB2gQ+Gb+46x3XQmQW1ki7DiKKf3vOHFI52eOsPN56sUzLcGenZPOFxwBu8v
         HjGfasQ7mlGBtJ1PNWFI1s4/Uq5REGVnG8F7Xn0lnh974fn0PjCMsTX7TS5sUBbSmR3i
         usvNccwTmaOD2WYMfm7R6AGjQkalavAak/8C6WbNP6nmtcxFCcZ4nmuYL3krkjc7Tvb3
         V6ncx7uSP930AuKrDA9jc9nXM9b/7j+KxlPSaRXha+w4VKm86cSQqHUNNqXRG00LMmld
         e1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=t8SV5g/N1Ujw8YXEiMA8goK6pHEl3rKDEVHVl/tTyA0=;
        b=SKwXtBz5mbplCZF7VeLg2B+wkLFmRsYmSetQNjGnvWMxRrxb8fkpG65v0MNTvc64E8
         vR/krFJk4ofXb8o4TngzpPPa1m2Dkfj300LSBCH6y/720oFPtW31GftAQ0BMAFmba6Uo
         8y2mOYpQH9tjlLGFN0fQQh2wDCbvAQ2747dv5KqtExiFHzuC7ierQWU5FL8Mtm0Q4zvk
         l4rm1p3rO1WBTD8NPlWaVqyTFrIV+sNvGg9MBl4DIokiM8QGbflOfArkVJkLVMFKMBqH
         wlqsMTHWIECvTgBGNSMbS/xfXOVNBWWErYtwUQgKtbbUaZKRsDMNbXAHgr8gKYZxvZIS
         D4tQ==
X-Gm-Message-State: APjAAAUXRoB5no0hsRxwTjie+7rBDjsZKLhe2ZQDb6FBku3buRZGIK72
        o4SHYsfQR9V7N0nc8Cbfqi1sGYs7
X-Google-Smtp-Source: APXvYqyNn1q50qVlI86bzW47qwI2eXndADTuIjFPGu+GFYq8QnJsHE9Vj6wui8EhiK0NQRyPKVkJbg==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr2932708wrm.324.1579264677579;
        Fri, 17 Jan 2020 04:37:57 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id u1sm4187731wmc.5.2020.01.17.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 04:37:56 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: map RTM_GETLINK to a privileged permission
References: <20200116142653.61738-1-jeffv@google.com>
        <CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com>
        <CABXk95Au74Dg8PvxochStgUwhurDtokntvg9WD-WaJmMhHJ+hw@mail.gmail.com>
Date:   Fri, 17 Jan 2020 13:37:54 +0100
In-Reply-To: <CABXk95Au74Dg8PvxochStgUwhurDtokntvg9WD-WaJmMhHJ+hw@mail.gmail.com>
        (Jeffrey Vander Stoep's message of "Fri, 17 Jan 2020 09:27:53 +0100")
Message-ID: <87d0bii7h9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Jeffrey Vander Stoep <jeffv@google.com> writes:

> On Fri, Jan 17, 2020 at 1:32 AM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Thu, Jan 16, 2020 at 9:27 AM Jeff Vander Stoep <jeffv@google.com> wrote:
>> > Persistent device identifiers like MAC addresses are sensitive
>> > because they are (usually) unique and can be used to
>> > identify/track a device or user [1]. The MAC address is
>> > accessible via the RTM_GETLINK request message type of a netlink
>> > route socket[2] which returns the RTM_NEWLINK message.
>> > Mapping RTM_GETLINK to a separate permission enables restricting
>> > access to the MAC address without changing the behavior for
>> > other RTM_GET* message types.
>> >
>> > [1] https://adamdrake.com/mac-addresses-udids-and-privacy.html
>> > [2] Other access vectors like ioctl(SIOCGIFHWADDR) are already covered
>> > by existing LSM hooks.
>> >
>> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Pardon my intrusion but I am trying to determine whether I would be able
to leverage this functionality and I would appreciate any comments,
suggestions etc.

I have two commits:

1. Adding nlmsg_readpriv to netlink_route_socket, and adding the
netlink_route_getlink policy capability.

This commit effectively changes nothing whether I have the polcap
enabled or not.

https://defensec.nl/gitweb/dssp2.git/commitdiff/83162d18c6f829de418921339269fa41b4e61882

2. leveraging nlmsg_readpriv

This adds a permissionx for "all netlink_route_socket ioctl except
SIOCGIFHWADDR and two classpermissions that are basically the
r_netlink_route_socket_perms and create_netlink_route_socket_perms
equivalents but without ioctl and nlmsg_readpriv.

https://defensec.nl/gitweb/dssp2.git/commit/1ab25105ede7a085f85c1b11b3abbc8e5b80dae5

The idea is that domains that shouldnt have access to mac addresses (I
suppose the majority) will use for example ...

(allow mydomain self r_netlink_route_except_ioctl_and_nlmsg_readpriv_socket_perms)
(allowx mydomain self netlink_route_socket_ioctl_except_SIOCGIFHWADDR)

... whereas everything else will keep using the existing
r_netlink_route_socket_perms or create_netlink_route_socket_perms

Does this make sense to you, and are these all the *direct* access
vectors to get mac addresses?

I guess there would be indirect ways to get it from an entity that does
have access to netlink_route_socket nlmsg_readpriv and SIOCGIFHWADDR but
that is a different story.

>> > ---
>> >  security/selinux/include/classmap.h |  2 +-
>> >  security/selinux/include/security.h |  9 +++++++++
>> >  security/selinux/nlmsgtab.c         | 26 +++++++++++++++++++++++++-
>> >  security/selinux/ss/services.c      |  4 +++-
>> >  4 files changed, 38 insertions(+), 3 deletions(-)
>>
>> ...
>>
>> > diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
>> > index c97fdae8f71b..aa7064a629a0 100644
>> > --- a/security/selinux/nlmsgtab.c
>> > +++ b/security/selinux/nlmsgtab.c
>> > @@ -25,7 +25,7 @@ struct nlmsg_perm {
>> >         u32     perm;
>> >  };
>> >
>> > -static const struct nlmsg_perm nlmsg_route_perms[] =
>> > +static struct nlmsg_perm nlmsg_route_perms[] =
>> >  {
>> >         { RTM_NEWLINK,          NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
>> >         { RTM_DELLINK,          NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
>> > @@ -208,3 +208,27 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
>> >
>> >         return err;
>> >  }
>> > +
>> > +static void nlmsg_set_getlink_perm(u32 perm)
>> > +{
>> > +       int i;
>> > +
>> > +       for (i = 0; i < sizeof(nlmsg_route_perms)/sizeof(nlmsg_perm); i++) {
>> > +               if (nlmsg_route_perms[i].nlmsg_type == RTM_GETLINK) {
>> > +                       nlmsg_route_perms[i].perm = perm;
>> > +                       break;
>> > +               }
>> > +       }
>> > +}
>> > +
>> > +/**
>> > + * The value permission guarding RTM_GETLINK changes if nlroute_getlink
>> > + * policy capability is set.
>> > + */
>> > +void selinux_nlmsg_init(void)
>> > +{
>> > +       if (selinux_policycap_nlroute_getlink())
>> > +               nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READPRIV);
>> > +       else
>> > +               nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READ);
>> > +}
>>
>> Two comments, with the first being rather trivial:
>>
>> It might be nice to rename this to selinux_policycaps_init() or
>> something similar; that way we have some hope of collecting similar
>> policycaps related tweaks in one place.
>>
>> Our current handling of netlink messages is rather crude, especially
>> when you consider the significance of the netlink messages and the
>> rather coarse granularity when compared to other SELinux object
>> classes.  I believe some (most? all?) of this is due to the number of
>> netlink messages compared to the maximum number of permissions in an
>> object class.  Back when xperms were added, one of the motivations for
>> making it a general solution was to potentially use them for netlink;
>> we obviously haven't made the change in the netlink controls, but I
>> think this might be the right time to do it.
>
> That's a very large change with some unanswered questions - like how to handle
> generic netlink. I will have time later this year to make that change.
>
> In the meantime, this change is small (ideal for backporting) and
> consistent with
> how we differentiate between levels of sensitivity on netlink_audit messages.
> Would you consider taking v3 of this change with your suggested adjustment to
> selinux_policycaps_init()?
>
> (Apologies for the resend, gmail switched out of "plain text" mode so my initial
> response wasn't delivered to the mailing list).
>
>>
>>
>> --
>> paul moore
>> www.paul-moore.com

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
