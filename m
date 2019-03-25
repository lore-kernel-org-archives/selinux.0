Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07368C10F03
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28E220879
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="yqTQAioe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfCYOlE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:41:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44812 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbfCYOlD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 10:41:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so3583574ljg.11
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2019 07:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Youh5qKLBar4PTWYzgdvYi2dhgM3EondF10RxT99Kvs=;
        b=yqTQAioe4vZrHbWH9dxQwMX0zBiHkRd5p9UMokjLpK7CYTpWjnjslpWhqMuaPLdnIA
         QRzI4W2CIu/mAd16TQ89rg7fJFfdwoqf+uM7OTerzN2wveaUSr3+2xOxhs6NLglO3PWL
         A8rRcq9yJEzv1Z9z0ewka7a8+dS30dsT4qg39pIvYizOXJMfFEuzD90es5RpN1X41LQt
         w+hh575UNtbH0k0+3fnQcLlM6fFtzmuvI0K++u1NWZhMt3cZGHrTuhgVIkhH1HXwpKeC
         SdeZh3qx5ansllA9p1VXPAeE/rxLwuzzPxVEHkUhlA5vOFkdewURJbN5tRFgcRCN5Hf1
         10/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Youh5qKLBar4PTWYzgdvYi2dhgM3EondF10RxT99Kvs=;
        b=snSdpwoRbQ7rKMOuq2KZPHyFQOSO5YWBXE81qxy9rIdWS0tRgFqg6R7j1hKmRb5ZRy
         SrGcszK2W7fBxg9bkIILG37p8hEl/AE/2sS1OBouIXzRddC8vJuqgZXGsn/sslyiTe/B
         K8Z86xIXkqpcWNpTdKwqTzJNK9h9KYPNMC4myVKr9tDlXLUp4NtsWNA0IO2NlZYK0X7W
         rcshHFB6djL7BH67cb8djPAFl5tIAXxJ1HqA9DfO/8ZlkuPlZmbfihItQcFZG/DPYmWK
         JCUccwR8ex9pZq5RAMnJaZ4rlFl8X0AmesUVFC1U8CaJ6VnklA/4gGrP3xuwm1UlekNF
         mo9Q==
X-Gm-Message-State: APjAAAUiJ++yWy9VA5suZtCVJwrLXpKegY5oEOmIV9WftaKbGVj4hhE1
        jHxCXoGrcwiJa0PDU63L1wQTSsIMq87+6+PF6b1B
X-Google-Smtp-Source: APXvYqz2kIwYS+Cn9ieZen3HqTBofVYcyvC3cOHOtpRUcKLyKJYfdgPI/VkslaQ8XS0pj6464Pw4baHOdfBso/EEu/k=
X-Received: by 2002:a2e:91d2:: with SMTP id u18mr13559936ljg.161.1553524860700;
 Mon, 25 Mar 2019 07:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190325142317.3666259-1-arnd@arndb.de>
In-Reply-To: <20190325142317.3666259-1-arnd@arndb.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Mar 2019 10:40:49 -0400
Message-ID: <CAHC9VhTyVXMxqDvSQs5skCjAOwkjjQxENyv8UQUSMftkDBiTZg@mail.gmail.com>
Subject: Re: [PATCH] [v3] selinux: avoid uninitialized variable warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 25, 2019 at 10:23 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
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
> v3: add missing ip_hdr(skb)->version == 6 check
> v2: revise after discussing with Paul Moore
> ---
>  security/selinux/netlabel.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Better, thank you; merged into selinux/next.  FYI, I had to fix a
couple of style errors that checkpatch.pl was complaining about ("void
*" not "void*").

> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 186e727b737b..f10813e54d07 100644
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
> +       } else if (IS_ENABLED(CONFIG_IPV6) && ip_hdr(skb)->version == 6) {
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

-- 
paul moore
www.paul-moore.com
