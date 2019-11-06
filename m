Return-Path: <SRS0=VC3m=Y6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F529C5DF62
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 12:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACEB217D7
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 12:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkrTyi+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfKFMYx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:24:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46596 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbfKFMYx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Nov 2019 07:24:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so12548520ljp.13
        for <selinux@vger.kernel.org>; Wed, 06 Nov 2019 04:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fo/RVVQksoFPI1B0S9XWJOFj3r7NXeANl9871GKdH8o=;
        b=YkrTyi+L7+Bnq3ByUlIRM7dNXkYitsvPOwu0S9SH0oaGLRSptTK0oB72f2tTBQUVfR
         aQMG1mOSMA472CWgJ9vtYfb0vdrNN+bIRKEXqCyrMtTfWYZHXsgB+3XqK8X5Kwus36qk
         ta9+X87dsMQ/a532wl4y09Z2IrXUNoGytOSsD7RAHefAB2+eYXgaTYe5CiRKiRMyCopT
         QjxpqFB+pmwtyzFgozsQgIfqzChrAdc7BrqqVN76dC+Uj2DUDiL0VwBGRbkKelYWiooS
         RkyVaj98K2AJdYef/YzrLcc2QSWy8VidCiniGhrGf5GXqQeS+qixzWKmqipJmMB1HFEq
         5oYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fo/RVVQksoFPI1B0S9XWJOFj3r7NXeANl9871GKdH8o=;
        b=mTT7+6yzmxwCKdXjt+HXhIkjzta/0O+HIUpbhsHLEyRtimci8bOO9dN+e36lKixdb9
         SrX7Ol6e5rNaHsjJ2Ck4hrqolKTutUG1DT2krko4utfns2oNcjPM27FP5AVIwcG9Vy4d
         piZt7I4qiRz5QdQSge/++HYBAenyILmFBetXUQTTi2mP3ffiTiuwa6opA8xS71jaAHzW
         /v1ZBEBsQqsy7URJU8e1QF/vrHsDsO5718duJqPKf9QjNocizW2HEGUnnJ8DEpE6/pZn
         mboxwVO3oqkCJiGpMjo5aKtPFrCGfaJDI2/FX0izlcWuybnT3+3jJ+OW6CAskfia687O
         3/xA==
X-Gm-Message-State: APjAAAV6gyJ8tsucMKI+tm1m008TCOtrXuHceVwVXgjlzCuPHAjkeTSo
        iUbqgbck54ROD7EtAiUdK7rTPbPEgQxc2dzG/MCA6w==
X-Google-Smtp-Source: APXvYqxj7NOHZ99rZf48pwff1jplT4qKVN0FB0qF5vmpiw7wdGfNd+8atsBL/mX9DKgnpJICiFRkatG+KbepTP+0MIE=
X-Received: by 2002:a05:651c:1202:: with SMTP id i2mr1813533lja.218.1573043090172;
 Wed, 06 Nov 2019 04:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20191104191535.23642-1-jeffv@google.com> <CAFqZXNvgcnYDER9aoV5aUfLL=jwDdoTs3EroOYchK+6PMWsO+w@mail.gmail.com>
In-Reply-To: <CAFqZXNvgcnYDER9aoV5aUfLL=jwDdoTs3EroOYchK+6PMWsO+w@mail.gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Wed, 6 Nov 2019 13:24:38 +0100
Message-ID: <CABXk95Afd963ayWxbmtnOCP==Zzr2LnGpUiUjvGMcC5BJzCYwQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: sidtab: reverse lookup hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> > +static u32 context_to_sid(struct sidtab *s, struct context *context)
> > +{
> > +       struct sidtab_entry_leaf *entry;
> > +
> > +       hash_for_each_possible(s->context_to_sid, entry, list, context->hash) {
> > +               if (context_cmp(&entry->context, context))
> > +                       return entry->sid;
>
> For this to be semantically safe against entries being added, it would
> need the hlist head -> first member to be read with
> smp_load_acquire(). Probably in practice you would always get fresh
> data when dereferencing a pointer, but I don't think we should rely on
> that... In fact it looks like hash_for_each_possible() wasn't really
> written with lockless traversal in mind - I checked a few random
> places that call it and they all either do it under some lock or
> expect the table to be immutable. I believe you will need to introduce
> a new equivalents of hash_add()/hlist_add_head() (that does
> smp_store_release() instead of WRITE_ONCE(), because the 'next'
> pointer of the node being added must be written before the head's
> first pointer is set to point to the new node) and
> hash_for_each_possible()/hlist_for_each_entry() (that loads
> (head)->first with smp_load_acquire()).
>
> Then again, I'm not an expert on this synchronization stuff, so I
> might be wrong... But you will have to prove it :)

I spoke with Will Deacon about this and he confirmed your concerns that
this cannot be done safely without locking. I'll migrate to the "rcu" hashtable
variant.

>
> > +       }
> > +       return 0;
> > +}
> > +
>
> I am a little uneasy about this function having the same name as the
> context_to_sid() in security.c. It could be confusing when debugging.
> Maybe you could name the security.c function to
> context_struct_to_sid()?
>
> >  int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
> >  {
> >         struct sidtab_isid_entry *entry;
>
> <snip>
>
> > @@ -305,29 +275,35 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
> >                 rc = -ENOMEM;
> >                 dst_convert = sidtab_do_lookup(convert->target, count, 1);
> >                 if (!dst_convert) {
> > -                       context_destroy(dst);
> > +                       context_destroy(&dst->context);
> >                         goto out_unlock;
> >                 }
> >
> > -               rc = convert->func(context, dst_convert, convert->args);
> > +               rc = convert->func(context, &dst_convert->context,
> > +                               convert->args);
> >                 if (rc) {
> > -                       context_destroy(dst);
> > +                       context_destroy(&dst->context);
> >                         goto out_unlock;
> >                 }
> > +               dst_convert->sid = index_to_sid(count);
> >
> >                 /* at this point we know the insert won't fail */
> > +               spin_lock_irqsave(&convert->target->lock, flags);
> >                 convert->target->count = count + 1;
> > +               hash_add(convert->target->context_to_sid,
> > +                        &dst_convert->list, dst_convert->context.hash);
> > +               spin_unlock_irqrestore(&convert->target->lock, flags);
>
> Do we really need to lock the conversion target here? The
> (undocumented) contract here was that as long as the conversion is in
> progress, the target sidtab is "owned" by the master sidtab and any
> modifications of it would be done under the master's spinlock (the
> target's spinlock wouldn't be used until it is swapped-in to be the
> new master). Did this contract change with your patch? I think this
> nested locking is the cause of the lock warning that Stephen is
> getting so hopefully you can fix it by simply removing this extra
> locking.
>
Some form of locking is necessary. Otherwise there can be concurrent
additions to the hashtable, which is not safe. My goal here is to avoid having
a single lock which is held for the duration of the conversion because that is
what caused issues previously during policy reload.

> <snip>
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
