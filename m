Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224FB34AB04
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629931; cv=none; b=COO2qzGC2RRyB7C+pDyJNtEm6iGB6LN6CcbAg0G3OaANiW989epvrzAZ7B2FtdfSUUmIuyEdbTRy3h6rGxP2BG3+BdaJYS4hT6SuFqFHl6TEJN39UuOd4LsoZQAbGk8Ub8+NvsygN6w7iM8iJvGjVBuOx7BkGEgz6FQxNBWam8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629931; c=relaxed/simple;
	bh=vbXM1NsqZ2wCtqtNHUsPQXGTXJWysQx5wncujdye78w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7Iij+LTO6rDEHLp7hhBTxztylvby68xTgq4PwW+BmJAXaR2S3cEJ/FW6T+PGjpEMl2xkHyAHw5S9eF6JIzTMZKOJEeS/mxdSmBCLrGx7ZzgmCCEanGL91z35h+gksTLQZQ9po0RRbWRVlMWJ+fCeP7AYkF4WwJwp2ExPQWLkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKf+dFZc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKf+dFZc"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33b8a8aa73bso897336a91.0
        for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629929; x=1761234729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0udxFW0ttpZOhy73eChx98Q00vBlhAZPw3nsI7f0Lo=;
        b=kKf+dFZcIa6p6x5LwZFC1qFFbT+0eDzte+Sh+Wkz3x3xD4yWh4dFQDFwBFaxgwzTW0
         AtLPZZanLG/ZddSBorAuaHieLZBw1oHBpYvWCtRqjsSJpceu4meItE+wjBd7/WB19J3R
         cuBnpkRjob8+60VsQHjb86wkGmhbScQjL/GDQ8fLD5SZLneecjARro3wFg2AM7hFYs1L
         aSXaCu6AzkQAlWBusF3srAP/OQwtM9l55L0F9j2rcDnNk5QO1oDiCit4UayOZxwjQ9Px
         xavz5IP037UOr3En83nS713SwLeKti+52C4o4sZ6rnRFlDlFjVnpacZptBNAE5kIa/bR
         uRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629929; x=1761234729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0udxFW0ttpZOhy73eChx98Q00vBlhAZPw3nsI7f0Lo=;
        b=sCdTRlphxEca3fAft+g4pPQgFKqCpIP2aZ76DUbwd1mW7qAxXPlBsJMaBzfWlB1Naf
         yrO1b4XfHKBkXLMNmb/VNINNMthxIOokCNJUKghPsOVkLrVOxTK4jQlZqzxEOQAG/3Fs
         aBgflL9NDG5Nhz4/lZklw5mwv5MUsq2Q+IzLPlxsW4rbm51FSNbkewCxlViFBc5CpfnS
         uCV3Z69jJk0k77wrVLZ+ebfc932a4m0T59gfouUZpzPjYWnajMfrpIK2bimfY4i+eUGm
         BaLhqoT4IHyhybnW7jzEiWau/VEYsY+qhw3ftPWzphzkYzMizAKRlKwlmZHZaIQ8PDIj
         jH/A==
X-Forwarded-Encrypted: i=1; AJvYcCWuAARVlDDrnk8BFnif3ZBMKXHspq8oAIwqUTzGzGGqhzgolJfYbuS+Y/irZ4/Kw2YSP7Oy8UMy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80kGFTt4oxaKEjbIxLAa+lNzYskRtaxqdoYD1cmweUlH8S2Jo
	vbnByDmv4CXKCC+PKygHM/vfVBJwvK+NJ1JiJVFO4BWV1ykbIJ0mOn2HEVNQzYMmEQ/K93mdlze
	TZ59Fyo2G+tfuWGMVgguay6uT6qoSpoQ=
X-Gm-Gg: ASbGncscBmn0AmfkaHt1kgf0HpFnHjjS1hrCOYk9idlGj0upGDCdbtkApt5enMJE23x
	m5HRH36vqTIZCY47WtVPY+CGlupdE9DFUOnNZzbOvhdzmX8PXMD1PI/rpX0xVwVnOFKpED1qhaD
	XTjdeujkZni3+GrK3Dkz3Bd072H/lIvYCX8HT82mUQFYVX1lew+hFHHo+3+LcrRgAr1dLndzaLy
	RTWTEIyR6oAk+cyHjVM5Lwbl4eeTdjqhHotWfFQQrixrwqv+IqIBxFx0Xfi
X-Google-Smtp-Source: AGHT+IFzzFARXAv9Uacq33I+G6rpHakF8mCC5wJYQ3nCqkFuHaNS5wWBPX1s6NLbYtAQorUpDHhe7OMPFjGdIUrNCOQ=
X-Received: by 2002:a17:90b:3c0e:b0:33b:c5de:6a4e with SMTP id
 98e67ed59e1d1-33bcf853711mr317184a91.5.1760629929245; Thu, 16 Oct 2025
 08:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008234613.2150-1-ericsu@linux.microsoft.com>
 <9f91729c4030890ebd10a6faa1009589@paul-moore.com> <CAEjxPJ4SdB1xEM2zNwAW9hgdh7QqbCEOewjaR0t61QnKNKyw3Q@mail.gmail.com>
 <CAHC9VhSAiAbW_-f0BRGXPSDKMesPj=2-wyEbrtDouYpYrq7j2w@mail.gmail.com>
In-Reply-To: <CAHC9VhSAiAbW_-f0BRGXPSDKMesPj=2-wyEbrtDouYpYrq7j2w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 16 Oct 2025 11:51:58 -0400
X-Gm-Features: AS18NWBL1sJQF_Jny-LXPAgohCUBMUMLryIbKK2kpEgJDYICjr8tuxaezyj3w_k
Message-ID: <CAEjxPJ7YU71UuWDa8tVm-dJAF+wZrmhujC9M2zkf+UXB44cEww@mail.gmail.com>
Subject: Re: [PATCH v5] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:02=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Oct 16, 2025 at 10:05=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Oct 15, 2025 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Oct  8, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
> > > >
> > > > BPF token support was introduced to allow a privileged process to d=
elegate
> > > > limited BPF functionality=E2=80=94such as map creation and program =
loading=E2=80=94to
> > > > an unprivileged process ...
>
> ...
>
> > > > +static int selinux_bpf_token_capable(const struct bpf_token *token=
, int cap)
> > > > +{
> > > > +     u16 sclass;
> > > > +     struct bpf_security_struct *bpfsec =3D token->security;
> > > > +     u32 sid =3D bpfsec->sid;
> > > > +     u32 av =3D CAP_TO_MASK(cap);
> > > > +
> > > > +     switch (CAP_TO_INDEX(cap)) {
> > > > +     case 0:
> > > > +             sclass =3D SECCLASS_CAP_USERNS;
> > > > +             break;
> > > > +     case 1:
> > > > +             sclass =3D SECCLASS_CAP2_USERNS;
> > > > +             break;
> > >
> > > This assumes that this call will always be made in a non-init userns,
> > > I'd rather see us handle arbitrary user namespaces, see
> > > bpf_token_capable() for hints.
> >
> > Is that possible? bpf_token_create() explicitly disallows creating a
> > BPF token in the init_user_ns.
>
> Yes, you are correct, bpf_token_create() blocks creating a token in
> the init userns, but based on the return codes and comments in the
> function I worry that this is simply because the BPF devs can't think
> of a good reason to allow it at the moment, and not because it is
> something that they want to intentionally block.  If we don't have
> code to handle both the init and non-init cases we might miss a change
> in bpf_token_create() that could cause us to use the wrong object
> class in the future.
>
> The change to support both types of user namespaces is relatively
> small so I'd rather us include it now and have one less bug waiting
> for us in the future.
>
> > > For a normal capability permission check, it makes sense for the subj=
ect
> > > and object to be the same as the process/subject isn't operating on
> > > anything other than itself, it's simply attempting to assert a capabi=
lity
> > > that it has been assigned.
> > >
> > > However, I don't believe it is quite as simple for the BPF token
> > > capability check.  In this case the current process isn't asking if i=
t
> > > can assert a capability assigned to itself, it is asking if it can as=
sert
> > > a capability assigned to the token.  Due to this I'm wondering if we
> > > should change the subject to the current task, leaving the object
> > > as the token:
> > >
> > >   selinux_bpf_token_capable(...)
> > >   {
> > >     struct bpf_security_struct *bpfsec =3D token->security
> > >     bool initns =3D (token->userns =3D=3D &init_user_ns);
> > >     u32 av =3D CAP_TO_MASK(cap);
> > >     u16 sclass;
> > >
> > >     switch (CAP_TO_INDEX(cap)) {
> > >     case 0:
> > >         sclass =3D initns ? SECCLASS_CAPABILITY : SECCCLASS_CAP_USERN=
S;
> > >         break;
> > >     ...
> > >     }
> > >
> > >     return avc_has_perm(current_sid(), bpfsec->sid, sclass, av, NULL)=
;
> >
> > My understanding, which could be wrong, is that this hook is called
> > outside of process context (or at least outside of the context of
> > either process involved - token creator or token user) since it can be
> > called during any eBPF program and hence we can only use information
> > from the token, not the current process, for our permission checks. We
> > could perhaps pre-compute the capability access vectors at token
> > creation time and cache them for later checking instead.
>
> If you take a close look at bpf_token_capable() and you follow the
> bpf_ns_capable() call down to ns_capable_common() you will see that it
> calls into security_capable() with the current task's creds.  I
> haven't chased all of the callers of bpf_token_capable(), but if there
> is a case where bpf_token_capable() is being called outside of the
> current task's process context we have a larger problem that needs to
> be addressed.
>
> Aside from the calling context, does the subj/obj change sound
> reasonable?  While I think it makes sense, I like getting a sanity
> check from others on things like this as the impact is significant.

I suppose the only residual question is whether the bpffs creator sid
should factor into these checks too as it does for the
map_create/prog_load ones. Daniel's patch didn't have that construct
and hence didn't consider it. If not, then I suppose the proposed
subj/obj change is reasonable albeit a bit strange looking to those
who are used to capability checks always being task-self checks.
