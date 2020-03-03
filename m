Return-Path: <SRS0=zB1t=4U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0142EC3F2CD
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 08:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA7820848
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 08:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSlvXM5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgCCId2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:33:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40190 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726917AbgCCId2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Mar 2020 03:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583224407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQIv25kfvfu3OIa0h6FtAM8RROZpMnc21pdNmJy2cI0=;
        b=GSlvXM5Qre524TZgFs5sabyVNGhr4wTuM/W/cHa9chWpofKQWe+ROrBDbr0aKybHc/rqwp
        AsnGHuFn1nLfqBzngaAL9T2DZTLGkqI92oPOnPz+PAMdaQjCr9om4G+jIBsDbLyw/3rWrm
        YW7fT+9KTLf5FYWvBXVFivstFWZUCsQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-kbDC744XP3-GqCwgsHsySA-1; Tue, 03 Mar 2020 03:33:25 -0500
X-MC-Unique: kbDC744XP3-GqCwgsHsySA-1
Received: by mail-oi1-f200.google.com with SMTP id v198so1383510oia.15
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2020 00:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQIv25kfvfu3OIa0h6FtAM8RROZpMnc21pdNmJy2cI0=;
        b=lI1UlX44HPeJU07yax7UBm+YdRsnxqItr10tIRj0kM2EVaSxroiCWNptB3dBA1s1ZU
         BmVjT5zcYIDeyJNw4h8RuH8fBfB49U/IJ3WNcJFr9u+5mOJQtf43zTDHTpBXFi+HgmuJ
         gCdyaas80Qd4yeFFhS4uEQzJvcEMLrMIzXHlqEXfI0v/BoqT0ne6dMhPinDsyMnJYays
         pp64EjDdHSW/+pukENzYSryn1P+ZvBObzRShvb82z15v4ExK50oQRCBcD+chJ49AbBmm
         Kl+DymJXIVH+HYm/wctGg49rCZzMv4+0b4RCjcW7yIApbfjrecseHNCG+xNR+3cO5Hjx
         Iwdg==
X-Gm-Message-State: ANhLgQ2htH1E/UKY2dH8PKZpcNRMWWCMlqXLLo/AnaFBp6MbBsuF571a
        HD10/KLmS70Sr/SzHtxRg0VQGP7BEYL+8sp8etO+jyBRjKpFexdgHRMc27nV8AalL7LsGNgOjIl
        xmJUB35/54uk2R7sR5cMjNAyGImuOohTf9g==
X-Received: by 2002:a9d:4782:: with SMTP id b2mr2554597otf.66.1583224404625;
        Tue, 03 Mar 2020 00:33:24 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuT8SEPmjLadQLqL/V20u/C+kGqR2Mi6vQJ/YQlY+yB0iaTLJO2/YGHTnL+r6m+R1KWWv+eVUCSvFo3p4oo3N4=
X-Received: by 2002:a9d:4782:: with SMTP id b2mr2554583otf.66.1583224404284;
 Tue, 03 Mar 2020 00:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20200226155452.301544-1-omosnace@redhat.com> <CAEjxPJ5M=iaVBQQGT8QqnHsndXKzxvRMSxSNbm3arNwXnmu4GQ@mail.gmail.com>
 <CAHC9VhQ0MHSRyHwnLjA_dpMMGY=kX22oFm0WNSO3B7zn2BTHeQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ0MHSRyHwnLjA_dpMMGY=kX22oFm0WNSO3B7zn2BTHeQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 3 Mar 2020 09:33:13 +0100
Message-ID: <CAFqZXNtfyF7fz=y1i=0ZVMKH4+dnLmLJvv2nPzOQLvsvdiPNrA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: reduce the use of hard-coded hash sizes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 3, 2020 at 12:16 AM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Mar 2, 2020 at 2:11 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Feb 26, 2020 at 10:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Instead allocate hash tables with just the right size based on the
> > > actual number of elements (which is almost always known beforehand, we
> > > just need to defer the hashtab allocation to the right time). The only
> > > case when we don't know the size (with the current policy format) is the
> > > new filename transitions hashtable. Here I just left the existing value.
> > >
> > > After this patch, the time to load Fedora policy on x86_64 decreases
> > > from 790 ms to 167 ms. If the unconfined module is removed, it decreases
> > > from 750 ms to 122 ms. It is also likely that other operations are going
> > > to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> > > but I didn't try to quantify that.
> > >
> > > The memory usage of all hash table arrays increases from ~58 KB to
> > > ~163 KB (with Fedora policy on x86_64).
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > > index 32b3a8acf96f..7ca8c74efba3 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -503,20 +482,12 @@ static int policydb_init(struct policydb *p)
> > >                 goto out;
> > >         }
> > >
> > > -       p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
> > > -       if (!p->range_tr) {
> > > -               rc = -ENOMEM;
> > > -               goto out;
> > > -       }
> > > -
> > >         ebitmap_init(&p->filename_trans_ttypes);
> > >         ebitmap_init(&p->policycaps);
> > >         ebitmap_init(&p->permissive_map);
> > >
> > >         return 0;
> > >  out:
> > > -       hashtab_destroy(p->filename_trans);
> > > -       hashtab_destroy(p->range_tr);
> > >         for (i = 0; i < SYM_NUM; i++) {
> > >                 hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
> > >                 hashtab_destroy(p->symtab[i].table);
> >
> > Sorry, just pointed out to me that this left the symtab destruction
> > code in the out path of policydb_init()
> > even though we are no longer creating them there.  Harmless but should
> > be dropped.
>
> Ondrej, can you submit a cleanup patch for this?

Sure, already on it...

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

