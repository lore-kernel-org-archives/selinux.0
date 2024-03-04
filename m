Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0079922
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579979; cv=none; b=nZDWtCzcspGDQ8UZ+2Tq7LYH8TVkoQ6bTJvM4cgKDY2dhWIAox0uPOYBMi/Qiz/GJ6B/DAcgy3iOETcwPA9hQ83AqpWlH2cXYOzaYrbhET273zSuR77NC814Ocagr9nPYAE/xLblPoqYqpD7aWM7R/ddCN0ekqvhrJ3XvD/cF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579979; c=relaxed/simple;
	bh=7LPawVZLNip6K+RmAPmUu8Jdw+G5W8QZcvp9olAVT0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCbXzlfNeLqmhhI3UpvHHZiWywh0d2/ZKVeJylw9nmRHgvldmExJOZqF9tcDrQbQRfEK2UdSH3uK+1WYhV6kn0g0OG2OifiWAs4MAytzCmp24zc85sKyc3Os+za4k9tFHqAjfrC1zGKuVgzXlHqSBMYfIoKXDG9wVgMw5EeNKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=doaDlzIR; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="doaDlzIR"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so4854503276.2
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709579977; x=1710184777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1/Q0Q90PER+TJEKaUvNV6rDrirnRteBoJxWlPsRQ80=;
        b=doaDlzIR4NUPd+pLgCaB5kmpyqR4ScEGT6ZAorgmKB6hJo/esvFK4z+hRC6ZvELUF6
         BlI0dycNEZ9QsJbru4Q77Ep6waJFhvmSYeq1nmzsramcNQV6RjTFTelcR3e+Q8cevb0G
         pGo0l3UOmM4vRC0K3nPMqBIxfXVGlw42p7+NF6g7Qs2M8ZlfyKp/4MgSSfNib1KvctQx
         l3zOOeVrBtdPXVPJqBi+hvMdqGvkC2qSmVBPTcqg51qaLr5pSm/vBLxMRG9eHs4s5OmY
         xkCOpgU2JmMKGqEtfMykfdhrLFUqOgB/1JYYSIY8rU3FF2kxWXc1sHa947OTGBukL3RL
         h0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579977; x=1710184777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1/Q0Q90PER+TJEKaUvNV6rDrirnRteBoJxWlPsRQ80=;
        b=cybClIMrp5nLmrel9Tp+P4SSlwMHA9qtfAQXpVuug0NYfvpvZlel4sDSPFW++aGygN
         Fv6z9yFbGXch2eFi6EvqjjAq7wis7c9vzzy2dzmV+rt4slGbvQlE6nesL4zxXC/H+Wxz
         OhtBDauCtWryrkW1XiZIhZCOJNXqjb4w+j4U7tYGC9viYIkYdwZW8zWEHp3nTLgkuKOK
         Aryh4b8NkZyJV/RsW+pcgLP73/vW1M0Ivv6ciFBE1yzxe096uITKIiRXyAhzDFEId8ES
         N33P0uCSeHANA8kOOM/PGgHh0zB1e3/r/Eikz2z7PHMphYwmqrpTbWDIlU5bzE+i9HWq
         gFYw==
X-Forwarded-Encrypted: i=1; AJvYcCV3WRUXFj4Gr82RwIxvbM6KpuawnPnfmCgg/NhDwiwM9JBsd3czcCA80tHmv+8GWfeg0R4M7sKGza1IVJHUA00yrX4RN7T68g==
X-Gm-Message-State: AOJu0Yx548f7us7jTRUz+9o+ufQSj138r+cIBHojg922tyOGomJgo6b1
	A5IuAnAZOCFi+GOA6EDNfNBT0t6XldUeImGHJdToZ4qmaZeYeRXmeL8PlmtuuiEJh7O7nuHehc0
	TB3IyzBKRQ/BQLcgPATBvyNTgT363VmJXhdcU
X-Google-Smtp-Source: AGHT+IHsy4Ug1GmZxVAebzCOv35zLpvrjM8F51KCxoeTBuswRcebRzIcATWJFWzj1B5VjMjRVyYLQyo8YwhKHM0xJ24=
X-Received: by 2002:a25:8b01:0:b0:dcb:be59:25e1 with SMTP id
 i1-20020a258b01000000b00dcbbe5925e1mr7459905ybl.30.1709579977159; Mon, 04 Mar
 2024 11:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOh-5_KzWih=qUxynbn=mMz=UfnPi6UftbyT8+MTDP0jg@mail.gmail.com>
In-Reply-To: <CAEkJfYOh-5_KzWih=qUxynbn=mMz=UfnPi6UftbyT8+MTDP0jg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 Mar 2024 14:19:26 -0500
Message-ID: <CAHC9VhQ3crxcLXbT3fw2k7jYJFKy1VOm25npKpD9ZrwmwKzvJw@mail.gmail.com>
Subject: Re: [Bug] WARNING: zero-size vmalloc in sel_write_load
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	"xrivendell7@gmail.com" <xrivendell7@gmail.com>, syzkaller@googlegroups.com, selinux@vger.kernel.org, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:08=E2=80=AFAM Sam Sun <samsun1006219@gmail.com> wr=
ote:
>
> Dear developers and maintainers,
>
> We encountered a warning in function sel_write_load(). It is tested on
> kernel 6.8.0-rc7. Bug report is listed below.
>
> ```
> WARNING: CPU: 1 PID: 8109 at mm/vmalloc.c:3247
> __vmalloc_node_range+0x10a0/0x1490 mm/vmalloc.c:3247
> Modules linked in:
> CPU: 1 PID: 8109 Comm: syz-executor370 Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:__vmalloc_node_range+0x10a0/0x1490 mm/vmalloc.c:3247
> Code: 65 48 2b 04 25 28 00 00 00 0f 85 98 02 00 00 48 81 c4 70 01 00
> 00 4c 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 71 43 b7 ff 90 <0f> 0b
> 90 45 31 e4 eb a1 e8 63 43 b7 ff 48 8b 4c 24 40 31 f6 45 31
> RSP: 0018:ffffc90002adf9c0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff81cdc194
> RDX: ffff888022124ec0 RSI: ffffffff81cdd16f RDI: 0000000000000007
> RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff888107373a48
> R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc90002adfec8
> FS:  00005555560953c0(0000) GS:ffff888135c00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000010 CR3: 000000010503d000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  __vmalloc_node mm/vmalloc.c:3385 [inline]
>  vmalloc+0x6b/0x80 mm/vmalloc.c:3418
>  sel_write_load+0x27f/0x19d0 security/selinux/selinuxfs.c:603
>  vfs_write+0x2a9/0xd80 fs/read_write.c:582
>  ksys_pwrite64 fs/read_write.c:699 [inline]
>  __do_sys_pwrite64 fs/read_write.c:709 [inline]
>  __se_sys_pwrite64 fs/read_write.c:706 [inline]
>  __x64_sys_pwrite64+0x1f3/0x250 fs/read_write.c:706
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f40e7728f8d
> Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff5bf39508 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
> RAX: ffffffffffffffda RBX: 00007fff5bf39708 RCX: 00007f40e7728f8d
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 00007fff5bf39708
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fff5bf396f8 R14: 00007f40e77a6530 R15: 0000000000000001
>  </TASK>
> ```
>
> The cause of this bug is that in sel_write_load(), parameter "count"
> is controlled by user, which could be zero. It is passed to vmalloc()
> as an argument.
>
> If you have any questions, please contact us.
> Reported by: Yue Sun <samsun1006219@gmail.com>
> Reported by: xingwei lee <xrivendell7@gmail.com>

Everything appears to be working as expected, vmalloc() caught the
zero-length allocation request, emitted the warning, returned NULL to
sel_write_load(), and sel_write_load() handled the error condition
triggered by vmalloc(0) returning NULL.  Did you see any unexpected
behavior beyond this warning message above?

--=20
paul-moore.com
