Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8DA32D0DD
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631037; cv=none; b=Ufz6ew7E9Bu87rEBtqPlIEyoKpjaX9g7Ar5WWDYyCmYJxQFJtXpZzkmz3uuI9+VEZYzaa876aHj8YwCmBo+WlSKlM+MqBloWfmlUnKJ0IXsRsXlZk+qAq3pxmqIwQKKYAObsHhYFR3g5HSuIS+0MaOQmYTqYFMo9ve2NA3sAm4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631037; c=relaxed/simple;
	bh=5UtGQucdHWvV1VugHg8AwOSOVxwUSSdJwhzi3mHy2TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGdPK1Xtyair2qCLQ5QOVHkEn1zGy+/UlwnpCAxxMYh836JdLumJQMqyXGhZVX2Gqpie5Utm2pWEoHTClYZwZ/ll6OrPtqYnUOjCM4FDVI++As6v+CaRQcZ6ma01WDe16hJu6ZdETbTvpviImZNFRrSbSzXKRJ6A+qGS1ZUD8QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NYCe9kIp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NYCe9kIp"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32ec291a325so743427a91.1
        for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760631034; x=1761235834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2Fw457lsujl863WIGncA2buGEjIZuUiUwxbr3V3/I0=;
        b=NYCe9kIpf/mRszA574OdjvoSPYFzejRcwuj0JOGNmm7dUGLMY1TDT4vaUHc+fYyGTA
         GTKbLI6Y0ycCwGWTfRHkE70lxSrv/wHvHV4ardZofiC1bCO+SjPy8IFp4Ux38MmDXH2i
         PI7DzyHRoMO4oId5IIbGdEVME5mj0JeHSRJoLYWSkt4ijCqEAH/piGZcnZJVO2wKisuW
         gh85m5SBXKxw/cqFS9j9sFv7PpCMbH1Bt0w/JgCTVAxLzj7sISf+U52n4W9l3tZoURh8
         n34hV+JWSGu+pVztnR3RKeXlPpbBx2Dqb2j/h2LxoihDwwqAJPW2ISopVBsBUrXONbij
         qa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631034; x=1761235834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2Fw457lsujl863WIGncA2buGEjIZuUiUwxbr3V3/I0=;
        b=Shlba0f9eR5RmSfwJ6BsM68RH9ECvoN+geaJ0mZIkBnJsCWQLKbrqS1vSnHvs27o2e
         zhPuWNF3zrH/k6uEEmItSvoBmZmAVzffTiaqfFv66jzBLkcFPYfBqWymCZ3feLqkUPZc
         0wJjwemlP4EzXqFMQVbjfsOCuUjwtccjhA635HrBVM6uyzeQMZb0dhti3IenCQVWPeQv
         b4VKKKkp0/tgDlKaXMdP6AojqT3M2Uqq0Uki64qnTuB8yM3AIzESxXHhgs49KREsXUoD
         F40VpNciqZRrUZ6uDosZAIDaWE4LgFb+UQDXOlRqS2JYAuY89o7a0xWZbuAWbyhR8xR+
         AJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6P2RkBOHsSgOvmLUU9Lw6byxeMYJ4N/NvHX3P3/cMPCika5J5e2Myx5OX3jjOgkgxVxr3idlZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfpAsEM3Tyg3JjnY9MlOqH4qx6dFTq5rxylZ0mXqBmHBamiSl
	d+lDWDYgZrlcRZdN6PbatKkgNVbTys8j4JQ6FUiOfmqPSYKOoV7DDRDRZGL9/TPFB0/cpnyIz8X
	uJ2Tav6oyHIDyuiRcjjieX7D0GmC0UZ6f3veT0ywI
X-Gm-Gg: ASbGncuUoOVmODb5k44xNVD5hoKvKIqiBcCVowxPLg+biTqXxH3ef4ZGRdzFhy657v0
	Ih3erMTM/U1pMbs7vjnWrgxOBH/O3sFfOD6Yo1WkoZmf2HcXpcxaMybdJK0OrZsXSms24W9VNSN
	oRI0qHXPBWDe0ugHKPyvouRqW++ldfQrsZI5tNaQUW1d1lhJ29L41azsWzAeEuoruu6vh1NLFwF
	P+AGoVBILll6U2fAMRPZT+AU8LA3xlELPM7ebfk6H+y9m+nSXiG/cYiTmTO3C8JjWdbInw=
X-Google-Smtp-Source: AGHT+IGp38C0cJS6JqiJ1dH0cu4QMdk7Npt2z8JZts5L+nJgnRNXrI+h+Y4ddR4+oD1P7lBoPBzMJK7uS7Yj5h75FIM=
X-Received: by 2002:a17:90a:ec8b:b0:32e:a10b:ce48 with SMTP id
 98e67ed59e1d1-33bcf86c996mr442367a91.12.1760631034392; Thu, 16 Oct 2025
 09:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008234613.2150-1-ericsu@linux.microsoft.com>
 <9f91729c4030890ebd10a6faa1009589@paul-moore.com> <CAEjxPJ4SdB1xEM2zNwAW9hgdh7QqbCEOewjaR0t61QnKNKyw3Q@mail.gmail.com>
 <CAHC9VhSAiAbW_-f0BRGXPSDKMesPj=2-wyEbrtDouYpYrq7j2w@mail.gmail.com> <CAEjxPJ7YU71UuWDa8tVm-dJAF+wZrmhujC9M2zkf+UXB44cEww@mail.gmail.com>
In-Reply-To: <CAEjxPJ7YU71UuWDa8tVm-dJAF+wZrmhujC9M2zkf+UXB44cEww@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Oct 2025 12:10:22 -0400
X-Gm-Features: AS18NWDXtHRKradrU9wzOo4v6MGbn__cnNJfCSlx9imnxCm0RTa8nH6fYJGffLo
Message-ID: <CAHC9VhS5-5+LxEstKX=ZHNPK6RazRqejXOEOXv-UJjiNsvQ6GA@mail.gmail.com>
Subject: Re: [PATCH v5] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:52=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Oct 16, 2025 at 11:02=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Thu, Oct 16, 2025 at 10:05=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Oct 15, 2025 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Oct  8, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
> > > > >
> > > > > BPF token support was introduced to allow a privileged process to=
 delegate
> > > > > limited BPF functionality=E2=80=94such as map creation and progra=
m loading=E2=80=94to
> > > > > an unprivileged process ...

...

> > > > For a normal capability permission check, it makes sense for the su=
bject
> > > > and object to be the same as the process/subject isn't operating on
> > > > anything other than itself, it's simply attempting to assert a capa=
bility
> > > > that it has been assigned.
> > > >
> > > > However, I don't believe it is quite as simple for the BPF token
> > > > capability check.  In this case the current process isn't asking if=
 it
> > > > can assert a capability assigned to itself, it is asking if it can =
assert
> > > > a capability assigned to the token.  Due to this I'm wondering if w=
e
> > > > should change the subject to the current task, leaving the object
> > > > as the token:
> > > >
> > > >   selinux_bpf_token_capable(...)
> > > >   {
> > > >     struct bpf_security_struct *bpfsec =3D token->security
> > > >     bool initns =3D (token->userns =3D=3D &init_user_ns);
> > > >     u32 av =3D CAP_TO_MASK(cap);
> > > >     u16 sclass;
> > > >
> > > >     switch (CAP_TO_INDEX(cap)) {
> > > >     case 0:
> > > >         sclass =3D initns ? SECCLASS_CAPABILITY : SECCCLASS_CAP_USE=
RNS;
> > > >         break;
> > > >     ...
> > > >     }
> > > >
> > > >     return avc_has_perm(current_sid(), bpfsec->sid, sclass, av, NUL=
L);
> > >
> > > My understanding, which could be wrong, is that this hook is called
> > > outside of process context (or at least outside of the context of
> > > either process involved - token creator or token user) since it can b=
e
> > > called during any eBPF program and hence we can only use information
> > > from the token, not the current process, for our permission checks. W=
e
> > > could perhaps pre-compute the capability access vectors at token
> > > creation time and cache them for later checking instead.
> >
> > If you take a close look at bpf_token_capable() and you follow the
> > bpf_ns_capable() call down to ns_capable_common() you will see that it
> > calls into security_capable() with the current task's creds.  I
> > haven't chased all of the callers of bpf_token_capable(), but if there
> > is a case where bpf_token_capable() is being called outside of the
> > current task's process context we have a larger problem that needs to
> > be addressed.
> >
> > Aside from the calling context, does the subj/obj change sound
> > reasonable?  While I think it makes sense, I like getting a sanity
> > check from others on things like this as the impact is significant.
>
> I suppose the only residual question is whether the bpffs creator sid
> should factor into these checks too as it does for the
> map_create/prog_load ones. Daniel's patch didn't have that construct
> and hence didn't consider it.

Yes, good point, I was mistakenly thinking that the token's label was
from the creator SID, but it isn't as the child namespace creates the
token.  I think we probably need a grantor_sid field in the
bpf_security_struct that is set to the superblock's creator_sid in
selinux_bpf_token_create(); the grantor_sid would then be used as the
object in the selinux_bpf_token_capable() check.

> If not, then I suppose the proposed
> subj/obj change is reasonable albeit a bit strange looking to those
> who are used to capability checks always being task-self checks.

Yes, I agree it would be a bit unusual, but I'm more concerned with
the permission check properly reflecting what is being requested by
the kernel.  I also tend to think that the bpf token capability check
looking a bit unusual may be a positive thing as it will allow policy
devs/admins to better distinguish between "normal" capability checks
and token-based capability checks.

--=20
paul-moore.com
