Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CE2F7F07
	for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598548; cv=pass; b=tuySBlp0Nk4BOSdv/bI2tzKcQx4zPOgNgmkVpiq6Zyk1yI2TOE8j00K4Idsh3ExXTYBT/L4pi++1CQk4kPPRX3c9IBEmKdFGqunI6WPpOyxHPlaIYHI6zsAJsw5P5ucj1DR+BLwnkv3pbqDtR7CPIOoOtv/0cH1ec4wPuT+iO5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598548; c=relaxed/simple;
	bh=Ag6Vtm3BcZRwjIEwQPY/y1XS2HyAP4hkR9tpMAdnhIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwXKkdZemhSUWsjXno92WXW8RMDW+gTUgOC/Zz48zudcpG1hxq7XTYWG7xdkdpneX+PHLy8A5aUEvf0LqZXlWMspZsw+VEYzJngcNl/bpMK/uxr9dC+Wi/TAommGWroLWS/TB1Mqdn9ls6rXydWZAN/5unvN+WVLjgO6pyHyeaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAE95Amj; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAE95Amj"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-448b69cfc6dso3737494fac.3
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 12:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787598546; cv=none;
        d=google.com; s=arc-20260327;
        b=UaynJPLCftaeCjbTC6ulFjgklXF+OT0QEnkGJGnWlk01zN6tQuIIWfq8is4OPSXOSr
         fPbbMHgplExazVX9v/WlduSnXzsMXN1MVY5hO2qI3iWhJpbNR9T6mIqytgXXj5FwWVtx
         JSRoNxVCBVQq7VnaruDdeeCRnLIEN+G18jbRvlHrwka0o060T7dAZoXg+b9/xRCJfcDa
         fG2pnPzfRlAGJ9CPv2tWlN2aPX8jyQevIO8OWBOdQp6sdPEfjzcOBwER91UtxtvsdvFB
         zHuwJzw/nNr4ESYtLRhV6UCiLiwnJ+rZlT0X4Vv0Eeg+kdrdHVF2cZwwfPQuhJndB2jJ
         gxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ag6Vtm3BcZRwjIEwQPY/y1XS2HyAP4hkR9tpMAdnhIY=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=Cdp5XIiV6YFZQXncok/MJkaQ5vi8jpXr3Hvj3ZbM6iM+TdLCPpHddgYopLxnnHC0sd
         EexxjOZn4LKj+R9VmmnGtTP7LCHyosaSJfYN8TMgXfFj3+UffuYD73mCI88kw8haJwUR
         W51f1G9BWDBIKSFOkhv70Y0ZVZKj4ivd+yaI1FCdR+ClaFKjhmx5ShzdsMD0QK1uFjmK
         vohCzv8dCPI6xdJcCKnHlAkgUyVJKd9xFs6ScNgQVfk6uhWPc3qxnSA27Nywn3BjBKg0
         9C98QEEtrL79msK2C/zj6nDS3899IVIs3Z2GHFJX21HP/cqpfv5nBiVhvf47KXZjIaeC
         3DpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787598546; x=1788203346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ag6Vtm3BcZRwjIEwQPY/y1XS2HyAP4hkR9tpMAdnhIY=;
        b=hAE95Amjq0ZIOvIhaBRyXAsyFnp0hhyUxcRqnYoBklU3JAgSt0wrokcvC+Uiy+l75g
         i/hk/ykxZDhiz/yutQGIJS5kgM0/7oKTu6yP7hy3fs3tLdiuy47v54cKFEQWwixQIjJy
         xaCEUfvN09k0aOEE0tcwRrmLQK4L5ZDdApvi3GnfEyL3hxN+yypi/AV1tGZYMZcwpjH4
         rF1IoW8e7JRrAjM/pOfa4gkH3IXaOEzRJOpr9UlSAJw/wjZLWq6zOswQt8wypiqiba3a
         CSptxC/i0phO4RQ4IcIaUJH4GZzmwmbeMDHPMekV0xTsmNWaBgzx/zESmeYdPzt972DE
         QZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787598546; x=1788203346;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ag6Vtm3BcZRwjIEwQPY/y1XS2HyAP4hkR9tpMAdnhIY=;
        b=BxdM/jyPQ272+6Jvua42FEXScIXxP9sLzbzHdmxphY1cMKXPf/OkWMDs/EHn44evsz
         WAfc4vol3w8zLvJQFBDJyijJhtojZ377XP2WH4cL9xQM6unXuGcdebdEO2AR/ieRtZtr
         zg6NSY5Tb0sNk2as/d9Qa+MbVFGFZOCko/zUvg4HgxNJ8QAb/x6+wZPsuJN6DOd7d54y
         3i7Gv1jEGNqb2u1n/cinGFoHCULKg4a9oAY/JPPM6Vw7l5ns5VPj3xYGAn3dNz/s1Zhy
         dwxs80tRFgSZX/DPoGFb7zPAwv1xDKHB4E8vmzGEAmptqIrQZHoCL6KYpCfRRk4hBtDU
         RWEQ==
X-Gm-Message-State: AFuF++mAerfuQRyDBT8rkUZ6DSj/EECLaKnVl9izGuOIH0VL7D6g8vIl
	+s5THxv4mPpPhLs06P1Q5xmHDe48+IsDBjgXdDw5zd+z3WK7BC+rMiIVruxotYvXhhYoAcUUfoj
	TWOFhpBAd70gg2gsN16LrWI1ZTh9Y2TzJ4Q==
X-Gm-Gg: AR+sD13ocIrOxl77n4H1N2NqQBnqg8Zi5cSIuN9rxjkKGIxzhaFcqfY7K38K+1+DKA0
	EOv2Ttd2usxmYa3gBjQhxqisN46cSCwgEe+ChsD86CtsQtHeIxaMwMrwJ+DyXAm+nzjaYmA1n47
	jBsJQwMCnPyMiTsXtKVBLio7tJw4eJpGtxEPFi86yJmFjCj+snINElWA7Y/yj+NtPZ4PhlDpX/C
	1xvfGtlLBdyO3cCtKIRTw9xVb9L5+YXYA/JI5rFC2Y88ZWFcDI6CLXWYNwG40epSeFttZbl6gq9
	emvp5Fdy7Bo3cH9ChBhTQKjhE9U+05Q5CgWnIVa1uUVU2g==
X-Received: by 2002:a05:6820:628:b0:6ae:410f:c745 with SMTP id
 006d021491bc7-6b1904c8f58mr749951eaf.30.1787598546118; Mon, 24 Aug 2026
 12:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824182133.75452-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260824182133.75452-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 24 Aug 2026 15:08:53 -0400
X-Gm-Features: AcwNN1X7R1rCUULt1aYF8GdQRGutz22tqapn5IMcvNT6R9LspVdi_bXa3QUchko
Message-ID: <CAEjxPJ7Lu56ZgdnoyrZPGivk6pNx7CwQtSSuySAaSMKswSP19Q@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy-fuzzer: do not abort on invalid policies or
 other errors during conversion
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 2:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The purpose of the fuzzer is to detect crashes on the fuzzer inputs,
> not to detect invalid policies or other conversion errors.
> checkpolicy itself does not call policydb_validate() before writing
> the binary policy, so an error at that point is not a checkpolicy
> failure.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This was motivated by https://issues.oss-fuzz.com/issues/550672317
> which is aborting on policydb_validate() error. I am not entirely
> clear on exactly how that is happening but I don't think it is
> what we want from the fuzzer.

NAK'ing my own patch - we likely need to figure out why
policydb_validate() is failing here and maybe checkpolicy,
checkmodule, and secilc should all be calling it?
