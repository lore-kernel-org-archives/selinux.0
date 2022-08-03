Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8A1C19F28
	for <selinux@archiver.kernel.org>; Wed,  3 Aug 2022 09:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiHCJDV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Aug 2022 05:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiHCJDT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Aug 2022 05:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6279629816
        for <selinux@vger.kernel.org>; Wed,  3 Aug 2022 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659517397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dhnmgBCHJ2s739+QPGvnnKkNYP0xnEl6DjbYe/za7Lc=;
        b=PklU5QuvldFDq4uoQWnBzQuvYLWgOcLljI7iUklFMK7kNgi65P1ngyFDCVpQDPlCUW/ifO
        LaXPwP3MqepxCDYYCoGDuWUzHCrCtlcVNnF0Nhk15IE6+QhPjSJWXJznFwl68vgbMQmWyi
        a7jNd7JRuyZow7HtSogNPcvYTmm8wc8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-gXh-Ut3APXOuPv-ZiEou1w-1; Wed, 03 Aug 2022 05:03:16 -0400
X-MC-Unique: gXh-Ut3APXOuPv-ZiEou1w-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-31f5960500bso138753147b3.14
        for <selinux@vger.kernel.org>; Wed, 03 Aug 2022 02:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dhnmgBCHJ2s739+QPGvnnKkNYP0xnEl6DjbYe/za7Lc=;
        b=dvBTpBSoglR6w5CqzzUy0DbHGDfHlbSB+QzoizxlhQhjGA1oqfRWBXcVpMqOUPv8MU
         n/vzrqOH20S1kZO4ViGhp4hPuF0qyE6NL98QgYVS93hsYDK0gdlAfWtKl1sxxWCUeNAK
         n7nBh1DhIbwfSKOhyRsnQ1rhlKKa0IK6K5kxDD7iW1/2PXydbPtMiR/qn5bUjK6suSFy
         ix7xnUi36ty+JSbFqHUykUi3yiMnP5m5cqbFqLu+eig0Mb+VZyEpqWiq7cYVYLbh+uoi
         aYj1elz0r34ChyZBp8SQH8qncVXzzj1l1rwY8/Hrh7ajPe/lhWX3ZZu8/xWTCoWVj1ju
         bBRQ==
X-Gm-Message-State: ACgBeo2xdEv88+DA8fb+qsFfPaBuJr3tBcmeNuH6A3JI+2Dz6tKzsAAI
        5cmCu2GM3JMwkU1UR0xFE5LW0uTkLDwU5BUhfb1xyApjYemoJNnh76GYvSp7XIfSoa5RDF4ZSRW
        nNEdgGR+FZtjV2BFo7dlteIrVLwOBR1VNIA==
X-Received: by 2002:a0d:f6c4:0:b0:328:2c56:6463 with SMTP id g187-20020a0df6c4000000b003282c566463mr4335718ywf.459.1659517395205;
        Wed, 03 Aug 2022 02:03:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5KGIxMF/2Z0Rajz9vh5d9X1h03qPMNVCFAgdYcfC0RLyep4icfijeixAbbmwzMaiB9IOErssN0XoNlma64hSU=
X-Received: by 2002:a0d:f6c4:0:b0:328:2c56:6463 with SMTP id
 g187-20020a0df6c4000000b003282c566463mr4335706ywf.459.1659517395015; Wed, 03
 Aug 2022 02:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220729120229.207584-1-omosnace@redhat.com> <20220729120229.207584-12-omosnace@redhat.com>
 <87618b9d-129f-5087-3010-52f5762b85f5@linux.microsoft.com>
In-Reply-To: <87618b9d-129f-5087-3010-52f5762b85f5@linux.microsoft.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 3 Aug 2022 11:03:04 +0200
Message-ID: <CAFqZXNvnpudTc4xSL=2AAwQy8rcBTiLMJvQAsrxBR0X5CHBMvg@mail.gmail.com>
Subject: Re: [PATCH testsuite 11/24] test_general.te: move sysadm-related
 rules into an optional block
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 2, 2022 at 4:03 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
> On 7/29/2022 8:02 AM, Ondrej Mosnacek wrote:
> > That should allow running selinux-testsuite with the sysadm module
> > disabled.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   policy/test_global.te | 26 ++++++++++++++------------
> >   1 file changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/policy/test_global.te b/policy/test_global.te
> > index aceac48..3862ee7 100644
> > --- a/policy/test_global.te
> > +++ b/policy/test_global.te
> > @@ -25,12 +25,21 @@ optional_policy(`
> >       dontaudit unconfined_t testsuite_domain:process { noatsecure rlimitinh siginh };
> >   ')
> >
> > -gen_require(`
> > -     role sysadm_r;
> > -')
> > +optional_policy(`
> > +     gen_require(`
> > +             role sysadm_r;
> > +     ')
> > +
> > +     # Authorize sysadm_r for the test domains.
> > +     role sysadm_r types testsuite_domain;
> >
> > -# Authorize sysadm_r for the test domains.
> > -role sysadm_r types testsuite_domain;
> > +     # Allow the test domain to be entered from sysadm_t
> > +     sysadm_entry_spec_domtrans_to(testsuite_domain)
> > +
> > +     # Let sysadm_t use runcon to run the test programs in various domains.
> > +     #allow sysadm_t self:process setexec;
> > +     #selinux_get_fs_mount(sysadm_t)
> > +')
>
> These commented out rules can probably just be removed entirely instead
> of being moved into the optional block?

Probably, but I didn't want to think about it and just preserved the
fossils :) I'll take a closer look and possibly remove them in a
separate commit.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

