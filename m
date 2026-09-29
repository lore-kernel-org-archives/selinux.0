Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA253D0903
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695904; cv=pass; b=P1s0P9jZDEmTRqX8ghfI7McfgyPExY99xuktv1Wqiy9v66cgZFfe+UpKsbvqr9fLSFNp3OeCTU2kZhNXFx/fTaPyjZyRnKXIUGujFEFPmc3BZpXalIC4ET24Lieodhz633pxcZo7pQ4y1VstizzYzE2Kxu1Qs52UjSRBREOw9OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695904; c=relaxed/simple;
	bh=SmkEwlxKquvhfL78d+PjpAs8/l/XCJhNVFNZQsZB0SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A90BGtAEOSwGnXhHYRpUHf5n1Dz45H6G4xa1p5URkVL5g9gqnwsPLw3u3MRtysZ5ZP68ypbCRswyv37fa2Pbu6YKWmHSdVVzPpCQpbCvPxNzKmnWZhuPVInjlXvHoLGZbI2L0RtB3ol8TtqQ5w+r897VH8rN86HhE9E+S30J04Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er4D8NYk; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er4D8NYk"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85e68bdbcc1so34764577b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790695902; cv=none;
        d=google.com; s=arc-20260327;
        b=EPj1Wj/RubRfI7QbA21B3dmhrhtpBRpjIHHOxSjZGtL8I8uZ1VDy6HDLp5ts4xn9q+
         zd1s5XI5byvJx3Cygo7yUlWwszIozOBo95FomGTdXlPdkqH3On6rb4cCe8Q16SIPFqEI
         hSxCbZwj/cTwp2E0rdo0IHF0iBsFSyHiuGXaCChTKmoMZRg3B62VQFZsfWHpIyXTE9ak
         iRTyRcRbV0PHGAEcQTlXMr2ns2puQ8jQ0BKnr6qMW9EQGn9cfj6clKU27lVJDPLpXRg3
         /9mGdm4aFjRONzSFhNsFYilM2invA7K9K2adKCzrslohToMP8csakCabZCdWvgV3776+
         bcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SmkEwlxKquvhfL78d+PjpAs8/l/XCJhNVFNZQsZB0SI=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=azDjYmqxyS7l9CgWmMgf6hPaxoJMu3xc1kX0GQMCEKtejJQU3v/fGpjS1R/DPTieGn
         3t/EoWSJRNUnb3QRvs+OtslyEFRtt2+UWj0FhlCJBu5B7904DBSNuyBNzveRX5jYsNxp
         /21rZX7PN6EpbXE3tuiJqgTakjn+bgT1WE32i/hTMk7kcB4tqByCs6xBk7gs3dSpiWGx
         Kokk3tV70GFaCyOsUwfCWaueoEDqnGCuJl9wL4cQsSTz2joYEacSyWry0sC9+1jsISm0
         62d0VczaKv5joiKEnA7MVzLkIj/E9K/+cwLGL7JrbTla6xDdsOeL01Yx3XStZ/3UreIq
         zVNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695902; x=1791300702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SmkEwlxKquvhfL78d+PjpAs8/l/XCJhNVFNZQsZB0SI=;
        b=Er4D8NYkmRBIKdu8fqp46qDsB3AcToC8OHR5DFhBDizcaTPznumjageZl0CIL9UXHs
         Uu/ydFQlkQRmVVeae/vrb64fS2epEnL+R99ZWeXv35uIB73r7KcM23fKhamCcrX/h+NV
         rvNzQIdbeRaQxD/8IHoGMjjKDBXZpT1VPY8+DxzQ7/N75bbzHnK8Qu9qXZjgJVsw/Sot
         FSTVjiXYXXvYrorI0XHEs0LXYYXicL9+OvywmfwqJDLuVBsumPWeHmMBg22nQl4VzYmi
         cIp7D5LV21N0Sfirb2MX2fMKb+/yVoqexVTspaiPD38WrizOJHbB0k+ncYB+40cIramo
         APKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695902; x=1791300702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmkEwlxKquvhfL78d+PjpAs8/l/XCJhNVFNZQsZB0SI=;
        b=dPdijwYku87UHl/6cz2e8fJMTFw20bZ82UEcXvsBxZmyuYFRC6iyX7YJEly9tr+T+T
         pjmoQKKiEzKNAgWpdEF7G9yr8+rmLkqBBcBKW94uuwJ86Pv6J2qtJfEYodpWPnmrFJIH
         9yVB4qEjpOOMagiPGDbWl42tVWSmJcJcXFawxTS/DCqL7eZ6SCrTc97j0Uc53/mTxSIu
         zN64YC/eLPtD0OOJSgQkplO5zSDQ4Fvm+thxPB08hI0JXwtxegt9AgBtdDP0J/L79YFh
         CTo00/V0OjVJQJ0GfmcKu+VWLSVJJJq3lXxoQt0Oiw2JCQXlt6bNDLFvRb/vPDBGnaUO
         nyBA==
X-Gm-Message-State: AFq9FYKomYSY/ArQBu3YM2tadqOkN7ASgS/4Y/phKMISapsAfZDKMrTv
	cpxrr1zeUp5rhVbZp27R/eKY7Y2i5FTPkRgztxAnBbhM9Mw5wTYdllriMuA5qtDOTRIUS/46eQe
	uDpBIFNl9+jMJWIPNELHhQEM/leFu0Yk=
X-Gm-Gg: AYBFou2M0zfizWeUcWlbMyC5SuHMYH+oiljf+ODKkEfTcPHoTFf3LI60VZgxFBm9Zx7
	DqvLyhqalgZitdcH4kb6tV61a/FKpBIYiIaidq1y1J0IO/gNLxoQMaYpXDhx5m7FlJesky2cuBa
	Ehs58VFKHDPzs9toMpvHeQI8IM6/xrRTZMTwWSijcRHrn9H8I+iN3wfBgqgIFYqcBO8j/OCI//U
	gv8rYDzONfw6qcltW9Q3TLCBbpCWnUF/2gCbKmm8zWJrywj0HlgF1qFTBl8nHMbmT5rb3C/6v20
	aXty9x+yy8i1s8xDZz899QgUmi4VObdc8i0Ii+G7iGUvlBvylFBJA3w=
X-Received: by 2002:a05:690c:c4fa:b0:8a8:7688:2d99 with SMTP id
 00721157ae682-8a876885069mr74308237b3.26.1790695902349; Tue, 29 Sep 2026
 08:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:31:31 -0400
X-Gm-Features: AclHuK9u71aN5f63iV15kaHG0bS4-rrNVte0Xsdwvv9m5l59NS0Bn5P2yktp0jc
Message-ID: <CAEjxPJ7HDwfLQUgVQirBOKqF9rOEhpyLvNNzFrS5LFNsXFWmXw@mail.gmail.com>
Subject: Re: [RFC PATCH 06/32] selinux: use memcpy_{from,to}_le32() in avtab
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Replace the open-coded endianness conversion loops for extended
> permissions with the generic helpers.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
