Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E03C0015E
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 09:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGSJhX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGSJhW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 05:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94FE19A
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689759394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjvU1LtcaO9NdkL1Fw8sT9E8Z6jo4wlfs7ue95A+P6I=;
        b=bXjRAQHNfQZOMla9tHUKYwux5c1XMmL31FJ/Ncl2+5iC1E36ouQCUQZwSrBPtjJiz1I0qN
        RSxbXHQSs1AXlwx/PFyzOgQiy9WnLcad3WibCEfML8nDAn+VHWLDD2cpdbzyltNaKT/0Hq
        fkRZIF87ab/wF7t5GSrYKrO8e1MJI8k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-q3NmqAr0Ob-0qCULq9ywPg-1; Wed, 19 Jul 2023 05:36:33 -0400
X-MC-Unique: q3NmqAr0Ob-0qCULq9ywPg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-637948b24bdso15195076d6.1
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 02:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689759392; x=1690364192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjvU1LtcaO9NdkL1Fw8sT9E8Z6jo4wlfs7ue95A+P6I=;
        b=GEjbc0mORWVEKjajS0Y/bzpTyXIhtR96L5c007y5qeDBMHCpoDQ3y1iZpN8nu08n4f
         rCGfxZ9bx4+vpe+gJlSEXHzKuqCA+/9qxtPkNhYyEMb2aQcGDebPNAnKHCpnCXuiY4rK
         5xRXrelat60TVhh13m0KhcpOvVNhEzsffTrwxMPpy//Zh6eq9O0pTBkRHbA0y8I5X8Gb
         qmQbfh0VH+UuhOTsnk0OTnRA1ajBlZ105PQ53BmYM2EJDojHQ5B2y1+IzUIz8BZsLvwN
         R3bb+9zaH8e0n5r7m6rnHacaNS6POAt5C4h2t5tlCpBQvQlaAQvoDNj3ViAMNts/PIX+
         j9Cg==
X-Gm-Message-State: ABy/qLaqd/pCDwnOmozJEeof9lBroAEAmsR5I8pWljO5TeUtKAoOmNeJ
        5tGsuvG4OdXmBsYgnXhT/jqyuGY0A58m2vtllXLAO/VrWQlGGdb+6GE9g1R8WP1F6/01BCSRb33
        2ZCnBBCv/xasE2rjkC+EthlqhkA==
X-Received: by 2002:a05:6214:d0b:b0:61b:2111:c2e2 with SMTP id 11-20020a0562140d0b00b0061b2111c2e2mr14550791qvh.2.1689759392450;
        Wed, 19 Jul 2023 02:36:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpG4CFGOHzYzxSM+T/5s8VHf3IBJ198hVAToI2/t4y8eWI6uXtqt80zbJmOfPljcg3KjJtjw==
X-Received: by 2002:a05:6214:d0b:b0:61b:2111:c2e2 with SMTP id 11-20020a0562140d0b00b0061b2111c2e2mr14550775qvh.2.1689759392168;
        Wed, 19 Jul 2023 02:36:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id j11-20020a0cf50b000000b006301ec0d178sm1359679qvm.5.2023.07.19.02.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:36:31 -0700 (PDT)
Message-ID: <dc7c9c969e60fef73b6d67976eda5756255898bf.camel@redhat.com>
Subject: Re: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Date:   Wed, 19 Jul 2023 11:36:29 +0200
In-Reply-To: <CAFqZXNsExEo_LYHZ49kQqt677UU5HXuKDomh6Zw_gNNeVSsS-w@mail.gmail.com>
References: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
         <CAFqZXNsExEo_LYHZ49kQqt677UU5HXuKDomh6Zw_gNNeVSsS-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2023-07-18 at 09:17 +0200, Ondrej Mosnacek wrote:
> On Mon, Jul 17, 2023 at 4:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > Perf traces of network-related workload shows a measurable overhead
> > inside the network-related selinux hooks while zeroing the
> > lsm_network_audit struct.
> >=20
> > In most cases we can delay the initialization of such structure to the
> > usage point, avoiding such overhead in a few cases.
> >=20
> > Additionally, the audit code accesses the IP address information only
> > for AF_INET* families, and selinux_parse_skb() will fill-out the
> > relevant fields in such cases. When the family field is zeroed or the
> > initialization is followed by the mentioned parsing, the zeroing can be
> > limited to the sk, family and netif fields.
> >=20
> > By factoring out the audit-data initialization to new helpers, this
> > patch removes some duplicate code and gives small but measurable
> > performance gain under UDP flood.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note the performance gain is small, but measurable and let the selinux
> > hooks almost disappear from the perf traces I collect. The only
> > remaining perf-related pain-point I see is the indirect call at the
> > security_ level, and tackling it looks much more difficult... :(
> > ---
> >  security/selinux/hooks.c | 84 ++++++++++++++++++++--------------------
> >  1 file changed, 43 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index d06e350fedee..9a75b3bcff2b 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4495,18 +4495,41 @@ static int socket_sockcreate_sid(const struct t=
ask_security_struct *tsec,
> >                                        secclass, NULL, socksid);
> >  }
> >=20
> > +static void __ad_init_net(struct common_audit_data *ad,
> > +                         struct lsm_network_audit *net,
> > +                         int ifindex, struct sock *sk, u16 family)
> > +{
> > +       ad->type =3D LSM_AUDIT_DATA_NET;
> > +       ad->u.net =3D net;
> > +       net->netif =3D ifindex;
> > +       net->sk =3D sk;
> > +       net->family =3D family;
> > +}
> > +
> > +static void ad_init_net_from_sk(struct common_audit_data *ad,
> > +                               struct lsm_network_audit *net,
> > +                               struct sock *sk)
> > +{
> > +       __ad_init_net(ad, net, 0, sk, 0);
> > +}
> > +
> > +static void ad_init_net_from_netif_family(struct common_audit_data *ad=
,
> > +                                         struct lsm_network_audit *net=
,
> > +                                         int ifindex, u16 family)
> > +{
> > +       __ad_init_net(ad, net, ifindex, 0, family);
> > +}
> > +
>=20
> Since there is nothing SELinux-specific in these helpers, maybe it
> would be better to move them into <linux/lsm_audit.h> and also convert
> the other users of lsm_network_audit (Smack and AppArmor) to use them.
> (In fact AppArmor already seems to do something similar using its own
> macros.)

I'm even less familiar with the internal of AppArmor and smack than
with selinux. After a quick look, I think AppArmor will be better off
without by the above, as there is a single possible user of such
helper, not much relevant from perf perspective: socket creation is
much less critical then packet reception, transmission or bh
processing. Additional hooking the common helper in the existing
macro's layers will probably require=20

Smacks uses lsm_network_audit in more places, I tried to give it a shot
but the diffstat looks quite not compelling to me. Additionally I had
to prepend the 'lsm_' prefix to Paul's suggested helpers names, to keep
them consistent with the common APIs.

The main point, I think, is that each lsm does net information parsing
in a slightly different way, makingthe common helpers for such task
quite not fitting, short of some refactory in each lsm module.

TL;DR: I would avoid extending the helpers usage at this point. If
there is interest from other other lsm's maintainers, I think such
extension could be a follow-up.

Cheers,

Paolo

