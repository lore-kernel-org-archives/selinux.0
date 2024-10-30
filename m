Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB11D1E7A
	for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294017; cv=none; b=dN0tDZ0sYnO3JkpiddzZBXozZ/sJHQ8SMsVBgJ3ElVtx6oF8Dy6DmasG9kNMK9o+XATiDbdsIhwWtELX9DbNPTk89xNOvzxiuEkstUYcxe1tzp7xKSli3OleLFF6WgoY4GwTSETmt6+K8NzeYHqnJtlRRF/91XSKQo0i+23QR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294017; c=relaxed/simple;
	bh=usaNunAbFTMTpJmYbosIby/dF0xGW3JQmeGKjettUos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quWEW6oee5D+2xsWAKypdmJffAvCAIR2Gb7rHjHRCW2j0+BrJaSYsjTug5hE2qvi59llWDfkIFPF2b3oWaTmnA2BOWuzj2hoDpDNCh0sOm2nqwV2kljN6HMtjZ9fRrHEcCt2iC8Fz+BRJY7TtysYordhc2iNPBzJ4GJJBHHUSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUYtUjO2; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUYtUjO2"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ebc1af8f10so2819476eaf.2
        for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294014; x=1730898814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH25q+NP+/zYxrfTSs8dxzgkMCJu54b7UHV/KcaJNxc=;
        b=dUYtUjO2TKJL2ss1iIDXg9g8r6/k4zG4FZknT6sZ+SDQGTDKAT4Bpmv0CslGCCWvuu
         oo3Mt6erHWsFYPEqvvo8jWJoRFR9W2V01sgGxoONv8xPxb3UAmLlTSvpFLV/u5CpzT7t
         Wus2cBYDgV542FLmn5/PYdKqibcJenwjMDS9gtnJtnzpTwscR0QKlPGtPk6h4RNQnnuQ
         sn+bKfAws3yD3hlcXwb83IJYduPHUminYI9ihxkBdLehXkxxnZOhwFdj+Vjgb5bw4QJL
         2+NclLTtVE9thzOVGzE3nl+nwoKOYeb8/loanxi0Gq2pSkY48g6v4ZtC0XpwBSLBSAJe
         oP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294014; x=1730898814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH25q+NP+/zYxrfTSs8dxzgkMCJu54b7UHV/KcaJNxc=;
        b=QK+3E3urwYwRD2kHQxSpgcAh/ehHLGR1jNGa1rwCeyGr+5AGPHy75eu3m1dhsf1Idc
         YMVgNRduV556e87+VcpijS8eyWOIN0ovvnwJN4S/d63pQ+Wx6lr0NmAP8eOG215vP7NO
         QUJSxtiBZR91Vtz6Isrcj0xFlXMlrX0yQ3Gk08zp2ilsAG07b8FhuUzUL4mSO3xO2rIZ
         5GI7/ASnBHkJdKMdOO8yC1Dnl8BC42vR+k45TfC/Y4brzlDLiTAGq0ADI2ES/4soJGdq
         B6MlMtIq6cYUcIf4ZNoyKW00vi4rGAanOIx5vvZrg3gzvIDrZkHz7nh2TCvSEGb1+Tbl
         sVBQ==
X-Gm-Message-State: AOJu0YzCRmQrJDXMtuBLNXOZpvFIKLsHLAg3FJGAli0T+McNAHrPUvKt
	VLtJ2rEZ+4FKcRLFzd75oG+Rl7j6wvymeLzdkXecNdNKfXgQotk4EAKdfiqHtuCusl4TEQhywyW
	1WwA5z8+8pwQvjac1XhPyuOyG0fs=
X-Google-Smtp-Source: AGHT+IH+wiHyp37iBUkUYwwytcJlkrgKlpeSAhrhT/HL2dYOoOgYxPV9gxujHcv1MpQ+9WC37oU9jkRleRZaWfe9SLw=
X-Received: by 2002:a05:6359:4c9d:b0:1c3:90ff:9721 with SMTP id
 e5c5f4694b2df-1c3f9f7a546mr772725455d.23.1730294014438; Wed, 30 Oct 2024
 06:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016184825.200567-1-lautrbach@redhat.com> <CAP+JOzT8_6sojgrqzqcGQ7s24netTEd_3Xo4M_7JoyP3Fnqkyw@mail.gmail.com>
In-Reply-To: <CAP+JOzT8_6sojgrqzqcGQ7s24netTEd_3Xo4M_7JoyP3Fnqkyw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 30 Oct 2024 09:13:23 -0400
Message-ID: <CAP+JOzRL=MA2FAqNMHQ8zwNxrpf8stZyCcT=Gw=FdhmAsVcdFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: fix swig bindings for 4.3.0
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Jitka Plesnikova <jplesnik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:34=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Oct 16, 2024 at 2:48=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > https://github.com/swig/swig/blob/master/CHANGES.current
> >
> > "[Python] #2907 Fix returning null from functions with output
> > parameters.  Ensures OUTPUT and INOUT typemaps are handled
> > consistently wrt return type.
> >
> > New declaration of SWIG_Python_AppendOutput is now:
> >
> >   SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, int is_void=
);
> >
> > The 3rd parameter is new and the new $isvoid special variable
> > should be passed to it, indicating whether or not the wrapped
> > function returns void.
> >
> > Also consider replacing with:
> >
> >   SWIG_AppendOutput(PyObject* result, PyObject* obj);
> >
> > which calls SWIG_Python_AppendOutput with same parameters but adding $i=
svoid
> > for final parameter."
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/447
> >
> >     selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_comp=
ute_user=E2=80=99:
> >     selinuxswig_python_wrap.c:11499:17: error: too few arguments to fun=
ction =E2=80=98SWIG_Python_AppendOutput=E2=80=99
> >     11499 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, plist=
);
> >           |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> >     selinuxswig_python_wrap.c:1248:1: note: declared here
> >      1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, i=
nt is_void) {
> >           | ^~~~~~~~~~~~~~~~~~~~~~~~
> >     selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_comp=
ute_user_raw=E2=80=99:
> >     selinuxswig_python_wrap.c:11570:17: error: too few arguments to fun=
ction =E2=80=98SWIG_Python_AppendOutput=E2=80=99
> >     11570 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, plist=
);
> >           |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> >     selinuxswig_python_wrap.c:1248:1: note: declared here
> >      1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, i=
nt is_void) {
> >           | ^~~~~~~~~~~~~~~~~~~~~~~~
> >     selinuxswig_python_wrap.c: In function =E2=80=98_wrap_security_get_=
boolean_names=E2=80=99:
> >     selinuxswig_python_wrap.c:12470:17: error: too few arguments to fun=
ction =E2=80=98SWIG_Python_AppendOutput=E2=80=99
> >     12470 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, list)=
;
> >           |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> >     selinuxswig_python_wrap.c:1248:1: note: declared here
> >      1248 | SWIG_Python_AppendOutput(PyObject* result, PyObject* obj, i=
nt is_void) {
> >           | ^~~~~~~~~~~~~~~~~~~~~~~~
> >     error: command '/usr/bin/gcc' failed with exit code 1
> >
> > Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

>
> > ---
> >  libselinux/src/selinuxswig_python.i | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selin=
uxswig_python.i
> > index 17e03b9e36a5..03ed296d5b85 100644
> > --- a/libselinux/src/selinuxswig_python.i
> > +++ b/libselinux/src/selinuxswig_python.i
> > @@ -71,7 +71,7 @@ def install(src, dest):
> >         for (i =3D 0; i < *$2; i++) {
> >                 PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
> >         }
> > -       $result =3D SWIG_Python_AppendOutput($result, list);
> > +       $result =3D SWIG_AppendOutput($result, list);
> >  }
> >
> >  /* return a sid along with the result */
> > @@ -108,7 +108,7 @@ def install(src, dest):
> >                 plist =3D PyList_New(0);
> >         }
> >
> > -       $result =3D SWIG_Python_AppendOutput($result, plist);
> > +       $result =3D SWIG_AppendOutput($result, plist);
> >  }
> >
> >  /* Makes functions in get_context_list.h return a Python list of conte=
xts */
> > --
> > 2.47.0
> >
> >
