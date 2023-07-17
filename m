Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1E3EB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 18:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGQSwH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGQSwH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 14:52:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3CC94
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 11:52:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26314c2be8eso2552007a91.1
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689619925; x=1692211925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0LVIgZm1M22iw6kEilVCZq+WKdAlRp2r04rLXVZm9A=;
        b=oaNuNyCkHPKcBco0No193LO/22HIN77lVP7IvFhTvVRPQMukYqMA1VokHZOnQaLNSE
         GdzB2+IfLrfu5jqOk2R76sRizwJIJSaLGReHsS4YxeL8JV/Y6W5qV2iE3e8AFWFztC54
         jSo6xg2KFQHkYYSt0R3S2YhEhqV/X3jFVp7qbvVFTSoi4ui44r7ydab8SFqo3fkkrqbq
         gx5n/FLqMhgmIgONdNpBtTHmnrhj7pKg+2BADQ/AUR+IpyNMj5sIeBFbfTVfKuMgknXh
         p73kDCqfNBSe7rgvYc1GaFbHyUdSwQVdranTxTtWjFwbbIdgjpUqACP8JoTMdApp1LSo
         nVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689619925; x=1692211925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0LVIgZm1M22iw6kEilVCZq+WKdAlRp2r04rLXVZm9A=;
        b=QZrTbU0xXxl6pgBdUqQHEPbWACiBJdl+O6qMcITD74gx3ML3RkjjauUJeZpOkcF7zH
         LMqGJ+w+Y9CnAv+7CweRJT0MMRVXfPfjKvuBxNGQsfr5sc08018dIf0FBPcUp6ajSjBn
         lKoo0niv9m2twwXY5hbl/drJIXVoXpd8vZCwxyhid4ypsO7+XybliJX8V2nUMd0Xo7dS
         uPwnQ8mby0CDYAqTxB2TRIdCzW06dKgFoMwv1m7AEmYQvKBUEALXODtgCVx70Zzw1Chu
         lJTpijLUN73/2GoRBCHi7YZCnNqZu1R7jmkbzi43Ka1yQ41kcD95fAdTAwxZ5vEUUQE5
         hUqg==
X-Gm-Message-State: ABy/qLabaFX1oKAJvgTtev2krMmFMuJPPEdvuKK99VIzfd0jlcgCMcLB
        WLOM/iZ9bCjGRfn7Bowft73DuxN7EXlxaJ6nHNc=
X-Google-Smtp-Source: APBJJlFiUoSzfEuVLVLsCA5ReyKSxaKtu3tanBCO5j3xyh9l72iGSXkROFOCM3p8I1z+ivw9pUAuafsVzYFhnSy5QVY=
X-Received: by 2002:a17:90b:3112:b0:262:ebb9:dd60 with SMTP id
 gc18-20020a17090b311200b00262ebb9dd60mr10005424pjb.20.1689619924998; Mon, 17
 Jul 2023 11:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <20230531112927.1957093-6-juraj@jurajmarcin.com> <CAEjxPJ5U0uJxhKU6A+igHUvJuOPF=ofaQQ-KTsDec=Exq1wxeg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5U0uJxhKU6A+igHUvJuOPF=ofaQQ-KTsDec=Exq1wxeg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 17 Jul 2023 14:51:53 -0400
Message-ID: <CAEjxPJ7B9=hjT5WOuv9m6Sb+dGWrE5HANUc3KJknp_mdyv2SuA@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: add prefix/suffix matching support to
 filename type transitions
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 17, 2023 at 2:33=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 31, 2023 at 7:32=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.c=
om> wrote:
> >
> > Currently, filename type transitions support only exact name matching.
> > However, in practice, the names contain variable parts. This leads to
> > many duplicated rules in the policy that differ only in the part of the
> > name, or it is even impossible to cover all possible combinations.
> >
> > This patch extends the filename type transitions structures to include
> > new types of filename transitions - prefix and suffix filename
> > transitions. It also implements the reading and writing of those rules
> > in the kernel binary policy format together with increasing its version=
.
> > Last, it updates the function responsible for determining the new
> > context to also include the prefix and suffix filename transitions in
> > the process. It does that by first checking for the exact match, then
> > the longest matching prefix and then the longest matching suffix, in
> > that order. That way the exact match rules have precedence before new
> > rules, to ensure compatibility with older policies.
> >
> > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> > ---
> >  security/selinux/include/security.h |  3 +-
> >  security/selinux/ss/avtab.c         | 53 +++++++++++++++++++--
> >  security/selinux/ss/avtab.h         |  2 +
> >  security/selinux/ss/avtab_test.c    | 16 +++++++
> >  security/selinux/ss/policydb.c      |  5 ++
> >  security/selinux/ss/services.c      | 71 ++++++++++++++++++++++++-----
> >  6 files changed, 133 insertions(+), 17 deletions(-)
> >
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 131647e7ec68..2faf92bf12da 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1661,6 +1661,60 @@ static int compute_sid_handle_invalid_context(
> >         return -EACCES;
> >  }
> >
> > +static int security_compute_type_trans_otype(struct avtab_trans *trans=
,
> > +                                            const char *name, u32 *res=
_type)
> > +{
> > +       u32 *otype;
> > +       size_t len;
> > +       char *namedup =3D NULL;
> > +       size_t i;
> > +
> > +       /*
> > +        * use default otype if not empty and then try to find more spe=
cific
> > +        * rule using name
> > +        */
> > +       if (trans->otype)
> > +               *res_type =3D trans->otype;
> > +       if (!name)
> > +               return 0;
> > +
> > +       /* try to find full name */
> > +       otype =3D symtab_search(&trans->name_trans, name);
> > +       if (otype) {
> > +               *res_type =3D *otype;
> > +               return 0;
> > +       }
> > +
> > +       /* copy name for shortening */
> > +       len =3D strlen(name);
> > +       namedup =3D kmemdup(name, len + 1, GFP_KERNEL);
>
> This is called in various contexts that cannot sleep; hence, the
> allocation must be GFP_ATOMIC here. With the proper config options
> (CONFIG_DEBUG_ATOMIC_SLEEP=3Dy) you would have seen repeated warnings
> about this in the kernel messages, ala:
>
> [  219.944942] BUG: sleeping function called from invalid context at
> include/linux/sched/mm.h:306
> [  219.944951] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
> 1, name: systemd
> [  219.944956] preempt_count: 0, expected: 0
> [  219.944959] RCU nest depth: 1, expected: 0
> [  219.944963] INFO: lockdep is turned off.
> [  219.944967] CPU: 0 PID: 1 Comm: systemd Tainted: G    B   W
>  6.5.0-rc1+ #32
> [  219.944979] Call Trace:
> [  219.944982]  <TASK>
> [  219.944986]  dump_stack_lvl+0x75/0x90
> [  219.944997]  __might_resched+0x1e1/0x310
> [  219.945008]  ? security_compute_sid.part.0+0x9d8/0xe50
> [  219.945017]  __kmem_cache_alloc_node+0x343/0x380
> [  219.945026]  ? security_compute_sid.part.0+0x9d8/0xe50
> [  219.945033]  ? rcu_is_watching+0x23/0x50
> [  219.945046]  ? security_compute_sid.part.0+0x9d8/0xe50
> [  219.945054]  __kmalloc_node_track_caller+0x52/0x160
> [  219.945068]  kmemdup+0x22/0x50
> [  219.945078]  security_compute_sid.part.0+0x9d8/0xe50
> [  219.945093]  ? __pfx_security_compute_sid.part.0+0x10/0x10
> [  219.945101]  ? rcu_is_watching+0x23/0x50
> [  219.945110]  ? lock_release+0xa0/0x380
> [  219.945116]  ? avc_has_perm_noaudit+0xb4/0x250
> [  219.945127]  ? __pfx_lock_release+0x10/0x10
> [  219.945134]  ? rcu_is_watching+0x23/0x50
> [  219.945143]  ? lock_acquire+0xb5/0x390
> [  219.945148]  ? __filename_parentat+0x282/0x350
> [  219.945160]  ? avc_has_perm_noaudit+0xcc/0x250
> [  219.945178]  security_transition_sid+0x63/0xa0
> [  219.945191]  may_create+0x16a/0x1c0
> [  219.945201]  ? __pfx_may_create+0x10/0x10
> [  219.945207]  ? selinux_inode_permission+0x1c6/0x290
> [  219.945216]  ? __pfx_selinux_inode_permission+0x10/0x10
> [  219.945226]  ? kernfs_iop_permission+0x84/0xa0
> [  219.945238]  security_inode_mkdir+0x61/0x80
> [  219.945251]  vfs_mkdir+0x226/0x380
> [  219.945262]  do_mkdirat+0x1a8/0x1d0
> [  219.945272]  ? __pfx_do_mkdirat+0x10/0x10
> [  219.945280]  ? getname_flags.part.0+0xc6/0x250
> [  219.945290]  __x64_sys_mkdir+0x78/0xa0
> [  219.945300]  do_syscall_64+0x3c/0x90
> [  219.945308]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  219.945317] RIP: 0033:0x7ff080322d6b
> [  219.945337] Code: 8b 05 a1 30 0d 00 bb ff ff ff ff 64 c7 00 16 00
> 00 00 e9 62 ff ff ff e8 e3 1b 02 00 0f 1f 00 f3 0f 1e fa b8 53 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 69 30 0d 00
> f7 d8
> [  219.945343] RSP: 002b:00007ffe3fbd6cd8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000053
> [  219.945350] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff08=
0322d6b
> [  219.945355] RDX: 0000000000000000 RSI: 00000000000001ed RDI: 000055a47=
31c2a10
> [  219.945360] RBP: 00007ffe3fbd6d10 R08: 00000000ffffff9c R09: 00007ffe3=
fbd6b60
> [  219.945364] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff08=
06af143
> [  219.945368] R13: 000055a47311ce20 R14: 0000000000000001 R15: 000000000=
00003a0
> [  219.945382]  </TASK>

Also recommend enabling CONFIG_DEBUG_KMEMLEAK and
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN - seeing kernel: kmemleak: 2634 new
suspected memory leaks (see /sys/kernel/debug/kmemleak) in kernel
messages and a lot of these warnings in /sys/kernel/debug/kmemleak:

unreferenced object 0xffff8881b05d6ea8 (size 8):
  comm "systemd", pid 1, jiffies 4294785029 (age 2050.052s)
  hex dump (first 8 bytes):
    6d 64 33 00 cc cc cc cc                          md3.....
  backtrace:
    [<ffffffff9f54d692>] __kmalloc_node_track_caller+0x52/0x160
    [<ffffffff9f5388d2>] kmemdup+0x22/0x50
    [<ffffffff9fac9702>] filenametr_tab_insert+0x332/0x650
    [<ffffffff9fac5634>] hashtab_map+0x84/0xc0
    [<ffffffff9fac8adb>] avtab_filename_trans_write+0x2fb/0x3a0
    [<ffffffff9fad3838>] policydb_write+0x508/0x1220
    [<ffffffff9fae0a10>] security_read_state_kernel+0xe0/0x1c0
    [<ffffffff9fae7343>] selinux_ima_measure_state_locked+0x643/0x7b0
    [<ffffffff9fadad35>] selinux_policy_commit+0x315/0x470
    [<ffffffff9fac125d>] sel_write_load+0xd6d/0xfa0
    [<ffffffff9f69560e>] vfs_write+0x18e/0x720
    [<ffffffff9f6960e7>] ksys_write+0xb7/0x140
    [<ffffffffa07dc29c>] do_syscall_64+0x3c/0x90
    [<ffffffffa0a000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
