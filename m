Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE7AEB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 18:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjGQSeE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGQSeD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 14:34:03 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E5999
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 11:34:02 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34611de0ee4so20419605ab.0
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689618841; x=1692210841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKovqJAB5k7Hg0OxL6Y3T18NzaAXqWWvdSKdHRXJV58=;
        b=sZ5WZn2U4BJ2XGt5eRtPcTDtrcs8yj4xodzv9tYHOFQm8c/GjjyRWwCmb5LELd3dsE
         KZ8tjB8wn/oGuto4CIf7evRf2xwb4ySxTjir00P62n4msuuAAaPLgQwhmWFFIenHA3nN
         1CSG9mmtzMOJzdxnWBPv/jbo+dvS1zcqOiOspa1I8dVHWL69dyTYoUkdVCiyaMv6OjEH
         alBiB1f8FZ+2IAlD+II85NCvkTLGtBzXbZZn0HwQbK7yIUVJtYH836Hen97QTlKg4nMr
         EMWa+zmt2aFOuhSbRJtqarCC1G5Sq0PHBhzd5t3IV7kndOt1rWldoiofYf6XuTZQgyrP
         6axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689618841; x=1692210841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKovqJAB5k7Hg0OxL6Y3T18NzaAXqWWvdSKdHRXJV58=;
        b=deDQFM1Pdr24IOX+i4NGjCdT0iBgpt/uCDaYWss1dm03uC4AOHN2zdZXKLH8Cibi7o
         m7DIunTVdqUyp6LNssvVWFngIZWI2AuRdUxV2gUE9XSCeeqmB0wa+hYgZwaJdd7Z9rrv
         vFCPVAuMsmDZERAvYysCDewHES/NhKVm6pFacPR8xKneag6PtJNg0RZqJnjcs7B+H9Hq
         EgA2peZfenK3hYZ/RjBgMjGgAsCQE926/8pLCpID/qTxrQ286zD27eYF1F+LISF43xW4
         kw6l6sHo+f9UKxzMtKWk/gjPzf5Wr5XWxD22m0ZyS20W0f/S9bl4/+PwMgPdZ4mn4q71
         Bp/g==
X-Gm-Message-State: ABy/qLY+dAXDNRnV86yMgqhf1HpyQuZyHac31l3+cBrqQhIBIUI+7xOO
        PW8bhOZvKkcLbpyfExtRKDuyYU5En8dfyoubEa77uvPO6bI=
X-Google-Smtp-Source: APBJJlG5As/d6OwofygwLfg0cgnEoPVzuCRlaLNNs+8zCNlKqhG4Z+fVQS/Q6atECvk6tAc5N8IYP5ITOefXYfGJpzo=
X-Received: by 2002:a05:6e02:20e2:b0:348:8c85:c998 with SMTP id
 q2-20020a056e0220e200b003488c85c998mr598103ilv.23.1689618841431; Mon, 17 Jul
 2023 11:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230531112927.1957093-1-juraj@jurajmarcin.com> <20230531112927.1957093-6-juraj@jurajmarcin.com>
In-Reply-To: <20230531112927.1957093-6-juraj@jurajmarcin.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 17 Jul 2023 14:33:50 -0400
Message-ID: <CAEjxPJ5U0uJxhKU6A+igHUvJuOPF=ofaQQ-KTsDec=Exq1wxeg@mail.gmail.com>
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

On Wed, May 31, 2023 at 7:32=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> Currently, filename type transitions support only exact name matching.
> However, in practice, the names contain variable parts. This leads to
> many duplicated rules in the policy that differ only in the part of the
> name, or it is even impossible to cover all possible combinations.
>
> This patch extends the filename type transitions structures to include
> new types of filename transitions - prefix and suffix filename
> transitions. It also implements the reading and writing of those rules
> in the kernel binary policy format together with increasing its version.
> Last, it updates the function responsible for determining the new
> context to also include the prefix and suffix filename transitions in
> the process. It does that by first checking for the exact match, then
> the longest matching prefix and then the longest matching suffix, in
> that order. That way the exact match rules have precedence before new
> rules, to ensure compatibility with older policies.
>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> ---
>  security/selinux/include/security.h |  3 +-
>  security/selinux/ss/avtab.c         | 53 +++++++++++++++++++--
>  security/selinux/ss/avtab.h         |  2 +
>  security/selinux/ss/avtab_test.c    | 16 +++++++
>  security/selinux/ss/policydb.c      |  5 ++
>  security/selinux/ss/services.c      | 71 ++++++++++++++++++++++++-----
>  6 files changed, 133 insertions(+), 17 deletions(-)
>

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 131647e7ec68..2faf92bf12da 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1661,6 +1661,60 @@ static int compute_sid_handle_invalid_context(
>         return -EACCES;
>  }
>
> +static int security_compute_type_trans_otype(struct avtab_trans *trans,
> +                                            const char *name, u32 *res_t=
ype)
> +{
> +       u32 *otype;
> +       size_t len;
> +       char *namedup =3D NULL;
> +       size_t i;
> +
> +       /*
> +        * use default otype if not empty and then try to find more speci=
fic
> +        * rule using name
> +        */
> +       if (trans->otype)
> +               *res_type =3D trans->otype;
> +       if (!name)
> +               return 0;
> +
> +       /* try to find full name */
> +       otype =3D symtab_search(&trans->name_trans, name);
> +       if (otype) {
> +               *res_type =3D *otype;
> +               return 0;
> +       }
> +
> +       /* copy name for shortening */
> +       len =3D strlen(name);
> +       namedup =3D kmemdup(name, len + 1, GFP_KERNEL);

This is called in various contexts that cannot sleep; hence, the
allocation must be GFP_ATOMIC here. With the proper config options
(CONFIG_DEBUG_ATOMIC_SLEEP=3Dy) you would have seen repeated warnings
about this in the kernel messages, ala:

[  219.944942] BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:306
[  219.944951] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
1, name: systemd
[  219.944956] preempt_count: 0, expected: 0
[  219.944959] RCU nest depth: 1, expected: 0
[  219.944963] INFO: lockdep is turned off.
[  219.944967] CPU: 0 PID: 1 Comm: systemd Tainted: G    B   W
 6.5.0-rc1+ #32
[  219.944979] Call Trace:
[  219.944982]  <TASK>
[  219.944986]  dump_stack_lvl+0x75/0x90
[  219.944997]  __might_resched+0x1e1/0x310
[  219.945008]  ? security_compute_sid.part.0+0x9d8/0xe50
[  219.945017]  __kmem_cache_alloc_node+0x343/0x380
[  219.945026]  ? security_compute_sid.part.0+0x9d8/0xe50
[  219.945033]  ? rcu_is_watching+0x23/0x50
[  219.945046]  ? security_compute_sid.part.0+0x9d8/0xe50
[  219.945054]  __kmalloc_node_track_caller+0x52/0x160
[  219.945068]  kmemdup+0x22/0x50
[  219.945078]  security_compute_sid.part.0+0x9d8/0xe50
[  219.945093]  ? __pfx_security_compute_sid.part.0+0x10/0x10
[  219.945101]  ? rcu_is_watching+0x23/0x50
[  219.945110]  ? lock_release+0xa0/0x380
[  219.945116]  ? avc_has_perm_noaudit+0xb4/0x250
[  219.945127]  ? __pfx_lock_release+0x10/0x10
[  219.945134]  ? rcu_is_watching+0x23/0x50
[  219.945143]  ? lock_acquire+0xb5/0x390
[  219.945148]  ? __filename_parentat+0x282/0x350
[  219.945160]  ? avc_has_perm_noaudit+0xcc/0x250
[  219.945178]  security_transition_sid+0x63/0xa0
[  219.945191]  may_create+0x16a/0x1c0
[  219.945201]  ? __pfx_may_create+0x10/0x10
[  219.945207]  ? selinux_inode_permission+0x1c6/0x290
[  219.945216]  ? __pfx_selinux_inode_permission+0x10/0x10
[  219.945226]  ? kernfs_iop_permission+0x84/0xa0
[  219.945238]  security_inode_mkdir+0x61/0x80
[  219.945251]  vfs_mkdir+0x226/0x380
[  219.945262]  do_mkdirat+0x1a8/0x1d0
[  219.945272]  ? __pfx_do_mkdirat+0x10/0x10
[  219.945280]  ? getname_flags.part.0+0xc6/0x250
[  219.945290]  __x64_sys_mkdir+0x78/0xa0
[  219.945300]  do_syscall_64+0x3c/0x90
[  219.945308]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  219.945317] RIP: 0033:0x7ff080322d6b
[  219.945337] Code: 8b 05 a1 30 0d 00 bb ff ff ff ff 64 c7 00 16 00
00 00 e9 62 ff ff ff e8 e3 1b 02 00 0f 1f 00 f3 0f 1e fa b8 53 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 69 30 0d 00
f7 d8
[  219.945343] RSP: 002b:00007ffe3fbd6cd8 EFLAGS: 00000246 ORIG_RAX:
0000000000000053
[  219.945350] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff0803=
22d6b
[  219.945355] RDX: 0000000000000000 RSI: 00000000000001ed RDI: 000055a4731=
c2a10
[  219.945360] RBP: 00007ffe3fbd6d10 R08: 00000000ffffff9c R09: 00007ffe3fb=
d6b60
[  219.945364] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff0806=
af143
[  219.945368] R13: 000055a47311ce20 R14: 0000000000000001 R15: 00000000000=
003a0
[  219.945382]  </TASK>

> +       if (!namedup)
> +               return -ENOMEM;
> +
> +       /* try to find possible prefixes of name starting from the longes=
t */
> +       for (i =3D len; i > 0; i--) {
> +               namedup[i] =3D '\0';
> +               otype =3D symtab_search(&trans->prefix_trans, namedup);
> +               if (otype) {
> +                       kfree(namedup);
> +                       *res_type =3D *otype;
> +                       return 0;
> +               }
> +       }
> +       kfree(namedup);
> +
> +       /*try to find possible suffixes of name starting from the longest=
 */
> +       for (i =3D 0; i < len; i++) {
> +               otype =3D symtab_search(&trans->suffix_trans, &name[i]);
> +               if (otype) {
> +                       *res_type =3D *otype;
> +                       return 0;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int security_compute_sid(u32 ssid,
>                                 u32 tsid,
>                                 u16 orig_tclass,
> @@ -1802,18 +1856,11 @@ static int security_compute_sid(u32 ssid,
>         if (avdatum) {
>                 /* Use the type from the type transition/member/change ru=
le. */
>                 if (avkey.specified & AVTAB_TRANSITION) {
> -                       /*
> -                        * use default otype if not empty and then to try=
 to
> -                        * find more specific rule using objname
> -                        */
> -                       if (avdatum->u.trans->otype)
> -                               newcontext.type =3D avdatum->u.trans->oty=
pe;
> -                       if (objname) {
> -                               otype =3D symtab_search(&avdatum->u.trans=
->name_trans,
> -                                                     objname);
> -                               if (otype)
> -                                       newcontext.type =3D *otype;
> -                       }
> +                       rc =3D security_compute_type_trans_otype(avdatum-=
>u.trans,
> +                                                              objname,
> +                                                              &newcontex=
t.type);
> +                       if (rc)
> +                               goto out_unlock;
>                 } else {
>                         newcontext.type =3D avdatum->u.data;
>                 }
> --
> 2.40.0
>
