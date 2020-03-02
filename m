Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972FBC3F2D1
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E15321556
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 15:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A93w34uX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgCBPqR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:46:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46739 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbgCBPqQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 10:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583163975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzWPgMqYxqkAznlrtKOlrqrt1C9KlltvESYFHwQuQLY=;
        b=A93w34uXAt4kRMWAJkLfBxxlOAolwWwdY0CkRJwP0lGwmxofIydB5NUYCtmLE9Htj6tuXU
        UBeSN7GsnUPdyj2EwOUocPu2WKvjNeTNxD+MFK+dANElkghnUjZJTjNXCZQsT/aQPb9as7
        lUUGwMt2fNDnZDqtmYBGL/xDGxO/8C4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-mWTQGKONNE2osw5AHiPVGg-1; Mon, 02 Mar 2020 10:46:12 -0500
X-MC-Unique: mWTQGKONNE2osw5AHiPVGg-1
Received: by mail-ot1-f69.google.com with SMTP id s22so129188otr.20
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 07:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzWPgMqYxqkAznlrtKOlrqrt1C9KlltvESYFHwQuQLY=;
        b=gj/oEwjq5mEhx3BdkH0BW5uVEKEawyAAv8HSZFOZAS0+IPzMC/M6UsQv+npb4F5VEU
         G3WvF6LrFsaA8bJg0qMsECldSGHZ8w5KHtJUUEa8Sj/iZ5H90e9VFjw24o9+q+WHse/H
         as7yNIGDXVe9AKH9POiFLXfkKihzQHuSIX24RA0MoEOxjHrFJszLlRgaaexZItl0oc91
         SugN3jkJfsi/ythQnjAp6KKzuq+bP5Ndi2oQ8Q3KrHcFPpILDwzT47If3ruU2F4/DjvX
         qM4ahSusJPrid/h9mhrnjn9Km/XPLdYDBwFXzfL7oQoasWmLEvRo5xUEiNC5ITk71IAy
         lVDA==
X-Gm-Message-State: APjAAAXlZMEeXQWuqsIkqQ2MYExq33uMROdxlrOLTUW7BCzKUPU178Ub
        mjfHwgN642cN3DTNlcvfi+x0qmMp6pMAb9wYihnsSvgNVRFP4KKNXZYJi+Edj6YEreM7wSz/kxx
        j3qJvfMO7xC5sEa8B2PmmEFWG212ANtQlUg==
X-Received: by 2002:a05:6830:1081:: with SMTP id y1mr13139568oto.367.1583163971404;
        Mon, 02 Mar 2020 07:46:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5xHt3WXuBafnOpRHafOLcJ71oGvTMqJGNaPPzuxNjk6JLezkOxJ90YTq9wo1dXxHzQ+jpOTwFeo07nnXeu40=
X-Received: by 2002:a05:6830:1081:: with SMTP id y1mr13139554oto.367.1583163971044;
 Mon, 02 Mar 2020 07:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
 <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com> <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 2 Mar 2020 16:46:00 +0100
Message-ID: <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 3:57 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Mar 2, 2020 at 9:50 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Feb 28, 2020 at 1:08 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > This series contains two small changes (these don't seem to affect
> > > > performance measurably, but are nonetheless logical) and a patch that
> > > > changes how the policy optimization "type_map" helper structure is
> > > > represented, which speeds up the whole process.
> > > >
> > > > Ondrej Mosnacek (3):
> > > >   libsepol: skip unnecessary check in build_type_map()
> > > >   libsepol: optimize inner loop in build_type_map()
> > > >   libsepol: speed up policy optimization
> > >
> > > Not a comment on the patches themselves, but this made me wonder if
> > > the optimization support is actually tested by our travis
> > > configuration.
> > > Doesn't appear to be (e.g. no usage of -O/--optimize or semanage.conf
> > > with optimize-policy true).

Yeah, there is currently no test for this. I have something hackish
that I used locally - I'll try to convert it to something more usable
an automated and integrate it into the repo.

> >
> > Adding optimize-policy = true to /etc/selinux/semanage.conf and
> > running semodule -BN before and after these patches yields different
> > binary kernel policy files (policy.32).
> > Is that expected?
>
> Here is one example difference between the policies, along with what
> was present in the original unoptimized policy:
> $ sesearch -A -s guest_t -t guest_t -c context -p contains policy.32.unoptimized
> allow guest_t guest_t:context contains;
> allow guest_usertype guest_usertype:context contains;
>
> $ sesearch -A -s guest_t -t guest_t -c context -p contains
> policy.32.optimizedbefore
> allow guest_t guest_t:context contains;
>
> $ sesearch -A -s guest_t -t guest_t -c context -p contains
> policy.32.optimizedafter
> allow guest_usertype guest_usertype:context contains;
>
> Seems like the code prior to these changes yielded a more optimal
> policy since guest_usertype only has a single type in it.

Hm... this is probably a consequence of the second patch. Types are no
longer considered a superset of an attribute containing a single type,
so the single-type rule gets removed instead of the attribute one...
But even before it picked the first rule only by chance (it was first
in order). I would say that picking a single-type rule over an
attribute rule in this case is outside of the scope of the algorithm.
Shouldn't the compiler automatically expand each attribute that has
less than 5 types in it? I recall seeing something in the code that
did this. I think this was in the CIL part of libsepol, so maybe it
applies only when compiling from CIL?

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

