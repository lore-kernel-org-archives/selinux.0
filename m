Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D763B19D8
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584261; cv=pass; b=h6fhuduK9ZX6ShT81c0sgcb3I/DmcUswpO1Eg3GxMryLKiXjqcdAu/Z0LAdhMkgFrkQQDEoCg/jDvL8sAA4KcEL5ZCF22fJvV8NtgXZvfB3sZK20Pgpgwz4dgJtDuvGaR9DBEBRzOVOHWOCPyPM+lskyy4l6z4ZdZSKMSMDSAo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584261; c=relaxed/simple;
	bh=Irp7tU1cJkN0W6tJKBltt5hVNzinXRGoA4OUrvXKdD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YPg1RlkDL8QMrPw4TDEZlK4YX3OUGJpTzZljQELKqWJZoNqcZ16IYb3UGr5glcu2vgSV/FymDoRvvrO8b3zICtwz8JoP8gZD5Lw3srWGC4Z4A7zBRCperVRrpGcwWC7G3B/d2wvYPuPxm9BPJmZPIyb0dh3L5++s6IBCYP5dYSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL75rCLz; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL75rCLz"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso893154e87.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 07:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780584258; cv=none;
        d=google.com; s=arc-20240605;
        b=iEqDrtVSZMPpHf6NI2IwxOxcOKOhOMx2klbzdnhjCgnb9CYGNAmfyJC//UKhL0Hmub
         5jIKxI+LD481tRwt7FaZ/F/YLl2aPSYXdYfKDXBj8710z1sB+zn5shTuJ2Vmn3uk09no
         X9fQkL4N7elsfieqLl3hCB1sVAW8syseWFZxJslxSPbzdTACer1FxQxPzi9bGJnbzX/p
         74hdEUjDhlAB6vBjKC4UFAzSE78H4liqFT13IDN3lWO6mcJlN1aa0iDdlywi2O5r5XFm
         3D22vOC4GppWpcd0sExWfbC0DQXnyjvP6vL7QopF1rNm0tvTDBkEEDuh7V1KzA9izwbj
         HAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yvkuVWtEiEDwpkFv7as7vIzhAlB+3JF41oEzzKxrsIc=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=JcBdivyvgmHt5ubMD9BvBk6TkiwidGbYb4NQZOfmmbrhov+sl0mhH14e/9WlQDs3LP
         lXkPWVB/QfrBKfBqGyWjYv/Xvwztunfy45Z4NEj8EyMP/u2DM2tTuT6JcQ9V+e8DoLMS
         B6KZMlbXOCFexwHzUQqo/OiitemP/6vpi9CJI48QeF+DaZim4GiFNGYYMMlUDaJHsvpi
         8LzSTTmV7AeeXYH6t2oNbjg6nNZbXOdDTXH2lzf42Kz1FagxvpgX1R/PWvYfljF20RVM
         NdPA/kNWddorvZAzhBul8bNWze8rJJW5Wtsukj/KKOy/FNwQxHqED8zOPpWXrcMs/fCE
         LeFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780584258; x=1781189058; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvkuVWtEiEDwpkFv7as7vIzhAlB+3JF41oEzzKxrsIc=;
        b=JL75rCLzHdLLUe5YsJq3ICkBkZb1n0bE+buA0Ly0f5nxJmkrcP2mqp0G9b0AbMwlhb
         PTLIkCnYbRahXZW8HvDrRBcOJBjE8x8RiWqf1OgkfBp0CEw07WUi6gAo+dpzJmpuH891
         NtruSHF+Pco1lNA3S+PhTAg7bCyieNxzygCSvxJFc902RC3buDt80iMKZkZyvjW6zrbW
         SFXwektBHD9aTZVwsl8f4fFDIZGzhuqtQN2ea+Dq/nZwx3FWH+/Ej+QQGTHPfkeY3iVP
         GBws+gcxwvSSUpGnMfLqWSYMxOkTA/czVqf6rd9k+0tCoK66dfjhlwQhHTdN4xyJ9iMl
         gkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780584258; x=1781189058;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yvkuVWtEiEDwpkFv7as7vIzhAlB+3JF41oEzzKxrsIc=;
        b=X2ornDBU5dplyP7msUf21Vz13RHRQz+cE9S/C+oJHIPvsQbYn63mraBIVVrIn6poEm
         VkoxRMzeJGOFd84RRYThc13p54h67DA+Y9qEbddo7Yl6BkYFjY3bMbwwPcdOlXva8kRp
         imaLsEFqyeWq3DbuHKJqXcf1QJu9tRqO7jDfBLVvcJu7Wrc2rmNgZU2A7S8oeNAfHz/F
         FIK8CiFkuPPaDANTPNRzA1qBtEX0sIDmxI4g/So8gss7tFfsdue87h0DN+UmxYVi7Asz
         sekcznZgP19a97YyBfBZe08ldRTWKoAhQszEiAa8ozzknyoEsT9dy27Ctrf59yDlaXl5
         4M2A==
X-Gm-Message-State: AOJu0Yx5PuPhUb4WhXd6X7/zjSOr/CpFm6bUbsI058qmgXGft2CSs+Q7
	AJlTe9KXj9bZQxsDPHr8OQwgyTagocSlHRUWvnB5+5vAL6mYsFSM4bnbcgySq2tgrYH3k741Eiu
	HCQIVadaCvscrnySZa2XsBh4kiHwUQhlpGw==
X-Gm-Gg: Acq92OH1ViAeZ2pP/qp5gXJ863cGDceJnYNWHKNBGWX427qDZyZmK8k9zet0sm0fiJJ
	XD6L31y/xTe3VVUbEYDzSTxJivUu0dtRw5WHEz9WGxc1kixo2FB2efYb9O8xNsROQ1lcbN3kdiu
	2YYQ8CpgkI09VXL+5Pl0rEJMed4n/fxcocbFtPrV00lpMpWTBMu4vE//YjVGJdfDVTxF0auUlT7
	8peIXoWuxoRaBTtsXPnSa/ZoU2nxcNfS8EDO0xC8qHdRyj/FZsmpmYbS9xQrvJM+QFYSzZnaxdK
	vXV+BAZJKZYpw0k=
X-Received: by 2002:a05:6512:3b8b:b0:5aa:80b1:6ae0 with SMTP id
 2adb3069b0e04-5aa80b16b37mr1611600e87.0.1780584257885; Thu, 04 Jun 2026
 07:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604143944.11282-1-jwcart2@gmail.com>
In-Reply-To: <20260604143944.11282-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 4 Jun 2026 10:44:06 -0400
X-Gm-Features: AVHnY4KXMzmdlCp3DKx9S8leZeNkGcbnIbf6QSFw6jSMcnXNmCTFCWKsNcedywY
Message-ID: <CAP+JOzRP-pQHrOJE_B+6NNuoZ3BsWb9boTMS3OHeXL9GrS8f8Q@mail.gmail.com>
Subject: Re: [PATCH] Have clang-format ignore auto-generated files
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:39=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Added .clang-format-ignore with auto-generated files to ignore
> pulled from the .gitignore files.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  .clang-format-ignore | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 .clang-format-ignore
>
> diff --git a/.clang-format-ignore b/.clang-format-ignore
> new file mode 100644
> index 00000000..8c32d922
> --- /dev/null
> +++ b/.clang-format-ignore
> @@ -0,0 +1,13 @@
> +checkpolicy/lex.yy.c
> +checkpolicy/y.tab.c
> +checkpolicy/y.tab.h
> +libselinux/src/selinux.py
> +libselinux/src/selinuxswig_python_wrap.c
> +libselinux/src/selinuxswig_ruby_wrap.c
> +libsemanage/src/conf-parse.c
> +libsemanage/src/conf-parse.h
> +libsemanage/src/conf-scan.c
> +libsemanage/src/semanageswig_wrap.c
> +libsemanage/src/semanage.py
> +libsemanage/src/semanageswig_ruby_wrap.c
> +libsepol/cil/src/cil_lexer.c
> \ No newline at end of file
> --
> 2.54.0
>

Actually, it would be better to put these next to the .gitignore files.
v2 coming soon.
Jim
