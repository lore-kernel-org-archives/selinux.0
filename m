Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB71DED63
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769998874; cv=none; b=VANDcbnWqQoZhaHCNsZdePXqsd9gsj53kbJR4DDhQe0C2bwpnLHfeZw3biH5LrgTEw7Cg2bSxJG0n0h681DvEStSCzTtdjV7L6j1H8nv3jlYUiJZI+DOYs9zvENkZrnVJiD9A9cMHkYtNtLwdZRQpTNyxclz772MP5Bsq9xMigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769998874; c=relaxed/simple;
	bh=JLbbBGBMTBwg16kYuxnH/xxmxbL4TUOMuBXANCKt/oE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctKoYiASJY/z3Ga8HOZScdZprFU+vOvssNPcElibW3rsLOHgVTy9KH+z6lAFKXJeO8X377Gg5uH8Qqz/X1Gijij1XLqJwyS9xfK2aWnwDEEWaix0O+RaF3jPLPlvEwbhuTLR196bPBcWkZ+5flDE6lHTT8T61Yd1+v9n6dTDX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b=W37NsuTb; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b="W37NsuTb"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5842937eec.1
        for <selinux@vger.kernel.org>; Sun, 01 Feb 2026 18:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20230601.gappssmtp.com; s=20230601; t=1769998868; x=1770603668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLbbBGBMTBwg16kYuxnH/xxmxbL4TUOMuBXANCKt/oE=;
        b=W37NsuTbeygVAS1bxb83Pu6dCBQDnBMw0xP+fQlojM9sGiysC825FZKhXaQPsEnXXg
         mvI3Qo3Ne+l93Xk+aH3PTce/SzcV9Z/6s2Zuv30tkuiZ3hwRzjlIqndlrcRY6bVGkxUx
         bQCAHAzMA0GkYDPCDvV3wsQpUNUdxYjqDqXKw54KqnegNpxQkbTAwb9Y6QtmryicncSz
         agauqDKyxNiQaEQXd/ePX+1hoeqIi3mnOSKPX6RmKWBtWN4h3EENMqzcDpqJtKI8gcl0
         4TNKzYaLBrrs1XU0NSTL9RRJEa5cUrVvjOasN2EIO9w/XvGRaPq6ovajrevNsg4OjXLP
         Al+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769998868; x=1770603668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JLbbBGBMTBwg16kYuxnH/xxmxbL4TUOMuBXANCKt/oE=;
        b=sdysiKUd5y0K9Usnt4qn842kj0X8vNB38Olj5ePI35Vv4aBzsT0SKJG7/VSBpECNXV
         xIEkecgQkjwl9BdFKKcllQhIOwtuoLb+GJwDr0Vz8igfMkBvVOcyFoSdhpHiFvGIJ43j
         816bRtYOXeh92E6N/TENToQw9y8fI+Si1wAvI+h4OEJddH8AeXqy3flnWxQI4FDzf4Wk
         W/55/CzuErOw7SltTOyKX+p4nD7TyQKlc7Lx4yZM345PfHLAP3j160yT4kRsiqPYsKln
         qkNUfj3z6scuZ3j664CbQmFmS/bvjRezo2RJHLwJSkc/blcY1DBqND4U9kVQGpK16ZtP
         pCPg==
X-Gm-Message-State: AOJu0YzXUdF6011vhMoiJ0t22m+npRUJyUSIOton7JtMi+fXNTGaDoQ1
	WPilDK5HpCvbtA87y/webk3sFglUSByGVeIXyjB43ZjVzOMY+PXR/bGRaxwhLPFuJwoar4cWJM5
	rqc/l
X-Gm-Gg: AZuq6aJoMIPUtg1bWXDyxRbiG3gcvkZAz5ZINfm32WpKntUbQEWVG8mpFJPzbzl0HdJ
	4RX9DTEpbU5HuK+GZnNO6E6cZ9BZfmEKe2vqpZKNBV1TbI6lsAAzGVn3xWLLvjvyNY7B8Ut0JP/
	/A+XYX7NACSHRCTGpRUD3pNqLCXMxO5amBfpG5It22NtW37atuQbKcZLvfY/IsJGF7ROAovbk45
	PWJ1gHXkeyntIAsx9+hStD73d+9dL4gdwFwPDMWiEwixva4Mrs/M+KHCb25XYjc5i0WQEdTc4jL
	txfpyAqss10c50dal9t5fZNU6thQeFvhpRHcSQh6L8AJYmy1GT6HXHKuFnwaJVqC/sxRTPNuD04
	Qy12HQaNmEGu+bVZCJy5gjF38LBC33m9JHkTCMqYTWOphExzV0RoO+KVTdNBBfRghi712SqTFpz
	FHcJBQzMoM8fO7mywlX48+z/bJ7O6zCZF++bpGhYAWzM9V9wc=
X-Received: by 2002:a05:7300:4354:b0:2b7:a3a9:9c2d with SMTP id 5a478bee46e88-2b7c86550d8mr3774268eec.10.1769998868250;
        Sun, 01 Feb 2026 18:21:08 -0800 (PST)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b7a1abe57csm22318095eec.22.2026.02.01.18.21.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 18:21:07 -0800 (PST)
Date: Sun, 1 Feb 2026 18:21:06 -0800
From: Jason Zaman <jason@perfinion.com>
To: selinux@vger.kernel.org
Subject: Re: SELinux userspace release 3.10
Message-ID: <aYAKEjlKxwVWGgrw@anduin.perfinion.com>
References: <aXbPKpbIXh7_fpTM@anduin.perfinion.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2zXHIiXd7NeLdE7"
Content-Disposition: inline
In-Reply-To: <aXbPKpbIXh7_fpTM@anduin.perfinion.com>


--d2zXHIiXd7NeLdE7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All,

The SELinux userspace 3.10 release is now on github:
https://github.com/SELinuxProject/selinux/releases/tag/3.10

Thanks to everyone that contributed to this release!

With Kind Regards,
Jason Zaman

RELEASE 3.10
============

User-visible changes since 3.9
------------------------------

* libsepol: fix TARGET and LIBSO on Darwin

* secilc: use correct long option name for -X

* Fix problem with bounds statements in optional blocks

* libsepol: Fix processing of levels for user rule in an optional block

* libsepol: Fix problem with handling type attributes in role-types rule

* libsepol: Fix expand_role_attributes_in_attributes()

* Allow type attributes to be associated with other type attributes

* libsepol: Support functionfs_seclabel policycap

* improve semanage man pages: Add examples for -r RANGE flag usage

* libselinux: fix parsing of the enforcing kernel cmdline parameter

* seunshare: always use translations when printing

* treewide: add .clang-format configuration file

* setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC

* libsepol: add memfd_class capability

* semanage: Reset active value when deleting boolean customizations

* python/sepolicy: Add support for DNF5

* sandbox/seunshare: Replace system() with execv() to prevent shell injection

* libsepol: Tighten checks on MLS range and level when validating

* libsepol: Fix potential NULL dereference in policydb_read()

* libsepol: Fix potential use of an uninitialized value in link.c

* libsepol: add bpf_token_perms polcap

* libsepol: Fix possible use-after-free when expanding attributes

* libselinux/src/Makefile: build python module without isolation

* restorecon: Add option to count relabeled files

* Bug fixes

--d2zXHIiXd7NeLdE7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQKvBAABCgCZFiEE4WLerRzN0RPwSz1JK77Zyxpo71UFAmmAChEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRFMTYyREVBRDFDQ0REMTEzRjA0QjNE
NDkyQkJFRDlDQjFBNjhFRjU1AAoJECu+2csaaO9Va7YP/RGELp2Ga0SC0kcS85pT
0N8Vzd5wVSmE5Z6BG5LWpRzqNrKJOoVWB+iKRukMrevFhAI0/c2ZC/BcedTJw1w7
MSRS++NYmg2A1BUQ7rPipuqGL/i9dfYobgNyq0zPKdm5BCsdx25SJlOqM9dewbMr
c5gkQXwaBcXb1LOG7gyM9Kit7H0PPt7pOumEGQTzZROd+jaxMUHGazRvPsv9W1bL
xcyH1x+Z0I5pmfvCVTzKEpfmtyt4/5k84Y6tU/zDiADDKBuf2JCGbnfP2Q138FjZ
TuMtQVBZPcFnoRD34yL/SI/EdESm0X1kxbzabH+C18InL93eUPH07WQtarlnONzG
TvMvrzeFfJ8aO23G1PlRRFHIxyi+u1Kz46mqYsrqS/k9WFcFPGwDqB5Fs2SE3grj
7+k2J0VfWDWOvLZiEisL3uBMoOmOJduEF9zkaYlObnLbZVUa2SmAiMF3yI4YIyXa
PFMik4WYJ9JSuJ3FfGt5IZ3m9NJd+yrJw6pxZC5FiOL42mTFgW0lE5lzjluogf8W
CBxNDSyWPG0ai2UfZISPXgyG/VRJvSwSt1yA9SrWM7+Y5jvuwiJHBRijEsw2jc/q
GaV7q2xdpRn4kGodmgzn4+AdcUyfPcvbuQugAnWCWTvJRAB4D4ro1A7swV+1Mx6m
H/myMUwYOyeKouNJ0JJVyYYM
=TNP+
-----END PGP SIGNATURE-----

--d2zXHIiXd7NeLdE7--
