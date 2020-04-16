Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CFEC2BB85
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 09:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7B72063A
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 09:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOBiBgO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504090AbgDPJum (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:50:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50777 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503627AbgDPJuj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 05:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587030636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHMqy1+sD3TFhCKrzNBpTaeB98djPlJCNL87smhr6Bo=;
        b=VOBiBgO5KvMRxB5uy6f0qBuTl1xyxN/CzOv/6mPTBcsAbW7SAVOdVlxCUW63HezNRzxYaa
        xopuAb3OE6ySP5tVIfW50FUy72FL7IwxyYIq1VjYQ7PeoW5gM34+bWQTaR4xlTcVtVr32S
        EvF8sEt3ZlSG7lSI/zc7quebeEmdO/Q=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-C6H703H_MKmHB6zcpeeqzQ-1; Thu, 16 Apr 2020 05:50:35 -0400
X-MC-Unique: C6H703H_MKmHB6zcpeeqzQ-1
Received: by mail-ot1-f70.google.com with SMTP id n3so2790483otk.22
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 02:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHMqy1+sD3TFhCKrzNBpTaeB98djPlJCNL87smhr6Bo=;
        b=MuXPaw9w480hHzYiZY2kna8Tutv2+YM9kO3r8WpBYXHMpVNi8EB+Ge4/6Y0tdEEYe4
         syE0FpCf3OFPoZ42srmZYP1jYbVMps8iyet2WdHYv5n+4O3YF4zFpMAkyERNfP+gQtKD
         88tGqEmtAaylMsHaWQtybXN14XSXz81KQzIm9KiWZeIvKdHe24lyznp3+Q2E3pmoUS2p
         qHbAs4szx2Im7W+oPAyy2t1Lgs6M707xuuAaZ+kkOOzQH6Otowgjqxg17zN+mLMcoHt5
         GhagQqrIFa8PdDb/8lOwNCKT5OTiG23DNo+9A+ALpwBsctkyYUw4RFAS7ZfJYMBpjbxd
         Q00g==
X-Gm-Message-State: AGi0Pua7du/rsshbCFBMuB68/uOrIe9yDF/yg+FKg6bqeucnBkyWRC09
        A2gMUSSym/uVTet/c16aYqg/YqwhDqAwtMB18ZKjbXy+xIDcrA7nnK3s16I4OJ+h7xEDpFL+NBQ
        sJu2kREe3/BrpNZkXZ/gc2fR/JA3j27KfrQ==
X-Received: by 2002:aca:488a:: with SMTP id v132mr2390217oia.166.1587030633977;
        Thu, 16 Apr 2020 02:50:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypKYdEmwl8W1zpXqAJFwOlAxbvslyIV/cW8kfp/xAKUA963mUq+/qLW36n6sax6oECJVXqcYbU5XLpW3B1rRd1M=
X-Received: by 2002:aca:488a:: with SMTP id v132mr2390206oia.166.1587030633516;
 Thu, 16 Apr 2020 02:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200409081248.1273383-1-omosnace@redhat.com> <20200409081248.1273383-2-omosnace@redhat.com>
 <CAHC9VhTGJ7kxjzaL5eiJ7g42qjgDeLPUowTrzvpkUJupNWkNpA@mail.gmail.com>
In-Reply-To: <CAHC9VhTGJ7kxjzaL5eiJ7g42qjgDeLPUowTrzvpkUJupNWkNpA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Apr 2020 11:50:22 +0200
Message-ID: <CAFqZXNu6AnC7wrDV9a2kF1zjqxAB9vZyaUcrNw80BQqnOD8tAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: hash context structure directly
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 2:56 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Apr 9, 2020 at 4:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
> >  security/selinux/ss/context.c  | 28 ++++++++++++
> >  security/selinux/ss/context.h  |  6 ++-
> >  security/selinux/ss/ebitmap.c  | 14 ++++++
> >  security/selinux/ss/ebitmap.h  |  1 +
> >  security/selinux/ss/policydb.c |  7 +--
> >  security/selinux/ss/services.c | 80 ++++++++++++++--------------------
> >  security/selinux/ss/services.h |  3 --
> >  8 files changed, 82 insertions(+), 59 deletions(-)
> >  create mode 100644 security/selinux/ss/context.c
>
> ...
>
> > diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
> > new file mode 100644
> > index 000000000000..7ca32683056d
> > --- /dev/null
> > +++ b/security/selinux/ss/context.c
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Implementations of the security context functions.
> > + *
> > + * Author: Ondrej Mosnacek <omosnacek@gmail.com>
> > + * Copyright (C) 2018 Red Hat, Inc.
>
> I think your clock is a bit off ... ;)
>
> Joking aside, copyright dates are important so please fix this (also
> because it is a copyright related issue, it isn't something I want to
> fix during the merge).

Ah, I copy-pasted the boilerplate from elsewhere and forgot to fix the
year... No problem, I'll send a fixed patch.

>
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
> > +       if (c->len)
> > +               return full_name_hash(NULL, c->str, c->len);
> > +
> > +       hash = jhash_3words(c->user, c->role, c->type, hash);
> > +       hash = jhash_2words(c->range.level[0].sens,
> > +                           c->range.level[1].sens, hash);
> > +       hash = ebitmap_hash(&c->range.level[0].cat, hash);
> > +       hash = ebitmap_hash(&c->range.level[1].cat, hash);
>
> Most other places we try to abstract away the mls_range details by
> having an associated mls_XXX(...) function, it seems like that would
> be a good idea here too.  How about adding a mls_context_hash(), or
> similarly named function and calling it here.

Good point... I'm a little wary of adding yet another nested function
call to something that should be fast (and that will do only a few
operations on its own), but I suppose I can just make it an inline
function.

>
> > +       return hash;
> > +}
[...]
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 8ad34fd031d1..2099355e9a7d 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1490,38 +1490,11 @@ out:
> >         return rc;
> >  }
> >
> > -int context_add_hash(struct policydb *policydb,
> > -                    struct context *context)
> > +static int context_struct_to_sid(struct sidtab *sidtab, struct context *context,
> > +                                u32 *sid)
>
> Since you need to respin this patchset anyway, and patch 2/2 deals
> with the move to sidtab, I think it might be better to keep the
> context_struct_to_sid() arguments the same and not swap the first
> argument for the sidtab.  If you keep the first argument as the state
> it makes this patch much more focused on the change at hand and leaves
> patch 2/2 dedicated to just the sidtab move.

Also a good point. I wanted to emphasize that the computation no
longer depends on policydb, but I agree that it adds an unnecessary
churn to this patch. I'll amend it as you suggest.

Thanks,

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

