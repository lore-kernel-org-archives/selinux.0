Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1E2949EB
	for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727682; cv=none; b=D27uJ3UZenpGN1/mxLkuliDOabZPFi8Q1gSI6AhLKGg7aAK2I93Qqju0Klu77s7feqmZpBoXlyzhb1smKGLpKXlMp7poC56fpN0wcVx0J8TNG/SU+2NpAvOQ9OZikmyn74rrersnabopK/oDzQaH8MMcdjXPV/4hrpWiARfIXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727682; c=relaxed/simple;
	bh=LdRPbPFnxQpoLqTe0f8Su1ReDixX9P3jUaLrK0sykI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwTHsMYqazG1umZx1uDvxMgZg65qlA6F7adomOh4sOkX60i0IDOvVouRb+nGQJu8xG2lreTZ0M2pvtd1HS8ZqCKpXuLGwbtxkN2GaxJKwHKrOtCpDlv/DYWYDHZkdrT48jLWUwIF088qGxU22qSWg1CR96DxbFX/llALGsKgrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UjP4pciI; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UjP4pciI"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f6ca9a3425so65865047b3.2
        for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744727680; x=1745332480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJVYie6e2sFL2iOxbcZpK1Auru/46cGqmeapp/74AQk=;
        b=UjP4pciIdtjX7WJxpEe9L3Vz9ptil+7nsrPVIkfq6QJO1T4xis7HOr9IJfvRRXQXY8
         b3TG32RN6g5W/R6zoEaBaYQ/IEBMpJ5HBP1P/fPD2X1PGUFZLL/OBOwjn99QbSk/CpNX
         7WGzIKIHpTX3D1Lus2ZN+v8Yrbr4O/pT2VtTnLlcsCg2jB7twsb/hPoCtYKRB2rkowXB
         pFXKWoTBR8m1Qwbe7bRxiLzrMap5mjWmm5cL5MIUaOlXDNv8gdlTU17DU6Hq47k2PfJ4
         ofqkMrnQuBqc/5/xhdQIAoMcsYzZV3Vr6PtMSA7F7ieLa9uSY5MNb15amUhXSyMo31g7
         NDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744727680; x=1745332480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJVYie6e2sFL2iOxbcZpK1Auru/46cGqmeapp/74AQk=;
        b=QV+nq6JCWlNhCf6fdlRC5XtqxD+SsMPz2+UxxnWXfEbApbMRJxk0TzSIdniJ7LYf74
         1lsT+PFUI6SgHntYF7O5f2KnXpNTKZAQM3+/YFBJZ3TFr5bXxShRMVRwI6vl9Ao4+HlQ
         vOCFRSEdd2ToU7HaW8wSyoz8yiVrFMjui4Gzcc2I4g0dWxQHFMAXQqHqa1KcOHohFGWh
         FAZYQX85b0kojmI2HLWA8v7g1o7zcvePjkCwpsC+2cLZZQNlt6XKc9qOiSlbq/t2k9DV
         uTg6lG25F1E/LZsK3LFoyWKUlPXYojP5gOgqdc6Y5NSRA8j7b9hiBs0FSsOUq7Er7wj9
         jDXQ==
X-Gm-Message-State: AOJu0YxHliI1EZmUF87yV7EZ+j0q7ehIS7dLqUtcjvk8Hil2CxcZU+fJ
	hjf03xI0vHHVBlxn+xP+phlzRpGlUL9K7tMfAE/M+C92Ejr31oZOxN8RgGh4HVdSzx16Hjw0Hwn
	BC16NL9nuOcHOfarWAWViG+DgnbY=
X-Gm-Gg: ASbGnctcMc3Yu7SvlhVl8GxNR4y6/jVvLBlPemsmw8grxmuNY9+v27EJiuq/mQ8Bb+d
	POUMusIrNtJcEP5upzvAihcqLSoMFLLfNCoSRlMZiCaYF+odWZ8U/uNmf/upaQqBjcwqr6uVhf7
	lDFEbadKVrRpWpAkCpHXH64Os=
X-Google-Smtp-Source: AGHT+IEDEgmylECXMVV2ndAZMNBHA0jCP/qRiQ2NdvcU+SnXl2s+O1OypWUE1wNRBPFN6smW1yRocAyrY7fnqLocMAU=
X-Received: by 2002:a05:690c:6481:b0:6fb:8461:e828 with SMTP id
 00721157ae682-70559a65932mr264405567b3.30.1744727679771; Tue, 15 Apr 2025
 07:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411185929.47912-2-tristan.ross@midstall.com>
In-Reply-To: <20250411185929.47912-2-tristan.ross@midstall.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 15 Apr 2025 16:34:28 +0200
X-Gm-Features: ATxdqUHmclZBDlWSUo51rqiY-hzrwz5udpy7g4pxUqLEt7y0xsr5URJeO5H6zt4
Message-ID: <CAJ2a_Df2p03otFfJ7wpGJ_izTw8SGAKr5vztFf0XxnnVypKFnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsemanage: add semanage_handle_create_with_path
To: Tristan Ross <tristan.ross@midstall.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Apr 2025 at 21:01, Tristan Ross <tristan.ross@midstall.com> wrote:
>
> ---
>  libsemanage/include/semanage/handle.h |  6 +++++-
>  libsemanage/src/handle.c              | 26 +++++++++++++++++++-------
>  libsemanage/src/libsemanage.map       |  1 +
>  3 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
> index a5ea31de..601cd9ee 100644
> --- a/libsemanage/include/semanage/handle.h
> +++ b/libsemanage/include/semanage/handle.h
> @@ -30,7 +30,11 @@
>  struct semanage_handle;
>  typedef struct semanage_handle semanage_handle_t;
>
> -/* Create and return a semanage handle.
> +/* Create and return a semanage handle with a specific config path.
> +   The handle is initially in the disconnected state. */
> +semanage_handle_t *semanage_handle_create_with_path(const char *conf_name);
> +
> +/* Create and return a semanage handle with the default config path.
>     The handle is initially in the disconnected state. */
>  extern semanage_handle_t *semanage_handle_create(void);
>
> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> index faea0606..ca57702a 100644
> --- a/libsemanage/src/handle.c
> +++ b/libsemanage/src/handle.c
> @@ -59,19 +59,14 @@ const char * semanage_root(void)
>         return private_semanage_root;
>  }
>
> -
> -semanage_handle_t *semanage_handle_create(void)
> +semanage_handle_t *semanage_handle_create_with_path(const char *conf_name)
>  {
>         semanage_handle_t *sh = NULL;
> -       char *conf_name = NULL;
>
>         /* Allocate handle */
>         if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
>                 goto err;
>
> -       if ((conf_name = semanage_conf_path()) == NULL)
> -               goto err;
> -
>         if ((sh->conf = semanage_conf_parse(conf_name)) == NULL)
>                 goto err;
>
> @@ -106,13 +101,30 @@ semanage_handle_t *semanage_handle_create(void)
>         sh->msg_callback = semanage_msg_default_handler;
>         sh->msg_callback_arg = NULL;
>
> +       return sh;
> +
> +      err:
> +       semanage_handle_destroy(sh);
> +       return NULL;
> +}
> +
> +semanage_handle_t *semanage_handle_create(void)
> +{
> +       semanage_handle_t *sh = NULL;
> +       char *conf_name = NULL;
> +
> +       if ((conf_name = semanage_conf_path()) == NULL)
> +               goto err;
> +
> +       if ((sh = semanage_handle_create_with_path(conf_name)) == NULL)
> +               goto err;
> +
>         free(conf_name);
>
>         return sh;
>
>        err:
>         free(conf_name);
> -       semanage_handle_destroy(sh);
>         return NULL;
>  }
>
> diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> index c8214b26..02c615ac 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -347,6 +347,7 @@ LIBSEMANAGE_1.1 {
>  } LIBSEMANAGE_1.0;
>
>  LIBSEMANAGE_3.4 {
> +    semanage_handle_create_with_path;

This should be placed in a new soname section.

>      semanage_module_compute_checksum;
>      semanage_set_check_ext_changes;
>  } LIBSEMANAGE_1.1;
> --
> 2.47.2
>
>
