Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888350;
	b=QJ4AwNAM7bnwZQWL34B1tQvfMWAX+LLOfftuWeex2MdI93SI0oLFj+Qk4iwipsbfyu2r
	 nx2d8na0KAApq5IxopcG1GoRnYZM2UhdKo9rntZKmuK90cXuF0uBoGdeoN4nrET1MYOqX
	 gpojnspD+WE7vxrnh2VocZ0y62GPZCA62Qy2X/VsMe79rN2ww24L92t5d7rfHA+I2n5Dw
	 Jh5DCCgZtkK8fOCENM89UVEaGCoPO0gOy/d+Vuz7QdbGKEuLAPcoaUXE+E+VTkYzZSbll
	 PWSL/Ppc2vZbmuvWP+SKdqI42DUaqvVqWqLzOHxrsltlzRYqBtXI5IamixNIrXwFu0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=of3PF4kBP8i1uRZq7MFNQYXEMBYHM1ExEu+AFPepTYs=;
	b=xiVxxrK3C4pauf48f/tUtJIiPSuAsWg8rdN1WRU2v+QqCTq7KEfeb9+BO67lhM6qm4Yc
	 leo7JKg2uishNGELjoKE8zbod8sGLOTAMJs4RyM80drcdwhYReWL2rOcNpngF2gYi8VeK
	 rtQzi9vPjelFPfvKzKnHjHxPl7NvKDfbm9k5jNH/ZxuMve6QuMDUuFLLfHH/jAX8H6nmt
	 Qo9CDwDPgwRpONemj5CGddH1kh3TLVik4ODEprL4eJ6GiTBwXiZHWcKN4o2Ues4U9+6y9
	 yomoODj2UnJH078Olklv9TnQJUZoaK5v241HDZ5pSnxjmk7xfGfrnkPRETqQ15w13ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c98+TIxD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E7606A326
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 14:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D2E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c98+TIxD
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c00f291e1so996049d50.1
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2026 06:19:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793888349; cv=none;
        d=google.com; s=arc-20260327;
        b=PXGG8a7DQbiJIAF2WeXnqjPDiXCwt/kbazrty2suDDoS6YrRx6GLaLGxXyiMljtjNa
         hphYwWU7eQbqMaTXDN/rSjVbtee5O9aIJaY9/Ksh4aBVurCMhqBWy3vLk0PlZYYnRpaS
         T4CxBLd4A1m5v0ihPmtLW8Y13SuiuEzI3ryysy6iOHvEOxuTYLmrBunrFw9av3R5mJaX
         00p3iRpXP1qH11zN95cZi3C01eNKhxluUphcguHwktWPJGFw92OcF4SaY4U0dzN0lRQl
         IZH9unSj7gM3LcWzYegKQw96ZgI8A6+U6GJRZj+cS/awNF8p/5346zdbNctaszYCdZlt
         AwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=of3PF4kBP8i1uRZq7MFNQYXEMBYHM1ExEu+AFPepTYs=;
        fh=NrCZa0w5KChfZ2udhlngfiY88cXwDjPeCwuObq/gURk=;
        b=i6ccrkDBPVzzwzqYNzKawk/m7QnRfEcIsOzTqEMdpppTL7vHlb+9hhHRPDSAl3T4wN
         bJHArnz7uAvcp1mg1bTmkUw9KC+3+sPw/VPvvGG7awxCjSPVb20WGRv3d/1aaNt/BIJj
         C6bPkLvyurHJSNN1rFFl2x53FSPi8RNG1C3ygA4Cu0wIHCKtLPSv0KTSDs8zQYjZwWwI
         tgAkprZEkWN1tfSJIeyQUBb6bKitqi0Hb8ezdXqAHPvO/i1rgQ5uA4Z0+/pTwR4VauWi
         lJPEnkaEw5ev2nLMgoixS4FswetynxN0P8ZJl3Vd8nLKYQ3/SNsPwQ/pHMTTHhIiYYaz
         PMmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793888349; x=1794493149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=of3PF4kBP8i1uRZq7MFNQYXEMBYHM1ExEu+AFPepTYs=;
        b=c98+TIxD9NFnHJ8XHbwnjJ7GWIeZiXRiru22lv9LJULI0VyyrH1ZZAuSTOMlFL9Cnh
         D7StBsQM7PAkHKuy7LbuhJS0FjSwJP1HJmwYH21gGy7tCxrItzQy/Lgd2EHcYiGrxIDz
         AnzlA4qEceF31Wmh/Gc1bwQesLVgmWeTu4e2jm+D3BfCGpigbfUUiG++ztVUdFsKMyyY
         wJBfdupJtslVo+ymX8TKtQMyi+CQFKtj4Gj3ceXVSfQf/mIEBkRtDexfo7KuCdBcA7Dt
         QAS7j08wBnWFfNp+iTBlXfWjn2ddKdY6s/tWk2zdiNBLkUBY/r77iDgAdUKoQSGxiAef
         ZXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793888349; x=1794493149;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=of3PF4kBP8i1uRZq7MFNQYXEMBYHM1ExEu+AFPepTYs=;
        b=K+xBaPsg9zr4sXI6BpQApgAWlbQ8kcdO3vhmb5PlbzogESRrSplWFCNMtMaa+dcQwi
         JrZ7J/6cLJ09g2aHGqcjJ7hEn/IAVdYRXa+RVc8M9j7oguiqDeTstGtC8ADsX7mGZM/W
         GQ9uqLT6c6EQT/pECpE140dGRvYEXkBHReY2YiorTWp+aqBcC0YA6oWfALpTxV/qgQhK
         eDFUG/vz8ubkyWESUbs04YvtIf+tC8iqWjR/QLeWFVTThOorBhCRjsVzdKb1iyVQG/lR
         vr8t4N+lvrlIjtdOUaZQ9e+NRXeAWDA8ExLGnd9JTpshPDGMI7CxkSmbZ3RmSxqZrx0q
         zUlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVJZIld0VI8+QyjWVKu4CVz/Piym4qma+S9exv6b1LkD54SLw+UGtTB2czH4D+ouhLMDNs64NX@vger.kernel.org
X-Gm-Message-State: APuU4Z9BMSZZEY17R8clBGMxKJE00nIukVxTAvn03F+krjrgNqsABLxz
	PJ5NnZ017+7GEGIONg/72RyICrI/VaVJB0XjvLKuNygKHCvoQRXgO9odJWNo2Ddkufohu9waz8B
	AvRW+MM5EJhGapIN9fir/bZ89dl+0ttI=
X-Gm-Gg: AYBFou2bntjikxJ8jwHOsZAI2zYiTtMbzKE0hNLUQ9xfqp9euB28IajIJxNKZLCpkko
	19M76HzbkmCr7dPEh8+O6fH8O2jwzSUwHJD/8fm7hvQn0R7PmhN6jLV1QOIFJkYKVvw/5N9BpTd
	SVfK8IQDOg+qtphSTSCEk6rLQL8YQBqwYF5EuTW+Fqlkabvdo+VqH4dYfxA0jr02XhAevCBlwIg
	IypIVSkuuOOYhp09c9ahBDFvHGCkJYL525SilchdHGcq7uPRdn+CV/2AthmHW0YN/mUkrmhBV0b
	MtXDD4briibv5CWprDHXwMoicosX5YHZFWj7F4uSu/iGNNXJw+hLAONMtxyBKW7szgfo7izcHtH
	6Jtzyde4dtdenw+a30j1q7NHnx/m9X3nSb59ab1PhYK3QYEGrNlI/dCnLBsVY7JgR+ZZMHdrq9/
	hukLIFNsEvri+fA41fibDgqrAVT3S++STex1rh58oBbpILNtE/ioN1aHetbA==
X-Received: by 2002:a05:690e:488d:20b0:679:af57:d199 with SMTP id
 956f58d0204a3-67ba4fdc9cdmr7069700d50.57.1793888349134; Thu, 05 Nov 2026
 06:19:09 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <76k2qxgeqgik3rdq6pnve7c6fqu43pjjeskxshtztal6rwllrd@ta3gvtdds4it>
 <CAEjxPJ6yTtMA4a-CvrQW0uTJ8mTEkdr6WE9mVJw67BKH5KRwyA@mail.gmail.com> <auxhNtTcQa-6TS35@suse.com>
In-Reply-To: <auxhNtTcQa-6TS35@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 5 Nov 2026 09:18:58 -0500
X-Gm-Features: AclHuK-QWmPa1d820LkdapO6qUwMtxziQ_5YhjcOj43lnJWshqd0XjoUZDy18a0
Message-ID: <CAEjxPJ7w5BMmMW-cZNG-fVpZT73BW0C9d-cBcrG3AVW-ArS=Tg@mail.gmail.com>
Subject: Re: Question about libselinux *_with_level functions
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 6:03=E2=80=AFAM Filippo Bonazzi <fbonazzi@suse.de> w=
rote:
>
> On 2026-05-27 13:46 (UTC -0400), Stephen Smalley wrote:
> >I believe this is a regression introduced by the deprecation/removal
> >of /sys/fs/selinux/user,
> >as used by security_compute_user(), which was formerly used by
> >get_ordered_context_list*().
>
> Hi,
>
> Just checking the state of this. Is this planned to be fixed at some poin=
t?

Sorry I saw Petr's response in the GitHub issue and was then unclear
that there is anything to be fixed at the moment. Patches accepted if
there is in fact a real bug for a real user of this interface.
