Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54329149DE8
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827057; cv=none; b=noKTVBxz8SA6jEb6Jzq+vzneZGZp5B4nNau20Ulm4TCb73NQTXrUka9r/Z5qLqvXUzMJlWIy98MRC3zV7uHkfyqYUfyiOupIbP4174FCDPqp2jn5YJ2ToCH109BpAuw1QX/0o5LX4JDRjh/GyGHktQTJxPwSSoMN9yWGvXhlqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827057; c=relaxed/simple;
	bh=bD1en0JtQx9b+wTbBY5bioqchwbzyAlq2komS/BShb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QxoGW1fa12Jy2oIZU/9KYbpvRmqk4hSL3yms6M+Z9xI95mmGWgvOI4AMD63MZj0pBiVnhbzfi6w67pOu7QGmPDWGpnlNdC8+sMpgGQn21LDzFInpA/pEmO1bZUNvRk/gLe+Q5rGpJA1E+bfQYtgescgw5W40kbOiMW3iKPEk4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGe8kK/H; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGe8kK/H"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c035f2afso1638804b3a.2
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749827054; x=1750431854; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxWo+49vZwXf1RJBaxyNLjSvZBNcqUBlhLPUO5YvbIg=;
        b=HGe8kK/HBg8y2Vcn4GfrIxCuZYYtTxUAK7X5BglsKsE2ijU/YEM4+ePd/fJf9dPM+V
         K1Bp/7BQmdRl/rMNCbVQ54qbmGLGS9IZiJjhYUs2Fja/DX/jdbDejwNzZeiC587wQs4v
         6mqVvgmsr2OMTHOBLv2GoMXDbqWRfY67dcgAzyPkgZGaLy49bY8loYBli0itP51xzDVS
         rXut6DCylxEiZ0ll0OW/avD8As+AsGJPc75PLC0dDeP2WThxFzfqDiy0ECmWmidTT8+C
         gKNOEXhVFL4yzlPMTGO5n/V+uDHNGsstSeToA/4jlUCqLjN1R+g897PR6kIxS7uoec+r
         N91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827054; x=1750431854;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxWo+49vZwXf1RJBaxyNLjSvZBNcqUBlhLPUO5YvbIg=;
        b=gBriLNHHwu/DV2KehUPLboaWfgsE9HfISq+yTOJ6bIsh9jSLBKH9gZ9HPFN+JzV2tV
         1hmeXTBQkP1dvjnYJEXWPYLjdkiB1AaEhblB0ktfCmz5ZKEVGa04rzJEpCvor2DKL9eC
         Wvx2o9G9h9UZkRyjdotsDW1Vvh8yxGXrQznpJYCHOEVXPX/pLQEsW2gPSy9UcMB4lf50
         UNWoAzaqnc+UWrXI7c4SR10kdvJTyRWbojkeOvEHbh6idKngWvqdZbh7gd4pxKS+kFUE
         63VIYgf0nU2bPJEf9f15B6Ui+KH2QomgXelxQtbShvjO68PuVfCHxfzXDriGOJ8PYHDI
         Ec2g==
X-Forwarded-Encrypted: i=1; AJvYcCUCL+W6+stDktzuYMYspnG/5iryzfvd6HT412UDR2vdDcuIoGNELIbKr29rqOCEeP7LDzYfNk2F@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9edNIgQrMfQMOWA5kt3pSTJU6klPsLD6lIgJ3RniAdZKsPVd
	AHXiGUlGmoPQceSyzkfnoz5+WOPQeM4YhV9pLEwqXZDx2Ofj3dUelGqq+/V+IkaSAG0LLRtQgdA
	zpMqCakDFW+2Lijbls7IF+aTSVhSPLgU=
X-Gm-Gg: ASbGncuL/rNBvtbN2StX4XNswxrYfrTNAA2cff7CRRDVksZ7vhN7Rr9Xo5ima+n3SOx
	y1/rlXf8OoDAAGGaND5YZi0uhqrra7svyPGZmcPpQgrxq3/iLpsNbtJ3n/F/6i0CiDIP88r22pW
	BiTGrzCLbiwBXGXaj4kTS3jgvpwYer4ZLNM7TLvmBOALM=
X-Google-Smtp-Source: AGHT+IHrlUAlXvjObykcwoz6pfjCP7pyBKiWUfxWNpBNsk6LQ3QJy3f/L8ve77wnpN2XlRp1HSI3U6Pfr8PTvRIIS1Q=
X-Received: by 2002:a05:6a00:3928:b0:746:1b45:57a8 with SMTP id
 d2e1a72fcca58-7488f746778mr4237432b3a.22.1749827054284; Fri, 13 Jun 2025
 08:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5veb_psQc_j=8c7Jz3H46twvnmZKy=8E8Bzq7pCinK7Q@mail.gmail.com>
 <CAEjxPJ6tA5+LxsGfOJokzdPeRomBHjKLBVR6zbrg+_w3ZZbM3A@mail.gmail.com>
In-Reply-To: <CAEjxPJ6tA5+LxsGfOJokzdPeRomBHjKLBVR6zbrg+_w3ZZbM3A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Jun 2025 11:04:03 -0400
X-Gm-Features: AX0GCFtzqVMiSZUSG5pmtH1U1DfqwL--e-uj-XB_25Wpw4Xq0n_57VzVL9JyTwY
Message-ID: <CAEjxPJ799ZQkuqf79vDCq9guHE5BP2VwQDBNx6yeopNkU+rULQ@mail.gmail.com>
Subject: Re: UBSAN warning during selinux-testsuite inet_socket xfrm tests
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 8:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Still need to confirm that I can reproduce on a stock kernel without
> SELinux namespace patches, but FYI...

Ok, confirmed that this is reproducible with 6.16.0-rc1. Updated UBSAN
output below.

[  388.060446] ------------[ cut here ]------------
[  388.061112] UBSAN: array-index-out-of-bounds in security/selinux/xfrm.c:=
99:14
[  388.061138] index 60 is out of range for type 'char [*]'
[  388.061158] CPU: 3 UID: 0 PID: 5043 Comm: ip Not tainted 6.16.0-rc1
#393 PREEMPT(lazy)
[  388.061162] Call Trace:
[  388.061163]  <TASK>
[  388.061167]  dump_stack_lvl+0x6e/0xa0
[  388.061175]  ubsan_epilogue+0x5/0x2b
[  388.061180]  __ubsan_handle_out_of_bounds.cold+0x54/0x59
[  388.061186]  selinux_xfrm_alloc_user+0x145/0x150
[  388.061194]  security_xfrm_state_alloc+0x3c/0x100
[  388.061199]  xfrm_state_construct+0x251/0x3b0
[  388.061208]  xfrm_add_sa+0x87/0x1f0
[  388.061215]  xfrm_user_rcv_msg+0x1a9/0x3a0
[  388.061218]  ? arch_stack_walk+0xb7/0x100
[  388.061248]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
[  388.061281]  netlink_rcv_skb+0x5c/0x110
[  388.061296]  xfrm_netlink_rcv+0x38/0x50
[  388.061299]  netlink_unicast+0x1e3/0x2c0
[  388.061308]  netlink_sendmsg+0x222/0x460
[  388.061318]  ____sys_sendmsg+0x3a2/0x3d0
[  388.061321]  ? import_iovec+0x1b/0x30
[  388.061331]  ___sys_sendmsg+0x99/0xe0
[  388.061356]  __sys_sendmsg+0x8a/0xf0
[  388.061368]  do_syscall_64+0x94/0x370
[  388.061376]  ? audit_reset_context+0x298/0x300
[  388.061382]  ? syscall_exit_work+0x195/0x1d0
[  388.061387]  ? do_syscall_64+0x158/0x370
[  388.061389]  ? find_held_lock+0x2b/0x80
[  388.061395]  ? __lock_release.isra.0+0x59/0x170
[  388.061397]  ? handle_mm_fault+0x2c6/0x450
[  388.061404]  ? lock_release.part.0+0x1c/0x50
[  388.061406]  ? do_user_addr_fault+0x375/0x6b0
[  388.061414]  ? clear_bhb_loop+0x50/0xa0
[  388.061417]  ? clear_bhb_loop+0x50/0xa0
[  388.061421]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  388.061422] RIP: 0033:0x7feb13c1fa06
[  388.061433] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75
19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45
10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83
ec 08
[  388.061434] RSP: 002b:00007ffc60961230 EFLAGS: 00000202 ORIG_RAX:
000000000000002e
[  388.061436] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007feb13c=
1fa06
[  388.061438] RDX: 0000000000000000 RSI: 00007ffc60961300 RDI: 00000000000=
00004
[  388.061439] RBP: 00007ffc60961250 R08: 0000000000000000 R09: 00000000000=
00000
[  388.061440] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000609=
62400
[  388.061441] R13: 00000000684c3c09 R14: 00007ffc60961480 R15: 00007ffc609=
64264
[  388.061454]  </TASK>
[  388.072240] ---[ end trace ]---
