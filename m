Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933823C8CB
	for <selinux@vger.kernel.org>; Fri,  7 Feb 2025 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958186; cv=none; b=oxP/esqY6Y/iVFmhcxBb8yLdIddEbwdmJMadq2aBDMexSl4KAoISJxOR9vkk6TwHnUshmr+leZBpGRQMYO+nwAJTInfIw9YySkSKU0o4a6hFh3OXaCarKuUYG2rg+6Emx0UtM7gkXD0euiHOUXRyD7lwTo3maB/4nx5dD5FX5Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958186; c=relaxed/simple;
	bh=9PrWgtsdxJqG2/vhgurkKTvwZh41qENKOdj+a9kDzYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr0dkCjXbN5PBB53jWFxz9Xtgrhhnz/8cQ2KaO91IUapG7H1VbneIhprLWvSeDl+71nlvOqkureVN2BGjmIa7QAVA4BwNwIImcjwn6u9YY0uIpdLFbDDzDIyHqq0fpd289ijiSWXZ1fjkeGl1vDwqrVPqPeThijv0sUwaCpKcI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bA8R3IhA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bA8R3IhA"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f4434b5305so20981087b3.3
        for <selinux@vger.kernel.org>; Fri, 07 Feb 2025 11:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738958183; x=1739562983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PrWgtsdxJqG2/vhgurkKTvwZh41qENKOdj+a9kDzYY=;
        b=bA8R3IhAVpxgjAAfwToOM414nufueEv04cPqvjYUKKC8m18al1HG66tFKlT+620Ti+
         NXhfgUZvnTMQ/8sbk7M29z+b04Q1P2UY54ddDy02Cemk+h/bgudF0jiN1zGeENlVFsOT
         i6BEX6w6E5udR+CO00Ri7LU77/zhvfEA+9JvAHpX1qQK0el2B+VgAQLZWdK0eZFFOwDm
         mK/Rn4Kp58IWbbDGP01rkb4GVStYYJ7wiUmDiqf3yo2c69CUJ1OTDiymhc5LaNrd6qzm
         AG7ys7TMDjMi2jjtCudJV/u3zm/ct706PfILxTWvChWoHhiX2shI4QHQDUx7s9I/yS9S
         PfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958183; x=1739562983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PrWgtsdxJqG2/vhgurkKTvwZh41qENKOdj+a9kDzYY=;
        b=QihctMu2eR9yccztRBqOjUTxwmY0HfIilm6S7z8UOGhL4mlueMbKsNelQRmYmPWXg9
         Uyb6Sp5191oYzYtbxiP/CbhGWdr3sRm2Rqb/sgMVkMTpK4/jBy2y60XO9Jo742dplfE9
         LryKyql9etY4Ls/1FKdacbVep2p4xT0eCiPmX3Ipp1DsLO7nl+Agvx7UHQZM1k+suN34
         LPdXs78aW/b3TCiWmuyTNEGgAxs/wUI+E+RZ+9GyVJUwvnZYkwB6StKW7YGilx+U6GdB
         XyDui219Fn6g+KkD8a0VAol6Lj1/BW1+SMeEWIZPQ/aLEmo+HYwQ1wfT/wiqTNHdJpfG
         cTRQ==
X-Gm-Message-State: AOJu0YzgpivhNFPrAHL9FcR5wO1mUw/jFDsAkSkqV/szbbJoXWwoBU7G
	nVXxgzE4i4ID7o8a2ODVj10wY3HFzo63Ga9ug1LRDarniN2pu3t8Sa7lu3kbA3wY4VboSCgrmV2
	hZ3/ceSelVpeTAzpByI+w1DT+ikLaVdXhJWos
X-Gm-Gg: ASbGnct+yvorkvGqVl65xk5iPgK8B9YAE+Jl9MEPO8JVfxTocQ1G2IlOFGIviBHckl0
	5JkhproV+HjgoGtluazt4rT/tFozsU9hoD8wHIduq6Z9pTe3qlnHqLx0x1SydGVxWZMxvSWI=
X-Google-Smtp-Source: AGHT+IHiqa2y4wG6k4mzfp5RLJAXFPQnrwyMI9IZkyJuKnBQ0JW1Uaglr2D2337SZ1kfMpYBoCAIRVu6BjEGdbsqwPs=
X-Received: by 2002:a05:690c:3704:b0:6f9:8b50:baf5 with SMTP id
 00721157ae682-6f9b29230e5mr42812417b3.30.1738958183750; Fri, 07 Feb 2025
 11:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com> <CAEjxPJ7n-qTTYN1+6XXNiL82ZYiHBujO4ijpKvhiJOoW1xgZkg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7n-qTTYN1+6XXNiL82ZYiHBujO4ijpKvhiJOoW1xgZkg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 7 Feb 2025 14:56:13 -0500
X-Gm-Features: AWEUYZmDR6123kUsOODRYQfwmv4bOn605F2lySzEol04ltdip3U47oNvervoCXU
Message-ID: <CAHC9VhTHRZByZ8rj4PVXsz+znzdGR7E93eoDnQVnTr97GA2szg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/44] SELinux namespace support
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 1:07=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> For those following along, I have created a repo with a README.md
> capturing instructions for how to build and use this support along
> with open issues for the known remaining work items here,
> https://github.com/stephensmalley/selinuxns

Thanks Stephen, the README looks really nice.

--=20
paul-moore.com
