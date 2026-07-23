Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763C45D1A5
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828187; cv=pass; b=gSRhmY1m0e0KpUlRkQ/Y1/wfU1XY+0GmDMOWNv+twYTuhQyHxHvYu1sk4MV5wqgvysWWYaMdO7vqqVtF+Shjb/udbtq4/TE9f9q/CcfeTonZk13DnWLiHar2N/ilzTPBwVy3MaC6XIlhU70uaqSIVZFOOFQ5Wzjyvu0p1Xnv0EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828187; c=relaxed/simple;
	bh=kE8XmJ2RqEvG5XmEUuBS8yxUGybc2ySsWyCa4xgjuiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heG70joM0qowgR4KeuTBNkDfJ0jWJNkq5QaQk6DSNlJVcLivX2YkNtMov//Zk8CBUWv+aAjifluyXtwfjPAhib58/VkZ9C2U4T8EKkVF8ChbGzA73pCPuXCeG+fsO69mEOQJXAdJn2VFygoy3KVm3+0GB+mU3ylqOuoFbljXmO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cCD6gWO4; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cCD6gWO4"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-382ef647e20so986940a91.1
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 10:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784828185; cv=none;
        d=google.com; s=arc-20260327;
        b=Ix05u3pPFBrwgN+4KYHAXTze5LAZqwtMHo/dkqE7lxxVrQ5HLPx407kiKHKeJBRwMV
         Mp2YqUoSPCc3t6d2veXcPsxxyt8ikVnS9aEaHeiBcl2T9YhGCBLa5eBCvcKhcgdP3Jqs
         K6AJ6f59dgBU/qBvbt7y2lTK3wMUqy19lhUfzlJckiZpaDFWYrITzSiLfPQle4z1LIc7
         Qgf0p3VmDUhJ3SwEUXTwT+0BjRE7qC0Odu4HvJvugd8jwUEyUoWgejR+U7hw63hT2duo
         pdUtbDOPPrDO+oYsoJv3ZA4vykntD2ewZ+Do0f6AEk3yGDQhjgDfnrS05DpZU66p58ta
         YPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kE8XmJ2RqEvG5XmEUuBS8yxUGybc2ySsWyCa4xgjuiU=;
        fh=ajj2Xqa02oxaZVhU9kpM7BUI0PZVtB4ZbEqxstui5f8=;
        b=fsyWxCZb22Hkqfw2aJTLUUSnXgs0gN6oFhuwpkKzI/i+TiN7hHEJHIKFj4XM4Cfsv/
         hIkbdnNIdW5vyvkCUUnkgCgAmpNQKdvIx5cCmVRhINyjLqwasuwABOIeQiJ7RkxGZG5W
         PS6QYiYioL7hegD110urI5kHmOufrdTngXpLvVOuh3vT+ohuFEVS0RmEzTDFc836UZM/
         a7YpqHmsl2xh6HCoQjTBkFXNROLpnRUsY3FfLQKYRxDPh/yO/4GPWTMwx1o0viSrRc7o
         Ga4CH/eIutN7QfY1yVpX4RIXKtLXa8okojUiGikVpgv2fjYmVQjGSdHfJIMn6Yj20iAn
         CfaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784828185; x=1785432985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kE8XmJ2RqEvG5XmEUuBS8yxUGybc2ySsWyCa4xgjuiU=;
        b=cCD6gWO4qTrI2a85l2Hzr9qjRuKZnF+ZWGZ4/2UmxJLgOaKkO2WYZfD7xt7sUF31dM
         WDu0ntyFNB7TtjP3B9XAtEzVDQYp0lDjdZIqZbD3qMttnh0o6/FJc3W0jcc22RAB0o8W
         5Vzj2J2UNOFXHH0lkdBW+4+GS05+THMJzolsNet7xI/+k+KzOq85cx1akomgRoDoWbN+
         X8FePoy4Fxpaecuc85muPa5cmzQ1NzxoDjwY+uwuFXP70WYLhoVjdj/pMYUkNafHj1qR
         JfUu7LvvjGbRkaVNN1brk5X+Up6U3CzuAj9WtmC6HqLyhG8qpXj2fWq5jqWW32eM916z
         CRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828185; x=1785432985;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kE8XmJ2RqEvG5XmEUuBS8yxUGybc2ySsWyCa4xgjuiU=;
        b=Plzi2gJONrextm6I4Gdq4P+OE32Zci/A46VFH6rdv/OmIDUWOuKm9TTthcmfF/Xpvn
         6/0rk/+gzdwRVOwwP3iqO6JeHh+KXHPK5rcSokttiL+egJO0OByRjencntN1AUsQsBlq
         XE8lF25Aozv24rmVWEJtu+Qy9E3L5D9qFSbwCv0W//io165eYuFjMp1VOJwQv/+HIQT0
         fVaQTPA47XfdW2jAoKkPLXUgtaU2bC28KfIyK/Lo7fZY0e5QhuFI05WWTh3rlcVC/1Se
         4iAkSU3Pq3jtO+7ioUDJgNbbt6B/ryYpHFj7OoW3pIM2HEK6yWBIZBvUmIs4Rgn143ka
         OdVw==
X-Forwarded-Encrypted: i=1; AHgh+Rro+p+RzAt7A0mT5YTdVhqo5HvHzIznRRxoHxbrWMzgi4tqyPenSmL0j1OJpEOvOc6Z3tU/R15C@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7LGU5Rwa20S/ezCrfT+i7A5q34HTClDgWylAqXEelk/fuAsOp
	RuzLoYRT5FPTo59guagYfYM0oicdsGGEyB3kKIxSALlszBdM4LU5oiOvyIcMBG5xfLFNTWgsl9y
	mgyBqWq94ExR3HDDZN/PoeyL3P1iB9R1B2pN1ChlV
X-Gm-Gg: AR+sD10JhGCz6frynrZX6bfrdjx7/TWTDl4jgUH4sducPXLhOU2m+OVp5r6vZBtVeTQ
	P8WNHd8o2YbGanjfHE0LocXV5M5YHCCdtAHCRZLnYtkWpczyc5Jma2AUKAI1FuIsfh7KJwQbWp+
	wA2ow9SjG/q+K4Wvt+2WcnXStHPQKBetfYasDmxOsuQ/mVAmzEQCpVK7FEFu0qzfPBlBiZnGmQG
	+J7dXzmyPILbE/STYuf9hC1xd8xV34ANT/qB48mrl5HLmI8pHlWGaMLw2ha3/h9oYthXuhu
X-Received: by 2002:a17:90b:2d46:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-38ec6453ea7mr4181173a91.7.1784828185536; Thu, 23 Jul 2026
 10:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com> <20260723062355.3096648-2-jason@perfinion.com>
 <CAEjxPJ5cdX3vZZmE3tLfY7Bk_YapnVU3erzeXUtGsy3wbK2BLw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5cdX3vZZmE3tLfY7Bk_YapnVU3erzeXUtGsy3wbK2BLw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Jul 2026 13:36:11 -0400
X-Gm-Features: AUfX_mxC9uTpXe9O5HJKfR6SZx1hzt1Zb9kBmGdxs2kJ2SmyGb8MdfEVbq3I2gU
Message-ID: <CAHC9VhQ2A878m1yTBxQc5a+GzhMSgPYR8wqp39URh37niFp=7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] ci: Drop circleci config
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:48=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Jul 23, 2026 at 2:25=E2=80=AFAM Jason Zaman <jason@perfinion.com>=
 wrote:
> >
> > We have not used circleci in many years, the configs are very out of
> > date compared to the github actions so need to get cleaned up.
> >
> > Signed-off-by: Jason Zaman <jason@perfinion.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
