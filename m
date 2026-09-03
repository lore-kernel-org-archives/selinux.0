Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3446AF2D
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453148; cv=pass; b=JjGumg/RBak/ZEtV6lr2Feh2ZSfRrDUnKyrKc4oLSHfCP9BvrON8KyHX3OkWqzYcFEekJ12wlVR6oKWqOV28BuYhluV4CuJMb2rPtwQNoMHi3Vuzpa4mTdQXGY/zBVJhAYhR2wGP9QYB6l0uGVPoKS+FeADY0bCvQSK13k7q5P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453148; c=relaxed/simple;
	bh=3Y2aXfnJkBWlUeD18cPJ4yoZg6JRr3jC8fdriAznDsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwIiu2O+eHfdu2evpV44Mv7Fu+rMCFAhDub0dJc96IJ4EaUZLmyCVjJ8Oqf0HHnW4vIuPbceGF/OZODsPOObG+MBPCn9plFSxftVkjqeJ+wb6BDg51UkeYoayPhiK12bjTNmCkBZaCtxdwz9bPEfyDwlqPUBSlfQ7fwdz94za1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTa29NPe; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTa29NPe"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90cd4631090so15673896d6.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 09:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788453144; cv=none;
        d=google.com; s=arc-20260327;
        b=XsPi8ytPCnDo/8dlIk4xAWEdpmRSp6xN8p9pMhPqcVYBoZYItf5EhbjASCEQjzBSQq
         +r6SwO2avCbWY/jFfAdiIme/gPVRjwTX1vIgStIY+pVJz8nrOlbt4SPLEkGoMTCnzcZ/
         v17igOm8X7PF9taSkW00g0fR+hEHvq1YawwDXVLp9eFZEM4QlO1nYp3Ea2JgjK71233p
         6VuBimUovtY38b277KmctUNSF8UMNO1wvx695mfNJqE89pmoBpmopdvyR0I+0RWpx553
         kHcWh18CIRBrNUE3Yz3dBxgefOItEg5GRuoF3S6CKmRtYd1n8bY/I8Ef828LQzbviPen
         va4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gQOAwgWsioiU3+7iKmN86fBBXc/5mhH5Bi/DPqov8iU=;
        fh=AQnnUcjcUYpWlp25yduSBOrX2TDQdvMOewmYwjwwoqA=;
        b=iTAB1zClwjIdpO0zU6rM4xw5/wU7B4D40GHvU/VhJ7PHuRM/IggXjkgl00mNnuiRUa
         QOdpEQLfw06Apjfgpncr+Knfh2zN4tQqHhvlJDeigd0/S0PSuZdjJehr1Q7nrnuP8X+G
         5rozFnB7sKQe9u6YidzDhKDQeq9TrsJcsxF00f9fhCutAl139SkpsA9WM8CWxyVP8hoF
         eqejqVFce1G/VIFmvUez8+W8mpnK0tVn6Lii5uEMhCPZ+iRLUNTDZEgPEFaNlXGZzgI6
         aeDZGyf/Rwnp4tLqp4ZgjYETDklyMulrqFduNh4Jm3BgJMlXxs2/T/ILdoaDW6jaWRgZ
         s9yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788453144; x=1789057944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gQOAwgWsioiU3+7iKmN86fBBXc/5mhH5Bi/DPqov8iU=;
        b=eTa29NPeC6NqtzGiuW8zOa2kLQ0N3cTbvmwzZWPyo1HARqvYp+ZaOQLTugi9oneBxT
         XYrAlEfWaVQLtkuJaINFYQp4ow7QzfWWvMfEXNuABe+0ktdPNJ+iJvPcIn8z0kWi+si1
         tfLzUV4rC0qgr/zY0vClBiGGPrL6oXiy8xMwSisbzEBJhANYQrgHb2Tjz8rvrBkYdvN4
         iH35g97ZeW2PCqkbz/2d6sPLyoIW8Nm0cs2fB48kIsLd4I9MrcvmVDTVIqEW0lvYdgOl
         a7N0vsppaU5lMJi2VaTsLgjblou69+jRrpHtop/uIeVQE/OXVIHKsw0QVkYdGKo2592J
         lUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453144; x=1789057944;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQOAwgWsioiU3+7iKmN86fBBXc/5mhH5Bi/DPqov8iU=;
        b=Sn1aCefkgLq8ypKiMDlTFiPLD3Zinu0OYD1L5cOO9J6I6MuBAol0x9rZcJnf2IlpBj
         VZSWYWCBiVaSFT2g5HFLfDs3+qAbEA1wF1Yo+KsKmZiAfWkZjuZ0XMm5WOEmO35uHQrp
         e9sPjBZtMqZ+VtAJkM/oepGWPMEeGKcsZmh4/AZ7C+eLVrzutV4HzbFm2cIOl5uxLIwd
         urQkkQ5NYmLxb4gMAmPOB4SRWLusXoZs5amedegejJptM0Q2TUjmoHj9tRvQmZWxdGD6
         QdudymFgWcC4VpwwGEm34Y6cnht7wATXM/ZchBJldfhQkh8UQT3PHmk7shgSV64EChEP
         BBow==
X-Gm-Message-State: AFuF++ldqZASf94+VPHaj1i7RlXnq9/OBNjwbsoVch5M5ZFY85UKAs+X
	GdY3QDoBlvBqKVCZPWKEggWaAdlJpxXRF5B7sNUq9BdvIZy+Qo65BGo4zia+TKm5uUPLSmWekIx
	qmTdpgXgUUPI8PRHFocC6coiyPnHhbt8JFQ==
X-Gm-Gg: AYBFou0cf2nvWy0YXDpytGaqlk5OWnxlYgIpch8apBxLZwhgpqQaanungT+cCPbMQgO
	lqhfsu+si5P7EWuTbeZ2Sxf9J+m2zL/oHhTZDmrHpxbyOe0/MqfGKVV63n+wFS5wiRPMQkHFulK
	AH0O5iL57ntiUxf35YWf+dXzhWAtgTKiQsxWid44cBTrp+MoE9oTyrbz4h1pn0KaIv2AprUK0rk
	FfZhHnuwOEOMu5A9dEd2hbnktZNwkt1JrJT6wZz5jToxLJYscBWIqKGVovQ5Ojn6ePbfJo9+/J0
	KuquN9oyZh/j2veY54WPCG3a3Zm3vnCcUAIswkP0mo/U
X-Received: by 2002:ad4:5cec:0:b0:910:3923:cc7b with SMTP id
 6a1803df08f44-9103923d189mr38066196d6.36.1788453144229; Thu, 03 Sep 2026
 09:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903151347.1513631-2-lautrbach@redhat.com> <CAEjxPJ7isYB2FekKMubJrDgdCuaRc27w6Rwfo9==BPe0GY4iyQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7isYB2FekKMubJrDgdCuaRc27w6Rwfo9==BPe0GY4iyQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Sep 2026 12:32:12 -0400
X-Gm-Features: AcwNN1XCeGmj-LyI7z_0Na4fIjrJQc7uTgTXi12LPV5oIy5eTDOstk5fDAPp2Bg
Message-ID: <CAEjxPJ6MdgdzEbV4LZsDseuPgARBDJ0YZ7xMA5DaSrh5TO8-5g@mail.gmail.com>
Subject: Re: [PATCH v3] Add support for UTF-8 in file context labels
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:24=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 3, 2026 at 12:00=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > - libselinux to be able to read UTF-8 spec entries
> > - libselinux to compile regexes with UTF strings
> > - initialize locales in setfiles, sefcontext_compile, semodule
> > - semanage_exec_prog to execute external programs with LC_CTYPE set to
> > the current environment
> > - disable UTF-8 support build time using DISABLE_UTF=3Dy environment
> > variable
> >
> > Fixes:
> >     # cat unicode.cil
> >     (filecon "/opt/=C5=BElu=C5=A5ou=C4=8Dk=C3=BD(/.*)?" any (system_u o=
bject_r user_home_t ((s0) (s0))))
> >
> >     # semodule -i unicode.cil
> >     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file=
_contexts:  line 2145 error due to: Non-ASCII characters found
> >     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file=
_contexts:  line 2145 error due to: Non-ASCII characters found
> >     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Inval=
id argument
> >     libsemanage.semanage_validate_and_compile_fcontexts: setfiles retur=
ned error code 1.
> >     semodule:  Failed!
> >
> >     # semanage fcontext --add -t user_home_t "/opt/=C5=BElu=C5=A5ou=C4=
=8Dk=C3=BD(/.*)?"
> >     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file=
_contexts.local:  line 4 error due to: Non-ASCII characters found
> >     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file=
_contexts.local:  line 4 error due to: Non-ASCII characters found
> >     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Inval=
id argument
> >     libsemanage.semanage_validate_and_compile_fcontexts: setfiles retur=
ned error code 1.
> >     OSError: Error
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> > ---
>
> > diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> > index d6b5bf0252ba..f632a87275d4 100644
> > --- a/libselinux/src/regex.c
> > +++ b/libselinux/src/regex.c
> > @@ -96,7 +96,12 @@ int regex_prepare_data(struct regex_data **regex, ch=
ar const *pattern_string,
> >                 return -1;
> >
> >         (*regex)->regex =3D pcre2_compile((PCRE2_SPTR)pattern_string,
> > -                                       PCRE2_ZERO_TERMINATED, PCRE2_DO=
TALL,
> > +                                       PCRE2_ZERO_TERMINATED,
> > +#ifdef NO_UTF
> > +                                       PCRE2_DOTALL,
> > +#else
> > +                                       PCRE2_DOTALL | PCRE2_UTF,
> > +#endif
>
> This causes pcre2_match() to validate the subject as UTF-8 on every
> call, which in addition to incurring
> overhead on every file would also cause regex_match() to return REGEX_ERR=
OR and
> label_file.c:lookup_check_node() to fail the whole lookup with errno
> ENOENT. Thus, restorecon on a file
> whose name isn't UTF-8 will error out instead of falling back to
> matching /.* and labeling accordingly.
> If you add PCRE2_MATCH_INVALD_UTF to the flags, then pcre2_match()
> will instead treat invalid bytes
> as "cannot match anything" but can still match literals and character
> classes and will return REGEX_NO_MATCH
> instead of REGEX_ERROR.
>
> > diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/s=
efcontext_compile.c
> > index e504b5084c8d..04c86053b2c8 100644
> > --- a/libselinux/utils/sefcontext_compile.c
> > +++ b/libselinux/utils/sefcontext_compile.c
> > @@ -1,6 +1,7 @@
> >  #include <endian.h>
> >  #include <errno.h>
> >  #include <getopt.h>
> > +#include <locale.h>
> >  #include <stdint.h>
> >  #include <stdio.h>
> >  #include <string.h>
> > @@ -564,6 +565,10 @@ int main(int argc, char *argv[])
> >         struct spec_node *root =3D NULL;
> >         struct sidtab stab =3D {};
> >
> > +       /* Initialize locale for UTF-8 support */
> > +       setlocale(LC_ALL, "");
> > +
> > +
>
> This shouldn't be necessary with the dropping of mbrtowc() and using
> utf8_char_len(); what still needs locale to be set? Ditto for the other
> setlocale() changes.

Also, you'll need to make format it - doesn't currently pass make check-for=
mat.
