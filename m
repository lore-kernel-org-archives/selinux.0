Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9089723F31D
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943257; cv=none; b=nBnwXgIbmaHYAcbAR+Ep1vueGqDeFMJvHRnbV/v/rnJlz/98UwZetC5A5f/8kLGMHwa5ECndqN5H5B55pFi0ACMtR/RH8xKBkWCaOtfTErp8ilwbG4Ulx4r9Ir79TkxZlhwJ3MIoM6zoY0ULh9hRFWGjY63zpNxGEXZZ3i0nUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943257; c=relaxed/simple;
	bh=ytIXkitzIgnaQXw1DgIpHBXtGpsP36TUADendYz/D8w=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZbDEAgJzUjDShsvAX6g1GLkc2URco/A3UQ1LGrUAE8Dg62o17d6tfJ0C/Wd5tc2/aDP/0o41+/L9Bt1J7f8byWLtxzJuFCQQUT1DVN1xHF8z4axUKCaCMuGfBHuj27Lo1IgfpYT9qy8dhw+a526rbxraBf3lsZ5nHUl5fWxntSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a2LMBlUp; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a2LMBlUp"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46753242ef1so57572351cf.1
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 10:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733943254; x=1734548054; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XevGW6C4cKdzpoiOoSBk/jtqXJQOxnp3pV3eD14Kncw=;
        b=a2LMBlUpzLImQqsd84lDXj0lDeIjrq28cISCxLzqc3EwAWJe+wqomGKsAAqLlgmZww
         4WPwJ4srUp1xkJM7g0dPmOaYsSsNpzZYMbpsbhpIkiDVMWHt/xThfCSmh+K1r3lqxopm
         FaKj+3XDZR3YUdbjB6ZCDd/7FDBJLsNNoHCJG0BHhvhtHfJP0ly8GfVMS75aN1QTDn2j
         wxsVFueszlmusy/mdqlCJCxHcjK4rap3rcU6VAsFHVeTpP0npVOhDANRzCvUqY4k6QPt
         WqM6OCUl7qGBwthaQS6Fme2HBQ/h3LtZXBuVd+J1d1q42fJMI6CndX3gdEtP//zRl8hR
         jKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733943254; x=1734548054;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XevGW6C4cKdzpoiOoSBk/jtqXJQOxnp3pV3eD14Kncw=;
        b=Av6ckTsa89OJBfsHZNEExi1qfl7UrmyiwNMNKkTl9JzqgWiy8VEACbXIBdaT50KkXx
         OhypdqpGdMrRuWP/+bXt6Y5Fr6p7SQjHU+Er4X5wakceOsK8kwxl+mcBZeV2H39V7d1F
         eOdNyCImF7GuPgj94HAXkbltbN4RqYjy5TEN85/1xRJ11qBieu4hjQS8Bu2ddARTGnlA
         o12Vyy4dqf6PcXmVyVX7INdfi/F65F7M/60Dq/ydZO3AgsVGr0/KB11mUcvBffZiOGIj
         2bS8qsf5y9PP5Fe07TKOYATJDjgplOxAFLamlH0Cy6VFtbr2T1yNakFiRa9mHHk+OFqD
         HraA==
X-Forwarded-Encrypted: i=1; AJvYcCVlIewc3EGpYB/AF4UYewwjlGOfqnoT8ADXf+B8w2dUIP2JXAAyMLhpEDC6GkDssSMd3nofNyCb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7piymm1ezODe+fs7DRUnAVbb+1mAgYV0SrkLaVnliuJbV1Vax
	EGviATt+65wIcbFp+qS2SOUZyii/QjCZRyAzCV+2W2u90r8bOJYDUsCiFR/1zg==
X-Gm-Gg: ASbGncuN9mzVw1uVwJSlXP/JgTPx25rpw1xlhlA3Ti4l0uCGsSSDeUBFJYJtYNxbe/w
	QhmM1d3uKKkiMZIj+rR/HYMbs9LvAf4XlMJtnwI9OQKtVmIgIn9kerTFW45IZveqS0mJEYiGdo1
	wwoOjB/OpfZVGBmp/zowg9YirY+UDEEmmAmowTHMcgswf6PzHDgQqgib7sbZF1LwK447owQhG2E
	zfs0h3oisYu3lj1fQp7OkL3AnRDMvN5omAkoSssCdWlP6T4
X-Google-Smtp-Source: AGHT+IFZrtArQk5gSvhPTSsM3vS4f/5WaozCWQBNYMA0H/wDIeqaekdqq8xGvtO0/3PS/0d/l016Gg==
X-Received: by 2002:ac8:58ce:0:b0:466:b29a:9b10 with SMTP id d75a77b69052e-46796234999mr7410631cf.42.1733943254155;
        Wed, 11 Dec 2024 10:54:14 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4676a25e32esm31050801cf.21.2024.12.11.10.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 10:54:13 -0800 (PST)
Date: Wed, 11 Dec 2024 13:54:13 -0500
Message-ID: <e43da8418fc54a5eba7cdbb594b24bb9@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241211_1304/pstg-lib:20241211_1304/pstg-pwork:20241211_1304
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selinux: use native iterator types
References: <20241125110646.50799-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241125110646.50799-1-cgoettsche@seltendoof.de>

On Nov 25, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Use types for iterators equal to the type of the to be compared values.
> 
> Reported by clang:
> 
>     security/selinux/ss/sidtab.c:126:2: warning: comparison of integers of different signs: 'int' and 'unsigned long' [-Wsign-compare]
>       126 |         hash_for_each_rcu(sidtab->context_to_sid, i, entry, list) {
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     ./include/linux/hashtable.h:139:51: note: expanded from macro 'hash_for_each_rcu'
>       139 |         for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
>           |                                                     ~~~  ^ ~~~~~~~~~~~~~~~
> 
>     security/selinux/selinuxfs.c:1520:23: warning: comparison of integers of different signs: 'int' and 'unsigned int' [-Wsign-compare]
>      1520 |         for (cpu = *idx; cpu < nr_cpu_ids; ++cpu) {
>           |                          ~~~ ^ ~~~~~~~~~~
> 
>     security/selinux/hooks.c:412:16: warning: comparison of integers of different signs: 'int' and 'unsigned long' [-Wsign-compare]
>       412 |         for (i = 0; i < ARRAY_SIZE(tokens); i++) {
>           |                     ~ ^ ~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c     | 2 +-
>  security/selinux/selinuxfs.c | 2 +-
>  security/selinux/ss/sidtab.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Merged into selinux/dev, thanks Christian.

--
paul-moore.com
