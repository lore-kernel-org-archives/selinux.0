Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC7AC432C3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93B02072A
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Q9zs6O59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfKOPhG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:37:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37119 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfKOPhG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 10:37:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id d5so11148128ljl.4
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2019 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4CS/Wze+L8OwF05/nD8VCaricfA1ZEuBlqqqQ5obWM=;
        b=Q9zs6O59rpnfXObvdCaCTcp0jZWgC6Byu/VVbmKONCMw6kxvtDRi59knKfKa2BR2Ik
         DeWfbmyVQKEyBgJSM94GvDaU4o4VtWcBCvi/dL0/JVIApoWqUdf0v/eU5rkvrsd5YhKX
         O7Kdzl5NicrqKHO1GJEPDS3LLdUzvcSN+ernXIr/YeIPd7j7cZ+jFq3fD7dpXr992fDW
         nF2wZhdunNQ6OGqp55Wf5E9rXYpE3v4YInxE4IebCj+fG3jCV+IjCfd5QFO9dLQDQU0m
         EL+KQx92o/Pco6xjP5YTiooqRt/5AWZieoIz9PSygRf+uJ8N4A1/qF4fJt0mvXITKhYT
         1aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4CS/Wze+L8OwF05/nD8VCaricfA1ZEuBlqqqQ5obWM=;
        b=DDf/SqNAI1QXa+eY4Ic0Z44NBEN0NMBg1p6iJ3vmpAqd0RYESHPa28pknd5hf7muvx
         lY7mxhYmXGBMZbhrU3vq6PMvcAh5lyGyWiWPp+ttuvYA6rutiSVsW+u6FVagyOVTKkjY
         eC8wCG65JspeaKwq6jSnIAbaVCf0O4AUxtDjbBwV+SYowzu2WqDOH4K0xqKsj9xPC43h
         KSt40KwSpPiExoaWMUbMYgP0klsWmXAnmqZAQcSxNs4EoZ/hxlBDRjNmwQUYkMLwRBuK
         GqB6IyMNczpvjfs9v6I2Df+pwq34PiCxZIfrrmQvSDOFJoEnTujLdMsyy+YF7w8+fStn
         zpvg==
X-Gm-Message-State: APjAAAUyfyAxIf235Hpdjj4T2nPGCsRGHpTDtiqdNtS0wt2bM0D/7gUe
        l2nCYeSa3M4wO7oBffBW1vcpYKUasIlUx7XrvptC
X-Google-Smtp-Source: APXvYqzr/hwcxkX0NSjaY/7tIWxLNyeVio/tuoykAuHnars5P0RDd5TzNDSkKTC0kUUBfe38PGz0lQIoRJ9fdJbJRio=
X-Received: by 2002:a2e:95c5:: with SMTP id y5mr11909602ljh.184.1573832223224;
 Fri, 15 Nov 2019 07:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20191111154004.1790-1-omosnace@redhat.com> <CAHC9VhSqmHJqxK3xm9Jo+iu7eJao=L6CLpp4UQEGbUGM8puudw@mail.gmail.com>
 <CAFqZXNvKD16h_T+w8OhAsxJTdr_gLv8B0=LjSmKGKkOLjam3DQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvKD16h_T+w8OhAsxJTdr_gLv8B0=LjSmKGKkOLjam3DQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Nov 2019 10:36:52 -0500
Message-ID: <CAHC9VhTGYWs+k2vRYFnHU7-mUXfDDop7CGaKAthv4Gds0A54zw@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: cache the SID -> context string translation
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 15, 2019 at 9:50 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Nov 15, 2019 at 1:42 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Nov 11, 2019 at 10:40 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > Translating a context struct to string can be quite slow, especially if
> > > the context has a lot of category bits set. This can cause quite
> > > noticeable performance impact in situations where the translation needs
> > > to be done repeatedly. A common example is a UNIX datagram socket with
> > > the SO_PASSSEC option enabled, which is used e.g. by systemd-journald
> > > when receiving log messages via datagram socket. This scenario can be
> > > reproduced with:
> > >
> > >     cat /dev/urandom | base64 | logger &
> > >     timeout 30s perf record -p $(pidof systemd-journald) -a -g
> > >     kill %1
> > >     perf report -g none --pretty raw | grep security_secid_to_secctx
> > >
> > > Before the caching introduced by this patch, computing the context
> > > string (security_secid_to_secctx() function) takes up ~65% of
> > > systemd-journald's CPU time (assuming a context with 1024 categories
> > > set and Fedora x86_64 release kernel configs). After this patch
> > > (assuming near-perfect cache hit ratio) this overhead is reduced to just
> > > ~2%.
> > >
> > > This patch addresses the issue by caching a certain number (compile-time
> > > configurable) of recently used context strings to speed up repeated
> > > translations of the same context, while using only a small amount of
> > > memory.
> > >
> > > The cache is integrated into the existing sidtab table by adding a field
> > > to each entry, which when not NULL contains an RCU-protected pointer to
> > > a cache entry containing the cached string. The cache entries are kept
> > > in a linked list sorted according to how recently they were used. On a
> > > cache miss when the cache is full, the least recently used entry is
> > > removed to make space for the new entry.
> > >
> > > The patch migrates security_sid_to_context_core() to use the cache (also
> > > a few other functions where it was possible without too much fuss, but
> > > these mostly use the translation for logging in case of error, which is
> > > rare).
> > >
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1733259
> > > Cc: Michal Sekletar <msekleta@redhat.com>
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > Changes in v4:
> > >  - use rcu_dereference_protected() instead of rcu_dereference_raw() in
> > >    sidtab_sid2str_put()
> > >  - fix typo in comment
> > >  - remove unnecessary rcu_head_init() call
> > >
> > > Changes in v3:
> > >  - add rcu@vger.kernel.org and Paul McKenney to Cc for review of the RCU
> > >    logic
> > >  - add __rcu annotation to the cache entry pointer (sidtab.c now passes
> > >    sparse checks with C=1)
> > >
> > > Changes in v2:
> > >  - skip sidtab_sid2str_put() when in non-task context to prevent
> > >    deadlock while avoiding the need to lock the spinlock with
> > >    irqsave/-restore (which is slower)
> > >
> > >  security/selinux/Kconfig       |  11 ++
> > >  security/selinux/ss/services.c | 138 +++++++++++++++----------
> > >  security/selinux/ss/sidtab.c   | 179 +++++++++++++++++++++++++++------
> > >  security/selinux/ss/sidtab.h   |  58 +++++++++--
> > >  4 files changed, 294 insertions(+), 92 deletions(-)
> >
> > ...
> >
> > > diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> > > index 7d49994e8d5f..6d6ce1c43b49 100644
> > > --- a/security/selinux/ss/sidtab.c
> > > +++ b/security/selinux/ss/sidtab.c
> > > @@ -492,3 +528,88 @@ void sidtab_destroy(struct sidtab *s)
> > >
> > >         sidtab_destroy_tree(s->roots[level], level);
> > >  }
> > > +
> > > +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> > > +
> > > +void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
> > > +                       const char *str, u32 str_len)
> > > +{
> > > +       struct sidtab_str_cache *cache, *victim;
> > > +
> > > +       /* do not cache invalid contexts */
> > > +       if (entry->context.len)
> > > +               return;
> > > +
> > > +       /*
> > > +        * Skip the put operation when in non-task context to avoid the need
> > > +        * to disable interrupts while holding s->cache_lock.
> > > +        */
> > > +       if (!in_task())
> > > +               return;
> > > +
> > > +       spin_lock(&s->cache_lock);
> > > +
> > > +       cache = rcu_dereference_protected(entry->cache,
> > > +                                         lockdep_is_held(&s->cache_lock));
> > > +       if (cache) {
> > > +               /* entry in cache - just bump to the head of LRU list */
> > > +               list_move(&cache->lru_member, &s->cache_lru_list);
> > > +               goto out_unlock;
> > > +       }
> > > +
> > > +       cache = kmalloc(sizeof(struct sidtab_str_cache) + str_len, GFP_ATOMIC);
> > > +       if (!cache)
> > > +               goto out_unlock;
> > > +
> > > +       if (s->cache_free_slots == 0) {
> > > +               /* pop a cache entry from the tail and free it */
> > > +               victim = container_of(s->cache_lru_list.prev,
> > > +                                     struct sidtab_str_cache, lru_member);
> > > +               list_del(&victim->lru_member);
> > > +               kfree_rcu(victim, rcu_member);
> >
> > We could move the kfree_rcu() down to after we drop the spinlock,
> > right?  It's likely not a big deal, but since the whole point of this
> > patch is performance improvements it seems like it might be nice. ;)
>
> I could be wrong, but I think kfree_rcu() just (always?) appends the
> object to the RCU list and defers the deallocation for later (and that
> should be pretty quick). But actually... since the kfree_rcu() is not
> called under RCU read lock here, I should at least move it below the
> next line, which still dereferences "victim". And at that point I
> could move it all the way after spin_unlock() as you suggest...

Yes, the bulk of the work is handled later once it is safe to free the
memory, but that doesn't mean work doesn't still happen :)

It's definitely a nitpicky thing, but since we are already at -rc7 and
this isn't a bug-fix, this was always going to land in selinux/next
after the upcoming merge window so we've got time for a respin.

-- 
paul moore
www.paul-moore.com
