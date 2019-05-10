Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B017BC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 15:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F772070D
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 15:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0JouUbW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfEJPdH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 11:33:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39736 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJPdG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 11:33:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id q10so5467608ljc.6
        for <selinux@vger.kernel.org>; Fri, 10 May 2019 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qf/l5mcfsWoOPApcOg3aFJDENoc0Mx0//PUEwY+AJ5I=;
        b=0JouUbW6qevUxqRZSJEuZIEIkrkCeS7pkWRW7WXy5nqbDfeer43wX0V3Gc0dWaEkMB
         5xe0PqJWtiRIP3P4HJ07ATJqGUp++bkHl5Me5rLAgaqOpXCn/GppvTY4yn/Io/LD8VBw
         auaxkws0a7JBoRDjx/qIKZxM2BAIaRoLrs5vYiNAL83rNhrdKVLTRvLwaowChJE7H4xX
         N7wGpHpV+fftJwUsdkMUeIBMr+BVV22RRKSTk0OuTCPNfwL7fkfygrPxsJM9DkHtna9X
         j09OfnxMXesUsSBzU9lY3wXmZ1mUqWP0MAbDroLZu9BowiGAbhkgwYUqHuxnwCsuSkdx
         Ro0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qf/l5mcfsWoOPApcOg3aFJDENoc0Mx0//PUEwY+AJ5I=;
        b=A7s7D4edqKaNsLrZ4OhCaS5IOUsK2DlEPtAvKmOKvBy6LGRtzmv/D5acvq3EkGS5mp
         SNZV80h3yPzbnzMK0zCldge7jmZGQ128Ul7HEOqMsZ1sFTmhHkD2cc1/8srTQqgtXM+x
         9wneh66owLlFyajxvOWcnszHRRTwytTRVwZHYyPwNXAANWmaVIREG4av4u9LHN0374Zk
         pTBsfrPKdLwqa5M+f+UMgW/jEmoM+Z4GRBmsTLDDH105gn12AOV+X1aH2PKmZ8MZPvtd
         9CbGsnP3yPM34o+Ftkf2SEvFAFBmX5rir5M96Cn4d9/P+twB39AFGu0NNJHHXHSwhOOX
         h0wg==
X-Gm-Message-State: APjAAAX6tIzed+U3M3jX2VPfMUcLZxbf0Qq5AQM6YCBv2sZL0Kau2XVm
        288IcY160Qj+1prTrCSz/mvYfopcBpHtumPg4t1iRZqXFg==
X-Google-Smtp-Source: APXvYqwMeMAxnzNrB2KCDIJTfvtPVg8zaixG7d4/fJaQop97s8EoOQJbeis5GBKTYSxQGFSsli7b6/XjLpSHfLxG2FY=
X-Received: by 2002:a2e:5301:: with SMTP id h1mr6205118ljb.196.1557502384641;
 Fri, 10 May 2019 08:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <34870696b95f9cf48b5436df46e27dddd054858c.1557492319.git.pabeni@redhat.com>
In-Reply-To: <34870696b95f9cf48b5436df46e27dddd054858c.1557492319.git.pabeni@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 May 2019 11:32:52 -0400
Message-ID: <CAHC9VhRCdSPB8LuFTtBjLqrZAc3h8UsDJPJnYnMZmU3x_zWkTQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: do not report error on connect(AF_UNSPEC)
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org, Tom Deseyn <tdeseyn@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 10, 2019 at 9:49 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> calling connect(AF_UNSPEC) on an already connected TCP socket is an
> established way to disconnect() such socket. After commit 68741a8adab9
> ("selinux: Fix ltp test connect-syscall failure") it no longer works
> and, in the above scenario connect() fails with EAFNOSUPPORT.
>
> Fix the above skipping the checks when the address family is not
> AF_INET{4,6} - we don't have any port to validate, but leave the
> SCTP code path untouched, as it has specific constraints.
>
> Fixes: 68741a8adab9 ("selinux: Fix ltp test connect-syscall failure")
> Reported-by: Tom Deseyn <tdeseyn@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - avoid validation for AF_UNSPEC
> ---
>  security/selinux/hooks.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

What was wrong with explicitly checking for AF_UNSPEC as I mentioned
in my last email?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c61787b15f27..bccc4b3e6f57 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4674,12 +4674,13 @@ static int selinux_socket_connect_helper(struct socket *sock,
>                         break;
>                 default:
>                         /* Note that SCTP services expect -EINVAL, whereas
> -                        * others expect -EAFNOSUPPORT.
> +                        * others must handle this at the protocol level:
> +                        * connect(AF_UNSPEC) on a connected socket is
> +                        * a documented way disconnect the socket
>                          */
>                         if (sksec->sclass == SECCLASS_SCTP_SOCKET)
>                                 return -EINVAL;
> -                       else
> -                               return -EAFNOSUPPORT;
> +                       return 0;
>                 }
>
>                 err = sel_netport_sid(sk->sk_protocol, snum, &sid);
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
