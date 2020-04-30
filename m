Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AC7C47253
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB232082E
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+REJXXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgD3PVQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726810AbgD3PVQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 11:21:16 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D88C035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:21:16 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id i27so5205644ota.7
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFjZuDW5wqBH4M7f0mbE0XrVBU+DOyQeqRhLL2YUCn0=;
        b=F+REJXXAy3tJINNAX2QpkR5nCyhboNtbMCfIJkHpnhhEp8S5/jPwb+acfxPxpk3xsK
         A4qA0woS7tWQg5Gvv3aGLeBgBcCDPdsC8hSG2N4juNakAgp3I1vz5AebpDoWa3qro8xu
         mp+UMUNXhib4DGX9k5ZWMCseEIuSONROQzR5RCRvmbHVyQyverKu9wYfCn7/ISh1NPvQ
         LoFLgw62BHk1x5IaIyLVDWZlDixfxIJSEZ99Avohy8kcPfUbxf8utBjZbzUElHtMn/Lg
         03wm7+ej2iRsvXAv3XcMeMJQYxJAw2XDVn26dW0zj5pTHTma4g8jaAhw9vHwx0tj+a1B
         mAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFjZuDW5wqBH4M7f0mbE0XrVBU+DOyQeqRhLL2YUCn0=;
        b=ALJba/WiSd7vD4eg7pilp2TQN5C/7Js+dXzIkzlc6NdGQL1e99EnDcmGMhdra83QyF
         zfoZgI0LLmHCFaE/3cnJriakWbPpf2dnFIHGMUk020KQn4qN9X8xP4+jBWl7A3Ughr0s
         Ao4BOgUdOpACcnCibAQPsd2tdgR7pVK/MVxggmij6SFdO+6nxSXJ7Tdmhi/GSIzcopiZ
         Im4T2lUPYuyyESjFB3Yr/jgYn4DgUlOXIfME5hd9fBdm2ZkKasJkDZd3c9e+nHZ7GP0a
         jUfRs83zMW2MmK550Y5utCI5K8rsYQEPPskUtc+8p8yA/l1C789kjWyYGuuRbG2poKOX
         klCQ==
X-Gm-Message-State: AGi0PuaXs5uij2B1u+UBcIWgjQjrWtGReUnQENxfFx/d6yQXRm0d/IEh
        zfIcv8KBBywoej7XRLo5Efb88QFowoF+hMvqYzA=
X-Google-Smtp-Source: APiQypJ7gXBClzHXPBu2MKuVTA4fYbGvOTxmiNbjb6ikLYScVmSfQFPVE4LU+Pl2UQMbGFk+n0dzR1sbJYql2e1psYk=
X-Received: by 2002:a05:6830:1c2b:: with SMTP id f11mr3122196ote.196.1588260075122;
 Thu, 30 Apr 2020 08:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200327152107.95915-1-omosnace@redhat.com> <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
 <7549b0e2-f845-1c3a-d9d5-314cb2b9225f@ieee.org> <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
 <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Apr 2020 11:21:03 -0400
Message-ID: <CAP+JOzQxeSrk+-+FxDdop5uEkWDdDZq+psv_Kq0saNykqTiX1w@mail.gmail.com>
Subject: Re: [PATCH 0/2] userspace: Implement new format of filename trans rules
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Chris PeBenito <pebenito@ieee.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 9:23 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Apr 29, 2020 at 3:01 PM James Carter <jwcart2@gmail.com> wrote:
> > I think the fact that the CIL, kernel to CIL, kernel to conf, and
> > module to CIL code is all in libsepol speaks to the fact of how
> > tightly integrated they are to the rest of libsepol. One argument that
> > could be made is that the policyrep stuff in setools really belongs in
> > libsepol.
> >
> > Thinking about how libsepol could be encapsulated leads me to a couple
> > of possibilities. One way would be functions that could return lists
> > of rules. The policy module code gives us avrule_t, role_trans_rule_t,
> > role_allow_t, filename_trans_rule_t, range_trans_rule_t, and others.
> > Those structures are probably unlikely to change and, at least in this
> > case, creating a function that walks the filename_trans hashtable and
> > returns a list of filename_trans_rule_t certainly seems like it
> > wouldn't be too hard. Another possible way to encapsulate would be
> > create a way to walk the various hashtables element by element (I
> > think hashtab_map() requires too much knowledge of the internal
> > structures), returning an opaque structure to track where you are in
> > the hashtable and functions that allow you to get each part of the
> > rule being stored. There are other ways that it could be done, but I
> > could rewrite kernel to and module to stuff with either of those. CIL
> > itself would require some functions to insert rules into the policydb
> > which probably wouldn't be too hard. None of this would be too hard,
> > but it would take some time. The real question is would it really be
> > valuable?
>
> I don't think we want to directly expose the existing data structures
> from include/sepol/policydb/*.h (or at least not without a careful
> audit) since those are often tightly coupled to policy compiler
> internals and/or the kernel or module policy formats. Creating an
> abstraction for each with a proper API in new definitions in
> include/sepol/*.h would be preferable albeit more work. There was a
> proposal a long time ago from the setools developers to create an
> iterator interface and accessor functions for each data type, see
> https://lore.kernel.org/selinux/200603212246.k2LMkRNq028071@gotham.columbia.tresys.com/.

I am so used to everything just using the stuff in
include/sepol/policydb/ that I forget that it exists. There are a
number of iterators there (for users, ports, nodes, etc), so it seems
like creating an iterator and other functions for filename transition
rules and converting setools to use that would be the first step. Over
time other iterators can be created and setools converted to use those
as well.

Jim
