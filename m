Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD415E96
	for <selinux@vger.kernel.org>; Fri, 12 Jul 2024 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720786479; cv=none; b=WuXlu7TkXRua8cOdL5pUxC/LxZRYZm0fA3NlXEVYeP0ea7bfyMZC1wKbennFqmzqMEoFBCxok+SAIrxgDFQLl1TFDgwTB5Wju421PRt7WbwIECUmLIUhOe71akwtN7U59ruEQYlMfVmTG/Ei6MfDYiM+HDtdxIXcjUcNNixsk40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720786479; c=relaxed/simple;
	bh=fuTFABT5MUf3cqu77GVk+O1mR9I350UFIqsgmCUDhtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBwsPPMY9AwUIv68cEYM3QN9V4uHywGfZnRTJCP8oHaGjl2NJyScQm+kCMS7Toib1GUiw26XHe06SURmn+/iYnf53pET2KPOYZK0QBEHjHkO5Pa/8MwRPsbrtAWejm5qMFxEyBL/IY+6aFn8nxDj8VpwGnWPptvJBYEUnO3LeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOM5POzE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOM5POzE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so11657895ad.1
        for <selinux@vger.kernel.org>; Fri, 12 Jul 2024 05:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720786477; x=1721391277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y49vJ1F4Q3RpU11PHofiL+cn8gHuMzO426IDMJzQFNc=;
        b=BOM5POzE8VPl4DrbPNKcSHnl76HBrW+vQ5w+IcHjPsGfubHmSx8+YXejzmB1K36Cyp
         skWTvdHfdWy8NOi23I4Jn46Uv6Cj09XKNU+jpK73xAvaoleW4xvNkLYfaZY9LkBMnaz/
         Ssirqu2UTupfjCdGCj9tpvTutRfXdp+SNiAfXUqDmQaDEi4dcms0v0GshW2aKO+OHEcd
         7C9Hc+Vu36e5n817erJ2JSASuIyc9MEeHxnO7+jKjx0x0oPTZi0xu2GX8OSK3GsScLVA
         Ckcl8JfVaRRbxIMDfFplwMUVC+DoBniRtNAyQk4i6bhqwAFxz7qJ39x0NQhlbWQ0BoIS
         PW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720786477; x=1721391277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y49vJ1F4Q3RpU11PHofiL+cn8gHuMzO426IDMJzQFNc=;
        b=ZOYZ9lhbgr+EKDsGhSG6nNUTgTrLpCtvrwhL6BDrcpTQk9isYQ30jMUq0keSxCzHz2
         DafFip2Bb7CDZobwRhZkd5wflclwC/zjSZPe7c45cbE8qiIrJoD5gtcGTRjUkCJxL9mA
         OrFFcEq+FY/ECc6ByK1ZkAxS003kowc2Kz+w+ejsr0f0Sy7ffTmMmgKBUBB9VLc4Uap5
         2Eacf7DCIiAi+RIuP4lDL41mnxUbnufgGLQG6hzDLn1XlsxmMLU+9EFBxTFjNlANnDZg
         61NVUUJ5sdiGs49uClOEhIuoVcIprV2IW+mLb+Ik+bDh1Am5lAdVh4qTEIrSc7kUc2ae
         gOqg==
X-Forwarded-Encrypted: i=1; AJvYcCXVTRsWbg/35dh7CYKdG1Ae3zoPGLw63lbtoaxLH57xEWsfk7bA8g3KtLtX00Dqw0DYa3gHS4u1Et4xCohHofR/vvMl/jYEhQ==
X-Gm-Message-State: AOJu0YyIyMAcEoVgEx+7LNpG0lyP0X86MoWXezcfaRQzEp7XP69mohk4
	0MsHQEAgVC7Ge1yS9LyGjodAzW3sK/R0fGxBp3NI80qOcwgWpU0KyvDMFoJ/cmnrtow3gmgNuUW
	U/PJXruHojSNP9YNVahuW67XAx+0=
X-Google-Smtp-Source: AGHT+IHnVveCg9T2Ck+/eOEXYxecoswkPIcQ+nQIIfiGzkNuVZ0Wr/29EcjbiZSlIy/t4M04qRDLm/A8yW4XxSe/snA=
X-Received: by 2002:a17:90b:360a:b0:2ca:4a6f:280c with SMTP id
 98e67ed59e1d1-2ca4a6f29d6mr7651790a91.41.1720786476946; Fri, 12 Jul 2024
 05:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711145257.392771-1-vmojzis@redhat.com> <20240711145257.392771-2-vmojzis@redhat.com>
 <CAJ2a_Ddn+UHFLMRov25RiTo-2ffv14nRE24=SC23iA+EmUX0Kg@mail.gmail.com>
In-Reply-To: <CAJ2a_Ddn+UHFLMRov25RiTo-2ffv14nRE24=SC23iA+EmUX0Kg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 12 Jul 2024 08:14:25 -0400
Message-ID: <CAEjxPJ767PpZfKECvZPVUtkUNRFOfWZpca3qd+PK9fX34EA8UA@mail.gmail.com>
Subject: Re: [RFC PATCH] libsemanage: Do not change file context when copying files
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 5:36=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Thu, 11 Jul 2024 at 16:53, Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > Issue:
> >   # semodule -B
> >   # ls -lZ  /etc/selinux/targeted/contexts/files
> >
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 =
Jul 11 09:57 file_contexts
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 =
Jul 11 09:57 file_contexts.bin
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 =
Jul 11 09:57 file_contexts.homedirs
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 =
Jul 11 09:57 file_contexts.homedirs.bin
> >
> >   SELinux user changed from system_u to the user used to execute semodu=
le
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > ---
> >  libsemanage/src/semanage_store.c | 24 +++++++++++++++++++++++-
> >  libsemanage/src/semanage_store.h |  1 +
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanag=
e_store.c
> > index 27c5d349..694c1519 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -731,7 +731,9 @@ int semanage_copy_file(const char *src, const char =
*dst, mode_t mode,
> >
> >         if (!mode)
> >                 mode =3D S_IRUSR | S_IWUSR;
> > -
> > +
> > +       semanage_setfscreatecon(src);
> > +
> >         mask =3D umask(0);
> >         if ((out =3D open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) =3D=
=3D -1) {
>
> The setfscreatecon context should be reset directly after the creating
> syscall (also in the failure case), e.g. via
>
> void semanage_reset_setfscreatecon(void) {
>     int saved_errno =3D errno;
>     setfscreatecon_raw(NULL);
>     errno =3D saved_errno;
> }

Yes, agreed if you retain this approach instead of just using
name-based type transitions to label these files automatically.
Other options in addition to name-based type transitions:
- Call selinux_restorecon(3) after creating to label in accordance
with file_contexts configuration, OR
- Use selabel_lookup(3) prior to creating to obtain the correct label
rather than relying on the source label as authoritative.
