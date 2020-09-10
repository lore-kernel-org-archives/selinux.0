Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F56C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 12:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DBF20BED
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 12:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il/6Yv1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgIJMgN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbgIJMeG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 08:34:06 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCABBC0613ED
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 05:34:05 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x69so5721043oia.8
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 05:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfvcHIZqtFL8WNWU7eRQgHJQdF22TwkwfJVRxq+Kxv0=;
        b=il/6Yv1pPp2MTDADEUfZWHsQ4VDGa/ejJlkXpWLeFney/yw0bhMRkl0EtF+YjfgJ8O
         l10lj0+YZ52AsS4DK1QuQnr2syJTkIjSBey8LqisbAO3PkDNKO/JydPHOHAB4Isw7dou
         eegUARIRWFv+OrBDQQpSOGq24DzQYMRExUeOG4Dx/mtnBLEUvco5IOc3yxUfC2ZTPYQu
         K3OHADBqkmI34B2WCWmdb89P19R3dRSG2GWIrCZ4Z9OCQnEctgow157fqotio8R9Pjrw
         rq/wHtk7RYA6EzPs6cOKBZsvMPDk3ss+7Nt2OTWEF3E0CgJzQTpbz5kqsptegUymNrwN
         agxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfvcHIZqtFL8WNWU7eRQgHJQdF22TwkwfJVRxq+Kxv0=;
        b=QZCM2aenB6tkr4i4MjMLTSwnHX0SiFysHfbX4x94IyiE9sIFgeCoYkbsRX+Roakngg
         FJV+ZrFZ24Rzh6QCSg/XhVUH7uvqNggAvnEZ92mJMo9ZbWnpv/C/P41p8/SY/fG0ZKoE
         E5f/CIKLK4DleEkN28GkQCkKMg47KIQibwpUpbYnVk/LRl1eN/Zn/3MizA8ucleZZCoq
         uJwNDtoYeM5NZtmWBbaim4eVs4AD01wU8DUzAmJgHSYmvgCY38Uge3rfFFkT1SJy2IbI
         5GY5plXGQYgM+guL65OKL8e6JoKPh79P941EPQ8i7I+T8r180k94VRMzBFgFr+LttWhN
         qXwQ==
X-Gm-Message-State: AOAM530BpyqkHSJTUI58vIugn7G37B1rcB7aaX4G/DtgP9XdIorf6AC4
        CwlV7OFSzHZIbz9m1so9myiPX7lUMLuTVonFgUg=
X-Google-Smtp-Source: ABdhPJy3i67DVEfhKQs6acXJTQscOMEx7G+fPn68EyRC4mRUf76QGjS6OAuGYFhmJ6GAkKcnReg1BK6cW3FyxYGTIaQ=
X-Received: by 2002:aca:ec53:: with SMTP id k80mr3384879oih.92.1599741245278;
 Thu, 10 Sep 2020 05:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
 <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
 <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
 <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com>
 <20200819171459.GA57975@localhost.localdomain> <CAEjxPJ54j6PD6oBMWj7wOVskJuUY=BLpMCkdmmqwrP1DGJ0VqA@mail.gmail.com>
 <CAFqZXNuPCwvf2BNYrxxL-DqcwLQBCS9b78iQBfKDsWXOy8pvyg@mail.gmail.com>
In-Reply-To: <CAFqZXNuPCwvf2BNYrxxL-DqcwLQBCS9b78iQBfKDsWXOy8pvyg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 10 Sep 2020 08:33:54 -0400
Message-ID: <CAEjxPJ7t4bmmom=ORduFqG5JYkbk+JW1dB4XxLyTULu709=b4A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 10, 2020 at 7:39 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Aug 19, 2020 at 9:07 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Aug 19, 2020 at 1:15 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> <snip>
> > > So I've started to compose Fedora Change proposal
> > >
> > > https://fedoraproject.org/wiki/SELinux/Changes/Disable_CONFIG_SECURITY_SELINUX_DISABLE
> > >
> > > It's not complete yet, but I believe it contains basic information. I'd
> > > appreciate if you can help me with text, phrases and references so that it would
> > > be easy to sell it as security feature to Fedora community :)
> >
> > I'd simplify the Summary to be something like "Remove support for
> > SELinux runtime disable so that the LSM hooks can be hardened via
> > read-only-after-initialization protections.  Migrate users to using
> > selinux=0 if they want to disable SELinux."
>
> FYI, the change proposal has now been announced to the Fedora devel community:
> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/YQIYMWKFQEWCILU7UZWXO3YFNS2PLDG4/

Speaking of this, I noticed that Documentation/ABI/README says that
files under obsolete should say when to expect the interface to be
removed, and at least a couple of them do, e.g.
sysfs-class-net-batman-adv:This ABI is deprecated and will be removed
after 2021.

Should we add similar lines to the two sysfs-selinux-* files, and if
so, what target date should we propose for each?
