Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8418A6DB
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464114; cv=none; b=blw60mSNFTy1jhyGQ58Bwwwql36NlHUcdeGPwYiAw9q192f90tkhaFQ2jEHRsaYcOClgjKpIOv4Lf3+hW4eIoivsqecBqh80mXtvKwurmfchyJpOb1Sk+RNCr4bIHJ7yQ9lcwPNO/5FpM87UDcCDcpx9kO/i0sHAio34QOGC/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464114; c=relaxed/simple;
	bh=z3sU3F5xhW6C+3MjFHiiX72VVEWPjUiYqocsqFhMIm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6GbBAw5X9LSypSag3yLWrmWy6Se1XWFi+58mYSt1a4YDyLsxVymgLMqHIV2qc2dKjmo2+JentHN8IMKz71kbWKSfnBkmnscsw1Wtfx0JCA4qAzYbf+lMjRZyeV3S/0YP5f92uBy7IV97+PCyv44UD7rH3lthocygDAeKvLcneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9i0z8q7; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9i0z8q7"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afed12283eso3388461137.1
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 11:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734464111; x=1735068911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1fXY/t5xluQF21DdWEQA8PJVPHTG4WJQU9ZrJ8xEdg=;
        b=R9i0z8q7iIJujrDIYIvRl3/ZZdF743HOGY9qlO49Yd3eheDljWrJleMPmevCeBozWe
         k/ysAedde+RNjD/BcjxOsAEk++Of5saIIq2Q73fmr7gldpOnJh45zdB1bD5dXFsXH2la
         oInPs/rGVt69lDhH5vpXq3JXVpAgTO5FNe0HiE1iKcfg466ykX9mOCNIru4NDSdia0y2
         nxk+6fZSe+hVcyNaROd1FhXWOX5c9GrZLy//nqCESP17OcwmTwa3M4WghGddZyj1+wf8
         t35PpNoYamQOGi0+rxHbn6ukWiTK9ggpKdADESFXMfYlSlArfj4eMKY3pDMHCENkj5pI
         OCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464111; x=1735068911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1fXY/t5xluQF21DdWEQA8PJVPHTG4WJQU9ZrJ8xEdg=;
        b=ncM8lTjjTbyYPenUCGLdQxn+zDTTOZN/XAmvfK8mvp8oRqsl8gQWaxmsNkbIiQRS4v
         P4s2oqU367MqbOsYWTs+QwaZD3mLZQddkZHKGZ3dNGtNitoDWxKd6BdXMOeLZgvLE2T6
         DiAxcOoOJ+1CRYvh9CCTD0lJzJGmmf8IXxYyOVc6oYzORjybRldZQQAT1+VbjJ6avPJL
         m5rHWLiltbJqsFMwp5h3e8PV8OZ0pOemuQ/9l/lxEiCawBV9/QkDRNdZDqfsub1FWx9O
         LfLdgsRWg37Mf7EMcXcPDFDvN4+UEYbNugWtlsGgVny8ec811njpbRm98BqEYvPJZHpn
         ZU3A==
X-Gm-Message-State: AOJu0Yxk2xD9jsj3txi9wRtAiZF2zXWD2oNq/yZhcFOg2MNAkJIay1Gj
	p8+ctb5cldvnztcatCR3xcTTm+IGhTsRMQzkh/BDULWYTyNsbWwBOQkAZTRpPqxcSdji5TQwrBm
	vEezYzqUyH3QTzqa8aclc5tau/U0=
X-Gm-Gg: ASbGncvgBIiG4yB/b0OmJKjkUd1CEPXAyeC+GWgBG2GwTfcP2HUkmgHydKPruo/KW4W
	fMQ5EjhxVq/vO3I4RHtXMZbDJ9GS/hUrTsUcrJA==
X-Google-Smtp-Source: AGHT+IHEMbISpqkZtmLzu83iuYFb8eGC5YrgaWLmM76GJsji15i0p4a0mC2uBvB3ht02EdakDFbrJuVarrAF+U11T/E=
X-Received: by 2002:a05:6102:c06:b0:4b1:340a:ce5e with SMTP id
 ada2fe7eead31-4b2ae8acf3emr72139137.26.1734464110666; Tue, 17 Dec 2024
 11:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819182123.1037607-2-lautrbach@redhat.com> <20240827113150.1843304-1-lautrbach@redhat.com>
In-Reply-To: <20240827113150.1843304-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 17 Dec 2024 14:34:59 -0500
Message-ID: <CAP+JOzRsUGNtO4j2T6Wfnj=MgUhqxxxHqKqOjXgxqa+Rap6evw@mail.gmail.com>
Subject: Re: [PATCH v2] sepolgen-ifgen: allow M4 escaped filenames
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:32=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> When a file name in type transition rule used in an interface is same as
> a keyword, it needs to be M4 escaped so that the keyword is not expanded
> by M4, e.g.
>
> -       filetrans_pattern($1, virt_var_run_t, virtinterfaced_var_run_t, d=
ir, "interface")
> +       filetrans_pattern($1, virt_var_run_t, virtinterfaced_var_run_t, d=
ir, ``"interface"'')
>
> But sepolgen-ifgen could not parse such string:
>
>     # sepolgen-ifgen
>     Illegal character '`'
>
> This change allows M4 escaping inside quoted strings and fixed described
> problem.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2254206
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Sorry, I don't know how I missed this patch earlier.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> change to v1:
>
> - use ``"..."'' instead of "``..''" - sugested in https://github.com/SELi=
nuxProject/selint/pull/291 by
>   @cgzones
>
> - controls right number of openning and closing quotes
>
>  python/sepolgen/src/sepolgen/refparser.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/=
src/sepolgen/refparser.py
> index e261d3f78f87..c8a3eb54d679 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -486,7 +486,7 @@ def p_interface_call_param(p):
>                              | nested_id_set
>                              | TRUE
>                              | FALSE
> -                            | FILENAME
> +                            | quoted_filename
>      '''
>      # Intentionally let single identifiers pass through
>      # List means set, non-list identifier
> @@ -1027,6 +1027,11 @@ def p_optional_semi(p):
>                     | empty'''
>      pass
>
> +def p_quoted_filename(p):
> +    '''quoted_filename : TICK quoted_filename SQUOTE
> +                       | FILENAME
> +    '''
> +    p[0] =3D p[1]
>
>  #
>  # Interface to the parser
> --
> 2.46.0
>
>
