Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4264286D46
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692201; cv=none; b=YobvIYOrZg7yw9JzRp+gqWYjsxQoTuRpTR7aQK3za8J4GW8AJZlNGK54qGvYbBcYvUmNw68OBh/LXN4jm58z+fWWHl4xdc50B67MShQ7zLqvIcpnmpEtFv2GbIstk5meOt1XLNSbgXoAuYQ8mMIOyUkEV37pbCferFOmJNwAFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692201; c=relaxed/simple;
	bh=lGS+0f0d2TPqmr39/urKxDV5nS75hlwL5bSZDFpp3aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAAquUEjmxLaCneXnHA9/2Bm5CvpJjkUCAeXA7epCVW/Cv9j/s96ySl5zbVfLpc/ABpNwjFlSC8YRfzDpuvV7nXnXfIfDrzXr5MNRLdWcGZTy5xU3kEtkut1y55pvU2WT7OBAA6A6GoEXFWVPLED+7JQlJEi4CiBYqY6huoq9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KK3z2ZZa; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KK3z2ZZa"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7387d4a336so3249686276.2
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750692196; x=1751296996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C+Macx0w6ywU+A/VvTC8HUBWMBBqnb8N7PQsKLlGDs=;
        b=KK3z2ZZa3naySG4UBYRrXHNJN/sqjzJpgXzbYb0hEdHli+tdbUhGQTl5KoG8t/KN7t
         D214XNVYjV6nLye/i29wogBvV29DVSPI9KOaiDb+YMNaztf8aTUC/k7xJScXA9Km3mTf
         vdm3tYLqIDaS+EqE9dmNSp5O/zvxlpiSz9SyMB2insFUqY1fHSSazu1jp2AbgLgXYtqM
         yYK4m5WPyl4ieQ6Yk+A/xmRBReFHox5fh8w2gzIRqovUMJz8f93AjdSK/kAZj/L0ur/x
         kBWqgEEEAY5RwKz/oAxUA4neebUJU0B9f5mx4RHm8tUqDmIZbsyKfM5b3aKa1fvm5Uso
         PdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692196; x=1751296996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C+Macx0w6ywU+A/VvTC8HUBWMBBqnb8N7PQsKLlGDs=;
        b=lts2/LRCnY7a5C29KKdGzuQ+Rw9VUwCAZzUXpw9+TvegX71QWN3xNoFCG6HAyQIwG0
         5pgdwZfG99fb1djxaqGhAs73Ec6s9LnFr8hpkEDz/AVEJere3TzPsYuTk7XbvbL10ztO
         VD3sycAI+y80D/n2csiU99lL3YGfDRJ1HaqDD5yVBaol80fC4XiCl2ZZ2UzRj07lXloC
         K7Nob6ijjYxdxZKGlQ64hSqGGJ7pr4MxGcUPSI1/FepeVcJ5bvVTUNtxq1rD1JE7mEyO
         M3LcslOzHqIqg8nsnCZN7sa6kGUg89HquUoTzLKW6l9L2WKB9OMnnwSp1e60MiGrTRDg
         pdxw==
X-Forwarded-Encrypted: i=1; AJvYcCVgIuxNq01EfpBmaY5apHPqaVJwWGPj2CU2QMP3WjYeuS8otLuhmZwtzyiO7CC4VhsYhGO5Ip4/@vger.kernel.org
X-Gm-Message-State: AOJu0YwPN/oRYPgxNxURXqtf4tBEKKFpiD29qfBBwgfe/Of2v+LzrHyD
	njC2PVv2VzkZdxRKPQssbsWagS1BsAqm9+zXZpOYxJl7x8BDzZI1GqXhm8PrfgY/1tuffkC2eMY
	f0Wtf14C0WQzJDkIz/L3294hGzgngAkJDzt+g40Eh
X-Gm-Gg: ASbGnctkbLtttr8aAKo9PtTXtBABWKJLpD1zJk2IAZVvlIplBGTSSyXzAiRc8c+k9Vz
	rEmhfa7PzVgI3xADzW5Zdl35xIOwQW8a08PcNMcxKtdEomEApl/tg8bjh/80j+FHwjuFb9iCa6u
	K/XospBjFLE8bdNEBAYBkt9PI42pg8FQYqUZV26Y49aDM=
X-Google-Smtp-Source: AGHT+IFDWmvezTtn24M48J2+gCwvEZrGp1xjw9YXsal4m8rI9IlwaC+CRLf7Nu9lLnMcBNv3Itll1k7csRHQcl6+zOM=
X-Received: by 2002:a05:690c:4a06:b0:70c:a854:8384 with SMTP id
 00721157ae682-712c63f3440mr197154127b3.11.1750692196000; Mon, 23 Jun 2025
 08:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFj5m9KOjqYmUOYM4EgDBrJ-rQxEgOhm+pokmdAE6w+bCGrhSg@mail.gmail.com>
 <CAHC9VhQ0dyqsjsNt98yiPCGsiuUXep3T7T24LWWRHy8V8xjV4Q@mail.gmail.com> <aFiwMxE4OlcFp7Ox@fedora>
In-Reply-To: <aFiwMxE4OlcFp7Ox@fedora>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Jun 2025 11:23:03 -0400
X-Gm-Features: Ac12FXzfEPBnZct18t2NRX4DFqCH556EcUr1vJpCOtWVUEWdAIFOvsXhC2LL9A8
Message-ID: <CAHC9VhQjF3L0B0GiZq-yWBMKjBMZ_qtnuG0Dn9g=bzjkFMYJig@mail.gmail.com>
Subject: Re: [v6.16-rc2+ Bug] panic in inode_doinit_with_dentry during booting
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 9:39=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
> On Sat, Jun 21, 2025 at 02:40:41PM -0400, Paul Moore wrote:
> > On Sat, Jun 21, 2025 at 2:08=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Hello Guys,
> > >
> > > The latest v6.16-rc2+ kernel panics during booting, commit
> > > 3f75bfff44be ("Merge tag 'mtd/fixes-for-6.16-rc3' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux"):
> > >
> > >
> > > [  OK  ] Finished systemd-modules-load.service - Load Kernel Modules.
> > >          Starting systemd-sysctl.service - Apply Kernel Variables...
> > >          Starting systemd-sysusers.service - Create System Users...
> > > [  OK  ] Finished systemd-sysctl.service - Apply Kernel Variables.
> > > [    1.851473] Oops: general protection fault, probably for
> > > non-canonical address 0x8cbad568292ed62c: 0000 [#1] SMP NOPTI
> > > [    1.853362] CPU: 9 UID: 0 PID: 269 Comm: systemd-sysuser Not
> > > tainted 6.16.0-rc2+ #328 PREEMPT(full)
> > > [    1.854923] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > > BIOS 1.16.3-1.fc39 04/01/2014
> > > [    1.856374] RIP: 0010:__list_add_valid_or_report+0x1e/0xa0
> > > [    1.857366] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
> > > 53 48 83 ec 08 48 85 f6 0f 84 76 2f 76 ff 48 89 d3 48 85 d2 0f 84 5c
> > > 2f9
> > > [    1.860338] RSP: 0018:ffffd152c0de3a10 EFLAGS: 00010286
> > > [    1.861244] RAX: ffff8aa5414d38d8 RBX: 8cbad568292ed624 RCX: 00000=
00000000000
> > > [    1.862439] RDX: 8cbad568292ed624 RSI: ffff8aa5401f40f0 RDI: ffff8=
aa5414d38d8
> > > [    1.863622] RBP: ffff8aa5414d38f4 R08: ffffd152c0de3a7c R09: ffffd=
152c0de3a20
> > > [    1.864810] R10: ffff8aa5401f40c0 R11: 0000000000000007 R12: ffff8=
aa5414d38d8
> > > [    1.864813] R13: ffff8aa5401f40c0 R14: ffff8aa5401f40f0 R15: ffff8=
aa5414d38d0
> > > [    1.864814] FS:  00007feebef42bc0(0000) GS:ffff8aa9ed02f000(0000)
> > > knlGS:0000000000000000
> > > [    1.864816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    1.864818] CR2: 00007feebfb58180 CR3: 0000000117f4d004 CR4: 00000=
00000770ef0
> > > [    1.870018] PKRU: 55555554
> > > [    1.870020] Call Trace:
> > > [    1.870029]  <TASK>
> > > [    1.870031]  inode_doinit_with_dentry+0x42d/0x520
> >
> > Thanks for the report.  I'm assuming you didn't see this with
> > v6.16-rc1, or earlier?
>
> It isn't observed on -rc2.
>
> >
> > Do you have any line number information you could share?  Also, based
> > on the RIP in __list_add_valid_or_report(), can you confirm that this
> > is either happening in an initrd/initramfs or on a system where a
> > SELinux policy is not being loaded?
>
> Looks the issue can't be reproduced any more with -rc3.

Thanks for the update.  If you see this again, please let us know.

--=20
paul-moore.com
