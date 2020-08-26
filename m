Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15CAC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4302078D
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 20:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y77qrwNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZUzC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZUzA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 16:55:00 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC5C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 13:55:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id r8so2673145ota.6
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLdyz3or2XmHSS4t+gMfePYklbbnw2xVtpDFpxB8aRE=;
        b=Y77qrwNK2xXI52rRDJBicU++uZZ2MLoHv5oOZawlMLm8qP+OsoCpDRIknBLwrqLHLn
         tTNMcR0rRzaYY7BnPg8F34rfi307t0gTsnthJPnOzcQFav6Xsz81+8my6Fg9ILziNAF4
         qPjPlW/vj9UZCnNrKykOdANJ4Wtj0TUDNspJwOFHQi3LTQzMGfOIkEMTSoevFotHmlk/
         skYN85Nf5V97bzfBKigew6+4bBcIFPvPl5NrmvpGqaUfg9ET5dcJ3Imz+ep9is6svjhv
         wUVFJyxzb17h7rUkUvxy7qUQgoz1UxRmV3PNXbgKPbNRvEEG+0oBSzh74nVFSqF1TIcQ
         qpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLdyz3or2XmHSS4t+gMfePYklbbnw2xVtpDFpxB8aRE=;
        b=dFYsUA19erHrYSCxE3aZ8vEgSFL8uN3jH+Vvaju+Nq0fB8QjXXNoTG41vY/t5f/WuY
         op9YIJMIM/ttlLBS8P9ryVr4w2LxjQBFuEKPdDJd00AVut4b7TK3qhsJwOwnsGjhAUZp
         bsZfgq9m7Enn/bMmx1naD6Pi2Ki8jKFLqHMCYdg+AIy8z39oZtHpKhvwQu6uq4jh58Oa
         ohkBW+Qd8s3e2u4o+QbgrW2+rB000rBEQs3J4TB2ekwdzOwvURO3JnK/KJ6vZdUSLVYg
         pLtTbH8/KjRsvIwMlQUbmlFqawk/jg95twI5Z0x1KqHHwE94No4h2gHKk6V1Usos5+pu
         yiJQ==
X-Gm-Message-State: AOAM532RfRy4ZEc7aTRekvJHCoOB2lSBN6/XYs2KKbZ02ALAgE+ulJGI
        rKmojdPZ0lQFsLgO3jb1zLtsapnK+1q2DmS8m28=
X-Google-Smtp-Source: ABdhPJypO0+PDCBK2CW0pczDLKhctwU/NXJpTIwfDiiC+caJCgYPN2v+ZAEAjLSoNdoxTuOXNZEsjLQV+Kq9oq0erQc=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr10643476otr.89.1598475299889;
 Wed, 26 Aug 2020 13:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6s0AgwoMqP=YCweRGpkC5wsvtusmNO235_S=97NmvSeA@mail.gmail.com>
 <CAHC9VhTbOfFxtjWYytX4qC9hqeNuUV5dnfcES2qUtYzpuUnBuA@mail.gmail.com>
 <CAEjxPJ5cRbCogQ17aakpnMp_0nwDHbMQTqC69SXBA3JcmP1nuQ@mail.gmail.com>
 <CAHC9VhSm2qKkhUK7dnn6_aPPY4LsVqeQwD2Xf6k7EvV9xJg_sQ@mail.gmail.com>
 <CAEjxPJ6KD4FfhWMYqBu7tupNAWEQqbWbA2o4YgsTQ1sPQTUNzA@mail.gmail.com> <CAEjxPJ6kj6LRFoiVG0v2QPEMXHw7YHPCOgJqQwvaMbDCYnyZTw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6kj6LRFoiVG0v2QPEMXHw7YHPCOgJqQwvaMbDCYnyZTw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 16:54:49 -0400
Message-ID: <CAEjxPJ5ovzeQ+NQ5YZitjrWmEUFPBEAAj5Gq7fHNkpwJfv8eFQ@mail.gmail.com>
Subject: Re: working-selinuxns rebase
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 4:50 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 21, 2020 at 5:00 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Aug 20, 2020 at 9:17 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Thu, Aug 20, 2020 at 8:10 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > Unfortunately I need to re-base it again and manually fix conflicts
> > > > with my patch to avoid deferencing the policy prior to initialization.
> > > > And I'll need to do it again when/if the patch to convert the policy
> > > > rwlock to rcu lands.  So you might want to wait. I'm starting to
> > > > wonder if the first patch in the series to rename selinux_state/state
> > > > to selinux_ns/ns throughout is a mistake because it produces a lot of
> > > > unnecessary conflicts.  Originally I did it because that was the
> > > > original naming since the encapsulation started to support namespacing
> > > > and then I did a mass rename to selinux_state/state for upstreaming
> > > > since I wasn't yet upstreaming the actual namespace support. Renaming
> > > > it back again reduces conflicts in the later patches but makes the
> > > > first one a pain.  But if I just do a mass rename on all the later
> > > > patches then I can drop the first one and avoid these unnecessary
> > > > conflicts.  Thoughts?
> > >
> > > I agree, the first patch is the one that always causes me the most
> > > pain; considering the work-in-progress state of the patches I think it
> > > would make the most sense to drop that initial cosmetic patch for now
> > > and we can always reinstate it at the end when this work finally
> > > lands.
> >
> > I've made a pass at this and force-pushed it to my
> > working-selinuxns-rebase branch.
> > It turned out that the first patch did two things: it renamed state to
> > ns and it changed all direct references to &selinux_state to use a new
> > current_selinux_state pointer to a static init_selinux_state variable
> > (in preparation for multiple states/namespaces).  I had to retain the
> > latter so I just dropped the renaming part of it, rewrote the
> > description, and did a mass rename in all the subsequent patches back
> > to state. So the first patch may still produce some conflicts but
> > there should be fewer of them.  This is relative to your current next
> > branch but it will need to be manually re-based again when/if the
> > policy rcu patches land, so feel free to wait if you want.  Since
> > every patch required modification and many of them required manual
> > fixups, I dropped all of your Signed-off-by lines and rewrote all of
> > mine with my current preferred email address.
>
> Re-based again on latest next and it was much easier this time around.
> Will need to do it again once Ondrej's patches and my policy_mutex
> patch land but hopefully not too much work.

I'm also considering whether to drop the two patches that were
externally contributed.
The one from James to mark init_selinux_state/ns as ro_after_init
seems kind of pointless; it isn't really used after init except for a
check in the runtime disable code so I don't see any gain from making
it read-only.  The one from Peter to introduce a lockdep class for
what used to be the services (security server) locks is partly
obsoleted by the elimination of the policy rwlock and the description
no longer fits since the status lock got moved up earlier from the
selinux_ss to the selinux_state.
