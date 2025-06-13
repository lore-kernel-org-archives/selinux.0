Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6D22688C
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817636; cv=none; b=k3C6P0VhWrXqS+a/pG4yvduf1/7K55p0sQsREmXzV6zv2ahquy9XbHxr3Vfb/8pMc5Tyg4Wk/U5Sh8J5jn7uLnm+110Zrw9NhepKn5IIazbx9DSrd5R1V08CFJQhcV2ADyJZv8iVWRrfitRsSp7oJ7YYTzoAOUIeLAZUZQgH6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817636; c=relaxed/simple;
	bh=mKvo2jSCBtAXtGYmKZ6AX01VjS7wfV8DPyXs5ow2KOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YV0mmLhXUB5ngKp0/9CeO6FUf0cFlf7bDU9rn2Vq8OHfaIjnWObsmJdfRf/OZRtwe50ncNLAdXEz7uQESkIADhhTqNhv+VPRVB6HIukU8wxDo3O0cY68AoxUbOaq6ykPh47tB/61Vd8nwrHYQAo+4lMxg2vtt8RnLOx8/xyWqcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB2UZZV1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB2UZZV1"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74849e33349so1940660b3a.3
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749817634; x=1750422434; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tD60XSIbwYbXFg2BxhfndyY+REnbVngk4NR6/RSy0Nk=;
        b=gB2UZZV1oXnWnxVBiOELceVwAwDvBA+cv71Gnx2YwMkbkCCyp2JWHw3YnuJ0n+KOE6
         WBaTImZlgeCUxcRE3dHJNOY79ZTPTg4n1hK/OQROfbkWsjLFl6mp+ppSas6m9Rf+hE38
         gDK9hmNNzJVWfr2CTC9E/yr/gBlEi8oyBgW3RKay8ZLD6cBQt82d2oxwyoQ0JkfubiZl
         qkgW5xl8EfxHTZzv/Ml52EjgoBd7CLT8PX1d6ITyKhJoCvC7ZIg9yR9Br7Z0YVVgXGso
         YCUsHm/kiPY8esfxXmercN+/bql7CPZXvs73dy1/VyY0SRCulU40gkEt6VaKVmW2zxmr
         +r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749817634; x=1750422434;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tD60XSIbwYbXFg2BxhfndyY+REnbVngk4NR6/RSy0Nk=;
        b=EAMJZQKOinfPdR4YAVrlHM2B0wREe13jt6Y/hEVmRa5bgLArMyOM4hsLkgAWYIcKLh
         H/+JepOEMPOVdHXddbsN61QkZTiGVMQx8hXklf2RPWIkXSoyJ46Zo3DqrnlHy5darH0I
         GOrEGxPbsUciCC5yQjaazzfnL9PZmZ/OiqhTgnVrQYErqujnVerGlIguDXHQXw1WYlTp
         EpgBQ3zeCbxNv1FCx6yrtW/zVNJdswYMgoU/ivkGz0LGrXS5r5BZX3fruz1RBB8Gf0n0
         G8UWJqJnxg5POuHDT6/7PkV6thcYUEOlWYFsc0nAlDlFEx/Ryfl43dB3K6dG2RVPGysz
         lB1g==
X-Forwarded-Encrypted: i=1; AJvYcCV1ICZJbyryZDXCPK58SVaurpZ+lOQIFVPTrfLM+XERiAS+/j+KnJoJlMfQsImzxgcBiDjtGKgi@vger.kernel.org
X-Gm-Message-State: AOJu0YyfX2L3zx61lxfmxl/eJljZH22cfQ4/AUo2Uqlt6lHwnFGUZfxn
	Us/xgzaID3neGY0xpxLxBQeBKO1KX0I8/vK1ihbEbENiN/QUC1sQdou6deDx4+16ZZm1kaiKX80
	k6wcjh3n8WGAb7ZyGeCDd991AQtF71GWYxQ==
X-Gm-Gg: ASbGnctpl1V2B9J7Frk5rMdbEDViVgcRTaCGpYcrITIQMIHbAsa46ftbMnkUeqt+I67
	baswy2OMS0Xb5P+TjdjUhJ1uKVOJ/cxa7d0cxcXFVmaMkDRmAxspeMUxTAzHHZZA2NAddunQ8m2
	6MAqmEPvq3rkMvjH/trlrR0mm0vs9BZsyKSoSd3pHMWtM=
X-Google-Smtp-Source: AGHT+IHeOGIdwcM70nb3VQz7NU72fKJqEYki7JlxkbUZHF68v4ORoAGPzjkzIiBIQ/RnYBr9Mp0TtRhw4mpTy8SV9mg=
X-Received: by 2002:a05:6a00:3cd1:b0:736:43d6:f008 with SMTP id
 d2e1a72fcca58-7488f6fb1d7mr4151183b3a.12.1749817633728; Fri, 13 Jun 2025
 05:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5veb_psQc_j=8c7Jz3H46twvnmZKy=8E8Bzq7pCinK7Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ5veb_psQc_j=8c7Jz3H46twvnmZKy=8E8Bzq7pCinK7Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Jun 2025 08:27:02 -0400
X-Gm-Features: AX0GCFsGQsAJOmdYoy91Hg9K5-rT547-CmnTF7mhmA6SQbsqfk5qOZ7z0ucR-dM
Message-ID: <CAEjxPJ6tA5+LxsGfOJokzdPeRomBHjKLBVR6zbrg+_w3ZZbM3A@mail.gmail.com>
Subject: UBSAN warning during selinux-testsuite inet_socket xfrm tests
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Still need to confirm that I can reproduce on a stock kernel without
SELinux namespace patches, but FYI...

[  125.187251] ------------[ cut here ]------------
[  125.187272] UBSAN: array-index-out-of-bounds in security/selinux/xfrm.c:99:14
[  125.187285] index 60 is out of range for type 'char [*]'
[  125.187296] CPU: 12 UID: 0 PID: 5028 Comm: ip Not tainted
6.16.0-rc1+ #390 PREEMPT(lazy)
[  125.187300] Call Trace:
[  125.187302]  <TASK>
[  125.187304]  dump_stack_lvl+0x5d/0x80
[  125.187311]  ubsan_epilogue+0x5/0x2b
[  125.187314]  __ubsan_handle_out_of_bounds.cold+0x54/0x59
[  125.187317]  selinux_xfrm_alloc_user+0x146/0x150
[  125.187322]  security_xfrm_state_alloc+0x3c/0x100
[  125.187328]  xfrm_state_construct+0x24e/0x3d0
[  125.187332]  xfrm_add_sa+0x82/0x1f0
[  125.187334]  xfrm_user_rcv_msg+0x19f/0x390
[  125.187340]  ? xfs_attr_sf_findname+0x6f/0xa0 [xfs]
[  125.187562]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
[  125.187568]  netlink_rcv_skb+0x5c/0x110
[  125.187572]  xfrm_netlink_rcv+0x31/0x40
[  125.187575]  netlink_unicast+0x26f/0x3a0
[  125.187577]  netlink_sendmsg+0x207/0x440
[  125.187580]  ____sys_sendmsg+0x39f/0x3d0
[  125.187584]  ? import_iovec+0x1b/0x30
[  125.187590]  ___sys_sendmsg+0x99/0xe0
[  125.187596]  __sys_sendmsg+0x8a/0xf0
[  125.187600]  do_syscall_64+0x82/0x2c0
[  125.187605]  ? psi_task_switch+0xb7/0x210
[  125.187609]  ? finish_task_switch.isra.0+0x99/0x2c0
[  125.187612]  ? rseq_get_rseq_cs.isra.0+0x12/0x220
[  125.187617]  ? rseq_ip_fixup+0x90/0x1d0
[  125.187621]  ? __rseq_handle_notify_resume+0x39/0x60
[  125.187623]  ? exit_to_user_mode_loop+0xe1/0x160
[  125.187627]  ? do_syscall_64+0x1e1/0x2c0
[  125.187629]  ? syscall_exit_work+0x143/0x1b0
[  125.187631]  ? do_syscall_64+0x1fc/0x2c0
[  125.187634]  ? handle_mm_fault+0x248/0x360
[  125.187638]  ? do_user_addr_fault+0x21a/0x690
[  125.187641]  ? clear_bhb_loop+0x50/0xa0
[  125.187645]  ? clear_bhb_loop+0x50/0xa0
[  125.187646]  ? clear_bhb_loop+0x50/0xa0
[  125.187648]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  125.187651] RIP: 0033:0x7f83c3beda06
[  125.187662] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75
19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45
10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83
ec 08
[  125.187664] RSP: 002b:00007ffdef5c6b60 EFLAGS: 00000202 ORIG_RAX:
000000000000002e
[  125.187666] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f83c3beda06
[  125.187668] RDX: 0000000000000000 RSI: 00007ffdef5c6c30 RDI: 0000000000000004
[  125.187669] RBP: 00007ffdef5c6b80 R08: 0000000000000000 R09: 0000000000000000
[  125.187670] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000ef5c7d00
[  125.187671] R13: 00000000684c1739 R14: 00007ffdef5c6db0 R15: 00007ffdef5c9264
[  125.187675]  </TASK>
[  125.187676] ---[ end trace ]---
