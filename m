Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ACC437118
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276958; cv=pass; b=rXdAPqg7eljiuZd4WObvTKSd7zDLk30t9OvQVzkHGFLQoi6Ajmx+dGN3ZQkY0tMEjIN+deI6kHaUXbqbIfGftFPoTifzMTrz7nlu2YclHAF4VqeyRQfcyzCysguUl7tWW0RL5ZHwXGgzEtLF2Bp+O25qAN9xBE3Dp4USgngGzpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276958; c=relaxed/simple;
	bh=jn1sest2ccjqaYA0ct4ZKyuK5PdxEXkGJ4/UDnHa25g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVetphVdowmFR7CaZxx+7VNwx2SRYbOF+0LA9Ae7qp9wSRaf0TwzWTWzJHt9SrcX2tJPSRszbG2+WgUiSnyNLQyPMW9+8SHICB0CseR8sez7mgTxfoUqZMb41BbhZsd40kylqer4PAx8W0w97wwF6XAbOw4VFOVum5mOctT+Ejk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NANb75tY; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NANb75tY"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d715f4a587so15526365ad.2
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 08:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788276956; cv=none;
        d=google.com; s=arc-20260327;
        b=X75V070+odorFgcixfd2PXORTEeU0BRncUCMlIzt+OzrdzOfXsqgZCZVSQ2rP0PsgO
         kh3Zgkwsuwdme96pqI1sLbt1Uy5vzyYx6bOxOcO3mEzKJ+wCZpoJy/k2+uA4f27xtuRQ
         1qgixmQRMemZbguC09+Cg99sG8oECQevj3SoLOLgxFEaCqXZX8VN2EXJpwZAwR6z5SZ2
         76M+cYlpbU34nS2VHRANDy9fu7fWioUJqAu16MQYFm+K356Qpoenm96h0IR3pkhgF+Pj
         tq54bBy0WQGGadQcMclpszFuDLp6OWEZxi93JNkYQmuCWbl2AzOskPG/ez+gz8YcoyNP
         UCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NK8GDZBjmRMaLcyD7xFcPzmtZY0QJHpenSUYLL10OsA=;
        fh=D0XEQgpOvpj+v4CqdFuq3+Kdqp8cn09vHu56Aw864JE=;
        b=GOYtdD+rm1tocDV5naBQX17T+7dfh31yUJPABIRWqnojiP2pBBXCkOA7esk4BzUuJQ
         lWLmiE1eJ7dlomdu93CJiy6er6/fnzJzs5WkQEexRri0xtwOtyY15a5+GWiK+dnB5ZpF
         XqfWR4wJAW1107LveJh3n/rQrhRHEcYLcmdszz2narX9lp+ak6gwNAFVEAmvNDU1EaLE
         8NR2X8vRgRMihPez46RX2HnyAVe9u6vJ70l4KRUSnteYHpsyPuPrCdTayu1XxaQL35Th
         yZuX+P8c4AkHCoaOpF1mO40oOK3o8hCnxh9lONgTlVYbYv1DFnrEA3Css27fJs2Hv8i1
         H35w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788276956; x=1788881756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NK8GDZBjmRMaLcyD7xFcPzmtZY0QJHpenSUYLL10OsA=;
        b=NANb75tYkGk/BYXWszwQPgrD4eQzJEGHksIkPCBFLUq2w5dDgyq0M/m+PzzghJm1B+
         nDSjS85bCJ1J3B6C5iEoiyELrJ+tg14Y/DcVSfnzhymOLrlwH/NI7XELNM74h9Ks+7WL
         UHd73rMQ8jrO+5zcDDEVOQ60zeXiI38wO8gUr9z/cI29ePza8VvDGz2DlP6MryUfT9Wi
         uZnXM+oYlc+4iDF24I/lAfO9Aa5yUX+iilNU2i+w3Qu0X5nq7L+FNYVVj81XUQKokDS6
         d6R0+PZJU9vuCJb67c5r0bJ2IOCPXIEU+3mNdITmlg/m/SZXKen8Xf5sAmZEbPZZAt0z
         qULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276956; x=1788881756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NK8GDZBjmRMaLcyD7xFcPzmtZY0QJHpenSUYLL10OsA=;
        b=T9CLno+//0p8qa2ovoGyPhViuPvbT6fZKx4ErDEzJ920UkqEnqQDMVVK7KCpukVdsU
         MRgCkLaF41HWmlz7fzfmQ4Nqb0zMopssSROh2kTLIPwgNe2FfT47+s40eq/Nqc+UE7UM
         K8zHpbeZvXNlL47UmUQyCGvyRqK6nxa7yc7w2bpz4KhlN+a0rHBlvoFPmncYpeR+EW3x
         7FCqSagqBiG0FfYLphSddDWz4eyLZ6E3uQWWcWrRMX5GVGGjeeJS7Gdxz9IeLwfHoeam
         HR0dzJCM9xhFxN8IIB1tzberP2OjrBz8AdUxnBcEw13iVGKfLcEKFLMzn86U3Ddd7/4H
         JOfw==
X-Gm-Message-State: AFuF++k90mwFR6n94e2aQisA7xWWDC3oEKLlC6fEIkQBSlGhmyG8pmc9
	vZCTHcRgMW2DTNTRq2vwZL681ZEEEZ8ZVt4EpPHIseKgarKD7bA4aKqDTHlfkEvQzZPVLsif+YZ
	ot3raU+FhJrxlXwHt9U1iyEu+ePdVWXzULc8MVAuH
X-Gm-Gg: AYBFou27KmPBCI8zwRx2YI0E/NTUxcqjyRpho4m7qBkF2iYLePJrO4dLFUCfcfeBE+B
	z/nIt5PW9GhnAMv3acy0r8kpMdYAIS6xiAnMmDudW7KJ5TP9nLnsCcQDAHXW78FAIjdq0TTK0QM
	i4j8Sne3ZlQYqA+vWOCGdYVkTIkImLFhDiwr6ep3CS8bfuqajTt/wahb/sdvUzuDkpyN5nrOF1S
	MuEB7uTUvGnXwp4e5gT1mriEns9KzF0aI8oJVSVr7fc81ZEO1Zv4QFklqc91oAYzzg7kFfPkfhQ
	sswdY51Ey12ZtLGbGhhO0Ey33mYRBBWVhsgp6ncd0+13
X-Received: by 2002:a17:902:ef52:b0:2d9:383a:30f1 with SMTP id
 d9443c01a7336-2d9383a326bmr189213615ad.4.1788276956037; Tue, 01 Sep 2026
 08:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <L8sbFRgfQca4r8AaNEEfTw@coker.com.au> <CAEjxPJ6SQcdEDFfV3W7Bk5JKbAxRp+9tuvr2yhUdDePmeXNAKA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6SQcdEDFfV3W7Bk5JKbAxRp+9tuvr2yhUdDePmeXNAKA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 Sep 2026 11:35:44 -0400
X-Gm-Features: AcwNN1XgKBU6I0f65QYhwuq3U7KYgUPSYs8tfbv6w-ZF7eTogZ7iw3hSJkI5Too
Message-ID: <CAHC9VhT+k9qWsA40APOi4Q1hg8M+Ft_A7D3epdBW7P2QczPf6Q@mail.gmail.com>
Subject: Re: kernel oops on recent policy with older kernel.
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>, selinux-refpolicy@vger.kernel.org, 
	Russell Coker <russell@coker.com.au>, Chris PeBenito <pebenito@ieee.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:21=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> ---------- Forwarded message ----------
> From: Russell Coker <russell@coker.com.au>
> To: "SELinuxProject/refpolicy" <refpolicy@noreply.github.com>
> Cc:
> Bcc:
> Date: Wed, 22 Jul 2026 21:04:27 +1000
> Subject: kernel oops on recent policy with older kernel.
> I get the above when loading the latest git policy compiled with 3.11
> userspace on Debian kernel 6.12.74+deb13+1 and Debian kernel 6.12.86+deb1=
3.
> The same policy on a 7.x kernel such as 7.0.13+deb14 works correctly.
>
>
> [    9.571350] SELinux: no sid found, defaulting to security isid for /
> booleans/httpd_can_network_connect_cobbler
> [    9.573682] SELinux: no sid found, defaulting to security isid for /
> booleans/httpd_can_network_connect_db
> [    9.575883] SELinux: no sid found, defaulting to security isid for /
> booleans/httpd_can_network_connect_ldap
> [    9.578956] SELinux: failed to initialize selinuxfs
> [    9.580143] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [    9.581804] #PF: supervisor read access in kernel mode
> [    9.583012] #PF: error_code(0x0000) - not-present page
> [    9.584222] PGD 0 P4D 0
> [    9.584875] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [    9.585964] CPU: 3 UID: 0 PID: 1 Comm: systemd Not tainted 6.12.74+deb=
13+1-
> amd64 #1  Debian 6.12.74-2
> [    9.588099] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S
> 1.17.0-debian-1.17.0-1 04/01/2014
> [    9.590356] RIP: 0010:selinux_policy_cancel+0x15/0x60
> [    9.592457] Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90
> 90 90 66 0f 1f 00 0f 1f 44 00 00 48 8b 05 a8 fe 2d 02 55 48 89 fd 53 <48>=
 8b
> 38 e8 d3 49 ff ff 48 8b 5d 00 48 85 db 74 2d 48 8b 3b e8 82
> [    9.596798] RSP: 0018:ffffd1c640013b50 EFLAGS: 00010246
> [    9.598016] RAX: 0000000000000000 RBX: fffffffffffffffe RCX:
> 0000000000000003
> [    9.599682] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
> ffffd1c640013c00
> [    9.609068] RBP: ffffd1c640013c00 R08: 0000000000000000 R09:
> ffffd1c6400139f8
> [    9.610713] R10: ffffffff8d2b43c8 R11: 0000000000000003 R12:
> ffff8d9286eb8ad8
> [    9.612339] R13: ffff8d92867dd000 R14: ffffd1c6406e9000 R15:
> ffff8d9284b02000
> [    9.614014] FS:  00007f504bf3ec80(0000) GS:ffff8d92f9f80000(0000) knlG=
S:
> 0000000000000000
> [    9.615863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.617216] CR2: 0000000000000000 CR3: 000000000107a003 CR4:
> 0000000000370ef0
> [    9.618842] Call Trace:
> [    9.620299]  <TASK>
> [    9.620887]  sel_write_load+0x5dd/0xbb0
> [    9.621809]  vfs_write+0xf8/0x440
> [    9.622590]  ? __alloc_pages_noprof+0x16b/0x310
> [    9.623640]  ksys_write+0x6d/0xf0
> [    9.624477]  do_syscall_64+0x82/0x190
> [    9.625375]  ? __folio_mod_stat+0x26/0x80
> [    9.626330]  ? set_ptes.isra.0+0x36/0x80
> [    9.627265]  ? _raw_spin_unlock+0xe/0x30
> [    9.628168]  ? do_wp_page+0x41c/0xcd0
> [    9.629111]  ? __handle_mm_fault+0xaa7/0xf70
> [    9.630137]  ? __count_memcg_events+0x53/0xf0
> [    9.631172]  ? count_memcg_events.constprop.0+0x1a/0x30
> [    9.632397]  ? handle_mm_fault+0x1bb/0x2c0
> [    9.633389]  ? do_user_addr_fault+0x36c/0x620
> [    9.634435]  ? arch_exit_to_user_mode_prepare.isra.0+0x16/0xa0
> [    9.635817]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

That's fun.  We've seen many fixes in the kernel between 6.12 and 7.0
(and who knows what the downstream Debian kernels look like).  If
anyone has time it would be interesting to know the root cause and the
associated fix so it could be flagged for stable.

--=20
paul-moore.com
