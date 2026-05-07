Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17A44CF5B
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176671; cv=none; b=mK8t12OoTIt5tRPGCoSQlLY8wj15NucO5Xuq3LpA8TS+yoDGEZvJaKyhBShLzdNgjDfH+0GNn1oPfQfqV/4FiGmB9hwiYT93ZxvnsTSMcRXdqXovrrNnxdYUjJ8E8PMu9FuR8dn6j3HoFXWg8QyrTHTiv63ZFETKvM7t4hqaekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176671; c=relaxed/simple;
	bh=kCJf7OBpSGwNrO8oLxIKvtU+M1OUuDPDPvAZEdcpLCs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=FAyw/xXI35JRifla+Yw2yUEiBheG8ZxqDbDXJz4VXJLdgNg/hdk0kaLYIr/5bIpPao6KQ42m+DJoRtEejlMLDza6nXrHiMdX3K3zAat+pKjDwjJJo+JUXost61/PvUmT2QiHZnS3Fu1+QxjoNEFp62aeQ6DHXfsSFyxQo5WtCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=g6VZge0r; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="g6VZge0r"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2787E24196C
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 19:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1778176667; bh=18Yz7rTpsysNrEtzIFyv1jub6baLxA8qbz0vTa5f+BM=;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:Subject:From:To:From;
	b=g6VZge0rRLQh4cLdcUg8ROcMzml3HETHANUmPWnInw2eQIpteLCKaxQ9QLcNkx1lH
	 3Ck9J2hnnKNse9k1OKu+nElii4y2l5G9m7aZ7BZRkrnLW6tmFYk3eu5SfxPMD4BV9L
	 rXgGdF55Ab98KW7UZh+bQx5G9++I2QKUaOdW7kE+LJPGLq0Gb5rVOztFY4DS8k5+B0
	 KGQiJffyMivR1b54x/6GH3hqid47skdFdyflcmg63914g8jPAIeOB68ffBkUD8HJcG
	 odjEJY8vl5sqkuMrZrd43PGVRZaIaPw4cZQ93C7S+7lfwvYu002SCQMudDj/739+IN
	 qZHiiidhqRtTQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gBKj655hhz9rxL;
	Thu,  7 May 2026 19:57:46 +0200 (CEST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 May 2026 17:57:46 +0000
Message-Id: <DICN0RAL27J0.HFQFGZOGMV07@posteo.uk>
Subject: Re: SELinux userspace coding style
From: "Rahul Sandhu" <nvraxn@posteo.uk>
To: "Kalevi Kolttonen" <kalevi@kolttonen.fi>, "selinux-list"
 <selinux@vger.kernel.org>
References: <afzMqTAtz3aHEx9f@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
In-Reply-To: <afzMqTAtz3aHEx9f@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>

On Thu May 7, 2026 at 6:32 PM BST, Kalevi Kolttonen wrote:
> Hello!
>
> According to CONTRIBUTING.md, the following applies to
> the SELinux userspace code:
>
> "C code should be formatted using clang-format, using the
> .clang-format configuration file at the root of this repository."
>
> I guess this only applies to the new code, right?
>
> Inspecting the userspace code shows it is really a terrible
> mess of conflicting coding styles.  Of course the correctness
> of the code is the top priority, but compared to the kernel
> side code, the userspace looks almost like a jungle that
> developed without any consistent coding style during the
> past 20+ years: e.g. sometimes people use braces with short
> if-clauses, sometimes not (even within the same function!),
> sometimes goto labels are indented, sometimes not,
> pointer definitions vary with their use of space or not, etc.
> =20
> To be honest, this is *most annoying*, but realistically
> fixing the whole codebase would probably create a chaos
> of patches that would be unmanageable. Especially for
> the security related code, one would wish the situation
> were different, but there is no time machine and so it
> is what it is...
>
> I randomly picked just one C file and tried:
>
>   clang-format-17 -style=3Dfile < load_policy.c > l2.c
>   diff -u load_policy.c l2.c
>
> It sure produced lots of changes.
>
> br,
> KK


Hi Kalevi,

Yes, this is a bit of a mess right now. We forgot to reformat all the code
for the last release so my understanding is that it will be done for the ne=
xt
one. Until then, feel free to ignore the instructions pertaining to that pa=
rt
of the code style guide. :)

--=20
Rahul Sandhu
