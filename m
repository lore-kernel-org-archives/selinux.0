Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867853191A9
	for <selinux@vger.kernel.org>; Mon,  3 Nov 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188008; cv=none; b=fS3rOKg4VBPkFmnqXfXlgs9uF/0kR8uAI2mL30XC4jYZg9EAAKLq3P8EHh8lfr8qwJ41QmHXH10wx2Sy2CviqqUfHa/I1KnOgrr1zi9KgDG/sXlnfPEj0EUDzbzkd6XPBwTxTHmz/Hcp8Q2xwGwcM99z5fPoC/oAs8VbxS4ZF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188008; c=relaxed/simple;
	bh=VFRJsGYs7n3x2iDRa2T1YcONZYBQklPYzEiOEBl8pms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DD1eDUkUJL/141c36i11KiFmRtI2opI6UpAJObQc/XEFJqh1FLAu+LmxgfhOZOyCiXqE2KMC11Tya+AtsuDFTmjWegYAzRgwXBKWDKjVwkj/7EJzw9WAWjtmcorcBIbOWxTT2eLx4iWfNALbul6F6jEP0XvUJpARt1jSaDMm2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=TDhlZa7d; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="TDhlZa7d"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed02d102e2so50976221cf.1
        for <selinux@vger.kernel.org>; Mon, 03 Nov 2025 08:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1762188004; x=1762792804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFRJsGYs7n3x2iDRa2T1YcONZYBQklPYzEiOEBl8pms=;
        b=TDhlZa7dnUnk8mvtUdyxHsWQwnTAMivYiRXdsdloGa6BebsZyifL59KccVXzssPD47
         ucFjI/e54FvghkibIieDUWXvHP1dhjPNL7QQT8p12whnTHs+PUmaVPzQuTePiHPxLqVB
         tpXmPbuWJzgn+dVpFz+7rJZ+9ICqULNYD3RPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188004; x=1762792804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFRJsGYs7n3x2iDRa2T1YcONZYBQklPYzEiOEBl8pms=;
        b=UNxdjnOzbnVURWkbhrnDkhzYIM/nHfkjjKwhNiWLQ8doAcd8pnQZlWLecvN28iG6Bl
         jf7vcK9QEliWTRA1HIoZoZW6DbozQWnbykEr1GA+qwQizoQZCke6oeZuUUMd8QXyWVoX
         vOTcMBzBeXI9rrSg4X2XXqqZiH3N2I9kf4o998ln/dfmUtbHt6dCeEv0OddtRDLdWkoB
         J1L9/ccRHxjJfpnEtvbGAXTjNu+Jos68uKMDxSyU/L+qTzqejqNZwDXzva/7apprIVK3
         JYLs41j9PUnvxFDcSaJvc99FrhIr5ZcOYAekc6RvxAXxVfnvotKnZOu3vehSygYiU5g+
         mXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3348lizcnPdsArwA2DuFaR5qIw8OZcEcNj3kncRB/95GF6WYDu41B7niMBh+/03Vuj1wAG4XV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6KYdlRc84ZqtkJeRoNVp30qo6NtsTfuWtQEb9s8xzi0gsje3
	ZsQWTAR0Wgu4EyFgYpyachQTeYoON5yDm4ZE+Q2X1DigjJ6nG0f/P0J63P67HVA9Hg==
X-Gm-Gg: ASbGncs9ufu/b0tJynAtgNY5UpNBs0ExDPJstyvRJgt9a8VLI6GgZvP6vmUx1tc45k2
	6uQj4ZGqtXbPU+AL+5/VSi7kqbN1vN45yBLZ6UB2bF51IoiZN4T0eLDi6OkqJ9rvT1ipq7K7shn
	1mw4e564CfaNfbaIU7yibfOnnUDUTT/Rd1gh9ceNxDhJsiDYlyK9nu1q9+jMyfiXSD+pjG2G/Iv
	c6e+4xlVqTGJHN13R+ssIFeDjD1i3TXEINSBZMMqJ3qNM0HElN4zb7/7UzB51xliUyJcaAD+Q3I
	m7/MmFK+P9ITmzgnF2s3XrklpaqXZGhysYz7tmox+zX3CUwSEf9iSg/ORdaOppDkGXrA4tSkLTg
	duuEFYPoa/9Aa1qQekxqb0TDx1S7ZIX/LSLEoaLcEuMNWxI70zKh5J2pt1hc37AYvmLlHUJLcuQ
	lbHLIXBwChLfB4IG1jL3kuCsn2vw==
X-Google-Smtp-Source: AGHT+IEk4NKwVocG+q46MfS/6wbmMvQSMdbVpxAuYKNsmt+a3N56ld5ovw9kqu7ifqjbkXpFVRDk5g==
X-Received: by 2002:a05:622a:8304:b0:4e8:b288:7b6a with SMTP id d75a77b69052e-4ed318e1fafmr128016321cf.82.1762188004460;
        Mon, 03 Nov 2025 08:40:04 -0800 (PST)
Received: from fedora.lan.pebenito.net ([2601:145:c282:5650:71bd:20d:33ea:4d98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fc3c880sm1409631cf.35.2025.11.03.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:40:04 -0800 (PST)
From: "Christopher J. PeBenito" <pebenito@ieee.org>
To: Russell Coker <russell@coker.com.au>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux-refpolicy@vger.kernel.org, paul@paul-moore.com,
 omosnace@redhat.com, SElinux list <selinux@vger.kernel.org>,
 James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH refpolicy] kernel: remove some unused initial SID contexts
Date: Mon, 03 Nov 2025 11:40:02 -0500
Message-ID: <27290380.1r3eYUQgxm@fedora.lan.pebenito.net>
In-Reply-To:
 <CAEjxPJ69MpEb266VUoWJUGEBVYPwV6g55nPBh8n_OzGJksrnbA@mail.gmail.com>
References:
 <20251030200720.18719-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6D9DZhzQ4DivTv8y4AVW2hLJa1MciPgdOVywCLU4XG5w@mail.gmail.com>
 <CAEjxPJ69MpEb266VUoWJUGEBVYPwV6g55nPBh8n_OzGJksrnbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, November 3, 2025 9:23:11=E2=80=AFAM Eastern Standard Time Stephe=
n Smalley=20
wrote:
> On Mon, Nov 3, 2025 at 8:33=E2=80=AFAM Stephen Smalley
>=20
> <stephen.smalley.work@gmail.com> wrote:
> > On Sun, Nov 2, 2025 at 8:07=E2=80=AFPM Russell Coker <russell@coker.com=
=2Eau> wrote:
> > > On Sunday, 2 November 2025 12:28:21 AEDT Russell Coker wrote:
> > > > The above is what apparently used to be the policy so it looks like
> > > > node_t
> > > > is being changed to sysctl_t.
> > >=20
> > > allow sshd_t sysctl_t:tcp_socket node_bind;
> > >=20
> > > I also tried rebooting a VM running that policy (previously I had loa=
ded
> > > it on a running system) and got the same result with TCP as an
> > > additional issue.
> > >=20
> > > Also I tried kernel 6.12.48+deb13-amd64 (the latest kernel for
> > > Debian/Trixie the latest stable release).
> >=20
> > My apologies, please revert. Due to differences between Fedora selinux
> > policy and refpolicy, I did NOT test loading of the patched refpolicy
> > itself but instead manually patched the base module (i.e. semodule -cE
> > base, edit base.cil to remove the CIL sidcontext statements for the
> > "UNKNOWN*" sids, then semodule -i base.cil) and tested that behavior,
> > which worked correctly. Looking at the generated base module from the
> > patched refpolicy, it is removed not only the sidcontext statements
> > but also the sid declarations and omitting them from the sidorder
> > statement, thereby perturbing the SID assignments. Not yet sure where
> > this is happening in refpolicy build.
>=20
> Ok, if I semodule_unpackage base.pp base.mod and dismod base.mod, then
> select 0 (Display initial SIDs), I see the initial SIDs with the
> expected SID values and gaps for those that lack a context. But if I
> run checkmodule -C -o base.cil base.mod, the resulting CIL file omits
> any SID declarations that lack a context and therefore ends up
> renumbering them when they are compiled into a kernel policy.

I reverted the patch. We can reapply it once a fix for this is in a release=
=20
checkpolicy.


=2D-=20
Chris PeBenito


