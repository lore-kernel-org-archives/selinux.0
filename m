Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F862E54B8
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252978; cv=none; b=bwSZLiQtnOxlpIyiWlwdCTBQZz3ycERaPHukv4NiK6pD8TXXaysv+63Wn4zXM2PWaDTWjVDTcAOeeS9zz/49MSuqhYZB6qvlYCcvUcbw8Y2KrLD3V98dVMAOjrl62MKUElebcjlSnEoV7X5eTtKH8SU2u8FLj/LyOpYAEamdzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252978; c=relaxed/simple;
	bh=4sVzlxLP/bZsoszLk8hSFb5vyq2fZ6rK+rSFQACgZ6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4WuBwuAE+ToYS+vY/HslwNEfEhPKsKhltozGLJHzkB3NGx0aNqLGUgdtLrXM2D62qH04eFvmZ+pzYiSYY/9P3lz70xH3rkiiwQc1MuwzR+/QyWkS2f+bqymB3C09rHP7zNidZMuLLrWOhR1GT95ioslTwIMbb+L6Ls18YQavh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WHsGPgKP; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WHsGPgKP"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so6034354276.3
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750252976; x=1750857776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drH9Y3tf+LSgM8baU4lopr0u6fbWMBKIJnj055I6/lU=;
        b=WHsGPgKP83yGRVorGfwYv1+xh46BH7m1aqr3q2CotAV5L1BlEs8TLfljYdqtWVW0j8
         Z9cRRhNMpkUkir1p/hcsDAMFr1ubfQt/OSxubNuEuphTANt/Lh7LL073i1MBg4prbQbD
         kJmaC16NKl9xno6b/Y6G1M7seD00zcbWn9uuvOU2nnbIYUj5kA0HTnUM14/Tf2EzC1CM
         8rTPdotul1+TJg5qHz2G7b0XDG36MIkF6lqqzfVHtUf6ldrYgD4qLvmvxC6UsQBtkmzB
         Dsq1vb/aHW8kINdA1z4TQ/G39ODjrb0yn7PNKmHY+f3LrQ97rqvmI4rVU8KMZozBdeN5
         mRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750252976; x=1750857776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drH9Y3tf+LSgM8baU4lopr0u6fbWMBKIJnj055I6/lU=;
        b=K3zcLMlibrgM27RWhOEuATUepybzfY+Wul1sZpJXQF0rVpJkLFeZ4O4UzXfryUKJk2
         I2TFdvbKJlvHoXgq1wSIHikgLx7tL8SduOoZz2pVRFiHf3bfonGqs2PLcVA+EXH8bGtj
         pcRhEY+1oFoRtRsI8OC+Ek604OksoX1NL5lABU+2FSx3IHRBQqrY9f1ID9eraYEMsmDD
         UFV4hxl6trLuzPM5f/XiqSypJXP9fXRXGcxmNPXS0Ysk7Ygc8vLM6m1/nu19Si4E/ZsM
         braZhF/UVF+ExxurflwyfnAzoRyynSWELr9L+3bIJSMfEE68fNmeiXMV9t2ZDixHrmrr
         i3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWkAAuu8BIw9Yu7v//iJroIKX12vvYExwGO8jC3/KxlVPwOp50NSuusSQlpDm2TMolWV+Zx8x2V@vger.kernel.org
X-Gm-Message-State: AOJu0YwYJbcJ28FoaJNhheO98vkVEUS1d5IbcEcXAiJmrCosiezeCUMF
	vAyb6mafcDnPdQgvuwoSqx8JSzh21teIPa+aCiMhigEukHMMgJx42L2b7JjxpSdyYPeNyEEh0qw
	TKMyKqx62LXR0JdzjmBM632YRJUDeYp5TUwi8iPbf
X-Gm-Gg: ASbGncu0LlZkMdmm3TcfwF23FFnLzn+GnxhIgcXns35f9k1RLGla10MW+ocxzn/7eGP
	2M2IAiA21Wljxx6qKNuW2vhCsNWbvYHvk32ahserhvAchBPO0Z2sZJb/e8XxJk1eTcxV2D0dL2W
	8I41njmsWVWlr8aTl0feWJhikJjYJvFkpW5QLMVTzAUQ4=
X-Google-Smtp-Source: AGHT+IFWMDFKDX7dwlLZnZslT/HeiGzOiWLxP7AZc3vtTIuwY8RU4GWriaQhueJM9cH+gEP6Tkk1JYfe/Zw4NbYkAnE=
X-Received: by 2002:a05:6902:220e:b0:e81:9581:4caa with SMTP id
 3f1490d57ef6-e822ad8bc0fmr23404196276.34.1750252975769; Wed, 18 Jun 2025
 06:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6852ba08.050a0220.216029.0011.GAE@google.com>
In-Reply-To: <6852ba08.050a0220.216029.0011.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Jun 2025 09:22:44 -0400
X-Gm-Features: Ac12FXxWXV5uy9kVJZxQnEU5kbkQBKDzOV7ISTVS6wOzhQkP9lyOkueHtfwc60Y
Message-ID: <CAHC9VhRSwtds1kJgreLOsvV0V5XXBS1jJ+UCsuAnXcgsEnPivg@mail.gmail.com>
Subject: Re: [syzbot] [selinux?] WARNING in hashtab_init
To: syzbot <syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 9:07=E2=80=AFAM syzbot
<syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    52da431bf03b Merge tag 'libnvdimm-fixes-6.16-rc3' of git:=
/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D144635d458000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4130f4d8a06c3=
e71
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbc2c99c2929c3d2=
19fb3
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12a1f50c580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1094050c58000=
0
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-52da431b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0ebc79a3dea1/vmlinu=
x-52da431b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2b1157e117a2/b=
zImage-52da431b.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com
>
> WARNING: CPU: 3 PID: 5931 at mm/page_alloc.c:4935 __alloc_frozen_pages_no=
prof+0x30b/0x23f0 mm/page_alloc.c:4935
> Modules linked in:
> CPU: 3 UID: 0 PID: 5931 Comm: syz-executor128 Not tainted 6.16.0-rc2-syzk=
aller-00047-g52da431bf03b #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> RIP: 0010:__alloc_frozen_pages_noprof+0x30b/0x23f0 mm/page_alloc.c:4935
> Code: f0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 83 fe 0a 0f 86 0a f=
e ff ff 80 3d 83 6e 7a 0e 00 75 0b c6 05 7a 6e 7a 0e 01 90 <0f> 0b 90 45 31=
 f6 eb 81 4d 85 f6 74 22 44 89 fa 89 ee 4c 89 f7 e8
> RSP: 0018:ffffc90003d87438 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000015 RDI: 0000000000040dc0
> RBP: 0000000200000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000040000000 R11: 0000000000000001 R12: 0000000000000015
> R13: 1ffff920007b0e9c R14: 0000000200000000 R15: 0000000000000015
> FS:  0000555574b0f380(0000) GS:ffff8880d6a53000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000001000 CR3: 000000002a80f000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __alloc_pages_noprof+0xb/0x1b0 mm/page_alloc.c:4993

Looks like another case where we should probably add GFP_NOWARN.

>  __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
>  ___kmalloc_large_node+0x84/0x1e0 mm/slub.c:4272
>  __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4300
>  __do_kmalloc_node mm/slub.c:4316 [inline]
>  __kmalloc_noprof.cold+0xc/0x61 mm/slub.c:4340
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  kmalloc_array_noprof include/linux/slab.h:948 [inline]
>  hashtab_init+0x1b1/0x290 security/selinux/ss/hashtab.c:43

This would be the right spot, in the kcalloc() call.  I'll throw
together a quick patch in a little bit.

>  common_read+0x1c2/0x3d0 security/selinux/ss/policydb.c:1172
>  policydb_read+0x874/0x3220 security/selinux/ss/policydb.c:2578
>  security_load_policy+0x15c/0x12c0 security/selinux/ss/services.c:2299
>  sel_write_load+0x332/0x1bd0 security/selinux/selinuxfs.c:603
>  vfs_write+0x2a0/0x1150 fs/read_write.c:684
>  ksys_write+0x12a/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0fd65a5d79
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc49f31638 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000200000000300 RCX: 00007f0fd65a5d79
> RDX: 0000000000002000 RSI: 0000200000000000 RDI: 0000000000000003
> RBP: 0000200000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000008f R11: 0000000000000246 R12: 00007f0fd65f419c
> R13: 00007f0fd65ef082 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>

--=20
paul-moore.com
