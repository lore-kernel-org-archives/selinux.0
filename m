Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792430594;
	b=GTiJ+DSxJJLpLlFoTmQvrOAhxUcvPqsvjx/MOYeNZtdRRTM7RXjprMlDuAkimwefFrNy
	 uaFdN8X012Y0MXWbcTTExXUNjwmPimDpmRiAK8D/+GmGblImgRZHNhwx3YCwh9Xg90aRz
	 ADTXvy23QaFMlK67oOgB59065boDsJh2rjR3mb4c3GsCyVJIJzePce1Xkdv36wcwG8wnl
	 LkgEPyezgqT1wybvHpx8rIheTW7NWUT/FneH28SRkHqbSFp4LME03924VBMLQwuiSjBYJ
	 CuDDwW8tvwzG9zL+1s8gWafDZd58kMzJksirjXZ3SBZ7A18jXUb7lzgx6n1XuHur66A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=XyDLh/OZ7L+0+0Z20pt671q5f2HtDROtE4kYqg2+KMU=;
	b=X8AY9+Ivs54UqSOv8KQ3sleTSr4uMjDhHLzVm+NB2kG+PllcdXh1yHttCLg3oRrtFu2F
	 VD95t9mKzUgHXaWZ+axJsD/0lwFtDyT97d2Er9BaTNzaZePJjqIGyQARp+YayXkwd7AdB
	 +mqZ+akA5zknohfDzFoWnwMsPyqTbtq/fWadDhVVICd/6ydu4SYTUdKV0jlcG4z/d31aM
	 Den2Tj/+EcX9LqGp8vBcbBf7VpREIzjGSWB5thNEtxrly+NHQzdmXkpkdIIYJN1WvYMGM
	 bxfHV/W3dXyXPxaz/BC0ACZhmakwa8WMV7AzjpnYqMNq4A7mGlIq8EaPdLdCExIz7/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="GPhRW/dy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399A606A31E
	for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 17:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9399A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GPhRW/dy
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-679334baa1fso2242325d50.2
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 10:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792430592; cv=none;
        d=google.com; s=arc-20260327;
        b=I+ik317zxNGRwyYS39MtevakoxGF4fqsx+OQsld3XZewWx7raO3l5+XCdvMufLEDG9
         U90vG/8X5KLneWrcVZvs9fB3THA82GYR31L7VXqGanFdthl7HwJMCTXyIx+GDPjO9/NI
         ScdX5HbH0RedqIvpq5CVNLVk/hucrQ/hbOMC2LLU2hgEKvPfkKiSERDILf3+6RI9RLsM
         pLj6+ZhzaUl2QHcUZuinfdBlKRkSPtjHZwnYaYID5u/6iOCUiYE1BQ90RpGgFKFimKLX
         ltaoYmF/AmvX4nOuvxrm4ALq8mlBHgdD9NmN9AAybABqoDpzG0GAhydlA9q+I4lTkxHe
         7Ebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XyDLh/OZ7L+0+0Z20pt671q5f2HtDROtE4kYqg2+KMU=;
        fh=dOK3+QzSPN7gzn1PlS8ptJJmK6YYk6mhFKVaSQ0dNqc=;
        b=O0sflhYVJCAyxpAHgyMUyH1tezApeXxJAvniEQT7DqqsX+hWfYY7wB1Gkg+DUmpYpX
         5BdgP+eqsp10yXyRnifTdeu9fRjd/OaCO2Sc2zIP418wjo0Do1WZBGRCgGae/lSO9gAk
         5K/cEdR0E5agePj7W4vE3lLXlZMX06cnQu5HTm0XcyyXeOOlnuPvYmxvRLqUahj4whho
         DEzqgqbngdgBo5Aw9ppbEXD2IOkhbufh+ZwvUa8hPwIp3K8hxyYYqIHDCnalsZIcu+/n
         0R+XaWi93DDuupdI9/QKr8cwPQ3o2ng44iLRq9dump+Bm8e4tZJQFdsgfEZ4VH+cI5+k
         3GGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792430592; x=1793035392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XyDLh/OZ7L+0+0Z20pt671q5f2HtDROtE4kYqg2+KMU=;
        b=GPhRW/dyeZTdA8MqpZ0+NnnOTSgyw3DF+1a6asevw5Lz7NLx3OlBHalILypuVSQbB/
         K+LEO/LeCCKli7nV8FGN0oL5wieHGUP2SAkZiTwW8orh5xnSqJkaOhCXOVU1OrQKuqQI
         DSF5JvPVJpZ/qStKJasesyWxqOAOs5++FiUAjmjAixt89JYe0KbRmZ+WhgUwsDde+9W6
         KXIx38yeTqLqmic2CrOCgzHp89da5QFPJKbGCBcgBz1UVqBSIe4S5un2NH6S2w5ZgrUd
         DO0ImCXi9NV+UsYj82+lytn7cUl0uMns6IMFBLZXlWGKS8qlHdxDKCr/iaDscK1gAfZ5
         +JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430592; x=1793035392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XyDLh/OZ7L+0+0Z20pt671q5f2HtDROtE4kYqg2+KMU=;
        b=2roFJtCEy9qlMjwni92qw0QnS/UwjS2upov/MlMsAQcaSS12Pq1DnZSo/f0S+yrUGw
         i0X672t3X57mUbOSufSt8vbJ41KuSajN0TYT715ssnhv6ZCUk/uE1WtCRF7liept0Grj
         CrQllIwTA46H39skhKfJHf2VciMP2Usng5zmHkm9f5KAcOfYECDLFTDbSkBSA3YdU3yK
         1UbFKdhZw5djN4D0d3MJ9hQCh6YodR8DPGDPQL7UVfvQdipdHbW3jhoARCMz2AV55hQ/
         yJgXYdJ+vaL6JSu2iZLsbZmZvT8EKS+K+PoQZuJeMy+4xQzJI7hzKahGVoSR+IYqdBVP
         hs9g==
X-Gm-Message-State: AFq9FYKIULDQ0kR5qV1lh5ggdRSEehQr66VFZNJSF3BaSRg4w7jFxEdb
	UOZ6gJnaljZj8l1MF15yYhQjLBBW66XPdNLamBb7M/ezh7EJuumI09SGJlA5k9LPlS2GrsgEUdP
	4sKZpcfPLjA8lMhixTEYdPiagek1qQEhmxNcY
X-Gm-Gg: AYBFou1zAq05GJIqxHOCyG8a+xZ6yjrFC+h3BeMI715LZ9I8QNCTzc2cWURHavFX2P8
	T8+J2q/c0SeJUiqDT8VYZqKFQPT+OeEINvFgmOnB5lwUNUGqcBmQAnMlka00peDrgc5Eog83j5a
	p4IIbSfnCUc2OEzS6hEiVxk58VKNThcdZW53Vc9VYyBYMJayEFLvY149e7VIMevbTyfHI3eMRUb
	WxPEDGj+KKeY+ZnV0F3iA1KC2BSQw/owQnyHrktXgdT8phmYLioj6zeKZUIpMjYLv0LWLo57nRp
	nJSgUPW3AwjILf+hQBq2r57Ds1IiRQCJwvfscuHLEg2GUr8UkXCQUow=
X-Received: by 2002:a05:690e:144c:b0:679:95cd:1aed with SMTP id
 956f58d0204a3-679ca85a67amr2013825d50.60.1792430592462; Mon, 19 Oct 2026
 10:23:12 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019140249.30088-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261019140249.30088-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 19 Oct 2026 13:23:01 -0400
X-Gm-Features: AclHuK8ByR0FE9TBIOdJl5yh0wvtLAwgJAQZEaLkEox3urYQbjt8GgVx9Kyisf4
Message-ID: <CAEjxPJ4tY5cpYMN4CwPoS5RN=+=P9RwzPiHGG0uTX2dRKWU-gw@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: omit excluded mounts from the fixfiles
 relabel list
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, Pragati Hatkamkar <phatkamk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:03=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Pragati Hatkamkar <phatkamk@redhat.com>
>
> fixfiles logs directories from fixfiles_exclude_dirs and passes them
> to setfiles with -e, but the Relabeling line and the per-mount progress
> output still come from every read-write seclabel mount. setfiles prints
> a 100% line for each of those arguments even when -e makes the walk
> return immediately.
>
> restore, check, verify, and relabel all use this list. Leave excluded
> mounts, and mounts underneath them, out of the list that is printed and
> passed to setfiles. Keep passing -e so those paths are still skipped
> when reached from a parent mount.
>
> Signed-off-by: Pragati Hatkamkar <phatkamk@redhat.com>

Other than some whitespace nits noted below (not blocking),
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

We probably need a standard formatting script for our shell and python
scripts like we already do for our C code,
with a top-level make format fixing up any divergence for those as well.

> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/f=
ixfiles
> index 45f2d5ce..e266da77 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -259,14 +285,18 @@ case "$RESTORE_MODE" in
>      *)
>         if [ -n "${FILESYSTEMSRW}" ]; then
>             LogReadOnly
> -           echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
> +           FILESYSTEMS_TO_RELABEL=3D"`filesystems_to_relabel`"
> +            if [ -z "${FILESYSTEMS_TO_RELABEL}" ]; then
> +               echo >&2 "fixfiles: No suitable file systems found"
> +            else
> +            echo "${OPTION}ing `echo ${FILESYSTEMS_TO_RELABEL}`"

The four new lines added here use spaces where the surrounding block
uses a tab plus four spaces, and the last line above therefore shows
with the wrong indentation.
Cosmetic only but would be happy to take a v2 patch.
