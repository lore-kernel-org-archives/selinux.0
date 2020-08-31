Return-Path: <SRS0=sjmt=CJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E27DC433E6
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1742D20767
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 15:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMaE1MWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgHaPwU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgHaPwT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Aug 2020 11:52:19 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A78CC061573
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 08:52:18 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v16so5713232otp.10
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAVlvGbQ3EzeowhjspidzVyf9/PskZjltYIqM4g9dzA=;
        b=lMaE1MWgVQc09ACpJDWts0LszIP7KLD4CqIiSNJ1DMoKpHk2p1iSoUOy1Qoss6wHpF
         oqUc+Ch+utXOPek7PXfSTuYO8JfoBdVcYu0O3x9VtJHvN+vvdbnsxSlHvmG2wuwO8Oip
         kr5AAUGZGg/C7s/zDj43mzF20TPtzTNdjEpXBtj5RJwlnF58WriyQY//ZUbB0bE1HXOO
         7X+ufN3rIAd+R7K58zOEt8Do7VqN9wJZDAnfl5AZFZ0YF9BJzn0MkAWYqkuQkgcvUo9i
         zKvOpE11+PW53p530hs7YXZrQds0Ars9L9CDsvV6NrgC3e0hxsoFRUYM+yuq1i4PSOHL
         WaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAVlvGbQ3EzeowhjspidzVyf9/PskZjltYIqM4g9dzA=;
        b=T4D5myV4qoSJnansl8YeZvU1Wv5itv9Qn3/5ib7BGJ6Q5b19YIuIVrhWlGTT5a4APw
         01jxpNU8vVjwwp0ZK3XRIC8xh93FhYiAT8d42LcF1mjn4Vxqmt5nJnEBWN/HjcZ0JMlu
         X1xIWgElCRe0jExsKoYPdNLMpIyhrGWqjbRrU5wGTT2o4nKKm+NIp3PeFj/uPmP9fPpH
         aTiOAcbaHMqil0+rtrBnXLHq3RWeAo3raF0rLCNrCGjy3LzLRuo+/jNgipfNu78IngjC
         CLT4Nvejpzi/Ag/CIJWhDH5nRu5kBfPgyS98G5k1g082wDh3UH28H1hOBxeChXTtTMUy
         2TVg==
X-Gm-Message-State: AOAM531doEyK579fUxJpBYqS+qlHrcAVUv6yOSlpfzCntR15Yf0BkwNg
        X/ZXoq/6Qq7jMcaBk35VYYJddlrrd6jay9aNGfUw56tY
X-Google-Smtp-Source: ABdhPJwrY+sb1twceqhg0YJ8aRxSzED14C0y8j4X/bYghWICXJrgZUCzgZB7xWWyTpR140xVgEhRNRfyV5swzwFXK9g=
X-Received: by 2002:a9d:185:: with SMTP id e5mr1423886ote.135.1598889137082;
 Mon, 31 Aug 2020 08:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6s0AgwoMqP=YCweRGpkC5wsvtusmNO235_S=97NmvSeA@mail.gmail.com>
 <CAHC9VhTbOfFxtjWYytX4qC9hqeNuUV5dnfcES2qUtYzpuUnBuA@mail.gmail.com>
 <CAEjxPJ5cRbCogQ17aakpnMp_0nwDHbMQTqC69SXBA3JcmP1nuQ@mail.gmail.com>
 <CAHC9VhSm2qKkhUK7dnn6_aPPY4LsVqeQwD2Xf6k7EvV9xJg_sQ@mail.gmail.com>
 <CAEjxPJ6KD4FfhWMYqBu7tupNAWEQqbWbA2o4YgsTQ1sPQTUNzA@mail.gmail.com>
 <CAEjxPJ6kj6LRFoiVG0v2QPEMXHw7YHPCOgJqQwvaMbDCYnyZTw@mail.gmail.com> <CAEjxPJ5ovzeQ+NQ5YZitjrWmEUFPBEAAj5Gq7fHNkpwJfv8eFQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5ovzeQ+NQ5YZitjrWmEUFPBEAAj5Gq7fHNkpwJfv8eFQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 31 Aug 2020 11:52:06 -0400
Message-ID: <CAEjxPJ7_XM2NGBsAc+4W4akAm8TNa=m1rz=YGWxcZbipD-REqg@mail.gmail.com>
Subject: Re: working-selinuxns rebase
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 4:54 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 26, 2020 at 4:50 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Aug 21, 2020 at 5:00 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Aug 20, 2020 at 9:17 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On Thu, Aug 20, 2020 at 8:10 AM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > Unfortunately I need to re-base it again and manually fix conflicts
> > > > > with my patch to avoid deferencing the policy prior to initialization.
> > > > > And I'll need to do it again when/if the patch to convert the policy
> > > > > rwlock to rcu lands.  So you might want to wait. I'm starting to
> > > > > wonder if the first patch in the series to rename selinux_state/state
> > > > > to selinux_ns/ns throughout is a mistake because it produces a lot of
> > > > > unnecessary conflicts.  Originally I did it because that was the
> > > > > original naming since the encapsulation started to support namespacing
> > > > > and then I did a mass rename to selinux_state/state for upstreaming
> > > > > since I wasn't yet upstreaming the actual namespace support. Renaming
> > > > > it back again reduces conflicts in the later patches but makes the
> > > > > first one a pain.  But if I just do a mass rename on all the later
> > > > > patches then I can drop the first one and avoid these unnecessary
> > > > > conflicts.  Thoughts?
> > > >
> > > > I agree, the first patch is the one that always causes me the most
> > > > pain; considering the work-in-progress state of the patches I think it
> > > > would make the most sense to drop that initial cosmetic patch for now
> > > > and we can always reinstate it at the end when this work finally
> > > > lands.
> > >
> > > I've made a pass at this and force-pushed it to my
> > > working-selinuxns-rebase branch.
> > > It turned out that the first patch did two things: it renamed state to
> > > ns and it changed all direct references to &selinux_state to use a new
> > > current_selinux_state pointer to a static init_selinux_state variable
> > > (in preparation for multiple states/namespaces).  I had to retain the
> > > latter so I just dropped the renaming part of it, rewrote the
> > > description, and did a mass rename in all the subsequent patches back
> > > to state. So the first patch may still produce some conflicts but
> > > there should be fewer of them.  This is relative to your current next
> > > branch but it will need to be manually re-based again when/if the
> > > policy rcu patches land, so feel free to wait if you want.  Since
> > > every patch required modification and many of them required manual
> > > fixups, I dropped all of your Signed-off-by lines and rewrote all of
> > > mine with my current preferred email address.
> >
> > Re-based again on latest next and it was much easier this time around.
> > Will need to do it again once Ondrej's patches and my policy_mutex
> > patch land but hopefully not too much work.
>
> I'm also considering whether to drop the two patches that were
> externally contributed.
> The one from James to mark init_selinux_state/ns as ro_after_init
> seems kind of pointless; it isn't really used after init except for a
> check in the runtime disable code so I don't see any gain from making
> it read-only.  The one from Peter to introduce a lockdep class for
> what used to be the services (security server) locks is partly
> obsoleted by the elimination of the policy rwlock and the description
> no longer fits since the status lock got moved up earlier from the
> selinux_ss to the selinux_state.

Re-based again and dropped the two externally contributed patches; we
can always revive those later and add them on top if desired but I
don't think they are essential.
