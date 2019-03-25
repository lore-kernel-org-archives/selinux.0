Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B0C10F03
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8D220863
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="De+U9QhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfCYOPB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:15:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40096 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCYOPA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 10:15:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so7988482ljq.7
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2019 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wM6zTGtLu/pzeYSvy2fPKD6o/g77FkApz0SPe5ooAFI=;
        b=De+U9QhBaFUgahFebLCbg3inN1hw7KICsXBImXurPhFjPvnJW/dPwTa90NHXXwjJli
         19xo7YOQ81axY4eSWH++PqqIYWMQQkgRO+9bFwoKyCz94yzlBfIXoaGjcCvBidW0Wfdh
         Txm1oS/HbQzhcokCk2hnt3+tconD8yTnfD942OOAXOXGxXF0O480DjDFVT/yAH9L/P3c
         WFVji+x3zqOaVrUsFm7WAD1bInG9dkn0f7evvBKjIKi6VB6EvqRgA0iAjYURXSzgwN8L
         AdXe9ZSyCl5y4JMCyisyosVceo9YXbkub8Wd8zQ6FjHJvqiELMEUxoKN8TZmn4AwiRTJ
         wYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wM6zTGtLu/pzeYSvy2fPKD6o/g77FkApz0SPe5ooAFI=;
        b=qkG4FILECyXGhIFe4RYTjRdo1gkJNk8mfwX8QHPLVA83NGJOINHT+66zKjVwD8jCqr
         oEw5lZLPgo79ylv/MBro+OX2j133Tem591qp1HZdqQZ62nIGxPa4rnBEruOJfeNaVvia
         hPcWtJumivnGb/Xg0/G8MUgUjlFCLLOunoRoWOTZODgiqIDUX1Tq4OyBm425qr6BkZ/z
         +vlvjYbMH8WctoTO4wAQk/LI7fAuEH6M26A8Mz9R9Om6hNCIpLjVXmP0zonPYoQHD20n
         Ji5sJE9vzJzGOhAsFL8qxgDQTCYCbS2DiZFDis3iV6KHHrnGFtAsNsnTSFCRSGc7pH/H
         0Jmg==
X-Gm-Message-State: APjAAAVLWLTrb/r8rfxYMkGtU2AqDhsU3YYcmTXcXVlHWHKSDnM8sJXg
        T9S8KKvfJtXDAfrfNjqdm0uzLCyfxI+b1ig3wvDY
X-Google-Smtp-Source: APXvYqzXDhQs71tdkHV80CfVt0Vpp5bB+VuEUw7PjyRooKdejejrumcLxXNNUcVEyB2skX/FEwUb7U/r9i3rvrMVYRs=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr13414717ljb.169.1553523298257;
 Mon, 25 Mar 2019 07:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190325124050.1285877-1-arnd@arndb.de>
In-Reply-To: <20190325124050.1285877-1-arnd@arndb.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Mar 2019 10:14:44 -0400
Message-ID: <CAHC9VhSmxfpGpVkHvu=HmATm8+uRkdyo8bgrU8XJAK_h3K3dhA@mail.gmail.com>
Subject: Re: [PATCH] [v2] selinux: avoid uninitialized variable warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 25, 2019 at 8:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> clang correctly points out a code path that would lead
> to an uninitialized variable use:
>
> security/selinux/netlabel.c:310:6: error: variable 'addr' is used uninitialized whenever 'if' condition is false
>       [-Werror,-Wsometimes-uninitialized]
>         if (ip_hdr(skb)->version == 4) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> security/selinux/netlabel.c:322:40: note: uninitialized use occurs here
>         rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
>                                               ^~~~
> security/selinux/netlabel.c:310:2: note: remove the 'if' if its condition is always true
>         if (ip_hdr(skb)->version == 4) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> security/selinux/netlabel.c:291:23: note: initialize the variable 'addr' to silence this warning
>         struct sockaddr *addr;
>                              ^
>                               = NULL
>
> This is probably harmless since we should not see ipv6 packets
> of CONFIG_IPV6 is disabled, but it's better to rearrange the code
> so this cannot happen.
>
> Link: https://lore.kernel.org/patchwork/patch/1053663/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: revise after discussing with Paul Moore
> ---
>  security/selinux/netlabel.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 186e727b737b..fb4351733450 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -288,11 +288,8 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
>         int rc;
>         struct netlbl_lsm_secattr secattr;
>         struct sk_security_struct *sksec = ep->base.sk->sk_security;
> -       struct sockaddr *addr;
>         struct sockaddr_in addr4;
> -#if IS_ENABLED(CONFIG_IPV6)
>         struct sockaddr_in6 addr6;
> -#endif
>
>         if (ep->base.sk->sk_family != PF_INET &&
>                                 ep->base.sk->sk_family != PF_INET6)
> @@ -310,16 +307,15 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
>         if (ip_hdr(skb)->version == 4) {
>                 addr4.sin_family = AF_INET;
>                 addr4.sin_addr.s_addr = ip_hdr(skb)->saddr;
> -               addr = (struct sockaddr *)&addr4;
> -#if IS_ENABLED(CONFIG_IPV6)
> -       } else {
> +               rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr4, &secattr);
> +       } else if (IS_ENABLED(CONFIG_IPV6)) {

I thought we had talked about using an else-if statement like the one
below, is there any reason why you changed it to just the IS_ENABLED()
check?  I liked the idea of explicitly checking the IP header version
number before treating the packet as an IPv6 packet.

  else if (IS_ENABLED(CONFIG_IPV6) && ip_hdr(skb)->version == 6)

>                 addr6.sin6_family = AF_INET6;
>                 addr6.sin6_addr = ipv6_hdr(skb)->saddr;
> -               addr = (struct sockaddr *)&addr6;
> -#endif
> +               rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr6, &secattr);
> +       } else {
> +               rc = -EAFNOSUPPORT;
>         }
>
> -       rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
>         if (rc == 0)
>                 sksec->nlbl_state = NLBL_LABELED;
>
> --
> 2.20.0
>

-- 
paul moore
www.paul-moore.com
