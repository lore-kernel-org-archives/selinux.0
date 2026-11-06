Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793995329;
	b=V9k0ku+Rlc4SFAK6XDxwynZGYsUaFFTfrjTc9cDkCeMh+nE+RrOkGfMSsA5/H5N8ANmi
	 qOvBm9A9iUMJLJprlWLh6TIAg01DSizpHMwltqBB4iniG++YXqtABJqNVHg/A785wc21U
	 +GJ1nvO2y1x1lq1uSxbQplocUd35LuScVHRDekkLO+YK91XUeuO2fFgLPCq2esl/j1tdD
	 9PFK5tlTLkiQ9KUuWFA5uPvIkO2uqVPGUWiluozzle3vnArBAfzolcD144moLdL3jYikB
	 zGVUF7qbfvpns+Yqb9Q90YcF32l7ueZk5ePeb6EPcIsnvWufyizNgvwoiUEb9DOophw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xOts80yKNaz7yxXoPVsfBhMhsfZ8TFyaWj+sJaGzwe0=;
	b=m0FQ9ldY1sQK785sMiPaHeAsdKJ997XL8gWSjJcG2Bjg7WSinMseBEbW7PuGMp3aXRaN
	 wzWTtUNx3qh+4deB+nL1pJNPo5QjNOLI+go9FcAviTK1EXVtIzg4jnbHCjypdJLRalZBa
	 BKUFZbezUMHJS1K398Yx40H21exvwLpzlyGk6l2yr1Yz21/6LP1BPcmtE7FR6nDhYLlaO
	 lCxF7/cOPK7EoGjs2Y7bbkpb6ke7GAw7sVuksN8RGGcFLQZ55OoNZ/w7h7M1PK/MD91M1
	 gzQg9yLDy4vBcmIGEEnlvvSNWucicm8VjZP6wgNphR2Vv4KXPVM70lRtQBvdzsA71uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9wvSZl8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C94606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 20:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C94606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9wvSZl8
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-677af43eed4so1108053d50.0
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 12:02:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793995328; cv=none;
        d=google.com; s=arc-20260327;
        b=rDt2tGnmtABnOfikidrFZQKhH9kfFam3U4Zq4ycWCgXqseks37RfVrvyub+0gTfegQ
         PcBDzFxjQxkELM5saf/R2TJVK29ZgwbIBnVv4tpKqfc/CZJ+5sD8mIdNU6Iz3A7gcoIk
         cy+ADRHG2U+6+TrAePwXXHlG67f4qpESO5KEzDzwPa8GWObcE2gLoFY7TTGuMnvzYOD+
         J8rE6mIS0UNW3soAUn9nZcoywnG8/3aYWrqlwFaG9QSTCifnQDqtPFM6t/iau4ojcc8+
         7P0zIPhrHAJE2/WaninXrt979mQQlSv4ZxuSE/MvxqdZv2ue3ENfYaxtw2Iuzh2Qt8iO
         EN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xOts80yKNaz7yxXoPVsfBhMhsfZ8TFyaWj+sJaGzwe0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=kcu5Tgh60XpvAkqUwsCaMyhlNdXapiXnG2zUX2Z7+BlP/4p+3t0KLEEw28C+vC+j2D
         1s/QZt14QWE0OfRBCdoysZJmw9I2/4lTBN1cDJEgCt906wtJfX5URO1+R35ceGHguWsF
         IqCgNNP25gW2BK5wrzvE1t9JBDyJLx0oLzjyr5MAY2+6rLthdyYY+A4tIQJV2/LGAXxP
         4KWrz3p7UQz3ko0kKgOK3aXDeaHfcdg0buC+EDq54mhqtMVmDuz4+BEFUkMxTDQ9GxJd
         B1Wma89f/aJTopZ4NNu8YWgn+G0C0EG1ZzkYGkL9lslTzQ45aSz/vNasOZ9zBbVe7EY5
         Bdeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995328; x=1794600128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xOts80yKNaz7yxXoPVsfBhMhsfZ8TFyaWj+sJaGzwe0=;
        b=S9wvSZl8ZQmeyYi+33/9vNHXRKoAnY5BM6HV8RXt2JkCD3Rqu+lw/jHesEaIii0R06
         /IeN20imY0N+AhYA4nEIGHC5nrkx36lV4VyB2yhByolOC4O01lh4/JtCG/Zr0PjcBcQR
         E283zSzd+pJTFlawRh7cFXvUhoTH2UH/Fz1cp7eMJvwF+yJVIQMJNQe6Ehx8Pt37tWt1
         qu92WfMn6v9Z3PBKvKd7gvWyMH80KaCJVV2irzsHSUg2TDS0MUOqWXLUZIdGjm+gTwAs
         7FdolXlpPUDaQkggtI+vLiAc1Vlt96H3y1fwE8YL+wyZEE4Ac2626+liV7X6MXfiLXbR
         nR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995328; x=1794600128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xOts80yKNaz7yxXoPVsfBhMhsfZ8TFyaWj+sJaGzwe0=;
        b=LyopRKQqitsCHV2JWn6ALYJwKtFiq7mjeaGJ0yE3P6QjIuNoDOICRobl6qF7/rIpXp
         658+XlY4eJ7LcBxisPS8/TU8Ce3TPr7Qy/Yz4M8ShKi26q7oKA1svJTsPLQLdyWVRjC1
         rHyT3lufcbc/m1GBObgr1bfCxmNrg3F9lB7lyh2hlFBd4Lmyk6x/kwELgRHdo5zMZrNs
         15ZS1dDPX+2XaQn77IWz1UCDNwRBZjNZ/YKW3tXs2NKLLx5AIpyMnRDtPOvpUwis3xFk
         W5VdLxLKIqYoOVZxAgUv2+hck+TZhIbsvR42K8I3cgTEL3BZXwPUBGPUUnoEkx/YVplu
         XHoA==
X-Gm-Message-State: APuU4Z/g8skFGzsitI8Iok5fftsMF4DDEVunEM4wIXEtgMqffv6XJfyb
	fUH/fbu8wArdkCKwl3GjrPoOUSclIjZISw97NGgcVydAX5GKWn5eF05hVNp3LzPyvN5Ad6ictz5
	NUTlttVc2/zhTyTsvdWWcAW8AmWPtGaY=
X-Gm-Gg: AYBFou3fJ6WtAS+DL5oXhzmIqGzgPorojD/cw9jw4ETO/Y+F24+BD/Ctidq1O8nk2tn
	uPoR4sDf2hpVg81cROIi70vXbbbNhfqFrnb9Kk5K9vnndW+7+bYrAKps2AxnEzOzcqOFAZmgJZP
	U/QTeI9ER2RfTfVykHjO+OIvi1OI9n004b6GW1uSK6O27cU2ICM+A6/xZ17MxAENSE3VKDU0RBp
	AS1nFCx5xxzorlUMTnKE7wR20AFAoUjjiHQ3iexdMQ+4cQnyXhZ7l1X+2xbc4PpausITG0a8Uk1
	d+u6xOeBQog4r5XfCxffge1B9PpHQIB6Stq9cr0UtIsvnzpVGwwl01ZMsvln9tupktlltNrIer0
	aremhXMpHyw2xduKpeaWkzAp7+8x6o+dm/UBVufmE1oyhLHEJXnoybCa37C7bOLvvflWk5eIMVd
	e44YLv3buJYXtV8nmB+Fo3OKEmXTJ6z4G4rf3gzvr7Cg6064uMiBMB3rWW/JUzwcinlTF1A4i4X
	Gz2Ppg=
X-Received: by 2002:a05:690e:1550:10b0:67b:fc94:86d6 with SMTP id
 956f58d0204a3-67c143d0d49mr1850575d50.39.1793995328429; Fri, 06 Nov 2026
 12:02:08 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-11-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-11-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 15:01:57 -0500
X-Gm-Features: AclHuK8Qm1534LptPyB57BEDe7rHtKVYU9tUZX8KQ-PsBOvKzrJHHCcY5OdIgtU
Message-ID: <CAEjxPJ5GqA7bUj3kiJ6XEUASvja3AgRMnXWovKfWgyx4ZVgO=g@mail.gmail.com>
Subject: Re: [PATCH 12/16] libsepol/cil: reject ibpkeycon subnet prefixes with
 low-order bits
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The binary policy stores only the high 64 bits of an ibpkeycon subnet
> prefix. checkpolicy rejects a prefix with any of the low 64 bits set,
> but secilc copies the first 64 bits and silently drops the rest, so
>
>     (ibpkeycon fe80::1 (1 5) (USER ROLE TYPE ((SENS) (SENS))))
>
> compiles to a policy labeling subnet prefix fe80::, and two statements
> differing only in their low bits produce two identical entries.
>
> Reject such prefixes as checkpolicy does, and change the prefix in
> secilc's test policy that relied on the truncation to one without
> low-order bits.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
