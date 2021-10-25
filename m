Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F11C433F5
	for <selinux@archiver.kernel.org>; Mon, 25 Oct 2021 07:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC04A60E73
	for <selinux@archiver.kernel.org>; Mon, 25 Oct 2021 07:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhJYIBT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232036AbhJYIBS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Oct 2021 04:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635148736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jeUaEKBazBPDsRvPc85+E5svUhK5D7xGXblBBx8ImfA=;
        b=NxHWMsXXv27YTxyimildE+KCZsm0jj7fliob70+ZH/L9UoBIM23np7EJV6FYspA3KJZEEx
        BvTDK679lPi9ivn7H8jamw9zsUGH8KJId6rk5mmiJU+KxyJsiZwyW0+CefBoQSE66U5b5A
        2qobFS/3z3KdWF213tcHl3JuiY/RCfo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-YpxX4Je4MXKv1wEGhGonwg-1; Mon, 25 Oct 2021 03:58:54 -0400
X-MC-Unique: YpxX4Je4MXKv1wEGhGonwg-1
Received: by mail-yb1-f199.google.com with SMTP id g3-20020a25ae43000000b005c181cc73feso1896565ybe.23
        for <selinux@vger.kernel.org>; Mon, 25 Oct 2021 00:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jeUaEKBazBPDsRvPc85+E5svUhK5D7xGXblBBx8ImfA=;
        b=vCv1h5JqtLYhhy0oNnzBCgK759NWwzchxriMl+G+RfQh4odzSKmHWzXhZ/q4xVHKw3
         A9ltXZ9OlqjeRvKLL4AKuQFgVy1ErFLFaC3e9w3hGzf6IzY7bxULITwupt/+uVV46L7v
         y+n45Nc/9YU9brvf3UTbfFGrbPQVo8mvUOvNY/i+++NBG9uyYnWgfxKWYQ1hwfsxny/2
         fYNjWzGP55sifDbwdcuXFlLVKCsevD22+yohjcwRqL9UwF//2oKyptMC5Xzb3FkbY76r
         azPqTUy49xELQjwXMlJ8T4sar73BDtteOgdAeAWhHr+hLAFgKSLrqCazWMrmE3zDNDk7
         pAfg==
X-Gm-Message-State: AOAM532PlhUfWRRS0+v87mwjx/N47qi2/2k2tylG2VxVg7a0NdBPHQtR
        Vn/9Y97B1T+plhMH3bPy8oieuRp8Jsp6IDKCKIzyKYhltg9HBYcf1d+iqu3mP6IV+42sIne2Yl8
        MIxnKYcR2f2YDSjf6mzomklM3aQd+lTzhIA==
X-Received: by 2002:a25:2404:: with SMTP id k4mr8045843ybk.363.1635148732562;
        Mon, 25 Oct 2021 00:58:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFNRYuuJ/BOE2vEMOVIaGGoP0dBQjAZh465kVSD8VgMFTjfh0Re3l1GkwsYF53olzBAw7VCKE61BE74/gEFDc=
X-Received: by 2002:a25:2404:: with SMTP id k4mr8045800ybk.363.1635148731889;
 Mon, 25 Oct 2021 00:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634884487.git.lucien.xin@gmail.com> <ba8724d10da0f7545e5b91d1540a984c2b398a6a.1634884487.git.lucien.xin@gmail.com>
In-Reply-To: <ba8724d10da0f7545e5b91d1540a984c2b398a6a.1634884487.git.lucien.xin@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Oct 2021 09:58:40 +0200
Message-ID: <CAFqZXNu5PxBh8XFs=AFwJW0jpxKxPNQyXiyYekz_whHWGGXs5A@mail.gmail.com>
Subject: Re: [PATCH net 2/4] security: call security_sctp_assoc_request in sctp_sf_do_5_1D_ce
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-sctp@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 22, 2021 at 8:36 AM Xin Long <lucien.xin@gmail.com> wrote:
> The asoc created when receives the INIT chunk is a temporary one, it
> will be delete after INIT_ACK chunk is replied. So for the real asoc

Nit: s/delete/deleted/

> created in sctp_sf_do_5_1D_ce() when receives the COOKIE_ECHO chunk,

Nit: s/receives the COOKIE_ECHO chunk/the COOKIE_ECHO chunk is received/

> security_sctp_assoc_request() should also be called.
>
> Fixes: 72e89f50084c ("security: Add support for SCTP security hooks")
> Reported-by: Prashanth Prahlad <pprahlad@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  Documentation/security/SCTP.rst | 15 +++++++++------
>  net/sctp/sm_statefuns.c         |  5 +++++
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/security/SCTP.rst b/Documentation/security/SCTP.rst
> index 415b548d9ce0..9a38067762e5 100644
> --- a/Documentation/security/SCTP.rst
> +++ b/Documentation/security/SCTP.rst
> @@ -151,9 +151,9 @@ establishing an association.
>           INIT --------------------------------------------->
>                                                     sctp_sf_do_5_1B_init()
>                                                   Respond to an INIT chunk.
> -                                             SCTP peer endpoint "A" is
> -                                             asking for an association. Call
> -                                             security_sctp_assoc_request()
> +                                             SCTP peer endpoint "A" is asking
> +                                             for an temporary association.

Nit: s/an/a/

> +                                             Call security_sctp_assoc_request()
>                                               to set the peer label if first
>                                               association.
>                                               If not first association, check
> @@ -163,9 +163,12 @@ establishing an association.
>            |                                       discard the packet.
>            |
>      COOKIE ECHO ------------------------------------------>
> -                                                          |
> -                                                          |
> -                                                          |
> +                                                  sctp_sf_do_5_1D_ce()
> +                                             Respond to an COOKIE ECHO chunk.
> +                                             Confirm the cookie and create an

Nit: s/an/a/

> +                                             permanent association.
> +                                             Call security_sctp_assoc_request() to
> +                                             do the same as for INIT chunk Response.
>            <------------------------------------------- COOKIE ACK
>            |                                               |
>      sctp_sf_do_5_1E_ca                                    |
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 3206374209bc..b818532c3fc2 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -781,6 +781,11 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
>                 }
>         }
>
> +       if (security_sctp_assoc_request(new_asoc, chunk->skb)) {
> +               sctp_association_free(new_asoc);
> +               return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
> +       }
> +
>         /* Delay state machine commands until later.
>          *
>          * Re-build the bind address for the association is done in
> --
> 2.27.0
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

