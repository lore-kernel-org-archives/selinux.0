Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9AA3B19D8
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363667; cv=pass; b=g/vdTeCdAT8siHMNsbGS9yKvYPWrn+k4NwXBrq9j8/1glGPxNPLu3BZS8oEAVXszHjnkKlrjYi67XkWudqw4elHDg0icqjArTGWbH0NLZu3wfQMq/wZEmziewWugif7y0ovIGyB0iSv2Argd9wTNTuGSWuBG8PSazx8ClPk0oNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363667; c=relaxed/simple;
	bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NR8jD/7Zx0nq4+cTe42d2UIcNdsPRc3E59y1C54tFEj3JbvhFoVV7BeiqWtaPP4oqKEWQUrQHxaVus0ATPByQfednbQF3F8R4m3osUObpp5NGmaHj/HQhOypGJrj2zOSyUVoh9kWIUaA10rbTEzBxeB5EMqrPShXhupURMC4D+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okjMKEFa; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okjMKEFa"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85e68bdbcc1so9952677b3.2
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363664; cv=none;
        d=google.com; s=arc-20260327;
        b=RsfuructyhXim8izKBHg9mobPQvFuyooxIY+E6HlWl2djV90aqU+yplyZMtWdBeVqo
         bbPRMTZoEgEBlhlKVoCUSk9oLOpLH8qef2NBMkb+fY+SYrHRytYNXkSKVAnmlcwIDxiJ
         QE7CIXDy2XJCuOfNzV6J+fHelANWtWw9zKhOBTqpDfdlseoNIoNYKe6l98FlwDFGm5ST
         ilNOyq2qbwK8341wgrHotPb6sfYK829K1hPqS/YmmTZVyJbQR1W64rRH5zqVtWp5cRD3
         Zyq+bPnrskyD7iE5d18QlMihBp8N3Pxm7A9i7faFkL/gxSC66wGK8gMQZhwaoimvdP9F
         s4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=YKoYg8OOH0KtF76FPVkWO5PCbDGy9iYxL9H99hdcav1Le9DJFAV2iyyPuTqyz7hWxS
         5cz5E7wisImvdNNeUDadKVdO6Y+rvxGRK/qD7ERXfgOs3/HpPbE2xyuv/cP89VgUv61M
         vYn9Bw81qwLp+whQp1djGrAhIKC+TfoPaGk7jQxqIpe7wu5Ezos3cWjzSe6pIGKrgoYe
         Z42udjVJWcdeuUoAbLOyQ2SqUnQru1AkqkoC9ro9AH80IH3ykFjXh2cIQgP0EMr/7t1O
         zsd4nhOngUtFvuru0Q2iXnJQn7yf5TNBVAPQJVgvWjGWEuCRD94JlazKcK+hpE9NxvZq
         R6Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363664; x=1790968464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
        b=okjMKEFaZqyKC0tiLhITd4fAG28GvJGpAjEICuYB1bQRHmCUnv8Q1KR1ihRU5PdxaT
         tonu9/FQ2qCSdrL6Bvop4l3G4yoeIV3CdUW4p+weTp8DGrG+uk04OLLzxazMS7RTB8s9
         G82Pp9RpQIg7edzYvYSV2g+0vlgc4Yx/hsvO3X9KYEaFyDqFv4z5ocR7GK8+4hk3UZ3B
         4m/FgiktR6oXzCghoh375hG0vn+FI6nft/woM+38zFHdsRG6xWT3hBhUyYqzSsx7OlMC
         CAY+ijLcghOzJqjGusyOoZWbYLADQjYUiscjMH7GtdDp0cMY3Dtoa16kx/9Wvok4LYgO
         HTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363664; x=1790968464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36R1YABcoKYvLc4/YglE8i4BQmVyZrJxbsP2IoFHN0Q=;
        b=lDtjJqIhUzXWTQL6sH3Y7jB9qEMEsVsgCQ+msJWsw1mgUBHfyTTjmfwzVbkbpTXrht
         tRi7HbejSWH2YC+UrVL6iQVyTvmVctrc6xfV8SCH9OHKs9cVo1O8N5wBxV89baQilRkk
         l6nZ5Ov+Gv8WZpae4zDbR8nm9a5EYuRxaf5jm+APgJGKkdj1hrt0uUxs0baWHfHVWSeA
         WZl5v9D/k7AvjhUAr89r6L1YBpCgSEmmyEoNYC9iOQXK2ESvYWvwE6gM199+t43QOzUL
         OpbQGH46uWN1vwBDuepYBiQYlVKD4g+L5js+mG8Q2Lpp8WztyNd3JtVNTQn6webc9YPm
         7uxA==
X-Gm-Message-State: AFuF++l5pTkFbiqbOKL68RNl6/4VeC1160pA1gD9dSSpU7rFoyfEDJuq
	eQbK5sW/tzOwmKctMm/NtItk+SCQQblVNmvTaouB9jWwpaFRe3L/FxFzyDVpVZs2oNOSMgNQBHX
	xp+TALiK+FSDdjwP5kNMDOcp7mQEs87E=
X-Gm-Gg: AYBFou2GTkNINTx42BsohWUMK4ynQt0ddVV8Ig9gH9s4QUVr2svCWtfvqpf3fPBCOSG
	ZEYnp9ThlBbUFLu2pU56WJ9Tui7LgudL8GdxlwkcRdt2kOAaRuy0eNH3dn7dhvxAXsFTPSc7iNp
	IXiXC1Ap/btn9zcVHcbODlm6UQSIVV2Kly8tyGYILH04Z5VDNeZrKLhpT9e4qk58Iapzzv5uvdp
	iThLXZOVgCqSo80ZE4wQeXZIj9cioYaNbMDZ8tIrxmTR6iY28jJGq7D9yXhDCx+vrPOmVq6Tk9H
	s5dn5lWziY7CpVO/QIWAKC+TRGbvQiqTR+3YPCnemooPwu4iQACRp+VPMblTDULkFg==
X-Received: by 2002:a05:690c:dc8:b0:871:bc3:9844 with SMTP id
 00721157ae682-8a6461b9be1mr39779167b3.7.1790363664079; Fri, 25 Sep 2026
 12:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-14-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-14-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:14:12 -0400
X-Gm-Features: AclHuK937IzaFqnnd2QwNm62aK4JuwCDqbADJkbIXSebpjCMApVlR_y0lHM_4hU
Message-ID: <CAEjxPJ6w9Zqm17BCif+g1NJ=PT70ocUABSCJqtXcDUjWi7LEKw@mail.gmail.com>
Subject: Re: [PATCH 15/21] tests/extended_socket_class: work with
 CONFIG_CRYPTO_USER_API disabled
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
