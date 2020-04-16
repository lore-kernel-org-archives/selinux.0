Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E327BC2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF15B21D7E
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4Yf9OHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408796AbgDPPPr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:15:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58238 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408874AbgDPPPo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587050142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+wnmDmQpJmJIUpO0XeelrjPDn9N3wQxkngKISiFx+R4=;
        b=L4Yf9OHibGAdocXCS6Z1s/Bjp37ph6sy87oz/ZHEAdMbig281Dr7taqmY3wJaZBvMPUoJr
        f228S3ZIooIbdHVcpKQ7/aEGG9ZAnSrTPgPdt8sEmTHbV04v4Aya0yq07ZecOLAh/cSZh3
        Pnw4sS9mLAG9EvV3dxAjob5aX2L/WqY=
Received: from mail-oo1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-vZ-dt7_jM6eLAoyJ77DyGA-1; Thu, 16 Apr 2020 11:15:41 -0400
X-MC-Unique: vZ-dt7_jM6eLAoyJ77DyGA-1
Received: by mail-oo1-f71.google.com with SMTP id i6so94600oof.21
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wnmDmQpJmJIUpO0XeelrjPDn9N3wQxkngKISiFx+R4=;
        b=G3hpJlRSf//uYdDbRbzXreg5smRy5v1dY/fay66RdxrZX/a7xy9T80naeznahdrMQy
         Hzyjr9GGrQRvk29AQOFAj895Nhi4jI0jV/aUIzDDuEtK2/LSmMRGqD+6sCHDpBFPbqFC
         Bn3lWnHUvQyM2m8wXD84l/9ZB7HyX0gBVctxnaX47rQcpcVmJ6sAfBZV/i1S9ELH9CRo
         o3/VC8QOGz/FgQO3aXyO22xQo+1F09rQ4QxaXKtG6G4BwgqsaRzpogDUHNfOEdt8VH5q
         LFnIgKlVN1wkGltxtiLN/uQRTvd03yfr1PRlNxzePS7qVyUDIKhC0pwVC3TXOsKtR3QE
         iZNg==
X-Gm-Message-State: AGi0Pub2v2bkgiGmKvupQK+B8SFQAth82nxPThb6TuP8VFUHTAajklnh
        sDVDoa/5VPB2F9SlPfPACMRgI8iUaW9KadFJik6VbNWUBS1J9ScjUt24ghdX2B/eON7mBjzcUL6
        31DNAuIH09pbalxy9sQidaSLiT8BXRsUlRQ==
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr13309175otb.367.1587050140075;
        Thu, 16 Apr 2020 08:15:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypJvSznS+Tm0VWhXbLGx1yKfZk544fbC9Wk8u8iWy3bhoxbSc/Tpb9iCW+FJ5tuNn1sRGOYGa/SL7WzFVcAAUVw=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr13309146otb.367.1587050139696;
 Thu, 16 Apr 2020 08:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200416124110.541408-1-omosnace@redhat.com> <20200416124110.541408-2-omosnace@redhat.com>
 <CABXk95BhDRd2nDHR4e7Nj3xtF+1RJ-K7jE4N12ciLjZBLywSbQ@mail.gmail.com>
In-Reply-To: <CABXk95BhDRd2nDHR4e7Nj3xtF+1RJ-K7jE4N12ciLjZBLywSbQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Apr 2020 17:15:28 +0200
Message-ID: <CAFqZXNuHNNXXZy+E2WbB7dWGDc0GmL7tHFMT7cfhfKymoEyi9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: hash context structure directly
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 4:22 PM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> Thanks for fixing this!
>
> On Thu, Apr 16, 2020 at 2:41 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Always hashing the string representation is inefficient. Just hash the
> > contents of the structure directly (using jhash). If the context is
> > invalid (str & len are set), then hash the string as before, otherwise
> > hash the structured data. Any context that is valid under the given
> > policy should always be structured, and also any context that is invalid
> > should be never structured, so the hashes should always match for the
> > same context. The fact that context_cmp() also follows this logic
> > further reinforces this assumption.
> >
> > Since the context hashing function is now faster (about 10 times), this
> > patch decreases the overhead of security_transition_sid(), which is
> > called from many hooks.
> >
> > The jhash function seemed as a good choice, since it is used as the
> > default hashing algorithm in rhashtable.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/Makefile      |  2 +-
> >  security/selinux/ss/context.c  | 24 +++++++++++++++++++++++
> >  security/selinux/ss/context.h  |  6 ++++--
> >  security/selinux/ss/ebitmap.c  | 14 ++++++++++++++
> >  security/selinux/ss/ebitmap.h  |  1 +
> >  security/selinux/ss/mls.h      | 11 +++++++++++
> >  security/selinux/ss/policydb.c |  7 ++-----
> >  security/selinux/ss/services.c | 35 ++++------------------------------
> >  security/selinux/ss/services.h |  3 ---
> >  9 files changed, 61 insertions(+), 42 deletions(-)
> >  create mode 100644 security/selinux/ss/context.c
> >
> > diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> > index 0c77ede1cc11..4d8e0e8adf0b 100644
> > --- a/security/selinux/Makefile
> > +++ b/security/selinux/Makefile
> > @@ -8,7 +8,7 @@ obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
> >  selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
> >              netnode.o netport.o status.o \
> >              ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
> > -            ss/policydb.o ss/services.o ss/conditional.o ss/mls.o
> > +            ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
> >
> >  selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
> >
> > diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
> > new file mode 100644
> > index 000000000000..cc0895dc7b0f
> > --- /dev/null
> > +++ b/security/selinux/ss/context.c
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Implementations of the security context functions.
> > + *
> > + * Author: Ondrej Mosnacek <omosnacek@gmail.com>
> > + * Copyright (C) 2018 Red Hat, Inc.
> > + */
> > +
> > +#include <linux/jhash.h>
> > +
> > +#include "context.h"
> > +#include "mls.h"
> > +
> > +u32 context_compute_hash(const struct context *c)
> > +{
> > +       u32 hash = 0;
> > +
>
> You describe why this is safe in the commit message.
> Could that same explanation be a comment here?
> Otherwise it's not clear when reading the code why
> this is safe.

I assume you mean the fact that valid and invalid contexts are hashed
differently? In that case, yes I agree it deserves a comment.

> > +       if (c->len)
> > +               return full_name_hash(NULL, c->str, c->len);
> > +
> > +       hash = jhash_3words(c->user, c->role, c->type, hash);
> > +       hash = mls_range_hash(&c->range, hash);
> > +       return hash;
> > +}

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

