Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C336215F
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028301; cv=pass; b=i0JnDbV38fsVete/Vi8yi4bkUi1dGYLw0mEAVSEU4/wDhmVkZGGq9sr8ysV1tDAWoC5ZxMCVhzUgZkVudii4vRRhTw2Bb82QYcbxhZ5iTLocXv53fCa5K/jNInn645VYFp7dewjsvw+k3eeUJkuIsym3lMTqjjcvIw31NPpCZXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028301; c=relaxed/simple;
	bh=CtqLWvxTdFuqCsgfwelm+Gy39TTTivB8Daoub2gGGy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzqq+g83KTxwGETBnvMZ1y7fWwHIr2lQpj3LaP9oLaiDLGSdGPZig3T6lRW3fZVsbJ+aROqJ8kKxrMa1H5mU01GR1d0tg1kLOZibO6LJl+0dMCgdo4boHdvVZsFZYaEJEC0lNyHILkVhO7ZiMmUqPkPRFTWdqFhcX2FMM3lXe08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPckhq3x; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPckhq3x"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0aa420401so45698575ad.3
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 11:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781028300; cv=none;
        d=google.com; s=arc-20240605;
        b=Uml5kNoxsm47M1lLCBEWpADP7FgOqD2+RGGTPYG5QK68NwVjnINA05Fi/PIf7Yd6y8
         cUtcZzUW8lUHIatTdpOSTzcpi1SgeDx/oP9finhGKCKaaboa02yC6/SZ3mydGUv6vlWh
         B1wkOz34BJiuRP406edyRUNaTL64i9h/mMa5p+7mz9usL64H18VdkTqNEaldRgCYVlUB
         mgn5liudLhIjhNgOMSr2l23hgjcdgTid0Z4PV1n/rY1b1HnpXJZfQfWMRMyIpsTk6ONe
         IA421U06BfubqOwE6lGw3fjB9WaO72RwoTjlFRYG5hNS3tuxZQn4erPIT8tplyeQh9qd
         /9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7vlBygqTgPmJBtPH0e2dlbk1B3mTKqu0giWIWFnntjU=;
        fh=o5vOOpm3W30egh9vQLIIQafUL/dHOoxctWKuGbZfS+8=;
        b=LUHmI7w56dcJlTTGq9Ot25M4G0qxmKh3Kx4lucvo8y8Sf7DhnsZep4SVBRHYgdT3Kh
         YCBrJ2cvPwektu76SE68eb51jA+ikxAmgoO8HMDzyDpBAGc+u0pyi2/nXkuHQ+4FGS+f
         JNIPjhq6dIuaK9qkNFcY3t7iVLj3iLlfcT+Wwrupd15wVlQFH2BQ8ya3+UXg1JGfdnza
         n3RUdE+CEsWFpP8HvRVK1R5Iv4NXRSxvQCK2aLx2ImpkRPWiq1st4RfaCTFhLVIRY+WC
         fTSMOg02CFRbRtpIKoAYaMbuLDLZTpt2nnBgdx3BCG+8VSOa5Ri5X5mMpyCvtjFzi7HL
         ieWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781028300; x=1781633100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vlBygqTgPmJBtPH0e2dlbk1B3mTKqu0giWIWFnntjU=;
        b=aPckhq3xdg/ALYdzq0p67idy2g+vqCR7fXNlkAQaWhv+Zw1o2ym+SNH/1PFToXljfe
         csXrZTFCtABy3rjCHo7vfmM2YjPNoDHkpBDem+sUWNZ3tTFUn4Rxa6/KhgW7yMfQuMyc
         Jr1g6RdEhga0Ov+Gf6+T0sb/Q54lrC8umeVqeEs5CbCbF/P1OQa5SUCl3GMY01nbhywe
         poto1PwXBMhiGwYDfR2wU6yusnI8nU/LC44E/5Z2MZNwktA8xPjHfdokXKUsdIdxV2yl
         d3sPoMwzE2kU7zY8qHsk8rqUD65X6r+lIFJG5VELUs7FbSO/pcGOm51h+/4ss1las6A3
         BbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028300; x=1781633100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7vlBygqTgPmJBtPH0e2dlbk1B3mTKqu0giWIWFnntjU=;
        b=ext50UN3+Cfl4sUvQekP3Gf0LxPSFKgRCeU+TSCaABnScJvKBBbBrj1RL9zFmhdcNB
         KvzjWGBD7K3sHQR1nNuuWBVSEj/1CUIzP1MnhnGjI5nim7dUBwjuIZMkXsReMdgCewDs
         ZegmpUdIWY7NonLUnYinNTfU6ODbLqx+X01ViIS2I6mFuxvlxUmAbIMpoLPs7CK5HtZ5
         yytKc9oRhD0IBAQPKB2mu05DnwemId2SZIilkhKiNM0+scYAKmEstogrrGL7/vpd3fFJ
         LBCe72KWs9RTsRZDPqB77DxD6n1KViS8jUA9X9wneuCM5oPG2JGFjSIdGuO8KOqgtCUu
         mlLA==
X-Gm-Message-State: AOJu0Yx1xGC0S1aQwY2ecCj2zAlhNfRaNLm4zv+UbUyIEBGDREktFejI
	gS6gxRdHzLlcJA9+1tM9es6eMumg4KNdgBQw7u63C2zMznhW7DUUgcSeVDsc++PSqcPFChiTaiw
	EZUMs7YgUVXx1+Xo6Lzyz8MMeNVNL1Co=
X-Gm-Gg: Acq92OFhGbTL+Z2QFesO7Fhvr7t4CpWwo5LSaXqmfTR/Lj4Tp6wF1GYLDNNBDUBl7Gn
	7doLUFg8J5VkqzxivWho9zgQlrnDbvel126kzyuuHWd0M9S8+8Mzpzw84hQeZNO1/I2K3lVxinx
	NUSg63t75UgoNAyd78vU6s94nozEi6SRxEFa28TqjAEjwcFdJw93t7SF4trBOTA+2o1dYY2PYL6
	LaHvl/ju4mHRW1Pu8/l71AbDmOUZiJCmvTKYmkBEy2XiObcENsyjX5DhWRwTDzqma9F7TpYx6D8
	QY5n6XwE0pLA2cH9EQ==
X-Received: by 2002:a17:903:1b0e:b0:2bf:dd8b:7cd with SMTP id
 d9443c01a7336-2c1e7e4bbacmr238065135ad.10.1781028299664; Tue, 09 Jun 2026
 11:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609162427.47578-1-rfrohl@suse.com>
In-Reply-To: <20260609162427.47578-1-rfrohl@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 9 Jun 2026 14:04:48 -0400
X-Gm-Features: AVVi8CdZIS03_FOew-4JKKuJilviRFchpBybV3mhonRv35aaKysKjnY9KH60z4o
Message-ID: <CAEjxPJ4XJROiL2BZqtaVo4YQxpJig0i8mr+yRiWPArv6usYUMw@mail.gmail.com>
Subject: Re: [PATCH] sandbox/sandbox: fix saving file changes
To: Robert Frohl <rfrohl@suse.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 12:37=E2=80=AFPM Robert Frohl <rfrohl@suse.com> wrot=
e:
>
> Fixes the following backtrace on saving files:
>
>   $ sandbox -M -H sandbox_home/ -T sandbox_tmp/ /usr/bin/vim sandbox_home=
/cmd
>   [edit file and save]
>   Traceback (most recent call last):
>     File "/usr/bin/sandbox", line 565, in <module>
>       rc =3D sandbox.main()
>     File "/usr/bin/sandbox", line 553, in main
>       return self.__execute()
>              ~~~~~~~~~~~~~~^^
>     File "/usr/bin/sandbox", line 530, in __execute
>       savefile(dest, i, self.__options.X_ind)
>       ~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/usr/bin/sandbox", line 133, in savefile
>       ans =3D input(_("Do you want to save changes to '%s' (y/N): ") % or=
ig)
>             ^^^^^
>   UnboundLocalError: cannot access local variable 'input' where it is not=
 associated with a value
>
> Signed-off-by: Robert Frohl <rfrohl@suse.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  sandbox/sandbox | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/sandbox/sandbox b/sandbox/sandbox
> index e3fd6119..4e7d56fd 100644
> --- a/sandbox/sandbox
> +++ b/sandbox/sandbox
> @@ -126,10 +126,6 @@ def savefile(new, orig, X_ind):
>          if rc =3D=3D Gtk.ResponseType.YES:
>              copy =3D True
>      else:
> -        try:
> -            input =3D raw_input
> -        except NameError:
> -            pass
>          ans =3D input(_("Do you want to save changes to '%s' (y/N): ") %=
 orig)
>          if re.match(_("[yY]"), ans):
>              copy =3D True
> --
> 2.53.0
>
>
