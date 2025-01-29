Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7B25A641;
	Wed, 29 Jan 2025 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738133978; cv=none; b=j6vHt+51/jr/Y2M80hgkpiVikuSbXp5Of58vtPsakvTrTEIXTiCm8Prfk7KdpI/7bGNySvO08y0ZGS9Q38d5gRbHbC04aemVPURonBoqvCVTCTTyzEAApfMiFR/l2nHbgYpZ3tFC/M7FnATWZ6L+Uqflu5n7INUJ5IY00jaLDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738133978; c=relaxed/simple;
	bh=9W49qK+P6h5kNqSXCMEaqgJpO8hlGAcadnbRGKBbszg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neKpQt988efI4Bs2j2MH2AhDMoP3YCy5nio+fHKF3delehsRZh495wrlljw2cAG8U1KvKbU8iPL8Tj4uBwoobGuleVCTROOGITmK3Cs7p8c/I7B3EuShLExnz/o+7jAyqhkvR0Ljj0fawVSP6DsKcIify0u8jOGDMoBxdu+y95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Vtei/BOY; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Vtei/BOY"
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2527:0:640:39b3:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id BE5806196C;
	Wed, 29 Jan 2025 09:59:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PxX2mV2OhKo0-aK4teXgU;
	Wed, 29 Jan 2025 09:59:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738133966; bh=9W49qK+P6h5kNqSXCMEaqgJpO8hlGAcadnbRGKBbszg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=Vtei/BOY5wKLZFvb1ywWSqGnwldYAc8qhr/Lt+suyr4ocmH2Pfymt4SNZzDlnYke7
	 WZ/r9nGnGkGQMcweTQ1Rrg+sI2nNs7jkWsdqEZwU3hA6dWybJ7sF0O5TB1RgACkpaB
	 nIruQAf90LpDFrKWGgS6jwjw/JqnxB6UvxNKEzqo=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <8b81a534-9c30-4123-bd7d-bf3a9d89dfcb@yandex.ru>
Date: Wed, 29 Jan 2025 09:59:25 +0300
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
From: stsp <stsp2@yandex.ru>
In-Reply-To: <67996154e30ce_d9324294c4@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

29.01.2025 01:59, Willem de Bruijn пишет:
> stsp wrote:
>> By doing that you indeed avoid
>> the problem of "completely
>> inaccessible tap". However, that
>> breaks my setup, as I really
>> intended to provide tap to the
>> owner and the unrelated group.
>> This is because, eg when setting
>> a CI job, you can add the needed
>> user to the needed group, but
>> you also need to re-login, which
>> is not always possible. :(
> Could you leave tun->owner unset?

That's exactly the problem: when
the user is not in the needed group,
then you need to unset _both_.
Unsetting only owner is not enough.
Adding the user to the group is not
enough because then you need to
re-login (bad for CI jobs).

I actually tried to address the
supplementary groups problem:
https://lore.kernel.org/lkml/20241108204102.1752206-1-stsp2@yandex.ru/T/
but nothing came out, so I have
to walk around multiple projects,
talking them into a new semantics
and representing the problems
like this one. If people instead
concentrate on solving the inability
to change the supplementary group
list, nothing like this would ever
happen. :)

>> Also completely ignoring group
>> when the user is set, is somewhat
>> questionable. At the very least,
>> perhaps then you need to explicitly
>> clear the group when the user
>> is set, to avoid the confusion.
>> Having "either user or group"
>> sounds like a sensible semantic,
>> but its a different semantic.
> True. I think that would have satisfied the intent of adding the
> group check at the time, and would have avoided this situation.
>
> But we indeed cannot retroactively restrict allowed behavior.
> As that will break users.
>
> Conversely, it might be that an existing user out there depends on
> the prior behavior that only a process that matches both user and
> group can use the device. Which might be reason for reverting the
> patch entirely.
But this is not an option too, let
me remind the previous situation:
1. If the user is in the group, then
    the group doesn't have any effect
    at all.
2. if the user is not in the group -
    no one can access the device.

"either-or" semantic is a direct fix
to that, as it represents case 1 and
fixes case 2. My semantic covers the
real-world situation of inability to
change the group list, but it needs
further tweaking and discussing.
Applying "either-or" may be feasible,
but the complete revert looks like
returning to a quite broken state.

