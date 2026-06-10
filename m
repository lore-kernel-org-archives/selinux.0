Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBB140803B
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095775; cv=pass; b=gxW2auTugxgWY5DuhceVvv61kj+3clari/NxW0igxCQd+EQ23v9xYl0ogN+pEk/fndm3KczJCIEk+uOrFmK3anLcqaaTjAzSbHK3S+E1vbOLi7rAmUrNS4Zvwc6RduLEPbIrJRGLcX8RoEUs2tFycJe+NCKTLOOdy5j93HeE/BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095775; c=relaxed/simple;
	bh=RgURrtfe4Bi4WYeAGA902q1hGpQT4DhKDMYPHrpkVO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCC9HCKB28jWtd+U8RWwK1A7RCOdQxA5T4PePrQNy6n3epYThvpZyOHVtJfx7vpK50wBwB0x7bnbLvAn+3nPC80doKcen4fhU1rW5Ze5k0F5E0oCI553e6KDRUZ9JEIS5cibCYyyDm2MIR5z6jmXGve7BAfw06Pm+uS9Pb6iims=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA7x6Nr/; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA7x6Nr/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so48019095ad.0
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 05:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781095773; cv=none;
        d=google.com; s=arc-20240605;
        b=EwdCtHb/5AutLU2KU5Pz3SG+xRp2r10fRJ/UJvPgYDNcuR6DnPYnb3FPuxfyB7OWu/
         zHHG3IZj9I6fXhoSDNHc8DrUC8yOgBLbtpDA0XG0Gqike6ntR9bjgFoBSZF5psUG/uP9
         MpdXZTCIP31q96+HufBInEe7FjyQBlRe9SKN2wn7FBKzesI3e9AdNHafMG1CUOnCi8+j
         f6fuKHKt/TE9HqqFeiM8MINnizewsmuFfY/3I1/RwZUNGdIJZUYDsyep3y4XNZqHBaKp
         wbKGlrmBxYg5UMB6Re66GCS06vZiN6dj179t3q2Ij+uRVmFacgSdShNjkSB5s2MTtGQx
         UX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RgURrtfe4Bi4WYeAGA902q1hGpQT4DhKDMYPHrpkVO0=;
        fh=BSYX5pFzsnodderZ6Fagt5SM/AxwelMKdQExzIDWKBo=;
        b=BNs7o7lGEYj+OYa57rvvPv1vPUbefI2rrwOcMP5+9EC/qO0X8EjZ1ndvDRq3CoCzxQ
         bgww6OMnz1thBRqYyax2n2egzCeiuk8gTDbpy/BbwRrMoxWHNBeGP7vI6bxJ8pEgaXh8
         fazh87lWBVsjcDa6HmGMvvAWgCZnXi7gSwh9DNU64aEFq/ZiXCQBpQVzzcuAgkxbJoGx
         P60fE8PLsTy7IUOqVvHL0n8vkY1dDGypCYMDWvHXefVUM+6nB8pT9hl/N5beQoL1r4Mg
         pbk7m3V8/CECn62js2Esj1UNdIX0qzPpkbz10KA2hIXoxhZUfwaB4ILLgOeKdLqRQzrK
         L2wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095773; x=1781700573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgURrtfe4Bi4WYeAGA902q1hGpQT4DhKDMYPHrpkVO0=;
        b=cA7x6Nr/T6wi3xbcOyEYuzzvxl6taow5U5t32AESQ3rTZHd9nN9JuBfeunswbf4+Qs
         6QakAGpTc0KzRrMbIF9b3MVWfaL83DLJytSj5KJPBnfD6RxhWioaVV1bjoJbPGk5XIlT
         m8Hiv+QnovxlGix9lDkVuhWqPInGmQ7vitZblSEMOVIeCR5sNspnkVHaCf/nlRsUhWt1
         tq16Ds/7ViBUQEb9VwmupCgbSCMleX5K8ew7rZCLp3hW28HhlkT7JsW3oJ8BiWseCjoU
         4kpyYuZiWPUKEdUKIuSsl6DdmHSoOcJvwhyGY5DKsHjAoQ+P22BATO39bBJzowE9SI9a
         p6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095773; x=1781700573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgURrtfe4Bi4WYeAGA902q1hGpQT4DhKDMYPHrpkVO0=;
        b=ANJsKYuXJG0THinSar9l8NkZi+ykKxPigQA3dCvbxXpoLReslYGPZb5gRR03DffIwm
         MrmY58h3aMPZrqwwFyE91Iyoyv0RNfMCdOF7RCTbXEuoNsmskN2cxQhMMwvcTN6gvtvi
         dHyO6wktOvfPbmOn2KfWa728N66qnAkB360tbHu42Ay6ZDRjPKJTs8IPzFoXQecyEsII
         Bji39hDjeJSCCNbaRUFkGhDPiVPyxvuPTaUz43mPvCw9rDebmcofHUivPkZjAsmJM+2D
         cA9OoGYkNl55KBj5QMrJLx2Grnc7tyVRaFMpNBmnQIR26x44YMOBSIz2y1GgaWW0lMAs
         e7dA==
X-Gm-Message-State: AOJu0YyTx9idp/7aC6OWnSkUoQkEqfQml79wUxmYzVByJBd8kY0HHVMI
	WT6anzitLqgGlxWw6H0GqV/xo3XoiP9Vw2oxwNeyQygciY+1vBYeGRHwsKvWStByUYQ3wp1jzBO
	dgmRt6om0JwBpHSqmOd2Itxs5XU8V7rN3vp9J
X-Gm-Gg: Acq92OHYi4Lny3Cax8ZjhPRWRp5gTszd21oZjBOjHACuAa1ZEb4JMHD+EExEGAw8w2U
	HV3O0rhofSl4fcZiv06wxeVFLupbZPXETaKBD1DAcCgahUDeA+rCJtY8YzA0gaGbmahm131gS62
	LS3a4IBXh9Ypoc2Radull6OiodMu+SgtyX2C9zKKXnERcNz4ko9UlEpoDZ4bl8o1EHHoNMYc2Ds
	nyp0eQTT9sDq2iTvxNRDGJZGBd/jVOvwRFxhlm2XFzbH+gTGX7DVVrl3hYqVP7RiV4ETJDrk78l
	vMWsVR2TVEKufPMY9g==
X-Received: by 2002:a17:903:19e6:b0:2c0:b6c7:227e with SMTP id
 d9443c01a7336-2c1e79e1fd3mr259715285ad.5.1781095773229; Wed, 10 Jun 2026
 05:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHLDejxCCVr1kH7JNFnvQM+ct6_mn89rAc+OdVbLaP=cCNkbeA@mail.gmail.com>
 <CAEjxPJ7f6Qb3Yg9Yx3Yuog5jwsg0bD2OEidDnR0U1o9HOj7QCA@mail.gmail.com> <CAEjxPJ7pF7f0uXXU50ECRKr2a4qXBipiGM49Tj0CSmkudcYBag@mail.gmail.com>
In-Reply-To: <CAEjxPJ7pF7f0uXXU50ECRKr2a4qXBipiGM49Tj0CSmkudcYBag@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Jun 2026 08:49:22 -0400
X-Gm-Features: AVVi8Cezt40bDPNXJ0pbyVE3xavKprMI_V248oj_36WdtU4prUu5PIx1kJlBYFs
Message-ID: <CAEjxPJ7DrFPVwO6d5UT37+yfqSAaUG0=zUqS7=iTdDGJ2JLUnA@mail.gmail.com>
Subject: Re: [PATCH] define matchpathcon_filespec_add/add64
To: Pepper Gray <hello@peppergray.xyz>, Petr Lautrbach <lautrbach@redhat.com>, 
	James Carter <jwcart2@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>, nabijaczleweli@nabijaczleweli.xyz
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 3:05=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 9, 2026 at 10:43=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, May 7, 2026 at 5:53=E2=80=AFAM Pepper Gray <hello@peppergray.xy=
z> wrote:
> > >
> > > From ce907fb1daa4d165b29f2d91b3d0958e2eb7f044 Mon Sep 17 00:00:00 200=
1
> > > From: Pepper Gray <hello@peppergray.xyz>
> > > Date: Sat, 11 Apr 2026 15:55:17 +0200
> > > Subject: [PATCH] define matchpathcon_filespec_add/add64
> > >
> > > matchpathcon_filespec_add and matchpathcon_filespec_add64 are
> > > exported in libselinux.map, so both need to be linker-visible
> > > symbols
> > >
> > > fix: #512
> > > Signed-off-by: Pepper Gray <hello@peppergray.xyz>
> >
> > I've added several people who have touched these definitions/code
> > recently in hopes of getting more insight.
> > Setting aside the whitespace damage in your patch, I am not clear if
> > this is the right fix.
> > commit 9395cc03226a0e1a ("Always build for LFS mode on 32-bit archs.")
> > introduced matchpathcon_filespec_add64() and the #define to
> > transparently remap API (but not ABI) calls from
> > matchpathcon_filespec_add().
> > Would appreciate clarification from the originator of that commit on
> > how/if this change would affect the intent there.
>
> Before your patch, on x86_64:
> $ nm src/libselinux.so.1 | grep matchpathcon_filespec_add
> 00000000000175e8 T matchpathcon_filespec_add
>
> After your patch, on x86_64:
> $ nm src/libselinux.a | grep matchpathcon_filespec_add
> 00000000000006c0 T matchpathcon_filespec_add
> 000000000000096b T matchpathcon_filespec_add64
>
> commit 9395cc03226a0e1a ("Always build for LFS mode on 32-bit archs.")
> says it is maintaining the type signature of
> matchpathcon_file_spec_add() on 32-bit but mapping the API to a new
> matchpathcon_filespec_add64() entrypoint that takes a 64-bit ino_t
> argument instead. But there is no reason to expose the new entrypoint
> on 64-bit archs.

Per Claude:

The actual issue is that lld (LLVM's linker) is stricter than GNU ld
about version scripts: it treats a version script entry for a symbol
that doesn't exist in the compiled output as a hard error, rather than
silently ignoring it. GNU ld lets you list symbols in a version script
that aren't present; lld does not.
On musl + llvm, matchpathcon_filespec_add64 is only compiled into the
.so when _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PER_LONG < 64 =E2=80=94 i.e.=
, only
on 32-bit targets. On a 64-bit musl build with lld, the symbol doesn't
exist in the object code, but it's unconditionally listed in
libselinux.map, so lld hard-errors out.
The fix needs to be one of:

1. Conditionalize the map entry =E2=80=94 not possible directly since versi=
on
scripts don't support #ifdef, but the map file can be preprocessed
(generated via cpp or sed from a .map.in template) so the stanza is
only emitted on 32-bit targets.

2. Use --undefined-version to suppress the lld error =E2=80=94 a linker fla=
g,
not a source fix, so it's a workaround rather than a proper solution.

3. Always compile matchpathcon_filespec_add64 regardless of
architecture, making the symbol unconditionally present and satisfying
both GNU ld and lld. This is what the referenced issue #477 comment
suggests =E2=80=94 the function is harmless on 64-bit where ino_t is alread=
y
64 bits.

Option 3 is probably the cleanest upstream fix: remove the #if guard
around the matchpathcon_filespec_add64 definition in matchpathcon.c so
it's always compiled, matching what the map file unconditionally
declares.

That suggests that your patch is in fact the correct fix.
