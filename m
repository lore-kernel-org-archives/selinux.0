Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFB1ACED7;
	Tue, 28 Jan 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076657; cv=none; b=hNj51xF0RPJ1XrFkqwoAnTgvwy5Lym1QhoPCcsyphzqGEpF4zzYc/lK78aTIU6frmoKS/2oWvsSQPwL4U1/7txlZGoj8W+4zqPCTFYSlZhw0I7ZitFoctrZ+LRljspptAZqWLEfiKZmXdKyLqfUIsRhy2zO21tZukT5VwGIGQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076657; c=relaxed/simple;
	bh=ZzrIR3hQ/Nebaq+39nzM0SlnLzkgNb0FbarXiUN1eCk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lW8Wqh/WGUKE24tfSSYeO1TdOXfDIkySFpVBaDMRaHNBldTwjOimemHH+J+3VmVl4FwkspmBUKU6oYQgaQLFmOXCgYaj2pUg7/fn1JnENi/LjeSwxwDAPr+nqs7AHCAQg9sQFFe7B+u0KHrBstHBVUoXStbhiFcOFdF/CCxIzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=i1ymYKMc; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="i1ymYKMc"
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a28e:0:640:cac8:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id EA6726097C;
	Tue, 28 Jan 2025 17:58:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ewe6pVLOpGk0-7uo6oAgE;
	Tue, 28 Jan 2025 17:58:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738076321; bh=ZzrIR3hQ/Nebaq+39nzM0SlnLzkgNb0FbarXiUN1eCk=;
	h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
	b=i1ymYKMcemak1/rUGQRZKswI02W0NVx3J0CLGxeXS7JnGpL6FRjgkqGLLQ5ialPsw
	 mI6b4hb5H7HoJL8VOWI8wuF6H7L0SVNEOVuzPXFoKGWcLguFjerhfoqOigIcOiVi1/
	 /SdnPEM0gaImFV3Xzskfu8Y9MXBqT1RH14YSfZTU=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d1eed411-789a-48ec-8468-8e5005fff909@yandex.ru>
Date: Tue, 28 Jan 2025 17:58:40 +0300
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
To: Ondrej Mosnacek <omosnace@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 SElinux list <selinux@vger.kernel.org>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
 <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <fd2f411b-c499-47dc-8472-321d42a35f13@yandex.ru>
In-Reply-To: <fd2f411b-c499-47dc-8472-321d42a35f13@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

28.01.2025 17:45, stsp пишет:
> 28.01.2025 17:20, Ondrej Mosnacek пишет:
>> That could work, but the semantics become a bit weird, actually: When
>> you set both uid and gid, one of them needs to match. If you unset
>> uid/gid, you get a stricter condition (gid/uid must match). And if you
>> then also unset the other one, you suddenly get a less strict
>> condition than the first two - nothing has to match.
> Maybe this means that
> unsetting with -1 is something
> that shouldn't be done and/or
> allowed?
> In this case you only stricten.
> Modulo the inability to set both
> user/group at the same time,
> so you still get "less strict" when
> setting group after user already
> set...

It may actually be possible to
add the ioctl to set both at once.
In this case you also reset both
(with the same ioctl or add another
one for resetting both), which
makes the problem fully solved.

