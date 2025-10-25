Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27A27FD44
	for <selinux@vger.kernel.org>; Sat, 25 Oct 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761383713; cv=none; b=O2EobTcbgdcJ0XEOx5+P1HCuIuE8N/OheUD+tPJp5adWF+iEQbZ770KsO3xKKxyul6anXCd3fCVsr28JMDX8XNwuIyojbWJopiWqeBy/HrnqayFDx8/0kzvdzjr1vEx/ik2oxKnon0y8pQXcqZg0DOMZMfHdy0cDxcgGxX4gHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761383713; c=relaxed/simple;
	bh=za9Cn1W7jhxHGcbkQFaCUwXr2ECDPJ7lbxsXF/ploVE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VPHKMqptXm1JyS7jARxKSCMVd2R7RBPD8d7mW+Zm5t96dX46Y062T9dXLvg+u5kig9v49sj+Px8ijpc7J5s3w/ojIaFYmCYRI2QEWzKjcY1coPaOhmvcEw+nTcVk1hPjaHx97XzAD13pbJUAOSvxWWtyeWsCWkC1l6MLGq+xbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BfXLIqM7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BfXLIqM7"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso6553100a12.1
        for <selinux@vger.kernel.org>; Sat, 25 Oct 2025 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761383708; x=1761988508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za9Cn1W7jhxHGcbkQFaCUwXr2ECDPJ7lbxsXF/ploVE=;
        b=BfXLIqM7laIZh2ZwJSUImoFiLogRJklO1Ig5fwVoM1k+tRijpLgp+UBzLIprVzhcOl
         Fltikr4j/yM1d7ueeEqz8SJNczTjgUXhG/2wq0V2I2uKOXpf5YK0IvApBAWKUiHZ3IJV
         bFJFuIePH4jQFr4dp/pXaBr3VmLBBw8HJlR7v6Lbf8QMrFfNS0+rxe7WQhKej1Y//fln
         92KwH5c2GXHrbtqcFXJiAZVqJhRbpq9YFgQQosiZPBh5raL50aQYhbJvL+Eg5Sq5Sxc3
         azRVA24Zoq2AcKno1agVjZpv5ZJzZ8j/tDXfR2r5hDWaWT/EM9rpRZholfzl0gEVOc+T
         1PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761383708; x=1761988508;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=za9Cn1W7jhxHGcbkQFaCUwXr2ECDPJ7lbxsXF/ploVE=;
        b=hf0YAFETOvK1/Gd+BKeCM5gJ+XX0c6D0Zy8xKMnfflA6DcrmR8oT7LkFUuTa/PQk4t
         1XASu1nbet/l+Vla9nApvOWqLGRy83f4OmStLQ+odgsbqiOjMFSn/u0+vHLTuiZ+QbOW
         BhyB5OMOfkP3ZiQNanBtWCRHJvBIcwWto1fYVAKoQT2H6/KOrspgUb6SNwuXFGW4ERCT
         LflfxXQnK0ju1sCAT1QDSIMmSD8ekcUUrK1I0n1Y8bXrgPeBeutqrTZ1FtXKiSZ2Uq+r
         wCvFAnalQJSRJMqmVNpFDu+5lTqHUSwXBNwNVlA7cIvwIVJJ6O+SU73UZaykWSFDmmUo
         NRhg==
X-Gm-Message-State: AOJu0YyYsRwQ4XHVPSz3H0MIfrchfwFIkYwOGc9rPoIujKjHouGL5Yd/
	dLIyVDFu4f2sCyyMoX/fS3uFt3KlxkbqE9sbccyrQjJLJVn9FONmsM0b
X-Gm-Gg: ASbGncvjgHmwRopVpJqgRW/PI+qY+Xr4dpMKsVXVcOxklI00f6AAL12Z2B0tdiGKQUB
	1zJv+rb2yKZ2XhYYhmzCoaIWa4f5qvJHVtuWl67/pxWJIQZn3q8nY73mb9Dajd+83KFVxA7S6t6
	dGkzdSLYTByx1v8swmOPNbhIHP7qBm7k3nG3xALMKg8MQXpZrAwFIm2iiUuF4tqliVaUn74K5Qb
	6RbIpW5PrwC3fnnN97p5L1ag8ubVfgIrJetMXC8u6lRBVKpZw6i0DPGe8nNjHWCzmY7TECXy3p2
	+J/cA21r8B7cWC9SwGjoFmxhJC+VgzQ/8AVGUxaaUYJ9T6zLNitRCxmXQrw7jKozInqo4EHb7Il
	xduH06qoXS5Vx+bz8Yyz1g/A5tk3SCQ3LakjSLETIZk9E3CfxQ6oK6lRHhNBMy2vQvzkgRPcJzh
	ugFFqynCXjwSY5dNNFAJ64A/JQpVQdL2J20B1VWemcHd0oRYHeu73ILApFEwSj
X-Google-Smtp-Source: AGHT+IHAAZIhmDIU7zCmeua4Y1pkvOc8nbIUXTSKm7SUAB7pIQN7E+tBVRPAnOOYMyWyQnkJ73BYnQ==
X-Received: by 2002:a05:6402:2111:b0:639:fb11:9935 with SMTP id 4fb4d7f45d1cf-63e60084063mr4560293a12.4.1761383708072;
        Sat, 25 Oct 2025 02:15:08 -0700 (PDT)
Received: from [127.0.0.1] (213.209.99.84.static-pppoe.dt.ipv4.wtnet.de. [213.209.99.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8530905dsm154096066b.6.2025.10.25.02.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 02:15:07 -0700 (PDT)
Date: Sat, 25 Oct 2025 11:15:05 +0200 (GMT+02:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Message-ID: <2b6896af-0fa9-4498-b33d-aa6729d320eb@googlemail.com>
In-Reply-To: <20251025083916.56013-1-nvraxn@gmail.com>
References: <20251025083916.56013-1-nvraxn@gmail.com>
Subject: Re: [PATCH] clang-format: add check-format workflow, update
 CONTRIBUTING.md
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <2b6896af-0fa9-4498-b33d-aa6729d320eb@googlemail.com>

Oct 25, 2025 10:39:40 Rahul Sandhu <nvraxn@gmail.com>:

> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
> .github/workflows/check-format.yml | 13 +++++++++++++
> CONTRIBUTING.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> 2 files changed, 16 insertions(+), 2 deletions(-)
> create mode 100644 .github/workflows/check-format.yml
>
> diff --git a/.github/workflows/check-format.yml b/.github/workflows/check=
-format.yml
> new file mode 100644
> index 00000000..a15cec05
> --- /dev/null
> +++ b/.github/workflows/check-format.yml
> @@ -0,0 +1,13 @@
> +name: Check format
> +
> +on: [push, pull_request]
> +
> +jobs:
> +=C2=A0 clang-format:
> +=C2=A0=C2=A0=C2=A0 runs-on: ubuntu-latest
> +
> +=C2=A0=C2=A0=C2=A0 steps:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - uses: actions/checkout@v4

Latest is v5

> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - name: check
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run: make check-format
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> index 7ec8cb0f..98467d5c 100644
> --- a/CONTRIBUTING.md
> +++ b/CONTRIBUTING.md
> @@ -53,8 +53,9 @@ When preparing patches, please follow these guidelines:
> -=C2=A0=C2=A0 Separate large patches into logical patches
> -=C2=A0=C2=A0 Patch descriptions must end with your "Signed-off-by" line.=
 This means your
> =C2=A0=C2=A0=C2=A0=C2=A0 code meets the Developer's certificate of origin=
, see below.
> --=C2=A0=C2=A0 C code should be formatted using clang-format, using the .=
clang-format
> -=C2=A0=C2=A0=C2=A0 configuration file at the root of this repository.
> +-=C2=A0=C2=A0 C code should be formatted with clang-format, using the .c=
lang-format
> +=C2=A0=C2=A0=C2=A0 configuration file at the root of this repository. Th=
e targets `format` and
> +=C2=A0=C2=A0=C2=A0 `check-format` are provided by the top-level Makefile=
 for convenience.
>
> When adding new, large features or tools it is best to discuss the
> design on the mailing list prior to submitting the patch.
> --
> 2.51.0

