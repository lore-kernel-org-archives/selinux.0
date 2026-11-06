Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793996392;
	b=B2IRkNjFOXM2b5bmgwDapDEEdjiVEBR2OkAPLXLVi9EwZjSTpOqxTMZmucYgHDdc1F1k
	 e6yD4jsXGOuvx53cg4qXvGDdFj/6oOl7ZYuQHDcxEH5BN3Y2BNzAzgSV+Bnan1pX0rWKv
	 whwTXPWhoWMRa5TI00rbQ+8sexbJ2eakKI/FBy1W8R3Wkn4k5tl97X78Du9jaVPkIR57N
	 3xLNFS4qkGnOMo/AV/kKgYeTO5EIc+KxHWjYtRXBkSsr2MertAmSM1/YZIgF/TeA4drV5
	 vGmwKIjLv8WI9tyqTgtVRjzVnNSPgfSXR3H2boGKJU3l/uX6aTJ70qQqBHRn1Wq03Yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=SeowNBcwfOtQF1pMEijjadbBBtc9YVqorDSQWzlcYG0=;
	b=ykfw8zJ0Ok637RuaGMMSZWidC2GiwB7k+0D3A+Dq2C5+zudxzI7jQSfb4jn2rjKg531+
	 Ntkrb/7ZeVRiGaNkgYS3lZCNI4FfL7M6SEms3QLWxd7dywe904zbbcNdVe6XDPgr0AI2Q
	 xmYJjHT3ptrUnjjZpKn00ChJ0ml0AYjSSl8Im0iel1RBOjrTKYbco4ODEftEYSyZpyAFb
	 j2nIz4gM2LU4g9nLFGG60owIep8RILWdUz2sHhWjcKeMqfAdmIGOUjH6GwR9QNi/S2OSB
	 W8elh4RGSw7VMQt4DhfrH3UE0y4XAW6wumFzOxqs7igqkts2gvx1wkazHYUSBTRVgxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LB35wMP1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF617606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 20:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF617606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LB35wMP1
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b349d21fd1so5994967b3.2
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 12:19:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793996391; cv=none;
        d=google.com; s=arc-20260327;
        b=nRS8Lv9Df70uD0nGE95RlUKGd/AhU3sq1884H+hpmUAreAVtBcjR3ID32Mk5PQzADF
         WspwwlqER/9bc2JEx25dse1jUTaYZUGAhxsi+5lN49ejn5yKTB0ybijC2UGyGQLd6KGe
         gWFK8SYLc6F10XL17D94VhJkfJQ7kCYlSEngcsAiAVgalTZfoZ+o1hFMbr6dQ8AhWklp
         t5jPquPju0Kj3FEIX1LPkGAZbJX2jAV8TMbenB+a0p+FoQ7fCGUbG61wHb5O/NfVWEEA
         tZLGckW4MKKG8a36qh63eG73rDOrUzHXlgLToJHfKW44s9pE3DOeLnRDO+nd1QclRRaD
         ZvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SeowNBcwfOtQF1pMEijjadbBBtc9YVqorDSQWzlcYG0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=jAYeXEJDsAK0dTz7Hl9QyQZGxHMdgfWxXesYgBrhICEXVVSf+f4lzOamimsdQc4NXZ
         GF6qHffrCKJOlvTcSz+MHQ1BoOvxr08T+cHDQupW7+5Ww93t0gBF/dkKHpUszHBlqdaj
         QxOI4ZPO2neVy+D8a5n575oXMcoWC5sYC7wceAWr4pqNRaih1Dj5K/fVVXqeTADNHZAo
         OzbEItYh6icoser5aBzamgwW9zr9Q8wnEINbDxXrya36X2hP1uhQwkDYdj64lIsNV7ga
         CRDa5QAmNq6h1ZH92VTwaRn6cvLqnA9KDRS7XA7fbZGV5lGbTd1FcwOXQ4lgeOfuhGuR
         lh3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793996391; x=1794601191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SeowNBcwfOtQF1pMEijjadbBBtc9YVqorDSQWzlcYG0=;
        b=LB35wMP1wRS1WD1lz0amBG96MRC/iuDCVbifYErgPI191OfzFq6X+PQFsU2Yr76+/i
         Nfl4O8E9xnijzNL70FmTroy4OAI3yi32OtmhrvVtW7M4/x+MvVpNGBbYy5Z2dR2lr8Rl
         3UmLwCqejk+2VORYg0+/fh3kFfhLs0FgdgeJoeA1dsxSmCIMbZBzYOxLXUTdqfG/bFwY
         SFjB/lsZVV2EPo1G/lANKjHbgTiAtsk+TzxlJI0GfgqBIBBLkPdZe0RAyY4RX2xsdv/M
         aV1n2BOK3tkeUdf4W+49NhAI/1gspsjWROg27ldghfyN+sUYPJWWWuq1NyFj9yM5w4/N
         1Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996391; x=1794601191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SeowNBcwfOtQF1pMEijjadbBBtc9YVqorDSQWzlcYG0=;
        b=vzfOGB0kqxhddsKzo8SOwzvgK2QKh33lCrN/jhftw0UsASXzDws2PrP5G5+xxN5gVI
         5MgMlGvE/dXrI7ltRSLPQSPq6a8Nupou0OG60LZWdlXxmziGJy313vNPQAxDW+5nDjhj
         hY9gl+kFgcr8jYBI7UjTJ5u9Y7CFEWMiyhdkVlbE8qFCgUtHNycVN++h3SSp2a9EjSZi
         yJ8i3JxcsW1ecNZ+EqdE6mCCsTSr/sPQZiK66m5pGkTR5z3xS8xk7rHmVwkOMkKnx6gS
         nOBXO01Rwi3KO4t6S3bp2eg5Ff7m+/P5MaOc0jgaHzkpKsork2W4uVSjBA47euiDxr8H
         R0sg==
X-Gm-Message-State: APuU4Z8KEW2613lh4wG7bkF2cgMXgfXUZOX2m/neFRyAt5kbBWGqZqmw
	lr3HaISdegEEn6NhTSkRW5EgxeUirrjC2+Fsjht+3kADAls3G4aSLF13MG/0dovRixoFpzkrj5w
	fn2exRL3NQ5FFWn0ub/4GlVnxr5ac0zGyH8opPB0=
X-Gm-Gg: AYBFou17ZjUC4rkrb9TRMm3JBluC6aGlQ+/r6uiuAIrjWWfeW6GH0B3iCEeMUkk3hha
	NUGds3LUkdJ4sO8l5/kNXKvEErpYmooOoCLAvrQCH6ocgb2Xsk1kkzbYFrSyyI7m+ri/T9JDSKw
	Q8VQstZPUx9amvdF9pDbWkzntJxvUqGsKHFUk7gcy3NNaPRk84n60XuLKU689tZhf0Sy0m2HDCB
	o/SfztAYGoVV8s4Ln74j22qPNNzVgZU5Js+12wNXYur7ob9TYHsw9gq+e+MxcihFmyT09KHKbmu
	6QwZG/WteScgV/PfJwpmSnU5f6Dm+vGZEGkqbspMoOVFIXDETYqPVCzj4L/xwbFhVmpUYHWvnti
	yzmkW65ndZIuaRFx73LWX/cuUX/uy1C5Z5Fo9FZME6xPz2ZX67UoWIisConoG/mOnwcLhLFX3Jk
	xdmss7gnbzC32j4ZLoS6zyF8Z+5phQNp3G/nR3T9il4z7pKHt1Y0LtJtmuGA==
X-Received: by 2002:a05:690c:660a:b0:8b0:ea29:c543 with SMTP id
 00721157ae682-8b3417afdecmr15459737b3.10.1793996390617; Fri, 06 Nov 2026
 12:19:50 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106135150.377761-1-cgoettsche@seltendoof.de> <20261106135150.377761-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261106135150.377761-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 15:19:36 -0500
X-Gm-Features: AclHuK-7tF8kaEhIG1MTeACbvCrMLfEDdG5MXjNqc-C8ERzmsj6igV-a6gVNOF4
Message-ID: <CAEjxPJ4W72BqFzd=8dN+3DoRTM3kGLD0w=zjzOd36HrkU13dog@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: link the Python bindings with -fPIC
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 8:57=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Pass -fPIC explicitly through CFLAGS when building the Python wheel.
> Setuptools supplies -fPIC for compilation, but does not automatically
> include it in the extension link commands. LTO can generate code at
> link time, so these commands need -fPIC as well.
>
> Match the existing libselinux.so and Ruby binding link rules.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
