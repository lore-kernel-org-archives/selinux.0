Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D6C433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 14:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B968620873
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 14:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEXT/gvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbgE0Oo4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 10:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388356AbgE0Ooz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 10:44:55 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BC3C05BD1E
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 07:44:55 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l6so21907717oic.9
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6j8W5yL67tA9OhQuTuFlPPXHMSnUbiYMy1tdvcYRB0=;
        b=VEXT/gvlgCnQw6Y3WLthWSz/RhQSd2EIJVJx/+Z5wMfUpmV0tm2t3/yNfn9Kmc4gHc
         QtDEDOQPq7pGxIven8GJhOBLOjYzpsyoYnAfZOUsRvU58JVjKDabE6xIX34WlG0y0yY8
         fOWGaE/5eVOa1rg7/PA5QOGIuStF3mfjrOK/FR49jn7QModKPHQmAksS4ZbmwrOfSXfT
         N2amYcFHydz9MZKfyrPK8epI/1ksRirlAV6m1fDFk9ly4w0FT1d6dgTt9ywP9gNxALk8
         T0RXqZvRQ/45vLKN8aCT037yV+GRHeKT5r4+tX1nOVjmkljR4cuN/1ZDmVNq7tLKtWI2
         96Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6j8W5yL67tA9OhQuTuFlPPXHMSnUbiYMy1tdvcYRB0=;
        b=QXH2fto+mqQBf2SF8r8rriRBOr03SLD7FmI/a6YHSE7fS9up8c++Cs7gNLKvgMLZ5Z
         C62CatUW9vyFu6jhXGqhNDSVD1P9+YHWaZ6KOiMDluyuKpekpQO5Oe7y70zTOUtF6iGE
         yEpiOh52npMm2TuU3ylU6n8nx6Is5Z7ymf0YPjE3gMY68Q/2shIrgfD++oqIRY3ynTFN
         TchZy5xI5OMlZ/D7/1y3nWfmGxW3oRuzALiDLEFZMS7HTsNejJpYvrjpxt6G4yFFed2S
         nJaAP1cx0wpSmbKRLTDUy354c8KBR74jQzYmS90BuYAQZ9fj2/nbtG4ElTifbloAw4Kv
         oB2w==
X-Gm-Message-State: AOAM533xG6iraOc6J90L/akvpjvB10wgssTF1RiIuNcLZyeV6mplP6GQ
        Qn/ecSKD3i20MA11umvgj0EBdjuJLhC+81rGAFA=
X-Google-Smtp-Source: ABdhPJxWm5eM957qvPmwK29/Qy9BQi2o6tmoMuiaC+/MurzICcsPZ83PrGz2jOgn1PmSX/siC5zL1yY1pkrfbR+GSPs=
X-Received: by 2002:aca:72d6:: with SMTP id p205mr2967873oic.128.1590590695020;
 Wed, 27 May 2020 07:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145038.194209-1-jwcart2@gmail.com> <20200522145038.194209-2-jwcart2@gmail.com>
 <CAEjxPJ6FBrGviZVjGQE=-wfVsetubcKfM-FTTqpAp9ZnCF_geA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6FBrGviZVjGQE=-wfVsetubcKfM-FTTqpAp9ZnCF_geA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 27 May 2020 10:44:43 -0400
Message-ID: <CAP+JOzT92X+D3i4nZDtK7XtPnQLM=_-Sy_6kG0mTTgydCU=XhQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libsepol: Fix type alias handling in kernel_to_conf
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 10:23 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 10:55 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > Type alias rules are not written out when converting a binary kernel
> > policy to a policy.conf. The problem is that type aliases are not in
> > the type_val_to_struct array and that is what is being used to find
> > the aliases.
> >
> > Since type aliases are only in the types hashtable, walk that to
> > find the type aliases.
> >
> > Fixed the syntax of the typalias rule which requires "alias" to come
> > between the type and the aliases (ex/ typealias TYPE alias ALIAS;).
> >
> > Fixes: 0a08fd1e69797d6a ("libsepol: Add ability to convert binary
> >        policy to policy.conf file")
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> This fixes the missing alias problem, so:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> However, in testing these, I noticed that if I do the following:
> checkpolicy -MF -o policy.conf -b /etc/selinux/targeted/policy/policy.32
> checkpolicy -MC -o policy.cil -b /etc/selinux/targeted/policy/policy.32
> checkpolicy -M -o policyfromconf policy.conf
> secilc -o policyfromcil policy.cil
> checkpolicy -M -o policyfromkernel -b /etc/selinux/targeted/policy.32
>
> then the three policyfrom* files differ in length and contents.
> Decompiling them all via checkpolicy -MF (or -MC) and diff'ing those
> (since sediff takes too long) appears to suggest differences from
> attribute removal (odd since I thought you reverted that), redundant
> rule removal (isn't that off by default too?), and portcon ordering
> (by protocol).
> Optimally we should able to regenerate the same kernel policy from all
> three (although we might need to run the kernel policy through
> checkpolicy to normalize ordering).

Interesting. I thought that we had mostly fixed the ordering issues. I
will take a look at this.
Jim
