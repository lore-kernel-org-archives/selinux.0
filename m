Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033CE4962D
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378649; cv=none; b=YfpBBKViLkMh7b5PSTL8LVDGd2LFWTuiGdXiVVlIOAX4FrEKcNz4vBvxJvR9PkSV5ILme8jgHAZQcJAtoMxFH5blaDZVT1WsWF1H/QDC02yVYGm3exSc17mdcSceR6uMbZGgU5uNEjr2XfpdgqdQqNyxuffN1pE7IIYPt/QiXCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378649; c=relaxed/simple;
	bh=lJIyFaVIKB8twhbasEgiBgfBI0UJwQMVspM4IWW9VgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8IwhxwDeO/lTxpKjxhFRv184/eP+Yi6obDg6iOT9QDVBHNrbnJMAG61lMlQCy/STYs3c8cDPxwSzsDGkquQKxCUWxfDtx2g45TBkmT3j69lU6c6tnFBElldYzyNH9jKKhPqbUvdD5ZfMBaEySNc9qtuP/Sc6REsQlzNrKgK1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RcDs7UmB; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RcDs7UmB"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-633629c3471so86027b3.1
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718378646; x=1718983446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbkiPXT4MxSmCQlnWWtMAWfTXmL2YwvJtBSh1O/FRUo=;
        b=RcDs7UmBR+X66BLi5nF9F7QjsUDVHbr779fPRtVlkBAKzdkc5eW0rS8fOHFL1g+tV2
         JTjkG3Y3QMkislX6Lh5UzxltMKDGZzTQDDEg+Jfm5eVQ5Z/omJJCzPwrPothj0M2W4Rv
         kCpRHRzc08tNwvqIZOYW0FYPQj5//DxFU7ryUJJvKO/NHQoh6Pzgt++tmjS5PyuJvHmg
         1KASWN/ebY6CWsh8TOl+hKY4el2JYALGhUMjEaPwHimBHFRiSpUtS0Aa/yAeeJAi+RMR
         Z1s6SBdRhlMYLwtMPJ8/8iM26fQlk3tKzX6rc+9JVULRUHJhKFHXOzgN7OJVb1GVHe4w
         ftsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718378646; x=1718983446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbkiPXT4MxSmCQlnWWtMAWfTXmL2YwvJtBSh1O/FRUo=;
        b=RSLNPlUPCfKkFsPqZWwhrccr8LuHAUFRqaNxPs4pqMKKxP5v+GC9oW6sogVqazQD2D
         CWmeCuirh7rNaVAkOPn/HiqDyUo0+ZW0uP7WpnQVS6TxQ0DdxatwxUrPek2JwHDjEHcq
         YY8GvdQN7NhfhigrIKx9OapeePmKvvoNBSOzyIlriOrScYRrOGYFH59s+lCixh4DGHg8
         8FHEH1gQTqAQ/DnqKxeaYWFRMiGzPsepLs5EcQ1NIG23MYj8uqjU2dj5c2m9eVodrguS
         3TK5ndBW1B9t1p7BxzY0JF/xYyaGGPX48pbObEdjbExRNxLiwCekzrWGd0bLZj6qQCxb
         Zz9A==
X-Forwarded-Encrypted: i=1; AJvYcCX9kKZAg0cqTED4pqJx6DbuIl3R0eD39EzcXbmma5/1KzlOUfw/bpVQC8ErtBF0ZSS5jhPYvXeHhzOU9mkgQpuVdk8yPCVTew==
X-Gm-Message-State: AOJu0YwefITeneAs0yGtfnizKBQo9cDeNZ7r0XvK+tJj64prKmmHtS23
	qbY55JUMFVUWWoV5LBG0uT9/2iTgD4pVNjmHx/LELv+Eqo8OsyEOKieFgjKQLtTBhEaMEljHGHn
	/d3Sto8nCie00+RTFcIdBkRl5xiAsgjwwDrBp
X-Google-Smtp-Source: AGHT+IEEtceTiB1OcGqMTSUadReXSDQ5wj4dA4qlg4p4P11kb3Rcki8xqJ0+jlhG93OXu6jblV5j3ti0+b0TqsBYTGo=
X-Received: by 2002:a81:7383:0:b0:631:e680:b041 with SMTP id
 00721157ae682-63222a5561bmr27229667b3.31.1718378645505; Fri, 14 Jun 2024
 08:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507012541.796421-1-guozihua@huawei.com> <00d88046025c611f2bf94708ffc65ecc@paul-moore.com>
 <CAHC9VhRqvBsdy+U-wr+X6QmawLv6DnB32nwAO7Ex6L7cdR=mSg@mail.gmail.com> <8e898e2f5ae479ab08be61048481404d12cb6ea4.camel@huaweicloud.com>
In-Reply-To: <8e898e2f5ae479ab08be61048481404d12cb6ea4.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 14 Jun 2024 11:23:54 -0400
Message-ID: <CAHC9VhTwqAJFSRhaEGGiKz6sy71uiYq7M7ZDMaED3KxjigkimA@mail.gmail.com>
Subject: Re: [PATCH v3] ima: Avoid blocking in RCU read-side critical section
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: GUO Zihua <guozihua@huawei.com>, john.johansen@canonical.com, jmorris@namei.org, 
	serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, stephen.smalley.work@gmail.com, 
	casey@schaufler-ca.com, eparis@redhat.com, eric.snowberg@oracle.com, 
	omosnace@redhat.com, audit@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 5:50=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Thu, 2024-06-13 at 14:26 -0400, Paul Moore wrote:
> > On Wed, Jun 12, 2024 at 5:43=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On May  6, 2024 GUO Zihua <guozihua@huawei.com> wrote:
> > > >
> > > > A panic happens in ima_match_policy:
> > > >
> > > > BUG: unable to handle kernel NULL pointer dereference at 0000000000=
000010
> > > > PGD 42f873067 P4D 0
> > > > Oops: 0000 [#1] SMP NOPTI
> > > > CPU: 5 PID: 1286325 Comm: kubeletmonit.sh Kdump: loaded Tainted: P
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 0=
2/06/2015
> > > > RIP: 0010:ima_match_policy+0x84/0x450
> > > > Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39 7b 18 74 26 4=
1 83 ff 05 74 20 48 8b 1b 48 3b 1d f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73=
 10 74 ea 44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> > > > RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> > > > RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> > > > RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> > > > R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> > > > R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> > > > FS:  00007f5195b51740(0000) GS:ff3e278b12d40000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  ima_get_action+0x22/0x30
> > > >  process_measurement+0xb0/0x830
> > > >  ? page_add_file_rmap+0x15/0x170
> > > >  ? alloc_set_pte+0x269/0x4c0
> > > >  ? prep_new_page+0x81/0x140
> > > >  ? simple_xattr_get+0x75/0xa0
> > > >  ? selinux_file_open+0x9d/0xf0
> > > >  ima_file_check+0x64/0x90
> > > >  path_openat+0x571/0x1720
> > > >  do_filp_open+0x9b/0x110
> > > >  ? page_counter_try_charge+0x57/0xc0
> > > >  ? files_cgroup_alloc_fd+0x38/0x60
> > > >  ? __alloc_fd+0xd4/0x250
> > > >  ? do_sys_open+0x1bd/0x250
> > > >  do_sys_open+0x1bd/0x250
> > > >  do_syscall_64+0x5d/0x1d0
> > > >  entry_SYSCALL_64_after_hwframe+0x65/0xca
> > > >
> > > > Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> > > > ima_filter_rule_match()") introduced call to ima_lsm_copy_rule with=
in a
> > > > RCU read-side critical section which contains kmalloc with GFP_KERN=
EL.
> > > > This implies a possible sleep and violates limitations of RCU read-=
side
> > > > critical sections on non-PREEMPT systems.
> > > >
> > > > Sleeping within RCU read-side critical section might cause
> > > > synchronize_rcu() returning early and break RCU protection, allowin=
g a
> > > > UAF to happen.
> > > >
> > > > The root cause of this issue could be described as follows:
> > > > >     Thread A        |       Thread B        |
> > > > >                     |ima_match_policy       |
> > > > >                     |  rcu_read_lock        |
> > > > > ima_lsm_update_rule  |                       |
> > > > >  synchronize_rcu    |                       |
> > > > >                     |    kmalloc(GFP_KERNEL)|
> > > > >                     |      sleep            |
> > > > =3D=3D> synchronize_rcu returns early
> > > > >  kfree(entry)               |                       |
> > > > >                     |    entry =3D entry->next|
> > > > =3D=3D> UAF happens and entry now becomes NULL (or could be anythin=
g).
> > > > >                     |    entry->action      |
> > > > =3D=3D> Accessing entry might cause panic.
> > > >
> > > > To fix this issue, we are converting all kmalloc that is called wit=
hin
> > > > RCU read-side critical section to use GFP_ATOMIC.
> > > >
> > > > Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_ru=
le_match()")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> > > > Acked-by: John Johansen <john.johansen@canonical.com>
> > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > ---
> > > > v3:
> > > >   ima_lsm_copy_rule takes a GFP flag as input as well.
> > > > v2:
> > > >   Changed the audit_rule_init security hook to accept a new GFP fla=
g, as
> > > > per Stephen's suggestion.
> > > >
> > > > ---
> > > >  include/linux/lsm_hook_defs.h       |  2 +-
> > > >  include/linux/security.h            |  5 +++--
> > > >  kernel/auditfilter.c                |  5 +++--
> > > >  security/apparmor/audit.c           |  6 +++---
> > > >  security/apparmor/include/audit.h   |  2 +-
> > > >  security/integrity/ima/ima_policy.c | 15 +++++++++------
> > > >  security/security.c                 |  6 ++++--
> > > >  security/selinux/include/audit.h    |  4 +++-
> > > >  security/selinux/ss/services.c      |  5 +++--
> > > >  security/smack/smack_lsm.c          |  3 ++-
> > > >  10 files changed, 32 insertions(+), 21 deletions(-)
> > >
> > > With the exception of one small gotcha (see below), this looks okay t=
o
> > > me.  At Mimi's request I'm going to merge this into the LSM tree, via
> > > lsm/stable-6.10, where I'll give it a few days in linux-next before
> > > sending it up to Linus.
> >
> > I also had to apply the following fix to this patch to resolve the
> > !CONFIG_IMA_LSM_RULES ca
> > se ... grrrrr.
>
> Argh, sorry...

Not fun, but it happens.  Anyway, I was going to send this to Linus
today but I think I'm going to hold off until Monday as we likely lost
a day of linux-next testing due to the compilation bug.

--=20
paul-moore.com
