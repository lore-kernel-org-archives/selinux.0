Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B538DEC;
	Mon, 27 Jan 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990389; cv=none; b=NsopLZp5A58xeFEOA9L+Usv0P7zBNJNWs/zYnWmkWawciwSRJAsy/kSEyERwSsG9830LJXz2nQ+ZwRhNJGIuf06uIkCh5JJRHP6NDR/aCD75A/yLzNw6DwYaRd5a64zpGpm0AgxoMiHiiwXdDRxwTdf75SVFOdY7l523BwVgt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990389; c=relaxed/simple;
	bh=GPl6WM1o3qJh2IXD7n1MyxuqxoUNMiwnsLudNpxSMek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfDATaC3NJ5lTDRNxCcyw920GDQeuj8oIdWmj84mkSXI7IrY8uHGJylSTC2Ym0PZ6Bqy/7LrYbhGMsIDcntaJj7OA/6wnHlCdxxciWZ+PdsZ/mHXT0BbuOHPi3x9iEEO6NuoMxToAZM9HWnlaeXXiAAd9v5IRdDk46wmn52QFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=qK+brCiq; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qK+brCiq"
Received: from mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:86a3:0:640:3a48:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id E087C60FD3;
	Mon, 27 Jan 2025 17:58:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id DwdhQljOf4Y0-OzeTgOCL;
	Mon, 27 Jan 2025 17:58:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1737989894; bh=lmEQu1PhyP+zEsEpjmNS4QF61wVqPu8L7WVxpIZ3WpE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=qK+brCiqA2E7uj/w3BEixbJZKUUzt59LI2rYIdTyYoG5ynH5jhb6LX4eAwiOjtZSd
	 dx9YqBY3E7VifDJ4lwKjb/xRIGwvsuCtgMm0Fgz+TsMA/Di6lySBp4n4cXB9MiIMdS
	 np1HK9YH8xwXD4DsddTNRbbtLTl8fw47CDaJAdqw=
Authentication-Results: mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <e4a8a2f6-c581-46c9-98f3-16e8c68b4107@yandex.ru>
Date: Mon, 27 Jan 2025 17:58:13 +0300
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
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 SElinux list <selinux@vger.kernel.org>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
 <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

27.01.2025 17:50, Willem de Bruijn пишет:
> Thanks for the report Ondrej.
>
> Agreed that we need to reinstate this. I suggest this explicit
> extra branch after the more likely cases:
>
>          @@ -585,6 +585,9 @@ static inline bool tun_capable(struct tun_struct *tun)
>          		return 1;
>          	if (gid_valid(tun->group) && in_egroup_p(tun->group))
>          		return 1;
>          +       if (!uid_valid(tun->owner) && !gid_valid(tun->group))
>          +               return 1;
>          +
>          	return 0;
>           }
>
> The intent clearly has always been to allow access if owner and group
> are not explicitly set.
Perfectly fine with me.
I'd raise the question about
the security implications, but
definitely not within this
regression subject.
