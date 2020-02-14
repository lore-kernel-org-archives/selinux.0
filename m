Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323BBC2BA83
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 09:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D062086A
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 09:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM7GCbM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgBNJMZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:12:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60462 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728422AbgBNJMZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 04:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581671543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Br3tyzJ+vg1p3glJ+yvMryhKZO9VhGWy8svJqLEWGW8=;
        b=CM7GCbM8kJLfGOK8yCiWlBbm4Voi0KYraFoky7B1A5OFJntdzf3YJ5QvDHfdztVSIgSpjr
        KPDa3JEUOG3Zb2eqNCjmau7eo+UgfsiX/y3UKwHWBOGoDYVvbK7cvAfDsNRg3SdJrK/FTh
        FU8VVtOrd/Z3tEUnILgP+EPPK9XTO5Y=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-dp4VdI4dPyiuojjItCfbgQ-1; Fri, 14 Feb 2020 04:12:16 -0500
X-MC-Unique: dp4VdI4dPyiuojjItCfbgQ-1
Received: by mail-oi1-f200.google.com with SMTP id m7so4275478oim.14
        for <selinux@vger.kernel.org>; Fri, 14 Feb 2020 01:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Br3tyzJ+vg1p3glJ+yvMryhKZO9VhGWy8svJqLEWGW8=;
        b=d6mPmxsFyE5dhL3UI02r3ljmYFY3oxo47dQ788dejXkuJ2UxXqCIU/VISZE0QYEU07
         YY5hlcpuKwf+mGlvuFe/3UIslcyb9ZQLA1SNUNlGEyGXpp51goGRm+XT1iQFYf18eiXt
         sShFgLP9ej2nIilVeQeSJ7qJF2OVc57u/Vm0vcHdiws1w92KgKWsEYjiryXPdPX2RCiJ
         e7jOzvanKakz9W1aKFvT+DLqm6S0GiqcpDWZD3jdRcAO8OpTn6gSQJ7I0dPOyPRy2yoC
         ANSPsGEGmk0oQm7Pc/HPqzg3eIXGae7hVW/NMJ43Z5kQArMfjCopJJgzLRsFqFvfenyN
         FHLg==
X-Gm-Message-State: APjAAAVWWEdWTMGmvE9mEw7tv2fdH4Y1ZToREEzfhxsz3R7+wEOorLTs
        MD3Rq7yCV7QLtrED1CZwktcpAM695zSA+PHWEt1xNewbhhx+kBfHyxoAzQik1+aQ12uR8n1exY1
        4PGlOGdkl1nIUS6dcrsynM6HemUrANH+BIA==
X-Received: by 2002:a9d:6283:: with SMTP id x3mr1378974otk.367.1581671535096;
        Fri, 14 Feb 2020 01:12:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqypHrKLkd+3uOOV6a1VraAIdeZ+/wN0rJjS3E7cEqlqgQOAq9pPvVoQTkA6mQSvznmXq/CwOCLnvESbMV6ggbE=
X-Received: by 2002:a9d:6283:: with SMTP id x3mr1378952otk.367.1581671534643;
 Fri, 14 Feb 2020 01:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20200212112255.105678-1-omosnace@redhat.com> <20200212112255.105678-3-omosnace@redhat.com>
 <CAHC9VhRwqRLNgycuX_MSYE83tFJBiresfiYRcz3RYX9Le+pTSw@mail.gmail.com>
In-Reply-To: <CAHC9VhRwqRLNgycuX_MSYE83tFJBiresfiYRcz3RYX9Le+pTSw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 14 Feb 2020 10:12:03 +0100
Message-ID: <CAFqZXNvkLVDuHZ8XbgEn9JFJ51=QGbAHK4Sbrc5r8mwLURT9Sg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: optimize storage of filename transitions
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 14, 2020 at 1:35 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Feb 12, 2020 at 6:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > In these rules, each rule with the same (target type, target class,
> > filename) values is (in practice) always mapped to the same result type.
> > Therefore, it is much more efficient to group the rules by (ttype,
> > tclass, filename).
> >
> > Thus, this patch drops the stype field from the key and changes the
> > datum to be a linked list of one or more structures that contain a
> > result type and an ebitmap of source types that map the given target to
> > the given result type under the given filename. The size of the hash
> > table is also incremented to 2048 to be more optimal for Fedora policy
> > (which currently has ~2500 unique (ttype, tclass, filename) tuples,
> > regardless of whether the 'unconfined' module is enabled).
> >
> > Not only does this dramtically reduce memory usage when the policy
> > contains a lot of unconfined domains (ergo a lot of filename based
> > transitions), but it also slightly reduces memory usage of strongly
> > confined policies (modeled on Fedora policy with 'unconfined' module
> > disabled) and significantly reduces lookup times of these rules on
> > Fedora (roughly matches the performance of the rhashtable conversion
> > patch [1] posted recently to selinux@vger.kernel.org).
> >
> > An obvious next step is to change binary policy format to match this
> > layout, so that disk space is also saved. However, since that requires
> > more work (including matching userspace changes) and this patch is
> > already beneficial on its own, I'm posting it separately.
> >
> > Performance/memory usage comparison:
> >
> > Kernel           | Policy load | Policy load   | Mem usage | Mem usage     | openbench
> >                  |             | (-unconfined) |           | (-unconfined) | (createfiles)
> > -----------------|-------------|---------------|-----------|---------------|--------------
> > reference        |       1,30s |         0,91s |      90MB |          77MB | 55 us/file
> > rhashtable patch |       0.98s |         0,85s |      85MB |          75MB | 38 us/file
> > this patch       |       0,95s |         0,87s |      75MB |          75MB | 40 us/file
> >
> > (Memory usage is measured after boot. With SELinux disabled the memory
> > usage was ~60MB on the same system.)
> >
> > [1] https://lore.kernel.org/selinux/20200116213937.77795-1-dev@lynxeye.de/T/
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/policydb.c | 173 ++++++++++++++++++++-------------
> >  security/selinux/ss/policydb.h |   8 +-
> >  security/selinux/ss/services.c |  16 +--
> >  3 files changed, 118 insertions(+), 79 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 981797bfc547..d8b72718e793 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -1882,64 +1884,91 @@ out:
> >
> >  static int filename_trans_read_one(struct policydb *p, void *fp)
> >  {
> > -       struct filename_trans *ft;
> > -       struct filename_trans_datum *otype = NULL;
> > +       struct filename_trans_key key, *ft = NULL;
> > +       struct filename_trans_datum *datum, *last, *newdatum = NULL;
> > +       uintptr_t stype, otype;
> >         char *name = NULL;
> >         u32 len;
> >         __le32 buf[4];
> >         int rc;
> > -
> > -       ft = kzalloc(sizeof(*ft), GFP_KERNEL);
> > -       if (!ft)
> > -               return -ENOMEM;
> > -
> > -       rc = -ENOMEM;
> > -       otype = kmalloc(sizeof(*otype), GFP_KERNEL);
> > -       if (!otype)
> > -               goto out;
> > +       bool already_there;
> >
> >         /* length of the path component string */
> >         rc = next_entry(buf, fp, sizeof(u32));
> >         if (rc)
> > -               goto out;
> > +               return rc;
> >         len = le32_to_cpu(buf[0]);
> >
> >         /* path component string */
> >         rc = str_read(&name, GFP_KERNEL, fp, len);
> >         if (rc)
> > -               goto out;
> > -
> > -       ft->name = name;
> > +               return rc;
> >
> >         rc = next_entry(buf, fp, sizeof(u32) * 4);
> >         if (rc)
> >                 goto out;
> >
> > -       ft->stype = le32_to_cpu(buf[0]);
> > -       ft->ttype = le32_to_cpu(buf[1]);
> > -       ft->tclass = le32_to_cpu(buf[2]);
> > +       stype = le32_to_cpu(buf[0]);
> > +       key.ttype = le32_to_cpu(buf[1]);
> > +       key.tclass = le32_to_cpu(buf[2]);
> > +       key.name = name;
>
> We don't really need the "name" variable anymore do we, we can just
> use "key.name" instead, right?

It is possible, but there is a slight obstacle in that "key.name" is
"const char *" and "name" is "char *" (and str_read() expects a
reference to "char *"). We could change the type in the
filename_trans_key struct, but is it really worth it?

I like to have a separate variable for the name, since it is easier to
spot that it is something we allocate and need to take care not to
leak it. It is easier to forget that there is that one member of key
that you need to free in the error path.

I'll be foolish enough to hope that I convinced you so I'll wait for
your reaction for now, but I'm willing to do the change if you still
want it :)

>
> >
> > -       otype->otype = le32_to_cpu(buf[3]);
> > +       otype = le32_to_cpu(buf[3]);
> >
> > -       rc = ebitmap_set_bit(&p->filename_trans_ttypes, ft->ttype, 1);
> > -       if (rc)
> > -               goto out;
> > +       already_there = false;
> > +       last = NULL;
> > +       datum = hashtab_search(p->filename_trans, &key);
> > +       while (datum) {
> > +               if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
> > +                       already_there = true;
> > +                       break;
>
> Considering the "already_there" check below simply jumps to "out", why
> do we need to add the "already_there" variable, can't we simply jump
> to the "out" label here?  Am I missing something?

Indeed we can... I think I originally expected some more complex logic
under if(already_there) (e.g. reporting warning) so that's why my
brain insisted on having a bool variable... Thanks for spotting it,
I'll simplify it in the next respin.

>
> > +               }
> > +               if (likely(datum->otype == otype))
> > +                       break;
> > +               last = datum;
> > +               datum = datum->next;
> > +       }
> > +       if (unlikely(already_there))
> > +               goto out; /* conflicting/duplicate rules are ignored */
> > +       if (!datum) {
> > +               rc = -ENOMEM;
> > +               newdatum = kmalloc(sizeof(*newdatum), GFP_KERNEL);
> > +               if (!newdatum)
> > +                       goto out;
>
> By definition "datum" will be NULL here so we can get rid of
> "newdatum" and just reuse "datum", yes?  I think the only place where
> we would have to worry about the kfree(datum) in the "out" jump label
> would be in this (!datum) if block which should be okay ...

Well, yes, if we remember to set datum to NULL in the "already_there"
case (and of course at the beginning of the function), then it happens
to work out. It feels a bit unsafe to me, since we should never free
any datum we get from the hashtable, as opposed to the one we
allocate, and using the same variable for both could be error-prone...
but my objection isn't strong, so I'll just do it.

>
> > -       rc = hashtab_insert(p->filename_trans, ft, otype);
> > -       if (rc) {
> > -               /*
> > -                * Do not return -EEXIST to the caller, or the system
> > -                * will not boot.
> > -                */
> > -               if (rc == -EEXIST)
> > -                       rc = 0;
> > -               goto out;
> > +               ebitmap_init(&newdatum->stypes);
> > +               newdatum->otype = otype;
> > +               newdatum->next = NULL;
> > +
> > +               if (unlikely(last)) {
> > +                       last->next = newdatum;
> > +               } else {
> > +                       rc = -ENOMEM;
> > +                       ft = kzalloc(sizeof(*ft), GFP_KERNEL);
> > +                       if (!ft)
> > +                               goto out;
> > +
> > +                       *ft = key;
>
> Off the top of my head I don't know the answer to this, and I worry it
> may fall into the category of "undefined behavior", but if we are
> assigning an entire struct to another dynamically allocated variable
> using "=" is the kzalloc() necessary?  Could we save ourselves a few
> cycles and safely use kmalloc() for "ft"?

Good point. Actually, we can even use kmemdup() to make it a one-step
operation. I don't think there is any issue with undefined behavior,
it is just copying the contents of a struct.


>
> > +                       rc = hashtab_insert(p->filename_trans, ft, newdatum);
> > +                       if (rc)
> > +                               goto out;
> > +                       name = NULL;
> > +
> > +                       rc = ebitmap_set_bit(&p->filename_trans_ttypes,
> > +                                            key.ttype, 1);
> > +                       if (rc)
> > +                               return rc;
> > +               }
> > +               datum = newdatum;
> >         }
> > -       return 0;
> > +       kfree(name);
> > +       return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
> > +
> >  out:
> >         kfree(ft);
> >         kfree(name);
> > -       kfree(otype);
> > +       kfree(newdatum);
> >         return rc;
> >  }
>
> --
> paul moore
> www.paul-moore.com
>


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

