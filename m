Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B159C432C3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 14:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568AA2073C
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 14:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkExEXp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKOOvK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:51:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41047 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727561AbfKOOvK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 09:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573829469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWGZlZ/TMnVLnOB99qYt76ANzAov/W2PfLYNFn2AD7c=;
        b=NkExEXp561SXtOONrHtGdUv4y3fOErJXYlcp+TS6UZOLI2uKP3rGVYl07+sZQaFrBaIxE6
        k/XFyS2Bb18DpMMh5BpxyQatSY/uvTTRlOOzJ/r+FDgdy3vuNMqpNI/i8H2+I3CbBCfBK3
        d8y1esbb1J/L0pmgDLvF6H2ztOUCuBo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-jXyOEuB5N62Ahztj7T9UUA-1; Fri, 15 Nov 2019 09:50:57 -0500
Received: by mail-oi1-f197.google.com with SMTP id r206so5077926oih.6
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2019 06:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuEfVqdjpO5uHXjyqdTIsfI3JsI4KSvsw1ieKeAi0HA=;
        b=I1bxgvkCejZpvuhaLYy12LBzkTk2Kz7wggoZHXv7HVWy0Qvpztcj1X4/RKFZwOq8WS
         /8AW4bR1oZvamAbq+YJbovID+ElXscvVhcanycBKlkCUvTGQOI0cgIz2HzaYkdIXDAAy
         hP6N6Qz+NYw2v6pJvg604XGWMXxIr+thqqwDkY2aSiD1doU/zQ0WUuMaX6KLVlE8zhSg
         F+exknTqxS6grr60NeezzrwdCQvaLEGeC3reA2Ixu+80VMSCJ09rGBiqH9qFfP/Iig2v
         qTeL9k7+vs9qNexy+Aai1PibDkPjPR9vkuqlrPE+nPVKswocWCY50fidjo900FzQoERG
         RzQQ==
X-Gm-Message-State: APjAAAXI2ayfGa5yXHFbLnrUgh/NQXqtkYxHmyuvuBpzvwssghHic8A4
        P3RfDeY3GRD9/as54KTnnOUlLoyG9Sl9ysNxe6NiL2/padlnKP6UlKnkXdsKHi4Yy+zpqNOLNLK
        wRET+6gvtJp2grgjlMkqwBQ4D0orergPxRA==
X-Received: by 2002:a9d:313:: with SMTP id 19mr11934159otv.197.1573829456394;
        Fri, 15 Nov 2019 06:50:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCtJP5eaEf80ezya450FnIth03LsIbTqtjsVlloZZcLd792F6CkGP9HSXmFamOJv53eqNEYx39EptMqlDOKNk=
X-Received: by 2002:a9d:313:: with SMTP id 19mr11934121otv.197.1573829455868;
 Fri, 15 Nov 2019 06:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20191111154004.1790-1-omosnace@redhat.com> <CAHC9VhSqmHJqxK3xm9Jo+iu7eJao=L6CLpp4UQEGbUGM8puudw@mail.gmail.com>
In-Reply-To: <CAHC9VhSqmHJqxK3xm9Jo+iu7eJao=L6CLpp4UQEGbUGM8puudw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 Nov 2019 15:50:44 +0100
Message-ID: <CAFqZXNvKD16h_T+w8OhAsxJTdr_gLv8B0=LjSmKGKkOLjam3DQ@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: cache the SID -> context string translation
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Sekletar <msekleta@redhat.com>
X-MC-Unique: jXyOEuB5N62Ahztj7T9UUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 15, 2019 at 1:42 AM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Nov 11, 2019 at 10:40 AM Ondrej Mosnacek <omosnace@redhat.com> wr=
ote:
> > Translating a context struct to string can be quite slow, especially if
> > the context has a lot of category bits set. This can cause quite
> > noticeable performance impact in situations where the translation needs
> > to be done repeatedly. A common example is a UNIX datagram socket with
> > the SO_PASSSEC option enabled, which is used e.g. by systemd-journald
> > when receiving log messages via datagram socket. This scenario can be
> > reproduced with:
> >
> >     cat /dev/urandom | base64 | logger &
> >     timeout 30s perf record -p $(pidof systemd-journald) -a -g
> >     kill %1
> >     perf report -g none --pretty raw | grep security_secid_to_secctx
> >
> > Before the caching introduced by this patch, computing the context
> > string (security_secid_to_secctx() function) takes up ~65% of
> > systemd-journald's CPU time (assuming a context with 1024 categories
> > set and Fedora x86_64 release kernel configs). After this patch
> > (assuming near-perfect cache hit ratio) this overhead is reduced to jus=
t
> > ~2%.
> >
> > This patch addresses the issue by caching a certain number (compile-tim=
e
> > configurable) of recently used context strings to speed up repeated
> > translations of the same context, while using only a small amount of
> > memory.
> >
> > The cache is integrated into the existing sidtab table by adding a fiel=
d
> > to each entry, which when not NULL contains an RCU-protected pointer to
> > a cache entry containing the cached string. The cache entries are kept
> > in a linked list sorted according to how recently they were used. On a
> > cache miss when the cache is full, the least recently used entry is
> > removed to make space for the new entry.
> >
> > The patch migrates security_sid_to_context_core() to use the cache (als=
o
> > a few other functions where it was possible without too much fuss, but
> > these mostly use the translation for logging in case of error, which is
> > rare).
> >
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1733259
> > Cc: Michal Sekletar <msekleta@redhat.com>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > Changes in v4:
> >  - use rcu_dereference_protected() instead of rcu_dereference_raw() in
> >    sidtab_sid2str_put()
> >  - fix typo in comment
> >  - remove unnecessary rcu_head_init() call
> >
> > Changes in v3:
> >  - add rcu@vger.kernel.org and Paul McKenney to Cc for review of the RC=
U
> >    logic
> >  - add __rcu annotation to the cache entry pointer (sidtab.c now passes
> >    sparse checks with C=3D1)
> >
> > Changes in v2:
> >  - skip sidtab_sid2str_put() when in non-task context to prevent
> >    deadlock while avoiding the need to lock the spinlock with
> >    irqsave/-restore (which is slower)
> >
> >  security/selinux/Kconfig       |  11 ++
> >  security/selinux/ss/services.c | 138 +++++++++++++++----------
> >  security/selinux/ss/sidtab.c   | 179 +++++++++++++++++++++++++++------
> >  security/selinux/ss/sidtab.h   |  58 +++++++++--
> >  4 files changed, 294 insertions(+), 92 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.=
c
> > index 7d49994e8d5f..6d6ce1c43b49 100644
> > --- a/security/selinux/ss/sidtab.c
> > +++ b/security/selinux/ss/sidtab.c
> > @@ -492,3 +528,88 @@ void sidtab_destroy(struct sidtab *s)
> >
> >         sidtab_destroy_tree(s->roots[level], level);
> >  }
> > +
> > +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> > +
> > +void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
> > +                       const char *str, u32 str_len)
> > +{
> > +       struct sidtab_str_cache *cache, *victim;
> > +
> > +       /* do not cache invalid contexts */
> > +       if (entry->context.len)
> > +               return;
> > +
> > +       /*
> > +        * Skip the put operation when in non-task context to avoid the=
 need
> > +        * to disable interrupts while holding s->cache_lock.
> > +        */
> > +       if (!in_task())
> > +               return;
> > +
> > +       spin_lock(&s->cache_lock);
> > +
> > +       cache =3D rcu_dereference_protected(entry->cache,
> > +                                         lockdep_is_held(&s->cache_loc=
k));
> > +       if (cache) {
> > +               /* entry in cache - just bump to the head of LRU list *=
/
> > +               list_move(&cache->lru_member, &s->cache_lru_list);
> > +               goto out_unlock;
> > +       }
> > +
> > +       cache =3D kmalloc(sizeof(struct sidtab_str_cache) + str_len, GF=
P_ATOMIC);
> > +       if (!cache)
> > +               goto out_unlock;
> > +
> > +       if (s->cache_free_slots =3D=3D 0) {
> > +               /* pop a cache entry from the tail and free it */
> > +               victim =3D container_of(s->cache_lru_list.prev,
> > +                                     struct sidtab_str_cache, lru_memb=
er);
> > +               list_del(&victim->lru_member);
> > +               kfree_rcu(victim, rcu_member);
>
> We could move the kfree_rcu() down to after we drop the spinlock,
> right?  It's likely not a big deal, but since the whole point of this
> patch is performance improvements it seems like it might be nice. ;)

I could be wrong, but I think kfree_rcu() just (always?) appends the
object to the RCU list and defers the deallocation for later (and that
should be pretty quick). But actually... since the kfree_rcu() is not
called under RCU read lock here, I should at least move it below the
next line, which still dereferences "victim". And at that point I
could move it all the way after spin_unlock() as you suggest...

>
> > +               rcu_assign_pointer(victim->parent->cache, NULL);
> > +       } else {
> > +               s->cache_free_slots--;
> > +       }
> > +       cache->parent =3D entry;
> > +       cache->len =3D str_len;
> > +       memcpy(cache->str, str, str_len);
> > +       list_add(&cache->lru_member, &s->cache_lru_list);
> > +
> > +       rcu_assign_pointer(entry->cache, cache);
> > +
> > +out_unlock:
> > +       spin_unlock(&s->cache_lock);
> > +}
>
> --
> paul moore
> www.paul-moore.com

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

