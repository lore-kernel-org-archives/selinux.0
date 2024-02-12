Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EF817BB7
	for <selinux@vger.kernel.org>; Mon, 12 Feb 2024 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731954; cv=none; b=PMp2PB+hbyMnHiQbZT0sDVLmHH8y5bjm01yRW18n9c9bnfzWp0pnQsm+Zi2DaqDoFAeLqDOU/eRuFGwyFHXs917GkvhH9ux46NRCzm46DKvugYNPF4EgyDLZbbBA5HcMWckYfFwc9YTAUkZPzItvDSoVldwMsuORXWO1dcRTSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731954; c=relaxed/simple;
	bh=PVpqCInb93QHd+v0XodvOymio4mgf0s7L+su+Gb9r0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lwUG6+A4cxet21Rc73N1ED33wgd8bbkLc27QbKikx5dRCSNnF5z9b/h+zedSGXT9naJvm8DZ7n9bGs5qtQ8qKE8K5Iv7nA5tV9KFSoHSkU5hjsvMBayj71fkvqaE9XKQCp5KvPq+M+Ohd6OJZ1Bs1zaV3p10HlD3ZgdzQxJxUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0Hmq9TY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0Hmq9TY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707731951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YuVcm4nW76xZhdu/DTHKV91ywIfD1G+QcRVZWCf/sU=;
	b=B0Hmq9TYleVn+k0HoE7LMwcrJ+yWh9FnSw2eoezSHqvOahpUEjEcGvYnCY6ifQ+XIJbxwu
	ZUJugw/bvk1OWPbozu5DY2ezVbJ0oPz0USvVQPLPgnxMK3gd5pg8QYTgZks/LEH1Sm1upr
	OOVkyV/bKm/gmBWBfFOr1L7SzjBWGP0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-48LXtCjzMTWVPZj6aM3PeQ-1; Mon, 12 Feb 2024 04:59:08 -0500
X-MC-Unique: 48LXtCjzMTWVPZj6aM3PeQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2966701bedcso1652856a91.1
        for <selinux@vger.kernel.org>; Mon, 12 Feb 2024 01:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731947; x=1708336747;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YuVcm4nW76xZhdu/DTHKV91ywIfD1G+QcRVZWCf/sU=;
        b=wHnmoEFrrLcFzx/VGl0/sTd/hOQ+vquVIrgvPGlPtswgm1eg/3FdldNSpK1KB9gvRo
         HsbZVdg4K7ivb+PI0WVpsSXRpct30M37YnXWMQyJn2hf2hXuJ14dRb9Ybz3to6MKvyrT
         KbQ8G/PdTqunu+YT3rS9Pw6OYGxFdFGz5UT0fxNgnfEkKsmpaISeImHIEjmX6EXwMqEn
         /DZL88Lt4y2vLqVgHTdJKUW7pz2Gg6jg7Do5NuWjc3SIsCVRNRdgVUVj8jB5X4ORja5W
         jo6pIB94jcMuzKhpA3mdF+RwdnvKgU3YyxxB///Wj9zC76nKvl4YPePbUvaHBykPDVxl
         iK4A==
X-Gm-Message-State: AOJu0Yx/hBw7N2IVcAQ92iUUKSc0tzdMhChrsIVouIqXRBuL5OEHoNGP
	v9uZaDCS2i3G9qHEQmULV5Y11zzapXeHtvJQJrNF7mvH5tsUmD18huQNdln1h3T41keyTjF27XD
	q0WmdxkxDH+I+hxQLs9WccOzDAXLUz7Ot8CVAD4tiMzg2Btlhbl7L3pipVeYRdfyNT7KgNyVbaa
	5tR57buIxF6tvaKVffl+DCC4Ac9EoT896/zrcNnHFY90k=
X-Received: by 2002:a17:90a:e2c7:b0:297:18f7:8b95 with SMTP id fr7-20020a17090ae2c700b0029718f78b95mr2638072pjb.21.1707731947293;
        Mon, 12 Feb 2024 01:59:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaaIxAWlGkCKbmc45VX4krvllbOLoYkazquqBl87bVYmphxF/bJmpndQ/K6A18He5ep9CjbYEIyedW9nMw84A=
X-Received: by 2002:a17:90a:e2c7:b0:297:18f7:8b95 with SMTP id
 fr7-20020a17090ae2c700b0029718f78b95mr2638058pjb.21.1707731946751; Mon, 12
 Feb 2024 01:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208161125.620477-1-omosnace@redhat.com>
In-Reply-To: <20240208161125.620477-1-omosnace@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 12 Feb 2024 10:58:55 +0100
Message-ID: <CAFqZXNtdHU-r4y61vVkfzW1zZZg_NTomDQzkfyyhDs854oLj0w@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: fix testsuite_domain_type_minimal() to
 work with rpm-ostree
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:11=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> After a live package installation on an OSTree system using `rpm-ostree
> install --apply-live ...`, domains need to be able to use file
> descriptors from install_t, otherwise they fail to load dynamic
> libraries. Thus, this rule needs to be added to
> testsuite_domain_type_minimal() so that the testuite ca run successfully
> on OSTree systems.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policy/test_policy.if | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index b20baad..e590f0b 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -37,6 +37,7 @@ interface(`testsuite_domain_type',`
>  interface(`testsuite_domain_type_minimal',`
>         gen_require(`
>                 type setrans_var_run_t;
> +               type install_t;
>         ')
>
>         testsuite_domain_type_common($1)
> @@ -46,6 +47,7 @@ interface(`testsuite_domain_type_minimal',`
>         allow $1 proc_t:lnk_file { read };
>         allow $1 self:dir { search };
>         allow $1 self:file { open read write };
> +       allow $1 install_t:fd use; # for rpm-ostree --apply-live magic
>         dontaudit $1 security_t:filesystem getattr;
>         dontaudit $1 self:file getattr;
>         dontaudit $1 setrans_var_run_t:dir search;
> --
> 2.43.0

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/f9f4a604b50eecdc=
9ff674f1762208f23c15013f


--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

