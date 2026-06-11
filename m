Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD04D90B0
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203826; cv=pass; b=SxkIp34v5csDL0UWSdTOejfImqSNsF+4zpXnhslUvLEeEh205jTwmNuH8fnllsSf91ereMbvu6P1uIu/ARZVNVLKs2SipAfURxjQOU/Mmo+/PezLu/VTwqJXmEISNgMFDc2NQFNzjShy+8M0yaZzfGlbu/30g4X9TB0rUxzgA6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203826; c=relaxed/simple;
	bh=l3lT4MA9jnw4aX56h/usQ0Iw42J/6PXz3k54xJ+K6E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWE2FbbNaBTyUa+sNDPxQ5TMOxSeCZdfTTp6ZRj/nTbl6It8+AEq/QKiNKc+cjDLSBghGisqR461EF36Ws4JV6KsI1gM1MMrTOtgFvLYMYybv78xYgCHGTc0wIg0zuRFu/02kpKWONAzjZYgJ5sDEIYdXe/6l5Ms4kFop/afaQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZOtU/I+Q; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZOtU/I+Q"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7f69b71f7b2so2236587b3.1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 11:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781203823; cv=none;
        d=google.com; s=arc-20240605;
        b=eWoFHnrD323TNRayXa9aOm4UiklG6tFgyxNntpRsHyoBp1sHlDToOlyJJRsbjIiiOY
         +8beK3uoqkezvy6SXBCzZzGN4AjPo/ZqzLEDxGs2QtEtsXQfy/bvnNc6ap6svCNLUmIw
         wuELYgPhmNxlfCLdCvRR9ERkBxm+TP+SZRW2qoGDxRfxk5jehDYmcof9XakR674UG9Kx
         aUhvaOiZtcAO7Ce+vE0gmay31wt+4sUETEUjri9o8uzElmXgyw9kwhCnq0g3jAtwa8qW
         HFcxrVRsPDQ6Whd9P0JDJDa23ZnWPkyEcYdGN/WIdrpIArnOBCbU3BFl1Pj1DQExttyC
         PKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O9LtxL4leyCA4dLDZfUvp9rNt7S3QTMEh1WeM5eQrKQ=;
        fh=2ch63Y9QYcPv00D5e23iMFJ04l5oDjXzxaG1HAO8Czg=;
        b=EwXhl45sp+NwRfiHu0GQZvWC+QLXsSpq4YPmHYzT7UMTopevbqYIgbS1vtCcxFhNb1
         iqiUJFDnC9cweqlSzJljAh/fYjII4HjeUwg/CltoI252SQAlOjoOwraKoUjqglChnrbR
         AmRLJUtUd4hklrxtlWNpObphwYlq8jSvd1WJaIXrAKruOCh3MC7yMJ7btvBnyMOdDi6a
         Omd933hfUnPNviqXPBLQx3Z425PUtlZgc4nIyrPdTWvp8PwxyKbM/Aid3mQWulftbsRO
         eQrWtYTNzgRlKOqvDX1xp/pjKxj65huCEcdIXx5l92ys5UVnrkn0Qfl2Jyikx+iJbwZN
         O44w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1781203823; x=1781808623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9LtxL4leyCA4dLDZfUvp9rNt7S3QTMEh1WeM5eQrKQ=;
        b=ZOtU/I+Q+ZOzxGlhnjqCtZP/uEBJronENjg/72wJ5OyEipPwh4yYXl8eSTB04BvoGj
         L8qGnYTwZQ1t1wchvOEJP8nO8wIP8zwYaCxr1J8FeDS8w7Hgt7zLorhw4BYloHFgYZHZ
         rPVFkhOde2oFg2yruMu8TR4/jwkpwMrswUR02gOSJfrlEHJJGdCogZZxBN6yGFgN3Xzp
         F77BDKh4qugz1yl1lyC0Baj9XizWDDHs3uQdo4q9Gi7eGr/93+Oh7iJRqa5dXByZFuJz
         LJWm1ijGQuNRV/9IIZZiYVwmtQCsTgZeXZVK+s5WGvVTan30fwC5MNlnqS+e0yguV8d6
         db5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781203823; x=1781808623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9LtxL4leyCA4dLDZfUvp9rNt7S3QTMEh1WeM5eQrKQ=;
        b=Bw3zFFiLx1ZSLwh5pTvCG4DRQoVPiuJHD4c/Xl4ikRoW05rzjRBa94eC/iLbr5Zckj
         uNHuA1zHQJlyxltdcFbvho16g/uUEo1BbfrWFMQCsffmpFkF9+55SHsvoxK2X09g7B9Y
         mqYJA5H04Xhy5n8dxGjl2HMIY0B5j+9SWVkcLwYzBrPo5q/GlL3tbi24WS1kzDopiwJW
         mf9DsIh+ccD1+jLYSqNN7U/zj0LLTalah/2TS5ZR9/34kg/fbKw4mQpmbG3WaJEKab4R
         gBoalwu4VQT5gJnTDAaTBWyKBC0u1oIlXS9QM9nXorPptJRO/I8MgO3QWUxwGTOMi5JH
         ya9A==
X-Gm-Message-State: AOJu0YwaNwyGrreuYYw//Bef/vL23kWw3l3hNOr7AAg1q6QeMfOhAIK7
	kTkkwXLwMYa/m7pqSZjrCLWPt1FGzQwVvGUgAhd9bp9GV+mY144e2HstkZwBe/LLenaztuc/zb3
	r1Wq088yKnJgLIgRXoEcuJ+ugyUiICDQ=
X-Gm-Gg: Acq92OGj1ep8A8UAEqkytBB1YV18YRg5peg7u8uJQ4GtweoQYSzV8C3XU8rLcoqFi3N
	MhZX9joh71aBpsUyuudu+gd/0T+5wfYzWzJ94N2KFpNj5Y5JSgxlbj5nPagRHEFLYqsI1kDzUbX
	4B/ETy+wm6/QZ0nnSOtzc+r8VZI+/OtxBluNJvtqbdHopeE8rHbG7hqekm2VJtLowILXnQqDwZf
	/NiUfPCSQIyhuJr+vinzUwSD9e5Q5n5v/vxpI+d9ktjuiT1VfUsfVWar7/UM/bgaQtZe22CIzSn
	qTG3oygjpcvti7L+ZgjV0mCiJzIWnYABFs60JCtQLg==
X-Received: by 2002:a05:690c:4b11:b0:7dc:2161:825e with SMTP id
 00721157ae682-7f655cd3d28mr46159447b3.19.1781203822803; Thu, 11 Jun 2026
 11:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611130351.15988-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260611130351.15988-1-stephen.smalley.work@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 11 Jun 2026 20:50:10 +0200
X-Gm-Features: AVVi8CdTaO5bdBNBt8yQa3ARAaXM1QC-XiUDb4N2xhIvxlt0xS4E1mIv0Yq51dg
Message-ID: <CAJ2a_DfUb2dWUMO-1Kr9_8j5swjeOHwwp0n7brfQR3-5vg=HmQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add --undefined-version to LD_SONAME_FLAGS
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com, Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jun 2026 at 15:10, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> commit 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
> introduced a matchpathcon_filespec_add64 symbol for certain 32-bit
> configurations but added it to libselinux.map. This was benign under
> GNU ld but breaks lld due to differing defaults for
> --no-undefined-version. Add --undefined-version to LD_SONAME_FLAGS to
> avoid breakage when building with lld.
>
> Fix: #512
> Fix: #513
> Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
> Reported-by: Pepper Gray <hello@peppergray.xyz>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Personally I liked the fallback wrapper definition of
matchpathcon_filespec_add64() more...

> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 9982faad..35f36b87 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -91,7 +91,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
>
>  override CFLAGS += $(LFS_CFLAGS)
>
> -LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro
> +LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro,--undefined-version
>
>  ifeq ($(OS), Darwin)
>  override CFLAGS += -I/opt/local/include
> --
> 2.54.0
>
>
