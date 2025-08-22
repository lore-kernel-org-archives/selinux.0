Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D43F9C5
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828882; cv=none; b=rLe7HXGo0rcKn1M1GwmJwt00S+hDOl6EzMoxbAtZQCY9ILTNm64vQqy8+zFhXOOkKKG1EQa3AJ0E8/03o0hHqhVj1XbodNFkUv7Nlta7NM+h+MvdMvQiCshXvWhb2xpFxW+YxOYg9dTV/5i7vvMmzDbHlkV5DBj7khgOd1sYbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828882; c=relaxed/simple;
	bh=bISpGZXty60XbXO3pu2twUaWVpiPeBB/bjButk1FHZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3Oz4wZaFDQ7I3TruXbMxPrXtWmT44dUoJaDzhH/wS1lfVQ6+M8UIoHfQ+dkubWxDbUnd5M4w1nY3xiVKh6DimZH39bTk6BWHUT4KqprQnWc1aMI521V8yZ5Qkx+io6DEeK+vQfw/8gNxe0ekUsxCuPylm5nbIGqaoofwqahcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z1Bbq+3g; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z1Bbq+3g"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so2058176a91.1
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755828880; x=1756433680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snSTyNlLtKKYHQw2AzoRfTppJ3BqX2cUN0VJIOzBi4o=;
        b=Z1Bbq+3g9ciKMOsbAD8jyLYRz9KGTJ0pZ41Oq6MSa3ndHCR916+lNWgfxjeKkkgRhY
         IY2iI0IiqbjHHAstgzAm2vSnjW+vdbwMzVMNNAzxpBwvJVR178YKsInL5fsJiC/BLQ03
         QsmCY01/Xm+oSRkOP927t+cLnXhMedp6MRZ8aUgA3/YH5YnOKNLhgsbV7QwkHqDDOYQ0
         zLQP3SWcjw+T3xgbIqzrMkAhMe7Bju4FSUhOcSKDeW72guVgmpWtTolOOcsh/wi+qyxo
         hPpGbtgg0n2u7iP1Z8A86v6Gw8eYrDXIVWPQdRHEChdwrH3uBfTj2I7NLovgtJqojaM/
         3v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755828880; x=1756433680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snSTyNlLtKKYHQw2AzoRfTppJ3BqX2cUN0VJIOzBi4o=;
        b=Lydn7pe776VjZRNLmERiUWgMUkKsmAN/OpwptSKh4xviYlYhV2vGfM10inGvPVa3hi
         BSVRjyt/7+T76iwQqhOHVgLHsmM02tfijnJ0GESiBN73THlceDNaoy46tOKjjzc+ktvr
         rm9mPy94WLv1xx4Cu4CaqhFLk4InBNBkYP4zhm2kxnk73JHp5xlkERcn7pLTxLOZ0nHq
         2V9cX2ibuJKBzXYHLeUM/GzBvzjn+EIktksH+R46L4H/QT5PdbRQEGq2xTs3bpJ0u+FW
         4cczqm2nv8TzqdkwKlNrbL7iogLmF1Iez/iMmAkLEDumXMEM1dKijM+XNjo997ekzGZg
         qwsA==
X-Forwarded-Encrypted: i=1; AJvYcCWSVtoGGP3gnP7imA7LGMEAPWqExgWyH6qyfiQBuSFrEHDD9exGIiijTFkMlWG7DaYBwnU6IG4z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qZK4cq4gY7bEKocGaifDsZDFY4w4yKzB20bAydF9sPPvU9by
	ube3CzkF8JhMrNrc6TuVLKANL86GwvCEfPio6ppp+iiGnEfbgQ+KCtHmJrKcFPBH1e6rYOiTDcI
	/8E+EU7GxTz6Zhxx1DJXKOUJDY0UM/lSylnBXkTnw
X-Gm-Gg: ASbGncu/zk4qtHWB5//SZOFywPR3jl8JyN2xJHI9zYjURW+fKelWOP9QEwOec7nid1Z
	nTQKhKLMg7WJ271R8ppxZj/j4fRE+WPDqIP7m7AU4VgtvLBBldNbAeJFtPKDzrSV4U2SeGFko7J
	G51PK5NuBplm2rF67lGPSyv4rXX14fqPWySr0I82ZjY/QIxkI1E16tK+Gsu1kaXZF9JmnDadLra
	S/rV4Y=
X-Google-Smtp-Source: AGHT+IFAM/EmAaCw+9+/FOCkbJwNwLUbgWW82O4+S8unwojlsgKl9CKToeQr/rose4HyFTE38K7RBdKAIbEnxhWKlx4=
X-Received: by 2002:a17:90b:3c86:b0:321:335e:19cc with SMTP id
 98e67ed59e1d1-324eecf9acbmr5923331a91.4.1755828880595; Thu, 21 Aug 2025
 19:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com> <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
 <20250820.xo0hee4Zeeyu@digikod.net>
In-Reply-To: <20250820.xo0hee4Zeeyu@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Aug 2025 22:14:28 -0400
X-Gm-Features: Ac12FXwKudN2CvQnT8J-dwguQbkz7dbQCLtewUNn3PfMmIHoHQBnHVy0atmzERc
Message-ID: <CAHC9VhSS1K0Zsq_ULP4sK9Okwthd+CO3vUdVPAf+F8FKfZsVqQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	=?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 6:00=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Tue, Aug 19, 2025 at 02:40:52PM -0400, Paul Moore wrote:
> > On Tue, Aug 19, 2025 at 1:11=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> > >
> > > The advantage of a clone flag is that the operation is atomic with
> > > the other namespace flag based behaviors. Having a two step process
> > >
> > >         clone(); lsm_set_self_attr(); - or -
> > >         lsm_set_self_attr(); clone();
> > >
> > > is going to lead to cases where neither order really works correctly.
> >
> > I was envisioning something that works similarly to LSM_ATTR_EXEC
> > where the unshare isn't immediate, but rather happens at a future
> > event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
> > LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().
>
> The next unshare(2) would make more sense to me.

That's definitely something to discuss.  I've been fairly loose on
that in the discussion thus far, but as things are starting to settle
on the lsm_set_self_attr(2) approach as one API, we should start to
clarify that.

> This deferred operation could be requested with a flag in
> lsm_config_system_policy(2) instead:
> https://lore.kernel.org/r/20250709080220.110947-1-maxime.belair@canonical=
.com

I want to keep the policy syscall work separate from the LSM namespace
discussion as we don't want to require a policy load operation to
create a new LSM namespace.  I think it's probably okay if the policy
syscall work were to be namespace aware so that an orchestrator could
load a LSM policy into a LSM namespace other than it's own, but that
is still not overly dependent on what we are discussing here (yes,
maybe it is a little, but only just so).

--=20
paul-moore.com
