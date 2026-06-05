Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC382EC0A4
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682836; cv=pass; b=jy7D8INL+YDydE8EI6+PPAHGEJGgx9naocvcE7qzeBGMyyJMf0Fyd5nyo9IOoLsy4UNmQVaM33dhxM24IwERuFxfg0FIYTDwDV6w8pdGDDjNyR4KSY21Q1SF1wWnswnqGGU+1GZh73xWidStJsXEKNdz6PrBMXaaIW4YD47vYvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682836; c=relaxed/simple;
	bh=aGAPuuSBr3XkcneFY67jjf7R7dR/33pUTNXbIZHNiFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADNiNRX0n2qRYkgPdRHuSetodFESY8CY6cyH9CYARKRW7fOLgbzraldAfWJ8EbZQijLWVqRoh7b4NYWFxXLkpwFfgJrN/7LFUsgsGdNEEaYxVTAWgjVMHqaLqGoIAdskWhe2rl5zD0YqHOXsA28eXs21T0r1TpEq0k+lucGjND8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnnPzU2i; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnnPzU2i"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842319576d5so1316975b3a.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 11:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682834; cv=none;
        d=google.com; s=arc-20240605;
        b=cND1iAq7N/xKUwYt22rAloEVrSoT4CLyT3cwbspeH/r/9iif0OVN2thFvThJG7pg17
         jQ4kahujy3/88Y7+MgH7d01Ui7jM5O9LntYbsOvoZvqFsusknOOBI3xyWphwgZdMlrPH
         p6Aet6VMheHPgLWY02quwSIOruxpkHA57ViAzH+VXgNm0gdoHAORVb7F8sPuBaFOgi2n
         21623vCInoj5u9+dZE0CkJN08CKdiIVHfz2OHeTT1iYr41qecEo2jYKaSJ684yv0EGYj
         RdC6eK2rOp5Qi+VhOR3vJP1HOMqTPUOobGf4A8BevgFGYY0Cn7BAvLJXncm2WvQn1Bu9
         fVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a3Sqwci8YkRuhRRfhTxfbkbL5PJ5BmIqXYLZbi9mg0w=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=KMsNtB1lXLtIF2IdujSfTopRShmmTQOoBmnDHIHuKP59NOs9kmUrUlIifyXmlfeq1o
         u//GjToHL2M79I5AVYQVc0TtPfSt5kigkDuaR6UtvWYjVE3QTTTQjYdMIZQIcIlSyvZP
         PWtkUI6npl5o7N8RaaJr8Asw1SLmqZcUvMuffuqvSRhuC2At1+0+wdzrue7QHoruG11i
         ZJgq8uh9FCkMwf1ucSlP+QguasVvIMS483/5kWLi85PQTHZBZ9dCXMaSAhcPsBNA62BK
         3CSvrKy/1YPJum/bGd9xpjOo4pE6IXQ6BjjcfBRPdrkRfwYxen5l45WJgjhltiOlXnN6
         P4uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682834; x=1781287634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3Sqwci8YkRuhRRfhTxfbkbL5PJ5BmIqXYLZbi9mg0w=;
        b=XnnPzU2iN7j0e28+ono4hfrH2a5l99ybE44q6Efx0WpMQWgXyx9vzJiJdksQUA5L+E
         WyN4P+iK9nRpaAiVI3n+pW9ahCZRxVW7AhTlsUZhu32qg6zopVWGRAYmkDYTmiJ3Oow/
         zCPGns4AIiv0hdaCEVO6WvxUATmGPY5jgMcAyhfDQa7HShdihYha6NEjzLRS42XzwzUT
         84yrIIb0ahL3jO52tSFqL2lKGgcoZWFAMJfT+tKA4q911nZlhZiCifWWUPrOL8FyV9PS
         IVYb3PcBaJ1PUXvbhSx/gjGjDL/sJ+SNUAklRvW8RMLvkNDvIgX2Zg5g6/CeNfQDpQlb
         RtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682834; x=1781287634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a3Sqwci8YkRuhRRfhTxfbkbL5PJ5BmIqXYLZbi9mg0w=;
        b=o/RHauLFjRH/wtmoUZtN6RH5wgA127/AUW1Cqh4uk1Qf2oyHeWh9yGZZ0hul+LJfD4
         FsZjePz/0N+RokQpqJzuxs6hbvmLJbt5V2MyOOI5Dr0diNvADa9c4v2AAcy3KNG1GNgU
         DYGt5y7xQtqQGNn/kvUmKB6DU0++mAr7pId0M8RqNME7np24qMibKxn1xDU7Ar4KmuGH
         euJ9EeP47F3Ffonu2Uob9ZcLugMBXPzXsLtRQWD88L/YySPmZ4Rz2XOjprdd8cXtzTmv
         zrI21iGRCj9W5o4dfQorYXKuD+DM+tGZN4TN8+kehCynIMMx8fQQJGWenkSfEKeGY6OL
         nTRg==
X-Gm-Message-State: AOJu0YyF+SRJRSoUwksWNcFYuZ6KD82xifIoZozuk+Rn8xHH/yX+oKXJ
	scgg5bp+uFnGzmFmjcWYKauYYNZyPSzYOiT6abrxF5TTPSgBrbRvms8KIAWcr/RDaI4T0SmUPwZ
	nVuDL4voELg1bHFhqckcCsfxFlfj91Fc=
X-Gm-Gg: Acq92OGH34v6iQbpYKJkA51yNMkn6F+4hDy1+HCPCLhtqqxtsPJpn9i00MR6L9HmA+8
	3SJG9izn6Jr33LhdCj/j9rsC0npw+csviRZUIiwli/wf24zoKF38ySlAAR/DqfS2ZDWOWnWCiu7
	7DN8uOwI0H+KrJp6BudlurPxPCf06zQnSNne2WtNpxSW00v+5BtlguRcV1050BVe4AJirzvnxoM
	gcPhNVtnglr2gU6PUzXyJ80GFxqdmaabjOiPDdawKRcMAatQEmti1Clb1eBrDFgZbe9IhwgH2nk
	zFrZ5CA/0SUL6Q/uFh0o7avMr2as
X-Received: by 2002:a05:6a00:1ca0:b0:842:6e9f:9d3 with SMTP id
 d2e1a72fcca58-842b1095a49mr4562640b3a.43.1780682834109; Fri, 05 Jun 2026
 11:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de> <20260605172207.222382-9-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-9-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 14:07:02 -0400
X-Gm-Features: AVHnY4IoBIFNE5eM34FmcvvJkN7AuVs2mSlC7ZGJXwHWtcn6fVfv6zXh0qk83WU
Message-ID: <CAEjxPJ4Ciuj80Dui1ROKAYorvKnTxS41-5SUJ+h_Er7403zomg@mail.gmail.com>
Subject: Re: [PATCH 10/11] restorecond: drop unused macros and variables
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:25=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> After the recent cleanup several macros and global variables are unused.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  restorecond/restore.c | 16 ----------------
>  restorecond/restore.h |  1 -
>  restorecond/watch.c   |  4 ----
>  3 files changed, 21 deletions(-)
>
> diff --git a/restorecond/restore.c b/restorecond/restore.c
> index 622de773..d46439ad 100644
> --- a/restorecond/restore.c
> +++ b/restorecond/restore.c
> @@ -1,16 +1,4 @@
>  #include "restore.h"
> -#include <glob.h>
> -
> -#ifndef GLOB_TILDE
> -#define GLOB_TILDE 0
> -#endif
> -
> -#ifndef GLOB_BRACE
> -#define GLOB_BRACE 0
> -#endif
> -
> -char **exclude_list;
> -static int exclude_count;
>
>  void restore_init(struct restore_opts *opts)
>  {
> @@ -49,8 +37,4 @@ void restore_init(struct restore_opts *opts)
>                         exit(-1);
>                 }
>         }
> -
> -       if (exclude_list)
> -               selinux_restorecon_set_exclude_list(
> -                       (const char **)exclude_list);

Seems like we could prune much of the earlier parts of restore_init() too?

>  }
> diff --git a/restorecond/restore.h b/restorecond/restore.h
> index 17f0bc37..51b105ca 100644
> --- a/restorecond/restore.h
> +++ b/restorecond/restore.h
> @@ -45,6 +45,5 @@ struct restore_opts {
>  };
>
>  void restore_init(struct restore_opts *opts);
> -extern char **exclude_list;
>
>  #endif
> diff --git a/restorecond/watch.c b/restorecond/watch.c
> index 30dfb8b5..a795ff59 100644
> --- a/restorecond/watch.c
> +++ b/restorecond/watch.c
> @@ -25,10 +25,6 @@
>  #define GLOB_TILDE 0
>  #endif
>
> -#ifndef GLOB_BRACE
> -#define GLOB_BRACE 0
> -#endif
> -

Wondering if we still need/want the GLOB_TILDE definition above either.
Didn't protect GLOB_ALTDIRFUNC that way and they are both dependent on
the same conditional.

>  /* size of the event structure, not counting name */
>  #define EVENT_SIZE (sizeof(struct inotify_event))
>  /* reasonable guess as to size of 1024 events */
> --
> 2.53.0
>
>
