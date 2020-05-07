Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BF7C38A2A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 09:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280C02078C
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 09:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avZeKDAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgEGJUN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 05:20:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43040 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEGJUN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 05:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588843210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mWFtzsY7wOFxFtrOWbpfn76WolldT4STR5IqvxShk9Y=;
        b=avZeKDAIQhHAJxYExYm1EvN0WlLWG14ZUXEYdkWAs/Q38jT2e+WJ1tDPlu6fNejCAb/HZH
        h/AqAENnb6JEGnG/2Gugl2QTozRExQefdnDOFksVKhSAP1HLmbfMy7Kg7nVY1bTYWazRjA
        K53uj7CT2vqmIzs+ec30SxWMjFU3AIE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-qwq6GYemMPO3q2kqN2BqGA-1; Thu, 07 May 2020 05:20:09 -0400
X-MC-Unique: qwq6GYemMPO3q2kqN2BqGA-1
Received: by mail-oo1-f69.google.com with SMTP id t23so3197339oor.1
        for <selinux@vger.kernel.org>; Thu, 07 May 2020 02:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWFtzsY7wOFxFtrOWbpfn76WolldT4STR5IqvxShk9Y=;
        b=QzGfe1U4Yn5/IYTowKO6RU2rAVPjRG/ENVOzF9nBEWhejVe0Fsl/is/0dPXTgqoD4n
         Gea0pqGXjNaUwCLdp3CXqjYe2rU3SYLNKnr6KQC1FFplo8gvjQKYeK0LllmFNRdPf/wl
         SKPawNBo0bphKgxOK+fhp14nAHSZ7vJa5h8cri1iJuQ1a987Y35+wRY1+F83Njwm7jEW
         e/Hxd+AQy5ccAPV1RWqGhkn6pgbFGpXe/6ijUIag/sFgPqO7qshRdqvDCqf3Wv5myuKi
         fzSg1GxZhQfKuO3HM3rrhyDJTk4qHzriFepWaK8BMnx1Qdedq6ZNwt2sUl3+SWsHFEOS
         6QTw==
X-Gm-Message-State: AGi0PuaGw+Zlq/4xZ6rdEcsFKoI6mFpVMhxWD2wx+Hqz+J3xPC5HrUc0
        +SLihCKiQ8yvjF5jGl977m8/NN9r/pRuIJdr8zh9xhDace/yt+19vt5L3i5Lno3btiFdtJJykzZ
        J/piW/B+kGjkc5y6d0Q98q6EvdpW46LYsNw==
X-Received: by 2002:a4a:7011:: with SMTP id r17mr10725666ooc.17.1588843207435;
        Thu, 07 May 2020 02:20:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ9p3d6g7PsNsvtbdZybTkSkdCFJl4JqLePCteMnIAAzMjlXGn8SmTE4aoGfiF8VtEtA7eSfJeAh6mlNFXLKw8=
X-Received: by 2002:a4a:7011:: with SMTP id r17mr10725653ooc.17.1588843207088;
 Thu, 07 May 2020 02:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200504115923.88828-1-omosnace@redhat.com> <20200504115923.88828-3-omosnace@redhat.com>
 <CAHC9VhTbTTT4otsEWRPrPewz2j5FEJHODr8N0efG+cX7vph0Hg@mail.gmail.com>
In-Reply-To: <CAHC9VhTbTTT4otsEWRPrPewz2j5FEJHODr8N0efG+cX7vph0Hg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 May 2020 11:19:56 +0200
Message-ID: <CAFqZXNt2axWdwy9PP6tMzB4QwBH-7bCHKiXPGeVYPLLJx9b9rw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selinux: prepare for inlining of hashtab functions
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 5, 2020 at 1:34 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, May 4, 2020 at 7:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Refactor searching and inserting into hashtabs to pave way for
> > converting hashtab_search() and hashtab_insert() to inline functions in
> > the next patch. This will avoid indirect calls and allow the compiler to
> > better optimize individual callers, leading to a drastic performance
> > improvement.
> >
> > In order to avoid the indirect calls, the key hashing and comparison
> > callbacks need to be extracted from the hashtab struct and passed
> > directly to hashtab_search()/_insert() by the callers so that it is
> > always known which callbacks we want to call at compile time. Note that
> > the kernel's rhashtable library (<linux/rhashtable*.h>) also does the
> > same.
> >
> > This of course makes the hashtab functions more easy to misuse by
> > passing a wrong calback set, but unfortunately there is no better way to
> > implement a hash table that is both generic and efficient in C. This
> > patch tries to somewhat mitigate this by only calling the hashtab
> > functions in the same file where the corresponding callbacks are
> > defined (wrapping them into more specialized functions as needed).
> >
> > Note that this patch doesn't bring any benefit without also defining
> > hashtab_search() and -_insert() inline, which is done in a follow-up
> > patch to make it easier to review the hashtab.c changes here.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/hashtab.c  | 44 ++++++++++----------
> >  security/selinux/ss/hashtab.h  | 22 +++++-----
> >  security/selinux/ss/mls.c      |  2 +-
> >  security/selinux/ss/policydb.c | 76 ++++++++++++++++++++++++----------
> >  security/selinux/ss/policydb.h |  9 ++++
> >  security/selinux/ss/services.c |  4 +-
> >  security/selinux/ss/symtab.c   | 16 ++++---
> >  7 files changed, 110 insertions(+), 63 deletions(-)
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
> >  };
>
> I remain concerned that in the process of chasing performance this
> patchset makes the code worse and more fragile.
>
> What if we took a slightly different approach such that instead of
> breaking apart hashtab_node we moved the variable portions (htable,
> size, nel) into a separate struct which we could reference in
> hashtab_node?  For example:
>
>   struct hashtab_var {
>     struct hashtab_node **htable;
>     u32 size;
>     u32 nel;
>   }
>
>   struct hashtab {
>     struct hashtab_var *table; // adds an extra ptr deref
>     u32 (*hash_value)(...);
>     int (*keycmp)(...);
>   }
>
> I might be mistaken, but I believe this should still allow you to
> implement the inlining/pass-by-value tricks for search and insert
> while maintaining a binding between the hashtable data and
> hash/compare functions.  Yes?  Or does the entire struct need to be
> declared as a static const for the compiler optimizations to work?  It
> is not clear to me from the commit descriptions or comments in the
> code.

No, that wouldn't work. For example: when compiling a
hashtab_search(&policydb->some_hashtab, ...) call (let's assume it's
defined inline already) inside a function that takes policydb as an
argument, the compiler has no way of knowing what functions you
stashed into hash_value and keycmp in some different function, so it
has to load the pointers from memory and call them. It needs to know
what the functions are right there if it is to generate a direct
constant-address call (or inline them). In C you simply can't
associate functions (data) to types. In C++ this would be easily done
with templates, but the kernel isn't written in C++, so you simply
have to get (somewhat) dirty to get efficient code.

How about if I moved all the 4 hashtab types into a common compilation
unit (policydb_tables.[hc]?) and hid the unsafe generic hashtab
building blocks inside the C file? The header would then only expose
struct hashtab and provide specific functions for each type of
hashtab. And each hashtab "subclass" could be a separate type (which
would just wrap struct hashtab in another struct), which would be even
more type safe than the current state. Let me try to put it into a
patch, where it will be easier to see what I mean...

>
> As far as testing is concerned, whenever possible it is better to show
> performance improvements in the context of some sort of user workload
> and not an artificial stress test or micro benchmark.  I understand
> that such focused tests can be attractive both in terms of their
> results and ease of use, but they can also be very misleading.
> Performance improvements for things like policy loads, kernel
> compiles, etc. are much more interesting to me than results from
> running something like stress-ng.

OK, I'll try to make my case on some more realistic benchmark.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

