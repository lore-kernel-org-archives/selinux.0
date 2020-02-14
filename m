Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FD1C3B192
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 00:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15CC2168B
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 00:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MIiGl0YA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBNAf4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:35:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33353 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBNAf4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 19:35:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so9151135edq.0
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2020 16:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WElCLdP43eu7ktNsP5QgKN3VwWTAf46l9TANut/ZGzQ=;
        b=MIiGl0YA5D2BlA0YnhHjhA/tl/ArB3MBkzXu9K9OdMvIMi4ifjZr/AYmiNKu1Ls8P6
         BQhoL+8BgdTW9tyA6b2l+KFy4dYPPV61W6mJ/i6jkHgGCH0mxHMC1Xb8yqclCqTwY9dm
         uOD5vkVXoDu4adCREEcdt5jTD0U2fQ82HlK8Jw9aZSrzqoYj94OyREiWB9GwTfEASySt
         e/1Fy4icIoUfRasPqJebTjbH4RqGU2DdQrY686ORU2qo5SKnU7Kwq0RihFbyYbDsAZf3
         DpHgZd1pFrnXMUY48OFVM6DHO+vpfETE2gEmb0MGsKu6OlXgnTJDd6IguLjfCtC6rA+G
         6q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WElCLdP43eu7ktNsP5QgKN3VwWTAf46l9TANut/ZGzQ=;
        b=kXVURt0SXcvYOyEuLoF5nesYzuVdIPG0eAjregYeMzPUCJXNunH/gxwF1oBSzeYdWV
         +JE3DDgBOBF2UvUx+UFwN+GFXrBw2vsHZ/AgYaoJBCre9NKjTEmQloVfVUh9AiNLyZ4W
         nNswAyZzj/uAD3MfzcgaqnKTukJ9Z0ORJ0DP+ONYKgZ+ODOVoApIAzQ6uu3ZaFIaiJbK
         A6n8wTGw6Ib4fxn62Ic8HTMtk7G12tpNAE9wpvMILzEu0+Gc1doqMQQTmjUALib+CBhH
         a66owriugg/wPKrctnGvEwP3PDbsOzVr7R8NLUqFHxPnCZ2izoHcmM9wrGPLBdLgaJk7
         mt2A==
X-Gm-Message-State: APjAAAW3P8X2pZysddx2SCofzhsPjRl4rEDsqIIB19YDf5cjOEsYcd5y
        7t4Nl+I3R/x6nW7pEkus951JBqgpXzlxCjAamGGp
X-Google-Smtp-Source: APXvYqxPbWpfP+OAHzSuWOnan2P84T4q99Qi3IQ6+FuzmzmUrJMqHbKaYgGtAJOnvclQNFbTrDTiBP5dUI8VWN9W7Eg=
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr276788edc.128.1581640552476;
 Thu, 13 Feb 2020 16:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20200212112255.105678-1-omosnace@redhat.com> <20200212112255.105678-3-omosnace@redhat.com>
In-Reply-To: <20200212112255.105678-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Feb 2020 19:35:41 -0500
Message-ID: <CAHC9VhRwqRLNgycuX_MSYE83tFJBiresfiYRcz3RYX9Le+pTSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: optimize storage of filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 12, 2020 at 6:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In these rules, each rule with the same (target type, target class,
> filename) values is (in practice) always mapped to the same result type.
> Therefore, it is much more efficient to group the rules by (ttype,
> tclass, filename).
>
> Thus, this patch drops the stype field from the key and changes the
> datum to be a linked list of one or more structures that contain a
> result type and an ebitmap of source types that map the given target to
> the given result type under the given filename. The size of the hash
> table is also incremented to 2048 to be more optimal for Fedora policy
> (which currently has ~2500 unique (ttype, tclass, filename) tuples,
> regardless of whether the 'unconfined' module is enabled).
>
> Not only does this dramtically reduce memory usage when the policy
> contains a lot of unconfined domains (ergo a lot of filename based
> transitions), but it also slightly reduces memory usage of strongly
> confined policies (modeled on Fedora policy with 'unconfined' module
> disabled) and significantly reduces lookup times of these rules on
> Fedora (roughly matches the performance of the rhashtable conversion
> patch [1] posted recently to selinux@vger.kernel.org).
>
> An obvious next step is to change binary policy format to match this
> layout, so that disk space is also saved. However, since that requires
> more work (including matching userspace changes) and this patch is
> already beneficial on its own, I'm posting it separately.
>
> Performance/memory usage comparison:
>
> Kernel           | Policy load | Policy load   | Mem usage | Mem usage     | openbench
>                  |             | (-unconfined) |           | (-unconfined) | (createfiles)
> -----------------|-------------|---------------|-----------|---------------|--------------
> reference        |       1,30s |         0,91s |      90MB |          77MB | 55 us/file
> rhashtable patch |       0.98s |         0,85s |      85MB |          75MB | 38 us/file
> this patch       |       0,95s |         0,87s |      75MB |          75MB | 40 us/file
>
> (Memory usage is measured after boot. With SELinux disabled the memory
> usage was ~60MB on the same system.)
>
> [1] https://lore.kernel.org/selinux/20200116213937.77795-1-dev@lynxeye.de/T/
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 173 ++++++++++++++++++++-------------
>  security/selinux/ss/policydb.h |   8 +-
>  security/selinux/ss/services.c |  16 +--
>  3 files changed, 118 insertions(+), 79 deletions(-)

...

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 981797bfc547..d8b72718e793 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1882,64 +1884,91 @@ out:
>
>  static int filename_trans_read_one(struct policydb *p, void *fp)
>  {
> -       struct filename_trans *ft;
> -       struct filename_trans_datum *otype = NULL;
> +       struct filename_trans_key key, *ft = NULL;
> +       struct filename_trans_datum *datum, *last, *newdatum = NULL;
> +       uintptr_t stype, otype;
>         char *name = NULL;
>         u32 len;
>         __le32 buf[4];
>         int rc;
> -
> -       ft = kzalloc(sizeof(*ft), GFP_KERNEL);
> -       if (!ft)
> -               return -ENOMEM;
> -
> -       rc = -ENOMEM;
> -       otype = kmalloc(sizeof(*otype), GFP_KERNEL);
> -       if (!otype)
> -               goto out;
> +       bool already_there;
>
>         /* length of the path component string */
>         rc = next_entry(buf, fp, sizeof(u32));
>         if (rc)
> -               goto out;
> +               return rc;
>         len = le32_to_cpu(buf[0]);
>
>         /* path component string */
>         rc = str_read(&name, GFP_KERNEL, fp, len);
>         if (rc)
> -               goto out;
> -
> -       ft->name = name;
> +               return rc;
>
>         rc = next_entry(buf, fp, sizeof(u32) * 4);
>         if (rc)
>                 goto out;
>
> -       ft->stype = le32_to_cpu(buf[0]);
> -       ft->ttype = le32_to_cpu(buf[1]);
> -       ft->tclass = le32_to_cpu(buf[2]);
> +       stype = le32_to_cpu(buf[0]);
> +       key.ttype = le32_to_cpu(buf[1]);
> +       key.tclass = le32_to_cpu(buf[2]);
> +       key.name = name;

We don't really need the "name" variable anymore do we, we can just
use "key.name" instead, right?

>
> -       otype->otype = le32_to_cpu(buf[3]);
> +       otype = le32_to_cpu(buf[3]);
>
> -       rc = ebitmap_set_bit(&p->filename_trans_ttypes, ft->ttype, 1);
> -       if (rc)
> -               goto out;
> +       already_there = false;
> +       last = NULL;
> +       datum = hashtab_search(p->filename_trans, &key);
> +       while (datum) {
> +               if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
> +                       already_there = true;
> +                       break;

Considering the "already_there" check below simply jumps to "out", why
do we need to add the "already_there" variable, can't we simply jump
to the "out" label here?  Am I missing something?

> +               }
> +               if (likely(datum->otype == otype))
> +                       break;
> +               last = datum;
> +               datum = datum->next;
> +       }
> +       if (unlikely(already_there))
> +               goto out; /* conflicting/duplicate rules are ignored */
> +       if (!datum) {
> +               rc = -ENOMEM;
> +               newdatum = kmalloc(sizeof(*newdatum), GFP_KERNEL);
> +               if (!newdatum)
> +                       goto out;

By definition "datum" will be NULL here so we can get rid of
"newdatum" and just reuse "datum", yes?  I think the only place where
we would have to worry about the kfree(datum) in the "out" jump label
would be in this (!datum) if block which should be okay ...

> -       rc = hashtab_insert(p->filename_trans, ft, otype);
> -       if (rc) {
> -               /*
> -                * Do not return -EEXIST to the caller, or the system
> -                * will not boot.
> -                */
> -               if (rc == -EEXIST)
> -                       rc = 0;
> -               goto out;
> +               ebitmap_init(&newdatum->stypes);
> +               newdatum->otype = otype;
> +               newdatum->next = NULL;
> +
> +               if (unlikely(last)) {
> +                       last->next = newdatum;
> +               } else {
> +                       rc = -ENOMEM;
> +                       ft = kzalloc(sizeof(*ft), GFP_KERNEL);
> +                       if (!ft)
> +                               goto out;
> +
> +                       *ft = key;

Off the top of my head I don't know the answer to this, and I worry it
may fall into the category of "undefined behavior", but if we are
assigning an entire struct to another dynamically allocated variable
using "=" is the kzalloc() necessary?  Could we save ourselves a few
cycles and safely use kmalloc() for "ft"?

> +                       rc = hashtab_insert(p->filename_trans, ft, newdatum);
> +                       if (rc)
> +                               goto out;
> +                       name = NULL;
> +
> +                       rc = ebitmap_set_bit(&p->filename_trans_ttypes,
> +                                            key.ttype, 1);
> +                       if (rc)
> +                               return rc;
> +               }
> +               datum = newdatum;
>         }
> -       return 0;
> +       kfree(name);
> +       return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
> +
>  out:
>         kfree(ft);
>         kfree(name);
> -       kfree(otype);
> +       kfree(newdatum);
>         return rc;
>  }

-- 
paul moore
www.paul-moore.com
