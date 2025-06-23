Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A1253B52
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685458; cv=none; b=YfYkmi0718+jL+rp4zV7wrso+BsMimKoN693X+K0BobSTX6IAM1yWerNdibWNBwaxC+rSDSGKulvL2QZ01+yMgMBFzs7cG0boecyQvcouX2qZDZEDMHIFzSc3lsI4yfQs52Gqu5QOwpEBUmSHYRyJukjutQukb7kWjST4qvbYhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685458; c=relaxed/simple;
	bh=QEIxJIMgb8UOIkw87Cb9aLfZS9HMVdd6mN1NNu4jLtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSkxurc0dp0ZazQkq+A1W2b2cSdd7m+Ah7Ol9+fYyj7BteLCPetiSCo9F6rmlPr0FDvQQivfU+atdXDjDfYCPECHVbg32wQd7e2JmcZfLxvG1bc/cPgapH+bldGv1ZXMgI5v/WmqB4pjthz9FG5GyDHphO8rk3Okl0nGN4mjglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URRBrfdN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URRBrfdN"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2352400344aso42598245ad.2
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750685455; x=1751290255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaJUZIdU94uz+zKB8shrYHDWcCSQZtXMuvg1wwPX2Qk=;
        b=URRBrfdNZx8dxEeL1B9T77EfFxsWQu47XDt/m6URtijWIZqoYSBbR3Q+NTlpmWOk4w
         5vJ22G7KKAFFDfREWmXbuc3qfZUznHppxscLq+61qJiFB5pAe+uRMeHz4s1OEbtDYIox
         /gElw9lyUZzyMjdOyjeyonBxTC+kBjTRkuHlwDjKnvgOlRkGJ7Ie6kW+fGhWS3yqv3Of
         rtxZ3O3qg2XJlTi4RyyDkfeSe6FxZX6aA2LaT11o2ed5hU5HNOGd3FT6tVJgr6jFnuI4
         wLXse1D7ZAkD3Zw0LpE8py1+tnjjKS8O7gqqxiYFSOp7r+Sesp/LkmQ0s6e/YInn7nsm
         /SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750685455; x=1751290255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaJUZIdU94uz+zKB8shrYHDWcCSQZtXMuvg1wwPX2Qk=;
        b=ureKas9aajFCREimJS37SQgNe+VoYULfI/Eods00OYGh8yiUQmGaGjzIP6p8t+3P4A
         GY0PhZu/ZC9UuOxshAScQohQIWYBxHowa+Kw99GIKI9RQIJsMwBmK1wH1Eg3GfGfqWfL
         9XwR9uuCe5hV2x5XvbmUoFnmwnng5y9Z7bruG8i+aPUwgQfoe6vRTL40B6v+i+63fHO6
         2vSOuQG+7kuSryDVPvv6kgdj65NiTowzS0gjCa96ZyIUKxowdOZ2ea8A5buSrU8jtlwT
         +572OsG2sK1zSfeU5F5wZaOEFwNXFjiJGdn83wFQTxFXbSVqdSXrAT5OdQyhwBT7U8NJ
         SjaA==
X-Gm-Message-State: AOJu0YzWvl7Anw/ikx5WCdwvtfkfCWEDrsIZWrKeZfCiEq8murnuq4/N
	D+3p9rP1Fmo7hKAa+tmBAuyoYPZg13NAEgSyO1c5fMJc3NHW8hSZkSHhBF9QkLGcjkKIQC1V9WT
	odkly04M+KR0xM6YTrxJIkpiAGw5m/WpAFQ==
X-Gm-Gg: ASbGncu9Kb7ur7nn3p+9+eSuJ11E3MJad4saH5LxkRO2j9x2S1skBkYV61XYhnjnLBq
	MYtFg7xTfuBMfltqZHl3xEYrZKlm5SQKLzT0W4OySlW65drdvd6XrxRZrLSFdVrGYZb/+7ZB12d
	GKAZKoisxRvoK8pzgvoqpHapTvngSj2e/L/lLwfFSfI4er7PhZP4zcaQ==
X-Google-Smtp-Source: AGHT+IG84Pj0EBsheBdMbbeZ/25ls2DyDhYtm0TSmckuMLH4q0r92ygLFbow81RN9tb+vJSRbGvNYYSJ1v8/kQnvAxI=
X-Received: by 2002:a17:902:d2c6:b0:235:f45f:ed53 with SMTP id
 d9443c01a7336-237d99b8f35mr203188065ad.33.1750685455363; Mon, 23 Jun 2025
 06:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616132724.22406-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20250616132724.22406-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 23 Jun 2025 09:30:43 -0400
X-Gm-Features: AX0GCFsfRyf8SRHSGfV20Dvo-FVHGiNfnnLoAK3WZlTN2Y9EsOMl715B4EdOXqc
Message-ID: <CAEjxPJ5bn6NJwAWsjcfuPhUHuhULjxwxiK3DdY-KHJjBQjxX0A@mail.gmail.com>
Subject: Re: [PATCH] userspace: replace all links to selinuxproject.org
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Replace all links to selinuxproject.org with links to the
> SELinux userspace wiki or the SELinux notebook as appropriate.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Any objections to merging this since selinuxproject.org is dead and I
believe I have replicated all of the relevant content over to the
SELinux userspace wiki?

> ---
>  CONTRIBUTING.md                    | 4 ++--
>  libselinux/src/libselinux.pc.in    | 2 +-
>  libsemanage/src/libsemanage.pc.in  | 2 +-
>  libsepol/src/libsepol.pc.in        | 2 +-
>  scripts/make-update                | 2 +-
>  secilc/docs/cil_user_statements.md | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> index e6a677a0..575410bf 100644
> --- a/CONTRIBUTING.md
> +++ b/CONTRIBUTING.md
> @@ -8,8 +8,8 @@ You can find a list of open issues where you might contri=
bute to the SELinux ker
>  https://github.com/SELinuxProject/selinux-kernel/issues or to the SELinu=
x userspace code at
>  https://github.com/SELinuxProject/selinux/issues.
>
> -See the selinuxproject.org [user resources
> -page](http://selinuxproject.org/page/User_Resources) for more
> +See the SELinux userspace
> +[wiki page](https://github.com/selinuxproject/selinux/wiki) for more
>  information on mailing lists, documentation, and other resources.
>
>  ## Reporting Bugs
> diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.=
pc.in
> index 7c66b1fa..587a4dd6 100644
> --- a/libselinux/src/libselinux.pc.in
> +++ b/libselinux/src/libselinux.pc.in
> @@ -6,7 +6,7 @@ includedir=3D@includedir@
>  Name: libselinux
>  Description: SELinux utility library
>  Version: @VERSION@
> -URL: http://userspace.selinuxproject.org/
> +URL: http://github.com/selinuxproject/selinux/wiki/Releases
>  Requires.private: libsepol @PCRE_MODULE@
>  Libs: -L${libdir} -lselinux
>  Cflags: -I${includedir}
> diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libseman=
age.pc.in
> index 43681ddb..978474dd 100644
> --- a/libsemanage/src/libsemanage.pc.in
> +++ b/libsemanage/src/libsemanage.pc.in
> @@ -6,7 +6,7 @@ includedir=3D@includedir@
>  Name: libsemanage
>  Description: SELinux management library
>  Version: @VERSION@
> -URL: http://userspace.selinuxproject.org/
> +URL: http://github.com/selinuxproject/selinux/wiki/Releases
>  Requires.private: libselinux libsepol
>  Libs: -L${libdir} -lsemanage
>  Libs.private: -lbz2
> diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
> index f807fec6..55f06304 100644
> --- a/libsepol/src/libsepol.pc.in
> +++ b/libsepol/src/libsepol.pc.in
> @@ -6,6 +6,6 @@ includedir=3D@includedir@
>  Name: libsepol
>  Description: SELinux policy library
>  Version: @VERSION@
> -URL: http://userspace.selinuxproject.org/
> +URL: http://github.com/selinuxproject/selinux/wiki/Releases
>  Libs: -L${libdir} -lsepol
>  Cflags: -I${includedir}
> diff --git a/scripts/make-update b/scripts/make-update
> index 4c940e1b..5549904b 100755
> --- a/scripts/make-update
> +++ b/scripts/make-update
> @@ -30,7 +30,7 @@ echo "Copy $ARCHIVE from $DEST to the server and update=
 its download link and ch
>
>  echo ""
>
> -echo "[http://userspace.selinuxproject.org/releases/$TAG/$ARCHIVE $ARCHI=
VE]"
> +echo "[http://github.com/selinuxproject/selinux/releases/download/$TAG/$=
ARCHIVE $ARCHIVE]"
>  echo ""
>  echo "`sha256sum $ARCHIVE`"
>  echo ""
> diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_st=
atements.md
> index d5674f12..dad88ef6 100644
> --- a/secilc/docs/cil_user_statements.md
> +++ b/secilc/docs/cil_user_statements.md
> @@ -358,7 +358,7 @@ The user `test` cannot have greater privileges than `=
unconfined.user`:
>  userprefix
>  ----------
>
> -Declare a user prefix that will be replaced by the file labeling utiliti=
es described at [http://selinuxproject.org/page/PolicyStoreConfigurationFil=
es](http://selinuxproject.org/page/PolicyStoreConfigurationFiles#file_conte=
xts.template_File) that details the `file_contexts` entries.
> +Declare a user prefix that will be replaced by the file labeling utiliti=
es described at [https://github.com/SELinuxProject/selinux-notebook/blob/ma=
in/src/policy_store_config_files.md](https://github.com/SELinuxProject/seli=
nux-notebook/blob/main/src/policy_store_config_files.md#building-the-file-l=
abeling-support-files) that details the `file_contexts` entries.
>
>  **Statement definition:**
>
> --
> 2.49.0
>
