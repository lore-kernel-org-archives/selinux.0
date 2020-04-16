Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB8DC2BB85
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 09:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD90821D7A
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 09:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE8cJPMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504259AbgDPJvj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:51:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24355 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2504220AbgDPJvf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 05:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587030694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnHfCAUNinSq34WXVXmIlIAejvHDdPnWm0xbq9pJpy8=;
        b=LE8cJPMw9JRRQN2VdF28Sk6A0KY7d+X++HFusqqCPVfc2tjr/36HW/stQjbYpXFq4PwTRD
        zK7kjy/vBHrvvzKIkWlG6RY4dHnJMx7/nydLBTcZtk5TGKkyPf+t4BQKslhZHbVOgohljU
        08WUyGtxDc0W4OYRr5iyNdIE7o1eNfk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-YHiZl_oRPlq7sMQQhJtQmg-1; Thu, 16 Apr 2020 05:51:32 -0400
X-MC-Unique: YHiZl_oRPlq7sMQQhJtQmg-1
Received: by mail-oi1-f197.google.com with SMTP id w7so10312268oic.12
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 02:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnHfCAUNinSq34WXVXmIlIAejvHDdPnWm0xbq9pJpy8=;
        b=BIqS9Xr/dMccPNSgkyF5dATgIwnfTooALrhFbpJp7wRKT9la0HeIsJo1aEqlzFA5cX
         kLoz81McBOHnasSURKbLkO4Xmvg7YlYUilDGf/lh2ANGk/tp1MKHHt1orrKZVCSRyMpG
         iexCilhR3CLNzcnIhtWy5ZjNZwh8tG+FaLiqsXQqXGPlOGI/Qlpb7xHZ1vaAYZ0oLya6
         cFTLcSQYs7qeohXlaKWuEIazSmagIgMsvtndMWwl3pK1F/vDCfH8EPN4tBgkGYo/XzTN
         28B1LsuNH84aQJS/G6P0L4HcAKMz0n+wcuxGrbvcTTCmwtNM/UrgGup9vi+nBZTqgmqN
         8V/g==
X-Gm-Message-State: AGi0Pua2k3WsFkDdP4+dL68rQTCrnKDM9vrZiFweMne59/IzlzsJLkdN
        kOhH22TXYq6ydg+7gv70RP+9hnZ/1LiIbL5qwVXfMrg3k8VSAZtD52fxZNdiW+JBJHy/uzrb2g/
        1J5HA0CIQL8mgl3G0VqdFqLnEDQb82zfC2Q==
X-Received: by 2002:a9d:69d5:: with SMTP id v21mr26459401oto.197.1587030691123;
        Thu, 16 Apr 2020 02:51:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypIIHL7AjayKOCpLtgIaWwzx2ku1GdHow+pf9r4rYSgRYpLz3u1uLKiWs6KMkQtx+7imVbg6kq9PWU/eSiRYBvo=
X-Received: by 2002:a9d:69d5:: with SMTP id v21mr26459390oto.197.1587030690825;
 Thu, 16 Apr 2020 02:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200407182858.1149087-1-omosnace@redhat.com> <CAHC9VhQu0B8KwBLP+qD9JvtyFJS-X3ANThp8EytG4R0scyzoCA@mail.gmail.com>
In-Reply-To: <CAHC9VhQu0B8KwBLP+qD9JvtyFJS-X3ANThp8EytG4R0scyzoCA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Apr 2020 11:51:19 +0200
Message-ID: <CAFqZXNtcvX2TkBkicaddk07HUQS37vTdbupOgK=3EXw5pP78SQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: store role transitions in a hash table
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 3:41 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Apr 7, 2020 at 2:29 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Currently, they are stored in a linked list, which adds significant
> > overhead to security_transition_sid(). On Fedora, with 428 role
> > transitions in policy, converting this list to a hash table cuts down
> > its run time by about 50%. This was measured by running 'stress-ng --msg
> > 1 --msg-ops 100000' under perf with and without this patch.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > v2:
> >  - fix typo scontext->tcontext in security_compute_sid()
> >  - suggest a better command for testing in the commit msg
> >
> >  security/selinux/ss/policydb.c | 138 ++++++++++++++++++++++-----------
> >  security/selinux/ss/policydb.h |   8 +-
> >  security/selinux/ss/services.c |  21 +++--
> >  3 files changed, 107 insertions(+), 60 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 70ecdc78efbd..4f0cfffd008d 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -458,6 +465,30 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
> >         return v;
> >  }
> >
> > +static u32 role_trans_hash(struct hashtab *h, const void *k)
> > +{
> > +       const struct role_trans_key *key = k;
> > +
> > +       return (key->role + (key->type << 3) + (key->tclass << 5)) &
> > +               (h->size - 1);
> > +}
> > +
> > +static int role_trans_cmp(struct hashtab *h, const void *k1, const void *k2)
> > +{
> > +       const struct role_trans_key *key1 = k1, *key2 = k2;
> > +       int v;
> > +
> > +       v = key1->role - key2->role;
> > +       if (v)
> > +               return v;
> > +
> > +       v = key1->type - key2->type;
> > +       if (v)
> > +               return v;
> > +
> > +       return key1->tclass - key2->tclass;
>
> Why just a simple boolean statement?
>
>   return key1->role != key2->role || \
>          key1->type != key2->type || \
>          key1->tclass != key2->tclass;

Because hashtab sorts the entries in each bucket, so it needs a proper
sort function. Other such functions (rangetr_cmp(), filenametr_cmp())
do a similar thing.


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

