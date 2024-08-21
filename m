Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279F1B1D4E;
	Wed, 21 Aug 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252256; cv=none; b=qpgdMUr5IIU96TqwEFB0389NZh68Xt921G/vlcVP8rH6ilVtIss146Dj9uZ88fEip5ZeC/nMKxlAUpgbuqh/sVn3BOfScgTJyDMQQJT7v7vQlFq1u1ZBn21Gv+B9i271DrPBcwwK1mGTeWYH3YbqsRFg3lgRi2AGfQrTWvE+gBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252256; c=relaxed/simple;
	bh=g3ei/xSv/c2CowALX58K1wHRGvHqz2KHG/3SeY2ty5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0BPfg0BmPiaeiHglNKo4xx5lui6BQu990T5pC1KhEfsVyMxx5dxKBcx8glTyErPfMLwOiDavNGK32fNSY2xjrzJjkmfdGkyfbIXgrY6I7T5+4oQtaG4GKNOgh9lGVFFPJduIVDo6hbNbt91xI0mAjrthH66NlKnMoE177XjLWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoM0PeR/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoM0PeR/"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3d9a5e050so4370274a12.2;
        Wed, 21 Aug 2024 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724252254; x=1724857054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMiwYatD/47tzYeAjhrq/9tCSM6j/K7/bPprC637qdA=;
        b=CoM0PeR/V6TTRiGYXgI3pRsGbci3IUa4FsnkVARdMv4dv/XY2ED/k86BFfH2zfc9FL
         rL8rxDQVY0NRkUG08srx/h68ynCXxEiaUZ1tLlLMgatYhR7Ne/uIL3mpyK2tfzwXoZRB
         JjISZgV8jWR8HhUOYMjBO7egsGQ2yTMQreBJYE3r401xIxtb3JRNX2W81qlrS0rkF8Xf
         rIWx+Q69d5LzvG9w9/b6hZ0KDIQX+Gx/nb1R50VUlkevX45HnK+yqGPUGvUXjFmwMvvC
         rkxF1GDUpMjbVbXk6s+4R/e0SeK14I32FVyIOsM6Tqsd75NriTIFl2k02WGfKXB638dg
         PGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252254; x=1724857054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMiwYatD/47tzYeAjhrq/9tCSM6j/K7/bPprC637qdA=;
        b=W+PNB6nJIpXRHssuJJ+RIqKqIKOADKLMJ5+jzSSS6MtpzJ1rYy8xkR/PBcj8Rp/lwf
         LfkARG6C2rr9KaV68DweYSRuJqUVNbt+2afMSHldDu6wtO/7PGacT1loml10m7s7le7I
         BtbX1/S5p5Q1c3t4l4p95JgpDAm7Lv+oJN2E1xU6fdmYGoDM8HL0LoDyauWI1hXPayxz
         2APDrhjiPpw2uFSr7/YoAunr4McbC4FKiEl5CvA6Cmk0OzmkzM4yFzB2OngEqRjQQmae
         oZzUYP318hajVy3V4+J+xMUHReROHAmACArWJ9SWEB1x1uPTU2sTYjbf3E4dVYiEpwr0
         9l3A==
X-Forwarded-Encrypted: i=1; AJvYcCXDrF3pcPRYROgSb/AIMfrlOK5/qOdIPrysG2R5satEGGqSU/TOkFohHSfEfrYI/sKgG1ishIP7qPywFns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMc8Jfct2HgExLG0lLbYzqJsS/7PyJhg+bsQ8etySeIw/577b
	VKzPh8loXQyFoQvOwK0cntwBUvFfxTz5dOT1cFby22gyBLgRIfd6xvSihxAQ1mRwoX1faloD+R8
	gziIMQF0gmn/owBdSTm6dIvsWiAA=
X-Google-Smtp-Source: AGHT+IGJ/4WrIEpPTIiFl2XKjb/TC4GZfqjrHUeVgUNSS1CjM1VQ1xcz/c791z0LvWYH3MGSLiIZL2/A2rerMmtK0AM=
X-Received: by 2002:a05:6300:41:b0:1c6:fc79:f9b7 with SMTP id
 adf61e73a8af0-1cada1a88a2mr2439936637.48.1724252253905; Wed, 21 Aug 2024
 07:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405161042.260113-1-cgoettsche@seltendoof.de> <20240821130755.25031-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240821130755.25031-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 21 Aug 2024 10:57:22 -0400
Message-ID: <CAEjxPJ5C+e3WKeQumo0KO8+Ge4iFR8gKUyfnJPxX84_EKGjh9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: add support for xperms in conditional policies
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, cgzones@googlemail.com, 
	jsatterfield.linux@gmail.com, linux-kernel@vger.kernel.org, 
	omosnace@redhat.com, paul@paul-moore.com, xiujianfeng@huaweicloud.com, 
	tweek@google.com, brambonne@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:08=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Add support for extended permission rules in conditional policies.
> > Currently the kernel accepts such rules already, but evaluating a
> > security decision will hit a BUG() in
> > services_compute_xperms_decision().  Thus reject extended permission
> > rules in conditional policies for current policy versions.
> >
> > Add a new policy version for this feature.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > Userspace patches are available at:
> > https://github.com/SELinuxProject/selinux/pull/432
> >
> > Maybe the policy version 34 can be reused for the prefix/suffix filetra=
ns
> > feature to avoid two new versions?
>
> Kindly ping.
>
> Any comments?
>
> This affects (improves?) also the netlink xperm proposal.

Do you know of anyone who plans to use this feature? Android does not
use conditional policies and it is the primary user of the current
extended permissions feature. I haven't seen any usage in refpolicy to
date.
