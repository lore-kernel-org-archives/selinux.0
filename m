Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAADB2BE7CD
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589613; cv=pass; b=ijUGkNJ9fUsjya19QXBwVm/J/7+gC3ApyYto+wqHPWlkZfGQn95zLygiJCd0LSclKEy/Z6Vz7egfYGljOqqEDYrRQeq5IGZRsBdcNKn5cVYJeDhBRAkAoOeZULMha/EJ7C6bb2xZPq5G+i5fNX0nXT4UuGpeWxzDMJ137DMIBao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589613; c=relaxed/simple;
	bh=3dGBIJ6ENHVqkpOC0pcJ+yR2+9QOtMaNsyN9vsUkmKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+tAbFgcL1k+gKj1O7RQB8yTLNj1ecXRQTBMR3JV4RX6t+CY/SpODqjTqhL8ooR8Ie4eqk7xJYFEaz+dLyMl7Vq634QGDhDei8irOXNU9DS79+Vc78ArnGqgYqk8K3H4n1PXBp9Ypx9EM5IALxN4Rs2L2n1G5U3j3Me3AaEqkS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMb1oY0x; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMb1oY0x"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so403061a12.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 09:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780589611; cv=none;
        d=google.com; s=arc-20240605;
        b=atlfcxOrOh84JsnM2odKE7IqEtI9BYLjT+Hl9W1TD9njZTsuunOIsRnc2ABe3vw1eF
         T5Tmp7mmAmzTBgwzOSna1oiP3olHh0vuhEC2O0gHxpqjcm44/LqDk1iscHOmYIT6RpgZ
         txCbIUM5GjKWp3EUb560SYtP4CPPlcUr1ijjDzIdjTPvKwS5V/GqscMfj1VfLd3fSNlF
         ZNzYK1ZHod8YJJvfaKm7qXgPLSKwVacUI+XKDX1RVxd85QuVwn2viWMHYYU18flbN2EB
         0FgG+Ip3+jzaNsqNL0EARo5KoyXL2VS5zZdsnIH3zUxQRJajWcIGcB4cOWsTtT2VTjgx
         4LXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8aiaI+bSnM55qdCf73bqqDmMAwLTLOiNhpB+MpcY34Y=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Orxp0W1kZ/Z4DQKyYrqG3gesE5yXtC9H/2fCZLMK4q6vHpbRcygr1sl0L9aV/JuCFE
         XOGYEkFAfC1hOgxxchDoAWNAHlggUseQkJat0nV5b6CTJNlN51mfuSfqJmfCib8Hqv/v
         qMBXP3pkQuplPuRX58gQLOBW1rjop5msFrilE+HY1yIB5RNmLAFJvfZbzR4B05vC6VxD
         32AfGTYrwM9GMEMNbdgvbNP0LkVz0Ki1VFMZzEFz78KV7Hny4NjB83a/qLtayk8FqCWv
         CYvC3CdL07FIvHGypj9qzgfLmUDJ0uZC3C8i3uM8B50TXCg8FFkPp8CCQ36pOIUkCJND
         JMbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780589611; x=1781194411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aiaI+bSnM55qdCf73bqqDmMAwLTLOiNhpB+MpcY34Y=;
        b=LMb1oY0x+kY7d4I6RLQa2KaHw8FQZCfWk2vZJkjlkQrxwRDm1afpMGHtFJsWeHG9oQ
         T63sxxrFh8iQSleDUphLrihlfPGPPD4FORD5wRt0Yv8kMMPrrQIH0YdT4Izx71Ziv0JQ
         XUAaXAkyB3DlrI3B3V2Lv29cdltXb9sMZpVqePclJvvSI4cIhqFKMi2cRALtsAsmE4q9
         IOPyYLuiwov8l1vN4vmzpN01klK7/B+6QqDM3T1seatKAuzfJkDnlz8HQ/FfXa6r0mzb
         dYkP4JkvvzsJhdh2TXzXKwpbIZg8ybCo+klSc/XzfF3f2ZefvxjzxfdplEA/WMvfgaaC
         98Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780589611; x=1781194411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8aiaI+bSnM55qdCf73bqqDmMAwLTLOiNhpB+MpcY34Y=;
        b=TYgjk1kBWlNTLnMb5mXEdA2AWWl+r6wmUvXPIAiGPFjdvUnLIwls4V26Huoljk5WY0
         d7dFDLhQj6YV5Ud7vn+1D84cx2Bydobp/EWxZ+7crN4RAXWgZaGyX6uz4Gbh4AdzMuLZ
         /QSGjKcZmfj0Gax0jHfhgFbyyGKMUjkbq1+TWczk12CQWpoLPBnw+0NJTaH0TEdYjt4s
         EvGfJfhb/yFZeTAPrT5dp5TLKLhXMEdCB8LFpNXWDjpHyPkpB3Lm/iFbb3sdDDMaCC8h
         llPlN8gQ2QyVCzSFzjhtgqPmxZG3CU9wVBUMKmtHlhArBzCH/bbWSL3K3WRLG5KppF1s
         WBxA==
X-Gm-Message-State: AOJu0YwTRVCDN/Q1aomuRok4QYHdYUdLP/A2EGqM5IwHjCjfxvdgBj1p
	Kynn/oH06UiPZR5G9huljsVnsIR8h1xX99Nw8U3iGr8zXP4q6nXvC/vZ/TALwXT1MFUiEiLNKvX
	pbmm/48Xsh6Eigg9gajCuZMSSln38YMGuOzhl
X-Gm-Gg: Acq92OFtS73FmZW5RbRzyERRNLRhJGCDP+gZFzdbsQQEWgJpJFfKXmMq446MxBto+FW
	0mES1StPE+QLSYd6uyKWeoVFw6G5uPY7ahRU3ERo8eYjwgJ00q5ytFOKC9Wer19YyzaIrDy3RRV
	Xr/96Ryic7WR756SIU8bCziDXOc+jgjs70Wa3GdifqTaShZmqPTxYvUoQQC5NrHmj5DpwUmO1O3
	RJV4/5UomVO1lh1PVSuEnsjRrHeYZYt/tveaM9C7ik/fRyppf7U7CJxnnlMwmHbVTq2iLo5X8wa
	mVImODE3kTAJKDqUKw==
X-Received: by 2002:a05:6a21:6b18:b0:3b4:6dee:a427 with SMTP id
 adf61e73a8af0-3b4976ba37fmr10197342637.44.1780589610946; Thu, 04 Jun 2026
 09:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604155319.16844-1-jwcart2@gmail.com>
In-Reply-To: <20260604155319.16844-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Jun 2026 12:13:19 -0400
X-Gm-Features: AVHnY4JmoJ8yse3s_XRa1oHkFdOHoH9dBFIgpHjbhq0wP9f7T5gCr2V-eOweAs0
Message-ID: <CAEjxPJ5powxtLp7OijePaaAANR=b-iQre_ZhmrRsjDn_E__T-A@mail.gmail.com>
Subject: Re: [PATCH v3] Have clang-format ignore auto-generated files
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 11:53=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Add .clang-format-ignore files listing the auto-generated files to
> ignore taken from the .gitignore files.
>
> With the exception of libsemanage, place the .clang-format-ignore
> files in the same directory as the .gitignore files. For libsemanage
> which has a .gitignore in both its top level and src directories,
> just place one in the src directory.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v3: Add missing newline to end of libsemanage/src/.clang-format-ignore
> v2: Use multiple files instead of just one in the top level directory.
>
>  checkpolicy/.clang-format-ignore     | 3 +++
>  libselinux/src/.clang-format-ignore  | 3 +++
>  libsemanage/src/.clang-format-ignore | 6 ++++++
>  libsepol/cil/.clang-format-ignore    | 1 +
>  4 files changed, 13 insertions(+)
>  create mode 100644 checkpolicy/.clang-format-ignore
>  create mode 100644 libselinux/src/.clang-format-ignore
>  create mode 100644 libsemanage/src/.clang-format-ignore
>  create mode 100644 libsepol/cil/.clang-format-ignore
>
> diff --git a/checkpolicy/.clang-format-ignore b/checkpolicy/.clang-format=
-ignore
> new file mode 100644
> index 00000000..f6b7b435
> --- /dev/null
> +++ b/checkpolicy/.clang-format-ignore
> @@ -0,0 +1,3 @@
> +lex.yy.c
> +y.tab.c
> +y.tab.h
> diff --git a/libselinux/src/.clang-format-ignore b/libselinux/src/.clang-=
format-ignore
> new file mode 100644
> index 00000000..001f20b0
> --- /dev/null
> +++ b/libselinux/src/.clang-format-ignore
> @@ -0,0 +1,3 @@
> +selinux.py
> +selinuxswig_python_wrap.c
> +selinuxswig_ruby_wrap.c
> diff --git a/libsemanage/src/.clang-format-ignore b/libsemanage/src/.clan=
g-format-ignore
> new file mode 100644
> index 00000000..2d2d8e8b
> --- /dev/null
> +++ b/libsemanage/src/.clang-format-ignore
> @@ -0,0 +1,6 @@
> +conf-parse.c
> +conf-parse.h
> +conf-scan.c
> +semanageswig_wrap.c
> +semanage.py
> +semanageswig_ruby_wrap.c
> diff --git a/libsepol/cil/.clang-format-ignore b/libsepol/cil/.clang-form=
at-ignore
> new file mode 100644
> index 00000000..3eb2902f
> --- /dev/null
> +++ b/libsepol/cil/.clang-format-ignore
> @@ -0,0 +1 @@
> +src/cil_lexer.c
> --
> 2.54.0
>
