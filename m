Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1376C4332F
	for <selinux@archiver.kernel.org>; Wed,  8 Nov 2023 21:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjKHVaN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Nov 2023 16:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjKHVaK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Nov 2023 16:30:10 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283FD1BE2
        for <selinux@vger.kernel.org>; Wed,  8 Nov 2023 13:30:08 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so125891a12.1
        for <selinux@vger.kernel.org>; Wed, 08 Nov 2023 13:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699479007; x=1700083807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW8K4lNeJKtY3nXZ8AkuKbjFaExeHIgVAOOPVYtT94c=;
        b=M+gWHVh0abtZFsqx3fDU1N91uBDvWEgDrUlu0/MApJ3VxRugWQ8W4pgSatvxnyabg8
         e9UMo//xD089E3bMRA4I8JrDmDhrAmnNxX9+u9R6rM2lrMh2K7SDTs9N53xz9EmzoZ8X
         +1XFCleTHf/ZgIEkg2vA3ixLv1qV3kdovOjtKkKdfxB/K0K5kbnF0JlzPa/uQSsVbuje
         Ri04bYyk4zD3lLnShmctzD/BAgZHg8jtqXxGh+bL0zd5WRta+69RBYHvad33Lon0IDld
         ICSDRIhg1/t8eEhiVDW7Ug+Sznr0T69N6mH3vUs+7i1a5QWbhNkeKyiRAv/KtCnZFGGA
         wmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699479007; x=1700083807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW8K4lNeJKtY3nXZ8AkuKbjFaExeHIgVAOOPVYtT94c=;
        b=c+g9F7vulJTG62IXo7/5VCB524r3wAbgLtZD0ieQ+kaTR0vL4PPobeZ5rwrKtXA+ui
         UxJXKBHFLfwMtDgiKHFlPmKN+QP0O2StyDZ6rWxj0u6VvtWl+nKTGMyFP6K7is1fiMCY
         +VVeEv5RWkeT9qM7qTHxrTiX1t09/APotfYOrQ+hY0MqejZ0KvQcn5UKooI8VAxVr0ZG
         ejBGgC4PUIFujkuGAoU/h9zDebfN926Kf3KeW+F9wO946R7aZa8wH6DsEDrZ4zfuNvxa
         f7LdLhTcQxpyL3m+EXxO5dQOILJ9ywMxiz35ax1IXGqAOL0njxReEWKCyJpKyNr2YsL+
         fGEw==
X-Gm-Message-State: AOJu0YyVA/ebvL1ZfveOZZRQre4pdDvbDFSVZmP0l/QkvMj5T4SVv57s
        dlkZGbb8OqU2ewCAmxuAYPspeRGw4bHTlnX8TP8=
X-Google-Smtp-Source: AGHT+IFAlQFnFpMLsMe3d1G5hxV81X4jTaN6KRZOtAShJauSHQhVdx57wXvdrI6ldxoMRf8GQevz7NauRXhFaZoCUFk=
X-Received: by 2002:a17:90a:bf11:b0:27d:375a:e322 with SMTP id
 c17-20020a17090abf1100b0027d375ae322mr3064750pjs.31.1699479007449; Wed, 08
 Nov 2023 13:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20231108101427.3514509-1-juraj@jurajmarcin.com>
In-Reply-To: <20231108101427.3514509-1-juraj@jurajmarcin.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 8 Nov 2023 16:29:56 -0500
Message-ID: <CAEjxPJ51mR-Qb0t_gWO-mW0-5pageAyORUEgJJ1HsX2Fd8dBsA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: add prefix/suffix matching to filename type transitions
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 8, 2023 at 5:15=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com>=
 wrote:
>
> Currently, filename transitions are stored separately from other type
> enforcement rules and only support exact name matching. However, in
> practice, the names contain variable parts. This leads to many
> duplicated rules in the policy that differ only in the part of the name,
> or it is even impossible to cover all possible combinations.
>
> This patch changes the filename transition table in the policydb
> structure into an array of three tables, where the index determines the
> match type for the rules contained (extract, prefix, and suffix match).
> Then the patch extends the functions that access the table through the
> policydb structure to accompany this change while reusing the majority
> of the old filename transitions code.
>
> This patch also updates the code responsible for finding the right
> filename transition based on the context and the name. The rules have
> the following order of prioriy, if no matching rule is found, the code
> moves on to the next category:
> - exact filename transitions,
> - prefix filename transitions in the order of the longest prefix match,
> - suffix filename transitions in the order of the longest suffix match.
> This ensures the compatibility with older policies.
>
> Without prefix/suffix rules in the policy, this patch has no impact on
> performance or policy loading times. Moreover, with prefix/suffix rules,
> the overall number of filename transitions can be reduced, which results
> in smaller binary policy size and therefore also slightly lower load
> time and memory usage.
>
> Performance tests:
>
> 1: Reference kernel (f5bbdeda34c63), Fedora policy (format v33)
> 2: This patch, Fedora policy (format v33)
> 3: This patch, Fedora policy without prefix/suffix rules (format v34)
> 4: This patch, Fefora policy with prefix rules (format v35)
>
>    | Mem    | Binary | Policy  | Create tty [1]       | osbench [2]
>    | Usage  | policy | load    |                      | create
>    |        | size   | time    | (ms/file)            | files
>    | (MiB)  | (KiB)  | (ms)    | real     | kernel    | (us/file)
> ---+--------+--------+---------+----------+-----------+-----------
>  1 |  298.7 |   3682 |  58.626 |   1.0228 |    0.6793 |    8.4916
>    | sd=3D4.1 |        | sd=3D0.47 | sd=3D0.058 | sd=3D0.0497 |  sd=3D0.1=
31
>  2 |  296.3 |   3682 |  58.915 |   1.0209 |    0.6752 |    8.5728
>    | sd=3D3.9 |        | sd=3D0.28 | sd=3D0.021 | sd=3D0.0244 |  sd=3D0.1=
56
>  3 |  295.7 |   3682 |  56.374 |   1.0160 |    0.6616 |    8.7467
>    | sd=3D2.6 |        | sd=3D0.44 | sd=3D0.008 | sd=3D0.0141 |  sd=3D0.1=
26
>  4 |  296.2 |   2585 |  51.434 |   1.0116 |    0.6699 |    8.7467
>    | sd=3D4.1 |        | sd=3D0.39 | sd=3D0.012 | sd=3D0.0115 |  sd=3D0.1=
26
>
> [1] Create test_tty benchmark:
>
>     mknod /dev/test_tty c 4 1
>     time for i in `seq 1 10000`; do
>         mknod /dev/test_tty$i c 4 1
>     done
>
> This benchmark should simulate the worst case scenario as many filename
> transitions affect files created in the /dev directory.
>
> [2] https://github.com/mbitsnbites/osbench
>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> ---

As with the previous patch, seeing these warnings due to performing
blocking allocation when atomic is required.

[ 2186.277242] BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:306
[ 2186.277250] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
10017, name: mkdir
[ 2186.277256] preempt_count: 0, expected: 0
[ 2186.277260] RCU nest depth: 1, expected: 0
[ 2186.277263] INFO: lockdep is turned off.
[ 2186.277268] CPU: 0 PID: 10017 Comm: mkdir Tainted: G    B   W  OE
   6.6.0-rc1+ #66
[ 2186.277280] Call Trace:
[ 2186.277284]  <TASK>
[ 2186.277288]  dump_stack_lvl+0x75/0x90
[ 2186.277300]  __might_resched+0x1e1/0x310
[ 2186.277311]  __kmem_cache_alloc_node+0x343/0x380
[ 2186.277320]  ? security_compute_sid.part.0+0xa60/0xe90
[ 2186.277332]  ? security_compute_sid.part.0+0xa60/0xe90
[ 2186.277341]  __kmalloc_node_track_caller+0x55/0x160
[ 2186.277356]  kstrdup+0x34/0x60
[ 2186.277364]  security_compute_sid.part.0+0xa60/0xe90
[ 2186.277379]  ? lock_acquire+0xb5/0x390
[ 2186.277388]  ? __pfx_security_compute_sid.part.0+0x10/0x10
[ 2186.277397]  ? rcu_is_watching+0x23/0x50
[ 2186.277407]  ? lock_acquire+0xb5/0x390
[ 2186.277414]  ? rcu_is_watching+0x23/0x50
[ 2186.277423]  ? lock_release+0xa0/0x380
[ 2186.277429]  ? avc_has_perm_noaudit+0xb4/0x250
[ 2186.277437]  ? __pfx_lock_release+0x10/0x10
[ 2186.277446]  ? avc_has_perm_noaudit+0xcc/0x250
[ 2186.277455]  ? avc_has_perm_noaudit+0xcc/0x250
[ 2186.277471]  security_transition_sid+0x63/0xa0
[ 2186.277483]  may_create+0x16a/0x1c0
[ 2186.277493]  ? __pfx_may_create+0x10/0x10
[ 2186.277501]  ? selinux_inode_permission+0x1c6/0x290
[ 2186.277510]  ? __pfx_selinux_inode_permission+0x10/0x10
[ 2186.277525]  security_inode_mkdir+0x61/0x80
[ 2186.277534]  vfs_mkdir+0x226/0x380
[ 2186.277547]  do_mkdirat+0x1a8/0x1d0
[ 2186.277557]  ? __pfx_do_mkdirat+0x10/0x10
[ 2186.277567]  ? getname_flags.part.0+0xc6/0x250
[ 2186.277573]  ? __pfx___x64_sys_chdir+0x10/0x10
[ 2186.277583]  __x64_sys_mkdir+0x78/0xa0
[ 2186.277592]  do_syscall_64+0x3c/0x90
[ 2186.277602]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 2186.277611] RIP: 0033:0x7f2cb7788d5b
[ 2186.277637] Code: 8b 05 b1 30 0d 00 bb ff ff ff ff 64 c7 00 16 00
00 00 e9 62 ff ff ff e8 e3 1b 02 00 0f 1f 00 f3 0f 1e fa b8 53 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 79 30 0d 00
f7 d8
[ 2186.277645] RSP: 002b:00007ffe4833a5d8 EFLAGS: 00000246 ORIG_RAX:
0000000000000053
[ 2186.277653] RAX: ffffffffffffffda RBX: 00007ffe4833a840 RCX: 00007f2cb77=
88d5b
[ 2186.277658] RDX: 00007ffe4833a840 RSI: 00000000000001ff RDI: 00007ffe483=
3c310
[ 2186.277663] RBP: 00007ffe4833a660 R08: 00000000000001ff R09: 00000000000=
00001
[ 2186.277668] R10: 000055776dfb5252 R11: 0000000000000246 R12: 00007ffe483=
3c310
[ 2186.277673] R13: 00007ffe4833c2dc R14: 00007ffe4833c319 R15: 00007ffe483=
3c318
[ 2186.277688]  </TASK>
