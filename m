Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D617C433E2
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 21:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291C320719
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 21:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2IuuXnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgIJV6l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:58:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39068 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730425AbgIJLlr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 07:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599738093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=19tEG56Ki36E/KtiDUvt89ryS4NT0vm1pZKWJqQLRvA=;
        b=D2IuuXnVfQuI2suzf3NWaDreM4LzaUIFZZhvDA9k+e2+yvH6thwToWcRCvoix/yCjRXo5F
        kQbEGS8E8EhDI6jpdz/pck5Jm46YukPC6QgP9VDYaD82LlzAZAIndnToAzIDUd+hw+/PQT
        sD+CEBbD630CNZjPiXftG2SWQpWEe9Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-ClSI-E6ZNYWy8QnEn2vl5w-1; Thu, 10 Sep 2020 07:39:27 -0400
X-MC-Unique: ClSI-E6ZNYWy8QnEn2vl5w-1
Received: by mail-lj1-f198.google.com with SMTP id 6so2123918lju.22
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 04:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19tEG56Ki36E/KtiDUvt89ryS4NT0vm1pZKWJqQLRvA=;
        b=o9Z41LEQSitnhq5sTSBSCS5y6D8iWg9BrECYhUQ03LcSMHe+LG10zlfDAoiBk18Sz1
         Esiz2CpPSiuXwHf0/vk1PvL1GjAowNO3CkcZfq+lzl3w3tNLA6WSEPTrUOC9oSW0sHvd
         wweu3DEku2eLcoNUn+LwYS9dyG7MIyXwfigr0GvH0F55SXQ0gVEJAXcfnZEnEfgMEWYY
         GLBXzQ/XmeoDPIawTPC+07EJM+0xN9iePoZshyjLI0ELxJZptZgwChP8motN0kZLTYV4
         kAxBm4CM1TKk3PsDMQ/ihAwm7OlQzrlA0QE9Z7HVIeNEBXjr6a7TvxCpilFmItousfsO
         u0Ng==
X-Gm-Message-State: AOAM532hpQK0cjXBr0LWxKhrfIkpis25GNx42pmxTLdYJAMzBjRLfkJF
        4FPaX6KDyIa/F+nA07EonbhUf1cVVL5zJDfgX8Dzb74aa5+M1I12aFDt64+zcLRXK87UQwbNW68
        OfLpwg3bJe1ympY2dtArUcJPuGp4yr0weDg==
X-Received: by 2002:a05:651c:38d:: with SMTP id e13mr3035812ljp.38.1599737965894;
        Thu, 10 Sep 2020 04:39:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd1ZA9pOGXtW0GFVrHd6yODZ9QHiBTOy33e8qySoo9fIRiW4fdYfaGrYqBjahvHSVCtUQroncA6gGhps9UOGI=
X-Received: by 2002:a05:651c:38d:: with SMTP id e13mr3035803ljp.38.1599737965701;
 Thu, 10 Sep 2020 04:39:25 -0700 (PDT)
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
In-Reply-To: <CAEjxPJ54j6PD6oBMWj7wOVskJuUY=BLpMCkdmmqwrP1DGJ0VqA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 10 Sep 2020 13:39:14 +0200
Message-ID: <CAFqZXNuPCwvf2BNYrxxL-DqcwLQBCS9b78iQBfKDsWXOy8pvyg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 9:07 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Aug 19, 2020 at 1:15 PM Petr Lautrbach <plautrba@redhat.com> wrote:
<snip>
> > So I've started to compose Fedora Change proposal
> >
> > https://fedoraproject.org/wiki/SELinux/Changes/Disable_CONFIG_SECURITY_SELINUX_DISABLE
> >
> > It's not complete yet, but I believe it contains basic information. I'd
> > appreciate if you can help me with text, phrases and references so that it would
> > be easy to sell it as security feature to Fedora community :)
>
> I'd simplify the Summary to be something like "Remove support for
> SELinux runtime disable so that the LSM hooks can be hardened via
> read-only-after-initialization protections.  Migrate users to using
> selinux=0 if they want to disable SELinux."

FYI, the change proposal has now been announced to the Fedora devel community:
https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/YQIYMWKFQEWCILU7UZWXO3YFNS2PLDG4/

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

