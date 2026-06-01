Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FE25B082
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337488; cv=pass; b=eD9W/RpaVNGJlojGNCeSL+Bn9p/ecI850fr2DjLWA7LubJngQobmEpOVHuWoB3wOf642i8LTDmIR31jg4T/dYcb98vZWU83N+qjGr1MgHvcGHQwGvOeEPDqtl2oNAdCMFaY6+h2HOwALpsaDn82M5KTJW3rsgZ12rtZ+sY34IvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337488; c=relaxed/simple;
	bh=2xRXZPZfCYt9b4vCehyQaJ+qBIItwjXX++sUSeNqctM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAbc0dJm84h875KekPkAGNSSgpEENkEI0X7FH3c97dBBoU66pjM8PNj8k0iFZ1pcqzA/430J/POZvJAOZw3FMpg9rf3bWspQZ4GE9YAQlV570xFKSLN2hWpmMxDSBFQzCYhRiMayvTLfM9U5I9H/D4XA4G1A6cuUMrG29gMRHw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HNv8DzJY; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HNv8DzJY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f53332aso584364b3a.3
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 11:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780337484; cv=none;
        d=google.com; s=arc-20240605;
        b=URtVoZEEo1B+8ZEvy7JyCjtuVnPfu3xHsfjOmNIpcPKcH6oH401xyb4IwhEYm8Ynnv
         Kj39HOnE51sN+yj5zI4A8aeNX2a8b5ykVde3pPL5Q1iDotiTtV/uKob3I6I4bJeF1tki
         j4xZ4GFF9zJMZT2j3slPi0UewY7962SXL1EdFuiCXIJT3R9Qbdqiu0zZdOkSqoQgT2nM
         1JqFBKH7G8uxOPg7SwOMdCQM3qbdjKCnKE3f3pe4P3XkccVI7irg42gaAv91rDUd29Wq
         +owIbojdSR/3IIYagDSoMl2a9J70zOtpT/9aTCdn6vk/eI96gSXDpMthv6/FYaD7OO1O
         /+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qWEgcb0G80qYnJdVaH1hDqGiOyw/i5fV37JTsMaS2X8=;
        fh=X/P/ijKcfmIxy97eXfv0Kk7U6+CFWaJBEjMyV+DENaU=;
        b=DyH5bDuSxdZI3PfpG5LyOegpwBDl2raH3Vn20dxSqK43tQqBfl1JL0NvxWH6lUWulu
         vc39BTFOTz9DyG5uuaXByhbv7dsHeOT/J35rgwG5186w4pbHJKDdwMzIgrxdh38Swgi9
         jE97w88NZ5yNAT/MUIHb6bw2iXTrZMGurTrCdfieXAruVhEYrgVj/j5XaNpdxG36YN/1
         uaQTTQAl92I/EskGIQSOAHPqEB8lMAnUVaCcuWOXJaO9ZOaMlGgUcC2pEzgjQHlKVD0B
         blcg3BZW1yeaO88GvQ6qifz2jkrTlPDFmxHI89HDtZCQcKB3bMrZVkLzAMgbPp7gPPFh
         I6pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780337484; x=1780942284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWEgcb0G80qYnJdVaH1hDqGiOyw/i5fV37JTsMaS2X8=;
        b=HNv8DzJYHF4jzGUSmzMGihUiazigt6M988TolC9HpIjWkQHEG8Epv+P9n/ptdx8+ow
         lScO/udpolImrHymSS97ArDqxQySTy0tfaTaxm17FcdhQcZMMy176R8t0yitXaLXP7Ud
         qaPwrmJLiy900x5QHDKS+6l6Ev3y0RaW0/C6vCdxor6Rip1XfK2VljvcINYj9+2dt0pZ
         hQry39v9Moi4Ad2zQ4IeMuL/FZ6edWf+DaxIFpvUiLX9hel9h4US00qSEwbmGozcVPuV
         m6mOFFuhYB9O02+qWvUZ8ouEgHX6vtXTY/TxOHfdiH0vrHv4VHsxQx/cbk24RWexDGpW
         0lTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337484; x=1780942284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qWEgcb0G80qYnJdVaH1hDqGiOyw/i5fV37JTsMaS2X8=;
        b=KR4c3HNwnCd0XmHi3cMP2Ox1TDz7tnHXCLrBY6j2MSljWA/7MtM8wFH16adbV8dOFt
         3gon/bnO+VaSLIcaHSayhZu3M9bSjtHe9t8O96h5wBoE6/tKspB5lTNv7J8PbvAXQXQE
         kub3T4+Uq90JZ3dhMRsgk8Gqi4HYtPYmfmPYC5wbrOJ2xbQa6kNxJSdBgmvbEvzLcgjM
         IjUQcY2idnqf3mfuTyLk2Atb/lhE13Kigj3rbZCcndDTuLDZJAkBq8CIDoe5bCr7PzQ7
         pCG1gID8FaGiFlF/faK0TyXo3kakoLPe+NeJe4uYKdwv1VKwD0vSGINvNvyHrs3JUwhi
         CRkg==
X-Forwarded-Encrypted: i=1; AFNElJ+6sKEQNfqBOhRQrAPs4GuKijT+LFpDjGhH4Bz1vuQfoZ4WoQANSuvSjGOmIXop7Ivt2iJQHl/H@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAxtS5pH2Wu2CEXEnip07aj1hOpT196x16Q4mMVRXeR8Puljk
	c/fi+mH8lDmCO7FfT9HziAfKkXSs82eSS5EhDhCGk/hzvKIGlL9cFSREuon8BAq1R4NSTgxSSP+
	HwUhHHSwcWajILtbpGEUWvp+5GNX1j5c9FJmBBBye
X-Gm-Gg: Acq92OFXrjyR0V33HRYx3vQE0QSGaVfp4qxB4wtdr9ve03zqDyflEKDK3q6x6uDB0eH
	IHL86xJvgl7cWqdBKCplanGyl2i4SEAvvSvmr8AKykKOs0T+Ol/ePssfkDX8tvXio6sN3qSkA9D
	nivN/QtgialEZVNIKg0VG5K0aZ2ElEULuWVcYnDwH1XOuwoKkOCjWOWzGdsGmp1rqDnTfiHMpg5
	7+fe/H3PcnJg9SaLVmYIqYVjpzko2tCY82kwjfTkjTWVzOOIY5dZjQO+9fsbBK2l4s3XI6O/Kzn
	siCrOLXHNkvbkneufg==
X-Received: by 2002:aa7:8893:0:b0:842:48ae:1d56 with SMTP id
 d2e1a72fcca58-84248ae225bmr6151986b3a.35.1780337483998; Mon, 01 Jun 2026
 11:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531165852.1478916-1-rppt@kernel.org>
In-Reply-To: <20260531165852.1478916-1-rppt@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 14:11:11 -0400
X-Gm-Features: AVHnY4I3LVQ4YicI8N3OY2LXcu9HR44xbzGsFYQZIKNljgU3jeAc9iNkd2kZXdA
Message-ID: <CAHC9VhQ9mMhswzmy3745HbXbe_xm0aeJOmTG1PiDHtv1=zTG6A@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: hooks: use kmalloc() to allocate path buffer
To: Mike Rapoport <rppt@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	David Laight <david.laight.linux@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 12:58=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> selinux_genfs_get_sid() allocates memory for a path with __get_free_page(=
).
>
> Such usage does not require a "page" and the size of the buffer should
> actually be PATH_MAX which may be less than PAGE_SIZE on some
> architectures.
>
> Replace __get_free_page() for allocation of a path buffer with kmalloc()
> and make it explicit that the buffer size is PATH_MAX.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> v3:
> get the args in the right order
>
> v2:
> * explicitly use kmalloc() with PATH_MAX
>
>  security/selinux/hooks.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Considering the problems with the first two versions of this patch I
have to ask what sort of testing you've done on this?  I know it's a
trivial patch, but we're on v3 ...

--=20
paul-moore.com
