Return-Path: <SRS0=Ozag=TN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE24C04AA7
	for <selinux@archiver.kernel.org>; Mon, 13 May 2019 22:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DF6208C2
	for <selinux@archiver.kernel.org>; Mon, 13 May 2019 22:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nKFpPALv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEMWu3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 May 2019 18:50:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46205 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEMWu2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 May 2019 18:50:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so10758028ljk.13
        for <selinux@vger.kernel.org>; Mon, 13 May 2019 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVBadUQyMsN1xKdzfRFA/3BjtGrBKiB1THY0ho1i9TM=;
        b=nKFpPALvyYRJoZK65iskGMmpZXpoqX/t2WYRF3CYceVMNdameu8UuG0oI8SU4dIkHL
         gUStdoRUcROzvET3N/cLODedstqfVtgK5c+hXfZ+uEwha+1eSySu/FnekCcFnpfr7SWG
         WEZmAQSwlkVLbR5MD+BEZAxQVJ/g8hsIPLIIzdlfFFzDUnVsfWbpLuGFyj5eeQ+vv0Qp
         S7+HVLH5L3O2mD8lpi7E7nJpAtsTmcrBPM5fTumV1CpcxoU0nuHIbptiJtAj4haP2KSg
         0EyhRuf9GkNKgasssP8oh1s8O0vcMOUTSRLxQZtjQKcaUg8IhkZW7hmhNGVZ8l7pJtqi
         4FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVBadUQyMsN1xKdzfRFA/3BjtGrBKiB1THY0ho1i9TM=;
        b=IF4aDlNoGmTCM7YEcb7ILE+Pp8h/p+MK+0ohzmXeMhVARhq+/8a05K0zbdOfK9/gGY
         9bKJKfh3AVsseAgL4FtxpzFbb0E/MPD1uE2YgjM1WpxCUheEDs0l8ep77Gt8NZOxyOk3
         fGoGWedp7NKCrWlWB4Hh5GC5LEUOcSPMHOHserAeGlNBCRGkdKFgeac/PNz/1JYbCFHy
         GCkRmHeD71lBclNZoppH4etYQzDp6RpEQcyj+5VUg7LSyiu4iqt8BDOBaRhydiZ6y3BC
         F2CxDW89bErkxOhLiwemsMHprcstWjEZU//sh7FMNFDNtTFzlcYkOLwqazgLSqYQI98K
         fjFA==
X-Gm-Message-State: APjAAAVuIHmqdbQPO3DzkFMAuNFtqPsxKxzOC02yQz/XxArCLjx89h5S
        nVlqlW68xOWQ5nJdWPUllDpG7/x8ePUT8gVOLjSy
X-Google-Smtp-Source: APXvYqzqZuYo/VC3rYjGXigGLJGdiP1qZzxc9gX9urVd6cGAV4u7ZBHKf9oMo5SJ3Y74LTz/KWnL/KPUN5FUmdwRkMM=
X-Received: by 2002:a2e:9b0b:: with SMTP id u11mr937963lji.57.1557787826395;
 Mon, 13 May 2019 15:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <73b14b25ad7741c9ddcef061ab65a9b7ea8811bc.1557506063.git.pabeni@redhat.com>
In-Reply-To: <73b14b25ad7741c9ddcef061ab65a9b7ea8811bc.1557506063.git.pabeni@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 May 2019 18:50:15 -0400
Message-ID: <CAHC9VhQU-f82h+2QTGMspVY9sqAog6iNfGqYn00JP_sgsoF5mA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: do not report error on connect(AF_UNSPEC)
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org, Tom Deseyn <tdeseyn@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 10, 2019 at 1:13 PM Paolo Abeni <pabeni@redhat.com> wrote:
> calling connect(AF_UNSPEC) on an already connected TCP socket is an
> established way to disconnect() such socket. After commit 68741a8adab9
> ("selinux: Fix ltp test connect-syscall failure") it no longer works
> and, in the above scenario connect() fails with EAFNOSUPPORT.
>
> Fix the above explicitly early checking for AF_UNSPEC family, and
> returning success in that case.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Fixes: 68741a8adab9 ("selinux: Fix ltp test connect-syscall failure")
> Reported-by: Tom Deseyn <tdeseyn@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>  - do the check for AF_UNSPEC at the begining, as suggested by Paul
> v1 -> v2:
>  - avoid validation for AF_UNSPEC
> ---
>  security/selinux/hooks.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Thanks Paolo, this looks good.  It sounded like DaveM wanted this to
go to -stable so I'll merge it and mark it as such; I think I will
wait until the end of this week just to see if there are any other
things which crop up during the merge window.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c61787b15f27..3ec702cf46ca 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4637,6 +4637,14 @@ static int selinux_socket_connect_helper(struct socket *sock,
>         err = sock_has_perm(sk, SOCKET__CONNECT);
>         if (err)
>                 return err;
> +       if (addrlen < offsetofend(struct sockaddr, sa_family))
> +               return -EINVAL;
> +
> +       /* connect(AF_UNSPEC) has special handling, as it is a documented
> +        * way to disconnect the socket
> +        */
> +       if (address->sa_family == AF_UNSPEC)
> +               return 0;
>
>         /*
>          * If a TCP, DCCP or SCTP socket, check name_connect permission
> @@ -4657,8 +4665,6 @@ static int selinux_socket_connect_helper(struct socket *sock,
>                  * need to check address->sa_family as it is possible to have
>                  * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
>                  */
> -               if (addrlen < offsetofend(struct sockaddr, sa_family))
> -                       return -EINVAL;
>                 switch (address->sa_family) {
>                 case AF_INET:
>                         addr4 = (struct sockaddr_in *)address;
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
