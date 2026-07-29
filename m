Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B424EA36D
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340994; cv=pass; b=jdoFvrdvBYo/wAci92EqfSbPiGdQx2VR9I+QyaF5F5H9VO8wvSo6DT3yC6QN6jR1euUKyY4ZU6PBJ01LByOUPowP6nObmVOtksYYWXjtI4yK3P4Tk+2fOGF1QE2Iv3EOKUP7fMUZIl7wjFU7XrxcR40hjlDlssu/MYkCNmhDu8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340994; c=relaxed/simple;
	bh=TZmm3w8I3+mLOOu+XWNNLpkFzyHTGy0vu+lA+TwF0C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N16Qs+sSsIUyFU4yLVMmiBKdK5DQn7mqcZ580hwI9NYEALKW3oI6/M0dPBijIxu1kobEHnZ8GwWHq7W+2MaK5mZ5nWPzoGwT1hhBpfMbplDiFJt1Su3dke4cdAiro2+ipws8CIIIbJnTFbaGoNz4B2IpEnvUJAdntWg6mIZrgcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO3qVT7u; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO3qVT7u"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43b7e186a0cso361575fac.0
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 09:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785340991; cv=none;
        d=google.com; s=arc-20260327;
        b=GKyRbvOdvEouX49tyEIXd463W2/bSJHYEcaZWz1PWmrdd6mBEIjhauKtsL92E0cI/E
         Kq6g/DC+ps2jAlBIUj+xbgPD3rRVIKF94VjodO7I6mOGClo0WV2hHPxmiICW3YH5TTZX
         L6EijENbF1NgBVbVlzJpbqxCT9QQlWk9sIt8xZ/kfS9eqpC0u9KPSK9dgTUt9sU3Lj/2
         3OS493RQaNIvNboX2XpZcYGUZKI5B+BbhzAX6gs8FVOA/jSa0kLTVy/KVmwhJHTbyW3u
         wJNWPjUH23/VGTpRn8Yfb+aQFAKYiAMIVkZB3f6dPqvo6InvOCVNzOZIT8jC+Q2sTxtv
         6RIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7NBerSzRHwuwE24NNrB7kZ82tnAI+ict7MtXWHBVezk=;
        fh=chQ82yjwsBiR9uZWyudR3T+s8hO/5hiH4ix6Fr2pKCg=;
        b=SVX6IgrWAXLX3fJlnnB2TcIozZpOcNkhHk5kk4e0NKDdYShbIq16YEcO56AjHHqFF3
         SwD52bEwaU9aN1fY/6VQqwOItrMtRfrVHD6uYIWNOEBG/Z759IFJ+pJyT250AUf0a/eP
         VxVE/qPwlaNO3lYehrbY5WgT4CixGjjlaSqdcOcdk6E8hP8zlbi7J8Z/W6XjORJOx3Nc
         wS6KuTAkTBx7lbPwe3OGVI3fIyI9/NJDdZYpuIUQAgbmX7dL4BVrCubreh0WERNGWt9t
         EtQaM9kSjL64b7yE2SQOpva1qoQg/i9beybjshHz2Uwea3RRnmaz+29BpHOTa4eF2LBW
         AjHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785340991; x=1785945791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7NBerSzRHwuwE24NNrB7kZ82tnAI+ict7MtXWHBVezk=;
        b=IO3qVT7u+eMt6Q/s0zr7qHD4bP0n4HshjZGSlcIFiVk9isOdz0StWN1dA96uHS9m/c
         dFKtvfcxzjBggMZHRGAQg44r91w3byW4gpwvJtu7zoMkYYfzNnMLcBCgoSbZhDzAvrDs
         U9qom/z4Nbcl54vmaeexkh9fCFBTYwu4uakpS7CyNa3Kede5Y+1qiMYSHkTVwbtLE2Ug
         B5BpI1yK88o3BOzSFNsFvOo7OENi7tyuNxVtiN1OdXVrj8knNhaI69PaJSYI4hYQFYLa
         x7PlDAU/SfF+Cqu4p6R46gqLQKcuxyAoksVN7Fq7DfSJ6h7wDFQ4hUIr3XogB66c+j/D
         E9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340991; x=1785945791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NBerSzRHwuwE24NNrB7kZ82tnAI+ict7MtXWHBVezk=;
        b=Llvq8uF4ckAIdDnE3UpC5JUbSxhhXTw++XGb1y0YVfIbqccK0AQkhpizZCqODPyNlo
         4Q3x/xqdPECiHEQVTpVjsLTKAVjrebcnnjIZqFD5iLAS53+l0vm5dJpNWxq+Qai0h/NY
         hQIiRs//jwBn4CLfpNxaQOwBwIFEqy3DpbCx1h1MdcduHfMKjowjaIKb+7uFS4rZZbx4
         H20259gBq4XB7MsR14MQwzTkwQ41d8IVSfrY04e3j8aqYSxmCQbV3dlJMsQKZs1T4Xa7
         q02KuGqlSJgdkytyj8r6oGEbP8Wj3s42/nmPKbRm/ksLLZDlRngJfnQmwHyXsXEdaUzi
         RZyw==
X-Gm-Message-State: AOJu0YzWvHDUNH2h/1NtLGaHc2zCaxZ2tzn0ASHr4C7KMhSBKJ9s5kzm
	v8tAYWKKsEs0qovd2sSC9DKvv0YuJ3ZNHe6pZYrn1xhE2siEVg/vbO2Gza0qZGrd+s1GPq+4Gxs
	GFqMH2BDFd8reCTLGN9eaMkkIZG0q/H2MfmWC
X-Gm-Gg: AR+sD13fDfhttLgtkNn9oVzWbT84e+FK5SBCXk1YAxOZ/9px/e3glOdwulrAVmcCBz7
	/YadS61xOOZUcDpnVr1wfkmD30DfDjfcqLi0YzUavty7VILKJ0A3mr0WlQoTsdhz0n7EKDTKc4F
	JTL2LQa+oLDcmDeVMWa1Ej0Tc8cmYXSoH7+zXNv1W3FCImM255OBM4CbHywBrBFg/CuFWhjcLZJ
	Zr/JnpvzixC9Pbb3v/ZudvOOOMlCwJmvPPj3hqOI+v0suOJXqgg/3Rg9F5UHKf19+EZWCSUsed3
	3Oj84BzXOzfwLdA3U3Wa9W3fvp3/PIPJIqsF5HPCPJbAGeJVpLSLqvo=
X-Received: by 2002:a05:6870:b3e7:b0:447:24bf:ec47 with SMTP id
 586e51a60fabf-4586cab7409mr4192097fac.10.1785340990824; Wed, 29 Jul 2026
 09:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729152415.1606580-2-cahu@suse.de>
In-Reply-To: <20260729152415.1606580-2-cahu@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 12:02:59 -0400
X-Gm-Features: AUfX_mxwwElaXnL81c7-UaCbnlSv65gjklxMiuiaITYsqBPWR7QtW9HJWCVuOuw
Message-ID: <CAEjxPJ4diE9aXf6SGrSqZfs7Kh-pnv62L7AA9CP1Z3YdDSZHPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libselinux: add pyproject.toml file
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:26=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> From: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Add a pyproject.toml file for the libselinux python bindings.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/505
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Verified via https://github.com/SELinuxProject/selinux/tree/pyprojecttoml

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> same as v2
>  libselinux/src/pyproject.toml | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 libselinux/src/pyproject.toml
>
> diff --git a/libselinux/src/pyproject.toml b/libselinux/src/pyproject.tom=
l
> new file mode 100644
> index 00000000..dfc44e81
> --- /dev/null
> +++ b/libselinux/src/pyproject.toml
> @@ -0,0 +1,24 @@
> +[build-system]
> +requires =3D ["setuptools", "wheel"]
> +build-backend =3D "setuptools.build_meta"
> +
> +[project]
> +name =3D "selinux"
> +version =3D "3.11"
> +description =3D "Python bindings for libselinux (SELinux userspace libra=
ry)"
> +readme =3D "../README.md"
> +license =3D "libselinux-1.0"
> +authors =3D [
> +    { name =3D "SELinux Project", email =3D "selinux@vger.kernel.org" }
> +]
> +classifiers =3D [
> +    "Programming Language :: Python :: 3",
> +    "Operating System :: POSIX :: Linux",
> +    "Topic :: Security",
> +]
> +
> +[project.urls]
> +Homepage =3D "https://github.com/SELinuxProject/selinux"
> +
> +# The actual .so is produced by a custom build_ext (SWIG + libselinux.so=
),
> +# driven from setup.py.
> --
> 2.54.0
>
