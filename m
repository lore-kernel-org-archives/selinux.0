Return-Path: <SRS0=/Hxn=6Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE01C3A5A9
	for <selinux@archiver.kernel.org>; Sat,  2 May 2020 09:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF97216FD
	for <selinux@archiver.kernel.org>; Sat,  2 May 2020 09:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZhh67Ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgEBJMB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 May 2020 05:12:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726488AbgEBJMA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 May 2020 05:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588410718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3F2KyFEaUkzAugeyEYQEz/HkD0AgrhqH3TgXTtFz+pw=;
        b=MZhh67Aeu+waTNHALXVIfaX7LP/LQ/XQMrs01LLBnccphsv3a5I1Mew/oFKqcJyl8Mfvoa
        PPMbnUU8JB0xvaKjMa2fHQ/xkLGqG25NStYaFuF5fcE2531UXgHWrmkMrj1wGoF8BkXEsm
        ExQCDZ4KDSxKGgQqhdvAMsikevOj6Uo=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-iW6oT7KvOf6G1Q7DLTUMNA-1; Sat, 02 May 2020 05:11:57 -0400
X-MC-Unique: iW6oT7KvOf6G1Q7DLTUMNA-1
Received: by mail-oo1-f70.google.com with SMTP id a144so4112784oob.6
        for <selinux@vger.kernel.org>; Sat, 02 May 2020 02:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3F2KyFEaUkzAugeyEYQEz/HkD0AgrhqH3TgXTtFz+pw=;
        b=eyiRhwWr1kr1m3EOENPk4m7NlquCg7XvDEuz26/4etvq3wGHdFQXtwUYW+YKEGFVmN
         3WvA2o27EirwlAJkfYmLT8+MxKhlDu30E69uTdKRkC7cda0HaGUlW3AbAa2O9BwWb41o
         33qUdpitSZAAPxqdJ06e8Qh0bQ/8pSf6K1IlZ0byupHSQXbcvr0oyoLTX8WIgd4PEyKl
         x14iH7dNkcViiwzQK1IhlgxRMBuV83T35Qge1hy1rC0NCzbEYEf4zWKtJwHC/MkzZeLQ
         Sri4mrFFX+7orAMvF06+EbHGW2O5xJIyuWNzegRDDoeCnlfOZPVprzUaLm68zlywvCF8
         hSCQ==
X-Gm-Message-State: AGi0Pub3Gw0Cg6HXAM4OsoH/b4nTlazrZVrUYVSHGcnv+Jm27f2M0yPw
        +ToyfwLkQghWaj9sG88gHIOebqdiOgHzav5q6kOW62pozQhyLxBdKpDz/0gj8Bk9OfPQVNFRo0B
        gjRkGWJ9PBNjDySjX/jhRQXv4ye0cdwhC+w==
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr6882344otq.66.1588410714312;
        Sat, 02 May 2020 02:11:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJLiTq6gUyODdgfqNCjIw10bI3THwqWvO4oxQVWU0CYh0fn2yoF2NcoXqqFS4wDWkoUL2FJ6BtavDmH/Ikt/7k=
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr6882324otq.66.1588410713918;
 Sat, 02 May 2020 02:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200428125514.2780171-1-omosnace@redhat.com> <20200428125514.2780171-4-omosnace@redhat.com>
 <CAHC9VhSP70QB4A4zjLScK1uGxBUhzHXi9UUVKk0kDoKbJF+PrQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSP70QB4A4zjLScK1uGxBUhzHXi9UUVKk0kDoKbJF+PrQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 2 May 2020 11:11:43 +0200
Message-ID: <CAFqZXNtRazyUY--gSUz+e=0=V6v65oqN-GqHa-HWz0D3sS5SgQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] selinux: prepare for inlining of hashtab functions
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 1, 2020 at 10:33 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Apr 28, 2020 at 8:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Refactor searching and inserting into hashtabs to pave way for
> > converting hashtab_search() and hashtab_insert() to inline functions in
> > the next patch. This will avoid indirect calls and allow the compiler to
> > better optimize individual callers, leading to a drastic performance
> > improvement.
>
> This commit description describes the next patch in the series, and
> some of your motivation, but doesn't really tell me much about this
> patch other than it is a "refactoring".  I need more info here,
> especially considering my comment below.

Yes, the commit message needs some more love... See the clarification below.

>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/conditional.c |   4 +-
> >  security/selinux/ss/conditional.h |   2 +-
> >  security/selinux/ss/hashtab.c     |  44 +++++-----
> >  security/selinux/ss/hashtab.h     |  22 ++---
> >  security/selinux/ss/mls.c         |  23 +++---
> >  security/selinux/ss/policydb.c    | 128 +++++++++++++++++++-----------
> >  security/selinux/ss/policydb.h    |   9 +++
> >  security/selinux/ss/services.c    |  38 ++++-----
> >  security/selinux/ss/symtab.c      |  22 ++++-
> >  security/selinux/ss/symtab.h      |   3 +
> >  10 files changed, 178 insertions(+), 117 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
> > index 31c11511fe10..4885234257d4 100644
> > --- a/security/selinux/ss/hashtab.h
> > +++ b/security/selinux/ss/hashtab.h
> > @@ -13,6 +13,12 @@
> >
> >  #define HASHTAB_MAX_NODES      0xffffffff
> >
> > +struct hashtab_key_params {
> > +       u32 (*hash)(const void *key);   /* hash function */
> > +       int (*cmp)(const void *key1, const void *key2);
> > +                                       /* key comparison function */
> > +};
> > +
> >  struct hashtab_node {
> >         void *key;
> >         void *datum;
> > @@ -23,10 +29,6 @@ struct hashtab {
> >         struct hashtab_node **htable;   /* hash table */
> >         u32 size;                       /* number of slots in hash table */
> >         u32 nel;                        /* number of elements in hash table */
> > -       u32 (*hash_value)(struct hashtab *h, const void *key);
> > -                                       /* hash function */
> > -       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2);
> > -                                       /* key comparison function */
>
> I don't like how you've split the hashing and comparison functions out
> of the hashtab struct and into their own data structure with no
> explicit linkage between the two.  This is a bad design decision in my
> opinion, and something we should try to avoid.

In general, I would totally agree with you, but in this case this is
crucial to avoid the indirect calls. Granted, the commit message fails
to explain this and I need to rewrite it (and the callback separation
probably deserves a comment in the code as well).

The thing is, if you store the callbacks in the hashtab struct, then
any function that didn't also initialize that hashtab has to fetch the
callbacks from the struct and call them indirectly (via something like
"call *%rax" in the case of x86_64, although in practice it will be
something more weird due to Spectre mitigations...). In C, there is no
other way to keep the hashtab generic without forcing the indirect
calls.

Note that rhashtable (see <linux/rhashtable.h>) does exactly the same
thing. When I first saw it, I also thought "what a horrible
interface", until I realized it is necessary to avoid the costly
indirect calls.

I tried to encapsulate the callback structs as much as possible -
symtab has them hidden nicely behind the specialized symtab_insert()
and symtab_search() functions and the other hashtab instances are
encapsulated in policydb.c (inserts are done always in that file and
for lookups I added specialized functions). Although now I realize I
could go one step further and extract all the policydb hashtab-related
code (read, write, lookup, destroy for each type of hashtab except
symtab) into a separate compilation unit (or even each type into its
own?)... The policydb.c file is getting quite big and unwieldy, so I
think it would be a good thing even as a separate patch below the
rest.

Does this alleviate your concerns regarding the design (assuming I
expand the commit message and keep the code using the generic hashtab
functions hidden behind a more high-level interface as suggested
above)?

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

