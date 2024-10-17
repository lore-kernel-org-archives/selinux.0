Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44516EB42
	for <selinux@vger.kernel.org>; Thu, 17 Oct 2024 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190091; cv=none; b=SGjcxn3IBb6XEpwbEcdC4KBXmClLoq2MY6MKoxSTBulp5+WS0KmCXhp+2A1jRbSfiiHeyphPt4C4Vmkrpb3oLrAHwTGnbCJWDV1eGfwyGa4J6eJVZdOoyvI2q2O4cNqAm71+H1EMRDVO0oWp0dMVhu/vtiCeOVkXJMkjJp+CN4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190091; c=relaxed/simple;
	bh=Xgk0kEn8omGNAQpxthVeBemNPNkhoXUJLl3AuYOmTdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiAf6fUA+1ULTotCUe44PSOnlMINYIyJHU3d4O25jUS0mlZuNU+1WoV0epMBSMecu3z79v3+Swa3R4omlgdVVjAgeVhZ9QFZEpw1pR9PQES2kqiZw6hbuURwtZTDvNcAeF7OxhYeNfqg8HWm2nojg6lGK+fX3BSw4zSf+k+MZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTqYcT6/; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTqYcT6/"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e5f86e59f1so684010b6e.1
        for <selinux@vger.kernel.org>; Thu, 17 Oct 2024 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729190089; x=1729794889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G08tWYifdIx7cP4RFzz0AfGYKAOKd32T0TytvCccEqo=;
        b=TTqYcT6/U4JHB4k9RtI7Va7CBVc2uSPYem8K1fSpVh/KDU6dZfCVWREtHsySQmC1Ft
         uGBOSFV7ZgJ4FXyPrc+eBI4tKK+km+hc0yUzTvtbtQoaRSzoxFStlI802AYQnfOdDhgp
         3nmYVReQ9hRGFdjoI6zqdDw7a42HAGM9WttBosSzJdPojILaa1DQ2CQt54RK+ZhMqQPL
         rJHkrvBFigE90PVJGahiK2MZAnjdx7Xe7csqVKcZYJniNTsXyEs5Rx6cfoH0JNcKOqVP
         LaBSErGVvAtkLv9sPz8SlUFNO3WkPhmhzZFXVc37RhlW1veiXruF3mA0eGd8B05Eoxy5
         BBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729190089; x=1729794889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G08tWYifdIx7cP4RFzz0AfGYKAOKd32T0TytvCccEqo=;
        b=FHMyPc4OFI/djOlCtI5i9FtEkZtApCfRwmI3BzSnBQhO9TsZIC/3agMOT5dQJ0Won9
         9lTFB1aUKSdliP7yfCNFVggCKiqu7Cs40FCh0ORzUgCGftNB5qVEXpyZIZcNDeqopxJA
         vp6gYZ1BxTfgaTEgD7soA1FwsjJFTkHsDpyvku/LTTs/NiUK18EwwpO04/u8i29UXE34
         nhyoKXrd7A6Q0tMFTK9qa2aVU+8mWsgIKMmFtOPAScX7JRDVp++dsTBBMCTjtsA1odB7
         EfzlBkJkCJAwDuvcCLmYgaIBn2Hb/P375dlh+Xhhk1P0+Tg6HNSNq3fjaXx9zNzlsb9S
         T4tw==
X-Gm-Message-State: AOJu0YzqzUEGLjW9sJZmXHEOHW7GQyxhx1t5J2EJowzcuPtJr9wJIQuQ
	0BVx522Ljo0e6a2Qdxu1ZiAd2LgXKfzf9d49LHFLi7Uf3rAQ2QdYrBZedMEC7PtdKG8yMq6SgHM
	V30Lk7ngZwojvMlquYSousqJWW9Cy8RlD
X-Google-Smtp-Source: AGHT+IFPe1hDNQ0qwAxoMgma6Sri8J+sxKldSMayt+KZ1i9FOqrHwsa4EW6NBxhr25QM4HiOoByO6MuRQouJVxX0xBM=
X-Received: by 2002:a05:6808:13d2:b0:3e5:c89f:8ee1 with SMTP id
 5614622812f47-3e5c9129cddmr17870188b6e.42.1729190089199; Thu, 17 Oct 2024
 11:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016184825.200567-1-lautrbach@redhat.com>
In-Reply-To: <20241016184825.200567-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 17 Oct 2024 14:34:38 -0400
Message-ID: <CAP+JOzT8_6sojgrqzqcGQ7s24netTEd_3Xo4M_7JoyP3Fnqkyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: fix swig bindings for 4.3.0
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Jitka Plesnikova <jplesnik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:48=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> https://github.com/swig/swig/blob/master/CHANGES.current
>
> "[Python] #2907 Fix returning null from functions with output
> parameters.  Ensures OUTPUT and INOUT typemaps are handled
> consistently wrt return type.
>
> New declaration of SWIG_Python_AppendOutput is now:
>
>   SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int is_void);
>
> The 3rd parameter is new and the new $isvoid special variable
> should be passed to it, indicating whether or not the wrapped
> function returns void.
>
> Also consider replacing with:
>
>   SWIG_AppendOutput(PyObject* result, PyObject* obj);
>
> which calls SWIG_Python_AppendOutput with same parameters but adding $isv=
oid
> for final parameter."
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/447
>
>     selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_comput=
e_user=E2=80=99:
>     selinuxswig_python_wrap.c:11499:17: error: too few arguments to funct=
ion =E2=80=98SWIG_Python_AppendOutput=E2=80=99
>     11499 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, plist);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>     selinuxswig_python_wrap.c:1248:1: note: declared here
>      1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int=
 is_void) {
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>     selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_comput=
e_user_raw=E2=80=99:
>     selinuxswig_python_wrap.c:11570:17: error: too few arguments to funct=
ion =E2=80=98SWIG_Python_AppendOutput=E2=80=99
>     11570 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, plist);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>     selinuxswig_python_wrap.c:1248:1: note: declared here
>      1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int=
 is_void) {
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>     selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_get_bo=
olean_names=E2=80=99:
>     selinuxswig_python_wrap.c:12470:17: error: too few arguments to funct=
ion =E2=80=98SWIG_Python_AppendOutput=E2=80=99
>     12470 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, list);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>     selinuxswig_python_wrap.c:1248:1: note: declared here
>      1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int=
 is_void) {
>           | ^~~~~~~~~~~~~~~~~~~~~~~~
>     error: command '/usr/bin/gcc' failed with exit code 1
>
> Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  libselinux/src/selinuxswig_python.i | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinux=
swig_python.i
> index 17e03b9e36a5..03ed296d5b85 100644
> --- a/libselinux/src/selinuxswig_python.i
> +++ b/libselinux/src/selinuxswig_python.i
> @@ -71,7 +71,7 @@ def install(src, dest):
>         for (i =3D 0; i < *$2; i++) {
>                 PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
>         }
> -       $result =3D SWIG_Python_AppendOutput($result, list);
> +       $result =3D SWIG_AppendOutput($result, list);
>  }
>
>  /* return a sid along with the result */
> @@ -108,7 +108,7 @@ def install(src, dest):
>                 plist =3D PyList_New(0);
>         }
>
> -       $result =3D SWIG_Python_AppendOutput($result, plist);
> +       $result =3D SWIG_AppendOutput($result, plist);
>  }
>
>  /* Makes functions in get_context_list.h return a Python list of context=
s */
> --
> 2.47.0
>
>
