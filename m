Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9D280018
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680795; cv=pass; b=qoESugqSah+aBP4SufC+dl9jB82AAB0WzzDWF1wn8HUWWgGPXjdp6AsZ6LhV/yg7bCAFub1NckDuOcOep6S7QB58hh6oEJ+SxQA4AVNxPUw0bPZvGmI6u/fWYphHYHP+XV+xOriRkVeQ6rcAo3wPwm16ENdvP04CajXFarexzmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680795; c=relaxed/simple;
	bh=E4MYAl9h710/KpMKjY7yaPJmYy9SqoXf0nQlTN5ir6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuJipxRoyjWmqVXe1bIa2zYQxuj1Pv4EO2kfDuSVGVhzC7pcHXpLEVvjXUxMQixoZHvAWi/2yYJdwR8x7FOCvmB6m9KKFkBeEyl8sIJPBIJ4JagwzRPoht06/7W8tcqm21UStlOvT8/fKZSUrSwCgtM5s3RDtaTBBbz7+jhgwqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJBMeEd8; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJBMeEd8"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3939d2bd7ecso54356731fa.0
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 06:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778680792; cv=none;
        d=google.com; s=arc-20240605;
        b=QbBA5tPxKP1gUvZlN0IXnDFux3Ha3hj+Xf86XKVNNnAukenHZiwCooDU9uzVJeWs33
         VElyJF9dSGG/xJs+MKXWEwy9ie41qJ/G1/JpswtW9RxaVOo8kpMLqYht6XE+DlLJ4FZ5
         bic9op/bE/2SKLVLEVvDh/1OfU9ucrxV7CEx8YySkerzRiHwcND6NHELg3NPag1FINNi
         gutKfdUqKwYFA9McDi+kYZ3R9jFwvtm3tw3rPmFZkDe31myOT9YvvsLTiNuZ+whhRG8L
         IJsn7k84t4BTDI99Oywm2R2SGptBA9q3ahsSsM6WmNNpSKP+BasPOi9k66Ego0Yk4uJH
         6+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WMYboCg9ubG+EHt7r6tJ/xXwIaUS9VcwUAQ1tD7Nrvw=;
        fh=9Kn6U4E5LMJy3xhP5t9LNYPPpXiXmOSDj/WE4utCypg=;
        b=H/iTap+GWD7+ye68ByMkxtbbnY41KPNm7kR7rz+LTh6Od2zk4Z61PUMUjXjodSJjo3
         77kaZBrGOVBW0qZkk463u2BvdgrG63zx43z34ACU3EM3qJQ3ANJ+cErDR2crdnms2F0j
         23n/O0G0iw6FWPht/qeSY4qwud6axwLjj6wm9slGVij4JJ0+hLi7wdBe4gL9gOwDqgf8
         8pEH+pSu/GBr0l00ol7Ws56HfNV/2kyJ4ammuuY6/CklWd54BkFGYuLo5Rw2pcNgojyw
         k9JYKe8KMgg9CxVsCLIgIEWTjFiTf+dVG6ZOUUSmA4ibNJREFhYukmHEHDpaCU1IgnTf
         AZ0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778680792; x=1779285592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMYboCg9ubG+EHt7r6tJ/xXwIaUS9VcwUAQ1tD7Nrvw=;
        b=jJBMeEd8aHOs6PbmJCfz80NDatIIZWb/X25Qh0YcMv4a4brI0DQoGCYHWjcmQHC2Ns
         W6x6klG+jcaLqtE54c2MWXgA6dPdv/IR1i8U2mYXHkX6h6cQPxYa8S95F/16aH0/diy+
         ooKxZ1r+eBDV/77THGYzKHEwdVjSF5qtP7NN2jJf3g5oAZw/OvnZGWtU0E+vJ7FfX7n+
         9QLNRr4KQxYEwi2SEY9l0yxYKAwQCvrU4jPylkDVEO3CMtpRgnk3bm/13akHJSarIFqD
         wIF59C1Oo6FL0asqbzMqI3BbjnpFtcN2HpDs0AkOtQbLJ9GWdudjuCCu50hpcRLTL8/u
         25Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680792; x=1779285592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WMYboCg9ubG+EHt7r6tJ/xXwIaUS9VcwUAQ1tD7Nrvw=;
        b=OZsoYPiUDX6yzr2tIqyny9WFnz/wzLTMxLyTSRZGRk8q+W1r36d6EymVffyDInMtqn
         Mnq/nL+OWuIkuCKThs9tBQCGLmGelRMFm77ud0l4kJrbP63ORbaCQegV6bmFIlCUTG7M
         6LOHgNKzDSQX4WDyEMj783Nj1ARxpE78mpPNVk/1lXh8xZUxfeU+mn9CbMSAnFvAckXK
         hoLCJdVeR7OMtGB3+FFquDjcT8xcj/ACqrXu7Fu+8+DR1BsKrH2++YiQzZW8MA6xNIz3
         bEvCB6ae1aBSdxfqQyOizrqidOXSaEgzycVjQkTZ5xub+xvVXx+MhpMEWY+geePdu5Cx
         bkfw==
X-Forwarded-Encrypted: i=1; AFNElJ/SJeroemZViK4UzhjPlnO5FOmVo5KE4mkPYDoJ3XiY74IP/Z+QxeVFrBRYKryRjgwN3S8o0y5q@vger.kernel.org
X-Gm-Message-State: AOJu0YwNBRalEqNqMu+mfQQQvL1ZIq8NlLr3VahcGJHXn9R9Fa7713uN
	ed4zxV47RbyWK8sc74gT/c6tDyGLC6avLTDVQw7CjsI03/25aCv3S/oSEOjrKgOq3IV1MNLcCOM
	8aTeyt1F8uXMcZWRqmWdZ78pYBCgh+hs=
X-Gm-Gg: Acq92OGx/OmPwT+HnZ4BCaRnCFvfX/NRKgzwpDPafI2xH7QNi5dJ151PM033tPpqacN
	NBhUEoN7nIiqcu9aZrJhYNRkz/pSF486YUPsnuIZK6G7qWoYbfm3Xgb/Ak1z/GlaXqfHknhvcYH
	n2i/A1zyZDGmNuDxd/eu1/FQJNgjLjg+TUlPJnDsjqVXGIXAMZS8Jlkhn108mI9uD2Lw8Oygcyw
	eay0bI4ijwPLA/FAuX+ve4fqkzz0R2h8/g6DSgLyzhRlUliEgtT81AufPGn07lLjv7sN3Nzrbwp
	nSg0
X-Received: by 2002:a05:651c:e0e:b0:393:7f7a:4047 with SMTP id
 38308e7fff4ca-3943888324dmr19228241fa.16.1778680791742; Wed, 13 May 2026
 06:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414183946.3867493-2-nvraxn@posteo.uk> <CAEjxPJ5TRLCVOWoxAsP1zC_v73Q1r1oFdXQfmAev7y1bbwPFSg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5TRLCVOWoxAsP1zC_v73Q1r1oFdXQfmAev7y1bbwPFSg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 May 2026 09:59:40 -0400
X-Gm-Features: AVHnY4J7X1lcXNbx3FZ5aOV-lPB4Z0e9v0JfxX_d0f4Qys_wVdAeLlvXj3sAxco
Message-ID: <CAP+JOzRupznV-j9UD6EiwmgQczY2CqKJbbkhDJnUfREo-uC1KA@mail.gmail.com>
Subject: Re: [PATCH] seunshare: guard fallible function calls by checking retval
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Rahul Sandhu <nvraxn@posteo.uk>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:22=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Apr 14, 2026 at 2:40=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> w=
rote:
> >
> > seunshare currently segfaults is passed --kill and an invalid context
> > via -Z.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  sandbox/seunshare.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> > index 2512a18c..e89a9fec 100644
> > --- a/sandbox/seunshare.c
> > +++ b/sandbox/seunshare.c
> > @@ -679,9 +679,19 @@ killall (const char *execcon)
> >                 return -1;
> >         }
> >         pids =3D 0;
> > -       context_t con;
> > -       con =3D context_new(execcon);
> > -       const char *mcs =3D context_range_get(con);
> > +       context_t con =3D context_new(execcon);
> > +       if (!con) {
> > +               free(pid_table);
> > +               (void)closedir(dir);
> > +               return -1;
> > +       }
> > +       const char *const mcs =3D context_range_get(con);
> > +       if (!mcs) {
> > +               context_free(con);
> > +               free(pid_table);
> > +               (void)closedir(dir);
> > +               return -1;
> > +       }
> >         printf("mcs=3D%s\n", mcs);
> >         while ((de =3D readdir (dir)) !=3D NULL) {
> >                 if (!(pid =3D (pid_t)atoi(de->d_name)) || pid =3D=3D se=
lf)
> > @@ -708,11 +718,13 @@ killall (const char *execcon)
> >                 if (getpidcon(id, &scon) =3D=3D 0) {
> >
> >                         context_t pidcon =3D context_new(scon);
> > -                       /* Attempt to kill remaining processes */
> > -                       if (strcmp(context_range_get(pidcon), mcs) =3D=
=3D 0)
> > -                               kill(id, SIGKILL);
> > +                       if (pidcon) {
> > +                               /* Attempt to kill remaining processes =
*/
> > +                               if (strcmp(context_range_get(pidcon), m=
cs) =3D=3D 0)
> > +                                       kill(id, SIGKILL);
> >
> > -                       context_free(pidcon);
> > +                               context_free(pidcon);
> > +                       }
> >                         freecon(scon);
> >                 }
> >                 running++;
> > --
> > 2.53.0
> >
> >
>
