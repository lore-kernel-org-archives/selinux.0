Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C421C198
	for <selinux@vger.kernel.org>; Fri,  7 Mar 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374626; cv=none; b=lqxtHFdiDe+I0Ym2n6pI5oRarcosL0OA3brmAJ+NsrsgkL/wg5DV9aKEIJVGLKcgwUZOyxwbd/QdlPmwNHMhVEA4ALv5lhIwW76pw6kNzZ8RDSw7Y/CqoZWYSC80PtMRSuOI9ngCs3sSpNDfK8J3leZFHW9muQ2n4I9gdLoPFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374626; c=relaxed/simple;
	bh=oFXwijcltbateQ/K0OMdE3Ty0lJtlp9JhjuQt22A824=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avJ9Z6vp4Jg33hId8i4j5W/ZHMgEeU1l5SUo+MOHN00rYKWwnU0HxoHRPFguRwJfzwAnhORyAfegkqOMIZNyhbXWt7BLwKQqws+XTGYnDA1uXFHdO/Acs54mmrXmg5YDmHnMIXk/zZ9EwPCE5Klnz+6nIPwBLmAJQkcYk6HCJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFzhlUp+; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFzhlUp+"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86d30787263so1010765241.1
        for <selinux@vger.kernel.org>; Fri, 07 Mar 2025 11:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741374624; x=1741979424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G320vO3tNGq5LjjYUJYVn9vH/OecsbxF7bGuK6RaMF8=;
        b=dFzhlUp+Ii3+nkoQQ3LSnQukW5JL7vQjSlups/hP22WrUnoOXpNIGQig5oUtewExp7
         Ud9l2HT3d+MRxRFoeTWyqCK7cFT0Nj6y4b5mt6gD33DhA3o2fYqZMCnG0Ujr9L6bZvaC
         b1CIjaKkDElJW8GFPonNzg7zFRIrs0l7tGa6s/jaSCRIRLA14VsCdu8dDnuZgZwIHjry
         kPYz9Jb7QNRjjJUg7ny2JzouC1EiscXUtUcbp1EZVD1HvL3vmc7BI6/A8BUdXM2fNzH8
         nxRPuhCWHlSRZUOPd0CK3V+y5PBFZRkIaQrdjdC9euf3iCV2rJc2qPFs7t80LyITAOL8
         y3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741374624; x=1741979424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G320vO3tNGq5LjjYUJYVn9vH/OecsbxF7bGuK6RaMF8=;
        b=Ebnbmng5az+ztOevWwzggBHk7nIod55Zen48S1EHClBVVaaUooOmEsyRSDZxhn0uZI
         +sTDaheLZkKGpSaJWiUZX3QRGCftgoaSjYQGpABuc97IXNR5MoOLwMAfq0KmbvsiOXy1
         kOHi9ssD6XG2Jr717mRWtdG9Rm7JYYUPfQXkpgkvwVr7XOifVXOW5NdQtm6HTgrlRz9S
         SxkQrz3b1P9gxA7ESQqt1Z8ZSFohPHeEKkZUeNgQJBwFRscaLn5I4LJXERV7yumEeZ83
         J8iDIfrVJ+jnOyu77nsNGeaZcJ2k3GTI6E2SBowEI7lwkMqP5U5mEZwvku87Q+eYFySN
         H9bA==
X-Gm-Message-State: AOJu0Yxo5Sm5O2MlMRHRTyJvjcXXv53fpjDvEUxY9hmkqKAdmVm46Xaw
	M+xu/Y7Dp0cJ3KCMXDSuaV9v0OO2E2d/vumiXqOCGlZZAnTvo1wsCxBcSsqZyBd7C6jL2h9zl0B
	47uFI5aVp0EQLBHOvPWT7PAqoCIs=
X-Gm-Gg: ASbGncsuCidB+YRDITBa8c9FUaqZsBQ3I/Y1Id0tOFly0N1gv7JGg7HBkIBhM4ahds5
	r9PsY8bjORLaLu+XTDMFhOzcP4v40StjYPrwqBfco7410jpMPe+7D4+dMA/EWE8viTYfgnqHWoL
	L83PyUBI6/VBeFFEQ64yzTYQo=
X-Google-Smtp-Source: AGHT+IFcCtf3OZ5JV1HRJFskFd2gKVkD8MsdMIZmMwZjx8X1iHFzHhCbMIzFSJ3JJGdmt81moiIED/UyaGlSc9DZjdo=
X-Received: by 2002:a05:6102:1606:b0:4bb:d7f0:6e65 with SMTP id
 ada2fe7eead31-4c30a537431mr3707840137.2.1741374624040; Fri, 07 Mar 2025
 11:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213022205.972878-1-tweek@google.com>
In-Reply-To: <20250213022205.972878-1-tweek@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 7 Mar 2025 14:10:13 -0500
X-Gm-Features: AQ5f1JqlO3-Yo0Tgt-DD_0F09a1if9X8M5P-8Va6IJpzVcGgtTjvdrPyRMCXoUY
Message-ID: <CAP+JOzQkPPZtzNHSY2L8Quw8btoYLEJ83t1=WT37vBDyhG0J3w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: warn on identical duplicate properties
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 9:22=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> Instead of raising an error in case of matching duplicates, only report
> the issue as a warning. This matches the downstream (AOSP) behaviour for
> Android.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_backends_android.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/lab=
el_backends_android.c
> index cbe932ae..cf4f5cbf 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -58,10 +58,10 @@ static int nodups_specs(struct saved_data *data, cons=
t char *path)
>                 for (jj =3D ii + 1; jj < data->nspec; jj++) {
>                         if (!strcmp(spec_arr[jj].property_key,
>                                             curr_spec->property_key)) {
> -                               rc =3D -1;
> -                               errno =3D EINVAL;
>                                 if (strcmp(spec_arr[jj].lr.ctx_raw,
>                                                     curr_spec->lr.ctx_raw=
)) {
> +                                       rc =3D -1;
> +                                       errno =3D EINVAL;
>                                         selinux_log
>                                                 (SELINUX_ERROR,
>                                                  "%s: Multiple different =
specifications for %s  (%s and %s).\n",
> @@ -70,7 +70,7 @@ static int nodups_specs(struct saved_data *data, const =
char *path)
>                                                  curr_spec->lr.ctx_raw);
>                                 } else {
>                                         selinux_log
> -                                               (SELINUX_ERROR,
> +                                               (SELINUX_WARNING,
>                                                  "%s: Multiple same speci=
fications for %s.\n",
>                                                  path, curr_spec->propert=
y_key);
>                                 }
> --
> 2.48.1.502.g6dc24dfdaf-goog
>
>
