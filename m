Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2F135A63;
	Mon, 27 Jan 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972341; cv=none; b=Ob4yKh0tuJdcmGLW9OZcz55XVem7s44bV0pRXWR3GuMhBT/sBn5KsaNPYU3cfqLbIWmhQz7QGOH//4g9+VDLt+/GDnf1blg6bGsuuqE5iEOczH8YoBcjTfoeJdxRtwulX1UQMZ9w8PWO8Dex7Nm68ch1mbUls4ILQ+7j1BYF2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972341; c=relaxed/simple;
	bh=AmsbEOkxtq6HwJPruOJ2w8tebz/UW09m5tFoi/aFVhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSl3nnJHaHPJLr0gwfJlubA96QKXZHX7ImvmBn01DWu1sExEwzLcs1wnx1eQPE6xkoytDqVeRzItAbcUv0d1LMA9veDUPp9Zq8Cq4LzvAeSWnxIjvY5I1d+irhp8HBrB6JXS6k6LKEYgxH3UYXCrpxrpfawreTqDKb+CS4sa3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=vU1QRx1R; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vU1QRx1R"
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5830:0:640:6cd7:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 0C3BD61055;
	Mon, 27 Jan 2025 13:00:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 30ZIHRbOkSw0-JR5L9Qrx;
	Mon, 27 Jan 2025 13:00:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1737972004; bh=AmsbEOkxtq6HwJPruOJ2w8tebz/UW09m5tFoi/aFVhs=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=vU1QRx1RhHvZLPlDUWYOvwSJuI5j1XBP6B5zr4WXdAKpYyLeyPNk2xNlql/N4iL1I
	 pUpNiZ/vL4VQdjUFI5C70/9eaGVogcgMgI1VJsq0QDa4cIcyl0hA05sp8fz8xrQMfq
	 JVoyplWrj+5ONHTVeY3kRlJiS0w8h6ZbYYybNcCY=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
Date: Mon, 27 Jan 2025 13:00:03 +0300
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
To: Ondrej Mosnacek <omosnace@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 SElinux list <selinux@vger.kernel.org>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

27.01.2025 12:10, Ondrej Mosnacek пишет:
> Hello,
>
> It looks like the commit in $SUBJ may have introduced an unintended
> change in behavior. According to the commit message, the intent was to
> require just one of {user, group} to match instead of both, which
> sounds reasonable, but the commit also changes the behavior for when
> neither of tun->owner and tun->group is set. Before the commit the
> access was always allowed, while after the commit CAP_NET_ADMIN is
> required in this case.
>
> I'm asking because the tun_tap subtest of selinux-testuite [1] started
> to fail after this commit (it assumed CAP_NET_ADMIN was not needed),
> so I'm trying to figure out if we need to change the test or if it
> needs to be fixed in the kernel.
>
> Thanks,
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/
>
Hi, IMHO having the persistent
TAP device inaccessible by anyone
but the CAP_NET_ADMIN is rather
useless, so the compatibility should
be restored on the kernel side.
I'd raise the questions about adding
the CAP_NET_ADMIN checks into
TUNSETOWNER and/or TUNSETPERSIST,
but this particular change to TUNSETIFF,
at least on my side, was unintentional.

Sorry about that. :(

