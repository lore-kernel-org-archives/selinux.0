Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E22CCC5
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966167; cv=none; b=mAWZLDLI2i9J1f/5k9xjYDKudYXBdBW1N9eEKayBg+RwuUy6o2oSSr+JZa6c15WqO4IEk2iyuGTuv6MKIuZZyX27n0T3+znwMCFFfE6ajU+450V15tzehkj9PdPnZ3+TkILAiRnDnhT2r0CuKzLFhL80YlTREFqwRmSpRfn9QiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966167; c=relaxed/simple;
	bh=KTM/SaUjnbgUx9nduzyEf4n89MV8gT97jAb/MJg/OXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t94H0oagNMMDlfHAaixiRMoN8tDWC2dHLmhN7DDzSUhB56I6KGHEjtzZqhugTwS99AfpHmVMnGV1BTiXZy/kWcKWAgfK2Tm+nhCzNjtpQSa2GQ4fo944bKfaH0oZMWSFZnnyKuxmllgqq4q3OQaAeoay/OwZyvb/7avB2M2IZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYQSwh+b; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYQSwh+b"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-79af647cef2so3703847b3a.3
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760966165; x=1761570965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPCHXVW2nq7/RtzP6gVmj3X/4hQw637qhdxzpb5UKrI=;
        b=LYQSwh+bNLcx6DCLvwit6/EiOoORSuAiCdBlClgi2zdkstnJommNNF1WwJrGlxBVet
         N8KAjnuBBFXzWWOOfmL6xgyAhf7RkRc93K1R3hQm6LCSOjk6LDvbyU5Y31h33MSPtvVI
         /R53KDlknHW3ePJJp9oQrhzFHPOLcoJTZIcjjVVdKiXLmCuZUbnp+iHmr3U+ImwLq0K/
         LU7eoNqCuiTqivbA9Fl79KcQ1Ryr/PeYM9DlTwUReS3ODBTn6rLBj1MqndR3vVfYlmbD
         M71Smypc76ujSUyNiwexv2AR3DM8mqFn90d+VJpZn5aYlfIyyoeTQ+5E4qpmljP0KlLp
         4C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760966165; x=1761570965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPCHXVW2nq7/RtzP6gVmj3X/4hQw637qhdxzpb5UKrI=;
        b=E+dImklJgMu3kexQ16Moj63vhBASgqVe9BYR2MaBFqjt6zGM4PQLMHxnmDLQv4/0H+
         m0p4uy2/asvI1n1dnfh27hYC8/tBuk+3hyTHO1hi8gay6VB5MaObY9tU5mrdlElptaqH
         A2go4FwEOS5GVk4IOQZ+ZDcg1QVtgP5YRn5ysRtA0B4u6+W7s7zANzselNuGEu//rEAY
         QI8CdcFCNpgvf/6H3Wz38lazZ0VcIZcgV3VFiLOqb/hdGzfYlV51EDqh8DC7iiwa+PSa
         1wQrs4SmKEQOKDLhNRiPnEJmpL0TcWskKQikrRRZKO8XJ1Jb33u+qtX1vET2RHQxslq/
         /lCw==
X-Gm-Message-State: AOJu0YxrtTR74Hly8SDikM8UUcMa7GPeyn+surOzRYIpOO3Jr3P3mkdJ
	Wk2uIk7YH+rb/kyYcMSNe3hL5wKEMDGD+RBG3X0OdB/oelwpWvDBPIQG5i7TS2odgK9t5qt6S3y
	v/G/peT0UI4dlhTCOD8roaTI16BfBeq02uQ==
X-Gm-Gg: ASbGncvQi52BQsfAVS9AMkS9f68a/vSbFKo+OQyOjyvSOTBjbMCNG7RJuizue8diKn+
	4H4ItMOwMpM4BvkLXgpi521wytv7XRTj/pPQGQBMqOmqldnGXg03mbTT4FlS/dkghVZSAbUEoHb
	NUBhQu4ExgAWdfT9VAXLfrTzXUY31inQ8VsGT0BI9UlIEIVMdFjrb7qOl89ABKIqzas9Uv32YcP
	SaOP79JsPLytCF84NFh8kYqLpj1KAG3ZC+GBIVx/nz95uz+Y4FcOaOC91uFHppy3zSN5RHlynUl
	4M+n7w==
X-Google-Smtp-Source: AGHT+IG8VXbrgIeIAPMSP7H7OYf6mxmSVfs/YHuAWUtl2o+Tq1cJZFMlu1NAb7hO02WFjXKleFiJAbZrlBZgAtE/h1g=
X-Received: by 2002:a17:90b:3f10:b0:31e:cc6b:320f with SMTP id
 98e67ed59e1d1-33bcf84d70fmr16652959a91.5.1760966165054; Mon, 20 Oct 2025
 06:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018051945.51425-1-nvraxn@gmail.com>
In-Reply-To: <20251018051945.51425-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Oct 2025 09:15:54 -0400
X-Gm-Features: AS18NWDAmUvxOiJad9p9RG257kCezYHCwIyvOuWLkzfs29_fx-yKDn-ElaRFn_k
Message-ID: <CAEjxPJ6dzwny-82pHpEHf6ugMDpXb_atFe5Q-EZBzte=NYy7_g@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: semanage_store: recursively create SEMANAGE_ROOT
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 1:20=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> In package build/install environments, when semodule(8) is passed the
> `--path` option, it is expected that it creates the entire directory
> tree for the policy root.
>
> Some package managers warn or error if permissions do not align between
> the tree on the existing system and the build environment about to be
> merged. To make sure this is a non-issue, create the tree of the policy
> root with 0755 permissions (in line with standards for `/var/lib`) and
> then chmod the final path to the more restrictive 0700 permissions. As
> the contents being placed in the policy root are security sensitive,
> erorr instead of warning if we fail to chown the policy root to 0700.

error

>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  libsemanage/src/semanage_store.c | 58 ++++++++++++++++++++++++++++----
>  1 file changed, 52 insertions(+), 6 deletions(-)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index 1731c5e8..c1425f15 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -491,6 +491,44 @@ char *semanage_conf_path(void)
>         return semanage_conf;
>  }
>
> +/* Recursively create a directory from a path string.
> + * Returns 0 on success, -errno on failure.
> + */
> +static int mkdir_recursive(const char *path, mode_t mode)
> +{
> +       if (!path || !*path) {
> +               return -EINVAL;
> +       }
> +
> +       char path_buffer[PATH_MAX] =3D {0};
> +       size_t len =3D strlen(path);
> +       /* + 1 for nullterm.  */
> +       if (len + 1 >=3D sizeof(path_buffer)) {

if len =3D=3D sizeof(path_buffer) - 1, then len + 1 =3D=3D sizeof(path_buff=
er)
and this condition will evaluate to true even though the path + NUL
terminator will fit into the buffer, right?

> +               return -ENAMETOOLONG;
> +       }
> +
> +       strncpy(path_buffer, path, sizeof(path_buffer) - 1);

Not sure why "sizeof(path_buffer) - 1" is used as "n" here or why we
even need to use strncpy() at this point. We already know that path
has length len and that len < sizeof(path_buffer), right?

> +
> +       /* trim possible trailing slashes, except if '/' is the entire pa=
th.  */
> +       while (len > 1 && path_buffer[len - 1] =3D=3D '/') {
> +               path_buffer[--len] =3D '\0';
> +       }
> +
> +       for (char *pos =3D path_buffer + 1, *slash; (slash =3D strchr(pos=
, '/')); pos =3D slash + 1) {

Assumes that path_buffer originally starts with a "/"? Likely always
true but noting it.

> @@ -529,6 +573,8 @@ int semanage_create_store(semanage_handle_t * sh, int=
 create)
>                         return -1;
>                 }
>         }
> +       /* We no longer need to use mkdir_recursive at this point: the to=
plevel
> +          directory heirachy has been created by now.  */

hierarchy
