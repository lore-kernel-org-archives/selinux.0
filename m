Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4D224AE8
	for <selinux@vger.kernel.org>; Fri, 18 Apr 2025 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745003601; cv=none; b=KMbOPZ62pRildocEfEhuiXn+JQrj5d5ZsH+s9K2NZSZshl+uNaQHv0QhZKDgf23cbt2MVq3L3LEA2BvMXkRkipa5ZX7j/q1GEimV3PuLkTwD5tSlK3pp5ErhpAsFgXlrmmhwuYnIRpZG7LxAyFtikaPS7GEz2e5havdwA7akEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745003601; c=relaxed/simple;
	bh=Me92RTMDGgSkjW4sOsqoqxZK7UO8cOatsfcuQ5RXiwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZMfou8QIazlpKsJ90R58bCrB+HQybUEWHOVSTla/eFzfIBiV15ZdhDpmtBANJX/cn3ShqBcMjdd0YOfrrWScm/yfoB4HqkzXFEaMna6IU83tGOeatswAlYEAGCY5LAHvH+Vfw8vBYJV8++11cIn7n48k8ZN+feaPdffCeKVhrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5ksXcXc; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5ksXcXc"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-523d8c024dfso825199e0c.3
        for <selinux@vger.kernel.org>; Fri, 18 Apr 2025 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745003598; x=1745608398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q61/tgvNQZmaIxt5UnXPrOh+eBBtZALhDFYLujVt9I=;
        b=F5ksXcXcm40im1iJWWnejN37xsIcDGSTgZoR2fctkEzubOrBldVt5xqZaC+j9O7FOl
         +0T0RdC4D6Z33pUFHYViPDvG/spBVd5vMmp+kOnL4JtSiOmxKJpk0hv4hxdBDOaTAOF3
         pXLWuHxhHRs72h2hRMxiQ2NGxppYjusthtjDytbJ92sz17lxQc4hmx3o/plD8HtJzS8h
         5A/YfGz+KGHRkhm0sdOKS9iB8WYPENPwHJCHwKcxJEUJWh/sg/ZHL3BIr3eb6kNYW1fk
         IKact+brfaRtNORdAG7zaljN8MDTY+lPI7mwuyjQg0xqDfb+yYdS3ZEWTunt//VprS3j
         TRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745003598; x=1745608398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/q61/tgvNQZmaIxt5UnXPrOh+eBBtZALhDFYLujVt9I=;
        b=GfPs/qi7VnBQB+3pjZwLoWhOM1l/m7OIzJ34TdO0TVrGO7DcuTkA5QEZCZaROqf2R8
         YQehj2ydwPHikH20E65G4ITV7Au6WeuuFg1/dxwXBVdAOCm3Loa4HXNiG2PTKr/85+Nh
         h/TYSHpEe9J8x9SVevBObj3zU34Ptk6C48Da7NsZKt4DizLhu/MUi/PUXzgHErwRK8d4
         /WDJzOZjUzqL6eATxj4B+Zf26DK2QVrK4LxAP3biarvc5DJNAv5yRzWrXjUJalpig6ph
         wcd3Dair+08/zLrC2FAoKUsRPt5XN4mfGj6r7eFsv2iCQXNCIGHA4chnjZrkqG7DsCHA
         nouA==
X-Gm-Message-State: AOJu0Yyp/MsjE4MnypjkgNHoAWRV/V8rIAd/X3uqx/BvZkoRdVdhAG98
	mK6YPTKO5bus0gd8fR/cPRpEU53g8MQv7BVHB7L0EkIi4JyJhfHunfqYkFoN81R+fwCfOYn6jvc
	R3Y8HiSXUNxQOK6xet+FCdMr5Czs=
X-Gm-Gg: ASbGncuETawc7lPdoGVLfRmz8K6rvDfUlx9ui93PvtMm/fa3T+nMTpPfFQn+VE0blQO
	n1I74svNc1PpUU5snUxH7y5xDz5zluLkXWXwncio42YH7TPrv6EIc7SmDpeGst94KULK3HH1Thg
	7fgySdYEVp6p8IRcSQeys=
X-Google-Smtp-Source: AGHT+IFFvpYTkyufAsOtUEJva/6tPRrPJTrPXVQPsdNC44puIrMZvVBG6wuh2iu7xZjl/xZKQ0HHLRZ5sae/oznt2Cs=
X-Received: by 2002:a05:6122:8c29:b0:525:9ddc:381a with SMTP id
 71dfb90a1353d-5292549d35dmr3467730e0c.6.1745003597704; Fri, 18 Apr 2025
 12:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417190812.41263-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250417190812.41263-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 18 Apr 2025 15:13:06 -0400
X-Gm-Features: ATxdqUEsHTw-14v-_RoUQafgf6r4Yp52OmzEkMLeXFKVzazGwHbCsypyryYrk9Y
Message-ID: <CAP+JOzQT6z8osFtrK9PTfG8dXnuwwo7vNyMxT_83OBUEwERKtg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: prioritize local literal fcontext definitions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 3:18=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For literal file context definitions respect overrides from homedirs or
> local configurations by ordering them first.
>
> Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> Reported-by: Paul Holzinger
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2360183
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/label_file.c       |  5 +++--
>  libselinux/src/label_file.h       | 10 +++++++++-
>  libselinux/src/selinux_internal.h |  2 ++
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 5d73fb84..61a9ddb6 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -480,7 +480,7 @@ static int load_mmap_ctxarray(struct mmap_area *mmap_=
area, const char *path, str
>         return 0;
>  }
>
> -static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool vali=
dating,
> +static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool vali=
dating, uint8_t inputno,
>                                   struct literal_spec *lspec, const struc=
t context_array *ctx_array)
>  {
>         uint32_t data_u32, ctx_id;
> @@ -489,6 +489,7 @@ static int load_mmap_literal_spec(struct mmap_area *m=
map_area, bool validating,
>         int rc;
>
>         lspec->from_mmap =3D true;
> +       lspec->inputno =3D inputno;
>
>
>         /*
> @@ -742,7 +743,7 @@ static int load_mmap_spec_node(struct mmap_area *mmap=
_area, const char *path, bo
>                 node->literal_specs_alloc =3D lspec_num;
>
>                 for (uint32_t i =3D 0; i < lspec_num; i++) {
> -                       rc =3D load_mmap_literal_spec(mmap_area, validati=
ng, &node->literal_specs[i], ctx_array);
> +                       rc =3D load_mmap_literal_spec(mmap_area, validati=
ng, inputno, &node->literal_specs[i], ctx_array);
>                         if (rc)
>                                 return -1;
>                 }
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 67db78e5..b7aed0bc 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -96,6 +96,7 @@ struct literal_spec {
>         char *regex_str;                        /* original regular expre=
ssion string for diagnostics */
>         char *literal_match;                    /* simplified string from=
 regular expression */
>         uint16_t prefix_len;                    /* length of fixed path p=
refix, i.e. length of the literal match */
> +       uint8_t inputno;                        /* Input number of source=
 file */
>         uint8_t file_kind;                      /* file type */
>         bool any_matches;                       /* whether any pathname m=
atch */
>         bool from_mmap;                         /* whether this spec is f=
rom an mmap of the data */
> @@ -368,7 +369,13 @@ static inline int compare_literal_spec(const void *p=
1, const void *p2)
>                 return ret;
>
>         /* Order wildcard mode (0) last */
> -       return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2->fil=
e_kind);
> +       ret =3D spaceship_cmp(l1->file_kind, l2->file_kind);
> +       if (ret)
> +               return -ret;
> +
These four lines should be removed. It makes sense to consider the
wildcard mode as less specific and give priority to a rule that is not
using a wildcard, but that is not how it was done in the past and that
is not (from my testing) what is being done if a regex is involved. So
for both consistency and in keeping with past practice, we should not
use the file kind to sort here.

By my testing, everything works as expected with those lines removed.

The rest of the patch looks good to me.

Thanks,
Jim

> +       /* Order by input number (higher number means added later, means =
higher priority) */
> +       ret =3D spaceship_cmp(l1->inputno, l2->inputno);
> +       return -ret;
>  }
>
>  static inline int compare_spec_node(const void *p1, const void *p2)
> @@ -754,6 +761,7 @@ static int insert_spec(const struct selabel_handle *r=
ec, struct saved_data *data
>                         .regex_str =3D regex,
>                         .prefix_len =3D prefix_len,
>                         .literal_match =3D literal_regex,
> +                       .inputno =3D inputno,
>                         .file_kind =3D file_kind,
>                         .any_matches =3D false,
>                         .lr.ctx_raw =3D context,
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index 964b8418..3fe7d4c3 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -150,4 +150,6 @@ static inline void fclose_errno_safe(FILE *stream)
>  # define unlikely(x)                   (x)
>  #endif /* __GNUC__ */
>
> +#define spaceship_cmp(a, b)            (((a) > (b)) - ((a) < (b)))
> +
>  #endif /* SELINUX_INTERNAL_H_ */
> --
> 2.49.0
>
>
