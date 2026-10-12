Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00349B5DF
	for <selinux@vger.kernel.org>; Mon, 12 Oct 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818601; cv=pass; b=edJZOjei5qpPookJNcYI8RJ62va7jjaGh55y4Z8/z2i0wKOaHYk/+8QL5QHXtJ/Co8MDGXm2Ic+A/RyauFQsmaXAudcsClQP36BS1mQVhv3orrS/QgMiyMmm3d7HtweJW/Gm2E4GPRZwfrMRZaNvlf3L19N1VNv0D5VJ1ICBKIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818601; c=relaxed/simple;
	bh=ZTliVUlbqhN96UOmLmVxV+MSqDsRny4axY4ONWBVUaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgLAWiQBoCO5viiPnLlwl4hF0d3QO0hSs3Hy5QP+4jmyo+VdnO1reT8H9PeeCaQiCypm91I2rwqsYDrOBXXkThOTg0G7nJi3HBS4m87uaf38sdnv7waJlQxLKlnz4Cjd82jJWte9DJAI9sQcHVWnmxnhC9vCPymP4j78v5GWYPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk72UCtg; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk72UCtg"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-675676afc3cso1919172d50.3
        for <selinux@vger.kernel.org>; Mon, 12 Oct 2026 08:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791818598; cv=none;
        d=google.com; s=arc-20260327;
        b=Dsjn1Qk2pEgXQYmAMOqRzfOrd3Ex5AUqwDPOWJGbj276VSLTpU8yG03DgCfngZgyH2
         dR6d1a1xTeLpSiL0vSAg4Vclj+j3Kl1RMO7h9SjLURUBUdGyyfuJkudz7JaSjLBZLiLo
         SPiWmLI3qa8yMEQuMSTePC6LotlQYnEBdiK6maPkfsMu9Dh+eCAMHMRsvu+y/50LNPlm
         eywETU9PTiVP6zOgb4qwJ1trp3p2XJTJBZtY9G8zw25uTWm8vWY7QaNopPOH6+JkVCF5
         23ilO4/A3cmEdRHBuwnK6cA8hsskkZEZ1g38XyMLdbuj0jdPzxTDV2g62+oLDiCxcxPG
         ZEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dxe5/7iE0L8+p44y9JDuvt/mRgid1dnQVUsBId/B/e0=;
        fh=AVo35WSrxuRBe4mK4l6REyQra+FLBSw02unxectkc68=;
        b=QIgImmQR7NnEl0Pb5PnwN3l7B7itmJmkyZX/1GXgknohQ2tw+iYT4NzHGH+4v3vKRg
         B9gE33sIlkniolkDxHNjoe3jp9+SxXvk7teM9uEPeiuRPQYdQeHKiU3HafeMjGWjr/06
         Qd1xgTozviXsFB4WcTKt9RWdC2+HMTUHgMffawkGYKPsVu2iOBgHPEGMMoXf9fLlZSLp
         IK9ctklftwbM0I94UCRS7L8+yDiDfhFLW1WD2VEaFQwI+lu68gc6h9UzCQkNi9iIwk+H
         aSIfkvgreHv7NRCWU9ufGe30cpu2UzUoGdXo0fWiHn13l5jcvuAwrDYHt42sOY0hHkvu
         FZOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791818598; x=1792423398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dxe5/7iE0L8+p44y9JDuvt/mRgid1dnQVUsBId/B/e0=;
        b=Vk72UCtg1FJGt6IIETfINuJHT7wXKgEY9Qbw3qEt7O9vb+OAcU/e68raoZtAWUJ1jG
         tD73IhvgFuFzgBtbS42Rejf/O54aW7yaCMlTCgODMQ1XZU64ujWo8oXLdqkp7c9X8b1z
         s/vjqh3D+8ysnSrOVytEVjqPNY+FX+FGWSXXcuWSezEb/63ldb0JAFm7Bu2cRo/+n2Vy
         1VX7Rvt/uEXf0RXCJOhSVAZMqap+U9zpCmAY55LLvA9S6+7OiQ0QNWGGxkEVwf0mbiag
         fi4T7kMtKuDZi+joA4LQVRfO/nkaJ5HAxaauZ2ierfzrFbiX2GU4UUbWzYn7aBz/Jh0w
         obvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818598; x=1792423398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxe5/7iE0L8+p44y9JDuvt/mRgid1dnQVUsBId/B/e0=;
        b=fUFJC5WULO/4EmALgYxcF9qG1JoADOxYFXjJiph1uISxhwLT7cd6ksukzKbUlkdBVP
         MMHrMe7M20IsRAwE71zzP7Q1d5Fv1QfvKU20M1LFBDC6pl19K9f5rwq8s0vhV09r3hxr
         C2kBcDe1QjRvIsQXRnhitkdvaKUlIn0fM5qUGn5y28zrYP+KYww56te//awaZleTCOC1
         27DfTp71zMum/FEjjrhQv27eLq+qEM19NKZJdYvBFtyoFmPjies067voroi5o/TLWqNh
         iPBQEf/lL2iZ4YMLoDTQFefphaS53mYdeaDsSEi/UYgkyqLNNELRaCkjN6zudS/uh+Gn
         anow==
X-Forwarded-Encrypted: i=1; AKwUvBx4gUnFSkKJxkypx8g5fcSSE7t44Trg/DWVZ7p7CnmvMXOLDm1C+I3+cdpHpxQivCBs1Ju2FcJ3@vger.kernel.org
X-Gm-Message-State: AFq9FYJEE53r0dfHtQ3DVa18TYh2QE6MLpeCuUzTlzSchfGyOCE5I0RH
	ymGwzkqs18Ted9p8HBB1vaIfDZgZi8HaNs4epay4NL0odnUG5+6Vmqy8fDjAgRFw6sYubJg/t1y
	0rqodoq66mzAMvlxGwCz4WMP3FD9nzfg=
X-Gm-Gg: AYBFou2R5wy9Y8Xb0witsiXduPRrKX13uQ5xEt6K7Wek+VtRP2EBDcwqIyppibsQGy9
	K7SOdMJowep+vFnwbIpvFc24EwtaF+4c18POF0X8a0ZK6MZ6xEwDP5JXGgshqWz/1k/8c2kds6/
	WbEwNFTNQn/ajGhnADerEpS41LVwu/WU4YnncU3+bVBkRDX0siwWucLxHpnmgmZrbvm7Hpirjea
	ls9/tfhs3G1jVmPDuHWViW0Vaj4Oh6dH+WqNApx11CK8KCy83JJf52kefnRB5RF9YIovSVvAqIm
	o7IeEgspUugwkmkeC2BdzUQ3F1d11fue+fewgBBQea3/GPQkJjg1erRm6KapWQZ6gOQ=
X-Received: by 2002:a53:ac86:0:b0:677:d0da:192b with SMTP id
 956f58d0204a3-67936006671mr3791582d50.31.1791818598572; Mon, 12 Oct 2026
 08:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_96F9E846FDA4A67FF38C7C393D985A44690A@qq.com>
In-Reply-To: <tencent_96F9E846FDA4A67FF38C7C393D985A44690A@qq.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 12 Oct 2026 11:23:07 -0400
X-Gm-Features: AclHuK-lsvXIdaTbY4bhYNDRFlD_elSj2POyX4r8YNdsklre3_y2ohDtohrCN9k
Message-ID: <CAEjxPJ6oN4zZ+0fTS8+Unp7wNRYZxjWCBrc5XQLUOFbt-xU2Hg@mail.gmail.com>
Subject: Re: [BUG REPORT] selinux: general protection fault in
 avtab_search_node() during an AVC lookup
To: 1sh1ro <yangguikun19@qq.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnacek@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 10:38=E2=80=AFAM 1sh1ro <yangguikun19@qq.com> wrote=
:
>
> Hi Paul, Stephen,
>
> fuzzing with syzkaller on a 7.3.0-rc5 KASAN kernel (SELinux enabled,
> permissive) produced a general protection fault in avtab_search_node() fr=
om
> the AVC lookup path.  The policy's avtab appears to contain garbage: the
> first fault reads a non-canonical address, and it is followed by thousand=
s
> of further Oopses (8850 in this run) as later lookups keep hitting the
> broken structure.
>
> The crash
> ---------
>
> Oops: general protection fault, probably for non-canonical address 0xe06f=
3dc280000000: 0000 [#1] SMP KASAN NOPTI
> KASAN: maybe wild-memory-access in range [0x037a0e1400000000-0x037a0e1400=
000007]
> CPU: 1 UID: 0 PID: 14271 Comm: systemd-udevd Not tainted 7.3.0-rc5 #2 PRE=
EMPT(lazy)
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-de=
bian-1.16.3-2 04/01/2014
> RIP: 0010:avtab_search_node+0x24d/0x4d0
> Call Trace:
>  <TASK>
>  cond_compute_av+0x59/0x340
>  context_struct_compute_av+0x7f2/0x11f0
>  security_compute_av+0x558/0xd60
>  avc_compute_av+0x86/0x820
>  avc_perm_nonode+0x9b/0x170
>  avc_has_perm+0x27b/0x2f0
>  selinux_inode_follow_link+0x226/0x380
>  security_inode_follow_link+0x96/0xe0
>  pick_link+0x447/0x1570
>  step_into_slowpath+0x928/0xdd0
>  link_path_walk+0xdae/0x1b20
>  path_lookupat+0x70/0xb80
>  filename_lookup+0x213/0x5e0
>  filename_setxattr+0x89/0x1b0
>  path_setxattrat+0x1cc/0x2a0
>  __x64_sys_setxattr+0xc6/0x140
>  do_syscall_64+0xec/0x4e0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
>
> Context
> -------
>
> - The task is systemd-udevd (uid 0) in setxattr() (ORIG_RAX 0xbc), which
>   follows a symlink while walking the path; the first AVC decision for th=
e
>   symlink hits the corrupt avtab.
> - The same crash appeared on three runs of this fuzzing instance:
>   2026-10-08 23:39 UTC, 2026-10-12 04:50 UTC and 2026-10-12 10:48 UTC.
> - The kernel log of the crashing run shows only avc denials
>   (permissive=3D1) and no policy (re)load, so the avtab was already corru=
pt
>   when this lookup happened.  From this run alone I cannot tell whether t=
he
>   corruption originates in SELinux or comes from an unrelated memory
>   corruption bug in the same fuzzing session (that instance also produced
>   unrelated memory-safety crashes around the same time).
> - No reproducer: the instance ran with syzkaller's reproduce disabled.  I
>   can rerun it with reproduce enabled if you would like one.

Yes, please rerun it with reproduce enabled. Thanks.

> 7.3-rc5 already contains the recent policy-load validation fixes (class a=
nd
> permission counts, level category sets, boolean values), so this looks li=
ke
> a separate instance of the avtab-corruption family rather than one of tho=
se.
>
> Thanks,
> 1sh1ro
>
