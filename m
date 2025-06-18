Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0032EAB62
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260419; cv=none; b=ZzjkydksHPKdjuPu86nyI/dMr7U/5oHtU3r6Q36t3JFEztsD9yix1zfPXEa4XzKWjMYIdtUEtmVElOVmnPLvBXA1Ll/4vGmTIR04BkZx7aqgM1SjZjax1wMIZ/uCvJgv1ZKnxE0jmBjVcqkTHDtzvBz7Y53v14OqM1HwEhpZ7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260419; c=relaxed/simple;
	bh=TsCR5oDDlZqG5afm7jH9wdrmUpldRbbmWnky3NFFbIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPjXUa2v1n9Qm0euW+o8nYnrYP2HxiUxh/QJC9cvET2102jxUci9FcQ2sb8BGiH9pfpctYwDKVQ4XT1v0OPQlYEiTZth3diyjE9GjuNicFICtUFzuOQNzsA8TCfHO64cqb+9HiYkahlr32SYScHwyJkLaih7IAdZhVYWFxSdEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EORtIwyf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EORtIwyf"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237311f5a54so12317015ad.2
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750260417; x=1750865217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q86emBzn0pmzBMm+tTYJWMTUKLSDRXoR+ohwg+EgRmA=;
        b=EORtIwyfw+BAppN/Oj8Jzv3xzzfS0dyjqPAz7jpXp8hQh4uMy7BDyNhjQ5M5v231At
         /bDy+2lTUqbCp/5gP5u6UMxEht0y+vquXEOBbhGZStVTxMSysha3+URaBWknvg9nqM0I
         IiuXuovPBPCfbUMdhV1ABzDRaUr2yHFUQzNbyjHQsk8rxO9crQjkWu2zLNAuebQJPoM9
         plgrV6e5xRjdpl0YYhWpJx9ow2wG7qE5WblmYTxLI7J/D0e/OyUBTl9tnKCPBHaEuQ/R
         q27R093Xdqex8m4Id4F1ae0raBsTYEunqvCdloX1g/IuItN+HPfeNjUVNRwWdRUEW7ac
         cuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750260417; x=1750865217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q86emBzn0pmzBMm+tTYJWMTUKLSDRXoR+ohwg+EgRmA=;
        b=BcvtJuF7Qy3o6KLgFlGLdG1FBG5apBz3RjInsviJD6AGq5Mm0N9V5VtzzD0fnz1cxt
         WI5Y/fEW3MJu5fhwMYaowGln6k6XFUmZYgkGlTW1tErXRnj6l2+11GkXQaiEHmpfWENf
         SJMylGFzvycODqSAA0/UAJyAS7i7uyDXCXSDgcI8SYNoMWkXz6YcQMIHRotacRksjtxd
         ZebcRbmPBJ2uzzixvOEEPzfNz9d89NrN2cEO0a7B5Li6gdMlqiqSoCZTCmCkNU2QE+f8
         9bFSmk3SzyXg59xUfZc7dCOkXRZ5VB8b6dL7FIloPKAxDbnunvxBtEpZqj1wfQXPOWMm
         odZg==
X-Gm-Message-State: AOJu0Yyi8XXN9JYMbzAWLvokH/uGcJ/PaPr6/2ZVP/zJAvfMM+YfkXzp
	epaRk6pJGtLijP+hqZyqv3ep94I6qsJNJzEhKEwA5zdeWS3Ns5oa/5n0DOxWoX76wMw5qVaF6p5
	pFa0DZ6keXtXWRNlpXV8M7lUkh/nx3xtq5g==
X-Gm-Gg: ASbGncuWAlAO+DxZ4WzdmZRg+/W+/9pExEhxuvsudjzo9hGMoWIR32Vwi2Ur9EFvmn+
	rplUzgvB7iaBRYfVTPFLZnT67WCnyEX+5j3cY1rLTD2N+sD5sK+Xu3H2L9OayZad0Cdwo1BMBIk
	yUbkUmNtHlH7L5re9F/MxqHNDXvG8BWH/mdtVCb2wav7M=
X-Google-Smtp-Source: AGHT+IHjTcN/B1NyubYf2n6tNOqHXAD5pM+SU2m9eHu1TSecejoMBa2Tt4ZU+a/ZijOcApz+PLF97ke4mvVHjnm3gMg=
X-Received: by 2002:a17:90b:2fc3:b0:311:a314:c2d1 with SMTP id
 98e67ed59e1d1-313f1c6f665mr25622701a91.6.1750260416684; Wed, 18 Jun 2025
 08:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613154343.25702-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250613154343.25702-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 18 Jun 2025 11:26:45 -0400
X-Gm-Features: AX0GCFtId_KZ8VvzfEi2dQ7Dv_briba128ucBNaA97_Jyu93CkLgMlHblqEA6cU
Message-ID: <CAEjxPJ6cdw6K+YDhBz8z+DvD6KS4rexoOik=9Dh13eX30-0i4Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] README.md: update dependency from iptables to iptables-nft
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 11:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Going forward, testers should install iptables-nft rather than iptables
> when running the testsuite.
>
> Link: https://lore.kernel.org/selinux/20250611183234.10255-2-stephen.smal=
ley.work@gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This is now applied.

> ---
>  README.md | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/README.md b/README.md
> index d24a3cc..f067eeb 100644
> --- a/README.md
> +++ b/README.md
> @@ -51,7 +51,7 @@ similar dependencies):
>  * libselinux-devel _(to build some of the test programs)_
>  * net-tools _(for `ifconfig`, used by `capable_net/test`)_
>  * netlabel\_tools _(to load NetLabel configuration during `inet_socket` =
tests)_
> -* iptables _(to load the `iptables SECMARK` rules during `inet_socket` t=
ests)_
> +* iptables-nft _(to load the `iptables SECMARK` rules during `inet_socke=
t` tests)_
>  * lksctp-tools-devel _(to build the SCTP test programs)_
>  * attr _(tools used by the overlayfs tests)_
>  * libbpf-devel _(tools used by the bpf tests)_
> @@ -78,7 +78,7 @@ following command (NOTE: On Fedora 32 and below you nee=
d to remove
>                 net-tools \
>                 netlabel_tools \
>                 nftables \
> -               iptables \
> +               iptables-nft \
>                 lksctp-tools-devel \
>                 attr \
>                 libbpf-devel \
> --
> 2.49.0
>
