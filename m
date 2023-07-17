Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA76EB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 20:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGQUIC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGQUIB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 16:08:01 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BFCB5
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 13:08:00 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57688a146ecso50356817b3.2
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689624480; x=1692216480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C8FKkX3Yfkjjes/0MjyA3rg8qFwFL4Cms8c67nSfmM=;
        b=JnmDEPNUSBQglhJQCiZBUobb1N0a3f0/hQ/yT8BEFKM9I/8kG45y77DGs3Kk5WTjMF
         fwS2MGVQMzDxl17sm3QYccgM1r+ozfk6x1sjsZO4daXuXokfTk/jcct3CzHpwGIVi4eW
         x8rYwr9CMZ4ipzsyy+ms1TtoBE0oNLw+FiO0CmoPkZQ+xGoMp33xTRRF9HOC+fkRZzxj
         B38P4QkgMPYhZHTBcHBHn5I3eYW+eIpC1xat7+jRn9OivO3PsCYCdenaFbqi0aB+vvlj
         AXt92Uqkrg5KPmkadLTCukTnISQhox6WSsZmwtAORTJ6YDKFOTvFWFs/sVAcBNGKduOQ
         3m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624480; x=1692216480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3C8FKkX3Yfkjjes/0MjyA3rg8qFwFL4Cms8c67nSfmM=;
        b=P2TL/G+AdRYnciDLQ7MU3Au/aryPhs7XTQeGIoEkjXae0qCI6mhVVUkyVBSwUnYVJk
         zyayAwZZg0cfwciniIuKRAfr9IJbcS1O131CBJX8dLRsPENZBlvq3HL+RTpbkolqVXsI
         7WBl7IKUpuW1CFYQxkcnDtvzRQHtfm0Y/SfLGYGods3RzzP+lxSg1/CWqpocdWpyYS/t
         +/e98DsN7BDxLESB1W+LpWqLS1XHtZjcENLJDxdr/NHDWDCAeuQMZ3Q2h7dPpOC4OS6P
         PdY2ka8Yu3eddVk9f9Dl72eQM+mKYWiI/39X8wo6FEfC8OJ1PAYTeJCda6tN1BwkHQnQ
         1W8Q==
X-Gm-Message-State: ABy/qLboreK6ZFI1E1WYew0b+hO++Yp358t+HNJissalRErUYNmtgc6D
        dZ4P1+VP6umXCPUf0U1v60LmWT8cfVd/uB8pPldgJXRK3DBOm+Q=
X-Google-Smtp-Source: APBJJlEtJdhcGy9NVnbbXuLyQZkUC/7+29SbOFJbo6enR6WIYKklRLsfRnA8CDAPlT84uTwtm0yGjYN60bcn0hs9aj0=
X-Received: by 2002:a81:8906:0:b0:569:e7cb:cd4e with SMTP id
 z6-20020a818906000000b00569e7cbcd4emr12437962ywf.48.1689624479893; Mon, 17
 Jul 2023 13:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
In-Reply-To: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jul 2023 16:07:49 -0400
Message-ID: <CAHC9VhQEctxOED6chHFqrY=FrDeZoQEFq0MOt-=Ngp+awumNEw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 17, 2023 at 10:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
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

Overall this looks good to me, I just have some bikeshed-y comments
around function names (below) ...

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

Let's call this "__ad_net_init()".

> +static void ad_init_net_from_sk(struct common_audit_data *ad,
> +                               struct lsm_network_audit *net,
> +                               struct sock *sk)
> +{
> +       __ad_init_net(ad, net, 0, sk, 0);
> +}

Similarly, let's call this "ad_net_init_from_sk()"

> +static void ad_init_net_from_netif_family(struct common_audit_data *ad,
> +                                         struct lsm_network_audit *net,
> +                                         int ifindex, u16 family)
> +{
> +       __ad_init_net(ad, net, ifindex, 0, family);
> +}

... and I think this should be "ad_net_init_from_iif()".

--=20
paul-moore.com
