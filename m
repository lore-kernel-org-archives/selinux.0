Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C82E11B5
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832501; cv=none; b=GKdSam3+osbVqKqTU4odo3v9YALN4L505c302XHUATPj94SrWV6j/9BIYoDH+xShNyCn9mXdSG7oAW+DH6sDqWa7O+aDq3vGy1R9PAsNxRoYItgmCR5S4pFFtBj8iBB8MEhWyzTmUfTU5VlTvSAWww1T8GbO8Yku808G8LdP1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832501; c=relaxed/simple;
	bh=KIV//8xrNRU4NEUQEhivDuyVhakdOSj6+M1ELjIaPFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwkaRlEJTyo9ycswLSH9sfTr7KDLIRRNqLjpNItRdSEeVpfZlW2eXA8TXVGuETs0amslK5DMQswgA+6Wuesae8k0gKfW9J4t6Gkww37apYsRDJNdgVXLwKvz2HVMZf/60HWmZNprDQM51OmdRSdyrxLVWXkZms1TQmkHaxGIT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2B3EZ8s; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2B3EZ8s"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74800b81f1bso2058795b3a.1
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749832499; x=1750437299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtbvSVS37BBnSPmuzzTz/0elO6G1egK/lEFEV6PETn0=;
        b=H2B3EZ8sckUtFrHk6D/a3I7K8cdn1/S64YiOMZaqjr1S0m1/JdMYadHd9qvMqoqdjd
         Wy+IkhtDtv8+YLgmczmH6nsN4trp5YcUd5L6dpM8CyhdRG4DoCJgMHmFKt2RDDD4bIZx
         r5jXv5Cn60tg3MJhigUy+c2VZlPbFP5JRK4lVlbjdZsZfYSU17ei0jcSJO9w7UL+ldgg
         d+bxh1L3Qy0mDaibbmup7rMVX3LiRaisevdmHm2qwPHFtyj2mTVEOTh/v+gJwa4pOGUn
         fr0r8fg3Y46KrTP6N63wDFzIfPRA9RlhI9099xDJ9m0riqMfm+zBIBXCuKPrGWhGoQ/Y
         VxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749832499; x=1750437299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtbvSVS37BBnSPmuzzTz/0elO6G1egK/lEFEV6PETn0=;
        b=bIjD1fnDaefBUEEaPUMVDGoicFuXz+b1d5nIkcd3y1uXlPJkr90rMpfR5zObTVwys0
         9UoXYNzB9W9RdGA6udTzX+kAk5kXbbgAY1xme1gv0rKMHbdHoFOm6qxk6gKBepyZqzsK
         fvy399RrkxNHqDoDlSjN07aM6L1/0CJXODgKcefOTz4iPVRYHsfTn4/LyJ8Z7taTUgNR
         7UVXrda7rUtCOHOUezOYpjWujuzjDqsHrYi4hzPZ6J1O4VE5slX3r8m3Gb5cicEr1I2T
         Vmmtqs3YfCdTOwU/jfoiSk36o2f+bjbLIKx00U/BUNzE/7+gmKREzBcEk9qb4CkYoXsj
         s6Iw==
X-Forwarded-Encrypted: i=1; AJvYcCV7FcSNsADkXx1KJULWK/k42JfzYeja4RGHq78sCo2ZU856kSG9YhsDuIRX93L6o1C3DjGvro51@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfRjt8cT33MVQFo/3ayirWmoa0kdBEwxBVhuKA0F0cdecuOim
	4B+F7eR8n0n3chdCy4cJVtsxb+t/shnyeGYy7P7DDjmJKDFibV0l6qkVmrW7KW93nHucHzAqFhp
	RRTgCFIHKiIU5HNY7Z3X9cW6fghH0pID9eg==
X-Gm-Gg: ASbGncvhgTJNeUlY9Jc8wsNFzIhm2+3FIvG6DGi0iwWUYwuFalF+g0SuHTXLu44ucYi
	u6PrmHlD8TTu9cazdXjxf4EUZArnOvwHof5knkkx0smGEAT/p6fScfLcbx3V64gavliZpu391nY
	daFiPngZpzg7AlWYt03YjE02cALaCqEPWqOSxVo3sEJDXdD0gZRE3Ciw==
X-Google-Smtp-Source: AGHT+IE4kriPW4lQV4CutnaXH24Fpa4NaHUGsyhdOV6+I51u5pYhtaNhHzvUGb4mEwiiiRsqUt0iKtfWRWSq9zAmA5c=
X-Received: by 2002:a05:6a00:23d2:b0:742:4545:2d2b with SMTP id
 d2e1a72fcca58-7489ce015d7mr106574b3a.3.1749832499431; Fri, 13 Jun 2025
 09:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5veb_psQc_j=8c7Jz3H46twvnmZKy=8E8Bzq7pCinK7Q@mail.gmail.com>
 <CAEjxPJ6tA5+LxsGfOJokzdPeRomBHjKLBVR6zbrg+_w3ZZbM3A@mail.gmail.com>
 <CAEjxPJ799ZQkuqf79vDCq9guHE5BP2VwQDBNx6yeopNkU+rULQ@mail.gmail.com> <ac908c36-8967-45bd-b230-035fea9fe2fa@googlemail.com>
In-Reply-To: <ac908c36-8967-45bd-b230-035fea9fe2fa@googlemail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Jun 2025 12:34:48 -0400
X-Gm-Features: AX0GCFvR9V2owjG2zC72OOTeqtIUQUvGDTfIsM8sFWVIn1gQHLpXO_u7LhR7f80
Message-ID: <CAEjxPJ6sGGuG8ZZBkqjvjg4EKhPmpiiSottHVT6y0GOy9RLt+g@mail.gmail.com>
Subject: Re: UBSAN warning during selinux-testsuite inet_socket xfrm tests
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 12:00=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Jun 13, 2025 17:04:31 Stephen Smalley <stephen.smalley.work@gmail.com>:
>
> > On Fri, Jun 13, 2025 at 8:27=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> Still need to confirm that I can reproduce on a stock kernel without
> >> SELinux namespace patches, but FYI...
> >
> > Ok, confirmed that this is reproducible with 6.16.0-rc1. Updated UBSAN
> > output below.
> >
> > [  388.060446] ------------[ cut here ]------------
> > [  388.061112] UBSAN: array-index-out-of-bounds in security/selinux/xfr=
m.c:99:14
>
> ctx->ctx_str[str_len] =3D '\0';
>
> The struct member ctx_str is annotated with __counted_by(str_len) so acce=
ssing it at str_len might trigger UBSAN (the field is allocated with a leng=
th of str_len+1, so there is no actual out-of-bounds read).

Hmm...tried adding one to ->str_len but didn't seem to silence the warning?

>
> > [  388.061138] index 60 is out of range for type 'char [*]'
> > [  388.061158] CPU: 3 UID: 0 PID: 5043 Comm: ip Not tainted 6.16.0-rc1
> > #393 PREEMPT(lazy)
> > [  388.061162] Call Trace:
> > [  388.061163]  <TASK>
> > [  388.061167]  dump_stack_lvl+0x6e/0xa0
> > [  388.061175]  ubsan_epilogue+0x5/0x2b
> > [  388.061180]  __ubsan_handle_out_of_bounds.cold+0x54/0x59
> > [  388.061186]  selinux_xfrm_alloc_user+0x145/0x150
> > [  388.061194]  security_xfrm_state_alloc+0x3c/0x100
> > [  388.061199]  xfrm_state_construct+0x251/0x3b0
> > [  388.061208]  xfrm_add_sa+0x87/0x1f0
> > [  388.061215]  xfrm_user_rcv_msg+0x1a9/0x3a0
> > [  388.061218]  ? arch_stack_walk+0xb7/0x100
> > [  388.061248]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
> > [  388.061281]  netlink_rcv_skb+0x5c/0x110
> > [  388.061296]  xfrm_netlink_rcv+0x38/0x50
> > [  388.061299]  netlink_unicast+0x1e3/0x2c0
> > [  388.061308]  netlink_sendmsg+0x222/0x460
> > [  388.061318]  ____sys_sendmsg+0x3a2/0x3d0
> > [  388.061321]  ? import_iovec+0x1b/0x30
> > [  388.061331]  ___sys_sendmsg+0x99/0xe0
> > [  388.061356]  __sys_sendmsg+0x8a/0xf0
> > [  388.061368]  do_syscall_64+0x94/0x370
> > [  388.061376]  ? audit_reset_context+0x298/0x300
> > [  388.061382]  ? syscall_exit_work+0x195/0x1d0
> > [  388.061387]  ? do_syscall_64+0x158/0x370
> > [  388.061389]  ? find_held_lock+0x2b/0x80
> > [  388.061395]  ? __lock_release.isra.0+0x59/0x170
> > [  388.061397]  ? handle_mm_fault+0x2c6/0x450
> > [  388.061404]  ? lock_release.part.0+0x1c/0x50
> > [  388.061406]  ? do_user_addr_fault+0x375/0x6b0
> > [  388.061414]  ? clear_bhb_loop+0x50/0xa0
> > [  388.061417]  ? clear_bhb_loop+0x50/0xa0
> > [  388.061421]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  388.061422] RIP: 0033:0x7feb13c1fa06
> > [  388.061433] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75
> > 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45
> > 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83
> > ec 08
> > [  388.061434] RSP: 002b:00007ffc60961230 EFLAGS: 00000202 ORIG_RAX:
> > 000000000000002e
> > [  388.061436] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe=
b13c1fa06
> > [  388.061438] RDX: 0000000000000000 RSI: 00007ffc60961300 RDI: 0000000=
000000004
> > [  388.061439] RBP: 00007ffc60961250 R08: 0000000000000000 R09: 0000000=
000000000
> > [  388.061440] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000=
060962400
> > [  388.061441] R13: 00000000684c3c09 R14: 00007ffc60961480 R15: 00007ff=
c60964264
> > [  388.061454]  </TASK>
> > [  388.072240] ---[ end trace ]---
>
