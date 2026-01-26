Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924C23D2A1
	for <selinux@vger.kernel.org>; Mon, 26 Jan 2026 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467826; cv=pass; b=shMW0yYfgrOwc1CrCndUfOSh11uHTDzD/jJJ2pHQfkSGpVqCvKhnqqb4g8yMp4RLiDHcg/+zp+i9agp0zLbX9ddYFgBVdh7RH9/I5M0OoWFMJv6/f2k7U92+1WJDWdW4aGO7XcVTB/jz8NIImG5bgSOH/pOGgVbT3TCKoqSi8qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467826; c=relaxed/simple;
	bh=46+a/iDHqPPQf3mwVZkJtqT/aUr/0rXY/N+3GsWaHPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F236ILpTcAFjUck5YSYF0KH60KDL39YEI9EE8vwJC8VBpHDQwsIn1aN3/fLuJaUCIAqvBopufxitLNqAHD2lvgYfTMB99RLpws8yiPochXQdMMv7fH/IWlbt4OxGGLeY+jpa97ss32bLPFZT+ehierKJ5WD0eq4PQ6H+sbyv/c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FhpCAHIS; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FhpCAHIS"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso2111990b3a.0
        for <selinux@vger.kernel.org>; Mon, 26 Jan 2026 14:50:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769467824; cv=none;
        d=google.com; s=arc-20240605;
        b=LRm0Ujo9Zke4ZFuAuuqj93/IZe81UeyDV8JoItwMr2Ha3y6G/ARct9MIaf918Q4KNn
         OUv2U9rZJaLdmPUvsiguaa+BGjEHC0HqR8TwsefEiUrwreS1eyUBi3jrVGLOo0R1CxNj
         axKef9vwklpw6bLQDf6yIkZQl9Lv8xzXU56RUVePHw3qGTkCmpyoM9khsFVfjHbUk9wJ
         z3ui02IbPWnhxnJb6pGcrvNU68tBBFH+Y4pwvEFO16sSHKCQyQeqmg2gMdk58KVyAFIC
         G0qnUEOoFsvQzYJy558XisJvVILQdpQqaqF9QxutiY5nSvbTbGkv+Mqlp1tu/R4NlSFh
         qwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IsU1GLIX0RR/n3pdl+FDNmWQXgtjeVq/SYufc3kBVeg=;
        fh=mN1fJvd00c4KfIOxXzjBYpC5x8Hs0Ds54t3lf8Q4zDU=;
        b=PYxmFD3GDlgMXGScRpeHIeNTSoGwveKi4CU0bHAuuFNJ9W8mJjfaICt1WkXdaGui4v
         T457iqcFleuO/H4rlOvc4Xv8Fv8DWF0JjzcCSRuAvUrepwU90AOP8x1Q/FXPq5S4HKyi
         RTaquVRS4vHsCnx7pT2mwgTB+npVRaU/vWhC2e4uX0vLGWJzxJM103Rc4JZPBMN0hc1m
         mi4VE5XobUYNyXX+sbUQo+jPCNs4TG3HbQ8EVq3TZT2+wpwkm440o/XHNQntprhKrsbs
         emNIOKSAhSzUdg0dn/lC0Xb222P73fSx9Gb/L0ge3sw1XBZVCRCTFK87V/XxK+0UX/lB
         HMaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769467824; x=1770072624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsU1GLIX0RR/n3pdl+FDNmWQXgtjeVq/SYufc3kBVeg=;
        b=FhpCAHISSahgiZKVbruJxGmsRcB2FYu8fEW6Uf3DZeOrEZGyjTxfCuaii1hqn7Y/7K
         VenYJQu498UgVIVyzTazxOL+Ta+dBFG6wLByOMxflSyDHZrmhKKnsVe02PKfVjnZS7ua
         PfqLl4qHSwLhZLhP4B3HdlNDxrN8R24/P2orlSzWglh+o3fczSuWcDmWh9aNc8OPySo4
         +mLB4Q8gaPT2y9zCbq59mgSRxTYYPWKPKcbTStgIe9a9k+FbwP9YpZ5nMs/ZwiHfORyR
         HGhFW/tyMOSMqXwTkxEEmDwG0jZTIPUye/p32XkO9UNloU4s52pdG7HjniIyJOlTRJtX
         R16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769467824; x=1770072624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsU1GLIX0RR/n3pdl+FDNmWQXgtjeVq/SYufc3kBVeg=;
        b=uHa0lOhiIoX3xheBu5DVFGjn2ryJWEP5lONNmoK4+Uy/i22lAUU88k0jIPbArykJjX
         +3sYHiZlaJ7fea7D7Q+RuTwqHD2wZbm6hL3DS+Oih31DSTyL1Nu4Q9Q0oFMh8+ea6Njs
         yXf2rb6qfAX7hhjqV+q3WS0cnYcOkjOM2PCUdb8xugtEbZEreSBC7BQHvXRMDaYpQg9G
         au49ERI2T6ILUVbw63SZ/sTomc9rkSQyRUzf6nCLw1x7/v5K29LLoDuEhiyiDDfwOZpZ
         tpPEdX8iArm4EZwbS8HFqJAIAZnSZGc6LOjLIP+H1ZA5LKeOGWQQdNpmIJIJp3PRic3F
         ES/Q==
X-Forwarded-Encrypted: i=1; AJvYcCULwEu6BjlM23AMGOo2U9hkn+s3gEXaA5R8PWipetXGudyHQmmytgsvOBCBkDiGn8lwxOMJ57kE@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqAf/4RPFYDB7QEYul6e8oznetq0uQVYxNLRFoiMOmp5fDJAh
	hk6YORB50n/AHCAewDXUbGdBQsIIK01MFLq2UyiH8Ukp9kXxwvAill+ay7rIOnOLzMiLZqcOfvz
	QqAEIKr+BKmuzDUteGIbvWQi3h5G8JJK7gkgQeK34
X-Gm-Gg: AZuq6aKEWUdIvLeTnVek01lcm+ib28GbUQNlrC3ryjAThgzhqu7dbZeU4gG4ngpYpl1
	Hc7dmzBvrBDPg5CGmnWOzmfCHhr9OkrmUfUnkS7/FhlUbgDBLSoEa7m8NRIEVDPCvGqVjT0TjH8
	jvRLoc8VVD0vRzYNX5GZ0w5Wj/3dDyKsAmCiRtFiKkHPOiCMHiU7r5HrvUD+oqgcO4UAJHh5X3r
	YqnCV7j5P9w5DzDBMRvZbw6tI5+6XuhOwBxJnx6Z/oJGrN69cqEeZEArDVI8vt4VogaYDo=
X-Received: by 2002:a05:6a20:6a26:b0:37e:43b7:5213 with SMTP id
 adf61e73a8af0-38e9f26c766mr5402650637.79.1769467824278; Mon, 26 Jan 2026
 14:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122141303.241133-1-omosnace@redhat.com>
In-Reply-To: <20260122141303.241133-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Jan 2026 17:50:12 -0500
X-Gm-Features: AZwV_QirH6WxkkEtxB_THz4KRLLy86A_qAkPoOWcP6X4SLKJhhu3sJBRiZUB9J0
Message-ID: <CAHC9VhQYLJVweDgBkRo=0_kS1TAUQH_YfT+woSfBW0SjUO4nqg@mail.gmail.com>
Subject: Re: [PATCH] ipc: don't audit capability check in ipc_permissions()
To: Ondrej Mosnacek <omosnace@redhat.com>, Serge Hallyn <serge@hallyn.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 9:56=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The IPC sysctls implement the ctl_table_root::permissions hook and
> they override the file access mode based on the CAP_CHECKPOINT_RESTORE
> capability, which is being checked regardless of whether any access is
> actually denied or not, so if an LSM denies the capability, an audit
> record may be logged even when access is in fact granted.
>
> It wouldn't be viable to restructure the sysctl permission logic to only
> check the capability when the access would be actually denied if it's
> not granted. Thus, do the same as in net_ctl_permissions()
> (net/sysctl_net.c) - switch from ns_capable() to ns_capable_noaudit(),
> so that the check never emits an audit record.
>
> Fixes: 0889f44e2810 ("ipc: Check permissions for checkpoint_restart sysct=
ls at open time")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/capability.h | 6 ++++++
>  ipc/ipc_sysctl.c           | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

This change seems reasonable to me, but I would make sure Serge has a
chance to review/ACK this patch as it has a capability impact.

--=20
paul-moore.com
