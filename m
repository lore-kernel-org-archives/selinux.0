Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C9EC83000
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319D42072A
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 14:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtX6D7la"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgD3Oem (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:34:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbgD3Oem (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 10:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588257280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4FzFJPQewlN1GIxcegUTwNVsoY+q/eCw2jPwIfhDYM=;
        b=HtX6D7lam6HHDfDh6+h4qG1H5GdQ0f8gq+9FqfBvzkdUnfN8exj/DG/MWN+YBu9WHFljpf
        jV+7RZKt8v+zC5AWY5n7F3/4doYOEuDYcO/HfJZri3TzUZ0L931he3ciU0ckXBsBLDnj+M
        axT9k3Pk32WBx+7Mqno0tBE/J7O+n4o=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-3VlvR67mMSKxD2BFhPi_8g-1; Thu, 30 Apr 2020 10:34:37 -0400
X-MC-Unique: 3VlvR67mMSKxD2BFhPi_8g-1
Received: by mail-oi1-f198.google.com with SMTP id z6so3988772oix.16
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 07:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4FzFJPQewlN1GIxcegUTwNVsoY+q/eCw2jPwIfhDYM=;
        b=WyjroJ2FxvPl2qAFhE1T3+9GmfTmgTeB0vPjZ7nhyuUgP4BJwD5mL6EdJXVfyCjyPo
         45WuV2FyEpwj6UsVCZVWgNDgSKV3Ogn+m4KOa1SBq3hi7f8QAjrPUXwOWJkMvNot3W8Z
         fcToYHq+dX+181TpViU0kukts1SeGflGHCFsYpmoD48U0I+r091Ki+OmmL9JkVT4XMnq
         fb8kQMGVTY/IAkvYfRR2qkXwVgSV3SeECM/G9KtWarFvGkWgtcrT9G7P/jcN3NfdGdsj
         +Fa2G2N4ZIBc04cNdSDm6mDZEULR6zMpWWmOwTGDdNFb1Jd31wh9E55m3n2oZgo3h8WP
         IVeA==
X-Gm-Message-State: AGi0PuYu0jSLN3h1BKlqP5ERCQf/l60XjJ+mskT17vyvybPM/wn4WZxO
        CYHRxLrlSc5gmgsYIGoRd29NhlCBvCThDd/igxcf9HFYJrnNqK0XOrW1tBSgAXXr6Z9z1LGIJx2
        Gw2bAn9AYcaQk6P9DC5BGgDXdwkNpr03TAg==
X-Received: by 2002:a9d:7d0e:: with SMTP id v14mr2849486otn.197.1588257273332;
        Thu, 30 Apr 2020 07:34:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypLT6fTGj4z5hxGOB/bSWRMDTuB2Pj4lA4jnUe5OOZzN2teSngOPwj7AJiXqAbyhu+BcMcuFaeQZQ+kXiZzIRgk=
X-Received: by 2002:a9d:7d0e:: with SMTP id v14mr2849453otn.197.1588257272937;
 Thu, 30 Apr 2020 07:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200327152107.95915-1-omosnace@redhat.com> <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
 <7549b0e2-f845-1c3a-d9d5-314cb2b9225f@ieee.org> <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
 <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com> <121c1c0d-da7b-681a-ae6e-121228a046af@ieee.org>
In-Reply-To: <121c1c0d-da7b-681a-ae6e-121228a046af@ieee.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 Apr 2020 16:34:21 +0200
Message-ID: <CAFqZXNuYPWWwcMeerzH1ZNzJPifuiNEE5im1JNgzZQLTmx9pAw@mail.gmail.com>
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

On Thu, Apr 30, 2020 at 4:24 PM Chris PeBenito <pebenito@ieee.org> wrote:
> On 4/30/20 9:22 AM, Stephen Smalley wrote:
> > On Wed, Apr 29, 2020 at 3:01 PM James Carter <jwcart2@gmail.com> wrote:
> >> I think the fact that the CIL, kernel to CIL, kernel to conf, and
> >> module to CIL code is all in libsepol speaks to the fact of how
> >> tightly integrated they are to the rest of libsepol. One argument that
> >> could be made is that the policyrep stuff in setools really belongs in
> >> libsepol.
> >>
> >> Thinking about how libsepol could be encapsulated leads me to a couple
> >> of possibilities. One way would be functions that could return lists
> >> of rules. The policy module code gives us avrule_t, role_trans_rule_t,
> >> role_allow_t, filename_trans_rule_t, range_trans_rule_t, and others.
> >> Those structures are probably unlikely to change and, at least in this
> >> case, creating a function that walks the filename_trans hashtable and
> >> returns a list of filename_trans_rule_t certainly seems like it
> >> wouldn't be too hard. Another possible way to encapsulate would be
> >> create a way to walk the various hashtables element by element (I
> >> think hashtab_map() requires too much knowledge of the internal
> >> structures), returning an opaque structure to track where you are in
> >> the hashtable and functions that allow you to get each part of the
> >> rule being stored. There are other ways that it could be done, but I
> >> could rewrite kernel to and module to stuff with either of those. CIL
> >> itself would require some functions to insert rules into the policydb
> >> which probably wouldn't be too hard. None of this would be too hard,
> >> but it would take some time. The real question is would it really be
> >> valuable?
> >
> > I don't think we want to directly expose the existing data structures
> > from include/sepol/policydb/*.h (or at least not without a careful
> > audit) since those are often tightly coupled to policy compiler
> > internals and/or the kernel or module policy formats. Creating an
> > abstraction for each with a proper API in new definitions in
> > include/sepol/*.h would be preferable albeit more work. There was a
> > proposal a long time ago from the setools developers to create an
> > iterator interface and accessor functions for each data type, see
> > https://lore.kernel.org/selinux/200603212246.k2LMkRNq028071@gotham.columbia.tresys.com/.
>
> I agree.  The hardest thing with writing the policyrep in setools was stuff like
> the value_to_datum indirections, type_attr_map, etc. and knowing when to use
> value vs value-1.  An API that has a new set of structs would be ideal.
>
> Unfortunately, since setools policyrep is now written in Cython, we can't simply
> move the code over to libsepol.  My guess is dispol has the most useful building
> blocks for making a new API.

Since you mention dispol... I also had the idea that setools could
just use the existing public interface to convert the whole policydb
to CIL and simply parse that as a string (this should be pretty
straightforward even in pure Python). However, based on my experiments
this would likely make setools a lot slower...

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

