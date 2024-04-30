Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7C1369AC
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498304; cv=none; b=QZhmyw+bF9RggQr7pYce8jC10l2xdlQtMHOLTFHyc97YdXUC4ay5QPrIYLnfJCDrJMzUo6kpNFuK7Q022M6mfZ811Zdq4kooZbCyjGFIEZ/3MOJarYzFr38spCEvH4fsdNvkN3r1/csKe+E74h34RE2LybtSNaBnO+KBb4ZHKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498304; c=relaxed/simple;
	bh=J5yfHD0gN+zmKlHwzvbS28+yQaBjq0AkPjB7SBn+4mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tW7aMTeTbL8uKwNF2HNTHICg55eq61ZaCBp7gLcg6jua/PQiL+tApZTIb36xSOtlWFfTyg+nDaTFqn7KmeRmahA+2jTtpVFa5rlXno9K6jIQ0YRGy8Z0p6Q3Be8V8a4WzmqO1ttdPuUoHAkGIsbso3oykEMdTIcnhFZMF8cbc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTdkRnXr; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTdkRnXr"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de60380c04aso2371556276.2
        for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714498301; x=1715103101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rereDESLOg2/57PWLAOT3gOmfiX8JOU6jmUyWKnZKQw=;
        b=lTdkRnXr1F2LswH+5CCmSFmdbikKjwo1OCMjebStPe95DRyNb5OTDyujnKwXsEKY9v
         PirpCcYJNNwfVono5N/Uz0Wj5IAj4mFQanvezUWcp/P0zogJw0GsM+jRjqUkLvkuQCbm
         GfTRI2ofQi/42yxswJITTycPaMHJs4QbTmaGjnfgb6fiVhsieTYbU2S+d+l4YSR6Y1ru
         SUT8WvgMj0cWfrXtn9TbtBV5vh/f6MGOf0fE+Yc5Ah6nXgpoff6pNAAwzRjB0d9BrcrN
         lMbDAho+/LpZJudGSq57wAVx6WJ6ckq5U/QIsymjAyVBUEndTifB4LiHjHHYWHatey4k
         OWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498301; x=1715103101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rereDESLOg2/57PWLAOT3gOmfiX8JOU6jmUyWKnZKQw=;
        b=LY8fQ7YrwqNlDkJS1jXbthHBcG8iqpp8is4z9WH6SOBUGyEnmmECeqN5ecqISpCpAV
         qiz7qTVWUWa+Kf9tH5f3zPKhtriqHTV6ghWZ/2mfAY9FG3hbho4eXTRAOOEknL1DhYxr
         3SvGTENUykG6ysJpCx/iNUw+9h2n6wUyU1V+Z49AgUuV18XZY0Cg8c07bYiWEE7oqSU/
         F9OKFYC1FQiJ5frPLBzsIc5q9PQesbhBr4pVb2RzHWk0K936NOPmASDZNCUuRTVckS9X
         OtCCubhFlDij65EZVCoDnaI4yT/SbTilP574LcFrPQyeiZ+bn3E1VxBItj1LBPb8vDJG
         ZT/A==
X-Gm-Message-State: AOJu0YwzMZX/AVgYp2zXhUOijX90+mY/tSlFnM8LKvfDrAJxoOk2n21m
	9yFwQ71YWkb+2RUi7H/yN+NIqtRIO1euhquVBE5SBzZM62F8EOx2WR2RCUfuMTZ1kOaNIO9XhIF
	iZrZ1EmmOa5np76ggWEvm7Bb5Bc8KGs81
X-Google-Smtp-Source: AGHT+IFoIHZ2xBaSg9AwlLZmEiTvT6puTkkCGw8RcvdCgkOX5sJ69BYMYSQDFnYAoU8X3K/YtnP44TMFju8ZlntzTao=
X-Received: by 2002:a25:a4c9:0:b0:de5:50a7:bc9a with SMTP id
 g67-20020a25a4c9000000b00de550a7bc9amr324635ybi.5.1714498301507; Tue, 30 Apr
 2024 10:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430153024.790044-1-vmojzis@redhat.com>
In-Reply-To: <20240430153024.790044-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 30 Apr 2024 13:31:30 -0400
Message-ID: <CAP+JOzQ01q=P2W6WX5Edp1sO8yxB30uSTSJrgF+k=mQiggnzCg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix detected RESOURCE_LEAK (CWE-772)
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 11:34=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>
> libsepol-3.6/cil/src/cil_binary.c:902: alloc_fn: Storage is returned from=
 allocation function "cil_malloc".
> libsepol-3.6/cil/src/cil_binary.c:902: var_assign: Assigning: "mls_level"=
 =3D storage returned from "cil_malloc(24UL)".
> libsepol-3.6/cil/src/cil_binary.c:903: noescape: Resource "mls_level" is =
not freed or pointed-to in "mls_level_init".
> libsepol-3.6/cil/src/cil_binary.c:905: noescape: Resource "mls_level" is =
not freed or pointed-to in "mls_level_cpy".
> libsepol-3.6/cil/src/cil_binary.c:919: leaked_storage: Variable "mls_leve=
l" going out of scope leaks the storage it points to.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 95bd18ba..c8144a5a 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -904,6 +904,7 @@ static int cil_sensalias_to_policydb(policydb_t *pdb,=
 struct cil_alias *cil_alia
>
>         rc =3D mls_level_cpy(mls_level, sepol_level->level);
>         if (rc !=3D SEPOL_OK) {
> +               free(mls_level);
>                 goto exit;
>         }
>         sepol_alias->level =3D mls_level;
> --
> 2.43.0
>
>
