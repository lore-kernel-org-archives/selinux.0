Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83227FD76
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083211; cv=none; b=Z6hxpW78QTeoCoLjaPkzYT0JJQWBmbZVX+ADHHs8h+jE0ozHynQ+rmBf86isC8F2SIPwD9B+BF4x10weT7KvdY6SPksfulWvXM3wfYpIfOHPLE8pdS9GqCCSL9HJ4PtsPctNpFwsktpyrEuNkBL9vl+WJxkMMNDMjIoHrYN3aIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083211; c=relaxed/simple;
	bh=7VNkNt7hrCVkrJ720i6Mh6g1eOYRmBUNp5rxGP7RKJ8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tutpChDBFdDfyrO1qGGncqkQmccR/n1b+mAf1XLH8xH6CBOQXSB3DkbitQakozRf1lbhPMaHdLDKwa72Mg5Wp574Nz9zoFWVgjWtmvw20MFLiKLOWLkOtV+U4XkwOElx7//LFMMj3ExUNKqIGD4TYNxTI1IMBTh+yygLO1akBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4y8c8NH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4y8c8NH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C3E1F000E9
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787083209;
	bh=7VNkNt7hrCVkrJ720i6Mh6g1eOYRmBUNp5rxGP7RKJ8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=c4y8c8NHUDvPKm4r/Lw0kIecZFHCssGQlwk8plNTgJv5yCXG4Kj4HW1UqywNcJs/n
	 LBt8Xd5gtkF/S2nap5wvl2CHvj3O1QAKuY37cKStHzkeXb6hxrx/hOFIvE/Ec2lkty
	 +6XXLjJco4bGA/wgdIlJs6TJd2garCUjVY7z8/fBgu1m4w16tIKC8K9XScc8ANb1b8
	 SgMpaSW+hT7MjyToX8GzLkSzeYTnC91I4nFXuYRDi4OfiK6iF63yv21vOj8gSMd0WC
	 +SvjwPWnmrZOlK1Zm4T7iO4uGRguQWcK2HRqMeb0RdKXvRadGWpqWEqVw4c1gmxskg
	 eUamZGQFvEBmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 20:00:09 +0000
Message-Id: <20260818200009.C2C3E1F000E9@smtp.kernel.org>
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
> Signed-off-by: Jann Horn <jannh@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-selinux-po=
kemem-v1-0-90cd2357ee05@google.com?part=3D2

