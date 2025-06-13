Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8851E1DE7
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828227; cv=none; b=EC6/GqSxtUMqZGeEUKvIPyPWg36aH4M1RIqk2QLL4f3M+Z7gQHf1HmtJ/q42b1Qi1eJR/vcXAOWar9Oe5ZV7evKq7gWzVdnj4sTfyhETdoy+WQ8iZKkGYj5BhsQNRqJPveDneyFL4qDHjt7cxHFR0YA7fFQFZV2PCT7lP8BJzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828227; c=relaxed/simple;
	bh=NaRV9veRfxlM5TuTkFqs8+k6vgGVxFBpTWnVx0e8ASg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIOFjZBgOlCRk0u6gtKWdbCdhBmVEB1kNW90HO6fuoT8hEVcnQrMWWMjwYcxX2gwiqo2sYPfb/BB0b8IDgYp25g2TJXisIFlxjfkv9ljRn8yJk9lcm4HvIURukeEh8dKq/kg2kibXQHQngCEfsIqspfwwbzjySKg/RScf0Rnd30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HKGIf0Kr; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HKGIf0Kr"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-708d90aa8f9so21726557b3.3
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749828214; x=1750433014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex1kV4xJd3bLxQ+c8s6zCzHMKqqt9KPcf48jEIHbYBs=;
        b=HKGIf0Kr8uixmvV+/YkdUFl6iEaqnWJMIo/ifMqudm2vCquoVrsqoTouBINCfHP3kC
         bSWa3vuLy60XYfe4a0gH+dXPICZhfkF0nnY6+wnaoxq+jQfJp3npZz0cXAvUc1MjLF/w
         nej1GdBa8W70JaJdV7ZzoLPffzqLqRwPHaie0xCSqfWiWexPXFKXhuxlpkRDNtMvKaU0
         mAOcK7Ucjk1nnDz7YdAB5xiQiu1kxs0VXbhYXeEGXbmV+cIInKZdmOXMV+g/qPZIq9ty
         im3lDWy+7gFwL+KVWXssvGpK9OtFHNVpMp/RjEPIaYJK0m6iJjqWNDxIY7Sa9rpYUFND
         fNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749828214; x=1750433014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ex1kV4xJd3bLxQ+c8s6zCzHMKqqt9KPcf48jEIHbYBs=;
        b=biO6wFo4INJ7m+d4HfhObqJN9n4i2XSjYCDmMQFQtHT2RHjawbK0G6xdn0lSSS0gIV
         QhIKVwoi10eWy7J3kGF7QupSDBC5MRMV0Nui0jJwKCP21dJ+KzsqSyM/DltJcN+bouWV
         dfxoNufu1pdpUDkKGJWyXBa9mhQ2GKJLvIfvnCZjQVYwJdzn6FJeGaGjyPNuFhYsH6wI
         0ww1u5WJbXlcYeDvmxIwCsCXqmD0avgYBEQZZBy1h75RENj9M3r2gcLt5mVc6S11CFb2
         qDpvtaN1tuSSrd3vojWgLxv/VWff35yhB8UT+wkOsKofm4neaM1n7+fKw0DZQPBV7X2U
         z6kg==
X-Forwarded-Encrypted: i=1; AJvYcCXPQjMTQB65r6VZWzWHw23DmfW7FpbS5BApjsS6kYrkt35vaH02sOtK1EJbYQ/MeE+m+Uiv3RFJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxETcgG/98BLwLh+FQFuTYdef6xkOqRwbhufz9ef5tsLIKLErlF
	HNJvsNcb8l3vyNAbYuhOE/zAkFd0bG/znwys15aqmXJ4s+lgS2vWXuxBIQgzPTthVCY5BgnFHu1
	MmnZgwyc1NRi/WGu+CB4XExaSlYOstUS9R6O0T02I
X-Gm-Gg: ASbGnctWem4tGqbb3fJUEqFpnuAEJBagbjQ7AOjiIZZHQMJYevJGrQf7nZjvuIUE7Ki
	NcCuaho7d56izGy0Toy7MMMtXfJ6Gz9SS25rhk/sChmQgGRFps48Mnop9Ea5LZTvX1EfxVpRDP9
	gtwu6Vg02M3/6gdoW9yijgbh2F/vaBAQQ5rkw/tl1jEaQ=
X-Google-Smtp-Source: AGHT+IFzpRcYrgKPN9u7JqaLGwBRLBVW1jPSW/7BVM1IoP14EDms5ZjN5Mm2/QAEbCMYr9hu/hxo8zsN5QEu7tpsjBQ=
X-Received: by 2002:a05:690c:640b:b0:70d:f47a:7e3f with SMTP id
 00721157ae682-711637290acmr55610287b3.20.1749828214456; Fri, 13 Jun 2025
 08:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5veb_psQc_j=8c7Jz3H46twvnmZKy=8E8Bzq7pCinK7Q@mail.gmail.com>
 <CAEjxPJ6tA5+LxsGfOJokzdPeRomBHjKLBVR6zbrg+_w3ZZbM3A@mail.gmail.com> <CAEjxPJ799ZQkuqf79vDCq9guHE5BP2VwQDBNx6yeopNkU+rULQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ799ZQkuqf79vDCq9guHE5BP2VwQDBNx6yeopNkU+rULQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Jun 2025 11:23:23 -0400
X-Gm-Features: AX0GCFuVNlSY-CK5cSWsl34WCpbxM9fZ4Si0n02TL0bNIgCNtrG1SV3OSmeAUJ0
Message-ID: <CAHC9VhRWRRxriviRmcy2jZN-_jSBMrmrVjA0jCoVqOZeHcQAPg@mail.gmail.com>
Subject: Re: UBSAN warning during selinux-testsuite inet_socket xfrm tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 11:04=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Jun 13, 2025 at 8:27=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Still need to confirm that I can reproduce on a stock kernel without
> > SELinux namespace patches, but FYI...
>
> Ok, confirmed that this is reproducible with 6.16.0-rc1. Updated UBSAN
> output below.
>
> [  388.060446] ------------[ cut here ]------------
> [  388.061112] UBSAN: array-index-out-of-bounds in security/selinux/xfrm.=
c:99:14
> [  388.061138] index 60 is out of range for type 'char [*]'
> [  388.061158] CPU: 3 UID: 0 PID: 5043 Comm: ip Not tainted 6.16.0-rc1
> #393 PREEMPT(lazy)
> [  388.061162] Call Trace:
> [  388.061163]  <TASK>
> [  388.061167]  dump_stack_lvl+0x6e/0xa0
> [  388.061175]  ubsan_epilogue+0x5/0x2b
> [  388.061180]  __ubsan_handle_out_of_bounds.cold+0x54/0x59
> [  388.061186]  selinux_xfrm_alloc_user+0x145/0x150
> [  388.061194]  security_xfrm_state_alloc+0x3c/0x100
> [  388.061199]  xfrm_state_construct+0x251/0x3b0
> [  388.061208]  xfrm_add_sa+0x87/0x1f0
> [  388.061215]  xfrm_user_rcv_msg+0x1a9/0x3a0
> [  388.061218]  ? arch_stack_walk+0xb7/0x100
> [  388.061248]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
> [  388.061281]  netlink_rcv_skb+0x5c/0x110
> [  388.061296]  xfrm_netlink_rcv+0x38/0x50
> [  388.061299]  netlink_unicast+0x1e3/0x2c0
> [  388.061308]  netlink_sendmsg+0x222/0x460
> [  388.061318]  ____sys_sendmsg+0x3a2/0x3d0
> [  388.061321]  ? import_iovec+0x1b/0x30
> [  388.061331]  ___sys_sendmsg+0x99/0xe0
> [  388.061356]  __sys_sendmsg+0x8a/0xf0
> [  388.061368]  do_syscall_64+0x94/0x370
> [  388.061376]  ? audit_reset_context+0x298/0x300
> [  388.061382]  ? syscall_exit_work+0x195/0x1d0
> [  388.061387]  ? do_syscall_64+0x158/0x370
> [  388.061389]  ? find_held_lock+0x2b/0x80
> [  388.061395]  ? __lock_release.isra.0+0x59/0x170
> [  388.061397]  ? handle_mm_fault+0x2c6/0x450
> [  388.061404]  ? lock_release.part.0+0x1c/0x50
> [  388.061406]  ? do_user_addr_fault+0x375/0x6b0
> [  388.061414]  ? clear_bhb_loop+0x50/0xa0
> [  388.061417]  ? clear_bhb_loop+0x50/0xa0
> [  388.061421]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  388.061422] RIP: 0033:0x7feb13c1fa06
> [  388.061433] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75
> 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45
> 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83
> ec 08
> [  388.061434] RSP: 002b:00007ffc60961230 EFLAGS: 00000202 ORIG_RAX:
> 000000000000002e
> [  388.061436] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007feb1=
3c1fa06
> [  388.061438] RDX: 0000000000000000 RSI: 00007ffc60961300 RDI: 000000000=
0000004
> [  388.061439] RBP: 00007ffc60961250 R08: 0000000000000000 R09: 000000000=
0000000
> [  388.061440] R10: 0000000000000000 R11: 0000000000000202 R12: 000000006=
0962400
> [  388.061441] R13: 00000000684c3c09 R14: 00007ffc60961480 R15: 00007ffc6=
0964264
> [  388.061454]  </TASK>
> [  388.072240] ---[ end trace ]---

Unrelated, at least I think so, but still within the scope of
xfrm/IPsec, there was this issue that is still open:

https://lore.kernel.org/selinux/20241106155509.1706965-1-omosnace@redhat.co=
m

I'm not sure if Ondrej is planning to resolve that, but it would be
good to have that resolved too.

--=20
paul-moore.com
