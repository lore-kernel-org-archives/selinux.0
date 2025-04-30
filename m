Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F4288DA
	for <selinux@vger.kernel.org>; Wed, 30 Apr 2025 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028860; cv=none; b=PRbVU2Zlnc+uWjEC5xCp6KP5x3uzlUc6OvY7akqyMi9QGx+SgtS2nuCH2uYBSaVUSQSffUbxNRyUKyOHRcdWUKytxvWQzeGWcKtOqBSBG+4eITD6mxNIpoOCmX/bIUoJLrBLKk7eDX5yBAK9K0SDrY1ZvgrJPspq4eFi0HBoL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028860; c=relaxed/simple;
	bh=/EZ3Hzxxon7ZXpoDvU/LYdWYnUfGbiXiIMTqqTn2fyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nak+1EGppPwG/wauX74J79QYoJjjeOD26Wrgw7k9+/+xvpcz1qslTgo+5KVeQH/zOgdnhPqBGnVzT0O8O2LgZtWWombcdWaR5ud8uE+TD0v2r1JdKH1BI5/vD7SLG+APr/sd825L8f0AsfOD8EDnNbpAcOrMP+btf8niLImtI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpCwkG+u; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpCwkG+u"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-873a2ba6f7cso2865815241.3
        for <selinux@vger.kernel.org>; Wed, 30 Apr 2025 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746028857; x=1746633657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEagP58MRDU7WidGlJapsEY7ysRbPAavnBdZCMP2iR4=;
        b=SpCwkG+ukcJ2I67xkVOpCgVrBD6CahVjlyGDmFO7Pw5V2K1sNRgREqWFqSJ07qc3f1
         TGiOhKEv9SfCq/3n40SyfC/meHGjyx2c05eKUosKHNwhHdKf4/5gmGZwqmSiEoJL4UCn
         M2MusJ1P3mflpUYrFoNM66qDFFmFIkwJSEAy4iZhp+Rcd+u9KQjD2nu7PO5LbXQM0BQk
         GOhv4F1XAqksrSql4WcjdBjtWMuKFJJZ/vSpml8Y89JLnzTd7VptvN9lQ/y9ugDVF1jd
         indi0+iyR0+kMI1H6Q1Ibt5hF2lKpAwyeMe/SY61rJLPm4B1jKzkNYoIaJNPXU7Xrgdi
         GBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746028857; x=1746633657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEagP58MRDU7WidGlJapsEY7ysRbPAavnBdZCMP2iR4=;
        b=U50wdZ5uXjdotQa4a/qmRdgyc1AW7m+e4g5Zkf0p7qhMMm1puP2TTbb+oEKsF4auN5
         XSHqwbzHq44EIkT2BegvWf6Ev+iCSvn9Xq/7a/hRyWCFoBJwtUEDJ1hz8QIE9mGNCnel
         BtjioGd7IrtPyO0Iktsbg59YpbBVoP2/0GzubvRorojMNMpDysEHyd0QP5pmjxdeSWPX
         E7fMIVUIED6EeDNcOfQmGAFSZGnlDrh9Zq//797zEHdu0qV/9GQcVCHRVzK8yaP0SHBO
         /TxvZU8Zye75ftRi6AqSiJthY6GvUQXB2B4v6wOyj9pZeYBOx64NFFm/6MmqHXoV2rOe
         yntg==
X-Gm-Message-State: AOJu0YwtfieaWEUgcx98WK8vy05OmCRGpJEuronqL8ZR3YlEYocNSOPe
	92h90XVFtaZAkZnJaeX93QPlmmtqnBVZwP9thLealE27yCYZ2YcaH61dki1eHNn9GvbPO9596by
	yFEZqU+0PSCrQnTggZIew9oKQhYwQuMcs
X-Gm-Gg: ASbGnctE7qAX7sH97b+/ZXqL4/bP9HNedCSdPXlCrJNXf65TyuApOIF7+Mzq/ey7GY/
	lRn/qMiUL5YWQVCQgJO/KSdTSR2viD3T2KAYZQVEUwC65jDIZuLYtMr8Hy3O7zUUEHAirQggHjp
	uYE9A1+hZm2pU+m+++kEU=
X-Google-Smtp-Source: AGHT+IGhaLYDMAjz93lKGWZeI7Fi4IA6kNEVCxDCbdOO35mGvS+CtHspxrG9XzYjG/zoc3kjXVV4Gh3dweqtt3rjLAU=
X-Received: by 2002:a05:6102:8020:b0:4c1:9159:859c with SMTP id
 ada2fe7eead31-4dad35b1591mr2800380137.15.1746028857208; Wed, 30 Apr 2025
 09:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430085757.2622178-1-inseob@google.com>
In-Reply-To: <20250430085757.2622178-1-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 30 Apr 2025 12:00:46 -0400
X-Gm-Features: ATxdqUExmnyv7LzCf60KAvkmuQDTXY-ThvJm6bMggTkgf0mVi80iKNoO3UpFCUc
Message-ID: <CAP+JOzTuwcZFpAEurkjiazcMXAQqzTc4=JQEswOwb+9KR=82mw@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: Allow lineno > 1 for source file line
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 4:58=E2=80=AFAM Inseob Kim <inseob@google.com> wrot=
e:
>
> There are cases that the line number starts with a number greater than
> one, if preprocessor skipped the very first line. This extends #line
> syntax so any lineno is valid for lines with a source file path.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
>

Acked-by: James Carter <jwcart2@gmail.com>

> Changes since v1:
> - Leave set_source_file as-is to prevent regressions
> ---
>  checkpolicy/policy_scan.l | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 5fb9ff37..7bdea427 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -57,6 +57,7 @@ void yyfatal(const char *msg)
>  #endif
>
>  void set_source_file(const char *name);
> +static void set_source_line_and_file(const char *line);
>
>  char source_file[PATH_MAX];
>  unsigned long source_lineno =3D 1;
> @@ -297,7 +298,7 @@ GLBLUB                              { return(GLBLUB);=
 }
>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}        {=
 return(IPV6_CIDR); }
>  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> -#line[ ]1[ ]\"[^\n]*\"         { set_source_file(yytext+9); }
> +#line[ ]{digit}+[ ]\"[^\n]*\"  { set_source_line_and_file(yytext+6); }
>  #line[ ]{digit}+               {
>                                   errno =3D 0;
>                                   source_lineno =3D strtoul(yytext+6, NUL=
L, 10) - 1;
> @@ -395,3 +396,21 @@ void set_source_file(const char *name)
>         if (strlen(source_file) && source_file[strlen(source_file)-1] =3D=
=3D '"')
>                 source_file[strlen(source_file)-1] =3D '\0';
>  }
> +
> +void set_source_line_and_file(const char *line)
> +{
> +       char *name;
> +       unsigned long lineno;
> +       errno =3D 0;
> +       lineno =3D strtoul(line, &name, 10) - 1;
> +       if (errno) {
> +               yywarn("source line number too big");
> +       }
> +       set_source_file(name + 2 /* skip a space and a quote */ );
> +
> +       /*
> +        * set_source_file sets source_lineno to 1.
> +        * Assign source_lineno after calling set_source_file.
> +        */
> +       source_lineno =3D lineno;
> +}
> --
> 2.49.0.901.g37484f566f-goog
>
>
