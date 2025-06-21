Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0DC42AB4
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750486141; cv=none; b=hIWFqNFbs6mYr80DiDHnyV0oev5jaScA2Ijv4jh7wc0kVGYocUot4dkFN7orBseKAeLQpVo7BEY3MsUt0wiLmc+MSez8e8LtsNUL8E9a/FJJCrlIeuOR6a39MOvIXOo8CE+GUmAPkxj84NJo0vdzjKNR/VpxAMbiEdJM3nN8kKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750486141; c=relaxed/simple;
	bh=H5TZ2/yxYZP3oSZxiSV6KJv3Y+I2Wa2DX/w3wTurgGc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ae7BsMaeqFJKEGdlXNthR3G7qTPfAC8tIOlHPWWAyzk/OnHRSb4o/2CtwAu+BVZWcpD+U12UARrOWwqzrhDhTeKNsdxL60N0JfYx3JtKS/8cCG+ec4B01qHnwA+QNCW8nla5nPhlY8sAyV6MLhH+JSkZZoP13EeKzWXfgqf61cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7/XDbAK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7/XDbAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750486137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=K52vtEFucQLGuMYKPj05GF3xHKKk00K2SQIo3fmgfSg=;
	b=I7/XDbAK8uYeAaroEGcozP8YVyaYeXgrj65x5rJ+HY0DVENwgAfbKRsQziSlXGxwe0gMTF
	8KaEpx7pi7o39bDzJor74SjGsLPkd+yM4k0JWFAk3oJjCcsjXTFVhIj9UOCLwS4exHTaUR
	Nckm+zqGMeg44OI/Wo8CTEvqDEKwYys=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-3HhxqgikN7W3AyXxPHT0MA-1; Sat, 21 Jun 2025 02:08:56 -0400
X-MC-Unique: 3HhxqgikN7W3AyXxPHT0MA-1
X-Mimecast-MFC-AGG-ID: 3HhxqgikN7W3AyXxPHT0MA_1750486136
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4e7fa155aa4so348639137.3
        for <selinux@vger.kernel.org>; Fri, 20 Jun 2025 23:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750486136; x=1751090936;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K52vtEFucQLGuMYKPj05GF3xHKKk00K2SQIo3fmgfSg=;
        b=pQIGIWDz64aVyKcyqDMi2jUNxyWwwaOg/A3h4cfUMQmCxJSfdp8x4PLyLVP0SmxFRw
         g8NKvPCqN6T3md3bTnqRkmfs4Dx2xBElVhkMudWpA/4evoqljzNbMbr7n4Uneig8JJaN
         i9wQ3QHtX5/P9P6zR4WzhhHv0txnry9eFrYWjJtDOT3OqQjXX02UYZY9GDTTHp+9bISc
         ShvthZPfU2WybBKawtUFy+hb3WfL++kQNV4YR9UQCW2lPi5lFrUvDCZNT1SzaB3uPe0g
         6QfGCvtTpcvtd7EkDzgax3NeBFcHV0gP+H+zCJ8bXQVVa2O2Stlx1RQ4MZCoMYC3C5ET
         XdlA==
X-Forwarded-Encrypted: i=1; AJvYcCXgvBL+H6pJuS4X+DqnxPAc1m37XqaGGhDoBUUP+7WLAYPBliw9QHgq2CKH89lQYsdwyjmRwokL@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQ4wwU3IjfUN1gvph2y+Uzk2QVMBuVNjDGpJVaZqdIVlvv1GR
	r3YwjXDp8fM7QuweOYSrEJQ73MDVGoKGP2WcIYrTU/GBfsvmkanUbxk/4lRUMWNrkWK/NcDEJbR
	IXKiVBFoBo3j3uQjkL+wB7HNbOflhg02s0srEiWBo7ThbY0HQ3k1yzonnQjsMc9CnLq4qN1tt2k
	ohgYRqge+d3SGvwdYAuHsmGuzz+Ys5VXs9/Q==
X-Gm-Gg: ASbGncuPRe4VNw/P/B88aIzKqlWBtAd5YKy9UpvlXKGvRtNbP1ROmz3xMGFECQci3VK
	IX+RGvfDW69vINevAHyB5GSetiB/3f1yX7FY83nywH4Xi38J28xBdLkuUe4wdf1km5sZgEHhjsr
	/bKObW
X-Received: by 2002:a05:6122:ca8:b0:530:7e05:3839 with SMTP id 71dfb90a1353d-531ad7b2082mr3595216e0c.11.1750486135684;
        Fri, 20 Jun 2025 23:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsHUaRWc2NcM9Iqj58DIfeKtW/k58h/kPWizo7tsvDaVv46Vjv8vidCt+94KkPp1WvqaYnP6K+S0vIDIN99aE=
X-Received: by 2002:a05:6122:ca8:b0:530:7e05:3839 with SMTP id
 71dfb90a1353d-531ad7b2082mr3595208e0c.11.1750486135330; Fri, 20 Jun 2025
 23:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 21 Jun 2025 14:08:44 +0800
X-Gm-Features: Ac12FXwu1_xOHn-k9ps5wWmOA0_RKeWo_S7_wOTUx3GDXOQVZ2GLfnGfNFK8GQM
Message-ID: <CAFj5m9KOjqYmUOYM4EgDBrJ-rQxEgOhm+pokmdAE6w+bCGrhSg@mail.gmail.com>
Subject: [v6.16-rc2+ Bug] panic in inode_doinit_with_dentry during booting
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"

Hello Guys,

The latest v6.16-rc2+ kernel panics during booting, commit
3f75bfff44be ("Merge tag 'mtd/fixes-for-6.16-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux"):


[  OK  ] Finished systemd-modules-load.service - Load Kernel Modules.
         Starting systemd-sysctl.service - Apply Kernel Variables...
         Starting systemd-sysusers.service - Create System Users...
[  OK  ] Finished systemd-sysctl.service - Apply Kernel Variables.
[    1.851473] Oops: general protection fault, probably for
non-canonical address 0x8cbad568292ed62c: 0000 [#1] SMP NOPTI
[    1.853362] CPU: 9 UID: 0 PID: 269 Comm: systemd-sysuser Not
tainted 6.16.0-rc2+ #328 PREEMPT(full)
[    1.854923] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-1.fc39 04/01/2014
[    1.856374] RIP: 0010:__list_add_valid_or_report+0x1e/0xa0
[    1.857366] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
53 48 83 ec 08 48 85 f6 0f 84 76 2f 76 ff 48 89 d3 48 85 d2 0f 84 5c
2f9
[    1.860338] RSP: 0018:ffffd152c0de3a10 EFLAGS: 00010286
[    1.861244] RAX: ffff8aa5414d38d8 RBX: 8cbad568292ed624 RCX: 0000000000000000
[    1.862439] RDX: 8cbad568292ed624 RSI: ffff8aa5401f40f0 RDI: ffff8aa5414d38d8
[    1.863622] RBP: ffff8aa5414d38f4 R08: ffffd152c0de3a7c R09: ffffd152c0de3a20
[    1.864810] R10: ffff8aa5401f40c0 R11: 0000000000000007 R12: ffff8aa5414d38d8
[    1.864813] R13: ffff8aa5401f40c0 R14: ffff8aa5401f40f0 R15: ffff8aa5414d38d0
[    1.864814] FS:  00007feebef42bc0(0000) GS:ffff8aa9ed02f000(0000)
knlGS:0000000000000000
[    1.864816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.864818] CR2: 00007feebfb58180 CR3: 0000000117f4d004 CR4: 0000000000770ef0
[    1.870018] PKRU: 55555554
[    1.870020] Call Trace:
[    1.870029]  <TASK>
[    1.870031]  inode_doinit_with_dentry+0x42d/0x520
[    1.870035]  security_d_instantiate+0x93/0xb0
[    1.870038]  d_instantiate+0x2e/0x60
[    1.870043]  ramfs_mknod+0x58/0xb0
[    1.870047]  path_openat+0xf53/0x1200
[    1.870050]  do_filp_open+0xd7/0x190
[    1.870053]  ? _raw_spin_unlock+0xe/0x30
[    1.870055]  do_sys_openat2+0x8a/0xe0
[    1.870058]  __x64_sys_openat+0x54/0xa0
[    1.870060]  do_syscall_64+0x84/0x2c0
[    1.870063]  ? __x64_sys_openat+0x54/0xa0
[    1.870064]  ? do_syscall_64+0x84/0x2c0
[    1.870066]  ? do_sys_openat2+0xa4/0xe0
[    1.870068]  ? __x64_sys_openat+0x54/0xa0
[    1.870069]  ? do_syscall_64+0x84/0x2c0
[    1.870070]  ? handle_mm_fault+0x1d7/0x2e0
[    1.870074]  ? do_user_addr_fault+0x211/0x680
[    1.870077]  ? clear_bhb_loop+0x50/0xa0
[    1.870079]  ? clear_bhb_loop+0x50/0xa0
[    1.870080]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.870082] RIP: 0033:0x7feebf965e63
[    1.870084] Code: 83 e2 40 75 52 89 f0 f7 d0 a9 00 00 41 00 74 47
80 3d 50 22 0e 00 00 74 62 89 da 4c 89 e6 bf 9c ff ff ff b8 01 01 00
008
[    1.870085] RSP: 002b:00007ffd85a4c5d0 EFLAGS: 00000202 ORIG_RAX:
0000000000000101
[    1.870087] RAX: ffffffffffffffda RBX: 00000000000a0141 RCX: 00007feebf965e63
[    1.870088] RDX: 00000000000a0141 RSI: 000055ed496c4f10 RDI: 00000000ffffff9c
[    1.870089] RBP: 00007ffd85a4c640 R08: 00000000ffffff9c R09: 00007ffd85a4c4f0
[    1.870090] R10: 0000000000000180 R11: 0000000000000202 R12: 000055ed496c4f10
[    1.870091] R13: 0000000000000000 R14: 00007ffd85a4c6c0 R15: 000055ed29c98940
[    1.870092]  </TASK>
[    1.870093] Modules linked in: scsi_dh_rdac scsi_dh_emc
scsi_dh_alua ip6_tables ip_tables fuse dm_multipath qemu_fw_cfg
[    1.870121] ---[ end trace 0000000000000000 ]---
[    1.870123] RIP: 0010:__list_add_valid_or_report+0x1e/0xa0
[    1.870127] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
53 48 83 ec 08 48 85 f6 0f 84 76 2f 76 ff 48 89 d3 48 85 d2 0f 84 5c
2f9
[    1.870127] RSP: 0018:ffffd152c0de3a10 EFLAGS: 00010286
[    1.870129] RAX: ffff8aa5414d38d8 RBX: 8cbad568292ed624 RCX: 0000000000000000
[    1.870130] RDX: 8cbad568292ed624 RSI: ffff8aa5401f40f0 RDI: ffff8aa5414d38d8
[    1.870130] RBP: ffff8aa5414d38f4 R08: ffffd152c0de3a7c R09: ffffd152c0de3a20
[    1.870131] R10: ffff8aa5401f40c0 R11: 0000000000000007 R12: ffff8aa5414d38d8
[    1.870132] R13: ffff8aa5401f40c0 R14: ffff8aa5401f40f0 R15: ffff8aa5414d38d0
[    1.870133] FS:  00007feebef42bc0(0000) GS:ffff8aa9ed02f000(0000)
knlGS:0000000000000000
[    1.870134] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.870135] CR2: 00007feebfb58180 CR3: 0000000117f4d004 CR4: 0000000000770ef0
[    1.870137] PKRU: 55555554
[    1.870138] Kernel panic - not syncing: Fatal exception
[    1.870365] Kernel Offset: 0x3a000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    1.898219] ---[ end Kernel panic - not syncing: Fatal exception ]---




Thanks,

