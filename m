Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAB440A2E
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976167; cv=pass; b=RajU60BXw7gH/OyyennKqMobJN84CBc3b1cRCCn3Xz8x3DrmFZckJI7hh9vPwYmzbziHAh/rXtam/czdRrak829VXh11W+et4RLp4NFfVR4NhD3mlgxLIjgJ4kobU/zqHKjKkNbmK5222I7sn3PUcJl4W0YB3aI9k8Rx1NUEuQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976167; c=relaxed/simple;
	bh=UDzHWgWp3wtjONI4mf3xqnQ96/ODPzMSREX9lgG38p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqPIKazDRiIJP0jIzjxwCLI4vovWbOdWbV6nCmEFX8+pnUjp2CJECKh96XZOOAvxcDq+AlIRBwGMzvvHBpe0pAl2MVVE/MLlTyCh0cFmVrDX+L4ipltivznnZV2GZ7UMy4ADkvQo+r46VTVKClfWEdQPb4xJ3Osy8hRS+fU4Kk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IraCdcTQ; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IraCdcTQ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so25854211fa.0
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 07:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786976163; cv=none;
        d=google.com; s=arc-20260327;
        b=S6NMp68+mbIZkyb3HAO4NiH7Vf+oR8PXXySiMAMffMpWRxR7wHN2sfPGFkUwpFmswe
         BNAFWZRu6WT9zBnfmlJEcAfpbhOVeCSfKxoey1FX0fjktXp3Qe99duf82Gsf1FLVRr8N
         8AcH9KEapoi67+OPGrSTJPtdNkAlSUEKGOxl+BsVll0NpmuqUe0BHLA8f86KfdMDsAfX
         wqrtwuYIFgDKBUxchtWBEgrzyB5URfXpK1p393LJp1kdmM5y76UiK1Do2cVm7OWbVub4
         RFVuz8CBlgHxixJL8pgsoyLTtEuCL0yGo0WKfRk84UzlXQag6tEdCI2g1xBIY3stGGD/
         UqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kPaYKde+InZaBuXQChB7cBzQDkMngO88bK8wbqCn/vE=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=eIYD5kwx+kxLF/iFECzSjKHooCsn7v9f4VCJpiNaPQ+tZSkRfDZx+cy2eL20uCrN5R
         Aez8Ca4KbKOIzwEswF5vQ3NoBCaYnU/tceIJ4VIm2ulIUS/xBG/GCcDrlXztelmhTxHu
         W37PScOZtnJFlMQRwyELepnzBS4vYHd5cGRew7ifaNvgBzgsNPoKoMIJyQGpK/QLeiZS
         NzGOZq7+ggTdp69cIsgUzEyP64i8yy6f82CuZBENjM8iOMoBcvvyrRxuNJki3Rb0keX7
         zHIJNBO25kKSS7DGlevCa1GYPgwPKJPSpqS3VKShbTb4pq4R3PV1IuND2z4JoMH1LeCw
         IQ6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786976163; x=1787580963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kPaYKde+InZaBuXQChB7cBzQDkMngO88bK8wbqCn/vE=;
        b=IraCdcTQiiMIcajss8LgZPAdB4hleptmI1wtR18qw+vNvZvLWX6s9rneOcuLKIy7v3
         3tyybuBpqhdGKZENoZuTHkb8SwCoq1NvHlPPGkHKK4PhJGlePZczxBpFOLYJiXhe4E3P
         dqJWwuB5b7pKOEI9sS16d9vsSFIhxyc8fWcoQ4nBSb+YF5mbSl9g/1nZuYSSlb45fZ1M
         Hq7TruHJcPYKSjCJ3G30pLoYcMSO2pCFQLqSHB+2o5u53DYof1gxOx91wdc4M+L/YVDU
         Zpb26EdA8rMeUolsTV6k2nlgHD7axreoyMCR+grIQLiCAV7UdFUzMulElda15XVAryib
         M2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976163; x=1787580963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPaYKde+InZaBuXQChB7cBzQDkMngO88bK8wbqCn/vE=;
        b=AdVNweRlDEPcOmwXmYCiRa2XDkRIR2zgkcIZWzxIx4U99bbeggk37kJYcCFl4K1uJ0
         YCzMw6UVJn1Vv0RtS2a+zuGEGv6Ha2MFEXW0MA9KCsWNJxlOPwNXagTjwPY9JCg94hSG
         zLCgMS4ppRINAp+R7ZsZO2cdFHz2Z0gZMcxTvQgEsJnIyi1Ww8jwB953D80rDt0yzcjF
         Mq8Ma6E4SL1bevj9P+KMUy4sYh5ElsQcrFtDvk7gZBWi52YXPmGVrtKUdmuRWrzikAvQ
         RPMjZWj6e6mhX1lA1zGejnTuoOqDxxJSzV7+SgDrwwF+e6k2ERyBC7yI+6VCTyiir/dx
         qGeg==
X-Gm-Message-State: AOJu0YyBv3fI/VNtA/xxaENF5E+yTP/LJxbm2GDok2SGrhGUXrOu6WDq
	VyGrViz3Se+aTKyJb+RDXxNjaT3ixmmFRTVM+bQ2Ep7J8Qvkd4WeIhFuJS+juUmx224GtewQqWV
	wvudC5zNd0zVMc1WMXKI9EhHv1/KCFeIk9pai
X-Gm-Gg: AR+sD10sw2kR92tJiUwGP0vllhdNT2RE7bZShGqse4lUGeIKLJsWHCM70qh52BSsSFw
	pMIHKXNZc6WwiQLpB6hjm1T0IB/T4aDf+b+FXq7jDbL8Cn9FTZ5QJFoIxcsa6bHYbA7K7uVl691
	Ooaw9CFzpSKMU4xLskcduU9Vw2S6YUR7z1XLDE+MA+x9Qs2z5oYMBCzY0wZ3r7SGSHUSJP2plcL
	g2WDXe3SjNwzx1CbpjnDlTDR7w/Pb5Gspeh0KsA44fn6FIF4EW3cEVAzm3TbcFgCSIHJold9C4q
	0n2ytfTVSqKXaNdG9GpsWDfeHPUBxzVeeQ+ByTyNDoyKILP0HshI
X-Received: by 2002:a2e:bea8:0:b0:3a1:11a7:a9ed with SMTP id
 38308e7fff4ca-3a17528da94mr254681fa.18.1786976163095; Mon, 17 Aug 2026
 07:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813184056.185732-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260813184056.185732-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 17 Aug 2026 10:15:51 -0400
X-Gm-Features: AcwNN1Vf6t-hxYQ4SwIEpbloUPkxi61Il5s1a9-kobdfiCO5ByEhTS4caO9F5w4
Message-ID: <CAP+JOzQnq8khhFY43BSytNv-Z8JSimhAYrCzz6xQqBpVyGXG2A@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: escape config text spliced into build_regexps() patterns
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:41=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> build_regexps() interpolates the base-classification, prefix/suffix
> affix, word and Whitespace strings from the setrans configuration
> directly into PCRE alternation patterns. A label containing a PCRE
> metacharacter such as "." or "(" therefore either fails to compile,
> matches unintended input, or produces a pathological regex that a
> client can drive via TRANS_TO_RAW_CONTEXT. The Whitespace value goes
> into a character class, where an unescaped "-" between two characters
> is treated as a range and "]" ends the class early.
>
> Backslash-escape the fixed PCRE metacharacter set when appending
> config-supplied text; the same escaping is safe both inside and
> outside a character class. None of the shipped example configurations
> carry metacharacters in these fields, so behaviour is unchanged for
> them. The configuration is root-owned, so this is hardening rather
> than a boundary crossing.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  mcstrans/src/mcstrans.c | 42 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 89235269..9704f5dc 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -1074,6 +1074,32 @@ static int buf_append(char **buf, size_t *cap, siz=
e_t *len, const char *s)
>         return 0;
>  }
>
> +/*
> + * Append s with PCRE metacharacters backslash-escaped so it matches
> + * literally.  Used for config-supplied label/word/affix/whitespace
> + * text spliced into the alternation patterns in build_regexps().
> + * Works both inside and outside a character class.
> + */
> +static int buf_append_literal(char **buf, size_t *cap, size_t *len,
> +                             const char *s)
> +{
> +       char esc[3] =3D { '\\', 0, 0 };
> +       char lit[2] =3D { 0, 0 };
> +
> +       for (; *s; s++) {
> +               if (strchr("\\^$.|?*+()[]{}-", *s)) {
> +                       esc[1] =3D *s;
> +                       if (buf_append(buf, cap, len, esc))
> +                               return -1;
> +               } else {
> +                       lit[0] =3D *s;
> +                       if (buf_append(buf, cap, len, lit))
> +                               return -1;
> +               }
> +       }
> +       return 0;
> +}
> +
>  static void build_regexp(pcre2_code **r, char *buffer)
>  {
>         int error;
> @@ -1106,6 +1132,11 @@ static int build_regexps(domain_t *domain)
>                 if (buf_append(&buffer, &cap, &len, (s))) \
>                         goto err;                         \
>         } while (0)
> +#define APPEND_LIT(s)                                             \
> +       do {                                                      \
> +               if (buf_append_literal(&buffer, &cap, &len, (s))) \
> +                       goto err;                                 \
> +       } while (0)
>  #define RESET()                           \
>         do {                              \
>                 len =3D 0;                  \
> @@ -1133,7 +1164,7 @@ static int build_regexps(domain_t *domain)
>         qsort(sortable, n_el, sizeof(char *), string_size);
>
>         for (i =3D 0; i < n_el; i++) {
> -               APPEND(sortable[i]);
> +               APPEND_LIT(sortable[i]);
>                 if (i !=3D (n_el - 1))
>                         APPEND("|");
>         }
> @@ -1149,7 +1180,7 @@ static int build_regexps(domain_t *domain)
>                 if (g->prefixes) {
>                         APPEND("(?:");
>                         for (a =3D g->prefixes; a; a =3D a->next) {
> -                               APPEND(a->text);
> +                               APPEND_LIT(a->text);
>                                 if (a->next)
>                                         APPEND("|");
>                         }
> @@ -1185,13 +1216,13 @@ static int build_regexps(domain_t *domain)
>                         if (i)
>                                 APPEND("|");
>                         APPEND("\\b");
> -                       APPEND(g->sword[i]->text);
> +                       APPEND_LIT(g->sword[i]->text);
>                         APPEND("\\b");
>                 }
>
>                 if (g->whitespace) {
>                         APPEND("|[");
> -                       APPEND(g->whitespace);
> +                       APPEND_LIT(g->whitespace);
>                         APPEND("]+");
>                 }
>
> @@ -1208,7 +1239,7 @@ static int build_regexps(domain_t *domain)
>                         APPEND("[       ]+");
>                         APPEND("(?:");
>                         for (a =3D g->suffixes; a; a =3D a->next) {
> -                               APPEND(a->text);
> +                               APPEND_LIT(a->text);
>                                 if (a->next)
>                                         APPEND("|");
>                         }
> @@ -1227,6 +1258,7 @@ err:
>         free(buffer);
>         return -1;
>  #undef APPEND
> +#undef APPEND_LIT
>  #undef RESET
>  }
>
> --
> 2.55.0
>
