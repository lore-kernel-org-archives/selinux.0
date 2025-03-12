Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B41E489
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782875; cv=none; b=hvfJmvjfDUMc0+ppxghyYh6qRzQUhWZJxXQ6vs/qzjUOxsdiau81LqRH9wy56JFnZToudJiMoeNsQr2EuaEoPJliW37GVfHxQ6BGOBtytDpZ3S8WlTQbpj2J8TvEZqE/igRzAJ9VQCEvSPML7elGTtuBHDh6wbO2YinI35lzhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782875; c=relaxed/simple;
	bh=oGKAlLruZC2gJdWmC8w8hWxc0Vq+iXtZG7Q5qQTmp7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIUyySQKkpXzuhSnC6Beg7XMWwoTyAzVVxGNn5WYIsSlre8R4Av5sxRDJuboklnDCsSYVg5pu5ts+f6OwUg8eKXMgWGtUCQ9Nzjj0W5vrv8O3hpDlt2wcrTXYnJwcIb1FdrfA4q5+Uyszox8I3MQjdLVsZQ5mB1E3wT/0BiPc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI5qJHHR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI5qJHHR"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fee05829edso12966846a91.3
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782873; x=1742387673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6BwZOxh6bjthsIBm31dem5Qs0/tnjKjb5FCc8KcK+8=;
        b=TI5qJHHR7WsxZ06NQzGQGw5zFeeJuAPl+YAcB0bOX8HAwVdRnwlA4/PyTrkhGF7vWt
         TxKhc4xPlM7BYvzp3zOuiAyH4C4/L8H3WVwdAnwMrNg2+0OjU3nFs1dqSFtpT7s08EYs
         P7+PR5+8tmMARQLSvM9hHodk8uE32Wd7FiLhRnFG8Qc6ZDMcwz0OnA+QrQ84oaxnzn2Y
         GU++0eht6z/Gt/vupI2skiy6eAVMBm58nMfrVqctMYTdhq55Bo640nR/7PFO8jdhkOE9
         nW+2cPAebGY/q9PIPAi2qhv5Qsb7iHMLF8FoKPMve2nSeC0yr5fFrGcUBmw23QbQ4jcx
         5czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782873; x=1742387673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6BwZOxh6bjthsIBm31dem5Qs0/tnjKjb5FCc8KcK+8=;
        b=kf4WCIumlhsFgoxFestqD3GcS5dgK38QlU3h/bfP6Zhy2PGCamjYZ96R/bNLqBlKyU
         wY2djTjpDiRd2PQwynSLjMbGYjbiR4NLl2JB8yjsXeeIcQ+V+EXg86Jm0rDkhfg0gElh
         L5cOu9bH3KehWFBH4xVZ2RkCWzpSLUhl2IdJYyBQFrqCZz/bcA3R7dfvGvJEXaaraehw
         sjYQgvacLuDN8D5ev6Wa8a2BxOuyEF+etyYYmfE17mFUYI9a8CBJMusHbUtTj3c/WIE1
         bZybKyvY1AFlYs8Rhn+Sl+khLqoRLJSysdejUXinjdm4MJLKdlRfZNzFbTcgJA0FLo4d
         SgzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLitrJKOs/odkvAOmybG2/iViekoqaiK/LHQTq4EcETDsUztAL1DXlp4mVkGzBUfILHTIoX4hd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fazaGcMoYTkpai22tEaXOimxRigDzz/cBJiavQv5E1lIIt6z
	zSCz6EM/WiCX5iapSJLcgkZ7gOZZXbp2rJTDk1oD/mLnWAme0Glt5bXgQM3WMGoGFDlkutYWasw
	+SaTb8DnPvzefj5IvmUkWtHMcL+Q=
X-Gm-Gg: ASbGncs/3tZePqZkBN9nPD8i/eOiU/LMhiLcyqQAbf3xcsgjqmHikdsj00NTZURtmGL
	Mx+EtDh8s8BBa5qDBiEcA/0vUJSN6SABjXbHZvjX00GmxlinZKmOdtUqOUReDHRGj8vvMdhUB6P
	S1gbr51q2vniShujHmIp78wLhgTA==
X-Google-Smtp-Source: AGHT+IHl8ProjulN4al+GWE91y1zBRucLHVYhqL5YUBvAk4vsvLBE/5rDM3xmIVpAk7EZ7rqQucXQqaERD8TRIDz1gk=
X-Received: by 2002:a17:90b:1c0c:b0:2fe:a545:4c85 with SMTP id
 98e67ed59e1d1-2ff7cefccd3mr31661204a91.27.1741782873126; Wed, 12 Mar 2025
 05:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311092920.1114210-1-takayas@chromium.org>
 <CAH9xa6dtem=xKPZhF6s+ttiOsQRyz63Je=Qv1m8edxCV1hE7Lg@mail.gmail.com>
 <510029be-c806-48b6-8d8c-f2ee47ce15b4@googlemail.com> <CAH9xa6eJzCgOJO_wKDyeeZbv9AXMoANt5vFvsqDEtAH_o2oQWA@mail.gmail.com>
In-Reply-To: <CAH9xa6eJzCgOJO_wKDyeeZbv9AXMoANt5vFvsqDEtAH_o2oQWA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Mar 2025 08:34:20 -0400
X-Gm-Features: AQ5f1Jrn0HH0TXRhbwl9N5YRlIo7EKOnEDXVYDd-4nnwjQaxtShyU3UrJC_c0DE
Message-ID: <CAEjxPJ5JgtdggL1Em2jgdZqRNEh7+UaErXaquP5QB=tUuMSZGA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
To: Takaya Saeki <takayas@chromium.org>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 3:56=E2=80=AFAM Takaya Saeki <takayas@chromium.org>=
 wrote:
>
> Thank you for feedbacks.
>
> On Tue, Mar 11, 2025 at 7:39=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Mar 11, 2025 10:42:22 Takaya Saeki <takayas@chromium.org>:
> >
> > > Hello, now this patch no longer appends "*" in the kernel space.
> > > I tested this patch on Debian by creating a modified SELinux policy
> > > where all genfs rules were followed by a trailing '*" and the new
> > > genfs_seclabel_wildcard cap were enabled. Both the new policy with th=
e
> > > capability enabled and Debian's default policy without that policy
> > > capability made correct labels.
> > >
> > >> +       bool wildcard =3D 0;
> > > I overlooked that this should be `=3D true`. I can fix it.
> >
> > Or maybe drop this assignment, since tge variable is always assigned la=
ter on (and modern compilers are good at warning about uninitialized local =
variables).
>
> I agree. Let me drop the initialization.
>
> >
> > On another point maybe this feature can be combined under the new polic=
y capability netif_wildcard, to avoid adding two?
>
> So, do we rename POLICYDB_CAP_NETIF_WILDCARD to POLICYDB_CAP_WILDCARD
> to control both wildcard capabilities? That should be fine for
> Android's use cases.
> However, it will mean users who want to enable the wildcard feature
> for network cards also have to take care of incompatibility of
> genfscon at the same time. I'd like to ask for opinions from
> maintainers.

It is Paul's call to make, but I would recommend keeping them separate.
