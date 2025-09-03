Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A430DD3A
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907273; cv=none; b=niL/qGwkGkovFeDn52Rt9YN2jZCcWWSTRKb+vz6Q73cmqAJtLFZvq0r/xatjGBI6E5jzgdsUPfuT4FD+94YyF5dYsVrRFQURXKB72Q3xF/tGrkW8526+d3lFB+2x03Rjlv3OADils84fmYtXG0zdpREx8G4dFlfzFfxwVITLxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907273; c=relaxed/simple;
	bh=kGrpS6XLnKczCps6GIbTDsxt2e8viE/7X0JkTZPXBZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efhKDa7etFdYhRWWShSzU6FHHBg4Zbaav3DFb7Uyn5NtE8ryP/w8CJWOjycrBNx6J62LAAlts1+uOuQrZVa7GfXhiKykxHUuFVzLEdRoCdMIXbpma6GKfE9VMkbH/rkz/1EugX1XcKDFcVlTz+1L4NU+r44Vkk/5H1THzrnx1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObsnDLjc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObsnDLjc"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326793a85so5225361a91.1
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756907271; x=1757512071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7yJWMyUR2PkDzfZgpv7UwJ1aWHYY07lFvHEmhAcQEg=;
        b=ObsnDLjck9x+ucww5iWqyxik0dcUpFx3EwXShmrTxgvQUULUrvcqOU1NmjoNdlMUXf
         MIZYb1tbUkAyvDHkQPm54AAjGY81g9SDfQqjdEWUJwdz9/Vx4NuXK2wnmdB1a0pOBR/y
         gOK6lJauZztW92aoXh720HTtJz4YsLtppoWO8UV8adxToXBegrAB7lk08vZBxKYC2Fbo
         xFSWE5h2Bcna0LS+f4v4u6fAgp3e0av+B148lSVhgih5I9OzRv0tKaPx2T9ob//ayEiN
         THpmR5Y9kGlZp7NkO7cd5lyGLKEhiAHnd1CsmWMb+qUP4szVOx3rg8SuCX4H/GdWEx6M
         9CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907271; x=1757512071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7yJWMyUR2PkDzfZgpv7UwJ1aWHYY07lFvHEmhAcQEg=;
        b=W2ES77ZFwUdc5TIqLhYZrbbSENJTHnyk0NR1iEG3+zSd3PdcatKQd1DAiovdHY39cP
         qLybWzAlPbxHnGlgiDN4pifwB5RelyDaW86Mn8rsxmTjhWC9vibBN99yJqIQwDSvciZP
         YkolaZ0NKemDKS4+pvebNDPMFcn6RYu4InucLg1GOvM/grHXxRKFLJnTL+7PFjsc0A8M
         74IDxr1a311DbHJmK9bW0DPCVTOw1i0cHF5tdYsix9YtroSpt1hzU8afDl9Rt7IhIQfW
         5bVm7EDtyTPLanf80HjXxYdrTlQ2XgsVXNx8ewXlRkhSsEg1FN8hwLTxTi93alNdmwxf
         Hbpw==
X-Gm-Message-State: AOJu0Yx5h1TMVr1GrxHQ6PvLRTL2QEZnh02tvbuFy+ouZz7/bf8EZnHa
	Y+Dpg+k2WRHSbptrm4C4H6lhSIvkX1z5VcoGyYp3D1AGb5c40QfFrynoJ3txnv9eQ9+annW8ER8
	oYdlAr9gzESMaOeSInmkgaKP1pJfc1Ow=
X-Gm-Gg: ASbGncvsSqmBK2pi2Sfhnnlmzhl+3vlH+bsczqsXosmNTwR+f6YC+teYwZAe63uVK31
	WmrUdxOfv8pzRXM+8S6xZqflIOviITHHfYCoCszTBYiylqtl9FWGGJFCCQW8ceDiTUAJyfnQtFS
	ppcLpkKxnX7+39HfbJDvgqYluYkmOsIHfw2d2ZH+qGUenSJN3Cuq2uprapcqAY7v4gKix4r5vts
	bJNHoQ=
X-Google-Smtp-Source: AGHT+IEX/VmLQRr8j44UaB0hmyrltRDbcWVTxSwBJFUGdl5EHI36VL0iS3aXM0RwG7TUQqYGPj8+qDy8xBC5CyCZyBs=
X-Received: by 2002:a17:90b:1fc7:b0:328:c00:b75f with SMTP id
 98e67ed59e1d1-32815412d6dmr23212844a91.6.1756907271386; Wed, 03 Sep 2025
 06:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902183221.119333-1-lautrbach@redhat.com>
In-Reply-To: <20250902183221.119333-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 3 Sep 2025 09:47:40 -0400
X-Gm-Features: Ac12FXzHOVWTVWcYqq3jESPPlh5eNy8KpsXY-YFDolD_CPhhNfw96KZdI7_5GT8
Message-ID: <CAEjxPJ6_mz8YQWT5AwOxFCtvd+O0VsPhWvLdrEnGyaL=6bCpfA@mail.gmail.com>
Subject: Re: [PATCH] Add simple github PR template
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:32=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Users tend to open pull request without notice that patches should be
> sent to selinux@vger.kernel.org
>
> This template should give them a basic hint how to send patches for
> review directly when they open a new PR.
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  .github/pull_request_template.md | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 .github/pull_request_template.md
>
> diff --git a/.github/pull_request_template.md b/.github/pull_request_temp=
late.md
> new file mode 100644
> index 000000000000..ae790a128d15
> --- /dev/null
> +++ b/.github/pull_request_template.md
> @@ -0,0 +1,15 @@
> +Please read [CONTRIBUTING.md](https://github.com/SELinuxProject/selinux/=
blob/main/CONTRIBUTING.md)
> +
> +## Contributing Code
> +
> +Post the patch for the review to the
> +[SELinux mailing list](https://lore.kernel.org/selinux) at
> +[selinux@vger.kernel.org](mailto:selinux@vger.kernel.org).
> +
> +When preparing patches, please follow these guidelines:
> +
> +-   Patches should apply with git am
> +-   Must apply against HEAD of the main branch
> +-   Separate large patches into logical patches
> +-   Patch descriptions must end with your "Signed-off-by" line. This mea=
ns your
> +    code meets the Developer's certificate of origin, see below.
> --
> 2.51.0
>
>
