Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9677331213
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109163; cv=pass; b=ZE/ldMZ8FUOWjUd30JwTvvl8XbgvKG3Q3ni9MkWr4NSzgxoLlUhB4krCnuoSG4Wy4eMhLiKzWNkqZD4JerTXzTMK8v9c3pCN7gIbBp/TsmYtufIkndDDQ4DPYJLeOAOoOf3udeR19DErpRlUcQN9mIxljdAOTtQuK9qkeoVslWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109163; c=relaxed/simple;
	bh=BlMmNhsJnBUiMRSoiWIzKxK/cgCZJ9/Fl49881u1UfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZbpbUiylBVKS5sPFxKULZwRCql1g21K5tsU3vnoNwKpwhZW+EVK0Q7RxK6MC5ygKSQ7dPzb4Vz55E+yNM9P3FDN7vEYI9kmrFEzEPHY6ieuV0NHAHOsTd4J+RxyE2ceyfVj9JJHfKvQstWRI3Qvv+90j3+5hX4u2DtQTWEQstU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfEMFEUO; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfEMFEUO"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-835c98b659eso1971871b3a.0
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 05:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779109159; cv=none;
        d=google.com; s=arc-20240605;
        b=i9Fw49CFLeSEdXR7ET5Y1axKpzHFtjC10t9J/TJqXqC3I5D5+lKKkea545w9kEKUE5
         RQKKLGitynXnzHVuNf0UAu+PHaiWt62XYvtj15sWrNLxRIHRPRSy6yJE7xOv0WrAdIG5
         o7ttT6j6l5meWyuRK740xbAaThOJmufjBbJvbTotSiRvNgp4Z+TcHwO5fn9t5gRrrGD4
         xr0/l92lFc6oqfmPi2m1jb1h6pLICY3p/ssPtqHM9dG2LACwjzN9r16XOdURHCu3UasV
         7WqhJCU/MkroNy8iXWIcf/8iBJVW0LDWlyYc15ThvLOVgQlEeGbABFle10/XPV09s+z7
         7OCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P7lGfFVPTrHxF8KD9AwUA/uZx3c/bnomEEUO0rYNo0U=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=iq3g8Wq/aJSTgSlOZq2ub5Cwg3Gn3jJvHYwN9m6Wp/Vx62xChpOuTn7J6qVpCf30on
         lJ5EPTxSxJthh4ACFx6Vp80swMm/TavCHPb47+BEEw7aeAyh1AQSJ8Tfku5IRb2QRSks
         yXopseOM9dq+d3D1K7676ErBXlGMjPxzCePFK+FabHrJ/gblBWd7z5UPJxTlITJQO7Av
         ZzHZnYG1mdxdqBViAfa0LJyX+HClkAxD7/00wDi+EWqgZFRtoaL23tfD1aj7kp2pKF5O
         sDqjfVnk03x8YLrrSFUdbnsxHeE2IdVWo4rpwlx05OMCJ0HOPCfPjO+q9UZBj6wJm0zp
         IJcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779109159; x=1779713959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7lGfFVPTrHxF8KD9AwUA/uZx3c/bnomEEUO0rYNo0U=;
        b=YfEMFEUO6HhnBcHLAQ42Zu6zzCRlGXvMi8z18mAm4N+6Y7D3xqKVtbE5y8Jhh23O9a
         /Dh4AgHYTn+p5CkIokyH+4TDTcc8GotrIb0V0H715YUBbw0OQ8Y0FHA0hxZfpfzzzQKn
         kHkUFAKPrp9HCE53P1e+h9IHUl0V/kIGIyWZIpilevziENDCxqvvp/rjWuct39qVv2C3
         tWXB0LyoDkrU3mohsVejfeCPC8G2tGMZuW6LrzbyO0nWnA7yJjLNc8qLNrRSG6rWSFut
         0mVy89DchY2berGwHqRbexuOMcekWVlJt7/QMX7xnPGDGNOzULZTUBAimR/mpnrmgABI
         326g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109159; x=1779713959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P7lGfFVPTrHxF8KD9AwUA/uZx3c/bnomEEUO0rYNo0U=;
        b=DG1RJMarDF4u/MwzOiKKXfJFrJkYVPunOQNg4Fkbtb3YOXl355XsZDVd8qqUcAb3so
         va8Jo7AZcSzerYfZ3conFTjzeqrTyB+l8xzOgxmtIC8Qz3IBu06vB8t/9M4ayRFOy42t
         RE328BEN7VedHyeYZssBJu6E+9Mx/pbT3NLla1KXdEWMQp3HzD0kW0xK/K93HbDDYBuy
         W4/GFjnlWgdsD2yyT+0pp9eM3nVpbkmKcWpnITVPIgTGGUCNiCIw1cd7Xli39JnEM3HR
         1GFBxMLkTq8Rn5r/Nh89fhtwYSxupe+LkSpkdIcqarzO93zDJR2j7HkQZJYwjdCCQ1FW
         6aGw==
X-Gm-Message-State: AOJu0YzT0Q/FKjZ5MX7N1+PDl8p+j9bj1Y7jwqHt+9CWrUjpJ5ZcKlXW
	kM2sb1cBB7E4buuV8XZlBPyq2/gq7yXgXPUioiAmwKRuNFzrvC2Ls2mEBUjgKOLeaAmITdjuFsr
	SC/0wXU0Xn39gGaREaJVE9f57QAI6AePzFA==
X-Gm-Gg: Acq92OHWM4oweatxmsFyUhsS6OOhGYwcCO6FuOIWwWUJnrbimIfJ0jOvi8tPGP4Kopo
	gAXgO6SXX1srToPAkf43rbrm7wd2Ylw0WuAP1fL6YZfeHWtHgq6xNFvZI6ngD90FjH5lHMA71Na
	rIVzD9No9zoxZ/QFzttgvJWAlZVJEFoxD8tPKQ97YTFxkMQHt0Sw68gGBl8lT0Pod2XpDg2KOLp
	WLS6eD6hmSI7JovNEeagBoHbdGtUt72Il6BEfmkQ3Fz9OlG2Zms5306ugO8MvXJcbUHltXmVA4K
	8kEPwsk=
X-Received: by 2002:a05:6a00:10c4:b0:837:a211:4ee3 with SMTP id
 d2e1a72fcca58-83f33c32a24mr16168914b3a.8.1779109158898; Mon, 18 May 2026
 05:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518115742.352949-2-stephen.smalley.work@gmail.com> <20260518115742.352949-4-stephen.smalley.work@gmail.com>
In-Reply-To: <20260518115742.352949-4-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 08:59:07 -0400
X-Gm-Features: AVHnY4JSNcrwGrOc7Lnxxj_ZrDT_pOmvemHp00N75yXumiKzrgkhgvsQhcGZm-o
Message-ID: <CAEjxPJ7GeHjVX-21eZe4ApR0b4kw4_R_FLd1A2FqSCBT-GqKiw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] python/sepolicy: update for modern python builds
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 8:00=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> setup.py build is deprecated and no longer working on GitHub
> CI runners.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Both of these are merged. This fixes the GitHub test build failures.

> ---
> v3 drops pyproject.toml since it is unused currently.
> My earlier attempt to convert setup.py to pyproject.toml failed.
> Therefore, just leaving setup.py intact but updating the Makefiles
> to invoke the modern python build module.
>
>  python/sepolicy/.gitignore |  1 +
>  python/sepolicy/Makefile   | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/python/sepolicy/.gitignore b/python/sepolicy/.gitignore
> index 32fb47f9..80824997 100644
> --- a/python/sepolicy/.gitignore
> +++ b/python/sepolicy/.gitignore
> @@ -2,3 +2,4 @@ build
>  tmp
>  *.bak
>  sepolicy.egg-info/
> +dist/
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index ccb22fe7..4a4a3512 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -14,11 +14,11 @@ BASHCOMPLETIONS=3Dsepolicy-bash-completion.sh
>  all: python-build
>
>  python-build:
> -       $(PYTHON) setup.py build
> +       $(PYTHON) -m pip install build wheel setuptools
> +       $(PYTHON) -m build --no-isolation --wheel .
>
>  clean:
> -       $(PYTHON) setup.py clean
> -       -rm -rf build *~ \#* *pyc .#* sepolicy.egg-info/
> +       -rm -rf build dist *.egg-info *~ \#* *pyc .#*
>
>  sepolgen:
>         ln -sf sepolicy sepolgen
> @@ -26,8 +26,8 @@ sepolgen:
>  test:
>         @$(PYTHON) test_sepolicy.py -v
>
> -install:
> -       $(PYTHON) -m pip install --no-build-isolation --prefix=3D$(PREFIX=
) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-d=
eps` $(PYTHON_SETUP_ARGS) .
> +install: python-build
> +       $(PYTHON) -m pip install --no-build-isolation --force-reinstall -=
-prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignor=
e-installed --no-deps` dist/*.whl
>         [ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
>         install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
>         (cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> --
> 2.54.0
>
