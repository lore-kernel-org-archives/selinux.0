Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9A1C43441
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 18:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761B4206B6
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 18:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NN2aF1oS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761B4206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeK2FuO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:50:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33668 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeK2FuO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 00:50:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so24428669ljd.0
        for <selinux@vger.kernel.org>; Wed, 28 Nov 2018 10:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyF6HkVr52XfG6RF2DOcWmYqiZYSWxWkllHnHVyKPAQ=;
        b=NN2aF1oSkDSTuqq0xWuPFuLCvrUpjbowsAO5RARgQW5VUpo9eJ3mLYqYmNHZaSXCcJ
         zGSoF1Y2L4ZdcDAxhxXF1DhtcJm+3wRwYaGC1ETkq7nzhUOy0ESFjQFCB/wUymzkINv0
         td98UyGYIMzM7efirt7uvx26m80s9A2KM0evAeKrQfDQT1oFCFMCWNxYI6MIP+TJTQ+E
         JQtEBFwwoNvrMpJfesJfuoXtLBUUHZou1i2mF1got7lBiOxmICOYe9PQzOq1yiBv6Xnh
         OR3/x+1dTjlkJO+ZV0zD8x+V54ZfpvzqBW+nJZUVMmt4lPW9ip6EfFOllgKByaMNlVy1
         AwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyF6HkVr52XfG6RF2DOcWmYqiZYSWxWkllHnHVyKPAQ=;
        b=OM0nwOrUpFyquYtUXAXOWv/2QuIGvwfaeAvtT9XuccwNHx9AixvSEyRXDJ4i2vI7yD
         zmkfyUn05Aei1Bxp/YR01ynT80X86xpPQ3l+qoUmNwXAkJVbDzgvYbhJ/mSvNcw1BokP
         11wva75WSfNQdtukNIJqxchrflWUrnTXgQ3RcCEqjRfsEYMF2sn46fqivsevTK09mMr5
         GsboNLdnGW2X+lsNtC36Txh9gb/IfvSlsK35KJ6vnVMOXB5iNi+A4Nz3LPA/EjXxTBCi
         2KpnzAkMLeEZasO6n6QuH0LnaPZlGPACh+OwoV4jNy86ct55RchPUctsLOUA2GBjSl67
         XKRQ==
X-Gm-Message-State: AA+aEWZt334p17F1SC1P2qdvuwEacseSiNdkQNZ8w+jWkJIB/pU5XHgu
        6DsriupJnMCVONqHoLt+b/LwMVNL86axbsePwb/u4Og=
X-Google-Smtp-Source: AFSGD/Ux557l/nOgPZUzimmHr7pO+w2lbtREywbzPXuoB354Han83ddFOUlceKav0/n41BRiYaxYqQLtO04fcb4CNTk=
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr23895532ljk.55.1543430856429;
 Wed, 28 Nov 2018 10:47:36 -0800 (PST)
MIME-Version: 1.0
References: <154343066843.17825.12154246717874457759.stgit@chester>
In-Reply-To: <154343066843.17825.12154246717874457759.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Nov 2018 13:47:25 -0500
Message-ID: <CAHC9VhSbqnN-brs0ssbCeAcUWGhUyRYR=FBYB1yB9uuR7_UeOQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: add support for RTM_NEWCHAIN, RTM_DELCHAIN, and RTM_GETCHAIN
To:     selinux@vger.kernel.org
Cc:     netdev@vger.kernel.org, jiri@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 28, 2018 at 1:44 PM Paul Moore <paul@paul-moore.com> wrote:
> Commit 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
> added new RTM_* definitions without properly updating SELinux, this
> patch adds the necessary SELinux support.
>
> While there was a BUILD_BUG_ON() in the SELinux code to protect from
> exactly this case, it was bypassed in the broken commit.  In order to
> hopefully prevent this from happening in the future, add additional
> comments which provide some instructions on how to resolve the
> BUILD_BUG_ON() failures.
>
> Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
> Cc: <stable@vger.kernel.org> # 4.19
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/nlmsgtab.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

I'm building a test kernel right now, assuming all goes well I'm going
to send this up to Linus for v4.20.

> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index 74b951f55608..9cec81209617 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -80,6 +80,9 @@ static const struct nlmsg_perm nlmsg_route_perms[] =
>         { RTM_NEWSTATS,         NETLINK_ROUTE_SOCKET__NLMSG_READ },
>         { RTM_GETSTATS,         NETLINK_ROUTE_SOCKET__NLMSG_READ  },
>         { RTM_NEWCACHEREPORT,   NETLINK_ROUTE_SOCKET__NLMSG_READ },
> +       { RTM_NEWCHAIN,         NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
> +       { RTM_DELCHAIN,         NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
> +       { RTM_GETCHAIN,         NETLINK_ROUTE_SOCKET__NLMSG_READ  },
>  };
>
>  static const struct nlmsg_perm nlmsg_tcpdiag_perms[] =
> @@ -158,7 +161,11 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
>
>         switch (sclass) {
>         case SECCLASS_NETLINK_ROUTE_SOCKET:
> -               /* RTM_MAX always point to RTM_SETxxxx, ie RTM_NEWxxx + 3 */
> +               /* RTM_MAX always points to RTM_SETxxxx, ie RTM_NEWxxx + 3.
> +                * If the BUILD_BUG_ON() below fails you must update the
> +                * structures at the top of this file with the new mappings
> +                * before updating the BUILD_BUG_ON() macro!
> +                */
>                 BUILD_BUG_ON(RTM_MAX != (RTM_NEWCHAIN + 3));
>                 err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
>                                  sizeof(nlmsg_route_perms));
> @@ -170,6 +177,10 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
>                 break;
>
>         case SECCLASS_NETLINK_XFRM_SOCKET:
> +               /* If the BUILD_BUG_ON() below fails you must update the
> +                * structures at the top of this file with the new mappings
> +                * before updating the BUILD_BUG_ON() macro!
> +                */
>                 BUILD_BUG_ON(XFRM_MSG_MAX != XFRM_MSG_MAPPING);
>                 err = nlmsg_perm(nlmsg_type, perm, nlmsg_xfrm_perms,
>                                  sizeof(nlmsg_xfrm_perms));
>

-- 
paul moore
www.paul-moore.com
