Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A117332C
	for <selinux@vger.kernel.org>; Fri, 28 Mar 2025 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743188919; cv=none; b=YU+leGCxpE1dScXDzcAOMFI6Ci7OK1nvsTGgLodoXrfOiXq3g7CTYfImyx+rY1EAb8WFn0gnSQXcJJ8LvOpy13fd2LWGS+kDiPcRjSOwasIrWHvwl4qRpPpdCFPa2WDqnQ1VJeAsLmEayFU6B3V4IsStCHpxIF42BMZ5sGolyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743188919; c=relaxed/simple;
	bh=WisDaLcABkvjZN+uyC9IyXsn2KpFom1APrT+7eJ5zB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e89x6fHpo1fmZlczYEKmvzMpvmQIGG5ubDSKZn+V29ddAiqDFp5rBNa+JlVP07FknU6/u4Grh0qYMmo2vcch6UIpjDW7YGcTlKMo4GURHDNMDmploEWZ8gT+VTUb/Oou3eVsHuM/EYFLFl2KQ8ja1dGgmvGujR6J+wJiay4PuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXSdo1Om; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXSdo1Om"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d30c329f2so2322543241.0
        for <selinux@vger.kernel.org>; Fri, 28 Mar 2025 12:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743188916; x=1743793716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcVDlnEGv4OFTNiBxg/xkElSw0YZskDFh5JN9/ROa0I=;
        b=ZXSdo1OmUt3/Qu71lbwKrSpNmBUMxTzWJQiYmnzaUloaPATym3BQSXJZ5XCYORiVRG
         y1goW01+R0q9oMw6tXHcZ9XG6vgXF5kqHyBmf7fL/e8n845cF4LEcqU/D9nddGsZsXsN
         dvjGMCu5UEKoz8PJpWOyAX3iYeoPhoL75QgCa/KgZu04D4F2o+i5bu7q2j4pM1GtjAWO
         1YcFJI7hfBTuTeQRtmajneK98Z/4G44bmF6W9NE66WUIoihRjo2DL38yOPSzSVL4l4R9
         FEzavS/pqOa/46Fe+Wxv3GOdDDZRHlZEBFD0G5Jwk3GvvFJSwDBfsgq0MJe4VkaaHXZB
         Lhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743188916; x=1743793716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcVDlnEGv4OFTNiBxg/xkElSw0YZskDFh5JN9/ROa0I=;
        b=etKfdw7KcuCAb493r8KKYdU40Wwg8EanDC/Zqw8xwOUy5YyJ5CP7dlhl9/ms3xYlRp
         G47KDFjo7/T4Trb6uXClpuc9yEa3tpaHZkJC12obmtvR2yEnar3EGobNxCc/lIklRljb
         DvnkOptt3K045yZ1yxATAqC0+8QwtBZvYt5U9tLc9JA2yeLOqwUQt9wBhR8b9i66G0lE
         e59aSLszCvbyUuluSbvjn4xA9a+5/5okzhLVuDGajByTuYSKGdKefW6ivZSgRk6mcd1V
         VcqZyIwTQmFu6q47zkrYBESX69hybmCfiVCRiSXYPPL8PQZXnWQJIXcCQAMfKSPCId0o
         KSSg==
X-Gm-Message-State: AOJu0YwboFI45AiymMpJpzQ+s+RwME7eycxuc8CAi1RvBa5pr7HclcaE
	LHfkumwShE4n85odMdDRSTATfCQ+6TVvqhiii58Hm1Fye3y98y7fTtVlraiUTweVf7l+jSy1f9r
	swva4ZmMqi743D1Tc9+wrmTJj+HA=
X-Gm-Gg: ASbGncsYrMv3j9RMzDSOb5RsxVl0DfSJp+QdMqtubvPnxD9ITr41YRaangzFMTDEYLg
	kNxrmtqd3ICzaD4leLlnLGsheosJLbEW9AYinT8Rg9Hh3qWb+edpmw/fPYPC7rRBgxZ9IfIs7NY
	2I6iJ5w8R6eFPtSUI8UP52jgg=
X-Google-Smtp-Source: AGHT+IFiAEf8FuGDXUgkDEWIkDBQVl8H8P3mCqrtR0f2X9G4Aj41C8y63BwFKJgMmwXXGt+IbqM/yLFf6c/U+hFp0yI=
X-Received: by 2002:a05:6102:a90:b0:4c3:878:6a62 with SMTP id
 ada2fe7eead31-4c6c2816727mr2822123137.8.1743188916066; Fri, 28 Mar 2025
 12:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314171355.27185-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250314171355.27185-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 28 Mar 2025 15:08:25 -0400
X-Gm-Features: AQ5f1Jou1RXKysmTM-kS3swqzqlrZD1F-g6rwCGyu-cyeF60KiCCf3dn9XnEKCs
Message-ID: <CAP+JOzRRbx6v4Rri717_QZfcPV_EpkVk7Z=riX+aiJ3vtd-8HA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: free ebitmap on error in define_compute_type_helper()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:14=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Free the local ebitmap for classes in define_compute_type_helper() on
> error.
>
> Reported-by: oss-fuzz (issue 403364352)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index f19e9f6d..cdd98cdb 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1699,6 +1699,8 @@ static int define_compute_type_helper(int which, av=
rule_t ** rule)
>                 return -1;
>         }
>
> +       ebitmap_init(&tclasses);
> +
>         while ((id =3D queue_remove(id_queue))) {
>                 if (set_types(&avrule->stypes, id, &add, 0))
>                         goto bad;
> @@ -1718,7 +1720,6 @@ static int define_compute_type_helper(int which, av=
rule_t ** rule)
>                         goto bad;
>         }
>
> -       ebitmap_init(&tclasses);
>         if (read_classes(&tclasses))
>                 goto bad;
>
> @@ -1759,6 +1760,7 @@ static int define_compute_type_helper(int which, av=
rule_t ** rule)
>         return 0;
>
>        bad:
> +       ebitmap_destroy(&tclasses);
>         avrule_destroy(avrule);
>         free(avrule);
>         return -1;
> --
> 2.47.2
>
>
