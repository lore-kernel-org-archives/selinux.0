Return-Path: <SRS0=VtUM=YX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6702DCA9EC5
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 20:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA7520659
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 20:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DUmJT/lN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfJ3Uss (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:48:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36614 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfJ3Uss (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Oct 2019 16:48:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so4226913ljj.3
        for <selinux@vger.kernel.org>; Wed, 30 Oct 2019 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zx0z/HygcI0gb+8rJhIfehQBjfDgYIR60eTMqcd5G8=;
        b=DUmJT/lNyHR8ivOLSeG4kvqG0kIMz0pJ90AIqvTOKe2zOK3aki1cnlhQ0MSwk6qrmP
         NvpdCC0wKPuDhT8LgfenZqWxi6NAyMi+I7hiuBiLqxfgsgY72dnJga2JuqAguK/MisF8
         CyCuvOPlhJI1nNF6Hk1sU2ez530q4fIbWeFJLg6r5nompfJvQ6bpfcgBjx8cyvsdvwMV
         4vsaOVC/pZrG5dLVgWukRfPci19LRqPIwOCI0pjHEc86Gh7ExtBT/Xup1JA4GlMDVZEz
         xkdVombYXHpXPlEnGBKvN9G6YPF9wIVJddIBwIs6c9x8U7kWyS4gOHQzX3kTFNswsLpR
         R2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zx0z/HygcI0gb+8rJhIfehQBjfDgYIR60eTMqcd5G8=;
        b=FtsN3RT+PTh8YIsAwdKfSDTpc+gwh/5pJnQKGseo3ckXcd+uMtEc6rdGCE8oim0epQ
         1KUuqnsPb0uKIME2/3gnKMN7oLuE53+r4e5mjOBsiojb/S0n5FLfSfrNcCkq8yKtyjtO
         Zo+6crnLkuZz6yBAuACifV800sVaV8+lBJNWdwck+THaFocl2+SX0s353gU6F4Rp+qZU
         ZCDhTkDa3XUQDZR036NWHosAg7iOpI+CO4hw0xKYuTPYdAtP0gnELhFMg94SF/4cMHGl
         el/hKDerNimyes1YFp3Vt/tkx8EfCMMFJ1Lycrp+ilrhiNOvHOaSZBvfijD2fjmZGk9N
         vp+g==
X-Gm-Message-State: APjAAAWxqsGjG/vNiuZ2w2li0dMOD3Swuu7pQM4gU26QEgRFULxDuSiO
        7WMyYsz8khkthxU27oQk2ttHuTUmQ15P56QnuMfv
X-Google-Smtp-Source: APXvYqw2NtwVG+Wy0DCJznH4UM/V49bsaY0MPJVz969JXQkRZSCoEQboO9fCAHqd6AZhaD2gXzAkuGFhOEsrM0bd9Zo=
X-Received: by 2002:a2e:58d:: with SMTP id 135mr1111155ljf.57.1572468524347;
 Wed, 30 Oct 2019 13:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191030101949.191788-1-jeffv@google.com> <5045a962-36e1-d7d0-2750-10e55c01975e@tycho.nsa.gov>
 <CABXk95B-woFimHCv3RuUdSJvEQ4C_KGvsT=qAQ6kup+eYov65w@mail.gmail.com>
 <7cc2b7c7-9f79-96e3-eccf-6661e7a51291@tycho.nsa.gov> <CABXk95CLsQx9gaQn+QxpuU5aj4mVCK5V9Y1ZeYhhsYk_-c5q_g@mail.gmail.com>
 <ef2bc55e-06d1-f8e7-1e73-e5afc6e50c02@tycho.nsa.gov> <CABXk95Di-Fz=Wao+4muid_dSMJ+jm19a3sgR8fddRbrx0iSvSQ@mail.gmail.com>
In-Reply-To: <CABXk95Di-Fz=Wao+4muid_dSMJ+jm19a3sgR8fddRbrx0iSvSQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Oct 2019 16:48:33 -0400
Message-ID: <CAHC9VhSMmkCWhVihL9Po==+tMYnnH17Yinni_vZb_W8ev4s6fw@mail.gmail.com>
Subject: Re: [PATCH] selinux: sidtab: reverse lookup hash table
To:     Jeffrey Vander Stoep <jeffv@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>,
        Jovana Knezevic <jovanak@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 30, 2019 at 4:06 PM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> On Wed, Oct 30, 2019 at 9:02 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 10/30/19 3:07 PM, Jeffrey Vander Stoep wrote:
> > > On Wed, Oct 30, 2019 at 7:57 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >>
> > >> On 10/30/19 2:33 PM, Jeffrey Vander Stoep wrote:
> > >>> On Wed, Oct 30, 2019 at 7:06 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >>>>
> > >>>> On 10/30/19 6:19 AM, Jeff Vander Stoep wrote:
> > >>>>> This replaces the reverse table lookup and reverse cache with a
> > >>>>> hashtable which improves cache-miss reverese-lookup times from
> > >>>>> O(n) to O(1) and maintains the same performance as a reverse
> > >>>>> cache hit.
> > >>>>>
> > >>>>> This reduces the time needed to add a new sidtab entry from ~500us
> > >>>>> to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
> > >>>>>
> > >>>>> The implementation uses the kernel's generic hashtable API,
> > >>>>> It uses the context's string represtation as the hash source,
> > >>>>> and the kernels generic string hashing algorithm full_name_hash()
> > >>>>> to reduce the string to a 32 bit value.
> > >>>>>
> > >>>>> This change also maintains the improvement introduced in commit
> > >>>>> ee1a84fd which removed the need to keep the current sidtab locked
> > >>>>> during policy reload. It does however introduce periodic locking of
> > >>>>> the target sidtab while converting the hashtable. Sidtab entries
> > >>>>> are never modified or removed, so the context struct stored in the
> > >>>>> sid_to_context tree can also be used for the context_to_sid
> > >>>>> hashtable to reduce memory usage.
> > >>>>>
> > >>>>> This bug was reported by:
> > >>>>> - Stephen Smally on the selinux bug tracker.
> > >>>>>      BUG: kernel softlockup due to too many SIDs/contexts #37
> > >>>>>      https://github.com/SELinuxProject/selinux-kernel/issues/37
> > >>>>> - Jovana Knezevic on Android's bugtracker.
> > >>>>>      Bug: 140252993
> > >>>>>      "During multi-user performance testing, we create and remove users
> > >>>>>      many times. selinux_android_restorecon_pkgdir goes from 1ms to over
> > >>>>>      20ms after about 200 user creations and removals. Accumulated over
> > >>>>>      ~280 packages, that adds a significant time to user creation,
> > >>>>>      making perf benchmarks unreliable."
> > >>>>>
> > >>>>> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> > >>>>> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> > >>>>> Reported-by: Jovana Knezevic <jovanak@google.com>
> > >>>>> ---
> > >>>>>     security/selinux/include/security.h |   1 +
> > >>>>>     security/selinux/selinuxfs.c        |  27 +++
> > >>>>>     security/selinux/ss/context.h       |   9 +
> > >>>>>     security/selinux/ss/policydb.c      |   5 +
> > >>>>>     security/selinux/ss/services.c      |  81 +++++---
> > >>>>>     security/selinux/ss/services.h      |   4 +-
> > >>>>>     security/selinux/ss/sidtab.c        | 283 ++++++++++++++++------------
> > >>>>>     security/selinux/ss/sidtab.h        |  20 +-
> > >>>>>     8 files changed, 283 insertions(+), 147 deletions(-)

...

> > >>>>> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> > >>>>> index 7d49994e8d5f..e4710f32b6d9 100644
> > >>>>> --- a/security/selinux/ss/sidtab.c
> > >>>>> +++ b/security/selinux/ss/sidtab.c
> > >>>>> @@ -23,23 +23,32 @@ int sidtab_init(struct sidtab *s)
> > >>>>>
> > >>>>>         memset(s->roots, 0, sizeof(s->roots));
> > >>>>>
> > >>>>> -     /* max count is SIDTAB_MAX so valid index is always < SIDTAB_MAX */
> > >>>>> -     for (i = 0; i < SIDTAB_RCACHE_SIZE; i++)
> > >>>>> -             s->rcache[i] = SIDTAB_MAX;
> > >>>>> -
> > >>>>>         for (i = 0; i < SECINITSID_NUM; i++)
> > >>>>>                 s->isids[i].set = 0;
> > >>>>>
> > >>>>>         s->count = 0;
> > >>>>>         s->convert = NULL;
> > >>>>> +     hash_init(s->context_to_sid);
> > >>>>>
> > >>>>>         spin_lock_init(&s->lock);
> > >>>>>         return 0;
> > >>>>>     }
> > >>>>>
> > >>>>> +static u32 context_to_sid(struct sidtab *s, struct context *context)
> > >>>>> +{
> > >>>>> +     struct sidtab_node *node;
> > >>>>> +
> > >>>>> +     hash_for_each_possible(s->context_to_sid, node, list, context->hash) {
> > >>>>
> > >>>> Is this safe without any locking or any kind of memory barrier pair to
> > >>>> deal with hash_add() calls?
> > >>>
> > >>> My understanding is that it is because hlist_add_head is written to be
> > >>> safe for this type of lockless access.
> > >>>
> > >>> It performs all modifications on the new node first and only then uses
> > >>> WRITE_ONCE() to write the list head's ->next pointer atomically and prevent
> > >>> reordering.
> > >>>
> > >>> (similar explanation here: https://lore.kernel.org/patchwork/patch/624316/)
> > >>>
> > >>> "Code that does lockless emptiness testing of non-RCU lists is relying
> > >>> on INIT_LIST_HEAD() to write the list head's ->next pointer atomically,
> > >>> particularly when INIT_LIST_HEAD() is invoked from list_del_init().
> > >>> This commit therefore adds WRITE_ONCE() to this function's pointer stores
> > >>> that could affect the head's ->next pointer."
> > >>
> > >> Wondering if we still need at least a write barrier in the code that
> > >> adds a node prior to hash_add() to ensure the node contents are sane.
> > >
> > > I'm not sure what you mean. Are you concerned about compiler reordering?
> >
> > Compiler or processor.  Are we guaranteed that node->sid and
> > node->context are sane before the node is visible to the readers?  The
> > old sidtab code (before Ondrej's rewrite) used to issue a full wmb()
> > after setting the node->sid, node->context, and node->next prior to
> > linking the node into the list.
>
> Got it, thanks. I'll look into that and include it in v2 if necessary.

I'm trying to get caught up after being away for a bit on vacation,
but after skimming this thread it sounds like a v2 is necessary.

Also - and completely unrelated to the code changes - can people start
putting some more care into trimming their email replies?  It can be
painful to scroll through big patches looking for the actual comments,
and the chance of missing something important can be high.

-- 
paul moore
www.paul-moore.com
