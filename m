Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2FEC282D9
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 02:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077BE20989
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 02:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EjH2eyBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfAaCKa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:10:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45670 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaCKa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jan 2019 21:10:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so1230171ljd.12
        for <selinux@vger.kernel.org>; Wed, 30 Jan 2019 18:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Whk/q5GwjVvnbaED4S5YUnxJOg/3KAYycyPfIkJB4r4=;
        b=EjH2eyBWlFCg9dz5pmsuo8Jl9GrYn9SWlbWo70qvXam/J/oWSt+/3Bj+XSAU78ExMO
         4otO0wbKwqqBLnCjRmdPikjfGXCul55zWB3qFcybBTEjDdYkmgdj7AkCBf/7nSkcjncA
         5tc6UJYjqYJungjGAMhK39S281k7eTdTorbvG80ob/aWf7llA/42ILiLezCIdRF9sEwQ
         v92bt49NCCBXbVpYoP2vgnb+p1788zuWk4CJlXS+6EnstCdzfXvysSefusB0DM87uQgr
         bv5eYuQpG0Ab9562oPqCX/aaILaq0C5NA6bbtf0gRV/h8lPeGW6U1WxxaRcACslfVulV
         KKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Whk/q5GwjVvnbaED4S5YUnxJOg/3KAYycyPfIkJB4r4=;
        b=E8FN90L+lqP4ROVhpWMpoCKutNTx/OBlHUImh+TrJZOV9Ov1zJ57GbOVJNLHIROMXl
         yPxp1eu0Hk3bRSq+D9Ddptsxc0peRPyHwpupwldOKdeIud01mbWnttGtFYp8+glmmE7D
         M7CEoyyNz3TTJox8j2EmkMBXqKkxZ+n9Cd88SG01X4zZxmZ0cOPP6QT0AbvCXviX9E/5
         q25Hy44ofw81cl2Mq0S2ppcY2/j9gfOcYnFSz9vLuMntfavU/gvfQY1WLe4F/VhuLcIh
         cr+tH5qkJr3hu2+x5sTb3KfvICOmH0xpxE0mPQ6t0PuefOKKgObj2CEOMSeUmQiaOQHi
         EVnA==
X-Gm-Message-State: AHQUAuaTA+b7nqDkFzUHSqm4fM0RS5toPIWz52yehCJt48l2Imh+wor2
        FTzT6gQXbZCceMYdskCXzyvbmslMnt4CBtNBMK+i
X-Google-Smtp-Source: AHgI3IaxhW9p8kSXLWoCtfhmPYyq8maDoE9A3BCeTfThYLmmlR8WIA4oj2pfQ/37jeZCnd8u7jumgFeu/kRAaRGwWrA=
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr11945689ljj.95.1548900627375;
 Wed, 30 Jan 2019 18:10:27 -0800 (PST)
MIME-Version: 1.0
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
 <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
 <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
 <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
 <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
 <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net> <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
 <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net> <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
 <1125571548681054@iva5-0acfc31d2b43.qloud-c.yandex.net> <CAHC9VhRC8BC9Ocs9FYVrwnWutWD4Dow_MjwpvowxmJd=NtVN5g@mail.gmail.com>
 <3499451548746609@myt4-929fb874f3f2.qloud-c.yandex.net> <CAHC9VhRXc=UAfNidPjYsG561_kc_j2CkD6Db=Kb=Gjyhk3ko6Q@mail.gmail.com>
 <3191601548853902@myt6-23299ba78d64.qloud-c.yandex.net>
In-Reply-To: <3191601548853902@myt6-23299ba78d64.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Jan 2019 21:10:16 -0500
Message-ID: <CAHC9VhQcrnXmjcVw_ppwM-fGcwhJq9SafTnZKjgpQpxK0ie+Jw@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
To:     Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 30, 2019 at 8:11 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> 30.01.2019, 01:42, "Paul Moore" <paul@paul-moore.com>:
> > There are several cases where the stack ends up calling icmp_send()
> > after the skb has been through ip_options_compile(), that should be
> > okay.
> >
> > --
> > paul moore
> > www.paul-moore.com
>
> In those cases precompiled ip_options struct used, without the need to reuse ip_options_compile.
> I think, for error ICMP packet, we can discard all other options except CIPSO. It will be better, than
> send packet, contains wrong option's data. Modified patch 2:
> ---
>  net/ipv4/cipso_ipv4.c |   24 ++++++++++++++++++++++--
>  1 files changed, 22 insertions(+), 2 deletions(-)

This isn't how the rest of the stack works, look at
ip_local_deliver_finish() for one example.  Perhaps the behavior you
are proposing is correct, but please show me where in the various RFC
specs it is defined so that I can better understand why it should work
this way.

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 777fa3b..797826c 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1735,13 +1735,33 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
>   */
>  void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
>  {
> +       struct ip_options opt;
> +       unsigned char *optptr;
> +
>         if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
>                 return;
>
> +       /*
> +        * We might be called above the IP layer,
> +        * so we can not use icmp_send and IPCB here.
> +        *
> +        * For the generated ICMP packet, we create a
> +        * temporary ip _options structure, contains
> +        * the CIPSO option only, since the other options data
> +        * could be modified when the original packet receiving.
> +        */
> +
> +       memset(&opt, 0, sizeof(struct ip_options));
> +       optptr = cipso_v4_optptr(skb);
> +       if (optptr) {
> +               opt.optlen = optptr[1];
> +               opt.cipso = optptr - skb_network_header(skb);
> +       }
> +
>         if (gateway)
> -               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0);
> +               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, &opt);
>         else
> -               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
> +               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, &opt);
>  }
>
>  /**
>


-- 
paul moore
www.paul-moore.com
