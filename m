Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3687137A49D
	for <selinux@vger.kernel.org>; Thu,  2 Apr 2026 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158309; cv=pass; b=VNpQZj9dRgFagYNqZpj8kSPgJCj0tjc+wwX074z+uDALmD6ShCByNI5p0LO1Lx0vshmC0wewfQd5jZmQ8e1JDqEST5onF2TlCIzA5Nezul5e9wfs5dvqiCC6YaqlkusC2M3pJ8VqlSqrPyPooqaErhSClaDNpbtbDTTnoQlHHV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158309; c=relaxed/simple;
	bh=h4Q0Y5YHf5nDQ1C9hTkU/4FOQDfs8Yi/kGtNKAxFubE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0I7xTDTNr8XLAthGJd7HFUhHjQOg0DqJamNxyoWNUoAiU+t8gr/QVCJzsMqnFCxlyq9GOwmvqIHUACApRYolf453ekESaCP0++F/Dmm3xN1KgjJ3m67UD4S3lOIfogZiadTCDHZVDjEviRTXw/24wbnW8+7y4r+Ap4/kmTF6Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F/Bo8Ef1; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F/Bo8Ef1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b258d93ffeso7424285ad.3
        for <selinux@vger.kernel.org>; Thu, 02 Apr 2026 12:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775158306; cv=none;
        d=google.com; s=arc-20240605;
        b=VQGDELpp+Hs/E83NCz+IPM8IPphUoN//1cdBbgknrau1P2q/CYMKddTNq1SGk682HE
         BjapUTO67NUJ4pqwVnrVYMbyoPHko4ItCRCSjTLIcxYn8O6W/FxY9lUyEv6PkevjTiC2
         UTLKAb/C0EFqEWW2dtMjVVbaPS5KnsHZ8cEe3r8tDDAWy2DQFMhLs0na4lZlOSArq3jM
         BAH2HKoKFOujdUdwxxv80+V4N9WzA2tgFiNljbpvyNWgDcSAhk/UnSGxqNHbl69AN3El
         VmwYu+O9QJgEZ7ZATtdAETtAcEAZK7UasleUHn3gS9UeKHGE5XGDHy5EpvY5gNNpt+0c
         hJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4Q0Y5YHf5nDQ1C9hTkU/4FOQDfs8Yi/kGtNKAxFubE=;
        fh=48DJpVtj3pLvUezlGSRjwxxqu+s4oikmr7+jpHgl024=;
        b=FXbdUuQp8VDFLZwmIK7MIH8lwwWLuVCQgq2ls3nk/ye4PeZYFVVuk9zZyzcEBarzt2
         WUd4AdNTr39AqEBQfK8YmylUOJbx1PqBrN0ecq/5BXMlZP3nqqrAyH8Wk9mk7zn+EJcD
         2Bxr/ix9FA7QrrECOrw362Xk0+txPauh/iExhd43mZeDUyc82x3OlvYzqhhjmvONHOD9
         ldvj+EB/06LWu+CVaKw7BAWFQ4mOysrfcuI3xbKrRIi1PNh/QMWGnIgehsLqtMr4EXUc
         OMPqJCTNBSwXQdhhDqd/fioM7DR+nFdnVPTh2rko1BxAl0tGeBrBWqCPHAHzf8LK7GFp
         HE2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775158306; x=1775763106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4Q0Y5YHf5nDQ1C9hTkU/4FOQDfs8Yi/kGtNKAxFubE=;
        b=F/Bo8Ef1ix/Ip+36dzOWPBR/iRqCVgHYlnI4Lx1gj6WAjW21NzMiSUomGjwE4Kes+D
         EH2kFo36k4WMSuZkipKHnM1GIVU4lCfdS4q0fy7P8rB6v2dqPNVSEdTqB7T3+oSr/Evr
         BgX9YOknQCwI16TVGytJZ50PSwFqRHI6Ae5RYItot5F7Rb23GbFzuq8qr6CAq7wnfKrs
         DfqWbBXcUqt1VxRP9J4cXHE3UFWOJrhW7MJPLCtavTC48ClkMrTlXP9NqUknbFvF/2g/
         EVBxZIcgWuw8t3j3f4RniUtE8GM1yhoU9eN8V6ZiZApKP6rCnCe0iYPIJaC3ITb8xpZB
         Kb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158306; x=1775763106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h4Q0Y5YHf5nDQ1C9hTkU/4FOQDfs8Yi/kGtNKAxFubE=;
        b=Nucl2+aD8OBOQifdmFK15fEDr5U65I02eBtFmUPZH45ER0GF2UDCOzvmYZL+EUGWCU
         sFsu9VqKk7oG53mw0zV9vOby0n7noWxU/fQDPEnq/TEbNqPFdMz76sBnzfSBiuZU8GyF
         wXqt9bVwwhu1neY3W59d/xLqPDRe+sLpeNVHDPNxod6GrJLTw58r5/jj/uhp5pywSD7f
         X14HBdCxC2RYQw7SjTKnEj8cd324apavVJn47bj1+B5RBTXVNtKwGqhu21Uo4JICes17
         5G+MxF1jkcXPd4jrcoNU+cA8uvZVN1Mlh1U4c15v2l/KmgD5oDbF/nxcPlQsb718VTb8
         29VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/DWwlqR96E6/PqtBOTBqepNjfSuMzYuGS8TxTWN5dd3PA8hAGS5sgmBMCzPbtkaJd/2Jy80Mh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+cuYtwjhLTlqXQwT93tyBuBqibzli4FyfiisGV0h/BmNXtSx
	Fcatsr9Q3Nm5e6/c+ruY1cBIhxN8bj8KDayTg8BdJEG65IotizZ1cDTv5EuLe9pIWoKKsLfZezu
	BnOvEY7/m6tjN4VzGpXaMojp1HRH12hio6qExUEDq
X-Gm-Gg: AeBDiev4mLp42zFSxWjSxjblXgTc/Y3JdTBWLQZtETL4JdF2khiAbxI8aHsiY9lv2Ta
	4Si+58ETlXHklvN4/FPAIMkGwCwSgS/rS+29o7zssgf33EAd13secryXadW00sIf+jLaaJ+r1iL
	xMxDYG+xMPIY1M48ICNPCt/ifssxn1ktt5zQ6dcfrV/kXN7zBvzbPWaC1hlB6tkOHpDAULzxYGC
	8lavbm4i4/1SPLbNm8WEUSUY+zRRcbW3t8RCLDMnsTMmnq1r5o5jgYWjMFexjl/gI2ZZgX0xRCX
	VWNvb5c=
X-Received: by 2002:a17:903:17cb:b0:2b2:5a5a:4f2d with SMTP id
 d9443c01a7336-2b28176a472mr5113795ad.31.1775158306102; Thu, 02 Apr 2026
 12:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <CAHC9VhRgi8_gdx0nKwkOws1VD6EFG+bHNTN5Q8YCxZ3HOCu5PQ@mail.gmail.com>
 <aclOtS61nbG5Wf3p@wind.enjellic.com> <CAHC9VhR1R7TcC2a2wZ9-G8dmXTuhcDK1YedDduq0sFgPC8QxFw@mail.gmail.com>
 <ac5MKr4lFQhc44i6@wind.enjellic.com> <5e210223-f9a4-4613-8c4b-bea5eea7f8c0@schaufler-ca.com>
In-Reply-To: <5e210223-f9a4-4613-8c4b-bea5eea7f8c0@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Apr 2026 15:31:34 -0400
X-Gm-Features: AQROBzCKlDtIgICtjmoltlMzQQF_LTufdSQcW4goNdwWquqG4-w9OR3uTEvjvgU
Message-ID: <CAHC9VhQn1=pSPF=n0SnUAKFnsnyTr52OqCCGc0a32LVqx5JfLQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:49=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 4/2/2026 3:59 AM, Dr. Greg wrote:
> > That still leaves the question of whether or not CAP_MAC_ADMIN is
> > appropriate for gating the creation of a new security namespace.
>
> That will have to be up to the individual LSMs.

Yes, exactly.

> Not all LSMs implement Mandatory Access Controls.

... and not all LSMs that implement mandatory access controls rely on
CAP_MAC_ADMIN to gate configuration changes.

--=20
paul-moore.com
