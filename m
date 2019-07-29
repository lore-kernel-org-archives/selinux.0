Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB85C7618B
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 07:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5AB216C8
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 07:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfG2Hd5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:33:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46505 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfG2Hd4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 03:33:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so33226008ote.13
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 00:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OE+Z/HCbIwd1N0xtAxYm3E5scpKICVpyoP5iwh5Lo4=;
        b=Pmkvg3ImMXkjP/3x5N0gqCERJ513hapBYavqsNx8a5h1QfPykAPOIZCv/p40C57p1F
         Jgut2lXhvuM9tlrVUuUPnEf43EUc3Y/ucJQVpG0d+bsAi3oru8WSyjiJFmXCOaSfJf3O
         /5HQbb10XAx44JnKWYwXUwslhK/TpHC4RhprhzYJJPgp6veaHRG2MMhryUBQDM2viydW
         7C6IwWgfvry6b4gfNjDBOVlC2y62yvVRBrmTBT/wW7QpolmSze6fjL9TLmQVMwbB1ko6
         tOYxF+Iz0mMZE+zEXpj8spmIjCcKluKX6JC9oZKzslKfW0tJtEg8iF9+qWrTx2l8stV8
         dIpw==
X-Gm-Message-State: APjAAAXp69V7M+/pSgbmu1hQHO0g665yredWGLYXOXJPJHRipL9SPIti
        u0r8DjL/k6qkIXPK4AtEvcLz1RsVwa/v2+PYbwH/cg==
X-Google-Smtp-Source: APXvYqylWzmNNRq2RJVMF15mKQ98N72JwScO2uHSBB0VpLWMT69v0/Tv38OatqMTXTMhv1+yZYArVq8gp27Z6ztpbXk=
X-Received: by 2002:a05:6830:1086:: with SMTP id y6mr42727594oto.22.1564385635822;
 Mon, 29 Jul 2019 00:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190725105243.28404-1-omosnace@redhat.com> <CAHC9VhR9Lfy0iddbpue2iMKqKGAfqMBeV17KbDoLrM62ngQzKg@mail.gmail.com>
In-Reply-To: <CAHC9VhR9Lfy0iddbpue2iMKqKGAfqMBeV17KbDoLrM62ngQzKg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 29 Jul 2019 09:33:44 +0200
Message-ID: <CAFqZXNsqnOn5+HEFDLKqdr4UbwwqZ8_XUm6dZH62kS8sx0h30A@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix memory leak in policydb_init()
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jul 27, 2019 at 12:27 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jul 25, 2019 at 6:52 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Since roles_init() adds some entries to the role hash table, we need to
> > destroy also its keys/values on error, otherwise we get a memory leak in
> > the error path.
> >
> > Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/policydb.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index daecdfb15a9c..38d0083204f1 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -274,6 +274,8 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
> >         return v;
> >  }
> >
> > +static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap);
>
> I'm prefer not to use forward declarations if they can be avoided, and
> in this particular case it looks like we can move the *_destroy
> functions up just below policydb_lookup_compat() and avoid the forward
> declaration while keeping some sanity to the layout of the file.
>
> Yes, the patch does become much larger (378 lines changed in the test
> patch I just did), but I think the end result is cleaner.

OK, that'ts reasonable. I'll post an updated v2.

>
> >  /*
> >   * Initialize a policy database structure.
> >   */
> > @@ -321,8 +323,10 @@ static int policydb_init(struct policydb *p)
> >  out:
> >         hashtab_destroy(p->filename_trans);
> >         hashtab_destroy(p->range_tr);
> > -       for (i = 0; i < SYM_NUM; i++)
> > +       for (i = 0; i < SYM_NUM; i++) {
> > +               hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
> >                 hashtab_destroy(p->symtab[i].table);
> > +       }
> >         return rc;
> >  }
> >
> > --
> > 2.21.0
> >
>
>
> --
> paul moore
> www.paul-moore.com

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
