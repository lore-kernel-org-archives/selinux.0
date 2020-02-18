Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC48AC34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 15:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14B420679
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 15:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKrf3RVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgBRPWL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:22:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39763 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726721AbgBRPWL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 10:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582039330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vA4rrRE4b+DlLDQq1PaekVWIbhIV0G4sZ8n4I0nYZrI=;
        b=MKrf3RVJ/CjNiGfaMQzWn3OyYbQkeQ/2wPe9uRh1rNO/rPjZAH8j8Tyy48zq6y3Gna5Qvk
        x6btsWdykH7EruBZYtSrJa6Z/3ODWd70AGVgrblFyesuWoeFxE/jaUMP9uVMYqIwX2CVqa
        /nFPK4kiNGX9SbyFl9F9uuY9SvQfMw0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-5InW8PjXO4ehG2DVrflD1Q-1; Tue, 18 Feb 2020 10:22:07 -0500
X-MC-Unique: 5InW8PjXO4ehG2DVrflD1Q-1
Received: by mail-oi1-f197.google.com with SMTP id 199so242165oie.10
        for <selinux@vger.kernel.org>; Tue, 18 Feb 2020 07:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vA4rrRE4b+DlLDQq1PaekVWIbhIV0G4sZ8n4I0nYZrI=;
        b=mdv2TjIT6h7SRLvuZ9HYO26ilrxPswpgzBuq0A7zIQxRS1xpU31mwqXF5F3jSi/X7x
         SttjBOiStA+OAJOifO4pPVuOk5iSwy1P5149clQ2bi9ohIXTIDnINE4GZ4HDWDuOSFnL
         7aOnVZsSRmL+REu8Wvk2ySdiGNs9gt0OC/zZfDMRAGLw+LQiRXoD/GvFtmrfj+9gwaid
         KHuPBZ36i1pmKv8z7D8pJKh+p3U2sNXoVzscOkz1iL/l+bO34E0DJNpOly57skcgsYlS
         hAZc/AF3kpK3fHZ5G33BJdmRboJ79lM6hoIaC5bU89luKXaHeryq8Fzro9ot28VJG5+T
         ioIQ==
X-Gm-Message-State: APjAAAUBDBsvCy2o1UtOjaWOMvAoo1X3tpXD1myaVwe+j4yB3wxZEp0Z
        q0HQWiz/QkFvYdUc5pFxy7wiIqjueY4DOuUJn4uWiGnhnangUjkM0zXPxTkEd89fggFKew24jbP
        PGoBImziT0rsEbamTMoVrS2QqQI+/T5LJCA==
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr15099113oth.43.1582039326366;
        Tue, 18 Feb 2020 07:22:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZRl/Yu/EqhtaE3ikBwmEiBusq1tai28qxQPJKfH/vOZHHqHNf7Nc8eUB7kXganPuEKAoCsspwsUIuUnLIGV8=
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr15099097oth.43.1582039326063;
 Tue, 18 Feb 2020 07:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20200217114943.67607-1-omosnace@redhat.com> <072c5073-3810-e2fd-ee54-fe8a5dc163df@tycho.nsa.gov>
In-Reply-To: <072c5073-3810-e2fd-ee54-fe8a5dc163df@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 18 Feb 2020 16:21:55 +0100
Message-ID: <CAFqZXNsm8TPp=60CLu6u2NH4oFBioXb_y1mLnVxvuWa=S9Qzfg@mail.gmail.com>
Subject: Re: [PATCH] selinux: reduce the use of hard-coded hash sizes
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 18, 2020 at 3:59 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/17/20 6:49 AM, Ondrej Mosnacek wrote:
> > Instead allocate hash tables with just the right size based on the
> > actual number of elements (which is almost always known beforehand, we
> > just need to defer the hashtab allocation to the right time). The only
> > case when we don't know the size (with the current policy format) is the
> > new filename transitions hashtable. Here I just left the existing value.
> >
> > After this patch, the time to load Fedora policy on x86_64 decreases
> > from 950 ms to 220 ms. If the unconfined module is removed, it decreases
> > from 870 ms to 170 ms. It is also likely that other operations are going
> > to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> > but I didn't try to quantify that.
> >
> > The memory usage increases a bit after this patch, but only by ~1-2 MB
> > (it is hard to measure precisely). I believe it is a small price to pay
> > for the increased performance.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   security/selinux/ss/hashtab.c  | 21 ++++++++++++--
> >   security/selinux/ss/hashtab.h  |  2 +-
> >   security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
> >   security/selinux/ss/policydb.h |  2 --
> >   4 files changed, 40 insertions(+), 38 deletions(-)
> >
> > diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> > index ebfdaa31ee32..554a91ef3f06 100644
> > --- a/security/selinux/ss/hashtab.c
> > +++ b/security/selinux/ss/hashtab.c
> > @@ -27,6 +41,9 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
> >       p->nel = 0;
> >       p->hash_value = hash_value;
> >       p->keycmp = keycmp;
> > +     if (!size)
> > +             return p;
> > +
> >       p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
> >       if (!p->htable) {
> >               kfree(p);
>
> Thanks, this looks promising.  However, I was wondering: if we end up
> with size == 0 (e.g. policy happens to have an empty table), does the
> rest of the hashtab_* code always correctly handle the fact that
> ->htable could be NULL?  Doesn't look obviously safe to me on a quick look.

Hm... it seems I didn't think this through when I was trying to handle
this case. I was rebasing this patch all over the place as I was
working on other changes in parallel, so maybe I just lost the safety
somewhere along the way... I think I will just clamp the minimum size
to 1, as that seems both safer and simpler. The extra 8-byte
allocation shouldn't cost much (there are only O(number of classes +
commons) hash tables and these make no sense to have 0 entries).

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

