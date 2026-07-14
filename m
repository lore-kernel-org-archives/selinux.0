Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB044CF5E
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032543; cv=pass; b=iEKHLCwwFDSCQvNVIbMdaWUCd7QH+5fYY8MeoLxqIGswhcw1ldUtvn6pAhDR7K4MflNUbZxL9R6gx0U4kc6z/woQadmAT+92BEgHJCF1bY/bbrkIwGwZ1+jX49uKYmkHxvtCXZVrPp8jJdR5nxZJkovvCGWbG3bumsLbmWRkhqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032543; c=relaxed/simple;
	bh=JrEw3KCvuog9AoEJaSI+TD6yvW/Gos3WVmKnXJjxm+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSUN+j1SlYbjFfholr+SRCirAbp8KlUGNjcd6grz3xKzcHq7KtIsHYlNILXa8mmMZ542JDr1DK2K8DEjadF4icdRHR1ZJu+jweUAaLF3Dq9PKbcm9TMUOYPXeK4wDvvofwXA/AXqLd54STcgPZX5gj7Phpf2iUzKWJ3N5HBAXeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoO90Dqf; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoO90Dqf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacf197759so13080415ad.2
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 05:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784032538; cv=none;
        d=google.com; s=arc-20260327;
        b=T7aOvHhttPGxAfg1UaP4khxX5Cnk5vOG41wfl+XHHQ3LE1IwgK2D2vPDfN5idcoWN0
         kGhbhPl2FomRA5bW4SGsVLsTON+KRDQ0YsFp5R0WkoL7yNEA7azEAyBKrqraJoabo92k
         u2bwKfjv4BmchBHLpjzwyLgkZ/OGlSmZqAp8ud28rnne7YhhWpKGc/7HPUUzh04lUPN0
         3y6vucLrKKtK7cXYxbXTsTXE3CX9aTxwRoeo3ctTym7f+UXi8HtIh9zvWQb0AXKKPUK0
         DrG1hD0pc7W0pALbDAwE/AZwyVfrgg97te1OpYD0YVjg3L8CkN9MII9BdZQfbODJ7neP
         e+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FtFch4Z7c0rrJAVa1P8+8rHC2/Kh/ni0Bsbw4iRezvc=;
        fh=2ScO9gmp4RRAPtFsL+/8JnhbZGQ8h6GV+VgX9iOPR1M=;
        b=fZUyzUmFUhaQaSiwhssed2UISLk47zlVXm7Ovk87fUKMd30Wa1l8YWyOStZBlrmD1t
         7BNOOs0S0pi2NGaWD3viaNOzPA4HCFWr9iY5f9UdGQwts+XUdvP4dMKveLS/VmzRTVSs
         gUnCd0M2bio+lIXDiNAo8wv/XUHwZ6Yrwi5TeVja+0F5jPkqD/xIvszq9HoRKav/nCjF
         RJ2WKlOeB21GwQgV7qZsIKxtG2xifXXF+VnbLviv93G/HGDblpQAt2ac3wLbt06xSIna
         HVT3RGv1Xe9A47itmmW1l1CO/HZrav7ucCj0buDUVzPAWNTKBuKVsBr11DksYsjayjP+
         D21Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784032538; x=1784637338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FtFch4Z7c0rrJAVa1P8+8rHC2/Kh/ni0Bsbw4iRezvc=;
        b=KoO90DqfQO2TP1QR/nP0Q48GN0waX1UgF28RmxLk5yUh4H3uH3SUpk81kc2VFDWpQt
         ezldNFhRy+nGIM9ECTBk5BVUmKp3c9Q1HNTfPPOTPLjpo33er+N1+dYWf3Nq1oIAvA3E
         eDFwonteFJKGQH9rDLq04rt/s4SxEEw44Bb+NOCsENiCQIBE0pdHgQjfstsRt/InxHpP
         0mU+dHWfIK7GDycPdQxFGb7FXZxFmwBu1ZfkJp5C4NjFn7V8ZVd4SHQ8SzUjQXN13qnl
         0ecXhFosauJjzYHZC/F9/bBlk8bH6tiZ1TohDRmdIUtTNN0ryPhyTX17UzVN8Dgu/MFi
         tpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032538; x=1784637338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FtFch4Z7c0rrJAVa1P8+8rHC2/Kh/ni0Bsbw4iRezvc=;
        b=MY7/t+O0Gnh+HHmTuSlxjx8MKtgoMAR9FvDQ1aexV5k2gGfMLF1ve0fn7aXUPzSzIX
         Vfo0o0IA7gywwnXFP0QYEJIm2fAZLk4V31X0tu8Z/uSLmASKspdSmYtyIiIhvfQUowk9
         wlYrIMksR+DAb9ZBEpF5cLpPvAUkIHgXL1HAm0Xs2e6X8IMzaljqUAKXjtxUVN3v7nym
         So5YrWO4Sug0TsrdssUVE5p/HTujzoVdAFEMJg32mpB2WeS98hv/Z4LGG9u1lgi3uG4a
         xvXONoxGo3k4i66IYiY85HNDh0epEAdm2R8iUB3XY4bQgZFCZbyw1GhAk/p4meKBibOB
         uKxg==
X-Gm-Message-State: AOJu0YwmV+29wbkY0H59765shKdroQuIfvxA5Rm8aa4y/lDFnQqcFY1F
	Pgf2KkZyMhLN92gTaligR5CRGhOd34gEEp1RHM/HLAaiMcadPg4O4imNNLzGO6r+ZE64OZtWQUq
	4kezm1FOckOkL0nsejdhQPYimCOLA+ns=
X-Gm-Gg: AfdE7cmyKGyRZ+uva9r7J7LB9w/w1KYLL+gz0puFQxUxFwbCrdW1wsQ7RJPbifROVGz
	B04XdZZ7jTg+gLqH0EtGuaJVj7fkCunQlKk9e/WG+Lay5J+n6/X35NH5yvgU2FtdXZN43Cqiz2Y
	MK1lM47zbViXyFkbdpMZbjL6sOOae1yOgkAf76CUPjIv4N5CymxKCtXth1vxh08Wqh7Gin8VPcV
	eTP2+HvvDpFBLcKnU5d6lLQT8IpGGcexCv+zj6NFJPBm8JReMJB5V0bv2sTLw/OP3TZX/bh
X-Received: by 2002:a17:903:1b4f:b0:2ce:fa3a:45f7 with SMTP id
 d9443c01a7336-2cefa3a470dmr8613755ad.16.1784032538195; Tue, 14 Jul 2026
 05:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714035003.1461542-1-tweek@google.com>
In-Reply-To: <20260714035003.1461542-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 14 Jul 2026 08:35:26 -0400
X-Gm-Features: AUfX_mwqXXpXElw07750QRXTCDJ_9yiJ963K58dvAMn-Om4IidBcT7Xc8RXVxeA
Message-ID: <CAEjxPJ46i4pXB6N94aDG1SyMXTxfg2x8qPyfUniRcU+v0FpB6g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: use designated initializers for label initfuncs
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 11:50=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Previously, the initfuncs array relied on implicit positional ordering
> to match backend context constants (e.g., SELABEL_CTX_FILE). If constants
> were reordered or added, array indexing could become misaligned.
>
> Use C99 designated initializers in initfuncs to explicitly bind each
> initialization function to its corresponding context constant.
>
> Additionally, define _SELABEL_CTX_NUM in include/selinux/label.h
> to count total backends, and add a compile-time static_assert ensuring
> initfuncs stays in sync with _SELABEL_CTX_NUM.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

This didn't apply cleanly for me on selinux/main and also doesn't pass
make check-format (fix with make format).

> ---
>  libselinux/include/selinux/label.h |  5 +++++
>  libselinux/src/label.c             | 16 ++++++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/seli=
nux/label.h
> index ce189a3a..0c20a4fc 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -37,6 +37,11 @@ struct selabel_handle;
>  #define SELABEL_CTX_ANDROID_PROP 4
>  /* Android service contexts */
>  #define SELABEL_CTX_ANDROID_SERVICE 5
> +/*
> + * Total number of context backends. When adding a new backend,
> + * please increase this value.
> + */
> +#define _SELABEL_CTX_NUM       6
>
>  /*
>   * Available options
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 2c510290..40fbd596 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -4,6 +4,7 @@
>   * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
>   */
>
> +#include <assert.h>
>  #include <sys/types.h>
>  #include <ctype.h>
>  #include <errno.h>
> @@ -46,14 +47,17 @@ typedef int (*selabel_initfunc)(struct selabel_handle=
 *rec,
>                                 unsigned nopts);
>
>  static const selabel_initfunc initfuncs[] =3D {
> -       &selabel_file_init,
> -       CONFIG_MEDIA_BACKEND(selabel_media_init),
> -       CONFIG_X_BACKEND(selabel_x_init),
> -       CONFIG_DB_BACKEND(selabel_db_init),
> -       CONFIG_ANDROID_BACKEND(selabel_property_init),
> -       CONFIG_ANDROID_BACKEND(selabel_service_init),
> +       [SELABEL_CTX_FILE] =3D &selabel_file_init,
> +       [SELABEL_CTX_MEDIA] =3D CONFIG_MEDIA_BACKEND(selabel_media_init),
> +       [SELABEL_CTX_X] =3D CONFIG_X_BACKEND(selabel_x_init),
> +       [SELABEL_CTX_DB] =3D CONFIG_DB_BACKEND(selabel_db_init),
> +       [SELABEL_CTX_ANDROID_PROP] =3D CONFIG_ANDROID_BACKEND(selabel_pro=
perty_init),
> +       [SELABEL_CTX_ANDROID_SERVICE] =3D CONFIG_ANDROID_BACKEND(selabel_=
service_init),
>  };
>
> +static_assert(ARRAY_SIZE(initfuncs) =3D=3D _SELABEL_CTX_NUM,
> +               "initfuncs array size does not match _SELABEL_CTX_NUM");
> +
>  static inline struct selabel_digest *selabel_is_digest_set
>                                     (const struct selinux_opt *opts,
>                                     unsigned n)
> --
> 2.55.0.795.g602f6c329a-goog
>
