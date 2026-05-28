Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7994963BD
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980146; cv=none; b=Kq4ohLcKnPNzbBB371aycsxDKcISwnpnwlUXJwZH4QsM3svD7GqOR7UMDHpUB56n20HTH/1/wKM0Oz/XqMk4MnBzB6lKjCb8vGbxq2klg9841Al6nLtGDXFLC8QtK9pUWIo0MpvfRkEVixvnYzqEjOk4tD+NJa27KPBz6tAzsZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980146; c=relaxed/simple;
	bh=yqfTgAMZe94usR8AruIoxhPxJl7f+rDrbPUNL0EpBzs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ihatEc5UzqUmSjyd1ofgdPn/qjq0TOtXuHdtB8GdffIVZuYEpJj1IeX8MvEEnZ4SYTraZ3XDtQrby+iqw53G5ZI3H5Z0cgrGVAZDUhn/BFQx+1bIzUjIXCPrxKMQw3LCz9u/7x//KojAREugGwBu8KrYqVkG6diii+pG/fqkWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=BA3S7j64; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="BA3S7j64"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DD4C4240101
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 16:53:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1779980039; bh=+DWqAJFel9wZyRSBp96LWoOK48/gQFNbRwnxcDbybCo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=BA3S7j642iWV0fYVAc4wMJ3QlhYKD+Q6W3GsDMSJeF6VF2t0LKCkbDV16iSHkeIfi
	 tXIf+uewp+yE2gENU8Ze/FtM2epGVAPSX9tgjzANItsDM2sa3bIMHGVHBj5QXWUfXt
	 33f7gyLvyqdcEkj3s1lCLFHosznqgyEe94aztZHUKwM3L+AQEjIzbwEdK09WIT+UkJ
	 V7knUZVKHgX9ETGHYre/ChRftpa/ivGoi4LVzQGWWrcE4Lpd0vJ2Bq9RggjwZ2v6SJ
	 Ss8uh+13hlPxY/KNaZoN8cn2dxpdsJ8pRhMT1MFDVnAb8CmUqlAcHZisYDPa1dnJNB
	 cI55Iemrt19uA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gR8dM34TXz9rxB
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 16:53:59 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: SElinux list <selinux@vger.kernel.org>
Subject: MRE: secilc and checkpolicy backend bugs
Date: Thu, 28 May 2026 14:53:59 +0000
Message-ID: <86ldd3k2kd.fsf@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

I have stumbled across some bugs in secilc and the backend for emitting
kernel policy language.

secilc appears to miscount AV rules that collapse to nothing, so seinfo
errors as the policy binary emitted by the compiler has no valid AV
rules contained within.

The backend for emitting kernel policy language used by secil2conf also
seems to emit invalid allow statements when cil permissions collapse to
nothing, something which is, at present, valid in CIL.

Patches for both are to follow soon. However, I'm a little unsure about
the semantics of allow rules that collapse to nothing: is there a
usecase for them and should the compiler error or warn on them? I'm not
sure if erroring, or at least doing so by default, is a good idea given
backwards compatability concerns, but I think it may very well be
reasonable to offer this as a warning.

Please see a minimal reproducer below:

rsandhu@carbon ~ $ cat repr.cil
(user u)
(userrange u lowlow)
(userlevel u low)
(userrole u r)

(role r)

(roletype r t)

(type t)

(sensitivity s0)
(sensitivityorder (s0))

(level low (s0))
(levelrange lowlow (low low))

(context context (u r t lowlow))

(sid kernel)
(sidorder (kernel))
(sidcontext kernel context)

(class foo (bar baz))
(classorder (foo))

(allow t self (foo (not (bar baz))))
rsandhu@carbon ~ $ secilc repr.cil
rsandhu@carbon ~ $ echo $?
0
rsandhu@carbon ~ $ file policy.35
policy.35: SE Linux policy v35 8 symbols 9 ocons
rsandhu@carbon ~ $ seinfo policy.35
Invalid policy: policy.35. A binary policy must be specified. (use e.g. policy.35 or sepolicy) Source policies are not supported.
rsandhu@carbon ~ $ ~/Workspace/selinux/userspace/secilc/secil2conf repr.cil
rsandhu@carbon ~ $ checkmodule policy.conf
policy.conf:5:ERROR 'syntax error' at token '}' on line 5:
type t;
allow t self : foo { };
checkmodule:  error(s) encountered while parsing configuration
rsandhu@carbon ~ $ sesearch policy.35 -A
Invalid policy: policy.35. A binary policy must be specified. (use e.g. policy.35 or sepolicy) Source policies are not supported.

-- 
Rahul Sandhu
