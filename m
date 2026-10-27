Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793129033;
	b=U9BLOQwOsTJP/peIisNpsBNFRBbo9I6Ffkb4NELdL9Z5MEBTHO/S5vi68384KuvvFETe
	 NyxJV7y/FoNmcgxQAsX8QqOpkgzcpcOgEoAaqNEZDc+mr9J5qeCJKSF0v/Q4SMFFZjY7P
	 xCMSxcFx7BX7meFFvYh3PxMS14yylz1fae6RuZIbNawylPUIjjXD5eUsG3jHVYxKi1cg0
	 KU/rsSt3ZJrKTAzS5I2BDA5HNMMYYBjLnMPUR4zTDyp2xwZGXI/x1jQMflDjE/mV5EpSb
	 KpSXmk+S7V0pzrpImidfm4R6qt+oAbKV+G5t9LGHLWSEjp+pTZ2F4MxELNa/f7q65sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=b1jN0zT9mwkzmKH3aSI04whLW0YaXy0ArfGlfvNdiO0=;
	b=GHSxCUgZdrLp+xNQaqUHTLsp0ABxPNLZCdu7nW5mrkORIhYG70LrypNe56Cj+rG5vaBd
	 icYGI6NEXDnQSq8VBmXh4eb7Yofoc/50jDuOmvuPKDyoI7WW26iLa0HgByFVorOpFXj1B
	 g08YWV+Ql3qK69YkrVsib5m5maCm4vzEKus+Y6GSUCdxNhHm6FYne9r7VNdlQF1O4QRQC
	 +QC14BSsJH8vs0TXHGqPNi8VQ6Gqsv69U6P1mRRQ+wfpCb1E6DniyBmrIcXMN+sH/4QDw
	 RZtlrP7njSfkSbh0a7nkS2H4slKJg7oo4x+OjRmMP8hKnIIUFdQvXrOyr0hz2cGsxqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qy/r9Lvk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909A606A31D
	for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 19:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A909A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qy/r9Lvk
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab432273c5so1787027b3.3
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 12:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793129032; cv=none;
        d=google.com; s=arc-20260327;
        b=oDSTHfts1H3A7JwDQ0sNuY2NCs8AgAKPlZfE6LcQnZsC15zetY70fGq2feys0fME6f
         7dlolPfXCxzKsIUDlgy/UkwNT3+DQzoDk+w9tEcbeioA0OfHMh5YVXMhOy+gOUk6SC5f
         0ELvzctLlr+l0SNih2b2VGWEM2O8wRJpg/uREYNmSFP62JpVcj2ErOavo5vg4wIyJb0B
         NuWfO7hP6xAgIxzN1fkimws6T/rfuNsYO2Qpic61uaDjExRk1gFTts8Ck5KS0IN6o/jL
         Kim7wbf1hxzUvC1lNxUpGWiY2sGkIDRjZeCooIk0ijnYnqT4xtVeVo95jU0RxmDkXlhY
         yOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b1jN0zT9mwkzmKH3aSI04whLW0YaXy0ArfGlfvNdiO0=;
        fh=88SD3A1r43C8ue1eh/tUY31otzODxDx4N77mxCQa0yI=;
        b=ZOkibWImDJHDrhbAkvO4ygkbMXkObwAoS6Ex/10txX/FqmKNxAZY+A466PF9k2+4oZ
         TrhKVmQoAnMmJxWDlLNiSBrk4L47oUl8X65a5kgDnY/6/SZSSeOU+PtXwvFcYVQnfSdY
         sKKrSvBCJsVJqfZ3i2lfk/CBukhifiugZq5tknhD7Phm/JoVoYXcc18YhMJj5Xe4QGUN
         8SIkQyuu4Oe+SrUKmhcf9/ueMHYZPqiigjqU9S9QPDg8H4NB90wcM/tEoroLMY0Fxv6N
         HEPgUal1es78S1FCFHE6/fctFEVWQFerLj2zwunUJ3RLX6J3DOFOE0/z522VvqCbWKxj
         2wEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793129031; x=1793733831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b1jN0zT9mwkzmKH3aSI04whLW0YaXy0ArfGlfvNdiO0=;
        b=qy/r9LvkvGxoiy+2SfmarwbUmMMS9OBIOme/odG/j98I+qne1OE2EWkjqRW89C2R6E
         8gp6Niu8RL+O7M7HVDhELWvf+R7jeULfFgrFaf+IUtp0PC22dgQOcpjNilRbVnyRiC65
         qZJBSyGopRhwWKPWpUiLCdI9s+T4tlQb4Tp7Fi7cSYdhG+EpVEd1it6FX98ofHNISnaw
         3xswJily83e3gfozI/te879LF08NwRvsmniiK9Ts7Re1Y4E/StFNfZZbVSxRCAlVEHsz
         Z/chJeT+ONfgHlwVYBgETaACDuuRnd+5MX7iFWqJn/Z5udimSs3288USWClpnOQLOEyx
         jNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129031; x=1793733831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1jN0zT9mwkzmKH3aSI04whLW0YaXy0ArfGlfvNdiO0=;
        b=bgN2++Qpb0z1VWdibMmJw7o95lMYoZXdFNqmeEcaHDE7uuJp4tNlfIrDc7957jyDsE
         UKCO+CvEHNvuTqi6w6jspZZKrEjL1jaDsoTX99jcPblQGnRMkfjgrg9JEcPzM/mj3Ns4
         U6t+EgN6EeKCnweyOCJrcDtPkc0dWmzOgIVUu2zeTnGa2AldvEjOvHu8qYeMNJNDw6mk
         /w8K3yXLtokbDqo+yrJHBIU8O7+Q0sqUBYxvIuOl2M4kNjfuw2qhBwnt9T5k0gdTKk+s
         0x4UNkdLSVvYgp9h8QXhJTT3xuvJVf0qiLYQydhCyUfhXkuy+GLtESi++a0cmFtdZzB4
         WZRg==
X-Gm-Message-State: AFq9FYLU+VZoNlro102LJcQQyvic5C08k2/KhDJt0SVqBZFWaFnQzVG7
	5kMyQyAZhKvCYR91S2joHygbsPcHdjrF+38sUw/d47IwfTjC+CIIGvGY6+LLesS6WAChpWPn/V0
	lmNKVLgX6zHgerMVrMosPNqwyZBUN7ZEXlb5/
X-Gm-Gg: AYBFou3EqkSWaZdQPpz9/xLWCx3q1egDcVQgVeSMk6bJaldfR+DaeCAZxnSZ1g+OlXO
	x4MIpUkXuI8T5322b7GZij3L/sA8X/9ABf1JTuMH51tfwqDMYUL7ai9gwFd0GByBV0JljNn8Jmn
	aO+Fwfb0SLR09M4uWzvX2rTWV9/o01bkKjb6vCjdj8ob3L3Sb0haKbPOwzTfGvw/XVp2TJWgn07
	SKkBJJm24yfqgxasFvOrbr09sEZOJQ9SoZW+ZQ7MkR6fyt1PzbTc6c2WYuBGZC3+KmeafLju+q3
	rF5yVaX0gB6col6vmwkYQ2jgawx9C9+gpZVX6py8+iJDAb542gyeAqYqNZHMOIxIZuCKcFpPhqF
	IE1a4PohKGNfzZIlaiHHd6Zmkq5gV7K3RYgTm5nUtqaC62d63efMP7tl4jEOd8sdq0+xz44LMCf
	quhIy5Tx2EFPeaavyMJxj50w==
X-Received: by 2002:a05:690e:1447:b0:676:9115:60f7 with SMTP id
 956f58d0204a3-67a7baa3ba2mr520244d50.12.1793129031563; Tue, 27 Oct 2026
 12:23:51 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027161833.90630-2-stephen.smalley.work@gmail.com> <CAEjxPJ5xdgskV4SRhEc-N2eAvjS5T6PAQUfDOEjA9AFcnRfpdA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5xdgskV4SRhEc-N2eAvjS5T6PAQUfDOEjA9AFcnRfpdA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 27 Oct 2026 15:23:40 -0400
X-Gm-Features: AclHuK9H8J0j1oyY8q5PwbFodmX6OMUmWQmTWRwZVxgdCV7vD3EAd-adxLUJIlg
Message-ID: <CAEjxPJ7LJ8mQW1Q=PHwWNVHt+LRptHGMkJ4kOiZ5c5u9=jGprQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: fixfiles: honor last exclude line
 without newline
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	Vaibhav Bhope <vbhope@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:02=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Oct 27, 2026 at 12:19=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Vaibhav Bhope <vbhope@redhat.com>
> >
> > exclude_dirs_from_relabelling() uses `while read`, which exits with
> > status 1 at EOF when the final line lacks a trailing newline, so that
> > entry is silently dropped from -e exclusions. Process the leftover
> > buffer with `|| [ -n "$i" ]` so the last path is still applied.
> >
> > Signed-off-by: Vaibhav Bhope <vbhope@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
