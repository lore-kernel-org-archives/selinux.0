Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD6293458
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586658; cv=pass; b=RwUGb+QbXcyFVcmlQOD+f3vrCIikk9BjqhSMM9PKFfmvjFbKm7S0VBnoIgv+7vsOpxtk4NoRdYba7giDI6Id/QLrlHhHryhXsoGFP2gYVD5IA8U3YMhiMaQ9xEk/ykY/IxjVdJJGAmF9yvL4GWYK/3HvaiiM+AfTjFWga7RNdzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586658; c=relaxed/simple;
	bh=IFpzWXt8kkfQ5id6I0ijXV5VJkHaVodFqm5Ob0uS6uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sk5QUMUwcv38tgg1G6MaVsIAzOMS02wTWS2ir8d4/X9mvI8ZT8ORUGR3PNrWGP7WTbbMFs8cKwgXbt+nku0ScUhzDh91jbflVQjoUkkWBsZ67SrJQXYaqMWor55Zj3yQaljmgTyU/t4b00BboBraOPy/his6pSeOYzcGcHtpyGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi9vFgPW; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi9vFgPW"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so6026245ad.2
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 08:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780586657; cv=none;
        d=google.com; s=arc-20240605;
        b=CBtB3vy8jUNOdH4bVN7PcZbbmqGKvQarenZM6TpiUwlolkFkuc4lqhr+nZbSyuaja3
         16ljqdze9T0Q6YJrNDKm+Gpg3LxE5B5PwU/z9gX6mJfHYf8oH18yGvq0U96nEuEUCiVf
         vZCDP3EKYrtpAjEs+4UyzGloXK5qXoDr0IXsooKLx57B+a9GpTIHBtI7lUvy+vUxE9J0
         9JBeJyPHfopYbGoHoXsvK8dK0XCvDu/nFWEdV8LO+H5dPUaeK26ltDsg90DvxqH4yMny
         aizUYbOAIl0/2/dsYKZF2ngr+v2aKEVesDKU0agkToLgGttkfuEGIB3K5Ph1r8IaLhjI
         Px9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jQWW1miLuEW2C/DwGq4xMmbZ34X3+7C4dJAjdsYh+IE=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=F33KTiePRtDqy4QdTUXF2+Q1mn/uk2PRRvo5CATLwjalwd74mk6TJxQJBWzbOv19ZC
         6Oan0S38EjNQtMp3PUHQhDNjO+t14f5mxEhqkfykFCnk5UKtXKElrsuTc67pZ8VhiIU/
         sH4hJVsO1IU6rMHqZmHVD2Y4roFliHlW0/u1obCDfCXJQUgIpOyVeBgBLhgDXipjBaim
         JdePonpyb4x6aNlZREj8xv43La57PXPDsrEd3R2y2RFQuIb3Qtqn8cjtuFO+/pG1vLDX
         GGL3AgP5ibRPU0R2y4fP178EZG4H6m/WCzMLoMJVqdBOgaPeZGlx9B6lW1vtsAm5REMZ
         hB1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780586657; x=1781191457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQWW1miLuEW2C/DwGq4xMmbZ34X3+7C4dJAjdsYh+IE=;
        b=Oi9vFgPWi5v8hYleC1cWI01pA3ktFu916Os9buDyVJSOvYRwzhP7d2DHob/FwqQU/E
         loxYvxsOEQbZn9ryieH31osHzqezvXUslkvg011GYgQop270QJ89DIYMnHJu8vJhKKuV
         DjcU1RHXIOGLV3CGkIGMjWuOlXZ7PJPAEHgC9SCDXOWDRCRrLml5FMHYWtbfWljmH5b5
         2zKpRJKYEwrvNSiXmD81PopkHpe3MPb9oEIQy87WTFHoebi55Gb6TbGMRejm05oRmvTp
         asFHibS1lH4OJ/RiWz0H/h0JCIPJemcyQhhv1V0uoIT9JBNGrNxXNw542LmmffsxSBm0
         sJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780586657; x=1781191457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jQWW1miLuEW2C/DwGq4xMmbZ34X3+7C4dJAjdsYh+IE=;
        b=lfXlAdstmWo5rC88U9qSdyySIPs4t0R7vQlgSsMn2c8h1QnZ1rndpx5ttMxB5mUcAy
         3ht8JoSv6t5I4MqzUDvlFkz4f5Ko5OU7fWP0b07ih8wPYPVrVImSOlTXRaLT3imJ4Wdz
         R9YLhjjEklyobwMNjUkTxdeytrOdV3A5eExeDx2VYKKWbB7NjB0JDs8ZSUJMhKFglKtR
         b6vzsEZVnvtTdTuL4FZiGVN0qHODoSCyuBJDsLtNTWYXDoTp1+4aSKTxuLmlM3XQpuHV
         J+Y65Af+Khw9clorLS/cyciD3CBaO0BLv6sYQWcdVHcKcyOL/KyIVmDIE/O39t9h3Eth
         QMtg==
X-Gm-Message-State: AOJu0YxfkiXPNr4mS+e43KiE6k8aU7It9LtImNWaoCHBGUO3LqBO3ml/
	eusS8JxRThmAC5pkQntIRcDTo6Iw2QhyuQhhKAxQiKCRm3xtqEFKnZto6eKCr3iDsscpflTGYq3
	vJxdiG/SXF+6NFn3AP2cjEJSXt/e3KenX9A==
X-Gm-Gg: Acq92OGIdImXzAmXEwa23c+MeDRe7WmnOpN52fZXp3DEJYia6UEUQ00LTLoqnqIxQV4
	hVl0MF4ZguXvDqalftbasZf2LEup0eJLTZ6hqCBYX/U+1uq5aX28iXa7Si706M1QlvYk7eGTmgU
	RAOZq8wqqxdWdpZCOFgnFbMGoOjXbjzrSD3JcxKRbUoEo2fuRLvrK8IUx0IYW3baEAd7ynse42P
	vR51dOykRmFOVBzCOK4DRvWCJMYbtiu2Hfj4XaChBYQmqTd6BcdMPZb+NYhN4vpCFhcmfqK+mTG
	Yqit9Z99KOonAzJ9pA==
X-Received: by 2002:a17:903:38c3:b0:2c0:e7bb:9081 with SMTP id
 d9443c01a7336-2c1640b1772mr95897775ad.33.1780586656679; Thu, 04 Jun 2026
 08:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604150001.15944-1-jwcart2@gmail.com>
In-Reply-To: <20260604150001.15944-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Jun 2026 11:24:05 -0400
X-Gm-Features: AVHnY4JNxBuuvnOsT_UgF2qBXEsygWzXxv0EauZ-EJ-EO7l3CdDrtiT5QTIIP_Q
Message-ID: <CAEjxPJ4Tx60b3SuMq9pzun8mdFoy+4yfGxQk5L=aL=LB8Ya6Ow@mail.gmail.com>
Subject: Re: [PATCH v2] Have clang-format ignore auto-generated files
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 11:20=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Add .clang-format-ignore files listing the auto-generated files to
> ignore taken from the .gitignore files.
>
> With the exception of libsemanage, place the .clang-format-ignore
> files in the same directory as the .gitignore files. For libsemanage
> which has a .gitignore in both its top level and src directories,
> just place one in the src directory.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v2: Use multiple files instead of just one in the top level directory.
>
>  checkpolicy/.clang-format-ignore     | 3 +++
>  libselinux/src/.clang-format-ignore  | 3 +++
>  libsemanage/src/.clang-format-ignore | 6 ++++++
>  libsepol/cil/.clang-format-ignore    | 1 +
>  4 files changed, 13 insertions(+)
>  create mode 100644 checkpolicy/.clang-format-ignore
>  create mode 100644 libselinux/src/.clang-format-ignore
>  create mode 100644 libsemanage/src/.clang-format-ignore
>  create mode 100644 libsepol/cil/.clang-format-ignore
>
> diff --git a/checkpolicy/.clang-format-ignore b/checkpolicy/.clang-format=
-ignore
> new file mode 100644
> index 00000000..f6b7b435
> --- /dev/null
> +++ b/checkpolicy/.clang-format-ignore
> @@ -0,0 +1,3 @@
> +lex.yy.c
> +y.tab.c
> +y.tab.h
> diff --git a/libselinux/src/.clang-format-ignore b/libselinux/src/.clang-=
format-ignore
> new file mode 100644
> index 00000000..001f20b0
> --- /dev/null
> +++ b/libselinux/src/.clang-format-ignore
> @@ -0,0 +1,3 @@
> +selinux.py
> +selinuxswig_python_wrap.c
> +selinuxswig_ruby_wrap.c
> diff --git a/libsemanage/src/.clang-format-ignore b/libsemanage/src/.clan=
g-format-ignore
> new file mode 100644
> index 00000000..c3d35d46
> --- /dev/null
> +++ b/libsemanage/src/.clang-format-ignore
> @@ -0,0 +1,6 @@
> +conf-parse.c
> +conf-parse.h
> +conf-scan.c
> +semanageswig_wrap.c
> +semanage.py
> +semanageswig_ruby_wrap.c
> \ No newline at end of file

Missing newline

> diff --git a/libsepol/cil/.clang-format-ignore b/libsepol/cil/.clang-form=
at-ignore
> new file mode 100644
> index 00000000..3eb2902f
> --- /dev/null
> +++ b/libsepol/cil/.clang-format-ignore
> @@ -0,0 +1 @@
> +src/cil_lexer.c
> --
> 2.54.0
>
>
