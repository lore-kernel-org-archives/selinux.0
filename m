Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E49C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 20:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA712078D
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 20:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZJba9Yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHZUuh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHZUuh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 16:50:37 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F1C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 13:50:36 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x24so2671233otp.3
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EARa78hVXNroRCtFkApTxtqJ52u6v2yP17xWiUWo1f4=;
        b=aZJba9YwKtWQ/urtovU2Ike0wcW57VS8/yBLkT7phshvlaC8EKZOqEiVB+GlvuYedq
         k4KEQQpmJv5t5n15WUuii/JumO3neJMoAr1OhqHDcjRwJcLUIrowkyam/k2r4dBK3n/U
         GvmMk6z9HFZhxut42RLNJvnFS8WQYLXWBdDbkOB+nmLM5Qh5FxNu/out3VZZAk/0kTAd
         PttbZFCpcJNs5J82PQ7L4RZnY6pw8WpjIr++fbC8SGSy3mtWMkLBLIsIjcI6ZArhSKsx
         c4rNDVthn/17y+2UlEUFXAs1LGi5t5zy9Fib7HH+wmMiC9kl/Xlb7NBAgT1IX4HrN0PV
         2+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EARa78hVXNroRCtFkApTxtqJ52u6v2yP17xWiUWo1f4=;
        b=Fqv+vQzg378NEkEqGjI/+Oi45iPhXQggNtp7SrpgfAGHvqNjiuXVecZwGB9UU+VNVS
         AWHoGPj14aLn9tMIhch4HLBDHwTWa6VyjNs5Fc4Az+p/vskDcWM1rzH5uZ4Nu0+UTNsc
         6qxq6FThMV1B2XmNYOo14OFFtrKMXdg4BqI0vmahDNtP2WfAU9vMWVulEixi+uHvSklI
         fJuCvcmVvPWaUW/NvZwOnq8TB/9EDwrN+kzEkKuqrvzOkOfkHRbw8iY5dAEPfBVc3jql
         WPacYl+pBNvLePC4YRp6G3QN2u1HW0UYkcR0HwNeeycjcK+gKuAyyKzbK+/kRK1m61IB
         Iteg==
X-Gm-Message-State: AOAM533S2zewywNv/E6YcUVMuV84rUY7Pa4flgLneuZsRKI1qAa1ukUc
        3xZImMc9QXQo2ixTblWHdK3MjwuE167daNd0mRgNLUPB
X-Google-Smtp-Source: ABdhPJxA6UkdzlCIvRc63dXNEReSDN9scJTFUjclPcOR/lD5cUUKENkEqE8AZ0+z5sJyTLljO2ydyZ1xT7GuP+iR4Fg=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr10634340otr.89.1598475034592;
 Wed, 26 Aug 2020 13:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6s0AgwoMqP=YCweRGpkC5wsvtusmNO235_S=97NmvSeA@mail.gmail.com>
 <CAHC9VhTbOfFxtjWYytX4qC9hqeNuUV5dnfcES2qUtYzpuUnBuA@mail.gmail.com>
 <CAEjxPJ5cRbCogQ17aakpnMp_0nwDHbMQTqC69SXBA3JcmP1nuQ@mail.gmail.com>
 <CAHC9VhSm2qKkhUK7dnn6_aPPY4LsVqeQwD2Xf6k7EvV9xJg_sQ@mail.gmail.com> <CAEjxPJ6KD4FfhWMYqBu7tupNAWEQqbWbA2o4YgsTQ1sPQTUNzA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6KD4FfhWMYqBu7tupNAWEQqbWbA2o4YgsTQ1sPQTUNzA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 16:50:23 -0400
Message-ID: <CAEjxPJ6kj6LRFoiVG0v2QPEMXHw7YHPCOgJqQwvaMbDCYnyZTw@mail.gmail.com>
Subject: Re: working-selinuxns rebase
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 21, 2020 at 5:00 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 20, 2020 at 9:17 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Aug 20, 2020 at 8:10 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Unfortunately I need to re-base it again and manually fix conflicts
> > > with my patch to avoid deferencing the policy prior to initialization.
> > > And I'll need to do it again when/if the patch to convert the policy
> > > rwlock to rcu lands.  So you might want to wait. I'm starting to
> > > wonder if the first patch in the series to rename selinux_state/state
> > > to selinux_ns/ns throughout is a mistake because it produces a lot of
> > > unnecessary conflicts.  Originally I did it because that was the
> > > original naming since the encapsulation started to support namespacing
> > > and then I did a mass rename to selinux_state/state for upstreaming
> > > since I wasn't yet upstreaming the actual namespace support. Renaming
> > > it back again reduces conflicts in the later patches but makes the
> > > first one a pain.  But if I just do a mass rename on all the later
> > > patches then I can drop the first one and avoid these unnecessary
> > > conflicts.  Thoughts?
> >
> > I agree, the first patch is the one that always causes me the most
> > pain; considering the work-in-progress state of the patches I think it
> > would make the most sense to drop that initial cosmetic patch for now
> > and we can always reinstate it at the end when this work finally
> > lands.
>
> I've made a pass at this and force-pushed it to my
> working-selinuxns-rebase branch.
> It turned out that the first patch did two things: it renamed state to
> ns and it changed all direct references to &selinux_state to use a new
> current_selinux_state pointer to a static init_selinux_state variable
> (in preparation for multiple states/namespaces).  I had to retain the
> latter so I just dropped the renaming part of it, rewrote the
> description, and did a mass rename in all the subsequent patches back
> to state. So the first patch may still produce some conflicts but
> there should be fewer of them.  This is relative to your current next
> branch but it will need to be manually re-based again when/if the
> policy rcu patches land, so feel free to wait if you want.  Since
> every patch required modification and many of them required manual
> fixups, I dropped all of your Signed-off-by lines and rewrote all of
> mine with my current preferred email address.

Re-based again on latest next and it was much easier this time around.
Will need to do it again once Ondrej's patches and my policy_mutex
patch land but hopefully not too much work.
