Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D86EB64DA
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 07:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGRHS7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 03:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGRHS6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 03:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D699BB
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 00:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689664690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GdJJsn9w+58D5IDgpnMMjkkTN6pnVvHLSvUA87Z7F00=;
        b=isu5JjvWKW0MWKnpTlmzJkg53oWGFuKI2MDQyDpTyJ0/7SG8Afl20c7lc5SSgZL5yQCRlP
        Ep9Es+Nd0pmymfcWfRttttyLcZn0NJPp4fxvngA5BoDi5dmMChj1TtM7Rc86+agUztTI/j
        Y3yBoyQQ/s7OaEgLGErjfQ3/QN7Fsyc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-L3i3hVZKNn-NVZ_ovlQe7A-1; Tue, 18 Jul 2023 03:18:09 -0400
X-MC-Unique: L3i3hVZKNn-NVZ_ovlQe7A-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2630c837b85so2414097a91.2
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 00:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689664688; x=1692256688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdJJsn9w+58D5IDgpnMMjkkTN6pnVvHLSvUA87Z7F00=;
        b=E6PZagh54fqOeGzf7tPms0qUelpBUWXlL6sgWLvlITmF1MwRz6sPlMFvzkAJlJnFvn
         yJebb9JhJKKMjec9wTxhFbOFTdJ5vnGFJrOti4NiSErizq68wJUUrmkHmaf6kEyVlxi0
         EbUsA4cqT/kxTdwUJVzkwfyuQvv6ZEdKLioJG42QkcwH/0yYDhvefjdSl/m/2J9f03Rw
         vI136SiqHs32XV9cBT7higNiY1fGfhOT0H38ZO8nY7TNbHKiUdDwVUA74hdw6JUaMF49
         YY9ONEaB2qUDYRfmHu0m8ANnyI9qlb5yADb6nTjaQ92Swv2NfxIRbVQeDzrq0BZ7mXmk
         /WXw==
X-Gm-Message-State: ABy/qLbquXQHLvqZf3nMWcjsAQ9OMfFmokmT934lijzmlS/+OFvZ4oYo
        gYRKmxODQqRyj1iLJCh66Vc9oS4WjuUPtgo8YQX1G+YNmjUNbXDYlrIvSz0w4QaYaKP1+QzG2MH
        /9STBm4ytlwIPUSYsKV7Pjvazk+/YT1OXGA==
X-Received: by 2002:a17:90a:fe07:b0:262:ec8d:b563 with SMTP id ck7-20020a17090afe0700b00262ec8db563mr10652652pjb.18.1689664688525;
        Tue, 18 Jul 2023 00:18:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFUmicdhSoc0fbftrs04b9jzaTYB+lAoV5ECUHJKvkYLRZZHKYvmmYQT8UgA8WeTzii3xLgsE43dfMIueD84Io=
X-Received: by 2002:a17:90a:fe07:b0:262:ec8d:b563 with SMTP id
 ck7-20020a17090afe0700b00262ec8db563mr10652642pjb.18.1689664688216; Tue, 18
 Jul 2023 00:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
In-Reply-To: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 18 Jul 2023 09:17:56 +0200
Message-ID: <CAFqZXNsExEo_LYHZ49kQqt677UU5HXuKDomh6Zw_gNNeVSsS-w@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 17, 2023 at 4:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Perf traces of network-related workload shows a measurable overhead
> inside the network-related selinux hooks while zeroing the
> lsm_network_audit struct.
>
> In most cases we can delay the initialization of such structure to the
> usage point, avoiding such overhead in a few cases.
>
> Additionally, the audit code accesses the IP address information only
> for AF_INET* families, and selinux_parse_skb() will fill-out the
> relevant fields in such cases. When the family field is zeroed or the
> initialization is followed by the mentioned parsing, the zeroing can be
> limited to the sk, family and netif fields.
>
> By factoring out the audit-data initialization to new helpers, this
> patch removes some duplicate code and gives small but measurable
> performance gain under UDP flood.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note the performance gain is small, but measurable and let the selinux
> hooks almost disappear from the perf traces I collect. The only
> remaining perf-related pain-point I see is the indirect call at the
> security_ level, and tackling it looks much more difficult... :(
> ---
>  security/selinux/hooks.c | 84 ++++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 41 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..9a75b3bcff2b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4495,18 +4495,41 @@ static int socket_sockcreate_sid(const struct tas=
k_security_struct *tsec,
>                                        secclass, NULL, socksid);
>  }
>
> +static void __ad_init_net(struct common_audit_data *ad,
> +                         struct lsm_network_audit *net,
> +                         int ifindex, struct sock *sk, u16 family)
> +{
> +       ad->type =3D LSM_AUDIT_DATA_NET;
> +       ad->u.net =3D net;
> +       net->netif =3D ifindex;
> +       net->sk =3D sk;
> +       net->family =3D family;
> +}
> +
> +static void ad_init_net_from_sk(struct common_audit_data *ad,
> +                               struct lsm_network_audit *net,
> +                               struct sock *sk)
> +{
> +       __ad_init_net(ad, net, 0, sk, 0);
> +}
> +
> +static void ad_init_net_from_netif_family(struct common_audit_data *ad,
> +                                         struct lsm_network_audit *net,
> +                                         int ifindex, u16 family)
> +{
> +       __ad_init_net(ad, net, ifindex, 0, family);
> +}
> +

Since there is nothing SELinux-specific in these helpers, maybe it
would be better to move them into <linux/lsm_audit.h> and also convert
the other users of lsm_network_audit (Smack and AppArmor) to use them.
(In fact AppArmor already seems to do something similar using its own
macros.)

<snip>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

