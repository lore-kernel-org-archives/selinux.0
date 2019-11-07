Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B558C5DF60
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5B72178F
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aq3c+Du0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfKGPuD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:50:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44119 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfKGPuD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 10:50:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id v4so1951875lfd.11
        for <selinux@vger.kernel.org>; Thu, 07 Nov 2019 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ealE5IDrokN6tNhse4AWckUTip5W+G2y/QXtr6U0vg=;
        b=Aq3c+Du0oS4JEKRHQnP8crDI4jSMdaYqETyJX6dVIhqMyg2GDblWZD+epdDADCTsNK
         mMv9NvI+ROgSioSw1BbswJrbgfD64fq35qZQou+AofYr3rgKQ9R977IuVS+zJ7ktqGgv
         aWop/AlhAnCE8kh12R92ph7yXYrbrzio8DGFuj7CZanMJJdyzZYNakn4heX4+VYeTI0C
         h9mK6+CM5Q1T5kKzhadt+9UkCVonKwiYwX0dfDwtmi6bBgAW7E17B8f7vOJ2fBnGewCb
         scSMMnr12eTZVMwgBISJpSJS5EDtVnBEcY8scCOlA8QPhd7+CCe2nZMfuvxwdeqOaEN+
         5bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ealE5IDrokN6tNhse4AWckUTip5W+G2y/QXtr6U0vg=;
        b=VtfHZhy+VZ1GOH+F86TJKeUiPrun0/BlTTX1qDqnMuWPfD1arqkiALAxBGe7I+26Ow
         Uvb9Rmq2kKkhRppP2KpjgA6YTd/4Yjndin0x9l9OMlKlXEk87kUmIeNF6iBDHVq08Y2O
         cpr+11f9ER48iIw/ZyqQs5dplCfRgeuInqi5idiOc14VQQpPkZ3Fwf3QEjSeL1eIDLHB
         TaUW0tqck588GaTqxuosR2YgjKxlcA0hd4f0jdc9zrZM2chXnJG3ei9bUHpLbyZY2UZX
         I5Spzo1IPHl3hLyqihHfjNJlOQ50kVcTrgus1qKxpH/DdMiPyacbN/RDOw7aox1GHBD4
         veNw==
X-Gm-Message-State: APjAAAVODpCi8tkv2s03SMfLXEN13nRtaQ9arKvhdU8GBot7Ehr/LZTB
        TAnxrhT7C2IGWfa4qzV7JGUHp+wwZ0HfIitHxqePtfbElOQ=
X-Google-Smtp-Source: APXvYqzltPNl0oaMmwXkUtKxRy2w5OKOAVptLHnhn0chEtPBGHhbjgPgT0Ej1A/MVjqJc8IVJh9ZZdhTwlZ7iT/5srE=
X-Received: by 2002:a19:fc1c:: with SMTP id a28mr2867395lfi.170.1573141799809;
 Thu, 07 Nov 2019 07:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20191107101743.203699-1-jeffv@google.com> <9b0959ff-93be-9086-063e-5403accabc8e@tycho.nsa.gov>
In-Reply-To: <9b0959ff-93be-9086-063e-5403accabc8e@tycho.nsa.gov>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Thu, 7 Nov 2019 16:49:48 +0100
Message-ID: <CABXk95CvEZWNrj48JNKGZS5aF=GgmQRki=igWo7yAEq81mWWig@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: sidtab: reverse lookup hash table
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>, will@kernel.org,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 7, 2019 at 3:54 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 11/7/19 5:17 AM, Jeff Vander Stoep wrote:
> > This replaces the reverse table lookup and reverse cache with a
> > hashtable which improves cache-miss reverse-lookup times from
> > O(n) to O(1)* and maintains the same performance as a reverse
> > cache hit.
> >
> > This reduces the time needed to add a new sidtab entry from ~500us
> > to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
> >
> > The implementation uses the kernel's generic hashtable API,
> > It uses the context's string represtation as the hash source,
> > and the kernels generic string hashing algorithm full_name_hash()
> > to reduce the string to a 32 bit value.
> >
> > This change also maintains the improvement introduced in
> > commit ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> > performance") which removed the need to keep the current sidtab
> > locked during policy reload. It does however introduce periodic
> > locking of the target sidtab while converting the hashtable. Sidtab
> > entries are never modified or removed, so the context struct stored
> > in the sid_to_context tree can also be used for the context_to_sid
> > hashtable to reduce memory usage.
> >
> > This bug was reported by:
> > - On the selinux bug tracker.
> >    BUG: kernel softlockup due to too many SIDs/contexts #37
> >    https://github.com/SELinuxProject/selinux-kernel/issues/37
> > - Jovana Knezevic on Android's bugtracker.
> >    Bug: 140252993
> >    "During multi-user performance testing, we create and remove users
> >    many times. selinux_android_restorecon_pkgdir goes from 1ms to over
> >    20ms after about 200 user creations and removals. Accumulated over
> >    ~280 packages, that adds a significant time to user creation,
> >    making perf benchmarks unreliable."
> >
> > * Hashtable lookup is only O(1) when n < the number of buckets.
> >
> > Changes in V2:
> > -The hashtable uses sidtab_entry_leaf objects directly so these
> > objects are shared between the sid_to_context lookup tree and the
> > context_to_sid hashtable. This simplifies memory allocation and
> > was suggested by Ondrej Mosnacek.
> > -The new sidtab hash stats file in selinuxfs has been moved out of
> > the avc dir and into a new "ss" dir.
> >
> > V3:
> > -Add lock nesting notation.
> >
> > V4:
> > -Moved to *_rcu variants of the various hashtable functions
> > as suggested by Ondrej Mosnacek and Will Deacon.
> > -Naming/spelling fixups.
>
> This still triggers a splat for me in running Ondrej's reproducer (also
> ran selinux-testsuite first, not sure if that mattered):

Sorry, I am unable to reproduce this using Ondrej's reproducer. :(

I am sharing the same "flags" variable between the nested locks. That seems like
a bug. Anyway, based on Ondrej's reply I'll go with a different
approach and keep
the current sidtab locked.

>
> SELinux:  Converting 3784 SID table entries...
> kernel: ------------[ cut here ]------------
> syscall 1 left IRQs disabled
> WARNING: CPU: 1 PID: 8313 at arch/x86/entry/common.c:261
> syscall_return_slowpathModules linked in: crypto_user
> scsi_transport_iscsi xt_multiport bluetooth ecdh_kernel:  crc32_pclmul
> snd_hda_codec snd_hwdep snd_hda_core ghash_clmulni_intel sCPU: 1 PID:
> 8313 Comm: runcon Not tainted 5.4.0-rc1+ #57
> Hardware name: Dell Inc. OptiPlex 7050/0NW6H5, BIOS 1.8.3 03/23/2018
> RIP: 0010:syscall_return_slowpath+0x1e1/0x4a0
> Code: ff ff e9 60 ff ff ff e8 2d ad 05 00 e9 2a ff ff ff 48 8d 7d 78 e8
> cf cf 50RSP: 0018:ffff8885a6adff28 EFLAGS: 00010082
> RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
> RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffed10b4d5bfd7
> RBP: ffff8885a6adff58 R08: ffffffffaa219f90 R09: fffffbfff5883615
> R10: fffffbfff5883614 R11: ffffffffac41b0a3 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f3e32c67080(0000) GS:ffff888822a40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f3e32f145d0 CR3: 00000005a7476005 CR4: 00000000003606e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> kernel:  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f3e32e11467
> Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e
> fa 64 8bRSP: 002b:00007ffec6482bc8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> RAX: 000000000000002f RBX: 00007ffec6483d88 RCX: 00007f3e32e11467
> RDX: 000000000000002f RSI: 000055b75e5a5600 RDI: 0000000000000003
> RBP: 000055b75e5a5600 R08: 00000000ffffffff R09: 00007ffec6482a60
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 00007ffec6483c4c R14: 0000000000000000 R15: 0000000000000000
> irq event stamp: 7292
> hardirqs last  enabled at (7291): [<ffffffffab26d9bb>]
> _raw_write_unlock_irqresthardirqs last disabled at (7292):
> [<ffffffffab26db61>] _raw_spin_lock_irqsave+0xsoftirqs last  enabled at
> (7036): [<ffffffffab600494>] __do_softirq+0x494/0x665
> softirqs last disabled at (7025): [<ffffffffaa168b8f>] irq_exit+0x13f/0x160
> kernel: ---[ end trace 1557497a64e0b001 ]---
> kernel: ------------[ cut here ]------------
>
> Some comments below.  Recommend running it by the RCU wizards e.g. Paul
> McKenney too given the subtleties of getting RCU right.

Sure, I've also cc'ed Will Deacon.
>
> <snip>
>
> > diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> > index 7d49994e8d5f..c052e620246c 100644
> > --- a/security/selinux/ss/sidtab.c
> > +++ b/security/selinux/ss/sidtab.c
> > @@ -17,26 +17,42 @@
> <snip>
> > +static u32 context_to_sid(struct sidtab *s, struct context *context)
> > +{
> > +     struct sidtab_entry_leaf *entry;
> > +
> > +     rcu_read_lock();
> > +     hash_for_each_possible_rcu(s->context_to_sid, entry, list,
> > +                                context->hash) {
> > +             if (context_cmp(&entry->context, context)) {
> > +                     rcu_read_unlock();
> > +                     return entry->sid;
>
> This looks unsafe to me; I would have assumed you need to at least save
> entry->sid to a temporary before rcu_read_unlock()?

Good point.
>
> > @@ -305,29 +284,36 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
> >               rc = -ENOMEM;
> >               dst_convert = sidtab_do_lookup(convert->target, count, 1);
> >               if (!dst_convert) {
> > -                     context_destroy(dst);
> > +                     context_destroy(&dst->context);
> >                       goto out_unlock;
> >               }
> >
> > -             rc = convert->func(context, dst_convert, convert->args);
> > +             rc = convert->func(context, &dst_convert->context,
> > +                             convert->args);
> >               if (rc) {
> > -                     context_destroy(dst);
> > +                     context_destroy(&dst->context);
> >                       goto out_unlock;
> >               }
> > +             dst_convert->sid = index_to_sid(count);
> > +             convert->target->count = count + 1;
> >
> >               /* at this point we know the insert won't fail */
> > -             convert->target->count = count + 1;
> > +             spin_lock_irqsave_nested(&convert->target->lock, flags,
> > +                             SINGLE_DEPTH_NESTING);
> > +             hash_add_rcu(convert->target->context_to_sid,
> > +                             &dst_convert->list, dst_convert->context.hash);
> > +             spin_unlock_irqrestore(&convert->target->lock, flags);
>
> Still having a hard time understanding why we need to lock the target.
> The target here is always the newsidtab allocated by
> security_load_policy(), not yet exposed to any other threads in the system?

It is exposed to other threads, for example in sidtab_context_to_sid()
which can be
triggered by calls from userspace like restorecon, runcon, etc.

That means that hash_add_rcu can be called simultaneously on newsidtab in
sidtab_convert_hashtable() and sidtab_context_to_sid().

The previous implementation avoided this issue because sidtab_convert() and
sidtab_context_to_sid() wrote to non-overlapping parts of the newsidtab tree so
no locking was necessary.

>
> >       }
> >
> >       if (context->len)
> >               pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
> >                       context->str);
> >
> > -     sidtab_rcache_push(s, count);
> > -     *index = count;
> > +     *sid = index_to_sid(count);
> >
> > -     /* write entries before writing new count */
> > +     /* Write entries before updating count. */
> >       smp_store_release(&s->count, count + 1);
> > +     hash_add_rcu(s->context_to_sid, &dst->list, dst->context.hash);
>
> Exactly what guarantee do we think we are getting from placing the
> hash_add_rcu() after the smp_store_release() on s->count, and is that
> guarantee well-founded?

None at all. I could move the hash_add_rcu() to before the
smp_store_release(). The ordering
of these two statements is not important.
>
> > @@ -474,7 +463,7 @@ static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
> >
> >               for (i = 0; i < SIDTAB_LEAF_ENTRIES; i++)
> >                       context_destroy(&node->entries[i].context);
> > -             kfree(node);
> > +             kfree_rcu(node, rcu);
>
> Is it safe to do this without having deleted it from the hash and
> without having taken the spinlock?

Yes and yes.

At this point we've already shifted over to using the new sidtab so
only this thread has access to the oldsidtab.
The objects within the sidtab are entirely shared between the tree and
the hashtable so we should just free
them once. Calling hash_del_rcu() before hand is just going to move
pointers around on a list of objects which
will all be deleted anyways.
>
> >       }
> >   }
> >
>
> > diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> > index 1f4763141aa1..f1f505df97ba 100644
> > --- a/security/selinux/ss/sidtab.h
> > +++ b/security/selinux/ss/sidtab.h
> > @@ -83,11 +88,11 @@ struct sidtab {
> >       struct sidtab_convert_params *convert;
> >       spinlock_t lock;
> >
> > -     /* reverse lookup cache - access atomically via {READ|WRITE}_ONCE() */
> > -     u32 rcache[SIDTAB_RCACHE_SIZE];
> > -
> >       /* index == SID - 1 (no entry for SECSID_NULL) */
> >       struct sidtab_isid_entry isids[SECINITSID_NUM];
> > +
> > +     /* Hash table for fast reverse context-to-sid lookups. */
> > +     DECLARE_HASHTABLE(context_to_sid, SIDTAB_HASH_BITS);
>
> Should this and/or any of the associated RCU-protected structures be
> marked with __rcu for sparse checking?

I'm unsure what you mean.
>
> >   };
> >
> >   int sidtab_init(struct sidtab *s);
>
>
