Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBEB647;
	Tue,  6 Aug 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961877; cv=none; b=ctf2aka/AxXPkJwIjChKWGR5g94vRje2moZS8jAmCSf8QcvxE02I0B5gVV3yCTfMzhUHN12C7D0ZEeHwrniiIdem+4iM0GHYiNIbCSVUKzQkx9F4ZudTRdidhxQfW/zOzf/c9midbTdVjjY3G+g08y6AUFF+VJitrDimoWC6ao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961877; c=relaxed/simple;
	bh=74zFBF+WcYmI5p0OpKozLDdsCkPH0H56toG+wpVDYMc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bX9ohN3TawGyFYShMGeERzSsiz1g/z4jBwOcZUfbT+1GyIDiliWqLQryYhBr8ba95Lmra0zpFlbE1FtI3W6ehsVoaZWzRuIgbKFcRHU5rb7FmjAQBbK9Pb2rE8HIw9B185BJRLDbg/1rP3lIO/Edg/iEjx1LkB3vFTGhwDwo42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tzCp9xxi; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tzCp9xxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722961853; x=1723566653; i=markus.elfring@web.de;
	bh=wGVCl7larn/FYTTbhpWDzXkcrYcCI9w8FYS3jwQ1ppA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tzCp9xxi4v7Xynrevqw9XX2tQPTqunW98fU8/enY8r5dufxbnmng6wEkXqGSrr+V
	 9ZW+oY+Mu0GbYIKN0/eEiLfB1rn5KDBitFrf1JhOs53TxsBBDEOztQDZhWy/uriU/
	 AezvfYR8AvLTrVBTQknsusx7uHK1Mp2CUZFGoAMpDxNVuh8keqhd1WhXQPQPOaVnD
	 /ypgQcquRmcC4sMHqh1MeQG24oP5qZA1G1cumPBQLpFBnpEww/6JKCuZHyhbehwVT
	 N7ZKn9p4JO0KM+IMf319qS0UNQ9q+6VpHcpYjeK2UQtet67Fvh2I8zrIzfNL6THwg
	 aDiSDJw5TqRYSAdzWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjMM-1sVtQX0WVg-009TNH; Tue, 06
 Aug 2024 18:30:53 +0200
Message-ID: <600318b9-928c-4466-a8d1-334fab8c512f@web.de>
Date: Tue, 6 Aug 2024 18:30:47 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhen Lei <thunder.leizhen@huawei.com>, selinux@vger.kernel.org,
 Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Vander Stoep
 <jeffv@google.com>, Nick Kralevich <nnk@google.com>
References: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com>
Subject: Re: [PATCH] selinux: Fix potential counting error in
 avc_add_xperms_decision()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RH31q5FPZD3ap4mjplBT5NRff7YZv7C27dwstV/5sm8IyF2Mee8
 Dv0ztTSZXuW4QX1Ixv4AGLJOXz+EPbF556bD1vfiQ61Dsp49KpHLQFiK3zXErzhWMSK46Yq
 rwCcWGCvM9ty+6euk6ByKt9dmHyWIVxUIYVv4+xhyAn9cQ3zWYE+0NH2LH1cIBxjGCDX0WC
 NfgDNXSnO2YYWghHuDWwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oLzqYPBPh3k=;BTEdAEngs7Wwg1bZghE/WEmfTvd
 qsWDrKgAX38prrqW5WWVu4o2j/AubbiqhKx+8O3j7WvNtPKoSpQD7wUs4NWil03E2UsGmGqVQ
 0Y2eJFS48GNivaT6PUkoSoJn4aMSWPIGKQAmRx1WTBpJHWO+5plZ8zLAHXObRfYXdQHGlOIfZ
 fWM3fyOdGLAyabd/Y3n8LyzcW06/+pYldzeTF088/Hxboz3Sg3dWI6WawBUciHHI+YFF1YwAb
 XeBvdPScUQ6twMlQiCTlWKcobILPPyrhdeliVquxfnvec8UKTrJZv5Y3F5AZM6X/JN8nzLN02
 FV4F0qZx8yD//Lq6d3gZAKXeV6aqkTxu4JYvDfexwXlkTjEZomt03sGnCzg55swCA+ef5AIje
 CHb1cBnyKac1Xz2mNiAo/H46OeYjq18TrqDeOBjBYcjAWLUy5V3ro8ZT7DGNwIt6dv2Z2Ec59
 P1UOG+oZ1WBAbd+CggxN5uVP9rYmTt369I5sPj5jjNiIFxxdYUqCkMBrKAa30zAw3omZlkVBe
 ZsjgKlLWMaK01R6Yhzd9oTzuZjGwLY1m/wYMbiWRJXi8jI3m8BmXORKHTDJLcgpifOaO+xTPN
 kgOqvOWR3Jagzb8k0IWzEx1VUkp+hr2JFb1NlG6HIvWLoHKSKwqyftaZS99uGOAPrvzya2KPj
 NfX6HgVEPiUqF2Z+CoSIf+MwavPNsMXDLyHjoiSn3N6KDpegxCkTVMJCCXKVbhTKj299D2RBb
 RgUCYhE4kzKFJ/CcLvyHfiJ4stWCMxB9BY/TPAPr1GZ49Cv05MmrnNQrEbGY6ZO+69WcniRIm
 erpzoilf/9C/ZqKQQeqLKT5A==

> The count increases only when a node is successfully added to
> the linked list.

1. Please improve such a change description with an imperative wording.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.11-rc2#n94

2. How do you think about to omit the word =E2=80=9Cpotential=E2=80=9D fro=
m the summary phrase?


Regards,
Markus
