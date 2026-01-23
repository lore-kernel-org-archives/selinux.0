Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39539318EC9
	for <selinux@vger.kernel.org>; Fri, 23 Jan 2026 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180946; cv=pass; b=XzMgrxNwRbR+OxOkFRM8HtjMJr56sgc90PKg50EQt4dyf+4W5UXlUEhYMxrNZ1rwQ2Um7GYkTjfelPjbHEQ7s3d5ehAjwqq5M19UZXzV4/Jp1VjmsihQsLBgl3VbmoamBZaSMXXc/UdvkmZ3NLZJaWYe3fDwWercwjyBwH8CezQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180946; c=relaxed/simple;
	bh=S2YeDSI65yRRxuyDtxUgMvbKnwfRSPjPz1R0PUI20y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jazQ3mBBTMwQKJkTdWBHsQvzMK2cHwWcrANCVlYWh7Wu5KDmOfOnZShL2ktrXKoNqbeL2A4CWRsyBRxi0W99BTm4gpnyRPDacznIF+JmP7Sya1pdWAdCxA7oyLkE+siOaIsgMX2qfixlqjs4ikUZI2c/ywJTaemBangWBB0OHDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjuYx9di; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjuYx9di"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38316445a67so19677721fa.3
        for <selinux@vger.kernel.org>; Fri, 23 Jan 2026 07:08:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769180934; cv=none;
        d=google.com; s=arc-20240605;
        b=PR/HRa5CuCjq/ErAIUtk7zJW9mFeHTLCvgh2VK/8bJCVRBL28zjxjMxQJoVncD86cl
         E51bznYolUbP2TDkv1tiUpVeCkN1scoOiANpx4GO4CFataXrlr6zVCFSjGEJr46cA22f
         HOn6seI+lmqV+ZCeAS3b6UchCQ+V+qwA5NjB1qpEOoqymiMGmMEZbrQQ6YOQKv51Ktn/
         h9gn3LTqQuZ88zJ17FQ2VWc0ZZ7CxGs6pywzaokiKbTWJnZ19hD2I6N0ixP/ThovJbjq
         0xYfR46WY4TC+dQ4HycxeSH0LzluaIzhZksI5wwLvCz7KObYaJ1g4WVVNvfrgK4UxsY5
         jrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0FzzC3u/R27U/pU5HyTt6U4K8VT0ok74FzfNzOBSulE=;
        fh=64kfzEJR+k3A/Bo0EjJbS2mTPctgdvPLOIBcE6p3LTk=;
        b=VOTwiGWarA664DyN0lTntkpImKl6VqtHJongZYNLYWj80rP4bXiboQIhPZbsiWirbZ
         UrkdT7kY+MwRyh6OFWtVyixyDYz1GjZHHtRvRlOZvXwE9cmfr1JWLTUj3SJFEq9Q5s+s
         uRmwEeooE0pfrQs/UulRA2bHb9J1jg0LJermNVtaHQEq2Kt6ayquk+7Dxhp3OD1YnC1j
         ea41MgzmNrYJh1B3EzTb6W+qbH6yLQL/w6qX2kwLACV6Qbm9Hm8zbXZLTt8zAhg6pUZw
         XNrjaR6dPjTywYRGDJLsXTBlB/kpp4gImuTab3C/xghskBAP/iilLm089h7l9A+cTeT4
         yS/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769180934; x=1769785734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FzzC3u/R27U/pU5HyTt6U4K8VT0ok74FzfNzOBSulE=;
        b=ZjuYx9difJRj8kLVh3lRNP5vbKRapD4XTimBRQLyoTdkYnbXZDSLrkYNh5cUtB882H
         gzWJ7WQI+cye60vXPKtPkLMD8pnqJa99UpvjMeCvDVg7KjzCsRI5+pEqMpSRK/1ed0HQ
         fINQi3lbM3e9SjkMezVZQbbF0is+twEBEkWPqLDGQjgWU01hLvZ6pJg6CIfCmBYVSwAL
         A8vlUVbVY+QA6qYa77xx5gTO22xV3A532/xPdC8qU6mtpkeeOSx2FR2n8rhCdDbI3On/
         NnkME2suvf5KI9qCtbicKBLoNVA1ku2LInUwMYbPL0sUpq2WtPned1Tk0+LD7AnnpfV9
         2UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769180934; x=1769785734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0FzzC3u/R27U/pU5HyTt6U4K8VT0ok74FzfNzOBSulE=;
        b=eIEo8eUcQCMvPhEtqKIm9fLc3t/WZ13NcRYCHHwv0zB80HLGNnQSsznB2L5WMw1es2
         mMtg/5fKbnSPoYriwnvzoj6WwnJrrjgItpN2I2Mvgp2bTkB1uNANnSMAkZTbGD0jTldK
         WjdKscPANzGadVG7AeKptALtFXZ90la59NMboYpaHK4njJIRFSsPUW+ghRNAHkBeVmJb
         A5EfbGJuXpukWAmRWhzAkzvsByGMYUmB818v6usrw5/tvPuxjraCJXZLz4Sp1DgjycUQ
         Nh/Ef2Sqqm/IqSnynP5MJaoCQobznkRhxAR0egishlKU6Mu+MXoLFEXeIugtA3BsuLAf
         JxIA==
X-Gm-Message-State: AOJu0Yzwf3X8nGK4wWAx6kNETLBOCNKwG6pBtmft4SBqbVyP7FOJfonX
	fRTXI3ZJyoVKS6B5zelGeEQ9O2JQmRWd2ws7th40YwKFzpYfq/MWLiaQEKkaUZmTN0dQIcS/TM/
	e/3YVvXGfIA8PSA6ls5+E7jQhVfAOkkZzuHEk
X-Gm-Gg: AZuq6aL988Xj9daRhzefhgMIadeaxhF1F8ofCdhmzkoN+8csH02Jt1sA+JrzgwatZKn
	c9qLk3QVd7SRHb4c8DHAc3cBENMb2sXrjiGoeQfJ1+eN2xYTRTIirA6g/ICDszxHg9iQ0B8ePBr
	gWgYE2ftsp5VhbP6bz0gZHQpEXCxkdGo2FybgjlqwvCwD9hFVh0sqSmORqN2ZXk6kTEdzGbJROK
	fOT9Eo5auhKsi5jgjrbfBCnN080axbIY5bQswBqqGSSNbUbVgT6ZbR7M5b0BIL+V9F+
X-Received: by 2002:a05:651c:f04:b0:383:5390:bc96 with SMTP id
 38308e7fff4ca-385d9e2cb1bmr13751621fa.0.1769180933346; Fri, 23 Jan 2026
 07:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227143911.1630813-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20251227143911.1630813-1-thomas.petazzoni@bootlin.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 23 Jan 2026 10:08:42 -0500
X-Gm-Features: AZwV_QiB93U2rOzd9O1eKK4Um1tCUBohnOhcHACA-OrDHATIiTL9TGYWBc9L3G4
Message-ID: <CAP+JOzRZBfW53JSN3kSyZdUtk8Hdv2TGKt567LMh0fFEOegrvQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux/src/Makefile: build python module without isolation
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Bernd Kuhls <bernd@kuhls.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 9:39=E2=80=AFAM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The "pip install" logic in libselinux/src/Makefile tries to get
> setuptools from the network, which is not correct as during the
> build/installation, there shouldn't be any network access, or
> downloading of arbitrary resources from the network.
>
> This causes build issues in Debian:
>
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1121121
>
> And in Buildroot:
>
>   https://autobuild.buildroot.net/results/0e9/0e9de0c0d8b6ec57eea9f8834f0=
2076b296ba4f1/build-end.log
>
> To fix this, we use the --no-build-isolation pip install argument so
> that pip install is allowed to use the system-provided setuptools,
> instead of wanting to download this one.
>
> This patch is derived from
> https://sources.debian.org/src/libselinux/3.9-4/debian/patches/Build-pyth=
on-module-without-isolation-Closes-1119155.patch,
> with the change that --no-build-isolation is passed unconditionally,
> regardless of whether $(DESTDIR) is empty or not.
>
> Signed-off-by: Bernd Kuhls <bernd@kuhls.net>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index f7412cd1..0dbba7f4 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -198,7 +198,7 @@ ifneq ($(DISABLE_SHARED),y)
>  endif
>
>  install-pywrap: pywrap
> -       CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip =
install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR=
) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
> +       CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip =
install --no-build-isolation --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && =
echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
>         install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__i=
nit__.py
>         ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYC=
EXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
>
> --
> 2.52.0
>
>
