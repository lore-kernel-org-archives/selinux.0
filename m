Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9A39768C
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361332; cv=pass; b=lNGnKyHwyIympFza9kU2twrE+x5UjPo1j5JuPuIpbAWilRpDuXVEDuzVHvqWukNs9IkN7Xlw2vG1GOB2seG9/IhKOH2sSgOhv10xgQTdYMQTKq18VhEESXIEBnnwTdC8fg+2k9CEq4xLjmY9AxdHWSMwtOum454rSaxg2bTiMx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361332; c=relaxed/simple;
	bh=q0wFRjOzB05KsZ7SH4m0Kmaw3WcqMiV/OzAbjNPKkTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qo0Qn5LdUCThv1h6ds2g3Rper6FSLwlcdPK+a3h3AAUMDyYAgXXSKpqoorpRPJH44UJgOYRn0PkIR5bmZD4SN6zL6mnnkWqFxadBdUuU3BOMN0DTojT+E8AiHY39y9yrEfL6P2KbAJxowZDY8/GPNts8we78ww7luC09FMotjkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkeaV5m+; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkeaV5m+"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e50968489so1215006d50.0
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 11:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361330; cv=none;
        d=google.com; s=arc-20260327;
        b=OV0nLi5rXKwATe9vSjFf4CuWF4YCj6GL9CMlK201fb2RUIOqc5OaDUmcnReDm6hq2C
         3YM13T2GgthPqPG6qfHX6mTSIOyEHJ7yq3zHQz+HXu3+wZIQA9aOnDmRDU/0YBHVra15
         NX9HGVA7NIUYkZucmzZpsE6x6eP2QEQU5QL6GTXzi6EAx1q91QR7WcA3tAGx5m21Vytb
         fDpN6GewUl6dgL5WU1+Z3RGsPjwhcGCCb0I9NF0zAd48Kp9f+Su5djXUamaWP1imzuel
         9iMOSxs4f9wMd8nRtW75VPT2YYXEZ2GUJzZAOyKgeaJP9PZkKl/lPFvjS2I668NbFHMj
         99LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HucarwXALvMl+6i5ydCGlALkVRyH6w0uTTGvh1xxUFU=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=BC92zzEYZ3nRd1jz6/jwXBYK6xONAJVv0FYnW+ZHmGOzAjJani3H68l3g8rD9vnVVQ
         O66O9zraPMtErfdBUSLeZdy4/hujJtLuH3wdVMk0ClVaU7Pg06oyEBKLdS+KL14iaavo
         Lq6P2lf0/A8IhxelYS3s6sZ7TbmSYto+mKQ2nul0X9MomjH6D7Ag7ORMjpKNUXDGmdLT
         SRcE7XgXhkobVRxoODFk/sD3YaT4foDU26ST532CILoAt06DXEr+/mrsTzXawZISdSIY
         w0E/Bv3Y7qwC1W+PHZ5DE189wKJyFjrApZk41hB5B6OR4XgJKN8J6OPd/1wRCv4YpFtz
         dfUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790361330; x=1790966130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HucarwXALvMl+6i5ydCGlALkVRyH6w0uTTGvh1xxUFU=;
        b=mkeaV5m+HCXG4H1i6e/3nkJQo7MdN0jH6rfj4YUmWhyQJNfujxRWkSPHIoQXR53QyH
         fvVEO9rOnNWmPMXGzvRGfwu0UC9PmgJ000GeZBL1ifJhE8xPz0sReAaTwtIPN9xpo6+h
         X30VCVcy7/gShR1NPMhu2LFnE4iQk8LiUUQ14yr8Lw3hbU4YHFdcgK8b0wIv/2hGnScD
         L/TwUNOQ2rkYDjBa+rlg0HImliFRAH+kJf8P00kvr1bPrMyhbWsyCwsy27CyX+iQKrsV
         KvqPDzRQEdzL1IT+aKifU6I800vrkisq+2t2UjA5RX6rLDheM+jA8neGKssgsI+Y1tYm
         PQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361330; x=1790966130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HucarwXALvMl+6i5ydCGlALkVRyH6w0uTTGvh1xxUFU=;
        b=FDwtQHg/TAY2NY1aVMMDPVHPzb5mvtaaHcEf5HUJyA7ErufsJVINGL6gR7XT93JzN5
         SeYH3sk7w54b2YBKYqNJjoSvrOwjhqSDGSFFDT5SxzvX1SUKd/R96mbN7Qfbh4Jib2LK
         mNEvrdEXiLx+H4yoA7c6/ioIM7LoDdOl2DGMvjq7hrqcXSzA0H2seY9ssKeNWUadhGn1
         j5K4FNrJpNOj+OH3l09lmUvwRuCVsRUa+EaxsTGRA/kfHJxFZZu7S+kP7thTFVt+CsjI
         OtMjkyBbSD1/TAOqg7caongNMRDrMXZm604t0TOEcFxPM5yu8aIaBiqdSlOKJai5F22q
         fNTg==
X-Gm-Message-State: AFuF++lVrC8vA3LhkecXzgTBA3B9Ou8+rmd9dd3ljGDCzAVt+uMtwHjs
	RnhWS8YtO6+8etYx2XP5NB1Kct54ktKF4U+JzhXwp5Nprb7UO7RyFYHLxY+zKscc0t3NlenmzdN
	vbHwucwz8QDTw8J77kLXOKEkHkzzpoO7R+g==
X-Gm-Gg: AYBFou0dZZ+PPDglh+9M2P97mX3tetelHfxVc1kUaaObJ3vxnADDc7MrxVCr9xEUBRt
	IFid+ExZFRjTSi1Ex7diqtLuVzEeISjBmCcwqRElrnQiSuJfeApfXPR8sVRYxtU7oM51JGdTGl5
	PiOaBdZaKIZNOErKcGuWxWWUfMGckuxZei0FACzVVlvn1LE3o0V/NvyL5UnoYjbieunuyJ/wjDH
	0EWQGUTgvj8dM+o0sYWU/LC4T0beuSzSti3VVrVZkF+m0l0drJfC4lN8hvxE+oDVXntNZXZGFqN
	kh4aUxTgig7KU1uvbxsnhSveX9MgBqUhSkpZ1xwhG8QIRE03IRmh95g=
X-Received: by 2002:a05:690e:4005:b0:672:f58f:b9c9 with SMTP id
 956f58d0204a3-672f58fba71mr3018852d50.59.1790361330341; Fri, 25 Sep 2026
 11:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-21-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-21-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 14:35:18 -0400
X-Gm-Features: AclHuK-0oKCSCTYMtkLarUy5dN_GaSfVTsW8PyKoOfOXasl9wGVwBoR58HmqM0A
Message-ID: <CAEjxPJ488233vN4=kgH2JtNMEHMJ1PAXoXDMibb4WNa3Sa=xxw@mail.gmail.com>
Subject: Re: [PATCH 01/21] policy: allow io_uring allowed in the io_uring test domains
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Since Linux 6.15, io_uring_setup(2) is subject to the SELinux
> io_uring allowed permission, checked on the calling domain against
> itself (kernel commit c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM hooks
> for io_uring_setup()")).  Policies that define this permission, e.g.
> Reference Policy since commit d4084b9fa ("Add new kernel security class
> memfd_file and new kernel permissions"), do not grant it to the io_uring
> test domains, which only get the minimal testsuite domain rules.
>
> io_uring_queue_init_params() then fails with EACCES, so the positive
> io_uring tests fail and the negative ones pass without ever reaching the
> check they are meant to exercise:
>
>   avc:  denied  { allowed } for  pid=3D3493 comm=3D"iouring"
>     scontext=3Dunconfined_u:unconfined_r:test_io_uring_t:s0-s0:c0.c1023
>     tcontext=3Dunconfined_u:unconfined_r:test_io_uring_t:s0-s0:c0.c1023
>     tclass=3Dio_uring permissive=3D0
>
> Grant the permission in the common io_uring test domain definition if
> the policy defines it.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policy/Makefile         | 3 +++
>  policy/test_io_uring.te | 6 ++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/policy/Makefile b/policy/Makefile
> index bf1ea76..2d098ce 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -207,6 +207,9 @@ endif
>
>  ifeq ($(shell grep -q io_uring $(POLDEV)/include/support/all_perms.spt &=
& echo true),true)
>  TARGETS +=3D test_io_uring.te
> +ifeq ($(shell grep -q all_io_uring_perms.*allowed $(POLDEV)/include/supp=
ort/all_perms.spt && echo true),true)
> +export M4PARAM +=3D -Dio_uring_allowed_defined
> +endif
>  endif
>
>  all: build
> diff --git a/policy/test_io_uring.te b/policy/test_io_uring.te
> index ad12846..4b8a1f7 100644
> --- a/policy/test_io_uring.te
> +++ b/policy/test_io_uring.te
> @@ -36,6 +36,12 @@ testsuite_domain_type_minimal($1_t)
>  #
>  allow $1_t self:process fork;
>
> +#
> +# Allow io_uring_setup(2), which the kernel checks against the
> +# io_uring allowed permission if the policy defines it.
> +#
> +ifdef(`io_uring_allowed_defined', `allow $1_t self:io_uring allowed;')
> +
>  #
>  # Define a per-domain type for any io_uring anon inodes created
>  # by this domain. We use per-domain types so we can distinguish
> --
> 2.55.0
>
>
