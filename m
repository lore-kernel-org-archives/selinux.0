Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578939;
	b=ieG4tLH9B1B9py9JRCKCmsIG90XdHeT6RLONUXLmuRG3R8k9Bm3CRGQScYX78Upz6U+N
	 DBmZftPVWF+AjwSfd8yPg8/cCApfde/IWZDmIQubaBHpZBlXuD1Ti5g+JZDccozNVS8n0
	 MB0DUsZhBvQbwfJhkGYxgatgW0fOPR1f8jDEi6E5XVD8XEXhhn3e1pkmf1KRF77wzwn7C
	 EwQ/jcQqJBClJiEv7v7dO1iRz/rSx8NAIR6aKP4q1aDOe0ulOIj128In1vhJRbZCQcjJm
	 KqkE0T4LsatqM1sD6pmFQOdjvU9pfMtCd5t6sLkBFgjYRqyctP4xYQbHAnKcINQ3ydg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578939;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xodgZnUu84rTj+o8glxbj5oXT1Vi9XwmjHtvuYpdWRY=;
	b=ukH2xK2fuGC1D2N9siAMlIlwbL7M2oBqsZyiunF6fbi3xN9Jy5gpu180UH2pCxCcKvB/
	 S3fjvT0Ppxow4S5EqhhkMa4sI3y4p4scK1maaHC5ONXt+e+iDQEG3kS2jY1HQZewwmGjl
	 ItPyHwfYanEuLfTr/jQDazMR/F8ZEyRLK/3Bdap7Y82ar5ssKxQABoeJ2ig9g5pxVuoD9
	 RWLj35RjmsATvD9ETKRydHz6xTMV+TIdvp2LtLuoAAvQ3xsp44aac8QrMUmIUah25m2yA
	 KwWBNWA1GHdi0F3zuMCgebbiBuz6vtKml8wAx4b7mQhOGaGpgK7OmgnOOe2TIUGKhiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWiq5HeN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB097606A323
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWiq5HeN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9F21F000C4
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578939;
	bh=xodgZnUu84rTj+o8glxbj5oXT1Vi9XwmjHtvuYpdWRY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AWiq5HeNmQNHNV9aGquKBFeWjH3JTKwA+rxuaHm1Yz+bBXFplhCOZnkQr+zsHq8oF
	 6WR2jubR3zltCSc0D4Nx+E1tw1bi8tpZqIUo2J2APjPW/OwEyL2a7RUPsg4xPh5+4G
	 qUAnKno6LRiNAzjSYDilEJUGWA1Jjk/sb6NZWLKrF7umczYIhYwmyJC3Aw5Y6X3VU1
	 gTpc4g1XUT2dFl9WHvEkTiZi5cH8aP/1yX9uRIYIPZtEdBRN5lZHaoxBNkJcDcj26W
	 yZUD4nwjEcpGPMrLFqq05o3U+1nIgvGO8wbPypIVyxJYnaApXDansThJiDM5CAp5fJ
	 zzJ6n0a2lux9Q==
Message-ID: <sashiko-outbox-212961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2] projects/selinux: enroll the SELinux userspace
 project
Reply-To: sashiko-reviews@lists.linux.dev
To: selinux@vger.kernel.org
In-Reply-To: <20261113140145.91850-2-stephen.smalley.work@gmail.com>
References: <20261113140145.91850-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:08:58 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] projects/selinux: Dockerfile omits newrole build dependencies
  and flags
- [Low] projects/selinux: patch_guidelines.md retains template
  boilerplate and typo
--

commit e4b3796eb9b6ee214884a7fed6793943a0dfc672
Author: Stephen Smalley <stephen.smalley.work@gmail.com>

projects/selinux: enroll the SELinux userspace project

This commit enrolls the SELinux userspace project in oss-scanner by adding
its project configuration, build Dockerfile, threat model, and patch and
report guidelines.

> diff --git a/projects/selinux/Dockerfile b/projects/selinux/Dockerfile
> new file mode 100644
> index 0000000000000..ce909fdf5c285
> --- /dev/null
> +++ b/projects/selinux/Dockerfile
> @@ -0,0 +1,35 @@
> +FROM ubuntu:latest
> +ENV DEBIAN_FRONTEND=3Dnoninteractive
> +RUN apt-get update && apt-get install -y --no-install-recommends \
> +      ca-certificates build-essential pkg-config git python3 \
> +	bison \
> +	flex \
> +	gawk \
> +	gcc \
> +	gettext \
> +	libaudit-dev \
> +	libbz2-dev \
> +	libcap-dev \
> +	libcap-ng-dev \
> +	libcunit1-dev \
> +	libdbus-glib-1-dev \
> +	libpcre2-dev \
> +	ruby-dev \
> +	swig \
> +	xmlto \
> +	python3-build \
> +	python3-dev \
> +	python3-pip \
> +	python3-setuptools \
> +	python3-wheel \
> +	swig \
> +	&& rm -rf /var/lib/apt/lists/*
> +
> +# scanner contract: the checkout lives inside the image, at /src
> +COPY . /src
> +WORKDIR /src
> +
> +RUN make -k DEBUG=3D1 DESTDIR=3D/src/build install install-pywrap

[Severity: Medium]
Should this Dockerfile install libpam0g-dev and pass AUDIT_LOG_PRIV=3Dy,
NAMESPACE_PRIV=3Dy, and LSPP_PRIV=3Dy to make?

projects/selinux/threat_model.md prioritizes policycoreutils/newrole first
and notes that its privileged behavior depends on those build flags.
However, policycoreutils/Makefile skips building newrole unless PAM headers
(/usr/include/security/pam_appl.h from libpam0g-dev) are present, and
policycoreutils/newrole/Makefile only compiles the privileged audit,
namespace, and LSPP code paths when those flags are enabled, leaving
newrole unbuilt in /src/build.

Also, swig is listed twice in the apt-get install package list.

> diff --git a/projects/selinux/patch_guidelines.md b/projects/selinux/patc=
h_guidelines.md
> new file mode 100644
> index 0000000000000..7688835f95eff
> --- /dev/null
> +++ b/projects/selinux/patch_guidelines.md
> @@ -0,0 +1,13 @@
> +# How we would like patches made
> +
> +## Size and scope of a fix
> +as narrow as possible: change only the faulty function, no refactoring
> +
> +## Code style
> +format with the .clang-format at the root
> +
> +## Tests
> +add a regression test in a new file under the per-component tests/
> +
> +## Branch and commit message
> +against the main branch; subject line in the form 'component: what chang=
ed'"

[Severity: Low]
Does patch_guidelines.md retain placeholder text from the oss-scanner
example template?  The selinuxproject/selinux repository has no
.clang-format at the root or uniform per-component tests/ directories, and
the last line has a stray trailing double quote while omitting the
project's Signed-off-by requirement.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113140145.9185=
0-2-stephen.smalley.work@gmail.com?part=3D1
