Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF384C33CB6
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 00:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F5C217F4
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 00:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="W79Pe3SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgAQAc2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:32:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46587 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbgAQAc2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 19:32:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id f15so16971947lfl.13
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 16:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d4lsvQ3AI1PLOypohcfUH++7PEtJ3KUyxuaObkpzmas=;
        b=W79Pe3SI3L21lgtdV1omDcKNDDPBg4uehsWscJxS7izUnwFArqPLdj3Psh6MuG9Z6Q
         FyKg1+Z6xa1zt6W2whEMjcdyVeB2/u71iAXSDPQd5amAVjrZfBGZZQQ565dBvFdICavR
         UJSy2OOtp3VLYSIp10SSDmAA2DznVtSwTLxfnDCn0BFw1wwXuTLH5pQXBJpTPwFFD7+3
         PYS2wzmuZj66r+d0Aoti3UxdlR0egj/iFAgMrHqpHGOnVfdyxXGlIhjYONo8bhWAiMJp
         wrB3sM/oDs5IZcT+aFWQlFYQS6gK99pUFkneoSWQXb/ulknWVntpf1nJmUrACDpZsKiX
         pxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4lsvQ3AI1PLOypohcfUH++7PEtJ3KUyxuaObkpzmas=;
        b=LvkygClzKpu4/aRKDD/jrhgl9x8OC4MADXN1H5lzjlWee8q9Me+TEYmpLSe2wqfXvo
         JnwP5qTwEqXHMNTvXkVA7B0lWIKkcB6ZtxgK3nIW6f60++2D5H29Xl2YsUZVj3UASXid
         Nlz1L9LIv+FrzwnlbiH5qzjN2hsdNxpdPbb/wiPP5iIol9yDKLCibl7am15LwsvE6qv6
         Gh6n4S3rXB4JG9w3cN7RikxWbZRwcc7+MMAxmGwre+zD1hBhkP2+PGgK2D4x7/OyXz35
         G/cdar4URyN5R3IRcuKqhcOn1JdEn6iVhCP32zSVmJ0JkBEjEYLNRhfIn6BrOMoZA1NS
         Z4Iw==
X-Gm-Message-State: APjAAAWn3gD1sdLCUSEI986ngl2JuY68Y1ujhrWwYaxYe2vrWye5IzRd
        UkobQL1FljcrdMTnf7BD1o3lIzU92ubH37l03wAz
X-Google-Smtp-Source: APXvYqy4E9RZrgkev+fVP3F1QP4zEN5oB7Gq63XoPdERnIVBOoZSVk6XY9AtwhyP+kfXvYz1Jw+Vb9HKxMJlkbqdT0c=
X-Received: by 2002:ac2:4422:: with SMTP id w2mr3833386lfl.178.1579221146183;
 Thu, 16 Jan 2020 16:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20200116142653.61738-1-jeffv@google.com>
In-Reply-To: <20200116142653.61738-1-jeffv@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jan 2020 19:32:15 -0500
Message-ID: <CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com>
Subject: Re: [PATCH] selinux: map RTM_GETLINK to a privileged permission
To:     Jeff Vander Stoep <jeffv@google.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 16, 2020 at 9:27 AM Jeff Vander Stoep <jeffv@google.com> wrote:
> Persistent device identifiers like MAC addresses are sensitive
> because they are (usually) unique and can be used to
> identify/track a device or user [1]. The MAC address is
> accessible via the RTM_GETLINK request message type of a netlink
> route socket[2] which returns the RTM_NEWLINK message.
> Mapping RTM_GETLINK to a separate permission enables restricting
> access to the MAC address without changing the behavior for
> other RTM_GET* message types.
>
> [1] https://adamdrake.com/mac-addresses-udids-and-privacy.html
> [2] Other access vectors like ioctl(SIOCGIFHWADDR) are already covered
> by existing LSM hooks.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  security/selinux/include/classmap.h |  2 +-
>  security/selinux/include/security.h |  9 +++++++++
>  security/selinux/nlmsgtab.c         | 26 +++++++++++++++++++++++++-
>  security/selinux/ss/services.c      |  4 +++-
>  4 files changed, 38 insertions(+), 3 deletions(-)

...

> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index c97fdae8f71b..aa7064a629a0 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -25,7 +25,7 @@ struct nlmsg_perm {
>         u32     perm;
>  };
>
> -static const struct nlmsg_perm nlmsg_route_perms[] =
> +static struct nlmsg_perm nlmsg_route_perms[] =
>  {
>         { RTM_NEWLINK,          NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
>         { RTM_DELLINK,          NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
> @@ -208,3 +208,27 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
>
>         return err;
>  }
> +
> +static void nlmsg_set_getlink_perm(u32 perm)
> +{
> +       int i;
> +
> +       for (i = 0; i < sizeof(nlmsg_route_perms)/sizeof(nlmsg_perm); i++) {
> +               if (nlmsg_route_perms[i].nlmsg_type == RTM_GETLINK) {
> +                       nlmsg_route_perms[i].perm = perm;
> +                       break;
> +               }
> +       }
> +}
> +
> +/**
> + * The value permission guarding RTM_GETLINK changes if nlroute_getlink
> + * policy capability is set.
> + */
> +void selinux_nlmsg_init(void)
> +{
> +       if (selinux_policycap_nlroute_getlink())
> +               nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READPRIV);
> +       else
> +               nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READ);
> +}

Two comments, with the first being rather trivial:

It might be nice to rename this to selinux_policycaps_init() or
something similar; that way we have some hope of collecting similar
policycaps related tweaks in one place.

Our current handling of netlink messages is rather crude, especially
when you consider the significance of the netlink messages and the
rather coarse granularity when compared to other SELinux object
classes.  I believe some (most? all?) of this is due to the number of
netlink messages compared to the maximum number of permissions in an
object class.  Back when xperms were added, one of the motivations for
making it a general solution was to potentially use them for netlink;
we obviously haven't made the change in the netlink controls, but I
think this might be the right time to do it.

--
paul moore
www.paul-moore.com
