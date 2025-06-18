Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13153B1AB
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258091; cv=none; b=kbs4THg967ioQiGom1Rn/avH3F2uVoM6UHVlgN29BoUQ+pYFdz9YAaw8AdHj2beo9a1kSeAInGsaAYXmUOYuw6P9Pf7h8dSTTVqlUd9EGz/rM5ZXHj0M+xu7NFFcx7e6tXeqaE58jv+laJ8ZztWA84qZiXNyMPhNhP5by8Ivn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258091; c=relaxed/simple;
	bh=CFD7EM1B7dveB/n1oenEJQ7ZJyE6MkhdXklOKaK1FTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFWpNivNVaqTN3Dy/d1amdGANIzycIC2Pxuj5c7vPz/waYbhN5W3buOhQDvmWIiecITOmKiEqRmhCpw/Z8YkpPBYAd0NzpDzt3LWe0u1WeyMzmMMycYSFvibRwdmntr7xT1rD9lcx1CwIKSXccEA5Ml7iphuRK01qZpS0jIzh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D9xxQpHI; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D9xxQpHI"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e447507a0so53404707b3.0
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750258087; x=1750862887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0nqmcz+C/uLT2LCqx4O5qi3rcAIoDvN2x0WB8gFKA/s=;
        b=D9xxQpHIGuFEq7ToaXP9LgQxK2KZb1MIwMHJzg9wT18LBFsg/Ul5aKGw8INkmx5Z8t
         Wj2aIRtq2QnUmtZkA8i5W3tczx76o7O5TGeiyvvcyrzb3TmQ+0WTnErmYbNQIAceFMSz
         Ag2etIbM2DuRbpamIUkyz0Zf7d3paVM37M7HXUanYq/DeIsdjefONfoweXNc7A4BpN38
         k+b8jRNtcWyDFz9KSdSau1/r+D3ChvrRsQNbLKswYkCbiCoRHx2HgtHkHNSsIWFAepqy
         9xblG89A66krxMM8Z4Hhq0aim/jwYmgRoWQVE0ShaoLsxQFvkKt26WlBycvS65Tesi1I
         icgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750258087; x=1750862887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nqmcz+C/uLT2LCqx4O5qi3rcAIoDvN2x0WB8gFKA/s=;
        b=R/y34D7SqjJflaskNmZWjWXxL96KWmmum2fAZ9goBapMPcF1FH1BNtc0GKthj0oauU
         Md93SlI3ziLhgbXhONtKRGr6+6IZA7JJScAd+9SEtgPmC5UXXNxtaSDFSvp7jL4BAgD0
         LBs2LVd1gRxMlaGU7xJHy2lQTDsIIstfP06NUyf3NHLaUPZ5g2gYmFW6gSPu1Jpxycrl
         9FFGm2IGAdNfIkhwFP0NHO/DdcJVELXoWFGgBrw0OUg93d+Gmt80EoDeqFJB5nx0BRyl
         83kWbg9G4+NHMylALHDQEh1ipFwqwAXLjgFtxIwaWyG+0297KM6iO8gYbuIwnONUZBoq
         fqkw==
X-Forwarded-Encrypted: i=1; AJvYcCU/sNzpucf5Qsm3irOelc752EyQQnIB0rp8e5oPx7TekEy5YOlnNum7RTQKUYyMnzLQ7ZwxZSfs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcc8hm/xGBc6jqYIqmPUQBCmNVWj+SE6GT2kKUKKp9Yy3OJOyU
	uVCYpUTbe2ENDw7jGJextyOgC2efiijvz7LFWLntVHtGa/lIkyTqCjMQLuhe5dfvdmCoESzr+78
	hAdKLOVdFFV4EMhZ+6swoRaA2/o2qeyIdxHuoynkF
X-Gm-Gg: ASbGncvima95OI9DMwz9ftaV6N+booGyoFIlwVh7EaHHyqhpnCGAuSR8Mx7BjVtq+61
	cKHdp1DoUarn9ik+ATiqRojPfVSILH5IF+6Z65VQoHaGIz8m0Onp+T9Vk4NcSlqkr3ywFwuG4aI
	sGNYFrSxhqluboXYvVDM441aOyBD3zowDzWkS81lQSEVc=
X-Google-Smtp-Source: AGHT+IFGjaMfuFyrioLFPLZq08soyqzY+bST42DECvYrqoAALSyrF8BC8JV/KZtqJz9LrXkObOrzesr8ksF2R/H8FyA=
X-Received: by 2002:a05:690c:3808:b0:70f:83ef:ddff with SMTP id
 00721157ae682-7117544368dmr269137437b3.30.1750258087575; Wed, 18 Jun 2025
 07:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6852ba08.050a0220.216029.0011.GAE@google.com>
In-Reply-To: <6852ba08.050a0220.216029.0011.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Jun 2025 10:47:56 -0400
X-Gm-Features: Ac12FXwM7ESYUG2Yj4RCDi85hG52oMXHOwbJt5vNBlSML3pPT9Ay9jgQ23PubUg
Message-ID: <CAHC9VhQkpNAsxy4rDf=qjwBrtCx5sXc74w5A=NU4R+8=FPa3Sw@mail.gmail.com>
Subject: Re: [syzbot] [selinux?] WARNING in hashtab_init
To: syzbot <syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000939fd30637d9b715"

--000000000000939fd30637d9b715
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

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
>  __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
>  ___kmalloc_large_node+0x84/0x1e0 mm/slub.c:4272
>  __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4300
>  __do_kmalloc_node mm/slub.c:4316 [inline]
>  __kmalloc_noprof.cold+0xc/0x61 mm/slub.c:4340
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  kmalloc_array_noprof include/linux/slab.h:948 [inline]
>  hashtab_init+0x1b1/0x290 security/selinux/ss/hashtab.c:43
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
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

--=20
paul-moore.com

--000000000000939fd30637d9b715
Content-Type: text/x-patch; charset="US-ASCII"; name="01-selinux-hashtab_gfpnowarn.patch"
Content-Disposition: attachment; 
	filename="01-selinux-hashtab_gfpnowarn.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mc22gbev0>
X-Attachment-Id: f_mc22gbev0

c2VsaW51eDogYWRkIF9fR0ZQX05PV0FSTiB0byBoYXNodGFiX2luaXQoKSBhbGxvY2F0aW9ucwoK
RnJvbTogUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4KCkFzIHJlcG9ydGVkIGJ5IHN5
emJvdCwgaGFzaHRhYl9pbml0KCkgY2FuIGJlIGFmZmVjdGVkIGJ5IGFibm9ybWFsbHkKbGFyZ2Ug
cG9saWN5IGxvYWRzIHdoaWNoIHdvdWxkIGNhdXNlIHRoZSBrZXJuZWwncyBhbGxvY2F0b3IgdG8g
ZW1pdAphIHdhcm5pbmcgaW4gc29tZSBjb25maWd1cmF0aW9ucy4gIFNpbmNlIHRoZSBTRUxpbnV4
IGhhc2h0YWJfaW5pdCgpCmNvZGUgaGFuZGxlcyB0aGUgY2FzZSB3aGVyZSB0aGUgYWxsb2NhdGlv
biBmYWlscywgZHVlIHRvIGEgbGFyZ2UKcmVxdWVzdCBvciBzb21lIG90aGVyIHJlYXNvbiwgd2Ug
Y2FuIHNhZmVseSBhZGQgdGhlIF9fR0ZQX05PV0FSTiBmbGFnCnRvIHNxdWVsY2ggdGhlc2UgYWJu
b3JtYWxseSBsYXJnZSBhbGxvY2F0aW9uIHdhcm5pbmdzLgoKUmVwb3J0ZWQtYnk6IHN5emJvdCti
YzJjOTljMjkyOWMzZDIxOWZiM0BzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tClNpZ25lZC1vZmYt
Ynk6IFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+Ci0tLQogc2VjdXJpdHkvc2VsaW51
eC9zcy9oYXNodGFiLmMgfCAgICAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NlbGludXgvc3MvaGFzaHRh
Yi5jIGIvc2VjdXJpdHkvc2VsaW51eC9zcy9oYXNodGFiLmMKaW5kZXggMzgzZmQyZDcwODc4Li4x
MzgyZWIzYmZkZTEgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L3NlbGludXgvc3MvaGFzaHRhYi5jCisr
KyBiL3NlY3VyaXR5L3NlbGludXgvc3MvaGFzaHRhYi5jCkBAIC00MCw3ICs0MCw4IEBAIGludCBo
YXNodGFiX2luaXQoc3RydWN0IGhhc2h0YWIgKmgsIHUzMiBuZWxfaGludCkKIAloLT5odGFibGUg
PSBOVUxMOwogCiAJaWYgKHNpemUpIHsKLQkJaC0+aHRhYmxlID0ga2NhbGxvYyhzaXplLCBzaXpl
b2YoKmgtPmh0YWJsZSksIEdGUF9LRVJORUwpOworCQloLT5odGFibGUgPSBrY2FsbG9jKHNpemUs
IHNpemVvZigqaC0+aHRhYmxlKSwKKwkJCQkgICAgR0ZQX0tFUk5FTCB8IF9fR0ZQX05PV0FSTik7
CiAJCWlmICghaC0+aHRhYmxlKQogCQkJcmV0dXJuIC1FTk9NRU07CiAJCWgtPnNpemUgPSBzaXpl
Owo=
--000000000000939fd30637d9b715--
