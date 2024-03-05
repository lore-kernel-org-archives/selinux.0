Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820C2942A
	for <selinux@vger.kernel.org>; Tue,  5 Mar 2024 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709608571; cv=none; b=XXF76psxFKJhndirL7drH75k0xjic4du1hrFSzFpg16LhLzGUiQ6zgXCk1Ummm6jGAKcrjZqpPelNZLpQtGSyOWECvXH/90gsFRaCzQlxcFF5REUovkl5N1mvJB3HgmQPBO5qbeMcUJsZbb0CJq1XgT2wivFO+Cp9wSeQkud8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709608571; c=relaxed/simple;
	bh=c2sk0VFcnCsuF31J5pGzoOL8j/YgpO2w9eqyn/sHS78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Udc8lvwYsjx/hOysrhG+fOit4s/M7R19v2Ew48OcwQwT/R2kpv1kFIoUdyyHrgZDo/1SotRfbe494FOducGWUfsFPiDypylQ5E8bXpFz0AD4g+Crp98E4rXGLrebKwKxzVAD75w5+Jc5JyIfM6P9SfFSUyMc5OrpUUXUUTQ80Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C63bHxKA; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C63bHxKA"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso2054802276.3
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 19:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709608569; x=1710213369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59tgGsOfTMjasIt3jOiRpx2c/quM226l3o33rNYo2qg=;
        b=C63bHxKAIAJ9Z6DZzBzBg6zuuti361Rc+RRo8IhRQKz0RBX8opG8iz8TlBaRgeM7He
         cgTD0YpykVe27T0J0Q5iFERWFt2kU/9d6Vs2TU9jI7Shj6tYaUK9KbKHhBJTbVTfpfIR
         tdxtdFiYxGfSpDP87KawqQ7wIAn7fSs9pdzNoTj9ZC7qAO0TR2V+ppT9EtB2Aj7IrA18
         BFOjQs0ZWD4uZ4Xww9NqQJu70RMGUrhys0rMOKvs3OM4QedQQLMldy2YO+NSqbcog8JM
         /yAbG2jH8bYz8x87TqLts/2OG8PcafGjOMf1ejGLjawU0BrIWU1CZpfkW40QVBK3XZek
         eGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709608569; x=1710213369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59tgGsOfTMjasIt3jOiRpx2c/quM226l3o33rNYo2qg=;
        b=pZgbhkAoUILPJab+DtI+Da8sXzMRrORbsHP1K2ZSs2QP91udGEkqh4jbU5Xrj/tYpm
         gG3ANrV+IZEU25dN6EtWAS+XgbzLCsMs+OjIzNu2ulvZrUP0UbCHN1kOmgAQsCDqf7bX
         3szURHIGiSisEnJAuCwv1J2s7UgmVN+KVxrQJYRavTMqRG1VWQm47iRyBMfrGoWnzWuH
         AtTXpNhlwIuWy7TkVTaBkx+a72IsN7VPPLubWFGkLCSTFcXlSPrq7zGr+Z68zEGltb1u
         7EDlgCmA1FHs4CQrNBfPT/fylM8SMP54+uk61XDz0oLn8HizXE6WC7ZVp9VLWymhK0Ac
         YyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX50txAJgv5jJNMz/mybMlnGo2dhPqgXdjNmzW210pTdDhJOePMZGERLBdyU35ha0JgBLagExBHAsUuEfg4bdYzs/QGL6xZNw==
X-Gm-Message-State: AOJu0YwZ5vUB9El98vQyqzJ7Qh/+Jca3dkdPJM9BYpt/tLwlYJG6ScP4
	DpFNeeF99su4BiZM9MQXdpq+gPtDgVdc5fS27wXYZfbYwHLsB5dRS7JZ+YtcKTDxtmbHkuJ1D5Z
	7ikmaIXgpWCJTNzPiMUfdwOX//GXUYI4itZh6eQi3bW/oTLE=
X-Google-Smtp-Source: AGHT+IFxMqSmhPgZuyzlLT6eKAcjv/9kMEuhqS/7CKsxulr/UKgHFvDED5tnw3/WYhPYQCPt831qoNQrQyjbrzTjfk8=
X-Received: by 2002:a25:5806:0:b0:dc2:3f75:1f79 with SMTP id
 m6-20020a255806000000b00dc23f751f79mr8143003ybb.23.1709608568463; Mon, 04 Mar
 2024 19:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOh-5_KzWih=qUxynbn=mMz=UfnPi6UftbyT8+MTDP0jg@mail.gmail.com>
 <CAHC9VhQ3crxcLXbT3fw2k7jYJFKy1VOm25npKpD9ZrwmwKzvJw@mail.gmail.com>
 <CAJ2a_DcSurcF5_G-DjXL_0X=utasy2y8oJ_ywCms-Qhyy6GORQ@mail.gmail.com>
 <CAHC9VhQVqokvnnqLPc8tv0jpewnUKqnWeAzQs-sMj3BLrY5=CA@mail.gmail.com> <CAEkJfYOTNdu2rK-7F58sg7XuYk+trdGDBjYo-y0SusxmSeCkFA@mail.gmail.com>
In-Reply-To: <CAEkJfYOTNdu2rK-7F58sg7XuYk+trdGDBjYo-y0SusxmSeCkFA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 Mar 2024 22:15:57 -0500
Message-ID: <CAHC9VhS=izWYH7uaFcF9vre3GF06FitLXj0uUOKzMAwvq29OEw@mail.gmail.com>
Subject: Re: [Bug] WARNING: zero-size vmalloc in sel_write_load
To: Sam Sun <samsun1006219@gmail.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-kernel@vger.kernel.org, "xrivendell7@gmail.com" <xrivendell7@gmail.com>, 
	syzkaller@googlegroups.com, selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:32=E2=80=AFPM Sam Sun <samsun1006219@gmail.com> wr=
ote:
> On Tue, Mar 5, 2024 at 4:45=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Mon, Mar 4, 2024 at 3:11=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > > On Mon, 4 Mar 2024 at 20:19, Paul Moore <paul@paul-moore.com> wrote:
> > > > On Mon, Mar 4, 2024 at 9:08=E2=80=AFAM Sam Sun <samsun1006219@gmail=
.com> wrote:
> > > > >
> > > > > Dear developers and maintainers,
> > > > >
> > > > > We encountered a warning in function sel_write_load(). It is test=
ed on
> > > > > kernel 6.8.0-rc7. Bug report is listed below.
> > > > >
> > > > > ```
> > > > > WARNING: CPU: 1 PID: 8109 at mm/vmalloc.c:3247
> > > > > __vmalloc_node_range+0x10a0/0x1490 mm/vmalloc.c:3247
> > > > > Modules linked in:
> > > > > CPU: 1 PID: 8109 Comm: syz-executor370 Not tainted 6.7.0-rc7 #1
> > > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.=
0-1 04/01/2014
> > > > > RIP: 0010:__vmalloc_node_range+0x10a0/0x1490 mm/vmalloc.c:3247
> > > > > Code: 65 48 2b 04 25 28 00 00 00 0f 85 98 02 00 00 48 81 c4 70 01=
 00
> > > > > 00 4c 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 71 43 b7 ff 90 <0=
f> 0b
> > > > > 90 45 31 e4 eb a1 e8 63 43 b7 ff 48 8b 4c 24 40 31 f6 45 31
> > > > > RSP: 0018:ffffc90002adf9c0 EFLAGS: 00010293
> > > > > RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff81cdc194
> > > > > RDX: ffff888022124ec0 RSI: ffffffff81cdd16f RDI: 0000000000000007
> > > > > RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> > > > > R10: 0000000000000000 R11: 0000000000000001 R12: ffff888107373a48
> > > > > R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc90002adfec8
> > > > > FS:  00005555560953c0(0000) GS:ffff888135c00000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 0000000020000010 CR3: 000000010503d000 CR4: 0000000000750ef0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > PKRU: 55555554
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __vmalloc_node mm/vmalloc.c:3385 [inline]
> > > > >  vmalloc+0x6b/0x80 mm/vmalloc.c:3418
> > > > >  sel_write_load+0x27f/0x19d0 security/selinux/selinuxfs.c:603
> > > > >  vfs_write+0x2a9/0xd80 fs/read_write.c:582
> > > > >  ksys_pwrite64 fs/read_write.c:699 [inline]
> > > > >  __do_sys_pwrite64 fs/read_write.c:709 [inline]
> > > > >  __se_sys_pwrite64 fs/read_write.c:706 [inline]
> > > > >  __x64_sys_pwrite64+0x1f3/0x250 fs/read_write.c:706
> > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> > > > >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > > > > RIP: 0033:0x7f40e7728f8d
> > > > > Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8=
 48
> > > > > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <4=
8> 3d
> > > > > 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > > > RSP: 002b:00007fff5bf39508 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00012
> > > > > RAX: ffffffffffffffda RBX: 00007fff5bf39708 RCX: 00007f40e7728f8d
> > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > > > > RBP: 0000000000000001 R08: 0000000000000000 R09: 00007fff5bf39708
> > > > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > > > > R13: 00007fff5bf396f8 R14: 00007f40e77a6530 R15: 0000000000000001
> > > > >  </TASK>
> > > > > ```
> > > > >
> > > > > The cause of this bug is that in sel_write_load(), parameter "cou=
nt"
> > > > > is controlled by user, which could be zero. It is passed to vmall=
oc()
> > > > > as an argument.
> > > > >
> > > > > If you have any questions, please contact us.
> > > > > Reported by: Yue Sun <samsun1006219@gmail.com>
> > > > > Reported by: xingwei lee <xrivendell7@gmail.com>
> > > >
> > > > Everything appears to be working as expected, vmalloc() caught the
> > > > zero-length allocation request, emitted the warning, returned NULL =
to
> > > > sel_write_load(), and sel_write_load() handled the error condition
> > > > triggered by vmalloc(0) returning NULL.  Did you see any unexpected
> > > > behavior beyond this warning message above?
> > >
> > > Probably because kernel warnings should not be reachable from
> > > userspace ...
> >
> > My question was asking if the reporter was seeing any unexpected
> > behavior *beyond* the warning message.  I wanted to make sure they
> > weren't seeing anything else on their system that we should also take
> > into account.
>
> I didn't see any unexpected behavior beyond this warning message. You
> are right, everything appears to be working as expected. Like
> Christian said, I enabled kernel panic_on_warn config. I thought
> kernel warning was something worthy to report, but I was wrong. In
> future reports, I will check carefully to eliminate kernel warnings
> like "vmalloc zero" and "page size alloc too large" if they don't have
> unexpected behaviors. Sorry for wasting your time analyzing it, and
> thanks for pointing out my mistake!

Thanks for the quick reply, I just wanted to make sure there wasn't
some other bug that was also triggered by passing a 0 count value; I'm
glad to hear there isn't.  Regardless, there is likely some value in
protecting against 0 count/size values and I just posted a patch to do
just that (and some other misc cleanups to sel_write_load()).

--=20
paul-moore.com
