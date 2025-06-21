Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA181DE2B4
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750531255; cv=none; b=uE1FsPFnAgI/lAYk3Sk4oJmBds7b+LhFi0qcJO02ifHcXLXDahg9KUzHZDKJekeq8bROgaOVN7la7JEACfPMINVAwDrJJydLIvQJ341bxKdNz2EFlfZkZZ/MHcexjgh0OnKreoHhu/Nkp68AIdqI38q1sePBdMDONy6Py0uiDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750531255; c=relaxed/simple;
	bh=4IFnmRIRAD36GeJm9EbPuQqG0BlFVpCjTDm4wRRolng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVYDHdpv8vm/OiZtNCGASqxk+BNvQ+jZ4oH8E+nurHLfQwJHi4rJwZyEciwm9MfwJACo+IkXLIN7TLjp2A9PUJZF0l1op1mv6uVXHr23qxZiu8+IibC4wPiUbQuH8oaWx5ZEEvlyawWXvf0HKSUkI/1FAHRzZlXaNJmfDux8CCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cppRlAN0; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cppRlAN0"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70f862dbeaeso27502397b3.1
        for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750531252; x=1751136052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O7eGR/KeBgpF+haXdt/+l6begHBWoxBFv4KjhqCQCo=;
        b=cppRlAN0up3EOGk8Z6bEU/uJa9Ltr2JjlquwoTWEEpzv0q7CSZpGM2LoQ+RdBLABfa
         k4jA7eFy5NIXUU9mM4288abdptuA0X+N/4/rUl5GRXGQ6yMRA4oqVOkzL9p0oqf2galo
         eQitpU48BNLRQi/3/LSzs8FvGmmtBFN8vhLXm7RoTwQ1gnAu5a7Eyl+7TLMTWwv+BCXU
         MWAiNg+DnkMD+z5CZuqEuRwURMdxng6AfiP7xHoM/bC3aFQZ6Gxjx56irSaeNSAzaMd7
         9Rz50IJpAO4+8DgZWc4P6d2pAscpw30nnstVGnfyWgbRM+4PCTEex0rbAqZiRb9J30i9
         WUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750531252; x=1751136052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O7eGR/KeBgpF+haXdt/+l6begHBWoxBFv4KjhqCQCo=;
        b=nICQac9RJjts0QWI0HO2eCGFYhugDBEfZhHmzD8vTbc6bbUoNJg52/GWN/hcZ2594i
         Knxz3g+1GdbJtr9BJRWQhI8DX1sxUJx4JMmy6+R3fjtshVPFUdYX5klL0JL5tzzYYK8z
         lCjIQZ5jljyyYNLvTjZVzcvPbq17s5XSNieCV3mMVXdlI/3+GiSJkFR1ZlwqzEHyNqhB
         2qIlRhR5x106Vf5juC/wu5LjBNMpa3yZCO0s++cpRVDXeJYjm5eK9OtAtsithRbtNBOW
         G9CsN6b8+kHmRhKO7DZZC10g8LiwRqTX6vn7tjS2es0/D27XSm7aVXvIGiJXnghKiJmR
         L63A==
X-Forwarded-Encrypted: i=1; AJvYcCU5N1kn8jiHtW3JoNQhvx4n5En5g/HomOKv4CAllCSF9dZhtDgcWekaOUFep3BnL2tRdPX7K1z+@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYotMnO36bOpvaMeWZDttjlADRxI8tuVvvWqqRpp9AFPAp/28
	gfu0fkDcZRWALC3vS1YEDEAytjzbAFajfLiwdjOEKF41SbZAh5LrSU1BUqQyhfcw/i80SnOqeAC
	nPstNRi3uZ3LGyoSZn4bFJMh53zLSFt0SQnNj/hVyu4xpZboqHUTCZg==
X-Gm-Gg: ASbGncudqjVDrSMt8HDr35jrVEr0MnC52OwulKd8FtjU8LveLPDYGAQ9vCYHc2hxkyi
	9cdY+Szb4KrGM12Rr39d6evzoevxVdSafw/nxc7IoI2FcgUGlTzaXu2061TYoBCQ7Xt/JT2RE29
	qyaHld76hfGvWCNR+Jy5ZySuzrbwkSwJ7xR0kIZLqf4jHqxsbR8/VSvw==
X-Google-Smtp-Source: AGHT+IF0c9odPRdWSovZcikaBVGemDRVGjDCgc17+FAFopNT4am5rDQAzDB6W7LMoV/InAU0yDlZ9uni9IAfjBq5EEc=
X-Received: by 2002:a05:690c:1a:b0:70e:1771:c165 with SMTP id
 00721157ae682-712c6512becmr96547347b3.29.1750531252250; Sat, 21 Jun 2025
 11:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFj5m9KOjqYmUOYM4EgDBrJ-rQxEgOhm+pokmdAE6w+bCGrhSg@mail.gmail.com>
In-Reply-To: <CAFj5m9KOjqYmUOYM4EgDBrJ-rQxEgOhm+pokmdAE6w+bCGrhSg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 21 Jun 2025 14:40:41 -0400
X-Gm-Features: Ac12FXxeC20nX9RGwhzbmW8A0ou1VC59sEjorGCGrwEZVDINxaAlTfaMP1f-2EI
Message-ID: <CAHC9VhQ0dyqsjsNt98yiPCGsiuUXep3T7T24LWWRHy8V8xjV4Q@mail.gmail.com>
Subject: Re: [v6.16-rc2+ Bug] panic in inode_doinit_with_dentry during booting
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 2:08=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Hello Guys,
>
> The latest v6.16-rc2+ kernel panics during booting, commit
> 3f75bfff44be ("Merge tag 'mtd/fixes-for-6.16-rc3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux"):
>
>
> [  OK  ] Finished systemd-modules-load.service - Load Kernel Modules.
>          Starting systemd-sysctl.service - Apply Kernel Variables...
>          Starting systemd-sysusers.service - Create System Users...
> [  OK  ] Finished systemd-sysctl.service - Apply Kernel Variables.
> [    1.851473] Oops: general protection fault, probably for
> non-canonical address 0x8cbad568292ed62c: 0000 [#1] SMP NOPTI
> [    1.853362] CPU: 9 UID: 0 PID: 269 Comm: systemd-sysuser Not
> tainted 6.16.0-rc2+ #328 PREEMPT(full)
> [    1.854923] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-1.fc39 04/01/2014
> [    1.856374] RIP: 0010:__list_add_valid_or_report+0x1e/0xa0
> [    1.857366] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
> 53 48 83 ec 08 48 85 f6 0f 84 76 2f 76 ff 48 89 d3 48 85 d2 0f 84 5c
> 2f9
> [    1.860338] RSP: 0018:ffffd152c0de3a10 EFLAGS: 00010286
> [    1.861244] RAX: ffff8aa5414d38d8 RBX: 8cbad568292ed624 RCX: 000000000=
0000000
> [    1.862439] RDX: 8cbad568292ed624 RSI: ffff8aa5401f40f0 RDI: ffff8aa54=
14d38d8
> [    1.863622] RBP: ffff8aa5414d38f4 R08: ffffd152c0de3a7c R09: ffffd152c=
0de3a20
> [    1.864810] R10: ffff8aa5401f40c0 R11: 0000000000000007 R12: ffff8aa54=
14d38d8
> [    1.864813] R13: ffff8aa5401f40c0 R14: ffff8aa5401f40f0 R15: ffff8aa54=
14d38d0
> [    1.864814] FS:  00007feebef42bc0(0000) GS:ffff8aa9ed02f000(0000)
> knlGS:0000000000000000
> [    1.864816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.864818] CR2: 00007feebfb58180 CR3: 0000000117f4d004 CR4: 000000000=
0770ef0
> [    1.870018] PKRU: 55555554
> [    1.870020] Call Trace:
> [    1.870029]  <TASK>
> [    1.870031]  inode_doinit_with_dentry+0x42d/0x520

Thanks for the report.  I'm assuming you didn't see this with
v6.16-rc1, or earlier?

Do you have any line number information you could share?  Also, based
on the RIP in __list_add_valid_or_report(), can you confirm that this
is either happening in an initrd/initramfs or on a system where a
SELinux policy is not being loaded?

> [    1.870035]  security_d_instantiate+0x93/0xb0
> [    1.870038]  d_instantiate+0x2e/0x60
> [    1.870043]  ramfs_mknod+0x58/0xb0
> [    1.870047]  path_openat+0xf53/0x1200
> [    1.870050]  do_filp_open+0xd7/0x190
> [    1.870053]  ? _raw_spin_unlock+0xe/0x30
> [    1.870055]  do_sys_openat2+0x8a/0xe0
> [    1.870058]  __x64_sys_openat+0x54/0xa0
> [    1.870060]  do_syscall_64+0x84/0x2c0
> [    1.870063]  ? __x64_sys_openat+0x54/0xa0
> [    1.870064]  ? do_syscall_64+0x84/0x2c0
> [    1.870066]  ? do_sys_openat2+0xa4/0xe0
> [    1.870068]  ? __x64_sys_openat+0x54/0xa0
> [    1.870069]  ? do_syscall_64+0x84/0x2c0
> [    1.870070]  ? handle_mm_fault+0x1d7/0x2e0
> [    1.870074]  ? do_user_addr_fault+0x211/0x680
> [    1.870077]  ? clear_bhb_loop+0x50/0xa0
> [    1.870079]  ? clear_bhb_loop+0x50/0xa0
> [    1.870080]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    1.870082] RIP: 0033:0x7feebf965e63
> [    1.870084] Code: 83 e2 40 75 52 89 f0 f7 d0 a9 00 00 41 00 74 47
> 80 3d 50 22 0e 00 00 74 62 89 da 4c 89 e6 bf 9c ff ff ff b8 01 01 00
> 008
> [    1.870085] RSP: 002b:00007ffd85a4c5d0 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000101
> [    1.870087] RAX: ffffffffffffffda RBX: 00000000000a0141 RCX: 00007feeb=
f965e63
> [    1.870088] RDX: 00000000000a0141 RSI: 000055ed496c4f10 RDI: 00000000f=
fffff9c
> [    1.870089] RBP: 00007ffd85a4c640 R08: 00000000ffffff9c R09: 00007ffd8=
5a4c4f0
> [    1.870090] R10: 0000000000000180 R11: 0000000000000202 R12: 000055ed4=
96c4f10
> [    1.870091] R13: 0000000000000000 R14: 00007ffd85a4c6c0 R15: 000055ed2=
9c98940
> [    1.870092]  </TASK>
> [    1.870093] Modules linked in: scsi_dh_rdac scsi_dh_emc
> scsi_dh_alua ip6_tables ip_tables fuse dm_multipath qemu_fw_cfg
> [    1.870121] ---[ end trace 0000000000000000 ]---
> [    1.870123] RIP: 0010:__list_add_valid_or_report+0x1e/0xa0
> [    1.870127] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
> 53 48 83 ec 08 48 85 f6 0f 84 76 2f 76 ff 48 89 d3 48 85 d2 0f 84 5c
> 2f9
> [    1.870127] RSP: 0018:ffffd152c0de3a10 EFLAGS: 00010286
> [    1.870129] RAX: ffff8aa5414d38d8 RBX: 8cbad568292ed624 RCX: 000000000=
0000000
> [    1.870130] RDX: 8cbad568292ed624 RSI: ffff8aa5401f40f0 RDI: ffff8aa54=
14d38d8
> [    1.870130] RBP: ffff8aa5414d38f4 R08: ffffd152c0de3a7c R09: ffffd152c=
0de3a20
> [    1.870131] R10: ffff8aa5401f40c0 R11: 0000000000000007 R12: ffff8aa54=
14d38d8
> [    1.870132] R13: ffff8aa5401f40c0 R14: ffff8aa5401f40f0 R15: ffff8aa54=
14d38d0
> [    1.870133] FS:  00007feebef42bc0(0000) GS:ffff8aa9ed02f000(0000)
> knlGS:0000000000000000
> [    1.870134] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.870135] CR2: 00007feebfb58180 CR3: 0000000117f4d004 CR4: 000000000=
0770ef0
> [    1.870137] PKRU: 55555554
> [    1.870138] Kernel panic - not syncing: Fatal exception
> [    1.870365] Kernel Offset: 0x3a000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [    1.898219] ---[ end Kernel panic - not syncing: Fatal exception ]---

--=20
paul-moore.com
