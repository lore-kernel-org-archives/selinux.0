Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481B4D8D98
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660791; cv=pass; b=TCvtLHhUH9yMI4zUGid/V+Nq61g7loHRhKy61bIPDTiYmC2z+Vn6Xd8JDqxjruxN4M9ZeNnOiB7YXMzfOc4W1JRwhCcPU+PEgL+X+GWg3HpAmYSejHNV18sCGzth80Nc0hTtvzqi0O+WCJKpNkklyuwaJ6u2/FqDB0gyRg8ClZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660791; c=relaxed/simple;
	bh=spkVl4wzFqCNtGKYBI2j3PLGLA+UtFXp8KuW5AYTaeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvtWSDU+PuyTcIbj+hWjRIWUxg84p6V3imyB7pYxuc4ftaRM6GIDizec0QcsPHqU59qiPEZg0pii5A50yCJB7F+K+KJwEVTb1ZM3TOquV6Gp0eMkgHGjVZFKETT60rriI9GOabKhLVhnPX/O2UHU3BDuPoPo7TZZaFrV5fSMODQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eme51Q+X; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eme51Q+X"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b903567fdso1743790a91.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 04:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780660789; cv=none;
        d=google.com; s=arc-20240605;
        b=kk26IwIzvmFwoeHXRhvImAeNLan7NK+D1DgcJyITVSZUM3ZibtvOmS37mN8B3G+9ZS
         alFSSEMSGOueIjf7Kd34WzVVTcb0ciyEhG1XFbEFLq9cyQ1fnGDsINoEZI1uFNCShxb2
         SBRN/t5Cfz+LpZ/q9fvKq1ok5df1po8seO6jl36y+RXrDxzLPENZtK7fm/y8SGE6jJ+0
         8Zta03OTJSfq5SStqDWTuYHm1KD6QHvAyVrA7AsIQh41InnNZrgHQoU3tlInY1RWVOIR
         Y8EEUBQmVe5Sp5e0iSknS5eYOAmZbCjQgcNfCKFBAIMOuqJGrA8qJCJZsIDQUMmdeyVb
         p0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xGKVvwa61dK99R6Vi0dbjcyvc04sXaqNqcpz9xFRV1o=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=L4yLtyNU52an4psOT6azyr8eT7EaJRIGw06uadNau3iPyJgc+6ubpZ+7jE1AdbuAlZ
         JENUV76GyfgsojywnaY72GCZSjXZSfUmKAudkxAB9mA6xkV9FW0Qgi8xvqZGmEfpkPOW
         y/JBhPbEd/VWZWOi3eZS/5EFQ7BQDKuG0JsKGLD9OGzflUyzgZm0a0uXWjuBoX8epuQO
         M5sAj0hUnjypUBC4X1x9QQdngcY1w2BhVE+eGQGSQNIyE7PJ8/HLRQhrbOPxi1H5Z2TS
         1DkN5/mYrsoZBNhek2envJno377Rns86tbLyIrXuo7UCwnM4q4wfKDJqqgVDlMKDG2N0
         nJaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780660789; x=1781265589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGKVvwa61dK99R6Vi0dbjcyvc04sXaqNqcpz9xFRV1o=;
        b=eme51Q+XBiTl6SHn7DLAGglHXXGalakHBGWodfyDgcrZhDQy9ylu8XkyUylLZUcRBB
         tV+X/9GwHBYtSDEnk7b6w5Dqc4ZSA0+ZOQongtgcXQu+kNi2wEVWEx2Cxh1jB6WuFazj
         fvZBUNU1NtVtHM0ApsOovr+kHQ9bhQgo/uYmAP1m2nnKiN7dX095BIpCg+lTFqBGMUNR
         wK3fvhJvmBSZRk0WPl0Q5pgtfBqI+Lk3ipE91F2HHibk7uuOhmx4da86n6oSGXJFjz6r
         axT7Hqo5oQzlOrEk75nrq+leUY6s4Wop7QZi/gtrk2gUbOLVcIRhDDrFNzrMZflqx6VH
         hNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780660789; x=1781265589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGKVvwa61dK99R6Vi0dbjcyvc04sXaqNqcpz9xFRV1o=;
        b=qJHgS+KvCx4Pu0W2xISYIKU3jMeimFUx1ocuRAuOgr9kNcCXx4h7hSLKGT2qbfKRqj
         zNbhTZ6kXous1Wd3sb7UJSpgpQ/Pz/1ekGCwSCgpdWtobl5s4hweynTV1eYqeJMn2qVp
         yWTxjtn1o1sjYgK9VLSN7pcOXVizTbNByhNhFvSZuS0cibggDqGHNEwBvJPvTtYyA1oG
         iome0nDOPhIVU6PQgFxAXOaW0KCU9OfdYALG3eC+wNzwvWNIbtdCwprf/Cm3K0EmtZEH
         xQeQFlVcBzld4VUnlsdohBC6K2FEB2zN+6JfYIudCjcynn0amNuuUzST2FhSrInlBtCa
         qkUg==
X-Gm-Message-State: AOJu0YwgdW5oDlLX0vkySxV234KU2xoUUekbx5ZSG7WxFoF8RRiYfUnK
	Y4U/DHgMl4VcW+lK7S18yyFBOd5m9Ed7GQteRml7B7eIA+4AuC8Upv3GaxptNngNbgCQ6gSGUSs
	kRDmtJAtaQrdZm0fqMaOiqZ9FGlGE1WU=
X-Gm-Gg: Acq92OH9zRey6N6kwh9WrjiDeUDNvISWEVM6+YxKKIP6hgMKhR4hpZ7LJKfQBvo7qSO
	tjL5bsbZwffKnSzbtLB8xsO7NMN7iyou33yTBQUrKjDXUDRaHNvPoBzh1SNz9Y+tMlEv5PoyHTm
	u5zkxENfj7e23G4cTvmqn2/CMxMOTj0ytTk/brQuLFPh/Rvt6n9LNabLnmoMHg8qeFA9k7QQDyZ
	+iYkhnusd56hx6LuqqxizEGtXU3ypxTd9WurS6UqJDH9RLehgwWetIsksg7QJ4wzs3/+EMIUaoX
	P8EGhWcXIsLEj0lBdA==
X-Received: by 2002:a17:90b:3503:b0:36d:635b:85a0 with SMTP id
 98e67ed59e1d1-370ee830376mr3226033a91.3.1780660789516; Fri, 05 Jun 2026
 04:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605112614.2397757-1-lautrbach@redhat.com> <20260605112614.2397757-2-lautrbach@redhat.com>
In-Reply-To: <20260605112614.2397757-2-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 07:59:38 -0400
X-Gm-Features: AVHnY4IZOQtm47SFjkgx1mJnCOEfonI8zDyfKDObBys8LrHLCsRt6wHoDnutHrk
Message-ID: <CAEjxPJ5EQroOXUgCKzSGwX26D0xjfF181bVh-Lsx6nLy4Wd31A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux,python: Use system Python3 build module
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 7:33=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Commit dfedefffbbdde609a7aacb1ef570c7ca1bb70915 ("libselinux: update
> pywrap targets for modern python builds") added `pip install build`
> command. This fails on build systems without network.
>
> Revert the install part and add python3-build to packages necessary to
> build Python bindings in README.md
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  README.md                | 2 ++
>  libselinux/src/Makefile  | 1 -
>  python/sepolicy/Makefile | 1 -
>  3 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/README.md b/README.md
> index ece18c394ee0..5e65a0495e39 100644
> --- a/README.md
> +++ b/README.md
> @@ -64,6 +64,7 @@ dnf install \
>
>  # For Python and Ruby bindings
>  dnf install \
> +    python3-build \
>      python3-devel \
>      python3-pip \
>      python3-setuptools \
> @@ -97,6 +98,7 @@ apt-get install --no-install-recommends --no-install-su=
ggests \
>
>  # For Python and Ruby bindings
>  apt-get install --no-install-recommends --no-install-suggests \
> +    python3-build \
>      python3-dev \
>      python3-pip \
>      python3-setuptools \
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index c62ad1edda58..52b2c621c042 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -151,7 +151,6 @@ all: $(LIBSO)
>  endif
>
>  pywrap: all selinuxswig_python_exception.i
> -       $(PYTHON) -m pip install build wheel
>         CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m buil=
d --no-isolation --wheel .
>
>  rubywrap: all $(SWIGRUBYSO)
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 4a4a351219be..518129805fca 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -14,7 +14,6 @@ BASHCOMPLETIONS=3Dsepolicy-bash-completion.sh
>  all: python-build
>
>  python-build:
> -       $(PYTHON) -m pip install build wheel setuptools
>         $(PYTHON) -m build --no-isolation --wheel .
>
>  clean:
> --
> 2.54.0
>
>
