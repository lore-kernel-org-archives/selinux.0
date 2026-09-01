Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21073B0AD4
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265308; cv=pass; b=qwg+EMAp7NSYY41M0ClJ1eu03xoAptbx60ueLZucl523SmgwB/MUroyzexdkdXcJnSddOABCB3ux8iTFvB/qtNZW+Sty7Jh5VmrkqkB1xiz2vYIApSQXGWFlAHHp8wT4s9jyOAdN/lp3UYyN4ocdq+hVm6EqLurZIkmazvs3MDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265308; c=relaxed/simple;
	bh=DSjEh0ldhPBvfVqgLmU/C0Fr0MP70X5OMM071hFTFVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=azLxhreBqsLQ1pqziUPraOWuAyBYmb/JO9jRu1Wl25z+Zsodw6BEOP85+fVy7u++I0MeYLcvnzqDrnIcclJm0FBVyzU6ic9eFzcH9hAqkOZDUgkqFIVpzJiSQ/egqEqdzlJ8LopeX89+VkJmSloDoyECPzlwPae5L4QPma+xlsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWaKS9rX; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWaKS9rX"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b1afdf98dfso509464eaf.3
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 05:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788265306; cv=none;
        d=google.com; s=arc-20260327;
        b=RubI3VPP2gJK53+RFhrL1FPqBIa7O20J2Sbm4GsM6MDY7JwnhzZuMgXAGANryWAXA6
         oQ0AmInYFmMNRrJu71LOT3QL66JLUNMFgKLNMZeCcRFhOqabzB2uAehAz2jvIf5aoBY4
         T4fwxN2rqlzmlj417e5AZ+J/PhrRBBiWzupxJsq4yMlW1bezq9RazDfbPwrKs5Mi+axn
         l1MwZf/Eo8cFDJOoJdAjYTm5fZfspq0oLaKW/6gZe6RaGNr+chf0ga8Nw65l5tCmtxnx
         EiERI6V150NgkpQ8KoJRqCLTabd40pLWJoe4TlBAPOssUxxkkq1ojytvYyNrXLd9F/zF
         4LFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=J36r9riRAqOKGfr7yHvW0iVypPgyafMmdGnBRenIjd0=;
        fh=qNDa0FzwtdQOGqvzqgBwpYTOHVcSxfX8SLritF2o1LI=;
        b=WUL7QxBUc+WkAyZ+gWjXmtrnx/DysUZYB4IA5OYhJqmRz7lvqgt/2h8dWR8ZUmQYgu
         fD3+5LlcXV/mqZr4zBbODDcCItSNgbF/vBroUgqfMNMw5EnH1OHqKPUgVP1tX2IWOGGs
         ILNVQ+vC9OoiSBtHU5mxpBKo+hjk1VSOY4sHpKhbCKcgxhMMJk5ZxGKfoaNvzBrX4tRk
         x9+95hnzkwKup1db4zs4MBg2fLKPoiVNzWLkrlyPj9TrQP2WWC2A7Qp0lDuNkDZE2MN0
         MLDlMUshv1R1s0UzMxCfP/DkowlefQSqFpUtRrHITj89Ui9UL9Qkth6ePhFG4wpYwyzB
         aKGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788265306; x=1788870106; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J36r9riRAqOKGfr7yHvW0iVypPgyafMmdGnBRenIjd0=;
        b=gWaKS9rXsyH1Oj3Q/7C2top4Ue7IySz+QDkkYKg+sPgEKYHcuORDTI4UWuYa1ao5fN
         5RmRm6JVoMNc+9GCtc2zRyabbFs9MqzeNMbkpThuK2/ylF4uB5QU03dEqanQHo0iILlk
         uOEk7rNDz4JdIqlwQS2Q8U2PiFeYFGC8clhNFAK4DA0tesKhYhJs77BJQt/ufxmpuK08
         3TX35LxBeTHy+gmaJdHsOds8b/lK55FpZUP6rBho++sCrXnQKZkZBoPCK44N/ZBxQgJZ
         0GnPsaY0VkM+R+mUsBndCPipG4nz1P4YRvKvEDs8cgEuVOO1PS6V795jQVFdIuhoM5Ek
         posw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265306; x=1788870106;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J36r9riRAqOKGfr7yHvW0iVypPgyafMmdGnBRenIjd0=;
        b=ngs6YFy1mhBpYPbvdae/fmucRNFxliQ0hmgGr2QqTzC7QhKMaIWuzSwCZCm95tj5dJ
         v7syoe2yMsdC3GIMKd3+JUbKAOZSqwm7an2o6t8hIfTLmFz2SCA6f7ewOWX9zB3SNijn
         wgaDbtnaI1MFWy4gMjClE5ZdWcrPrCLEbkLjF4f9xIKanJmdBkl5yZhunLvm4swLJ/Nb
         WsJoMO2WF+pKpqz9Kqyt9VNJYFZEPlJih2N2tTZVTfJrEJn1R+TxASMq3Qplcl14AO25
         6NUOAdxpGyRN2BFlGaPSrc1Yf+ouyoA9VMrsqnuqlyDpseWvIRTpXtv0KlP8D0SSsJVv
         1z0A==
X-Gm-Message-State: AFuF++lJ5Jz7Y0WoDbyV4AulRsbfV1ttVaZiXpi1Gm3VhGmE1EP62cck
	d6uSDtQ9HK26roSHOlIFHlI3o7wOKh+7bXX6ccuXuhrDbHSuwOUSzMMNGwXhuNYoIlshflXvl9H
	Ur5/q/sTOsv/+ErsKKEGdwEDnMISXWLWJ7g==
X-Gm-Gg: AR+sD114JYmWYP1oBm6XF93Du8UVwAe151Gb8mO1PR/nVrjJrXfBeo3qwABmTMaMC89
	lH72/EzVEmSKDx0aQwGuzpWQZ74CRCtBF9Nxp5pK+KiMXZ8pdIFQSVM0fgBr3uVTsauQPLdahPw
	E894tbyUCuorF4cAiC1TO8t60wpfcaiDD6jvKi6pzb+ckLzZP5pyB6YqyJ56udXzRLRLfGy5rz9
	yFrHqx9LjybhXB0dFtBhUFXQDQUI8dF/mEPHtPPz2zxLIwi1sbHhL+zb5XpTR9rg9/fRi761cGr
	TnGzXoF7kCG1co7ijRYAyDH4cciGfwEfpKGhmMrpADfz
X-Received: by 2002:a05:6820:1c9b:b0:6b1:c6df:868e with SMTP id
 006d021491bc7-6b1c6df86b2mr27792992eaf.13.1788265305647; Tue, 01 Sep 2026
 05:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <L8sbFRgfQca4r8AaNEEfTw@coker.com.au>
In-Reply-To: <L8sbFRgfQca4r8AaNEEfTw@coker.com.au>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 1 Sep 2026 08:21:34 -0400
X-Gm-Features: AcwNN1WF6YJcBc8vVGSSJtew7xr6z27g1eo54bPM9g9YEGCY2qofgzXrP-TQWFM
Message-ID: <CAEjxPJ6SQcdEDFfV3W7Bk5JKbAxRp+9tuvr2yhUdDePmeXNAKA@mail.gmail.com>
Subject: Fwd: kernel oops on recent policy with older kernel.
To: SElinux list <selinux@vger.kernel.org>, selinux-refpolicy@vger.kernel.org, 
	Russell Coker <russell@coker.com.au>, Chris PeBenito <pebenito@ieee.org>, 
	Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"

---------- Forwarded message ----------
From: Russell Coker <russell@coker.com.au>
To: "SELinuxProject/refpolicy" <refpolicy@noreply.github.com>
Cc:
Bcc:
Date: Wed, 22 Jul 2026 21:04:27 +1000
Subject: kernel oops on recent policy with older kernel.
I get the above when loading the latest git policy compiled with 3.11
userspace on Debian kernel 6.12.74+deb13+1 and Debian kernel 6.12.86+deb13.
The same policy on a 7.x kernel such as 7.0.13+deb14 works correctly.


[    9.571350] SELinux: no sid found, defaulting to security isid for /
booleans/httpd_can_network_connect_cobbler
[    9.573682] SELinux: no sid found, defaulting to security isid for /
booleans/httpd_can_network_connect_db
[    9.575883] SELinux: no sid found, defaulting to security isid for /
booleans/httpd_can_network_connect_ldap
[    9.578956] SELinux: failed to initialize selinuxfs
[    9.580143] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    9.581804] #PF: supervisor read access in kernel mode
[    9.583012] #PF: error_code(0x0000) - not-present page
[    9.584222] PGD 0 P4D 0
[    9.584875] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[    9.585964] CPU: 3 UID: 0 PID: 1 Comm: systemd Not tainted 6.12.74+deb13+1-
amd64 #1  Debian 6.12.74-2
[    9.588099] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.17.0-debian-1.17.0-1 04/01/2014
[    9.590356] RIP: 0010:selinux_policy_cancel+0x15/0x60
[    9.592457] Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 66 0f 1f 00 0f 1f 44 00 00 48 8b 05 a8 fe 2d 02 55 48 89 fd 53 <48> 8b
38 e8 d3 49 ff ff 48 8b 5d 00 48 85 db 74 2d 48 8b 3b e8 82
[    9.596798] RSP: 0018:ffffd1c640013b50 EFLAGS: 00010246
[    9.598016] RAX: 0000000000000000 RBX: fffffffffffffffe RCX:
0000000000000003
[    9.599682] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
ffffd1c640013c00
[    9.609068] RBP: ffffd1c640013c00 R08: 0000000000000000 R09:
ffffd1c6400139f8
[    9.610713] R10: ffffffff8d2b43c8 R11: 0000000000000003 R12:
ffff8d9286eb8ad8
[    9.612339] R13: ffff8d92867dd000 R14: ffffd1c6406e9000 R15:
ffff8d9284b02000
[    9.614014] FS:  00007f504bf3ec80(0000) GS:ffff8d92f9f80000(0000) knlGS:
0000000000000000
[    9.615863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.617216] CR2: 0000000000000000 CR3: 000000000107a003 CR4:
0000000000370ef0
[    9.618842] Call Trace:
[    9.620299]  <TASK>
[    9.620887]  sel_write_load+0x5dd/0xbb0
[    9.621809]  vfs_write+0xf8/0x440
[    9.622590]  ? __alloc_pages_noprof+0x16b/0x310
[    9.623640]  ksys_write+0x6d/0xf0
[    9.624477]  do_syscall_64+0x82/0x190
[    9.625375]  ? __folio_mod_stat+0x26/0x80
[    9.626330]  ? set_ptes.isra.0+0x36/0x80
[    9.627265]  ? _raw_spin_unlock+0xe/0x30
[    9.628168]  ? do_wp_page+0x41c/0xcd0
[    9.629111]  ? __handle_mm_fault+0xaa7/0xf70
[    9.630137]  ? __count_memcg_events+0x53/0xf0
[    9.631172]  ? count_memcg_events.constprop.0+0x1a/0x30
[    9.632397]  ? handle_mm_fault+0x1bb/0x2c0
[    9.633389]  ? do_user_addr_fault+0x36c/0x620
[    9.634435]  ? arch_exit_to_user_mode_prepare.isra.0+0x16/0xa0
[    9.635817]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

--
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
