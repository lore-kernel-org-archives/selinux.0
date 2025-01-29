Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3BFDF78;
	Wed, 29 Jan 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160889; cv=none; b=bZ6GZDUo0TqZhvmbaPBVJaZ5TIuSmDmhSkpeJyy5j5ODpejP9F74mpvwTozW+ONtoXuaadVxk6dErWfN6Z1AXlMsGHiss66hRhgo0ov+wcBk4xuABhYSTzGOkJdTTW0ZVuMlko6iIepqafegUYnu8vZ32bIo0HvObKDhNKZ9JsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160889; c=relaxed/simple;
	bh=0X6XA8qSo+B+sKUSwtlUX1AWbUmalf/RLSTJ+WfBTSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/Ef7ZS7SQtXdd9uPi97wXDcfjNFB3DCFDpXvR/birIFJzEV8ZEOAWd4CtZ3jVTzg91gfC9FzpRI8fY48VYzzS6ftjdeetNVxusi7GS63Gccyf1xzTuiOUE/xwcuZ/H0T5fpJo4IQPgSbBq/kVKc6sDeQsc3OQzC+3Kb8LfQu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=bOUxl2g4; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="bOUxl2g4"
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:26a5:0:640:547b:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 6EF10612F2;
	Wed, 29 Jan 2025 17:27:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qRfUoG5OfiE0-P3CXM5K9;
	Wed, 29 Jan 2025 17:27:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738160872; bh=0X6XA8qSo+B+sKUSwtlUX1AWbUmalf/RLSTJ+WfBTSo=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=bOUxl2g4vLRh8AZDdxTv7Sm8SuNDXXZz8jVKWMcbNlAyrZeX0oIa1qmurtP5YXhmw
	 nhDrL/zCHNNod337Jy1fLtRnL8nZ20SUMlJlYjjP9pHHaX2f3o8eoEwS3F+IqYA8J7
	 X0lEQJWE+nSPIZCkI+0C7OJ82uaPEeSOGO9OvDX4=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <04879909-72e5-4ab6-8c28-5d3cb551feb5@yandex.ru>
Date: Wed, 29 Jan 2025 17:27:52 +0300
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
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 SElinux list <selinux@vger.kernel.org>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
 <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch>
 <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
 <67996154e30ce_d9324294c4@willemb.c.googlers.com.notmuch>
 <8b81a534-9c30-4123-bd7d-bf3a9d89dfcb@yandex.ru>
 <679a376739b99_132e08294f3@willemb.c.googlers.com.notmuch>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <679a376739b99_132e08294f3@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

29.01.2025 17:12, Willem de Bruijn пишет:
> stsp wrote:
>> 29.01.2025 01:59, Willem de Bruijn пишет:
>>> stsp wrote:
>>>> By doing that you indeed avoid
>>>> the problem of "completely
>>>> inaccessible tap". However, that
>>>> breaks my setup, as I really
>>>> intended to provide tap to the
>>>> owner and the unrelated group.
>>>> This is because, eg when setting
>>>> a CI job, you can add the needed
>>>> user to the needed group, but
>>>> you also need to re-login, which
>>>> is not always possible. :(
>>> Could you leave tun->owner unset?
>> That's exactly the problem: when
>> the user is not in the needed group,
>> then you need to unset _both_.
>> Unsetting only owner is not enough.
>> Adding the user to the group is not
>> enough because then you need to
>> re-login (bad for CI jobs).
> At some point we can question whether the issue is with the setup,
> rather than the kernel mechanism.
>
> Why does your setup have an initial user that lacks the group
> permissions of the later processes, and a tun instance that has both
> owner and group constraints set?
>
> Can this be fixed in userspace, rather than allow this odd case in the
> kernel. Is it baked deeply into common containerization tools, say?

No-no, its not a real or unfixible
problem. At the end, I can just
drop both group and user ownership
of the TAP, and simply not to care.
My aforementioned attempt to
allow changing suppl groups, was
not directed to this particular case -
inability to change suppl groups
create much bigger problems in
other areas, but my TAP problem
is really very small.
Which is why, eg if you decide to
use "either-or" semantic - fine with
me. I just think that completely
reverting the patch is a sub-optimal
choice, as the previous situation
was even more broken than now.

