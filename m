Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF40AC433F5
	for <selinux@archiver.kernel.org>; Mon, 13 Sep 2021 13:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1CE61BB1
	for <selinux@archiver.kernel.org>; Mon, 13 Sep 2021 13:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbhIMNxy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Sep 2021 09:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244113AbhIMNvu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Sep 2021 09:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631541034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBjIIvcb5dunWtRsVviIpL9DBOBpPMCvEHR7NyeCpew=;
        b=jVyALL4fF5rGaMeuDIctAKv2DgvLVwcUNFj5A+AglGbMxyGTxN9FEelKQNeLRLd/UGs1Mk
        47F+ItWPYOk+znu0nB49VUz2pHEv1S9C0fljulPHGCr7lO0kk1pIABxAl1RmxfWY61Ehrq
        mL56a7TNTnXw9OF3NuABmssn49yv7VM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-XXaLWcefNl2O_j45KVaGqA-1; Mon, 13 Sep 2021 09:50:33 -0400
X-MC-Unique: XXaLWcefNl2O_j45KVaGqA-1
Received: by mail-yb1-f199.google.com with SMTP id 63-20020a250d42000000b0059dc43162c9so12826223ybn.23
        for <selinux@vger.kernel.org>; Mon, 13 Sep 2021 06:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aBjIIvcb5dunWtRsVviIpL9DBOBpPMCvEHR7NyeCpew=;
        b=0O/Z/sFQqVO3ONI6rz9hlK25eDFjvucv1OG54E8v9uY+a1oQsNpMvB5H/52gZGXdFV
         qBhhjKqLfk/7pLQtG7VUcJyYJKiqaCZk6Cq6dihXJN3cWm/oWtokxUOLhUA+OX5diQwA
         +z7qAulUC5nwIgsvh+jTvC6YGa9nBWbW9jEPLQ3Xe6VwGqrPrIVhwobVfAaJN4wnzSJn
         NVAZ0muH4nGNyAcWahYGSq5QWoBZ69JPhAFMU2pFJx/0wegQdg722CGTQPQaZNkCussK
         sLM1BKPIV6PtqckDpIRSaxviKL1bObgimS7hDv/WM8rRvQqANj6ughdNsia25XAor1x1
         xjBg==
X-Gm-Message-State: AOAM533tf4RGUbGJvF+v7JDkjvyRvxnqQcdWc/YB2sY2CynnuaJJZpXd
        mb+4ihMdtnFlSdrHHfAiattcfLOLj1P01qqlKxSt6+M6CTE6jmFLFAJH88Cg4JHgaosxIoenLpl
        nptQu7wWnFykbbejZyDqgXox1YnEm8mBPtQ==
X-Received: by 2002:a25:6913:: with SMTP id e19mr15482531ybc.25.1631541032785;
        Mon, 13 Sep 2021 06:50:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaynW83umBqEPokVSSibnO6NtuWoQhuE0RyA2lBp5gkMZ2HjvBKRYnpKQf1MqN054h1RGdfDAUtNC2myJBoIU=
X-Received: by 2002:a25:6913:: with SMTP id e19mr15482493ybc.25.1631541032487;
 Mon, 13 Sep 2021 06:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210912122234.GA22469@asgard.redhat.com> <CAFqZXNtmN9827MQ0aX7ZcUia5amXuZWppb-9-ySxVP0QBy=O8Q@mail.gmail.com>
 <20210913102316.GA30886@asgard.redhat.com>
In-Reply-To: <20210913102316.GA30886@asgard.redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 13 Sep 2021 15:50:21 +0200
Message-ID: <CAFqZXNsp84kFLDfJfdu5fboB8vMm85FU7BDDjpiqeiJ2WSjWAg@mail.gmail.com>
Subject: Re: [PATCH v2] include/uapi/linux/xfrm.h: Fix XFRM_MSG_MAPPING ABI breakage
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Antony Antony <antony.antony@secunet.com>,
        Christian Langrock <christian.langrock@secunet.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@strace.io>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 13, 2021 at 12:23 PM Eugene Syromiatnikov <esyr@redhat.com> wro=
te:
> On Mon, Sep 13, 2021 at 09:16:39AM +0200, Ondrej Mosnacek wrote:
> > Perhaps it would be a good idea to put a comment here to make it less
> > likely that this repeats in the future. Something like:
> >
> > /* IMPORTANT: Only insert new entries right above this line, otherwise
> > you break ABI! */
>
> Well, this statement is true for (almost) every UAPI-exposed enum, and
> netlink is vast and relies on enums heavily.  I think it is already
> mentioned somewhere in the documentation, and in the end it falls on the
> shoulders of the maintainers=E2=80=94to pay additional attention to UAPI =
changes.

Ok, fair enough.

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

