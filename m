Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03D213E76
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784287; cv=none; b=gs73tkU6w8SCbheWWWNonGJ+Z7BU/Ng5t0vNyhN9+OMOmhe+yKQuF9C53Z1XydnK6AiWfcKxPMtDZqG9IO/hyY2o63gBr0LkFLirDGuvI9YVu2pXBPbTWm/65lxd/csCl+6T6c0hibM8j51l2gjwAVnsPleqiCMKKGy4DXm63Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784287; c=relaxed/simple;
	bh=WJ+GbwrZ/Ldj1Ij2WEMgCJYCLrOojxh5ipIsWNFHfhw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=hJOHD7b6aVn4EHUu9pNJEOFLTC4tS4IzwYhgQy5ztxrt40pdfkWuj0KHCmhg2QqnVMWnQLQ1YsFZyV24vVWQ7cisT0yp1A87zbDLPtUSRsuOEiVSSf+uL6GtC/OZ8FXLDC35cWOhbeXrTrkQzYC5e6wtanHGgLyd4nHgEMBqeag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P3hyUvh6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P3hyUvh6"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c54a9d3fcaso700455885a.2
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747784284; x=1748389084; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62U7Q0d69MZQQhMsOgtCAUKGD6TsHKE2/Y7fYLmAfds=;
        b=P3hyUvh6w1YbIX6ge+XsyhEYnl/nyl12H8qImJXg9pYX0DAZPPZvPt/6uMlXldQdWN
         t+i5svt0+4fLCVUmQ1/1/oPJzQtHy2YVd10BUbVWcYpXsULMsZ70wBWr/GlOXeA0JQ3m
         bXduSlQ4N3Mliu02g0gOFZehRjiotHHLmqi+hMbyNrFVM2kjmOR/baKWy5VthLrvOR1y
         yi13uwjUbnyQ79Yh8uJoh44YbxHWlvhtIYKHsVepZvvZhcl1ZfPOGf7GpR9Gr7fEDMWU
         q4AfhXCEQONyKaO+QqpOyW8QoUinHLZRXlpZH1G1euPd/jXn78jtB9ryhAYGdUkJZ7Rz
         E/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747784284; x=1748389084;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=62U7Q0d69MZQQhMsOgtCAUKGD6TsHKE2/Y7fYLmAfds=;
        b=Mxi1DO3oiWqK6Qv9E+nQIEUq3mzkC0hUmeAz78Mno7sP1XTxsGGuu7Woch8FKz2uIe
         AuSH0Ffxqw41B+Gn0pPCrMKqgGOvVoNTrQdO0GRDDUvLk7MSORTra/9O6IG9pO2ISEl9
         bi64kiBI/mKck2S0LlC0TV/uPXxxHhl4C0eNcqqB3mAO8mWRJuGbv+3ahhoyJjLx4Ux0
         /70QOqcizLbDL9s+IUUPHbzhnNXcXjJ77fNrjOupyl59y0u7rZc3XX4S0naQkSFdV8fL
         pwCngt9Iz8svzWwZZouwZhCcukX6mSuD8CZ36mbqld7rmAhxGyx4n0GbqIRjqh76z6/i
         qLeg==
X-Forwarded-Encrypted: i=1; AJvYcCXrLEUiOR53GDrQcIDww8MbUq18GRsZ0ihRXufVkqCQzBZUlijHD8Yt+zuoHRsWvXCk2JQk3Xgz@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYzxggR0JkYtZrqcRSYQE7RDUfuGmNYNLNP/igRvMOf4TWhQC
	xL4iG2mD9sDk6pY1Dd4QaP+cIcKP5yQhyS1KeIgIZHptfiFtUI3Q6QW9XhzpyTvchQ==
X-Gm-Gg: ASbGnctp9ew5lKDXjs+EvLJbnd1+Wh7CK7atSnjkcs9l53Rh/58NhWavuuhnqv4L7GC
	ibUmyZM2eLHanj/KO2RL8x4+nm4spbNKc3CYjUEKfjLPcD8u32JGa2ZtcqC9okY/T5mFPBrJnk7
	ocBm1kg1w4O2vvVcznTGpoUaBAE/WzW4xnr56kK7kYCQkfEA1g75YF6rMrkJmOubxHqQghyaqWa
	bt8o+ZRZPlldOQmTtiBt8Xt5G5qoVRCH3G0Fuu+J/hpVUEiBSmHtv/SBEQsj8QmBL8IhAWj8qfm
	XskKTieYtaHrPzAwSVU5svIsXm8b+vYA3hKxAGVayKR8fQ9YxVW8KpRy/TtKhnEWFSjdHS8lnWc
	tYi25ur91PV2Whf3hszvN
X-Google-Smtp-Source: AGHT+IFZhkgZNdxEVCbm/DP1KoGQ4FPNeQ4wQW/z/losg8dqUUq2fj+6Br6bD5lv8xm2Gp/isg1IPA==
X-Received: by 2002:a05:620a:3197:b0:7c5:4d2e:4d2d with SMTP id af79cd13be357-7cd467c1316mr3128290385a.50.1747784284428;
        Tue, 20 May 2025 16:38:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467be470sm798404585a.13.2025.05.20.16.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 16:38:04 -0700 (PDT)
Date: Tue, 20 May 2025 19:38:03 -0400
Message-ID: <8c2770270a9d4a217e22102ddf91327e@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250520_1533/pstg-lib:20250520_1521/pstg-pwork:20250520_1533
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 1/2] selinux: introduce neveraudit types
References: <20250502170450.27160-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250502170450.27160-2-stephen.smalley.work@gmail.com>

On May  2, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Introduce neveraudit types i.e. types that should never trigger
> audit messages. This allows the AVC to skip all audit-related
> processing for such types. Note that neveraudit differs from
> dontaudit not only wrt being applied for all checks with a given
> source type but also in that it disables all auditing, not just
> permission denials.
> 
> When a type is both a permissive type and a neveraudit type,
> the security server can short-circuit the security_compute_av()
> logic, rendering the type equivalent to an unconfined type.

I really don't want to see the word "unconfined" in this patchset.
Talking about optimizations that can be done when the permissive and
neveraudit flags are combined on a single type is a good thing to do
but I don't want people talking about how this is an unconfined type
because it is not, it simply mimics that behavior.

You are welcome to criticize that stance, but understand I believe
this is an important distinction and it *is* a hill I'm willing to
die on.

> This change just introduces the basic support but does not yet
> further optimize the AVC or hook function logic when a type
> is both a permissive type and a dontaudit type.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/include/avc.h      |  4 ++++
>  security/selinux/include/security.h |  4 +++-
>  security/selinux/ss/policydb.c      | 19 +++++++++++++++++++
>  security/selinux/ss/policydb.h      |  2 ++
>  security/selinux/ss/services.c      | 20 ++++++++++++++++++++
>  5 files changed, 48 insertions(+), 1 deletion(-)

...

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 7becf3808818..1c9b38c016e2 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1153,6 +1153,14 @@ void security_compute_av(u32 ssid,
>  	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
>  		avd->flags |= AVD_FLAGS_PERMISSIVE;
>  
> +	/* neveraudit domain? */
> +	if (ebitmap_get_bit(&policydb->neveraudit_map, scontext->type))
> +		avd->flags |= AVD_FLAGS_NEVERAUDIT;
> +
> +	/* both permissive and neveraudit => unconfined */

Nope.

> +	if (avd->flags == (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT))
> +		goto allow;

...

> @@ -1208,6 +1218,14 @@ void security_compute_av_user(u32 ssid,
>  	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
>  		avd->flags |= AVD_FLAGS_PERMISSIVE;
>  
> +	/* neveraudit domain? */
> +	if (ebitmap_get_bit(&policydb->neveraudit_map, scontext->type))
> +		avd->flags |= AVD_FLAGS_NEVERAUDIT;
> +
> +	/* both permissive and neveraudit => unconfined */

More nope.

> +	if (avd->flags == (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT))
> +		goto allow;

--
paul-moore.com
