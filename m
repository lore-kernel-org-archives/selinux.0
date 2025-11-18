Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA42EDD58
	for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495892; cv=none; b=lc5J5OUkwkiUkQypQOiMtpGLUt2RIIJOdZKiJN2rIAt04C8g6Xpo/3fI4wLzho/d9gm9By3ftaTKl8eNtZdbKH/UTCeZqtHHj2ZR3Jv82zPNm4Vc8gY/hUR8G4dhci1FiQVhTzp5TTP9EnOAHACid5vWguL54JBYG/mE1CnzYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495892; c=relaxed/simple;
	bh=rkJd9Jhzjevyi+jRBU8FRSaAEMPIIqn2pd0JAwA/AG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXjVw2lcgG3wzzKbeV0uCI7D17K/IOdXYqvCWObIBgg1iQW6tAhKiGN5mXJlKl5NjpIGUnr2zmxBle1ulamB9kpKRC+bbakswwnoVWHyF+3DfVl2B/TRFboaX69MO0F6zeC2N5yLERcl6DMIbKZhg0rv0W/Alxf6fbfd1Cwx6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FsKifox0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FsKifox0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so7110604a91.1
        for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 11:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763495890; x=1764100690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/NUBTllh151IrEpgnwJ8+JmjPBnmHC7nZQo6tT8Cn0=;
        b=FsKifox0ZXbi8fu+LTKTNSS/bPzoaL5jto7zjxecXQI1DXqm4TX8ttq+Y9Licy4MDJ
         gZsQWRS4EsejOd/lBKbr9o5zzAD6mtdax1WUEOFO/cx8jSpAZDbkuLIzhdzAKqwJis/F
         wfqpl32Pxup7ItKFzwKgPTsuCRVPc9vm8XvWGcPY0zoB5WIojQyG8A/rICTI2ex98TRi
         02UjFIJIleypp5alR7eihR1HNnM5zNEYp8kz1Bz1Nrh/Q5pcG4vg/htRwBnbyHGiCXfL
         fG/5Cn1YLiHvN1Q0ttX7hadUbm9B1M52Yo2kGtIpkhFOOp9qd9PRkC/5MKTWTylK/EBK
         OgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763495890; x=1764100690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/NUBTllh151IrEpgnwJ8+JmjPBnmHC7nZQo6tT8Cn0=;
        b=Nmge06kOhZHyo7gExcg8bI4smN3gINvw0Fxg/9FQ5a+v24weoBfVZfrqdq8MRq+Ncn
         xDcHpeRocmkreyxEH4JaoGP1B/vZAlqY8OZE4UNTh//zlGVwH8Xw7CyJTSNfS0nWlzPG
         xPAxrU+MBczC/k36SaZ1PD2lyDtdX9xnnZpO2vYipjJ3Fn9nGe7pgejFalgOWFwi8E0d
         Osses4pr2doSFZv2AC7oCjt4Yu9OUxJoJkcLxU5eyrBjYFx6t730Q5kyvj25L+/9jSQc
         cKHCJ2UmcUG1eL+4r/+CrSrtrY690gWuM5adae44R8vec5Q/gPH7Sx9YdZpE8NCoiozC
         UoIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWycXKwuBMUmqcTkYszt8ujtCBexnT2leJzb1UpwtWSIjLWXKhdlx/1TwXCuHaHtB4NKekh1ZPX@vger.kernel.org
X-Gm-Message-State: AOJu0YwT01zn79xOTt89Paeyo3/TlV1/4109hFBWy3LB5RShIeQfLVm1
	180BwQonpBzLa65w2BcFIxDTWMBa8SHE6XpUE6Z8RnXZl+tOREKHIYAvqT6vzxp4ONTJtuv5iSQ
	45A5ppxC+2ezEUmY1yquZkbCTHUiqQmVYfsm7FhiM
X-Gm-Gg: ASbGncvAveRKRrYMyndtzYkZqFAp+jZr/JdWKMHYJXYFCi1lFDRvXYfztikqbaLFvYk
	fo9CbzsRG9Daj5pzbUNL+KQPxS9Q8vTn6q60eVe3MR6LIbJxAVJW5JsDaZ9WplWT6aq6LEXt44L
	IjU0kIhavc24YDRDchrIXz8qbXWXmLpDe4xwr/iQRKpCFrEdPtfkZ/0WoZKB9kCU+etPizdWqAR
	bnUwCuF2Hum67R6LQUz79SHJaIeVG43rRo0V+lXO7PXk8fqY+ehTFP7DKptwpDE5f09Ekk=
X-Google-Smtp-Source: AGHT+IFMWDZFzMLQ7wI+3AHqGWgJI1cpjXoudG7lL+/9RNnI6zXBanAKUl3NDGiZqfij7wsKx5V0RwJ5QH4Az7P/DBU=
X-Received: by 2002:a17:90b:3509:b0:341:8adc:76d2 with SMTP id
 98e67ed59e1d1-343f9ee49a5mr20887879a91.16.1763495890372; Tue, 18 Nov 2025
 11:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116205208.734-1-ericsu@linux.microsoft.com> <CAEjxPJ7s8vS_Spt-9wabztTeh-3j+uX6auSEecHZh6RfkPpQHg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7s8vS_Spt-9wabztTeh-3j+uX6auSEecHZh6RfkPpQHg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Nov 2025 14:57:58 -0500
X-Gm-Features: AWmQ_bnKbNjhvdcDKTaPM8nV9JSNktwnqlX35Gv7UUM3vzc2vGNb8FgFApEpbpE
Message-ID: <CAHC9VhSomsUf2ydNs=nmNHnEc6YSZQCaZ8kmUHjCSmg+tNAxZg@mail.gmail.com>
Subject: Re: [PATCH v6] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:37=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Sun, Nov 16, 2025 at 3:52=E2=80=AFPM Eric Suen <ericsu@linux.microsoft=
.com> wrote:
> >
> > BPF token support was introduced to allow a privileged process to deleg=
ate
> > limited BPF functionality=E2=80=94such as map creation and program load=
ing=E2=80=94to
> > an unprivileged process:
> >   https://lore.kernel.org/linux-security-module/20231130185229.2688956-=
1-andrii@kernel.org/
> >
> > This patch adds SELinux support for controlling BPF token access. With
> > this change, SELinux policies can now enforce constraints on BPF token
> > usage based on both the delegating (privileged) process and the recipie=
nt
> > (unprivileged) process.
> >
> > Supported operations currently include:
> >   - map_create
> >   - prog_load
> >
> > High-level workflow:
> >   1. An unprivileged process creates a VFS context via `fsopen()` and
> >      obtains a file descriptor.
> >   2. This descriptor is passed to a privileged process, which configure=
s
> >      BPF token delegation options and mounts a BPF filesystem.
> >   3. SELinux records the `creator_sid` of the privileged process during
> >      mount setup.
> >   4. The unprivileged process then uses this BPF fs mount to create a
> >      token and attach it to subsequent BPF syscalls.
> >   5. During verification of `map_create` and `prog_load`, SELinux uses
> >      `creator_sid` and the current SID to check policy permissions via:
> >        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> >                     BPF__MAP_CREATE, NULL);
> >
> > The implementation introduces two new permissions:
> >   - map_create_as
> >   - prog_load_as
> >
> > At token creation time, SELinux verifies that the current process has t=
he
> > appropriate `*_as` permission (depending on the `allowed_cmds` value in
> > the bpf_token) to act on behalf of the `creator_sid`.
> >
> > Example SELinux policy:
> >   allow test_bpf_t self:bpf {
> >       map_create map_read map_write prog_load prog_run
> >       map_create_as prog_load_as
> >   };
> >
> > Additionally, a new policy capability bpf_token_perms is added to ensur=
e
> > backward compatibility. If disabled, previous behavior ((checks based o=
n
> > current process SID)) is preserved.

...

> > +static int selinux_bpf_token_capable(const struct bpf_token *token, in=
t cap)
> > +{
> > +       u16 sclass;
> > +       struct bpf_security_struct *bpfsec =3D token->security;
> > +       bool initns =3D (token->userns =3D=3D &init_user_ns);
> > +       u32 av =3D CAP_TO_MASK(cap);
> > +
> > +       switch (CAP_TO_INDEX(cap)) {
> > +       case 0:
> > +               sclass =3D initns ? SECCLASS_CAPABILITY : SECCLASS_CAP_=
USERNS;
> > +               break;
> > +       case 1:
> > +               sclass =3D initns ? SECCLASS_CAPABILITY : SECCLASS_CAP2=
_USERNS;
> > +               break;
> > +       default:
> > +               pr_err("SELinux:  out of range capability %d\n", cap);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return avc_has_perm(bpfsec->sid, bpfsec->grantor_sid, sclass, a=
v, NULL);
>
> 1. There is a 3rd possible SID that could have been used here if this
> is always called in process context, i.e. current_sid().
> Do we care? What is the typical relationship among the three SIDs,
> e.g. will two of the three be the same in the common case?

Based on the discussion in v5[1] of this series, I was expecting to
see something like the following:

  return avc_has_perm(current_sid(), bpfsec->grantor_sid, ...);

As mentioned previously, I view the selinux_bpf_token_capable() check
as asking if the current process can assert a capability assigned to
the token.  In this case that would mean the subject would be
'current_sid()' and the object would be 'bpfsec->grantor_sid' as the
bpfsec->grantor_sid should reflect the security context/label of the
process which delegated its authority to the token.

[1] https://lore.kernel.org/selinux/CAHC9VhS5-5+LxEstKX=3DZHNPK6RazRqejXOEO=
Xv-UJjiNsvQ6GA@mail.gmail.com/

> 2. Do you have a test case that exercises success and failure of this che=
ck?
>
> > +}
> >  #endif
> >
> >  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {

--
paul-moore.com
