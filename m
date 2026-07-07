Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EF422543
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432720; cv=pass; b=aHRXXlbNhq6g5Zu7N/8eDSWSsyvfykZa0oPQ1imcUgxdpBxlqP22Dy8gHog3ZuFh2mtGxMbHMRKJ7ITGVvR/C8c5ewuR+mupHe++Lt7As6eMcpREKIPYUjbfMkxl5DdwOBJU35alN+4BbA0QBtqAXVg5ke/PCbMSjA3PDUNqmXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432720; c=relaxed/simple;
	bh=cL/dxsqpAv4pwHfIQMToHZRj39lAXLaID3UKovS4ogY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujqrY4HLHD9QhBttnSE6mdffaSX9BqF0b1cJ8ybvBrSEJFKV+7Gx6ESo4glBnQcdQEHXRsNYCoGQy4DI98epR/VWPpbjqPTgvZ1FdZg8946EKd3EDB4Bj1ytmXnlEn4qNOyyWwB6KEriqF+blwscjB86tjathRd3umA91UGls1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrhWwVoZ; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrhWwVoZ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39b217f54daso7156121fa.0
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 06:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783432716; cv=none;
        d=google.com; s=arc-20260327;
        b=DH7Zkj26iom2PzzoJsrFXSAEK5jGbW38KZy/z++gZqCEurwuuVDlWFq2F/L6BXLs1f
         OsEjM0ls5FU5m7TYgTWjQn58woI98TTlOyaVIBJTLcceTlp5GDVhknLPkfXHIhDXPNtS
         4T6MehlhW6t9gJHwm/E3EXANSabSSnM/jLEpUV3FvfmcMRsHXzZY8J9leOEo6vOAIdqK
         hP7WWzjqNE+z7lqzz03K3Vk8hM9s2r4YTdY9IhetZKgfHEmQpBlGqf6nI0U+UJPNndDg
         3CvnyNJxvzLUyA8xV6Qqv/wnD8H3+jvjChp133779kngkZMUCFtgcrY0u2VCbVluUrrS
         lFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ejqBzq9eM23reCFrT8vNOd4F1NdIYLPFV8GABh5mZ4=;
        fh=iWU6EMthgWNLSYoyCnZUFfTmFYJzGz6VSgGmuJwkex4=;
        b=L77d1MwX9FgalibO80MwQq2BS58qZakCdSs/Yzz/ARESAASWsh9ZhFKGn52AzpT2H9
         mHbLOHQmOoQUznDw+B068I01TQu+26W6nwMnPecm1lvdU4+djOF2zgIwn4/6CnmXId18
         PytpU6g6N9fU+28Y/ABYiXLV0AvQr1Z0l9gnM1fUTa80bEMUyqMTYtAyFnekNlPpGYvg
         GVGNGl51xxUJgAqlWIPA2gEdiqt7SMoT4VokaOK3mKLJ+0eg0rLtQSqb25mhSYgqdiQN
         o0RJWmwChLMhM22UfrRX6GHU15Gt0MZ1LhxfhgsriEtleFip2P7iMCOI4zV5Px6Nc/R0
         LyQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783432716; x=1784037516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ejqBzq9eM23reCFrT8vNOd4F1NdIYLPFV8GABh5mZ4=;
        b=MrhWwVoZPPZ3XUG3s3koMcxA1nJQgwNTyJewOgvzquBPp0eSzfNz+l/STZYsWPqXC4
         a9BaNW2kuzZRIKoLyjFSzKs/owp6tvx2Sqiu2w85MQWTv+8VvDL0cac3fUY+nncyBwv4
         87zbPlbdWWc+F4pAHhpUWqWrUx8MiZltI7Up800WqRBJ/aMiuMNgetQcXwxYO7hWqM3L
         wmehIVsji7gv1WeotOrgJd63+xtX01A+GzFPnGQ141il8I7bKuSbdHCFP2zl3b0N7NvT
         HGHeub3PSSIItUFMnaAdHzURJmMDF5pcLmtz6Ydb1P7zpyhXnt5SHEZeXd+H7ZTWgvH1
         LBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432716; x=1784037516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ejqBzq9eM23reCFrT8vNOd4F1NdIYLPFV8GABh5mZ4=;
        b=sN3+ir2WnXCQbwGJmGb0tHzedKlk6oUUr1Zb5BDfVHCKa8I/kCJGL3LXlXA/AqPRGv
         bkTwI3zfpAxo07W0ZVJudz8fO3pgqJt0ymB1QoJ90uCfhHxzXoTTDuFSPS3/zPTdlKbH
         i9qCfUn2UlHJIQ3nAsy0eUVW1MsQ4K9l7iWJ6DQH+U4fxhQXvG8RbuOa8lm38TOe5N/U
         qgHE6m8KkaiIh81nlebJlvEOUyWRiwleJOvMNTQ/oit9IkwZn4Q7rmsV0NC1TlnSAGMr
         sgelMXzpNniEtokwd1YeMfjOatQIuczvl6ia9H/T/wXISUS35FJJKB1kJ7FhCf8j7T4L
         aueg==
X-Gm-Message-State: AOJu0YxyS++f9rM/Nxeb2Shjhj1LpZ+glo+sWJ45318zwnAlvC6ulmX/
	DeSsI7hhB0oqJmLOEf502Yoh6m/KY7pbJMq2JUFimoqN3+hb98LiB2JuBOk6B75qmy06TF4PvNu
	x9pVy+21uyRJJqyNWehlF6KSHuVSg7Rc=
X-Gm-Gg: AfdE7cluJU/KQzoX5CFJEAJMb5VTqryEcTs686WKb+/6KueqVctwZEr+QBcW084ndfQ
	np1rj7eDtTMtGvUpChoo3/sqxgjPFc15IrNQGe9wO4V2ETbLXHW6RIeYDIx1biJNoi/4BUgjRO5
	kWiO/clwrabGOlywzU5qbAqS7O/PbsPBE51MxKJHFAQ760VSFExR/DptthfUzXRzBxAJHqyq3WU
	gzzcT8T6znHsGFZ7x82omXyFIzVz4oYSEKUwmN9aGUHAtFmfjCHIeY97P0udjPnst7ehwGC6W9V
	B+6t
X-Received: by 2002:a05:651c:2124:b0:391:11de:dd5b with SMTP id
 38308e7fff4ca-39c69b14e24mr5572241fa.11.1783432716064; Tue, 07 Jul 2026
 06:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143726.47421-1-stephen.smalley.work@gmail.com>
 <20260706143726.47421-2-stephen.smalley.work@gmail.com> <CAP+JOzRYWVLBCHZT37ESKKvaMxgPhXj79AMizWebQ6jq4UDGUA@mail.gmail.com>
In-Reply-To: <CAP+JOzRYWVLBCHZT37ESKKvaMxgPhXj79AMizWebQ6jq4UDGUA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 7 Jul 2026 09:58:23 -0400
X-Gm-Features: AVVi8CcqoG73MffdQP3nihwBes5lGmaT7ps1iMJrx-CNAvbKkOT-5uL0aVkwNxo
Message-ID: <CAP+JOzRfEwMAJVxC=sQUY=Gw1dKtPR47XcYdAk35Mj1N7BQ8dg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libselinux: selinux_restorecon: use openat2 if defined
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:39=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jul 6, 2026 at 10:37=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Update selinux_restorecon()'s safe_open() helper to use openat2()
> > if defined to optimize the lookup of the initial pathname. Fall
> > back to the existing per-component lookup on ENOSYS/EINVAL so
> > that pre-5.6 and seccomp-filtered environments are unaffected.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/src/selinux_restorecon.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index b34d8e60..30f1b836 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -25,7 +25,11 @@
> >  #include <sys/vfs.h>
> >  #include <sys/statvfs.h>
> >  #include <sys/utsname.h>
> > +#include <sys/syscall.h>
> >  #include <linux/magic.h>
> > +#ifdef __NR_openat2
> > +#include <linux/openat2.h>
> > +#endif
> >  #include <libgen.h>
> >  #include <syslog.h>
> >  #include <assert.h>
> > @@ -1114,6 +1118,25 @@ static int safe_open(const char *path, struct st=
at *sb)
> >                 return -1;
> >         }
> >
> > +#ifdef __NR_openat2
> > +       struct open_how how =3D {
> > +               .flags =3D O_PATH | O_NOFOLLOW | O_CLOEXEC,
> > +               .resolve =3D RESOLVE_NO_SYMLINKS | RESOLVE_NO_MAGICLINK=
S,
> > +       };
> > +
> > +       nfd =3D syscall(__NR_openat2, AT_FDCWD, path, &how, sizeof(how)=
);
> > +       if (nfd >=3D 0) {
> > +               if (fstat(nfd, sb) < 0) {
> > +                       close(nfd);
> > +                       return -1;
> > +               }
> > +               return nfd;
> > +       }
> > +
> > +       if (errno !=3D ENOSYS && errno !=3D EINVAL)
> > +               return -1;
> > +#endif
> > +
> >         copy =3D strdup(path);
> >         if (!copy)
> >                 return -1;
> > --
> > 2.54.0
> >
