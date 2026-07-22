Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958035CB6A
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784688287; cv=pass; b=OoAzUBXhzyI4MyCGFqWCXpbTL+DI/IuUrQciGvaaJkeq8cdQ8SvSGeKKKM1dYU2NJUyvTeL8DXGmusmwoUj3Rn8VsM1PcV4nmgCZhe4+uJdjTC60Llk9BbSRFCqn9WgXEIiCIJ5Dz85LqxS0hp+IDepuLl8uPvdW7+7JJ+l4/Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784688287; c=relaxed/simple;
	bh=uR28FbFr2qFZs7NVIlPynrGVSOG58VF1s6GqO+Y5U6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtWjTh7YKksK6mG+IOd6jXZPZBSopxCL3k0rvxhwoOiIkM54ImQF2nP5Z3vodh00WDFUGphuH7Nu3gD0NfFs/nw5tOvmaEW+hqymva2AGtFl83MK6nz/Mlt31XgghPc1P1mDYKCp9JVE0YWkzis/B4lKAygjo1Vy4MMahLadA/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9xRbJoM; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9xRbJoM"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c10ed63c0so1481871cf.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 19:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784688285; cv=none;
        d=google.com; s=arc-20260327;
        b=TjckXbVeXiW5nGPh7AOHwySeeAjAUFOHZYzBUzBaD+RZI8D+1gh3UtT8st5zHdk89U
         08mSgaCV+QLiKmBqt5PZdXK4y8Tb5F1do4W9rxpAJyLs0cuWi+iDTpSGtFo1v8NkB0i+
         iburPxw5UwAZvFYRwusyDLfklBRoi5dGwy3xK+wpNmaHo6r6Q0VCGI2qwQJOWNOfiV6w
         fJc3kgtfSRN/6ySkkcH5+C2kvCaXI7A1f/cfd+7ZuxvJTFTPuEOpY8ymYtjzi8JSPMp3
         YgCsSrWwb/w+yUxE9FaXk2pcne1p0T6kKntnuQ9CnwBELFiCVW6bejJ56/ZNhViAvGGk
         rlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9jQN30wSyJ8RjB6Qgkmmd9dcHKjZ1/5oDLkgSDmGtx4=;
        fh=lmYQukEDd0Aey/kbL357Wz9nh16CGqYXzPiRr/xRR8w=;
        b=J0BO5zSXQiDollt7YRyd4PjNs3lcVH5NCyB+FMXWj2rz0mE5aGAUWYtkNaUpJK16U9
         oCoCSdqOwQ0gWuGQOvPY9mXRRYz03fqQECifJlD0huvthYgtZSDv2UKjAVEty67qB0Hp
         sb45V0KBXm2rETHSLpYakWX8iNfHB+brGOo9qnEGEbrSmxBifE1nnSPwNTHMb/IRn6in
         CGnxNrbPchUFbT8oFrgWug4lGfPgQr1HvF7/YSxFjuCssZ/EHVeeLmwx+MZlx+iNPLVq
         JnECybJ8ac31OuHSw8NsgywUY1FzaYtNT6da5Ad1kfd9h8eKFqPXNq76nfc05OV9/4Tx
         fKIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784688285; x=1785293085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9jQN30wSyJ8RjB6Qgkmmd9dcHKjZ1/5oDLkgSDmGtx4=;
        b=l9xRbJoMhDpWKj/eaYSxBsNaDU6/lAu2nA+rojFe8tD4XgnJ9yQ7n1CTn7goowlGug
         FKaHmRJ0zc/ncxjw//3ft6euxRwXy5ujDKE9suL0V2bkaq90kFNd6fLqxWGWxTP8LnHG
         +1UCYuRLAz47mILcHHck2Q08VQ0+vYxSBUrk7vAnstv9M49+CFlsdwAxqCiaGaECE+kM
         GVzyswyorReK6EsHoaRPHFB2erJZOyASPHeKyxMePcin3nYhJ6p8qSYsd+UhMsUVQiG2
         F8ZbkngjyFwhhsJC6SqjyECxHn3HtvN2QPdsbtnZQD6GtldvcnT3UKg4jzCQCB3YB5LN
         H7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784688285; x=1785293085;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jQN30wSyJ8RjB6Qgkmmd9dcHKjZ1/5oDLkgSDmGtx4=;
        b=fAPz3xKtI1AVkYKl2LiwtUJ6awXe7aFCIXlYCWJDoSNxEDKrX2peNqPLf6C8o1SZqY
         5zoUPY66/zrlDinLoY6xLftHpA85hcpbhPeQIUnAI21Z3ksXZ+8MLkWajnI2cP6bajUK
         uqLnAmp51XTvkfARMtlUnxKd6iv5u9ds3oTVpBhnh0zX3faUU1mqPHb4MgaFLMxx5vPN
         uU8f9gkgegQEsCI+gqhItNgWN2D+9lFR11kSqg5700SktUFuDHPVWkpO931lZM7l+FQJ
         FVtB3hgZruShnaC0Fd6gY4BElKYs8TblfP3CW0EuRV/aV1fMYJTedvlQUVVDl2Bl3wRQ
         tUkA==
X-Gm-Message-State: AOJu0YwONeA8P6gq+8a7GSfM0VJ11wPT14cOPutn5KEZ+K8xmWV/Cw3a
	/ZB0jBFxlAE222W5AXOBnjuAI8IRTs2vD4MqDloavvcwo6tlNGrQ4lf1QN76dabbCELSzlwyF2f
	qQ4Et9V9GIR8y/4Cd257RX4TBV2+jsv37hxKgJm6i
X-Gm-Gg: AR+sD12QZKEHWC51jqZe+sKt2kmLx6yhU3s+EJ38zTc3dKapyHOT11IslhJ0sw8oYaY
	tg9hv6GQh6uLqeMQLF+pE22bfQoxMUvHnNbDwve1hjxe3kHAAIw3XjVmg4vmHNlY+IcxiQrpetA
	glnygvSX9QSg7KTIzspEtw5omwpUURFJrTqQduMavJCqakX66ocveoY1FxUTonZwP4xbIjVPo70
	ucRU141YDI15+HNcNO4HxI2CYLrevSipYzdIlRHT35DqNROXlnWfn/sbBcMha2dI4AnzNYbRK07
	GDz5qgXkuYsunGWJu1YatubosK7/
X-Received: by 2002:a05:622a:a992:10b0:51e:af63:e831 with SMTP id
 d75a77b69052e-527ed9b10b0mr3632901cf.1.1784688284622; Tue, 21 Jul 2026
 19:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721021127.1313453-1-tweek@google.com> <20260721021127.1313453-2-tweek@google.com>
 <CAEjxPJ7pfTxcZ=DRO4WaW9J3Twrttc0LiK1RsEj_HMtUPDv00g@mail.gmail.com>
In-Reply-To: <CAEjxPJ7pfTxcZ=DRO4WaW9J3Twrttc0LiK1RsEj_HMtUPDv00g@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 22 Jul 2026 12:44:26 +1000
X-Gm-Features: AUfX_mySARRh-SMsGAu1Zy4VpeLsk5xN7bHWV23xR5VRfSPylrwAEMzk4SHX7_Q
Message-ID: <CA+zpnLdSB3SfM+xSfoUnu8uqr=aHr3A84=XW0GXjBQL8q=+vyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: support multiple contexts for the file backend
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Petr Lautrbach <lautrbach@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 2:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 20, 2026 at 10:11=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > Update the file labeling backend to support specifying multiple
> > SELABEL_OPT_PATH options in selabel_open().
> >
> > All provided paths are stored in rec->spec_files and processed during
> > initialization. Derived files, such as substitutions (.subs, .subs_dist=
)
> > and auxiliary contexts (.homedirs, .local), continue to be based on the
> > first path (or default selinux_file_context_path()) when enabled.
> >
> > Duplicate checking logic is refactored into a helper function
> > report_dups(). A duplicate with the same specification result is not
> > fatal anymore, but a warning is still logged.
> >
> > Additionally, duplicate validation is moved after all files (including
> > .homedirs and .local) are loaded and sorted. For single file context se=
tups,
> > the only difference in behavior is that duplicate validation now extend=
s to
> > fc.homedirs and fc.local.
>
> Not sure if this change in behavior is desired - it seemingly
> precludes .local from intentionally overriding an entry's context.
> Defer to distro maintainers.
>
> >
> > A similar multiple files setup has been used in Android for 9+ years.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Thanks for the quick review Stephen. Overall I agree with all your
feedback and will send an updated patch.

> > +       /* If no paths were provided, we will use the default path or f=
ail, depending on the target. */
> > +       if (!path_provided) {
> > +#if !defined(BUILD_HOST) && !defined(ANDROID)
> > +               num_paths =3D 1;
> > +#else
> > +               selinux_log(SELINUX_ERROR,
> > +                           "No path given to file labeling backend\n")=
;
> > +               goto finish;
> > +#endif
> Do we really need/want differing behavior here for different build config=
s?
> Effectively it means a different user-visible API?

If I understand correctly, this difference already exists. If ANDROID
is defined and if no SELABEL_OPT_PATH were supplied, path is NULL and
selinux_file_context_path() is never called; which means that `if
(!path)` below will be executed and return EINVAL (I should have kept
that return value in my change).

More generally, we had to implement a layer on top of selabel_open for
Android-specific file_contexts locations [1]. I am wondering if we
could improve the design and abstract any standard-distro details
(e.g., homedirs). Fundamentally, selabel_open for file_contexts would
either: use the file paths provided as argument; or otherwise use the
"platform default". Right now, "platform default" means
(selinux_file_context_path + homedirs + local + subs). What if we
define a callback that returns a set of files to use and optional
subs? We could keep any Android-specific changes in our own "platform
default" implementation (which would be behind a build configuration
option).

[1] https://cs.android.com/android/platform/superproject/+/android-latest-r=
elease:external/selinux/libselinux/src/android/android_seapp.c;l=3D101

> >  /*
> > - * Warn about duplicate specifications.
> > + * Report a duplicate in the log.
> > + *
> > + * If the duplicate is considered fatal (i.e., if the specifications o=
f both
> > + * entries do not match), return -1 and set errno to EINVAL.
> > + */
> > +static int report_dups(struct selabel_handle *rec, uint8_t inputno1,
> > +                      uint8_t inputno2, const char *ctx_raw1,
> > +                      const char *ctx_raw2, const char *match,
> > +                      const char *file_kind)
> > +{
> > +       if (inputno1 >=3D rec->spec_files_len)
> > +               inputno1 =3D 0;
> > +       if (inputno2 >=3D rec->spec_files_len)
> > +               inputno2 =3D 0;
>
> Not sure if this change in behavior is desired - it seemingly
> precludes .local from intentionally overriding an entry's context.
> Defer to distro maintainers.
> Since you are intentionally passing in num_paths + 1 and num_paths + 2
> for the homedirs and local files, this will incorrectly attribute any
> duplicates to the wrong file. Not sure we want cross-file duplicate
> checking anyway.

Thanks, I wasn't sure about this as I don't know how these files are
used in other distributions. I agree, keeping the existing behaviour
is better.
