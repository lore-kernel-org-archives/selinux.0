Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B7C83000
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1CFE20774
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vri92dhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgD3OUh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:20:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726309AbgD3OUh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 10:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588256435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7yuksv3d9vr0u7wZAlXK6fVF13uFgKOcAizuHbgXr7A=;
        b=Vri92dhiRQRDIePkTkWOw/rXMQwGiID5aNnPePCCWTz1DMFjxop6Qfafm/EUVHAeYwEd5n
        rLgWiNKGNeOZwU4jOBuoq3ZLS42jvSGq1mbApsHZ+7I0/C0ro6m06fQRqMKT1w56Mi6amU
        gss+pdX22/jKBswtv09rISmt/nUZzzg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-66seQKnEMY-MLNu65aC3dw-1; Thu, 30 Apr 2020 10:20:29 -0400
X-MC-Unique: 66seQKnEMY-MLNu65aC3dw-1
Received: by mail-oi1-f198.google.com with SMTP id l2so3945987oih.19
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 07:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yuksv3d9vr0u7wZAlXK6fVF13uFgKOcAizuHbgXr7A=;
        b=bA9ugyLzAFUU8XvfmqRh1edXqVzXtn3Ilmmo2Y/xcq0SkCGlNPhAJmV0vfW5+5f+dX
         RkOyPgiRwIxZL5YOWPcD9r/FREHoz0M2zpQN76Kpwap/zzhGX6I/RXc69EXqpWt8/pGz
         p+dYza7NZ12ukcqml3N/HD1xW+y/moyo6wSMiDGdPBerPknLW74WHA9I8HZD7m7DHDfz
         /iWd3+HvxVStgmR62lh4yMswrK3JTarbaSZenCrunRuzap42A3lc0prKHAY6OYQiaCmT
         OnM4YU3g4MRBHQ4SpnKys0E+EjY7Ci6+/9iLBkKkbbgfcxtv9Due40CorEIxCNF9RagH
         uLsw==
X-Gm-Message-State: AGi0PuZZwwtIxk/wa3HuR4dU55ae1edWjhNc5V4XA6jABrw66vimqFLF
        3kVnsis/gVrrOObHzAnDakwyzb/IcOGMFlaI0Uqz7QjjdsOFV+iZhABYsMWmM+tVsKYuLM8wXQc
        aWnEfNP/vXdVpvGH9MV6+qI+ti02JPJVR0g==
X-Received: by 2002:aca:ed44:: with SMTP id l65mr1912374oih.127.1588256428364;
        Thu, 30 Apr 2020 07:20:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypI7tSyAFYVNYQhXQTLWVQC4xKX8uIk1f/aVTC6rDcjLimXUTMVYj/7pB9PaCDYIP4raVdtrdXmE69rQeuziJ3U=
X-Received: by 2002:aca:ed44:: with SMTP id l65mr1912359oih.127.1588256428095;
 Thu, 30 Apr 2020 07:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200327152107.95915-1-omosnace@redhat.com> <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
 <7549b0e2-f845-1c3a-d9d5-314cb2b9225f@ieee.org> <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
 <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 Apr 2020 16:20:17 +0200
Message-ID: <CAFqZXNuLhpOQLk54QNExgnwKZXM=nBKGg9YFxuVhUo1U+sF_jA@mail.gmail.com>
Subject: Re: [PATCH 0/2] userspace: Implement new format of filename trans rules
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     James Carter <jwcart2@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 3:23 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
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

We could also partially mitigate the problem by linking libsepol
statically into setools at build time. I suggested this in [1] for
Fedora at least, but in general there is the problem that you need to
know the exact path to libsepol.a in setup.py [2]. I don't have enough
experience with python libraries to know if this can be implemented
directly in the upstream setup.py script in a reasonably generic way.

If linked statically, at least it wouldn't segfault after an update to
an incompatible libsepol.so. It would still fail to build with the new
headers, but at least this turns from a user-visible bug to only
packager's & maintainer's problem.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1826000
[2] https://stackoverflow.com/questions/4597228/how-to-statically-link-a-library-when-compiling-a-python-module-extension/49139257#49139257

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

