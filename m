Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38E42AA3;
	Tue, 28 Jan 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738075899; cv=none; b=T+EAeuQdO7iM9A9AgNJ7E7ceNJoTYD1xWcOdnzOkZ+mo/QiKLGm7qh9gOJBgeh50jHKybxylSPW3jKDdLrbvN5uRSAoCAOuvE8x9Wt65D6Pb/zVCh339d3gtOBQp6YzxJdiqAP6ja/pzzZW0lZuNu+g+lFp9ynxSPIa6cNc9fow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738075899; c=relaxed/simple;
	bh=zxhSE2Vg3QjGjf0jXaebTM2bZQ7lbrsCGviXBJwmR1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQz3cTWsVHkklvC/qVVmoYClcGZgoHbeBC2cprduyjzVYVAM4hKo8W5AqMTuLUxMtrBu2ATp3T0etqSv0hJ7LY4wzj9lRIdVOxeduoLCg3SsU+pZxDm+8gf8Ni+1la6W4pUboe421IffHvpKtpfhFVkwIZPiR389ZQcLiBiZI/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=CfDhyt7S; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="CfDhyt7S"
Received: from mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4caf:0:640:9790:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id E7C6061202;
	Tue, 28 Jan 2025 17:45:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id hjeV17tOhqM0-MKcNK6MC;
	Tue, 28 Jan 2025 17:45:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738075544; bh=zxhSE2Vg3QjGjf0jXaebTM2bZQ7lbrsCGviXBJwmR1k=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=CfDhyt7S36PAV9LHljGZEYQOjsOWgOXrQV/bCEZdbUBRmn+BPBEBmgCny5c88tmzW
	 T0WdXtBOlnbv3eC15AvIs0q6may9MVbLavbf0vG7xIC1E5hP8Rd3zAxB2OEq8JzZ7t
	 Zv+u2uJ3atDmn43hXI8je0fbcsXnvbL9GI54a2V8=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <fd2f411b-c499-47dc-8472-321d42a35f13@yandex.ru>
Date: Tue, 28 Jan 2025 17:45:43 +0300
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
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 SElinux list <selinux@vger.kernel.org>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
 <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

28.01.2025 17:20, Ondrej Mosnacek пишет:
> That could work, but the semantics become a bit weird, actually: When
> you set both uid and gid, one of them needs to match. If you unset
> uid/gid, you get a stricter condition (gid/uid must match). And if you
> then also unset the other one, you suddenly get a less strict
> condition than the first two - nothing has to match.
Maybe this means that
unsetting with -1 is something
that shouldn't be done and/or
allowed?
In this case you only stricten.
Modulo the inability to set both
user/group at the same time,
so you still get "less strict" when
setting group after user already
set...
