Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD21A8F6E
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339590; cv=none; b=WoirJdjQmudeds13CKAmlCVmwUT1ULE5WmyxttH1iPp9P//JWVLrubRTWA2Um/cEF4PJqcPnSCdcea6sL5495O1i1qP/tlZJiVw1l8XPvSOwtBCYkuPa2k94BlGNxMckId2yULs2SEDqT1mc61Xf+hUNXDvXFMlVx2psUvXo+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339590; c=relaxed/simple;
	bh=kWUAmislDh4sTshx+sYpot/fYLnVXKtWTWQugGnmlWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rybx4vyAybjyfjlcS7OL36lIH9xQ0v40rvpf64v/aDVdjBUA0lq2p9qDgSW1jbfTCyRtc9cWfVL7kyJWhrajd4jnKU/UHRtDo6n4BwB30fCFa+OevmYvDDFjG7gHg2kW47yFfyXNE4g9oCyy/FQLc54LhQDkTsJJ97eVypHCkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOWM8KkT; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOWM8KkT"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4af1578d288so8281137.3
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733339587; x=1733944387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIfZ+7UVomT+UrLcfHeEH3RM5MK3p7JQIyiqdFFP00Y=;
        b=QOWM8KkTpxCmfwi1blQGAMEY+AgWR/Dq/LsiYQNd6bQ9zGMXfLu55WSFkJBoVsbeS9
         MJeY1inG7g0m7S5jSvNTNocfUuOC4LP6PyD2MWbc8SqFlr8NUaOpz3XPZyXUfo9LwABo
         vvA+hybyKrph+jKoIsgsGMhA0VziLACpXgi8BckUi/AyQoJUcMcE2HowskzoEYUJWRix
         lZZn3mnFvkppLjEcrhqMewasJeQ8LKjg7wjRh4SjJphwMRu4bK8EBowU6BHQk1kfCBCu
         wN2DcFm8wS63XZ4bGFDbhO4u/+PCHgRE+KyhA6cBq69WsdNfcRrvf10gRZUIIMzuUb8x
         68HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733339587; x=1733944387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIfZ+7UVomT+UrLcfHeEH3RM5MK3p7JQIyiqdFFP00Y=;
        b=djdVI16T89JdjbbJWYno4YbkDL61ZIurhw0cGHmmw1h9jDp9E0YkUs1jv0qmZ7tngs
         nqctLEz+XLUazxuNsfpVXmkJSmMn4ChZMUZnO532lvcS6ye2AF2PaDYDqChAXYSJg7BO
         Bs9/P+NR8nh0+6YcZifVtemEwK9RVePUBuCInNRXt7jwZYJNM3FxZL93ArGtsy9ZSQbM
         0/gU1HoVwbuJ657RrQogsrExPIa138yoyrZBq88AY2H+IGDaLZisKfyai1HgiKiG73hk
         gyG7K5cjjuQq4qDJFGDYu1KSEzcq5EggaC7f+4Gr81k+El4BpmoLHiAKa/l6cy24nYSA
         XeHw==
X-Gm-Message-State: AOJu0YzIiTeCOuRVKQw+EevF1hA/fV5Po1C5FWHeH3iZWr5jW2IrngkA
	6+3z70iKQ2U9Uk9qOjbW809YiH4/NrueMvCUnKfHQSECgsX0P8o20uUBVmaP7JuuhZ9ubUfbZkw
	aRlEozjxF0pomUlqpSuvREdD8eWI=
X-Gm-Gg: ASbGnculzsZ4w1yhEifQzRNoTqQ7eHbWuFoNFpt9WCTpQe121HYomp4L1k84F/Gmzz4
	USyxP2jXv9YIHXDemgxjqugSJQRlpVWc=
X-Google-Smtp-Source: AGHT+IHIC1ZP65P1UI+26a3OnW6l8YOmq6HiyG//UELCHRJk/Bfjpn7Id8pUVuWRzZ8RzaZZ9zQqtbtCy8chS1AWiAs=
X-Received: by 2002:a05:6102:2909:b0:4ad:b85c:e6c with SMTP id
 ada2fe7eead31-4af96e7e220mr12439978137.0.1733339587455; Wed, 04 Dec 2024
 11:13:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113074931.2730415-1-dmitry.sharshakov@siderolabs.com>
In-Reply-To: <20241113074931.2730415-1-dmitry.sharshakov@siderolabs.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Dec 2024 14:12:56 -0500
Message-ID: <CAP+JOzQQnGA4icsG6n7H0DBPxE4ouY8F2PtP+XtKKBGWKPWsbQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libsepol: allow specifying SUBDIRS when building
To: dmitry.sharshakov@siderolabs.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 2:52=E2=80=AFAM <dmitry.sharshakov@siderolabs.com> =
wrote:
>
> From: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
>
> Allow building without utils and man for minimalist builds which do not n=
eed those.
>
> Also make the Makefile modular as in libselinux.
>
> Signed-off-by: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
> ---
>  libsepol/Makefile         | 27 +++++----------------------
>  libsepol/include/Makefile |  2 +-
>  libsepol/man/Makefile     |  2 +-
>  3 files changed, 7 insertions(+), 24 deletions(-)
>
> diff --git a/libsepol/Makefile b/libsepol/Makefile
> index 5b5d03e2..e354d3cb 100644
> --- a/libsepol/Makefile
> +++ b/libsepol/Makefile
> @@ -1,29 +1,12 @@
> +SUBDIRS =3D include src utils man

To allow specifying only some of the subdirectories wouldn't you have
to use "SUBDIRS ?=3D include src utils man"?
This seems to always set SUBDIRS to include those subdirectories, but
I am definitely not a Makefile guru.

Thanks,
Jim


>  DISABLE_CIL ?=3D n
>
>  export DISABLE_CIL
>
> -all:
> -       $(MAKE) -C src
> -       $(MAKE) -C utils
> -
> -install:
> -       $(MAKE) -C include install
> -       $(MAKE) -C src install
> -       $(MAKE) -C utils install
> -       $(MAKE) -C man install
> -
> -relabel:
> -       $(MAKE) -C src relabel
> -
> -clean:
> -       $(MAKE) -C src clean
> -       $(MAKE) -C utils clean
> -       $(MAKE) -C tests clean
> -
> -indent:
> -       $(MAKE) -C src $@
> -       $(MAKE) -C include $@
> -       $(MAKE) -C utils $@
> +all install relabel clean indent:
> +       @for subdir in $(SUBDIRS); do \
> +               (cd $$subdir && $(MAKE) $@) || exit 1; \
> +       done
>
>  test:
>         $(MAKE) -C tests test
> diff --git a/libsepol/include/Makefile b/libsepol/include/Makefile
> index 1ad4ecab..8d64e846 100644
> --- a/libsepol/include/Makefile
> +++ b/libsepol/include/Makefile
> @@ -3,7 +3,7 @@ PREFIX ?=3D /usr
>  INCDIR =3D $(PREFIX)/include/sepol
>  CILDIR ?=3D ../cil
>
> -all:
> +all relabel clean:
>
>  install: all
>         test -d $(DESTDIR)$(INCDIR) || install -m 755 -d $(DESTDIR)$(INCD=
IR)
> diff --git a/libsepol/man/Makefile b/libsepol/man/Makefile
> index 0b410c19..6017ff51 100644
> --- a/libsepol/man/Makefile
> +++ b/libsepol/man/Makefile
> @@ -7,7 +7,7 @@ MAN8SUBDIR ?=3D man8
>  MAN3DIR ?=3D $(MANDIR)/$(MAN3SUBDIR)
>  MAN8DIR ?=3D $(MANDIR)/$(MAN8SUBDIR)
>
> -all:
> +all relabel clean indent:
>
>  install: all
>         mkdir -p $(DESTDIR)$(MAN3DIR)
> --
> 2.47.0
>
>
