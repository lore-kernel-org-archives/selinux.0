Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BC13D261
	for <selinux@vger.kernel.org>; Mon, 25 Mar 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386832; cv=none; b=Smg8+Y6wUTHWfR6ajdULJE+2kGE7WSses/UMlpKEY3FyrOEGay+HpFsanFCUGecOx3I00RSxd0GIcXDVB1gB0SP7a3Sq380pLWL0n5PMOMBvuu1SkDEpXAaZG04cnaI+AlF/UrQRLnKntzt/ELflKHgl+iK8taLVbBGI3NrKNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386832; c=relaxed/simple;
	bh=yKpaC2tq99a9yFZ0uph0nEZsn4ZCP54NZsVRno+Nm/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aM2234ZIygDCX1VITemhkeK71f/jELGCSfHv9eMJznGL1HRb40FNDk3wlMlXfEsxPtoT/PpLnIAd0iUQPp/cNbXb5MVZBVH/zQwXOKHmMIPvWyagYaEJa4Hbrnzw1BZGcVqTjuSULG5MS4yA/TQ+ShUpbkmOseN9sFoAthvUM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMHeTDHw; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMHeTDHw"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-476cec93716so1541726137.2
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2024 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386829; x=1711991629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCQBh3vI0K7DFJu8xxDIhQXe5L0iaH0GxaL7gRK5pgU=;
        b=RMHeTDHw5ymPNywpL2zt/l9iPRkNkjC+lo0Qm2G6UF16kijOS5QQ0XviB+/J8fsPOT
         kIAyHpeUu5pbErEVw9jJOhiRJnmMfDB2gXABFgOTGSbbeVdhzC+91iVOiz34Kpv/wmN5
         Oi/nePO1Z+m0hLmnBMEmXyHncVQ7j/Jk250urVAVaYKqF9zPZ4Su606mF85MT+1U/WEG
         iYPQLcPkSK6RXeZG1wsefCGS94szFtD2wFtVCMdOR/nTS5PcDxZS/nIATPph3QIlOyGc
         l+1IwvmsHtPzrvwfMB6EacvqZz7EF46Q2/wRMrlmcA6k8sUL/3nUaOzSSiw1GePLTpiF
         kaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386829; x=1711991629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCQBh3vI0K7DFJu8xxDIhQXe5L0iaH0GxaL7gRK5pgU=;
        b=FYK3RjbftoOWyRHNNkE9IW3dwNQba0u7H7EgISS2P3eXMhlkix6sOM2UEhTJLZ6/P1
         YdYoVmpc/WOIVOI4Ng2ycnD/9M5TBUwrVrycvpYlLeo7y3V1aNxmyOkzovUSlTHmBAbA
         6GvTXYtVV939CITQdvRDJLLLEXGudfHbZxOlzcSJHPy2TyzHsM/12MYUFRmMFfBrDYNz
         JGw6joZORmWALlobRqcpFMv2vxBL8KzDXerCFargasA4AnXYjiQJZ1cQh8Y8EhGM9mAL
         5BrFe4LbekNGv65TyDe2J0iTBTk4M8+iJv0rgWEHXe2Hm1yGeS9CQbo9FEGABSS93ij4
         jyyg==
X-Gm-Message-State: AOJu0YzZkDWK88fcsAQ6NgRUl4XUARkvxbA68e2MZ9+qZuXF2UlxNka+
	DAZU9FPNPu4YqQQ7gWCgPwn0L2h3cBM2tWqE34wmtHne/TWaqLKnBhURLV4DqbfPR1wgyxaJHu7
	OG//UCGAZyvqvh5bNvcUEHRAFcyUqNep4EEU=
X-Google-Smtp-Source: AGHT+IECfDojJBJD9HB0xIQAsGwzp/EMQ48OhrRi+3goSTUuAH/tgtuYhqgsjuXHaqoz8/hbxkPZBgo1ORRdnL068cM=
X-Received: by 2002:a05:6102:3651:b0:476:6a0f:68ba with SMTP id
 s17-20020a056102365100b004766a0f68bamr5783732vsu.12.1711386829525; Mon, 25
 Mar 2024 10:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322145049.60340-1-cgzones@googlemail.com>
In-Reply-To: <20240322145049.60340-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 25 Mar 2024 13:13:38 -0400
Message-ID: <CAP+JOzQH0gLqUTmYq5Ou2qt_P9nzvaQY6gscTuQpsU_Mg5rz7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: use YYerror only when available
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:54=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The special error value YYerror is only available since bison 3.6
> (released 2020).  For example the version used by oss-fuzz does not
> support it.
>
> Use a special token in case YYerror is not available.  Only downside is
> a duplicate error message, one from the manual yyerror() call and one
> from within bison for the unexpected special token (which would be
> omitted by using YYerror).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_parse.y | 1 +
>  checkpolicy/policy_scan.l  | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index e0103502..1b275ebc 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -153,6 +153,7 @@ typedef int (* require_func_t)(int pass);
>  %token FILESYSTEM
>  %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
>  %token LOW_HIGH LOW HIGH GLBLUB
> +%token INVALID_CHAR
>
>  %left OR
>  %left XOR
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 1926129c..c4d8e937 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -308,7 +308,14 @@ GLBLUB                             { return(GLBLUB);=
 }
>  "]" |
>  "~" |
>  "*"                            { return(yytext[0]); }
> -.                               { yyerror("unrecognized character"); ret=
urn YYerror; }
> +.                               { yyerror("unrecognized character");
> +/* Available since bison 3.6, avoids duplicate error message */
> +#ifdef YYerror
> +                                 return YYerror;
> +#else
> +                                 return INVALID_CHAR;
> +#endif
> +                               }
>  %%
>  int yyerror(const char *msg)
>  {
> --
> 2.43.0
>
>
