Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE27C3F2CD
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 21:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E99921556
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 21:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+g/BF7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCBVIr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:08:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30823 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725781AbgCBVIr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 16:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583183325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qVR4mq27Ps+ACWwtSzdx3ASIq+LQ786tVWudikjaP9s=;
        b=F+g/BF7uUvR00FYWHB54ytQa3cpq0oSP+vHY2fO1xYt+wWM0+mAy1NyeeALAybv2iALImL
        YMMn8RMWC6hEsVuuF9XmrSarZSeG9N2B6nsNLzD3dnhspWCc1hA9pVtHHqEiqMf0pqFo0s
        jMdpbWPDLjgLBx9Mb833Imo2GK6cBg4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-ZgsHGvi2MnqNpCsUBiDCAQ-1; Mon, 02 Mar 2020 16:08:44 -0500
X-MC-Unique: ZgsHGvi2MnqNpCsUBiDCAQ-1
Received: by mail-oi1-f199.google.com with SMTP id u129so601425oia.10
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 13:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVR4mq27Ps+ACWwtSzdx3ASIq+LQ786tVWudikjaP9s=;
        b=G/oZ+NMVDZ6LGOGWa8xr/EKNNGPIMYEZ0F43OcmI90xDz6iuYAJNTQQOREaPGwzpWI
         Cj90f3cjFvptU2NdasPJdcNwlIzVFTIuUfWRv43uZrLRgFpMUpVlOZKwG4yGQFNOxfE8
         Yy+xXT/IZNtC5/Qju02vFU7IWRYV6uG/XpUdLuqUhXJ3wYEGjdbZ+gm1Qqn+D/OIrU/R
         uzXi6QKkcfYc9diaXQzfsORIUG3P0fpJaCDHsCupgqk68aCZsIgx3hX69Sv8RIZCvAJ1
         KSxzN0JdyEKU0QISZdsLpr74PWqJsUPH4JWcb+4qCZ3t4m7VpnK71KpTytSYqv8WgBvp
         NueA==
X-Gm-Message-State: ANhLgQ0ncMZyNStXLSFTxCN/exxD2MIzK7KPxTKI5DPQ0pL8YVZiLIE9
        Z1AgR5w9ybBdly6wkGA6Zd4E1TQbLrH3gf6QQtvBFJUf7p8rbq+kCoaHSjQl125hDX0sFacJQRX
        ztvq67rzsSp6iAG1nvw7GlBui+HI1l8FGzg==
X-Received: by 2002:a05:6830:1098:: with SMTP id y24mr868608oto.197.1583183323134;
        Mon, 02 Mar 2020 13:08:43 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvrFYX2N4kxA5wI31BCCxNwxVRVCmSJhNjHBW9cHZSzurw/plYie9vRutF1Lizbet4utOLeZoJmuAhmL6fWL2c=
X-Received: by 2002:a05:6830:1098:: with SMTP id y24mr868580oto.197.1583183322818;
 Mon, 02 Mar 2020 13:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
 <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
 <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com>
 <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com>
 <CAEjxPJ66CZL6-+KbRKwicYuj50uvcTjr-O81LC+BhQGO-jaKew@mail.gmail.com> <CAEjxPJ5VMy5aRX_2_OB_4gwDmKAve+TMu-BJeSmqsWmM-PxRCg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5VMy5aRX_2_OB_4gwDmKAve+TMu-BJeSmqsWmM-PxRCg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 2 Mar 2020 22:08:31 +0100
Message-ID: <CAFqZXNub7i2OyqWqU2snePw+XBfJxauh-0n2zgZy_q58sZovSw@mail.gmail.com>
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

On Mon, Mar 2, 2020 at 9:22 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Mar 2, 2020 at 1:45 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Mar 2, 2020 at 10:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > Hm... this is probably a consequence of the second patch. Types are no
> > > longer considered a superset of an attribute containing a single type,
> > > so the single-type rule gets removed instead of the attribute one...
> > > But even before it picked the first rule only by chance (it was first
> > > in order). I would say that picking a single-type rule over an
> > > attribute rule in this case is outside of the scope of the algorithm.
> > > Shouldn't the compiler automatically expand each attribute that has
> > > less than 5 types in it? I recall seeing something in the code that
> > > did this. I think this was in the CIL part of libsepol, so maybe it
> > > applies only when compiling from CIL?
> >
> > secilc has -G and -X options for controlling expansion of attributes, but
> > there aren't equivalent settings in semanage.conf to control when
> > building modular policies.
> > Internally it all uses the libsepol CIL support so it ought to be fixable.
> > Looks like the default is 1 in cil_db_init() so it only happens when
> > the attribute has no types by default?

Okay, I don't know where I got the "5" boundary from... maybe my brain
just made it up.

>
> Apparently that was to eliminate attributes that have no types at all.
> Seems like we could add new options to semanage.conf to provide equivalents
> to secilc -G and -X, and have semanage_direct_commit() call
> cil_set_attrs_expand_generated()
> and cil_set_attrs_expand_size() in the same manner as secilc does based on those
> semanage.conf settings.
>
> Could also look at increasing the default size to 5 or something and
> see what impact that has on
> Fedora policies.

Well, for a start we could increase the default to 2, which should
only remove those attributes that have only one type. That has
practically no downsides (other than making it a bit harder to trace
the rule back to source policy) and would be just enough to make the
optimization work nicely.

I wouldn't change the default to higher values than that for now,
since such values already trade off policy size increase for rule
lookup performance, which is more of a gray area.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

