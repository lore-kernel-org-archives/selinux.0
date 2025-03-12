Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D9198E76
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794468; cv=none; b=tA+jiPhUdBqpo5d1NC5RN5gc9QHONTYqLldwiSakyMgMeKSu+K5clqIm3RXxuBhrSLH2LE6L40uP2GcAJ00gknDcEfPUF8xeoeVAR4YPbxwXmsoakVik6/Ac0iiIJhQZHBdcA/by/v3PdnsbpG16So2Twl1yWes5f0H68Qi8PxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794468; c=relaxed/simple;
	bh=naLCbYkTj4wtNapPEI4cwvKFhu7lxXBAvCAlPeUlWPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFQd6z8Xs1NZwL9lpM8KdqfoSt1AH1A/D0xsnFHdkHHrTLbECyuQaEeqXUjVZMaJX1YaA6IsD0VzEujZjqg7WlnaEvF8A7I8j+6TdCwyUr8ljRBCWvGifSjRcrSgNNj0lbORhdzoZtYFyhYd/xcJ+9oBQYgsbR/ZOlrvUBPXuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxZe2hzV; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxZe2hzV"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d36e41070so2893646241.3
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741794466; x=1742399266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwcPR810p4wa7P/ovIpgPsV6U2/DXYTB7TcHnulvtSU=;
        b=OxZe2hzVz/AwJ+Hd/xM7v7p4KnT5y9ZbbvWAhLsKUuuSVhUIyyqaTQYBXQ6j0OlQrq
         o4NjQpxdgRJ2BNz97BdbqeoqPJXtjVAu0SAn0olSv+XD+X0ZBThPHxW5lSsalXoZVun8
         iR6+e/VpR/l5lMhGqGO6nGY5y/cxVQmG6HvpX1qTpofFX99LKbkoruvvEh6vY+VSpygw
         mbnukzU9rcxt+651uXOUF5+qqJ5s6aRJjzvqKv2c2qfXMDROv7KW+FWvZD1Qj/MI2WQk
         eJLxmxx92/DSACzUMr/uqdQc8ekDmZTnQ10ACkNm0l7GdJFZziR7QvhJXXupA4CfzfgO
         6qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794466; x=1742399266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwcPR810p4wa7P/ovIpgPsV6U2/DXYTB7TcHnulvtSU=;
        b=aUk7nZluJ0f/iQ5jBKI8OoCc92RfACcw0kvH8PiKXzi/ceAb/I1rHFr0tp9V11cXjb
         s0cL1qKBuhUI7//BA/+jnjf8bQ49REWP4lVVaaVvU85dgoQigWmQ0wuuS64DfM5p6V7m
         PIo0QvcSup5BGh+yq2T1QxYrmE6w2/+3KUqikovFXAEordKhmC9PYzd1WnMX/FF4BNmk
         4HeBXXy3QHeZ5Vmt3kSsNx9/2+60J2mtBQ79AU56u2hyMNVkfpSSfT1ceFTgFgwy0DEF
         Ryma8ZZRga6mb7sHEXgL//HwTAJCrXuhuMiNY9pdKZgveQVQ5g19UfJ3wNL+9hYpg5Fe
         yaWA==
X-Gm-Message-State: AOJu0YzvBpxdyPQ7OteD2L0tY4G+Xs5fs6DMF3jHm/KOWvsi7UpJJPRN
	F1rXhiCjM+9cCohT6SS/tKU14BPqCwHh81g6tuXPbeENpU9ue/VaObZpv62E/1SuBEO1f3jYPjx
	nrGACMC4Yk8JAib9zjYH3TX4JLvcce9QB9GU=
X-Gm-Gg: ASbGncuL6BkHHZxLW9xkPF7u/G4VKm7pzQ4yMPy4DhsMph2ifL3c5ndzbf1/xKMCK1o
	WjEhnQHax+QxzBlOMhUBMB5VZmR7G79XDJ+eiWySgOTUyX9mfgKAdEzkSYTIwN+H/L4xxsgQmvA
	teVJipbrJeZRt2nvvB6ZmGsPk=
X-Google-Smtp-Source: AGHT+IHMzuYohXtPUVwDX2m42FjeaSLDB8qihzU1MsSgKbhVDw9Flghj6jWUHleorh7porzvAGFvjfHrXQ2Gcbdt0hw=
X-Received: by 2002:a05:6102:4424:b0:4bb:dba6:99cd with SMTP id
 ada2fe7eead31-4c30a5aa778mr14627395137.8.1741794465724; Wed, 12 Mar 2025
 08:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212164932.35152-1-dburgener@linux.microsoft.com>
In-Reply-To: <20250212164932.35152-1-dburgener@linux.microsoft.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 12 Mar 2025 11:47:35 -0400
X-Gm-Features: AQ5f1JogB3bPyUvSDjMrT3Jx0rusRAns0vufohVuXcbdk7L3hNtRsvSRW6EEygA
Message-ID: <CAP+JOzSSt_N5u+zcYBS53vM8JqbqGe9CTjYNU-Rhvytm=5f2FA@mail.gmail.com>
Subject: Re: [PATCH] Switch from bison name-prefix to api.prefix
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:50=E2=80=AFAM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> Avoid a deprecation warning when building.
>
> api.prefix was first released in bison 2.6, which was released in July
> 2012 [1].  name-prefix was deprecated in favor of api.prefix in bison
> 3.3, released January 2019 [2].
>
> The new api.prefix construct rewrites additional variables when compared
> to name-prefix, such as YYTYPE and YYDEBUG. However, these variables are
> unused currently in conf-parse.y, so this does not affect libsemanage.
>
> [1] http://savannah.gnu.org/news/?id=3D7269
> [2] http://savannah.gnu.org/news/?id=3D9321
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/conf-parse.y | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index 6cb8a598..93a04699 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -53,7 +53,7 @@ static int parse_errors;
>
>  %}
>
> -%name-prefix "semanage_"
> +%define api.prefix {semanage_}
>
>  %union {
>          int d;
> --
> 2.34.1
>
>
