Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3E9C001DE
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 20:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGSULs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSULr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 16:11:47 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288ED92
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 13:11:46 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5836d23abebso1088897b3.3
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689797505; x=1692389505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6lOqx60d0iTQNOe82zBrX+lChZpjpSZxlw5XN53Uf4=;
        b=EWA7G7lG7CSslGfrBWMbYb0BdJwVv+ByUJTHgHgVBv3lVt3ZLIyT56LQhh4OZsuvYj
         k376vxehfkiFuvVSTQLf/Q1WjxMZIjUmC2V9SL/YOHLoKZ8JWmeLfiaN+HA9lsxO2Ghr
         CpwHHTwUqHld4fiZ1k+vNQdFLXoitQTQj3tJ2cNHeGqRWkHSwsIcaSVL6KaetKYOFtME
         +MEaF/2PY28qqaZD7TPHaqkWXi2SjZrRjaLrlSBTrmGlt1XRxhURowdsheTGca3JRTap
         4bL3zblZqaPu/vFrso23YsBLvaVo2TuTiGns2uPCCCoC/d5yr3LNgG6+rnh439OqabpJ
         vYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689797505; x=1692389505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6lOqx60d0iTQNOe82zBrX+lChZpjpSZxlw5XN53Uf4=;
        b=DhFmlor1AGjnJDHlFEUnXSeQHSxm9VkvGLHisgUfvNOleOm5WE4pb0Tdo4orByV7gL
         1lf9YtsSnkmjdtgvV1vVNzyEJuJg9vQKuYbzjphtIU0se0HsDdQAeGWZUWxa335bYrCt
         /mPu0ryY3IVbNZ+AQadq9btxOsGN+zVPXZsIHf0yotfr+b+VHT06IEMs4L3fxgTrj+9I
         Rrmjmc+xO+WgHEf1dTQgLhW4Ve+y61GzaLPjmXxCYtAeN2Ghmt6RuvJIjIW54VEx4DnM
         qGhgLIVCeIHU/xbKXrIgDvQ0ReJDvz37Sszw+GPmfmyRKG0Yq91VHGjKA+HugUqSQpJw
         PkXA==
X-Gm-Message-State: ABy/qLYis0RzF91Ch5ANAD6UUAP8/xGvpxT+2m3XT1YeWaKxiA7gQK/t
        22izwMwHpzTLxH08zIbCimNCcP73SXHQan+qnEJu
X-Google-Smtp-Source: APBJJlE/RQy8k4fIQjViRVqcBRi+gr2MGdJyvOT8FyQP7vjL+Z+N4D98GUai7q3QbP6Dcp9YAvvDAjH81BY1mr9LWek=
X-Received: by 2002:a81:6f84:0:b0:57a:504a:e019 with SMTP id
 k126-20020a816f84000000b0057a504ae019mr180332ywc.20.1689797505297; Wed, 19
 Jul 2023 13:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <7d24dcfc0a7d89cb66cbf06e21c76bf29d3824be.1689766036.git.pabeni@redhat.com>
In-Reply-To: <7d24dcfc0a7d89cb66cbf06e21c76bf29d3824be.1689766036.git.pabeni@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Jul 2023 16:11:34 -0400
Message-ID: <CAHC9VhQjV1C8jUQnGsgQC0Pv9jdAXCj3sgyQ+xxjanKB=p2JcQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: introduce and use lsm_ad_net_init*() helpers
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 19, 2023 at 7:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
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
> rfc -> v1
>  - helper rename (Paul)
>
> As per discussion at:
> https://lore.kernel.org/selinux/dc7c9c969e60fef73b6d67976eda5756255898bf.=
camel@redhat.com/T/#m25143ccf1923fcd2e336405be57c8deb69805ea4
> this is still a selinux-specific change.
> ---
>  security/selinux/hooks.c | 84 ++++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 41 deletions(-)

Merged into selinux/next, thanks!

--=20
paul-moore.com
