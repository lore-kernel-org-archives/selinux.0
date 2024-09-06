Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7B132120
	for <selinux@vger.kernel.org>; Fri,  6 Sep 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647864; cv=none; b=dpxHoP08JjVc0bPMbN0D1T/VrPQhhxfwE8OhoQ2UYY+J042x/mJbQfXG+Di4VylWzbtKhvt5wwHqJ0NAgFLLICG+oYX44VD+QLYeiMEDt4ZbXvroG0bpeTvSrwvaGtlmjoqxeb6gKmE12AYzv4lnCJmResHQtiiD3kkgVS12GNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647864; c=relaxed/simple;
	bh=Sb099loroznid82TL6UsRgewEF5E6va4NMgy9gU+6FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujkd3VZFjyjo0RVFrRVetxAY8qbcqtMGQdbZiy52dBkIB945tJaKHwqVLYIOeWbrp1UrDS+VtB6oLSUdrseRbRfTWy3M6a/lEs2vn2D7V0/pQaYz1NwLkutOTvgCNIBLpGvuuGJXSHwkdi+wjM2TlPRcz3GdDp1R15DxQaTQyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aBFDmmXD; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aBFDmmXD"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6db2a9da800so20558297b3.0
        for <selinux@vger.kernel.org>; Fri, 06 Sep 2024 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725647861; x=1726252661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0Sop3gGbpp7a02AwhDEi9yeUAD7zkHPXJcezmo9CH4=;
        b=aBFDmmXDgrQWRc10Ynfmo5YJHQZcHQSO4mZLRsqy2uVajMUglHnqskDoEBcQ2eGEY3
         5l2BSeOgg31thm/79MERR4NeZX3iy8w/nEDwCDjSWzPmSovYL3juOGdINmFd0Kv3hied
         3JGAj4yOK2HqTlQFOyWgczxjxa701690EzjKAiGDfrDGVm3veZt2Lc2G8Utb/zOqNe0H
         ljEzPhrZmYXN0cUF0+Pn6Nbd0bQ08hEr32PaUyxDg06VVW1s0QxXCBZlsuj6JN4AgIVK
         uyfuu/Uxw0Wwr/QXAil3wrKJKUkW5eTgOgHeD19IpvAt10jhwxrjYWPSGVXDYOnzCSQP
         fkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725647861; x=1726252661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0Sop3gGbpp7a02AwhDEi9yeUAD7zkHPXJcezmo9CH4=;
        b=rWcfFjdgwKELn627UfXS/1Zqgu+hMvt1e4lnFyHt8MDovsf4OuWFPdnXMjcjaAqOZV
         ubEU/u5RbBq9C/62fwZYJHK+xgG4ibXz5PeizcjizLMWNNLTVoUMhv607zgh6H6iYVvA
         yrtLgBooBK5ow5AxdQ+CLDNG5VxyAzlOiNRXgrAmMXMGCHsOWHzzqGfNlaMhVksgzYsA
         qZuFk2wTk7x9/nrVZFrA/rj01m9d/36IFjEbgGHp7GpJJwye6tn93nydS2AB6TGzAriV
         pTXYaWKToAGeIyCMZuymeqmvBGOkCl0NBOOOJ+Pt320ULWX1q/Tox/4IiT0L45OpvPLp
         8WhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrwTUStVBV2JDeY9EbFiloTGc50nvGuAh2I4tTFEDyoWPRB9dLT/WbSN1MkcmqShJwC/bZfKFL@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZvzpbedGVQlFXeUsDEa72nt+LxKliRuvnuHE+ikyuFtb5MwN
	QIB+ZWPuTSjoefwYnXoNxpcu3kHyP9UMoWnqrGQm+iyc4xMP+gCbimfOzje0yd1s/35hNTFUNEc
	DSBj5Qb/prbU+k2d9EugWjndm38HxcgiBXImB
X-Google-Smtp-Source: AGHT+IHjKcURSSTe8+mNfV7/rYJRSAMCbEJs8d/CYDWZBuHCRS3PlIcMmTQ+exX7EfBuG4GWLrr6QA4wI3Ns8dtM1Ao=
X-Received: by 2002:a05:690c:386:b0:64b:b7e:3313 with SMTP id
 00721157ae682-6db442e2f43mr37012147b3.13.1725647861559; Fri, 06 Sep 2024
 11:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906172934.1317830-1-masahiroy@kernel.org> <20240906172934.1317830-2-masahiroy@kernel.org>
In-Reply-To: <20240906172934.1317830-2-masahiroy@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 14:37:31 -0400
Message-ID: <CAHC9VhQ+2miDE0Z99ymYAk76_C0O0aAH07swwhSPWn1uCH9hBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: move genheaders to security/selinux/
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:29=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> This tool is only used in security/selinux/Makefile.
>
> Move it to security/selinux/ so that 'make clean' can clean it up.
>
> Please note 'make clean' does not clean scripts/ because tools under
> scripts/ are often used for external module builds. Obviously, genheaders
> is not the case here.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - Add more reason to move genheaders to security/selinux/
>
>  scripts/remove-stale-files                                 | 3 +++
>  scripts/selinux/Makefile                                   | 2 +-
>  scripts/selinux/genheaders/.gitignore                      | 2 --
>  scripts/selinux/genheaders/Makefile                        | 3 ---
>  security/selinux/.gitignore                                | 1 +
>  security/selinux/Makefile                                  | 7 +++++--
>  .../selinux/genheaders =3D> security/selinux}/genheaders.c   | 0
>  7 files changed, 10 insertions(+), 8 deletions(-)
>  delete mode 100644 scripts/selinux/genheaders/.gitignore
>  delete mode 100644 scripts/selinux/genheaders/Makefile
>  rename {scripts/selinux/genheaders =3D> security/selinux}/genheaders.c (=
100%)

Better, thank you.  See my comments on patch 1/2 for when you can
expect this to be merged into the SELinux tree.

--=20
paul-moore.com
