Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6C2C4724C
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3D32076D
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLU9Gas8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgD3PeY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:34:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49941 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726344AbgD3PeY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 11:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588260862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VcS56AQwZhyTwyX8D3CHc5mIkX0kLPpz7R1mIz1Ei/c=;
        b=BLU9Gas8IEMoLJyS1F/59+oJr8mm9gReP19J87LV9WTBJGqnPljuXJ7ZT8hrzH7wRnKkqf
        3oT1UTbKe36Gp7J5cxmhR9SdLX8kAqHxNOZRMlsDgVz4CHSl2X6AeuWxMmfJjN3kCKBZml
        dgWdxuqE94QEDUkuEsMSOFpxNSBxVfI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-hwjktKpuMBOyANysCd-VwA-1; Thu, 30 Apr 2020 11:34:18 -0400
X-MC-Unique: hwjktKpuMBOyANysCd-VwA-1
Received: by mail-ot1-f71.google.com with SMTP id 22so4281018otg.7
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcS56AQwZhyTwyX8D3CHc5mIkX0kLPpz7R1mIz1Ei/c=;
        b=kp+wFCl7zLGCZwGtGzzESDjlIxZi8WJ0SB6p95yr1j5aAk8RWuN7+zFJcWbZAIArmR
         D0Fz3ARXq+okAIiYpWruFBY/BEYkxkrzm4n5L/Dk/tqzgCR2GoejDQ9E5xkF9FyBG+cB
         Lm/fhHzdwcqTZs0iJyowFapu1DCovLim4m3cDHN/QCW+MOcA9vzINs7zhwYT3tkbxqKc
         ezklZv9TKfkf5B9zng6/ytah8lOVcO+ODc9gVGxPrle9lC9U0mo10oMqe+/fV99v2JDQ
         NSe2G/KGL1IxpGAfBXnrIezLCOq6hJ66RgHdighcJ2liRtCXczLKK5l2/kOdlFxagxFv
         aqwg==
X-Gm-Message-State: AGi0PuaSPErRGa91mPZu+C9zyjfyJ+bikKgOo12CaT5sfXC3bx/xszYE
        4L/YqR+h0xkXaIuCiWk7pGplLwY36u8QKPV9HTqCbG5S0asX8N0plQI8NxiPcR1K74p3Hy+LGLm
        rX9LE2j1zLzU+lgJuk79BMiyoEwc6OvkwtA==
X-Received: by 2002:a9d:7d0e:: with SMTP id v14mr3100202otn.197.1588260858121;
        Thu, 30 Apr 2020 08:34:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypLL2yY8ZcUys6bQQPOZ3IF5gx7gpLrQG2zNNp5teHJ7MAeNc1zt/ZCAXxIIrbHtT31TD7U6SMTwTr1CzKSYhho=
X-Received: by 2002:a9d:7d0e:: with SMTP id v14mr3100182otn.197.1588260857776;
 Thu, 30 Apr 2020 08:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200327152107.95915-1-omosnace@redhat.com> <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
 <7549b0e2-f845-1c3a-d9d5-314cb2b9225f@ieee.org> <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
 <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com>
 <121c1c0d-da7b-681a-ae6e-121228a046af@ieee.org> <CAFqZXNuYPWWwcMeerzH1ZNzJPifuiNEE5im1JNgzZQLTmx9pAw@mail.gmail.com>
 <b36f82d5-d502-edfe-cde5-eb1e4bf76641@ieee.org>
In-Reply-To: <b36f82d5-d502-edfe-cde5-eb1e4bf76641@ieee.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 Apr 2020 17:34:05 +0200
Message-ID: <CAFqZXNs778bhs91sFyNmXNctxzOvsYOcLNoBCXs3g4drf0U4mA@mail.gmail.com>
Subject: Re: [PATCH 0/2] userspace: Implement new format of filename trans rules
To:     Chris PeBenito <pebenito@ieee.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        James Carter <jwcart2@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 5:20 PM Chris PeBenito <pebenito@ieee.org> wrote:
> On 4/30/20 10:34 AM, Ondrej Mosnacek wrote:
> > On Thu, Apr 30, 2020 at 4:24 PM Chris PeBenito <pebenito@ieee.org> wrote:
> >> On 4/30/20 9:22 AM, Stephen Smalley wrote:
> >>> On Wed, Apr 29, 2020 at 3:01 PM James Carter <jwcart2@gmail.com> wrote:
> >>>> I think the fact that the CIL, kernel to CIL, kernel to conf, and
> >>>> module to CIL code is all in libsepol speaks to the fact of how
> >>>> tightly integrated they are to the rest of libsepol. One argument that
> >>>> could be made is that the policyrep stuff in setools really belongs in
> >>>> libsepol.
> >>>>
> >>>> Thinking about how libsepol could be encapsulated leads me to a couple
> >>>> of possibilities. One way would be functions that could return lists
> >>>> of rules. The policy module code gives us avrule_t, role_trans_rule_t,
> >>>> role_allow_t, filename_trans_rule_t, range_trans_rule_t, and others.
> >>>> Those structures are probably unlikely to change and, at least in this
> >>>> case, creating a function that walks the filename_trans hashtable and
> >>>> returns a list of filename_trans_rule_t certainly seems like it
> >>>> wouldn't be too hard. Another possible way to encapsulate would be
> >>>> create a way to walk the various hashtables element by element (I
> >>>> think hashtab_map() requires too much knowledge of the internal
> >>>> structures), returning an opaque structure to track where you are in
> >>>> the hashtable and functions that allow you to get each part of the
> >>>> rule being stored. There are other ways that it could be done, but I
> >>>> could rewrite kernel to and module to stuff with either of those. CIL
> >>>> itself would require some functions to insert rules into the policydb
> >>>> which probably wouldn't be too hard. None of this would be too hard,
> >>>> but it would take some time. The real question is would it really be
> >>>> valuable?
> >>>
> >>> I don't think we want to directly expose the existing data structures
> >>> from include/sepol/policydb/*.h (or at least not without a careful
> >>> audit) since those are often tightly coupled to policy compiler
> >>> internals and/or the kernel or module policy formats. Creating an
> >>> abstraction for each with a proper API in new definitions in
> >>> include/sepol/*.h would be preferable albeit more work. There was a
> >>> proposal a long time ago from the setools developers to create an
> >>> iterator interface and accessor functions for each data type, see
> >>> https://lore.kernel.org/selinux/200603212246.k2LMkRNq028071@gotham.columbia.tresys.com/.
> >>
> >> I agree.  The hardest thing with writing the policyrep in setools was stuff like
> >> the value_to_datum indirections, type_attr_map, etc. and knowing when to use
> >> value vs value-1.  An API that has a new set of structs would be ideal.
> >>
> >> Unfortunately, since setools policyrep is now written in Cython, we can't simply
> >> move the code over to libsepol.  My guess is dispol has the most useful building
> >> blocks for making a new API.
> >
> > Since you mention dispol... I also had the idea that setools could
> > just use the existing public interface to convert the whole policydb
> > to CIL and simply parse that as a string (this should be pretty
> > straightforward even in pure Python). However, based on my experiments
> > this would likely make setools a lot slower...
>
> This is an interesting idea.  I'm not familiar with the CIL API; secilc.c looks
> like it uses public API.  Can I use the existing CIL library functions to parse
> it, or does the resultant db lack public accessor functions?

What I had in mind was actually to just use
sepol_kernel_policydb_to_cil() to dump the textual CIL into a
temporary file (maybe using tmpfile(3)), and then parse the contents
in Python. The CIL format is really easy to parse (especially in
Python) so a lack of existing functions for that wouldn't be much of
an issue. Yes, this would be a little dirty, but you'd avoid the
trouble of maintaining a stable binary interface between libsepol and
setools.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

