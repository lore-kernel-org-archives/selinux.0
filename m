Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CAC25A2DD
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992439; cv=pass; b=P+xLUweqCWVjBJXHdY/kxRgGc7LQfu/uvt/MgZS4IewJ6BK4SSH9tI3g6vg384v6T17PP22sp4VwRS5BrWObB2pCNQ2RaVIPFEBaC0I1VJLxhZ5rGuzw2xP3rFfXiYAkCB29sHjCYftDWGt1fZkLWZrQvaDW+HgzmfatHp/WDa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992439; c=relaxed/simple;
	bh=KA14rTsNhcynHUXomk5/91ohEyxcj1BCPlioprKyQ+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmOiMQow+f34IEr7OGrIJbucMq/NgIYxG2WQ92dF4MXTOah92+gAkpbhF8VH9MMDQ4DNGZu/WQR9ilrQVc1Mjdp9xDQZvlKmeDw/4Ruq4tu43BrDcwV9Z3IO4GT1hEopkrvG/7Im2tfp4jhcHwyY9hX6azGc8yT/7zIaXisTEAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXxtlU1f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=afRM3zSs; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXxtlU1f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="afRM3zSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785992436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KA14rTsNhcynHUXomk5/91ohEyxcj1BCPlioprKyQ+g=;
	b=TXxtlU1fFO+pD1F8ggXq1xqoYvqvJriRynjydOjCs/tyhhd9xUyenr8gZKFEjrwpwabn//
	GU/J7oUwgw4htXWxdqkXilwT6oTT1neMGZm68epiYtjQbicjGoF1SQgGhLdiGuAcCnsbTI
	rPUH+94ZbleYUJqbrV27JqZdx4dlItA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-WjVkQW7fPcuTSga9T1TO2g-1; Thu, 06 Aug 2026 01:00:34 -0400
X-MC-Unique: WjVkQW7fPcuTSga9T1TO2g-1
X-Mimecast-MFC-AGG-ID: WjVkQW7fPcuTSga9T1TO2g_1785992433
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e4ef9a74aso3162873b3a.1
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 22:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785992433; cv=none;
        d=google.com; s=arc-20260327;
        b=mZdFpv/vNfBcBrwRYiR4GlhPUK58z5aLEIyHktfNgBGzzvMWRpl8if8QpNYI8sALqA
         v/h8as6a4y3sevcHG+RX2/r3CO9fiBXRCirXR9brbEhIoMrqVnRN+JpRVoRAVQF6I/6R
         hFWeNq98J8MqFvDqUERBjTH2yqYgikYLqf5M5X3BXcqhVRckGZ+anz/hsGzEgrl1cq7Y
         RTojFBvvyquNk6p4NBEjTHKXK78S4dRNRAQRYHBmMLPkSs+UG1TKJHkxAE71Saw6MUK5
         9AA1yO0gdVP14L7r1gEr63yyHp97NDY5ZTPRt2X/Fq/136IVSRYlbP9r0yGFurdu8GUZ
         VUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KA14rTsNhcynHUXomk5/91ohEyxcj1BCPlioprKyQ+g=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=RdaDPEwr7m+UigNjlgRlEtguP3njxdKNgz+iKbrNELbznfJrB5kDrHIQuA6ma+uJm8
         45TjTBjIWs5g9duJory74qQQN/nh81uXZNyc+KExsEwY7m6uVnBFnVi5L7rvbsAtEbVw
         /J1AP7Zf2IBT7CFET9nmlp+FaYZsVjoNm0AFtk73aW4gEpuZAi9FTsLHcEhLtXaGIFUF
         nApJdvE6LfAyfGqHSGLufwdW5CvjwGaBmi9XUlAG4TY524d3eTIBg4mgKolrDWaN9KyY
         Em51zMIp7e2wQoxr+kgwSHwUv3lqIZtRwTXFA2ShCvGoDaNrbw9i/IFllTEJwzJPBHGL
         1kgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785992433; x=1786597233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KA14rTsNhcynHUXomk5/91ohEyxcj1BCPlioprKyQ+g=;
        b=afRM3zSskwa2nF+fF+OPvjt7PSyMgEUQHIZNDNUQ1QQ8ShHqroPHT5qdS8SRA/FasA
         FGqDZyUb7lz0wF8AJC5RAzFwcwIU7AQwVnu4j7x5egXMrBa+OunoLM840hz2h2KU1/Ma
         LzSz/whV6qrgP4wDfUdDDDC92ZPU0NlSJUQQO3zrKrD7Pm2PQBTzH2ninqq+uiJPKLwv
         oAOIcU1W/99OeOCBfSOFICQIsFSGXdi0ggdyogtCqu8kbwobf2IS6h5/9B05HV9907uU
         TcyE2lWRh16nVRQENVHdYDTfU1bID3tBmVx3CHES+qKWofl357r4uJX3gBv0U9V+vlya
         Re1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785992433; x=1786597233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KA14rTsNhcynHUXomk5/91ohEyxcj1BCPlioprKyQ+g=;
        b=fHTkzCMDfKfFBjAMHmI7jeB1m4JHgXeFpORtl3EbjplhVkmhHKCbceKN2AV1ylijhQ
         9k+ybzRbwUVrzSZ3ZWJNtZqLmCNgTqKPXPAjppmTGjA/uOSWzOUpm+IlhkL4ignpEWam
         O7uJPxKJ0l81AVdCZNrqwXxG4L+eL3K+G6oWITT6Boz+IWbEgWVI3/zROv07iDiw/94R
         29Hp+eI2cSNU9oPcTeWzRR61vH2+CwHE6zAUhNX4EiFhlYMFxoIO9e1+lxcElqtH6bHm
         d8dG3y5t6b3KP0gm7hxq/jLI+ymU2XOpvwDcrnF58a0V3Euqu2SY1jh92zZ5dNDPkhju
         4ohA==
X-Gm-Message-State: AOJu0YyE5tbvZG7uaMiXTvpsLtNpyEcbxHJEoYJqTNDh+VNA5XR6X/fn
	j58rsnyucl/pcGbi+6wLAxD+ivMRVzal3smTNr5Wu8iYhuAxn9l4cmFehVOA+5JlWWdZJQrscTT
	E52/LJCj9Uo/xHa2ffCNQX6W/CCBdn30cnCECo3Iwx3uNemdG3m4cyTKu7A3CrR6s72dvHRwjgd
	/NzdwwidSORXKB7n0K3bYkpxEwPOfIMT5ctmryLbvQp+Mg
X-Gm-Gg: AR+sD10WvHhj+bqpaucLVae2NgC7G4Ok8g45wQmGR/OcdDPgV65tJjieaIGTcm1ijQZ
	X+hrjsO2bM/HaWWUzj6WTObS4/+Jg3WM/BI3T0I/fdjZpEtAR1tMLCWYkEIBNB4GsTLVtyz8Aqk
	RKKCMN/ZDkI9HbBuLxU+oiUZE1b4BATFN32WhqIs7E8xVPXHKSiUYQabIv
X-Received: by 2002:a05:6a00:22c9:b0:848:6f5c:a327 with SMTP id d2e1a72fcca58-84f2dfcfa5fmr12768854b3a.15.1785992432955;
        Wed, 05 Aug 2026 22:00:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:22c9:b0:848:6f5c:a327 with SMTP id
 d2e1a72fcca58-84f2dfcfa5fmr12768804b3a.15.1785992432557; Wed, 05 Aug 2026
 22:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805110714.17403-1-omosnace@redhat.com> <CAEjxPJ7wZcydOM1RWAYinmQ_AgJLg+75U0ZSFnGwHNtc_5ZORg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7wZcydOM1RWAYinmQ_AgJLg+75U0ZSFnGwHNtc_5ZORg@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 6 Aug 2026 07:00:21 +0200
X-Gm-Features: AUfX_mw096qh9dQ9Ch0r70eQG8UGZV5LIMd_WPm_K-Hwnx5geCP0IP8IR7onkkw
Message-ID: <CAFqZXNtmJ7gJtYcDWrcjpGLJ0paomZPbE+B8QwcAk+nFPfxVFQ@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/io_uring/iouring.c: bump
 RLIMIT_MEMLOCK up to hard limit
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 3:29=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 5, 2026 at 7:21=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > Test domains may get their soft resource limits lowered on transition
> > due to the typically denied rlimitinh permission. However, the resultin=
g
> > RLIMIT_MEMLOCK limit may not be enough to run the io_uring test program
> > in some cases (low init task's limit + large page size, for example).
> > Ensure that io_uring tests can run successfully in such environments as
> > well by bumping the soft limit to the hard limit (which should be
> > sufficient everywhere) in iouring.c.
> >
> > The issue can be observed for example on CentOS Stream 9 on aarch64 or
> > ppc64le.
> >
> > Fixes: 3b4e44eb3243 ("Add tests for io_uring")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/d03e89292da66e63=
8d795c06840037d27131d82c

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

