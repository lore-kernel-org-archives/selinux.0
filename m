Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45833F4119
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787066; cv=pass; b=V/5TlLy/4boHqq1adMuDSV7i+uRs0G2nZPR5Jgwr+lS8Rrrn0w2J4bDCsQ2++BUtzES8q4EgavjNch/yHOVcZuTX7PzNYbHKc8qJZ+aHr0IQw6SCf9KNW9KGSKRevHNrgOnuIHI8pVi4OmP0rVDFS9ON2xh9zZAg2GHo8tgschg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787066; c=relaxed/simple;
	bh=XDx15kfZ29g7ZySn3pqe9YiwQ7X/mA2HiCO/wUB+tCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9Wi5vV3ujoH1GMq0AFSEKUgr1Hi1LA7PjnSDeiW715T1gvpB9InFBEMa1hB6JC6VGvdyuJ43YO6udTlm1X5IZvS9sVlc2ayoCPWu2auCXnrTr1y9h7Glb/CSkKmT2mO0kCqet/BHFJDJrTvEBGHaJU9wjRyw5C77F7TE4MW5O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoQtBvSf; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoQtBvSf"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-392445f11c5so1936081fa.1
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 12:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778787063; cv=none;
        d=google.com; s=arc-20240605;
        b=cxXgfSsHidM8TqSJFQ0CYG3INwchN0VX+tZsRHc/ZIBjUuHpHA0UhVrE3QbENNYesn
         yPvCoHAawfIH6netzK0heJgRHbQ8OzJFul52I62CkUsCKLUOTxCBA7V/jBk+Ce6CXgAB
         zx246VLxzdBqr0S3OmrZujHmr3VTtiptt+cmWCTxqZad68xZ5Mt4fnq7TiWVCekyB5zv
         JFjdRjH9/Duzr00/5FDwdlzzEwpNiB+TeXAg9QdMO2DMkv2erbuHqDqzb+bU3SYs/c7v
         mIKdiUlmt2hvGZ+3G8PSqTYG8KlZk2FTFlwKPF9u57S3cU+DOxrB2i/E7Ftq7USJ7+ft
         VHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6vKULXXoRyikupCNauwDhUwrjfRvNlLhXlPN0u/DcXE=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=XapCqkbyuQJgpqM+3L5iBgE0X2/ZV47UuMOCcHL6EKsGMfkn2057hLcsmK1qmviHmk
         wOXCOLH2LCg+u7nYhIE3AfUL2NVcJvnZAJktih1OFkdedlpR9/i/OzOjpPWJ7VbX2VOP
         cZvQ/WSHH+xyD94XloxPHtP6ta7P7TkGwXTsQk6kdPl1IrEQ0TZBKRpmmBXPa7wNq+8w
         /HFuyZ24bDZ0k/5H12aB5SRpGXc5Gm8CScCKHmD3dEv0OMWYTwoBXCYikkPos5LFY3iD
         p8xZOFl9cga3JqCakdCPId6xLjX4rh34sk8dT/gP0Y3bsUVobPywWQXVkKpxs/5C+ibE
         wzJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778787063; x=1779391863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vKULXXoRyikupCNauwDhUwrjfRvNlLhXlPN0u/DcXE=;
        b=YoQtBvSfaIaslmNL2bWRe3uAukhmTWptmA1BXjELtMspI1eUE5/Qq9AImO0pk/jbRX
         lFL86eiOzgQiR9KIGwMOqJVYywyAZc0hT4cEA+zmg+U48Yyh/CPEZRUQ50nNRwSzqoFt
         1H0S8rX+29nvGUJIuWecBtkpFzNqoHmUchMEfM/q4Cqm/iFvXh3AeMdAwt28dNnfvqE3
         F49y4EC/9AKKHri3Rt6W8owD8ouaInW/xdSNoSKt81dANr3uN6+pTxwdkMn7cjxog5OG
         uhyebkVLn8GBMgeRWRxIgtHvyoP8qi/2RQ6g9IniXWNGdT8VbcZvBw2LdPq2U0vWGsSG
         pGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778787063; x=1779391863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6vKULXXoRyikupCNauwDhUwrjfRvNlLhXlPN0u/DcXE=;
        b=VwGdZIak4dL17jzzsJxFZSbnRes6XaXFXFhrm/iCcDMys0JdPy3sgxuI2F7EAyzEQ3
         q4ld78MxB3nVG6UMDpABdSZ1gJf1CdAwlRNTtqYYESEXxcupGNzMj1zcMyEw8KeOVY2S
         j0SdKlGiVB+BK2jpIWRF5BimD7/wSVdAUNjG8wdfZQiCXiHKVLLVPGndm0A8tbgGKW9J
         Ef0KrTap4VjfusBi9gS19dNu6BM/uC0cNClN4KdcO4q0ENPrqIGxwLXibKceL34FC5Kt
         gRXNkEMcgpAt8KtJud+HS2dQ0AgTBqOVDX2JhsQrltOLsq5RZsLXBTzAfukKLu+N5BMV
         43Zw==
X-Gm-Message-State: AOJu0Ywhc+w2zt/P2+S/Qr9R/OIBXQxI9ONPZ7QHnjiSRLFoso0Kr2Fs
	9gNPctuLDuCA+iuLyQf7qW8T9U3biAXQ4wZGLnciTJCgVfqwE1pYhoWt+dpkfLFR7qDE5vy2Z0A
	SfMBFUsM0Y0xgIrqh58mcqQ9xPAIfsqo=
X-Gm-Gg: Acq92OGQp874IDLzjHTbMH6UKlrZFYQ0Q9IwzCNCuOwo1ovphnjI72f3UeZ0DsWJXAi
	/wre7PFJVlngOPax/l1/5JtB3Wl4d7y7qvJgZPtU4iGI7NHYPQctCi7CdZhSFWKvlw9qtIr7luE
	th1l33KuPY3AI+bUUoHU27B4VJAn0gQOhIov4mKbviLv+IRDqfWuVB1qJFtignXLLkfx1hu5ytz
	3QBFs2aMmKCMNpkMCzZ4R2cgDLQBRY2mkgda7rTp/Sz1nG1Wku1Nwpff9tayoVQ/0JRFHaS1ysR
	NwH9j3LoHEmE8HY=
X-Received: by 2002:a2e:be08:0:b0:38b:f0f0:e39b with SMTP id
 38308e7fff4ca-395609cee95mr3136931fa.10.1778787062562; Thu, 14 May 2026
 12:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506195834.19-1-kalevi@kolttonen.fi>
In-Reply-To: <20260506195834.19-1-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 14 May 2026 15:30:51 -0400
X-Gm-Features: AVHnY4Lpwn0NrSOZRaZ9LJKSBiA7DkI_aPc7kiMW9xGnPjt3Ri0TXXrx-V-T3eg
Message-ID: <CAP+JOzQt9MW2W_6KZOt3_7OEwd2o+7pDszpcKt=cwGu1GoNGFQ@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: make expand-check a proper boolean option
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 3:58=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.f=
i> wrote:
>
> Make expand-check configuration option accept values
> 'true' and 'false' for consistency with the rest of
> the boolean options. Preserve backwards compatibility
> with old configuration file settings by still accepting
> the values "1" and "0".
>
> Add missing <stdbool.h> include.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  libsemanage/src/conf-parse.y    | 22 +++++++++++++---------
>  libsemanage/src/semanage_conf.h |  3 ++-
>  2 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index b69ac75b..3cd2b7a9 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -29,6 +29,7 @@
>
>  #include <errno.h>
>  #include <unistd.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -168,15 +169,18 @@ target_platform: TARGET_PLATFORM '=3D' ARG  {
>          ;
>
>  expand_check:   EXPAND_CHECK '=3D' ARG  {
> -                        char *endptr;
> -                        long value;
> -                        errno =3D 0;
> -                        value =3D strtol($3, &endptr, 10);
> -                        if (*endptr !=3D '\0' || errno !=3D 0 || (value =
!=3D 0 && value !=3D 1))
> -                                yyerror("expand-check can only be '1' or=
 '0'");
> -                        else
> -                                current_conf->expand_check =3D value;
> -                        free($3);
> +                       if (strcasecmp($3, "true") =3D=3D 0)
> +                               current_conf->expand_check =3D true;
> +                       else if (strcmp($3, "1") =3D=3D 0)
> +                               current_conf->expand_check =3D true;
> +                       else if (strcasecmp($3, "false") =3D=3D 0)
> +                               current_conf->expand_check =3D false;
> +                       else if (strcmp($3, "0") =3D=3D 0)
> +                               current_conf->expand_check =3D false;
> +                       else {
> +                               yyerror("expand-check can only be 'true' =
or 'false'");

0 and 1 are still acceptable, so the error message should reflect that.

Also, you need to update man/man5/semanage.conf.5 to reflect that true
and false are acceptable values (along with 0 and 1).

Thanks,
Jim

> +                       }
> +                       free($3);
>                  }
>          ;
>
> diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_c=
onf.h
> index 2388faad..f9e330b7 100644
> --- a/libsemanage/src/semanage_conf.h
> +++ b/libsemanage/src/semanage_conf.h
> @@ -21,6 +21,7 @@
>  #define SEMANAGE_CONF_H
>
>  #include <semanage/handle.h>
> +#include <stdbool.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>
> @@ -36,7 +37,7 @@ typedef struct semanage_conf {
>         int server_port;
>         int policyvers;         /* version for server generated policies =
*/
>         int target_platform;
> -       int expand_check;
> +       bool expand_check;
>         int save_previous;
>         int save_linked;
>         int disable_genhomedircon;
> --
> 2.54.0
>
>
