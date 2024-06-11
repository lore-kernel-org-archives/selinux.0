Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B02770FB
	for <selinux@vger.kernel.org>; Tue, 11 Jun 2024 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132476; cv=none; b=SfF0Ek5QeDFjiQDHfriiaF1owZMIwwjxxRtxGsBQgeRYcgzQHE9urMw/Qlq1HexhsMiavk0f63nOd+vPRsuNsLADlhpJOScpVn0nUL8mDiuWLYfjlD2bc+i0Gf4creL0Z8kt/diWqtjwIcWB7kVAr8PN+bzwPEOEvsyFwtG8zME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132476; c=relaxed/simple;
	bh=ENJyu2q1TCIG7X86Dkn/kBr09c7RlEUlrRfjGN+h+lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WH6ugroq2DK6hjfWFESxLkKiqg1XssU/wOAdHS1nqh07R5wkvwK/A2IhBf4GIagXzZ7PnURX8IV8ka3HWdRserBHozwx4XHICYv/oeczp2UK2Esn6nvYcOYJvgnb1ux1BPLtCbwutwfC5Ar4RDf9zftw0C4mCauxzoSlNH3b8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T6AVwgxv; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T6AVwgxv"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48c4739dd39so780092137.1
        for <selinux@vger.kernel.org>; Tue, 11 Jun 2024 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718132473; x=1718737273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIQEfhtUbJ7wSRBw/Z3zFV6dBPlc3fX2vRxj6Dj2nXo=;
        b=T6AVwgxvMWbNKACXjYTAV6vrBVRPd2vr4NSw1Q31b0LWOBTTkhObRxI5jHVPc1u1sN
         S98//NKrQsFF2Qug1uSohZWo3TCbSvdBM3kWjQW0Ww+qIKdf6apXELbXumyY+JKPC3OH
         EqT1WQ+9ZMW+i0eqwzIHoCX0exbf3Q95HOsVnm2ZI/UNEjFM+jY4vppiqJwdgNcEqCz6
         kHqdL0pdKFHs1UVF0EFSsh6H4hrMedBzevW9zwIszoigNqklahEtbEAo4NYwUiCg1hTD
         30zcCbPMDT4yHCirXoFfJBmbsLwxlg7/t13hKuiaC66Uifr7P61e/DxkpxXENJ1Nncfb
         mlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718132473; x=1718737273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIQEfhtUbJ7wSRBw/Z3zFV6dBPlc3fX2vRxj6Dj2nXo=;
        b=OwbJ98WvZ1ZW8K5viM/9ji6uMrULcGEpZFUZtRzBpTSJLgDbdOZ4w9VEPSxzoRsOJV
         nkKhiIMe4P+ESK0MPJLA5EfZclySkmV0LXCA2aQUPYihUxuflrxR4CR1FgCDVtrN7KO5
         Bx+D26Pyx1c7skdBz0aCFJ3E4m8CYO37D3DcZEZ2YrvskBKL6Ls0CA5HgL1vf+5hJ/yD
         xLwAn9gG31G/tq/8ZLTHdOl9zNEpq57rnjdK1bPOp4+MtF3c8DnUsn6QiU8MtZLZp87B
         VSUFEGUWHItSqULO7EI7G1MgQzNIgdG5TSHUDeK/54Nf6vkZlxWxAx/+gk0TTlk6Q9NL
         HbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRbr/FhzeVu26gvn7RZAsYlgJqjEsh2IxONoUv/GiUSFYei7wZDj9MWZ1HFl8PKevxsv8VuFozPUBWSNKiZqO3ZMq6Fp5SrQ==
X-Gm-Message-State: AOJu0YwVofJb9+0Dn8/+Pennmn9MZhSR8d74l/U5Z9k380aNKg61t1wt
	HdPBz8NJZfAB3eVWx8D9tINk2VQROOPvCPgEaScC2P9SfSLHkS8NaqaaN65tJWFMwaQDkWRAGHm
	L7x3kZzXFKCwMAu7o4RNuZWZZbIQcMFoByxFc
X-Google-Smtp-Source: AGHT+IH7RGfkj1TXHCbT0kM+n/35Ll9I9wY3s9K+VYTc8H3wpcJisLGeX88yBuo+qYhZgyhgS/ZiOgeqpnjCaxPdS8A=
X-Received: by 2002:a05:6102:2162:b0:48c:5349:b19a with SMTP id
 ada2fe7eead31-48c5349b531mr6044494137.15.1718132472414; Tue, 11 Jun 2024
 12:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609104355.442002-1-jcalmels@3xx0.net> <20240609104355.442002-5-jcalmels@3xx0.net>
 <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
 <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw> <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com>
In-Reply-To: <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 11 Jun 2024 15:01:01 -0400
Message-ID: <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM hooks
To: John Johansen <john.johansen@canonical.com>, Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com, 
	Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	containers@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 6:32=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 6/11/24 01:09, Jonathan Calmels wrote:
> > On Sun, Jun 09, 2024 at 08:18:48PM GMT, Paul Moore wrote:
> >> On Sun, Jun 9, 2024 at 6:40=E2=80=AFAM Jonathan Calmels <jcalmels@3xx0=
.net> wrote:
> >>>
> >>> This patch allows modifying the various capabilities of the struct cr=
ed
> >>> in BPF-LSM hooks. More specifically, the userns_create hook called
> >>> prior to creating a new user namespace.
> >>>
> >>> With the introduction of userns capabilities, this effectively provid=
es
> >>> a simple way for LSMs to control the capabilities granted to a user
> >>> namespace and all its descendants.
> >>>
> >>> Update the selftests accordingly by dropping CAP_SYS_ADMIN in
> >>> namespaces and checking the resulting task's bounding set.
> >>>
> >>> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> >>> ---
> >>>   include/linux/lsm_hook_defs.h                 |  2 +-
> >>>   include/linux/security.h                      |  4 +-
> >>>   kernel/bpf/bpf_lsm.c                          | 55 ++++++++++++++++=
+++
> >>>   security/apparmor/lsm.c                       |  2 +-
> >>>   security/security.c                           |  6 +-
> >>>   security/selinux/hooks.c                      |  2 +-
> >>>   .../selftests/bpf/prog_tests/deny_namespace.c | 12 ++--
> >>>   .../selftests/bpf/progs/test_deny_namespace.c |  7 ++-
> >>>   8 files changed, 76 insertions(+), 14 deletions(-)
> >>
> >> I'm not sure we want to go down the path of a LSM modifying the POSIX
> >> capabilities of a task, other than the capabilities/commoncap LSM.  It
> >> sets a bad precedent and could further complicate issues around LSM
> >> ordering.
> >
> > Well unless I'm misunderstanding, this does allow modifying the
> > capabilities/commoncap LSM through BTF. The reason for allowing
> > `userns_create` to be modified is that it is functionally very similar
> > to `cred_prepare` in that it operates with new creds (but specific to
> > user namespaces because of reasons detailed in [1]).
>
> yes
>
> > There were some concerns in previous threads that the userns caps by
> > themselves wouldn't be granular enough, hence the LSM integration.
>
> > Ubuntu for example, currently has to resort to a hardcoded profile
> > transition to achieve this [2].
> >
>
> The hard coded profile transition, is because the more generic solution
> as part of policy just wasn't ready. The hard coding will go away before
> it is upstreamed.
>
> But yes, updating the cred really is necessary for the flexibility needed
> whether it is modifying the POSIX capabilities of the task or the LSM
> modifying its own security blob.
>
> I do share some of Paul's concerns about the LSM modifying the POSIX
> capabilities of the task, but also thing the LSM here needs to be
> able to modify its own blob.

To be clear, this isn't about a generic LSM needing to update its own
blob (LSM state), it is about the BPF LSM updating the capability
sets.  While we obviously must support a LSM updating its own state,
I'm currently of the opinion that allowing one LSM to update the state
of another LSM is only going to lead to problems.  We wouldn't want to
allow Smack to update AppArmor state, and from my current perspective
allowing the BPF LSM to update the capability state is no different.

It's also important to keep in mind that if we allow one LSM to do
something, we need to allow all LSMs to do something.  If we allow
multiple LSMs to manipulate the capability sets, how do we reconcile
differences in the desired capability state?  Does that resolution
change depending on what LSMs are enabled at build time?  Enabled at
boot?  Similarly, what about custom LSM ordering?

What about those LSMs that use a task's capabilities as an input to an
access control decision?  If those LSMs allow an access based on a
given capability set only to have a LSM later in the ordering modify
that capability set to something which would have resulted in an
access denial, do we risk a security regression?

Our current approach to handling multiple LSMs is that each LSM is
limited to modifying its own state, and I'm pretty confident that we
stick to this model if we have any hope of preserving the sanity of
the LSM layer as a whole.  If you want to modify the capability set
you need to do so within the confines of the capability LSM and/or
modify the other related kernel subsystems (which I'm guessing will
likely necessitate a change in the LSMs, but that avenue is very
unclear if such an option even exists).

--=20
paul-moore.com
