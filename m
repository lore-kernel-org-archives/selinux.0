Return-Path: <SRS0=5TXQ=P6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2881C282C5
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 16:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10FF21726
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 16:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JmmI1VAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfAVQtR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:49:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37548 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbfAVQtR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Jan 2019 11:49:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so18602724lfj.4
        for <selinux@vger.kernel.org>; Tue, 22 Jan 2019 08:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7Wpv/4iLgNw7f7oCJ0+7IbRi5sRctWW8WMe3Ae3M98=;
        b=JmmI1VALhwceJA4QdE3sqSAlOazg3D9qZ9st+ffsvDAnJXWt1M987N8WLgeYEV1C4E
         5+cxJoeXOTPCfwAIuAYjvIMJgcgiq88eHIXt+VQbcbX3RKMn8lmoz0yOZnJWCiliKBro
         8wEodl6/hhiVpwqYYeMCehjOKhlzCjcrqTd2MotUDFAJlzvQz8bw8AlBimbwiBVTeIjf
         MAPOoC1DwbJVGam9yImueXidGdrGXRNZn2Zr1fXs1PspngvMIz63ZCd3k20U01ljG0xl
         jTJQhv3aalFYXvwWDP1EtLUXzF/a/keWy8PHs9Q374HNjX+cMdTaiejc7kum3KyCuz0s
         S9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7Wpv/4iLgNw7f7oCJ0+7IbRi5sRctWW8WMe3Ae3M98=;
        b=d8GJZcQzqvS+oxsurwLKn/s2EtNQ40SqWN4KGr2saJZc4vcXyV5W3CJsyUoyMynkLw
         y9NjNBESnXf8PqspI5e95cy4GdK6nReNsnVDA14iP4rbggsHvpC9Q/VC1oqHNbshIDF3
         Ogx7lqkkqVKNIrcgU5i6LUE1plnR6BTEher9a3KzACd/X5eJcDcWBy1kCRg2CokmuXx3
         Mi0V434dokkCisexT/RbcFMDdPwhmKQsUInvGA4ELk4bemLKSOIdQTfiY2bmmdX/sIgt
         Gpr0qyPDrTJ/KyGkmVEixAgXn+ej1NtnMyukMTBAt4G1Men/fIlLLxdnl114YnfNPsM5
         DGDA==
X-Gm-Message-State: AJcUukdw+VJWmIx+jH/cVGs1+4HPi91AJPsKIunnVJj0IS7isnOhk1ue
        mctHYVzskI5g345wO3uqK3G532yQZnF6bdloHKfZ
X-Google-Smtp-Source: ALg8bN7yUIuX890rg7pP8rOw/YbA/czlh6ciEs1iupPZw5iOEfGrveJOhJ0F1zuszwc5pHfEw0Fgkbf86ymDA/oW3as=
X-Received: by 2002:a19:c995:: with SMTP id z143mr18843123lff.79.1548175753501;
 Tue, 22 Jan 2019 08:49:13 -0800 (PST)
MIME-Version: 1.0
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
 <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
 <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
 <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
 <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net>
In-Reply-To: <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Jan 2019 11:49:02 -0500
Message-ID: <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
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

On Mon, Jan 21, 2019 at 12:11 PM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> 18.01.2019, 20:17, "Paul Moore" <paul@paul-moore.com>:
> > Yes, this is extra overhead, but it is in an error path so I'm not
> > overly concerned about the performance impact on the given connection.
> >
> > I will admit that it isn't an ideal solution from a LSM/NetLabel
> > perspective, but historically the netdev folks have not been overly
> > receptive to changes which negatively impact the core network stack
> > regardless of how important it may be for the LSMs. If we could
> > modify icmp_send() so that it works regardless of the caller's
> > location in the stack, that would be great, I'm just not sure it would
> > be deemed acceptable. I suggested the approach I did because I think
> > that has the best chance of getting merged.
> >
> > Regardless, I would encourage you to put together a patch and post it
> > for review, I think that's the best way to get a response. If you
> > aren't able, or aren't comfortable, submitting a patch please let me
> > know.
> > --
> > paul moore
> > www.paul-moore.com
>
> May be something like that?
>
> [PATCH 1/2] Add IP options parameter to icmp_send
> ---
>  include/net/icmp.h    |    9 ++++++++-
>  net/ipv4/icmp.c       |    7 ++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/icmp.h b/include/net/icmp.h
> index 6ac3a5b..e0f709d 100644
> --- a/include/net/icmp.h
> +++ b/include/net/icmp.h
> @@ -22,6 +22,7 @@
>
>  #include <net/inet_sock.h>
>  #include <net/snmp.h>
> +#include <net/ip.h>
>
>  struct icmp_err {
>    int          errno;
> @@ -39,7 +40,13 @@ struct icmp_err {
>  struct sk_buff;
>  struct net;
>
> -void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info);
> +void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
> +                const struct ip_options *opt);
> +static inline void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
> +{
> +       __icmp_send(skb_in, type, code, info, &IPCB(skb_in)->opt);
> +}
> +
>  int icmp_rcv(struct sk_buff *skb);
>  int icmp_err(struct sk_buff *skb, u32 info);
>  int icmp_init(void);
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 065997f..3f24414 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -570,7 +570,8 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
>   *                     MUST reply to only the first fragment.
>   */
>
> -void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
> +void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
> +                const struct ip_options *opt)
>  {
>         struct iphdr *iph;
>         int room;
> @@ -691,7 +692,7 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
>                                           iph->tos;
>         mark = IP4_REPLY_MARK(net, skb_in->mark);
>
> -       if (ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in))
> +       if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in, opt))
>                 goto out_unlock;
>
>
> @@ -742,7 +743,7 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
>         local_bh_enable();
>  out:;
>  }
> -EXPORT_SYMBOL(icmp_send);
> +EXPORT_SYMBOL(__icmp_send);

This looks reasonable, and I think this should be acceptable to the
netdev folks.  Although a minor heads-up that somebody might object to
icmp_send() no longer being exported.

More below...

> ---
> [PATCH 2/2] Extract IP options in cipso_v4_error
> ---
>  include/net/ip.h      |    2 ++
>  net/ipv4/cipso_ipv4.c |   11 +++++++++--
>  net/ipv4/ip_options.c |   22 +++++++++++++++++-----
>  3 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 8866bfc..f0e8d06 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -667,6 +667,8 @@ static inline int ip_options_echo(struct net *net, struct ip_options *dopt,
>  }
>
>  void ip_options_fragment(struct sk_buff *skb);
> +int __ip_options_compile(struct net *net, struct ip_options *opt,
> +                        struct sk_buff *skb, __be32 *info);
>  int ip_options_compile(struct net *net, struct ip_options *opt,
>                        struct sk_buff *skb);
>  int ip_options_get(struct net *net, struct ip_options_rcu **optp,
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 777fa3b..86599e9 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1735,13 +1735,20 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
>   */
>  void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
>  {
> +       unsigned char optbuf[sizeof(struct ip_options) + 40];
> +       struct ip_options *opt = (struct ip_options *)optbuf;
> +
>         if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
>                 return;
>
> +       opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
> +       if (__ip_options_compile(dev_net(skb->dev), opt, skb, NULL))
> +               return;

I would suggest adding a comment to the code above explaining that
this is necessary because we might be called above the IP layer and we
can't safely use IPCB() here.

>         if (gateway)
> -               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0);
> +               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, opt);
>         else
> -               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
> +               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, opt);
>  }
>
>  /**
> diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
> index ed194d4..32a3504 100644
> --- a/net/ipv4/ip_options.c
> +++ b/net/ipv4/ip_options.c
> @@ -251,8 +251,9 @@ static void spec_dst_fill(__be32 *spec_dst, struct sk_buff *skb)
>   * If opt == NULL, then skb->data should point to IP header.
>   */
>
> -int ip_options_compile(struct net *net,
> -                      struct ip_options *opt, struct sk_buff *skb)
> +int __ip_options_compile(struct net *net,
> +                        struct ip_options *opt, struct sk_buff *skb,
> +                        __be32 *info)
>  {
>         __be32 spec_dst = htonl(INADDR_ANY);
>         unsigned char *pp_ptr = NULL;
> @@ -468,11 +469,22 @@ int ip_options_compile(struct net *net,
>                 return 0;
>
>  error:
> -       if (skb) {
> -               icmp_send(skb, ICMP_PARAMETERPROB, 0, htonl((pp_ptr-iph)<<24));
> -       }
> +       if (info)
> +               *info = htonl((pp_ptr-iph)<<24);
>         return -EINVAL;
>  }
> +
> +int ip_options_compile(struct net *net,
> +                      struct ip_options *opt, struct sk_buff *skb)
> +{
> +       int ret;
> +       __be32 info;
> +
> +       ret = __ip_options_compile(net, opt, skb, &info);
> +       if (ret != 0 && skb)
> +               icmp_send(skb, ICMP_PARAMETERPROB, 0, info);
> +       return ret;
> +}
>  EXPORT_SYMBOL(ip_options_compile);

Granted I'm looking at this rather quickly, so I may be missing
something, but why the changes to ip_options_compile()?  Couldn't you
simply set opt->data manually (set the ptr) in cipso_v4_error() before
calling ip_options_compile() and arrive at the same result without
having to modify ip_options_compile()?  I suppose there is the rtable
value to worry about, but ip_options_echo() should take care of that,
yes?  No?

-- 
paul moore
www.paul-moore.com
