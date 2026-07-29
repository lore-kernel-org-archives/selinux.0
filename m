Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1211A08A3
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329162; cv=pass; b=s1UVGEKDKKFfWcB3o07pRRMG3zu2vGcD3fkHeWJsvQfAuvAkxT0ejQdIrK7gL/uz8eFBBZYxI6cMKGx5sFqyewToIT5KXkayYs1bCvpQwKmzDUNmrO3dLALZUCXVXjnkKc6OC2IDXcsXYwVXc+RsZLBdJm1874KegZyeXO8wn6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329162; c=relaxed/simple;
	bh=zGwaQwzquHvsmwEek8F36Y97FJiQKU/gztulFBofgng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrtztMgnDPqWhmkg2MU5ZQ5y1t+mJMR+AncR2HKIEY7E4y64QhzzpvMFmNDWL4zIAiHec06ZuxMrER2Ku8L3c6D98zTV6pnBDSiGnml2jOtXIP3i5+YMEdE8mH4rlD0EB/EmL4mvZGMKCBN3CNlO5Yjd/ASvx5+M1Lun+3s7Ba0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yway3Zi1; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yway3Zi1"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44856d185bcso637037fac.3
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 05:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785329159; cv=none;
        d=google.com; s=arc-20260327;
        b=gmZ5QV+b9bFY7EnFpxUQTK+nS3BuwyJMCyRU97BvoyXE51Exso1sJ+/Ed5BSPdmJDf
         luJi+XboC2MBk0spE5OqirNl7rsYLviSd/4QE6iLLL3kiEMU4S85bZk8xVWpwQvOgtgI
         KwTFsPhyArp3/pJI6FlxZ2oTqqWU7gVd/mQSsklbckiPm8FZLvVKGWbT7XEVaXCmx/Hb
         9xdbW7Uoo3UFXooymC+lxqSdkxl59yGOSb5AWuIRILtXpKtS/M1zm+iNPEUdInk4W4i1
         fRRfphTylsC1YZtdZi4Dri6y+Di8RUppe3zwU1nGFtFXfE32PRixcSrjosXfNhmm7EdM
         43jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TQ3laoHaHuDQceaCWVdgmx3Ee9LpPfTnsBtoNHxk5ls=;
        fh=PQW2+EFmpWBtO81Y9GXw7FUXUmmIfFgRGhdldCcDDpM=;
        b=GUMyPdh6bJrdSKg12k9xm+GHr0uqaMJnzCgqHShE5zfillaO/aXmGwfrQuooB7MV5C
         pQb8v62JZ5PFkEVDWWZ11WSgeT0M7npKIZApXlZU/i+yz3usST+EtGLFLZAM1o8zkh3R
         tx18X9zSedzQ2PJLkLbshlQuYjSFyeFv/pN9jB0kHtHo7B3yfY8lVY92TaMDTks1yBkJ
         drxqcWKeLmM1VYWG9zhezDg/vyesbv0mSk+sZZC1VzxBbOlwrnpOTDdMJPNbQnsBX8yW
         44aIWDB2I/DYzN4nZLqALQ6XMPqVb1Lgisk26zdu39xuFLmvn4Ze4cv018AhTRBzT4yS
         sEbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785329159; x=1785933959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQ3laoHaHuDQceaCWVdgmx3Ee9LpPfTnsBtoNHxk5ls=;
        b=Yway3Zi1hozDgxlhUTXqeK0x3Oqrj67FjFhPPgEyTp9+9q5fTEhlUEd9AfPKCqpXr8
         ABIVF7o9sls80xQ8qOZk1bnqhgqic7FjYGXUxaTdM2R8LNscEmmFq01uzLFJn31tCc6y
         ZxjQLIsGwFWJy0ntetmLU74GrGkjGVftGjre8smlDa18SSPOGYdq7tqznb8D1RMpCu/Q
         B0jVIXh5LeQKAJpg6dnvEZeadXWBanx4q29ytFQQKsx6wPoavMHk6DARGnvB+AXyPqLX
         /JGhoQXnTMkYQir6Ommw66GNbIniSRQR9i1ZgYL1PoQMwGeVm9tw6EYhnN5GvXtbhWXm
         b7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329159; x=1785933959;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQ3laoHaHuDQceaCWVdgmx3Ee9LpPfTnsBtoNHxk5ls=;
        b=OkT7SYc+jWxFb/veqxasY0mO1YNYvjVAqrfBh26j5lW9dhFl2Dc4YYP6LOWGzf5NtP
         5JNYfQgXi3zwZG3KCrWa50dgicIpY5/CXAGLSsWIuO0d6PXiI+KcCIRtVbkjFvJ5a3Kw
         uLgImjx8gAvz0lwBYzQWELcThSwBzKZikxMagZ4bTenGupVWedbjMjq4sIuE7XVc5Xhz
         QhnekkIAfbuRaH8qoPbQAr2yrzCEywR4uX+aAut4fz6ipppk8J0xyzd+NcOIVYIopbDZ
         YR5Uu6P/U/pbxDonkg18iJCgsIJsEd+E3blLfoUr18YW1IsJOQfgE2wMq4IC/pV9xxZG
         r7Tg==
X-Gm-Message-State: AOJu0Ywk6l9FE7HLz5zBvvpTjPgFWSJz/yc7dIdFvC9SoxMIucQNacF/
	meLTTUuj5GjzOxSGRm83TjaGSiVd/dGi76uEqmfdc/u6kl1YOd7NQXvj8KSilrVxk1C7hyQ6bID
	nKUgeotfbAO6m+PiOTmB1iYu0xXQ9jr8fqoKj
X-Gm-Gg: AR+sD10RiyOgDahzgVv1lUWcGao/uDxmY8bvAO832kmrbJnJaQ+4vefy8mnv5/UDP2R
	r/Xd/Z+KXuk3cx/HjnIWpTz1pV25qRt3pb7Al+iWqshlsDZeGrrJpvVI+WtTZTQ9bLzY+Pu+SH3
	LtWrPwX9BI+MIz7+kcDfnGiwrmXnXtrzTE8RdYgtbW/KGtkw4MT5v/y3aLkbcfdpxT9fcQB1upb
	woTPout8jnmHJsgA/Sj5sveabzXw4J2e/lDjgUmDEX8COdEFWPKLoL297qsarkV9toWDNzlC5Sb
	r+v5tRvx5UuJIKLtdqjoabYZXIhZjoZJyMWyoEMobLYul0cCk4WMy2xH
X-Received: by 2002:a05:6870:c245:b0:456:ed5e:3536 with SMTP id
 586e51a60fabf-4586d1b1dd6mr3519553fac.41.1785329159532; Wed, 29 Jul 2026
 05:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com> <20260723062355.3096648-3-jason@perfinion.com>
 <CAEjxPJ7RsJoivrD+xr9qaC2znKkG2NxZCuMqNRRHVah6h2BwJg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7RsJoivrD+xr9qaC2znKkG2NxZCuMqNRRHVah6h2BwJg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 08:45:48 -0400
X-Gm-Features: AUfX_mx2FuAwI51XbyY7jcUM5Vb48MQODbiz8jpqEzvYknyW7Zbmo6Er-k2Oh3Y
Message-ID: <CAEjxPJ7Xh0NvGJUm5YWVVJykAATGwZBHKfk=z_cSaNiG=LTkWA@mail.gmail.com>
Subject: Re: [PATCH 3/3] RFC: SECURITY.md: Rough draft of codifying the
 maintainer process
To: Jason Zaman <jason@perfinion.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Johannes Segitz <jsegitz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 23, 2026 at 2:25=E2=80=AFAM Jason Zaman <jason@perfinion.com>=
 wrote:
> >
> > Since security issues are quite rare, best to codify the processes so
> > when they come along we can fall back to this and dont forget any steps=
.
>
> don't or do not
>
> >
> > Signed-off-by: Jason Zaman <jason@perfinion.com>
> > ---
> >  SECURITY.md | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/SECURITY.md b/SECURITY.md
> > index 49c40e97..145a2714 100644
> > --- a/SECURITY.md
> > +++ b/SECURITY.md
> > @@ -35,6 +35,9 @@ the issue as quickly as possible and shorten the disc=
losure window.
> >    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0=
EAF
> >  * Ondrej Mosnacek, omosnace@redhat.com
> >
> > +If unsure about whether an issue is in kernel or userspace, feel free =
to send
> > +to any and the maintainers will handle it internally.
>
> I'd recommend sending to both rather than any to avoid potential loss/del=
ay.
> We should also mention that private vulnerability reporting is now
> enabled on GitHub,
> so another option is to submit via:
> https://github.com/SELinuxProject/selinux/security/advisories

We may also want to add something like the following to SECURITY.md:
Bugs in libsepol that only affect policy compilers (checkpolicy,
checkmodule, secilc) are not considered
security vulnerabilities. The policy compilers are typically run
without any privileges and attackers who
can feed them arbitrary inputs can do more interesting things. We will
fix such bugs but will not create
security advisories for them.

>
> > +
> >  ### Resolving Sensitive Security Issues
> >
> >  Upon disclosure of a bug, the maintainers should work together to inve=
stigate
> > @@ -57,3 +60,26 @@ lists.
> >
> >  * https://oss-security.openwall.org/wiki/mailing-lists/distros
> >  * https://oss-security.openwall.org/wiki/mailing-lists/oss-security
> > +
> > +### Maintainer Process
> > +
> > +This is the process maintainers will follow upon receiving a security =
notification.
> > +
> > +1. Make sure all appropriate SELinux maintainers are notified. Regardl=
ess of
> > +   which maintainer was initially contacted, others should be looped i=
n. This
> > +   may also include the kernel maintainers if relevant to the issue.
> > +2. After an initial review of the issue, maintainers will agree on one=
 person
> > +   to be main point of contact. The response to the initial mail may c=
ome from a
> > +   different maintainer. If the initial mail was PGP signed/encrypted,=
 the
> > +   replies will also be PGP signed/encrypted with one of the above key=
s.
> > +3. Maintainers will work together in private to verify and fix the iss=
ue. For
> > +   larger fixes, this might involve a github private fork within a dra=
ft github
> > +   security advisory.
> > +4. Maintainers will prepare the fix as soon as reasonable. Maintainers=
 may
> > +   invite the reporter to the draft security advisory or private fork =
to help
> > +   verifying the fix.
> > +5. We will aim to release the fix publicly quickly, but may request an=
 embargo
> > +   period up to 90 days if the complexity of the issue requires it or =
if
> > +   severity of the issue requires coordinated rollout amongst distros.
> > +6. Public disclosure will involve pushing the fix to the public repo a=
nd
> > +   publishing the security advisory on Github and to the mailing list.
> > --
> > 2.54.0
> >
> >
