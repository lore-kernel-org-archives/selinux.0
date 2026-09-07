Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E02DC331
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815360; cv=none; b=rzp0Xo+dJaUUlrT3rjmw8TOuvFAq9/FqGb0rLxSFa8ooh7la3j/XYEVNCN0z7dl2vtoCYykbYhDrkQBFt0zsH8eS5L5+Vo/W7p/ri8MafltWRIocpaKH/nNvtj4oJp/2HrRAxaTtVde7ZXPQaganaveAbn1NottCTeLiSdNPjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815360; c=relaxed/simple;
	bh=fguIKbmLRB0Qr/oQOvUbfs80c+6Prly/HGoDXW5l3I0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HwAzGR0Ii4hailSu8Q2qS5WQtf85503FfgK+rWITcwXI6QGrVcGpjIUuQLZcKTvFWrWQcA1HbKybnSVRQFk+dWK+LdC0No2UuzAIU5B3J/KggEYF34h3dJluxNhz1NIxHLOPqsB20CVdqpyz6UP9XxdJXyAyCZLqVRnURvQgS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fufc8g07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fufc8g07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FB61F00A3A
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 21:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788815358;
	bh=fguIKbmLRB0Qr/oQOvUbfs80c+6Prly/HGoDXW5l3I0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fufc8g076KnFncxmXuyiMgJ9o8KYy2eaO+xmvFYtpfjjWVg6osRG0oNtx6NtQ63oz
	 sdmeHhN+oxiaQXFU8WmC+rp9hl4YzAXPWVacaMuZrrTQF2XbdScXSoqa38b/aAdnmv
	 er8bakJ+lKRhkUVrCuV5L4xdiPBLrG7fr8VvKhqR/YVXI5fAsz8doM9uRhBAgNAAgK
	 PpT8DQBUjZQtxDiuCzIUwHhkJel42sILBAGgV3Wd/9lsyNLb55anYig9ucP8tUvoHq
	 Mx+BfQRwB0zFMp6JdxnGo1ROuSD2kbRGwl39DQzjc08K6JAKnQapO97Qnmezrdk87m
	 a138cwcQbSvmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] proc: query LSMs for introspective mem access
 (if PROC_MEM_FORCE_ALWAYS)
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 21:09:18 +0000
Message-Id: <20260907210918.77FB61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have =
no
> good opportunity to block a process from overwriting read-only code in its
> own address space through FOLL_FORCE writes via /proc/self/mem.
> The security_ptrace_access_check() LSM hook is bypassed when a process
> opens /proc/self/mem because this is considered "introspection".
>=20
> This causes a hole in SELinux EXECMEM enforcement, which tries to ensure
> that a process cannot create executable anonymous pages.
>=20
> PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> accesses are only possible when the LSM allows ptrace() attachment; but it
> is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> environments running lots of third-party code, such as Android.
>=20
> So, introduce a new LSM hook that can forbid FOLL_FORCE specifically for
> such "introspective" accesses.
>=20
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Jann Horn <jannh@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-selinux-po=
kemem-v3-0-0bafbaeafe50@google.com?part=3D2

