Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E74D2ECD
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660741; cv=pass; b=Hrxj78pb59OWgKeSDtitEpENxwG7LAcJLyf1is5soOTtHx11FvJWtwge70rGkQgqEERe+XUTJ+gFpvSBMH5vmYFiF0mRW0RbWittwbu3Sk74y02GsiyZlbgkkFwDMpXwjy4RYBCJJuzJ+rNf3aerUzU7N6IAkIm8OCEqqJ2Sock=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660741; c=relaxed/simple;
	bh=36v5BDdZ9pdE+cUdl+a84tlJrBgEtaPZchPKwvNqXEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAPL5E2Wxne9nyyS+VOO6WuKKRsBiUImxfu4XMii06ubCl3lV7R3gij7578zY1TgWqsLTR6ChsLk5AaWOCMz5TQPEz8YoJec8fdj88K4NpR7L7tfGjZV6PHN/JYHQRo82sJDGMoEkaPSgkY0NBf79askp8br+8DK8KFPV92eRh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyjxsEo1; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyjxsEo1"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84230ab8857so789094b3a.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 04:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780660740; cv=none;
        d=google.com; s=arc-20240605;
        b=c77P/06XOLUd4z6IB1oYrGp9hTgaJeSCnpyU1qSaPKdGtohoDyvYHn14whPcfLGLIe
         aMuM+mapvKBgNV8TBgPxtXt7jrpCQI3Cj02BHh6ymFGnqpKCowx+aLnXeNglj/bT5G4b
         2HN2u15whtDBdsxJxSrJEe5oJJArMNHXqT4BmNZ1X05c1WBPLLZnaUgqjZX+xJo9un13
         fp6REpPJiHQ6W5MhAwBmoMxq0Ns7VBl5L7wuv0zXIVNZnidEAY3YWdao9a0PXs16716C
         uA+B5Kz7YGCjRxnnjZuJMnc4/AZJBYjMQYsktC9aUTPSZi5zy1aKPFTVbykGBaizfVdc
         mDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HKovdyHd/BQf9hTPk9/l92T52HtbbwzdtIAsrB8VAgI=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=JpKXwm3CmXNL82Oo+nUgUg27VxD4qD5jXD/Ye6hCkUZaAE9svqMIFH53V528MLRDkM
         0pT7Gmb4Ym2F+9q2ZK7739dMC8cn0rWm2fGQGEMPKuZhEH/hhrwKWDPmGtsJzZHXo5PV
         F/mYoYvsbym2fl31zlHQPzfyIXdUZ7jLiJXjidxojjndEcLRG3Q0addcjXJcMNgQvWEL
         UmBzpuWj78hBfp9cQF8VKYtrU2ikQyYJskdcR0hBmnmhxEHpehAjSqStZnWQlS7LMJlE
         u/veU6XOuSR8aezsoeGr1Lj6+p2l7AMYowa6XuxNbgKxtdgOjM1T9jTlzMQEU2kFB7MP
         jIcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780660740; x=1781265540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKovdyHd/BQf9hTPk9/l92T52HtbbwzdtIAsrB8VAgI=;
        b=kyjxsEo1a+U8Bk4Zapck2/DQpJCozYinDhH4fnmXgo2fLX0CQ9NsWP5L1d4Wj3hwSs
         c4S9Di2HalyasQkFaCYp53C5uYaAFx3j3VIFRvyaJlVu2I64aVppCk9ljQ1O1GBzn1In
         p1HCesj/dXVzLj8zBmSoDOaakuuT1ZbkxX4QnSwSPdcVs+WqhoGV8ADe++d235nSxyA+
         BAgXcl5POnp3bfrQf/rDh0aBYgApnhfWl+GlwStyfoKSKJPYHVthxefoQKmNdL+35BV+
         iHz6DwdyxOVRgeZL8ZtcY9I0gK29eTSeYE/dL8IDJcOuuEATRoLbQ3HUZzdX16RYWeWB
         jDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780660740; x=1781265540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKovdyHd/BQf9hTPk9/l92T52HtbbwzdtIAsrB8VAgI=;
        b=TyYo07GmwzqGo7SwL8d9wMXcjSx0EgTXwP261q4A7XcbSyxlDzA1bVsVfTHY0KpuQq
         2LIzsPP9IEGdDnFJ5wsYjPXk2EcAKy6NH/rIRSfTsKeRwC+AAUx1rjoKsSktqzgu99y+
         X0HD2k3Sc5uBMGUgXl73LixkuS1wOyy+4X3mdSnRoooX1Kqd18guahbBeQftpAlwXAPg
         uZp8ITQ9/3K8MkKn1M7/bBGFdR9KEQ1cHK8/cau2vN3V6G86oteo6n3KTHTe48Mr9sj1
         BDoO5B8m2pw1cLMVP7lTjllyBcII5uavhLVytMZSSJnBp/kGsyGNyYkUu5Q55PHdJeIk
         6Riw==
X-Gm-Message-State: AOJu0Yz7odzNtMMU6QOaFqI0zzm/id4if11HKXoLwG24KV+Rh0ipqZ+R
	5vXnBIZP3vWDmd5GGNvpGOLntN6zzgAOgea+OaTfa7NvY3zY5Gg1xgn0lijouyOhmIISQrl55T6
	uFwiHzXgiVLBUk7xjmQdskJa0SJh0vt58x98r
X-Gm-Gg: Acq92OHDZbqTydcyJV+6vTRaTy+1R7BU7omioi7ndUYTItUjYl9eYMhGX0h/yj6hVx1
	An7lHO9cCe0L9rKF8VUpr22DzkDB6JFQgk+hJdjj631r4OR+dRUQPZUMbYV27S0WtRKw0/YUuRb
	aWeyfW7wW+V9kN/92MtDPIHHCcn3PbfV5ANcVhLt3SculmRpT0S3s00UxjPHyyNJPkChBeYFXNl
	aVdw5HBAmDdQQj8XhGxcLlcL/OKyRv/EzQon2jIgNBu3HdWtfCAbMLVLemLjrWSNmlDVK8p4DwE
	Hj5Q3Bk2/ObjArS1YQ==
X-Received: by 2002:a05:6a00:1d8e:b0:842:51d5:efc4 with SMTP id
 d2e1a72fcca58-842b0e565eemr3214928b3a.12.1780660739839; Fri, 05 Jun 2026
 04:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605112614.2397757-1-lautrbach@redhat.com>
In-Reply-To: <20260605112614.2397757-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 07:58:48 -0400
X-Gm-Features: AVHnY4LDPJ1Pg_Og79e1cJPlMDMrqoNCjSDbS-8buc9R67_Sp1ynXBW5ctiBtys
Message-ID: <CAEjxPJ50c=904ijMzHxA_5csB4u81WUkgPxEb_+wUimct0cpDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ci: install necessary build python module
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 7:33=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2 - add python3-build dependency also to tf testsuite
>
>  .github/workflows/run_tests.yml | 2 +-
>  tmt/plans.fmf                   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_test=
s.yml
> index ed60921acfb7..82c44fccb521 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -71,7 +71,7 @@ jobs:
>              swig \
>              xmlto
>
> -        pip install flake8 setuptools
> +        pip install flake8 setuptools build wheel
>
>      - name: Install Clang
>        if: ${{ matrix.compiler =3D=3D 'clang' }}
> diff --git a/tmt/plans.fmf b/tmt/plans.fmf
> index 89f041f2630a..8f9f96f46290 100644
> --- a/tmt/plans.fmf
> +++ b/tmt/plans.fmf
> @@ -30,6 +30,7 @@
>              - python3-pip
>              - python3-setuptools
>              - python3-wheel
> +            - python3-build
>              - swig
>              - xmlto
>            test: |
> --
> 2.54.0
>
>
