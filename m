Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCCB3FE7
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843521; cv=none; b=ShArO5q3+CXZHZHWAO7GV/bISm/5LPJYHgf8ZRTd5rt6/N9HRWQUVVy51WAZ65kdabDoxmWRwk5SDgi3s8FEjUcqIs3zIC4q8QpnyGOszLKYCBydL/8Js8X/yANIfazVbufWhevJJcJ5p++31OIajJyY8XtX3sD0UUR8iZ5RSuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843521; c=relaxed/simple;
	bh=8USoHdZGZDQR6j3eP+vbIY9gXAT7ZcukFU9B6LKf+gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbGf9Z51bWBKA/8HOPzeWoYuPvkNww/RL5dPIzeVIaa5KxN48Jwil7QE4scfzETRW8+linLUsnqGX9PuNpZRclr39JguCho+2rOaVLlcI0gUiR0GYYUROFBQF+AU6269jGQ2vYsOXIuNgzpOKSd5k2y/n3ZmSMw6bh5EjopjfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAB2mkQF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAB2mkQF"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7486ca9d396so1777490b3a.1
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749843519; x=1750448319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXSn66rVo6/j60KSlltH3KiqXPbpB7l6SyCN2tnUm9g=;
        b=YAB2mkQFC3yPhbUjjli6ge1s8nr0H/fj6zPtpuOhK21p7rfJ/AXiSSvJmkt5EldlSG
         XEnHmAjt5ZgN6G4o5zi13DIVCV04XX6R0NgJrG2gKRcMaDy15b/ZrkZx25eCM41qtkA5
         ZF09LRwORQOSirVCrSRpyAzJOlbDrVfVEDsqYwgzhSXe7dORebcEEQRkA2LMjc/7hfVb
         smtL9aiKrl3LDtDW75RAYhqxzvos/F4H1IKNXMR9Cf4kylCu7OuQbAgYG4a7ifa47Z0c
         IDM7et6d3nccb0GFZCjQwVeRQdz0iz6M2EUsl7mjxwuo0nR6o7w3D8NAE+1A91EdTKUr
         7Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749843519; x=1750448319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXSn66rVo6/j60KSlltH3KiqXPbpB7l6SyCN2tnUm9g=;
        b=YDmKvn68lEaNeRJER5D8PFXOs8qKDMNkPlaYrCwV+8R5Cos/SO7hlbD3IhMuhkdZY4
         hFfva74WffUs501BZtHPHz9mOZRM43XoSpHS+jO+kRBYcxabHeY8toZWQeC6+HmbuYz4
         l1ho9FVbQtDqqtvcUBsS5VycZ0S+V+oEKg9mqCnKIiaSs+o01Fn5danqJapfkH2v4Eix
         ro5i1IWzlKtONgGibfa93ypg6m2kzTrDvgiYFMrQGT2lPTHIi0UhEq1C1uDcUegP7smW
         2tmFze6GLM0qpJiq+R84c5/nVABRHnPn+hwU/LJFtTQ+sD4ZGzdQ2+HEGlMIKwq2967X
         AN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe0X1T1xVwnlXn2jQivQa/YBH5HsAZnd4OjXPk5k4Qn0A/CWLY+A0UtoCOcaxJ2Le4gwhJDwa4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3F4/JWoQTi7KpzljZTd5McDicOdOeaawUAJmWJLScxARp6nt
	+EH2KeVCOItTs02w7arcokrmwvxmkRKG98011Zf4Yg97J4xj68BtLyvsoX+lxOfiZWwN/Uxt7z0
	dv/rr2R4IIzyKdheibyXGcjjM3ZPOYJc=
X-Gm-Gg: ASbGncvaFedZoo1aj12S5T8+IoOw8wHgjRXbxPev5lvoOQxMgx3IGSEeO9K3T9t9/Oy
	V1MeUp5KuvSPwhWR2G6BIud5SNNu9KgH36CnfhqyWDlVp+Ur49OOeTH1jWBRGr/MpFgaguXdUVW
	yT9JovINNlGudePjhyijajMro4kuIvMKachjs7mhpUssoH64c0QFV+sQ==
X-Google-Smtp-Source: AGHT+IHBjKnu+0Obwbk/vBXyfbBxev9X3pT+M56usP+/iYS8TRMmzJvYru4+VEmTCyAMGpL/R06IBH7IjRh1L872pC8=
X-Received: by 2002:a05:6a00:148a:b0:736:b101:aed3 with SMTP id
 d2e1a72fcca58-7489cdeef7emr814163b3a.1.1749843518935; Fri, 13 Jun 2025
 12:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5veb_psQc_j=8c7Jz3H46twvnmZKy=8E8Bzq7pCinK7Q@mail.gmail.com>
 <CAEjxPJ6tA5+LxsGfOJokzdPeRomBHjKLBVR6zbrg+_w3ZZbM3A@mail.gmail.com>
 <CAEjxPJ799ZQkuqf79vDCq9guHE5BP2VwQDBNx6yeopNkU+rULQ@mail.gmail.com>
 <ac908c36-8967-45bd-b230-035fea9fe2fa@googlemail.com> <CAEjxPJ6sGGuG8ZZBkqjvjg4EKhPmpiiSottHVT6y0GOy9RLt+g@mail.gmail.com>
In-Reply-To: <CAEjxPJ6sGGuG8ZZBkqjvjg4EKhPmpiiSottHVT6y0GOy9RLt+g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Jun 2025 15:38:27 -0400
X-Gm-Features: AX0GCFtsYspL7cYfbeDP0vHwxKMu75_zlI_lZjEkRme8aGDMlT2i6Z7ZLY82vHw
Message-ID: <CAEjxPJ5ofF9xGNfi5kZhFcZQNJb-7HNLoeO3Kbidfgg4+-khBA@mail.gmail.com>
Subject: Re: UBSAN warning during selinux-testsuite inet_socket xfrm tests
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 12:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 13, 2025 at 12:00=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Jun 13, 2025 17:04:31 Stephen Smalley <stephen.smalley.work@gmail.com>:
> >
> > > On Fri, Jun 13, 2025 at 8:27=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > >>
> > >> Still need to confirm that I can reproduce on a stock kernel without
> > >> SELinux namespace patches, but FYI...
> > >
> > > Ok, confirmed that this is reproducible with 6.16.0-rc1. Updated UBSA=
N
> > > output below.
> > >
> > > [  388.060446] ------------[ cut here ]------------
> > > [  388.061112] UBSAN: array-index-out-of-bounds in security/selinux/x=
frm.c:99:14
> >
> > ctx->ctx_str[str_len] =3D '\0';
> >
> > The struct member ctx_str is annotated with __counted_by(str_len) so ac=
cessing it at str_len might trigger UBSAN (the field is allocated with a le=
ngth of str_len+1, so there is no actual out-of-bounds read).
>
> Hmm...tried adding one to ->str_len but didn't seem to silence the warnin=
g?

Figured it out, patch posted.

>
> >
> > > [  388.061138] index 60 is out of range for type 'char [*]'
> > > [  388.061158] CPU: 3 UID: 0 PID: 5043 Comm: ip Not tainted 6.16.0-rc=
1
> > > #393 PREEMPT(lazy)
> > > [  388.061162] Call Trace:
> > > [  388.061163]  <TASK>
> > > [  388.061167]  dump_stack_lvl+0x6e/0xa0
> > > [  388.061175]  ubsan_epilogue+0x5/0x2b
> > > [  388.061180]  __ubsan_handle_out_of_bounds.cold+0x54/0x59
> > > [  388.061186]  selinux_xfrm_alloc_user+0x145/0x150
> > > [  388.061194]  security_xfrm_state_alloc+0x3c/0x100
> > > [  388.061199]  xfrm_state_construct+0x251/0x3b0
> > > [  388.061208]  xfrm_add_sa+0x87/0x1f0
> > > [  388.061215]  xfrm_user_rcv_msg+0x1a9/0x3a0
> > > [  388.061218]  ? arch_stack_walk+0xb7/0x100
> > > [  388.061248]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
> > > [  388.061281]  netlink_rcv_skb+0x5c/0x110
> > > [  388.061296]  xfrm_netlink_rcv+0x38/0x50
> > > [  388.061299]  netlink_unicast+0x1e3/0x2c0
> > > [  388.061308]  netlink_sendmsg+0x222/0x460
> > > [  388.061318]  ____sys_sendmsg+0x3a2/0x3d0
> > > [  388.061321]  ? import_iovec+0x1b/0x30
> > > [  388.061331]  ___sys_sendmsg+0x99/0xe0
> > > [  388.061356]  __sys_sendmsg+0x8a/0xf0
> > > [  388.061368]  do_syscall_64+0x94/0x370
> > > [  388.061376]  ? audit_reset_context+0x298/0x300
> > > [  388.061382]  ? syscall_exit_work+0x195/0x1d0
> > > [  388.061387]  ? do_syscall_64+0x158/0x370
> > > [  388.061389]  ? find_held_lock+0x2b/0x80
> > > [  388.061395]  ? __lock_release.isra.0+0x59/0x170
> > > [  388.061397]  ? handle_mm_fault+0x2c6/0x450
> > > [  388.061404]  ? lock_release.part.0+0x1c/0x50
> > > [  388.061406]  ? do_user_addr_fault+0x375/0x6b0
> > > [  388.061414]  ? clear_bhb_loop+0x50/0xa0
> > > [  388.061417]  ? clear_bhb_loop+0x50/0xa0
> > > [  388.061421]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  388.061422] RIP: 0033:0x7feb13c1fa06
> > > [  388.061433] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75
> > > 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45
> > > 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 8=
3
> > > ec 08
> > > [  388.061434] RSP: 002b:00007ffc60961230 EFLAGS: 00000202 ORIG_RAX:
> > > 000000000000002e
> > > [  388.061436] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007=
feb13c1fa06
> > > [  388.061438] RDX: 0000000000000000 RSI: 00007ffc60961300 RDI: 00000=
00000000004
> > > [  388.061439] RBP: 00007ffc60961250 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  388.061440] R10: 0000000000000000 R11: 0000000000000202 R12: 00000=
00060962400
> > > [  388.061441] R13: 00000000684c3c09 R14: 00007ffc60961480 R15: 00007=
ffc60964264
> > > [  388.061454]  </TASK>
> > > [  388.072240] ---[ end trace ]---
> >
