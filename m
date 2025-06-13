Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813311ACED7
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830453; cv=none; b=HBMIFadRv3q4CxUY0NIlm8Dxqel9OkxetiZOia3yaEdbE3jiKGHSiEV+ffth0UYAUxOZu88kaL5EjUZ8OsQyy7k7dBaf84yvDT3ax6lFt5jiWjTjIW2/3pvsrl3jO7cJhWGwvbExU20RrOvMqkiFshH9c1bIkPbDMRW+FIUc36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830453; c=relaxed/simple;
	bh=DdklC/K0guDOKec7pV1rt11Z2NHBNRku33gMmLHQMMI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UabZYvcjo0/JRxPsarMd0L0NS8aXdZKn21DzmAudj4+PQqdH/fpt/P9DArrkJXJSNjwXiCX3IDrVhN335NlbGi+8YEHI1F2YwwGU+Y/cCFPrtNcP7rXwfSIdVW5V7Jqoq67MvHAEqKK7MCbCH+g3PSOeiga38QSfqvHxTKmc1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JOdCwVy8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JOdCwVy8"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad572ba1347so359435166b.1
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1749830450; x=1750435250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdklC/K0guDOKec7pV1rt11Z2NHBNRku33gMmLHQMMI=;
        b=JOdCwVy8LPsD156UAbHRoRrckY39kSmfG3iqNf2wbqM51hyOhfoygaOY1oz1VXnEQG
         LJbEgOwiS8aFGw3PAzchevxWTSMEOUSPHBw3yfDYEGOJj0WtEolV6ngJyLKZ9DT+nrlv
         pW/nx5NXKzgH4ecuY0i28SKCopqPNom9ug1LC67b81/0mgws9sIEZdSnS9TreFKPPX5h
         OIhMsfFsPkcDjAzDppkzV5JKkYuStd+r+ZEbJpzfdKY3dHkXTxtSF45kk9mfLd0pCC7a
         SyTL7tjMQYOo9ZByylJVbp95MPchyfq8/A5igDj7U0kf/aBOU5v0v0guvgFZ6tW34xlg
         fqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749830450; x=1750435250;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DdklC/K0guDOKec7pV1rt11Z2NHBNRku33gMmLHQMMI=;
        b=PrALnw8YIFcLzitesIx0jbyZAXQreW3Rs5SgLjyKffghJMl83SPw+Vs+d6T8ldUgaN
         zb5/HUk2wBZeD7jcyQvOlq6PAIlsjhHaB+Crkdoo/WoHYN/E1v5jPIgEU+x8bnZRl5AV
         Y71qURwK3oPM3qpRhRalT5Pqi9BjjE+hl7ahwYzSYWr7Zea7gmR7ABYOWqtBLtf3TiRM
         Ake6MlaqsdejS/KqjoxIoVgZ1S3quxTPl5tC6b0j1OTnMS/OPGTDqbJfUVgBex+Nf5ly
         +57ooWntn1vBYeasbHOVUhjckBmZhiYPXVOQ2xcOnKA/+hpvtlWcdG2o2dv6eLFSSQui
         n+1A==
X-Forwarded-Encrypted: i=1; AJvYcCX8fezx7KX/aAK7K47aWEvHD/dtoz2Jr5Wcj1ZgTRM2jcvautrzz3Ynd9vDdISt0l0EYj7RWfPH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8weHCYEnVRkdu+0pU3MLi5i0Kfj44J5KqAhQFOYVIlGBnbAqE
	j8kBKvjjKXIqB9Vkwqz5tk38zodWNtDwKQ5mgLsdPIPVp2r3ppQd+iUV
X-Gm-Gg: ASbGnctW9YbQAYwX9VmNxn7bTr2wLcXNjYjS4v/Ty48CKTWJBNNlr5gxSONrF5TCHL2
	pV4GPDWa4+w5BZJjZa5ZwQ8zfcXbPOVeMQUBJo+r9BDPYdpovOSomlevhm5ZH0kV08M4pj8jPUD
	Jju1FLi5KYc0xij1vJtYF9jSxpXg+GXNSBbUC5wLxp4RR1hi1TnGUfyXB4jJ99ZoAsXulzCFC6m
	FmeDVAvSzce3+P3yJ1+t8ImhGXG9gd6oBYLH3VmVHk5GZnByThqlcMXZ6TEKS8+++7Pxqi5RWhX
	+ezvq0JxWntbtPp+lsULKJc8uPLQ98PZW4SHqP+bCQqahJezsNhoGFfW9IapAwj5
X-Google-Smtp-Source: AGHT+IHlVP34wPFQHa4z/cuZbYpEt14jAP0WaAdJZhDEVpvB8aqQNSkQkfmxw6x7xYLYLvpUIPpAng==
X-Received: by 2002:a17:907:6d0e:b0:ade:3eb6:3c6 with SMTP id a640c23a62f3a-adec5597782mr384384666b.15.1749830449350;
        Fri, 13 Jun 2025 09:00:49 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.240.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf8b393ea8sm19072166b.159.2025.06.13.09.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 09:00:48 -0700 (PDT)
Date: Fri, 13 Jun 2025 18:00:48 +0200 (GMT+02:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	SElinux list <selinux@vger.kernel.org>
Message-ID: <ac908c36-8967-45bd-b230-035fea9fe2fa@googlemail.com>
In-Reply-To: <CAEjxPJ799ZQkuqf79vDCq9guHE5BP2VwQDBNx6yeopNkU+rULQ@mail.gmail.com>
References: <CAEjxPJ5veb_psQc_j=8c7Jz3H46twvnmZKy=8E8Bzq7pCinK7Q@mail.gmail.com> <CAEjxPJ6tA5+LxsGfOJokzdPeRomBHjKLBVR6zbrg+_w3ZZbM3A@mail.gmail.com> <CAEjxPJ799ZQkuqf79vDCq9guHE5BP2VwQDBNx6yeopNkU+rULQ@mail.gmail.com>
Subject: Re: UBSAN warning during selinux-testsuite inet_socket xfrm tests
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <ac908c36-8967-45bd-b230-035fea9fe2fa@googlemail.com>

Jun 13, 2025 17:04:31 Stephen Smalley <stephen.smalley.work@gmail.com>:

> On Fri, Jun 13, 2025 at 8:27=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> Still need to confirm that I can reproduce on a stock kernel without
>> SELinux namespace patches, but FYI...
>
> Ok, confirmed that this is reproducible with 6.16.0-rc1. Updated UBSAN
> output below.
>
> [=C2=A0 388.060446] ------------[ cut here ]------------
> [=C2=A0 388.061112] UBSAN: array-index-out-of-bounds in security/selinux/=
xfrm.c:99:14

ctx->ctx_str[str_len] =3D '\0';

The struct member ctx_str is annotated with __counted_by(str_len) so access=
ing it at str_len might trigger UBSAN (the field is allocated with a length=
 of str_len+1, so there is no actual out-of-bounds read).

> [=C2=A0 388.061138] index 60 is out of range for type 'char [*]'
> [=C2=A0 388.061158] CPU: 3 UID: 0 PID: 5043 Comm: ip Not tainted 6.16.0-r=
c1
> #393 PREEMPT(lazy)
> [=C2=A0 388.061162] Call Trace:
> [=C2=A0 388.061163]=C2=A0 <TASK>
> [=C2=A0 388.061167]=C2=A0 dump_stack_lvl+0x6e/0xa0
> [=C2=A0 388.061175]=C2=A0 ubsan_epilogue+0x5/0x2b
> [=C2=A0 388.061180]=C2=A0 __ubsan_handle_out_of_bounds.cold+0x54/0x59
> [=C2=A0 388.061186]=C2=A0 selinux_xfrm_alloc_user+0x145/0x150
> [=C2=A0 388.061194]=C2=A0 security_xfrm_state_alloc+0x3c/0x100
> [=C2=A0 388.061199]=C2=A0 xfrm_state_construct+0x251/0x3b0
> [=C2=A0 388.061208]=C2=A0 xfrm_add_sa+0x87/0x1f0
> [=C2=A0 388.061215]=C2=A0 xfrm_user_rcv_msg+0x1a9/0x3a0
> [=C2=A0 388.061218]=C2=A0 ? arch_stack_walk+0xb7/0x100
> [=C2=A0 388.061248]=C2=A0 ? __pfx_xfrm_user_rcv_msg+0x10/0x10
> [=C2=A0 388.061281]=C2=A0 netlink_rcv_skb+0x5c/0x110
> [=C2=A0 388.061296]=C2=A0 xfrm_netlink_rcv+0x38/0x50
> [=C2=A0 388.061299]=C2=A0 netlink_unicast+0x1e3/0x2c0
> [=C2=A0 388.061308]=C2=A0 netlink_sendmsg+0x222/0x460
> [=C2=A0 388.061318]=C2=A0 ____sys_sendmsg+0x3a2/0x3d0
> [=C2=A0 388.061321]=C2=A0 ? import_iovec+0x1b/0x30
> [=C2=A0 388.061331]=C2=A0 ___sys_sendmsg+0x99/0xe0
> [=C2=A0 388.061356]=C2=A0 __sys_sendmsg+0x8a/0xf0
> [=C2=A0 388.061368]=C2=A0 do_syscall_64+0x94/0x370
> [=C2=A0 388.061376]=C2=A0 ? audit_reset_context+0x298/0x300
> [=C2=A0 388.061382]=C2=A0 ? syscall_exit_work+0x195/0x1d0
> [=C2=A0 388.061387]=C2=A0 ? do_syscall_64+0x158/0x370
> [=C2=A0 388.061389]=C2=A0 ? find_held_lock+0x2b/0x80
> [=C2=A0 388.061395]=C2=A0 ? __lock_release.isra.0+0x59/0x170
> [=C2=A0 388.061397]=C2=A0 ? handle_mm_fault+0x2c6/0x450
> [=C2=A0 388.061404]=C2=A0 ? lock_release.part.0+0x1c/0x50
> [=C2=A0 388.061406]=C2=A0 ? do_user_addr_fault+0x375/0x6b0
> [=C2=A0 388.061414]=C2=A0 ? clear_bhb_loop+0x50/0xa0
> [=C2=A0 388.061417]=C2=A0 ? clear_bhb_loop+0x50/0xa0
> [=C2=A0 388.061421]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0 388.061422] RIP: 0033:0x7feb13c1fa06
> [=C2=A0 388.061433] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75
> 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45
> 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83
> ec 08
> [=C2=A0 388.061434] RSP: 002b:00007ffc60961230 EFLAGS: 00000202 ORIG_RAX:
> 000000000000002e
> [=C2=A0 388.061436] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000=
7feb13c1fa06
> [=C2=A0 388.061438] RDX: 0000000000000000 RSI: 00007ffc60961300 RDI: 0000=
000000000004
> [=C2=A0 388.061439] RBP: 00007ffc60961250 R08: 0000000000000000 R09: 0000=
000000000000
> [=C2=A0 388.061440] R10: 0000000000000000 R11: 0000000000000202 R12: 0000=
000060962400
> [=C2=A0 388.061441] R13: 00000000684c3c09 R14: 00007ffc60961480 R15: 0000=
7ffc60964264
> [=C2=A0 388.061454]=C2=A0 </TASK>
> [=C2=A0 388.072240] ---[ end trace ]---

