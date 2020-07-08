Return-Path: <SRS0=sWNN=AT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FD1C433E0
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6F520786
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X250fcNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgGHOhY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:37:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35285 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729468AbgGHOhT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 10:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594219037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2fiuW/fGt85PFp8F1Zmw9Ruq9Q0xwhVKNyMYiHcDaxo=;
        b=X250fcNGMEORiO/saq3XbVBGiDo1Ne2ktXrBN0zarz/6ZSGeD8umuFRcVjzDL/6Wum7eVF
        IzZ/KuuZKs7ArWsz9H9VU8fgq0NYUHjp37ub2Quc4hcgLeCZNKd7CHRrNLNUodEkfH9B32
        z+Lgm+E4CoquPEVu+ZojIpktHToWwWs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-L7bT7oq5PsGRsub2qHDBLw-1; Wed, 08 Jul 2020 10:37:16 -0400
X-MC-Unique: L7bT7oq5PsGRsub2qHDBLw-1
Received: by mail-lj1-f200.google.com with SMTP id w19so19252969ljm.16
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2020 07:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fiuW/fGt85PFp8F1Zmw9Ruq9Q0xwhVKNyMYiHcDaxo=;
        b=LwYh/5QcZyC4dM+jJYkWRSAx+jyWBB9O0o4afX4sh0mDNVuw9bgF0XXa285Ufu1pgb
         l4BJMSpPu+lWcEvNg4HrFXNvTczQ3NSSLnGcQ/tzG8AP+7KC0sTFvIGjhLVfRBZxrf0e
         j7Vts9srfBB0ycGynSePPCwBfxY8IFBGGyXwIP6Jedhdqf5y0SWfcAG+eMs1OO62zg/d
         ZF/EbTwH0mfEavF44AWtxm3vQRac2U9SFl4WnWxrz758QBj+qIcmh9wXDPcKh093QYyA
         NUChNBGw7/m/Ys4BupFHipqNQIqbf2lUQZ4MdimphwnHAr3hrjqSVQXC/cxVwNwz6RHK
         +YyA==
X-Gm-Message-State: AOAM533f1VzmJW9SlaVLsm/bw8KAQQE72K7QiO992zT8CTm4Fk2K5R02
        W91odBD+mdtEH7yeCEEMLSDiKyZh/F09ddYesIT0TQZcxj/A8NJFnK+5ZOIymRxJi+i6Aey/Jbk
        jcpc1Huv9I0YfgLbkZni2E/+6YUpT7kvW9w==
X-Received: by 2002:a2e:8798:: with SMTP id n24mr21270619lji.372.1594219034492;
        Wed, 08 Jul 2020 07:37:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQjgi1RAlFykQR7HvKioTXtNkwwoQxDwILn7lvbffKgnEIeffhN3xJPif/SvLqNLrUumUVUgzi9xBUGghC7uA=
X-Received: by 2002:a2e:8798:: with SMTP id n24mr21270605lji.372.1594219034193;
 Wed, 08 Jul 2020 07:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200708112447.292321-1-omosnace@redhat.com> <20200708112447.292321-3-omosnace@redhat.com>
 <CAEjxPJ6HptedbTxrSKi3sYk+7PZ7-JHiNqa9eti86+BWm=Z6pg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6HptedbTxrSKi3sYk+7PZ7-JHiNqa9eti86+BWm=Z6pg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Jul 2020 16:37:03 +0200
Message-ID: <CAFqZXNv9k76BP5Qb0WHsJwMipfkB_Ukc6YpDHV=PAu=jkROuqw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] selinux: prepare for inlining of hashtab functions
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 8, 2020 at 3:38 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jul 8, 2020 at 7:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Refactor searching and inserting into hashtabs to pave the way for
> > converting hashtab_search() and hashtab_insert() to inline functions in
> > the next patch. This will avoid indirect calls and allow the compiler to
> > better optimize individual callers, leading to a significant performance
> > improvement.
> >
> > In order to avoid the indirect calls, the key hashing and comparison
> > callbacks need to be extracted from the hashtab struct and passed
> > directly to hashtab_search()/_insert() by the callers so that the
> > callback address is always known at compile time. The kernel's
> > rhashtable library (<linux/rhashtable*.h>) does the same thing.
> >
> > This of course makes the hashtab functions slightly easier to misuse by
> > passing a wrong callback set, but unfortunately there is no better way
> > to implement a hash table that is both generic and efficient in C. This
> > patch tries to somewhat mitigate this by only calling the hashtab
> > functions in the same file where the corresponding callbacks are
> > defined (wrapping them into more specialized functions as needed).
> >
> > Note that this patch doesn't bring any benefit without also moving the
> > definitions of hashtab_search() and -_insert() to the header file, which
> > is done in a follow-up patch for easier review of the hashtab.c changes
> > in this patch.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
>
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 02b722c5c189d..ae78f66e85d29 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -1888,7 +1920,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
> >         otype = le32_to_cpu(buf[3]);
> >
> >         last = NULL;
> > -       datum = hashtab_search(&p->filename_trans, &key);
> > +       datum = hashtab_search(&p->filename_trans, &key, filenametr_key_params);
>
> Why aren't you using the helper/wrapper function here?

Oversight on my part, thanks for spotting it! I'll wait for Paul's
feedback and send a fixed v4 if needed.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

