Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9891FF61A
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357249; cv=none; b=DcdRMNiRsf/5gqg0VpVUdkwa5ab+amiyV1Da1cZZB55AT0mJeQaLjydWaJRDNnAn+Bn5PlvHAIBWvg4PMsJtCSVMOJxUNBzAwRRAlQtyqUwQb4QbDZL8PAh/y+FXL9xPqtQ3HEniG47RCF/dE8ZPLVXrelFiznnTv3N84uZLIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357249; c=relaxed/simple;
	bh=pStCZhXcJxNa+7QnI5weZzWeah+4hUCpyjMSW2CkIL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJ79d1pNjz+oiblQFtZhK2H8STd75+cmPBgnETCc3LMCHddRcWjwOVYUgIj9ixW9ShyHlVWFH8GP0Wqk+adU2qgDF/WjzGSWpvJQIdKHqfYFY4E/hHndIvDUtuS//VI9UjMjp8OOmZ+FP1yxUtkvZNOWfqZ0MhN5HqOSh1NqPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8zUdMnR; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8zUdMnR"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4afde39e360so29589137.0
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2025 09:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736357245; x=1736962045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pStCZhXcJxNa+7QnI5weZzWeah+4hUCpyjMSW2CkIL0=;
        b=h8zUdMnRI7Tz12hbkHCU8hDstOhjfmQCbZuSTBRazfGpRNOLGYu8hJyR3OQTjEWO7p
         OIn52NFDlEbI/XkdV2Ac7XJomxInytJ6v8ayMxeLdjOR6XmFmcmzO60opielvqto95Ve
         zoiAQVIlCSgjG5wVe+aPFrRRsSEHwUtvUtfEHY8WC96kRcczGpQG0ktMy626OhVVaQYb
         pq8Po7XkXUNRk3WXtqwlzwtgP3tc0kVzZE30Al0b/EX3rh89YKRU7DfDcTOQSpPF6VDy
         NF4zetOzv9cTl4DCLEm7qcU46uxc4VOqOO+cbznecgBiILycf4wUUYGC1qXh58pbyWqT
         KjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357245; x=1736962045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pStCZhXcJxNa+7QnI5weZzWeah+4hUCpyjMSW2CkIL0=;
        b=mGDSFOG4ryxbYLrSOvUe0xdU1DV2V4h5ntLQ/ry7H4EkDR8VtGvoQrXZ2nYG/9Xr2x
         xrxC/710X9asXGyJtkw3/7d8T6MrLOK2tcUNy/JhM1qF8yTj0J+j3HyX3P51o+0PyiD0
         zBK87+irmiTDHhMMRvgj9T7QaRCX7tL1NwG8mYfUcbaabNEJus8ABUoHc6oa892vQu+F
         8Bba0Cn2//ChP4ke3iDlN6RxZCxSRUOjdIukSPaEbeywnFbCSwbADOW/PYiSMhGX6nJ1
         WaqYvGhQMj/8Tnc9lWJnOtGRA5OlBbHJySEcJXtIVivy3OPbArhAzF+NZcvkwDby1jzW
         EEWQ==
X-Gm-Message-State: AOJu0YwRwWs+qG53Uo51HaWKE84T+wiCm55ZKIqKIUp5klEHMiGJ7GCL
	FFgOR807yYsx1PpiHB/BSPqQyjX4/LCNVmvAQ1mlB2pYp9HA4YpgRQb/eSK6Ko6utqyWn/wxMO6
	jAx3KU13JON3XaXvZpg5fRuR3cBw=
X-Gm-Gg: ASbGnctT9lx+SHc9kS/ojx0pnOPveFQJvDP1bdNeybKIMv16WZD5ifqtfxDZaQU/7uE
	LHAqJMNAkkKlii1Blch03zikEDjrSKb0955wG5w==
X-Google-Smtp-Source: AGHT+IEtyZ9/0QY/vzwD4Fo/S1KHfjIn+UZlUsWLMCKO/JVvxgazlUB658EDn2kBZWdtKpOkHdQ9ITpeRYRpOqpi/vk=
X-Received: by 2002:a05:6102:3a14:b0:4b2:5c2a:cc9d with SMTP id
 ada2fe7eead31-4b3d0dc0215mr3536550137.16.1736357245490; Wed, 08 Jan 2025
 09:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87tta9xm89.fsf@redhat.com>
In-Reply-To: <87tta9xm89.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 8 Jan 2025 12:27:14 -0500
X-Gm-Features: AbW1kvblqwKWrL3qP_lMrA0o2v3sSRXLwuvG9TfjIiBktp6iNgZUxSpYZoeBBcs
Message-ID: <CAP+JOzQZY4Bji7vD_ZaEQksvUP04-9u+CvRHDWXsHCD8zdss5A@mail.gmail.com>
Subject: Re: 3.8-rc4 or 3.8 release next week
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 12:13=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Hi,
>
> there's only one change merged since 3.8-rc3 but it looks like
> there's some important changes in the queue so I'm going to postpone
> -rc4 to next week as the last RC and if there's no issue I'll push 3.8
> release two weeks after rc4.
>
> Does it work for you?
>

Sounds good to me.
Thanks,
Jim

> Also feel free to suggest all necessary information which should be
> included in release notes.
>
> Thanks,
>
> Petr
>
>
>
