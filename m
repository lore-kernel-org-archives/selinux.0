Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121A34CDD
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373489; cv=pass; b=N6srmWxt53oMWp36ctfkVJjviiLEswhMyyRufRxOrBG/o1Adq6/sEoTcuJ+4Il5oYi3ssVX69z59wzelSm7n8bA5KFV3brALZNOCDHtBgnkDTWQMkqbvWLD8bHDIhZN8cVYW5sod+5l8asGcamI6oGQchL7brxrehCSzkI99Gfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373489; c=relaxed/simple;
	bh=ouKc7RFvTKAUnPzY6RbsH61vV/Q2FIBs8lm0EyzjTp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcIHJRXuS2NvjuoBiufO+ebQAs88GS8jX/EkodlK8esrA8/OYuXXWxxTL4CTccgVHNNJX5HZhSAK5WpiNuSQpJ7k4ybveLkSB863QkFkOIIUcVpp7cqvk8L90JhCXCHHt7A5yxMeN6NRSpqVzcPV3sK2WQD9+6omeVr/zAqY+U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZk5YmXP; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZk5YmXP"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-394095009beso54186341fa.3
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 07:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373486; cv=none;
        d=google.com; s=arc-20240605;
        b=Fa27WVdZ5kKZytsiXOe0JQnPKklbc4ExK9kpRja0zT2ZXEx0R8blq1kEj7tDW7ANbM
         m2SMrQHLLvZrKJMjFvF3vrEzjP+Xd+3ks+FGE9liF7Qexdqwg0wbajj7WH/uiOIdBbZU
         atouhtTCr0djhzN6w0tGucpkq2ldyv1lTk6my8CComuFEba7kitWfT6JLHD+qqKhCjzl
         AcP2hEDOcKzqFs56QWux5SoAuM1+K/jsw+Y8KFe7CdI19xuCLA6DrukVkeYQvT9+idU7
         67n2cFicVoZRp1jufkZZX8C+6RlEBInLHIwUctlxcA9/iHHNBPBl3APMToovheMFxZHX
         Vhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aqE3SonfX/gbWcnCmMGaONGt4ftuV/DRXDnWaqjt88g=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=DLfWf5OiRS5QyrixN07qBbx4NP8NDeWFBkULQOrUkYM5OzUc/PYvB594vTfAWXtj8h
         tEuTbDd0CHerItE6MQcbsqsmCvF4yG/JbEaYGxbAXmvWzQ1EuI0eT7jEW0cIzuIea+sD
         iS7AV0KSGnZlj1seBHN9iQzcn6Vi4Npu6a5fBC/0yqydBpCr6YhNnuRWAreM/LOt+R2A
         Rfprc2lirHqnkX14G/DyrbcEyj9pnyCNHifOwDczNZjX694xhkUcXB1fEedFFaCNEf1i
         1cKyVQCbS6MvHBOBhXeitnA1XvYdF8ZJZg4K4FVYDz2zq3D5BT6b7N323McQSFcM0BoR
         ayyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779373486; x=1779978286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqE3SonfX/gbWcnCmMGaONGt4ftuV/DRXDnWaqjt88g=;
        b=fZk5YmXP1wJalvw5DyUIc5Kw2XgUrFiTWWxrIpjVIWPOP/IAEC+2JNvmwK/RSeU9Z2
         yTrWykEyQ3jJuuuGy01f3G2Q95kItJTMvJAIys4dyd/pZJrukDDEPaQyFArmG3zoDfnb
         HMgyw2ToEzPbcZZVxgGk4UbzjtlV/Lw3q5SjcHJ517vanDY+O348Co7QLO/7MSKMywcy
         kzwN3O3rbh3Omy/GB7ttPJIGlIFFe6Lk6ItDMfNungvshJIATS1/tYUz6IFSM0fKLrLk
         htODhzgIbb7PCf2Jnld3FAXY1kqHmMH+jOnt/1LTdVo0sLduDT3kOVBeuWT+8U2Mp+kG
         SF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373486; x=1779978286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aqE3SonfX/gbWcnCmMGaONGt4ftuV/DRXDnWaqjt88g=;
        b=RDWJI06bYFyOJT+UhvTERih3t5RoaQGG8X+46EIeu9oZVam3MycSRLMP2gbi48jbBZ
         UfCoAPkV/uUeLvrJqg9LaIVblzNSL94+EXz5X6vVc//R2lwH3bzRZCJ7gxLop84JhK3h
         KwQPSkt3cyJZ1NgKPlf8InKReCuNt0SEWGRfsBemc4uniBrWSPaL5pdpKma/duZ/eXrL
         W4n2UJQdq7Zli1hc39AAPGd9/b9Fmk/okJUMtfkFVEMZhTkfgW/bE09SvqAoCxJx6jEH
         PmzGMn3sRilxXAAHO9JuDM5LDgDkNKlrkm2HqsdKFbvsZTTYBIK0g0cGgBHb1qPaKSl9
         DHDw==
X-Gm-Message-State: AOJu0YwTZHveWyZvGxk5GQXS2QL7kuA4DYng0yaWLUZRrnCIkzdFklr5
	iU7uuh9tNHT6gMm1snb49s+mBSnAcxPb2McKZIBa975ZxbkYloFkD6CrVIdplyBCIEuDVLq2ETX
	eC673pzFLnsEGZg99G5adRrPOheuiHI4=
X-Gm-Gg: Acq92OHFS2qth4D9TY5VH5qN1I4C4gpOpyd7ISydaMekXR+dd8KnIlF8qZD0LJHDbyz
	BX9u8H7AT341MBHf8nYTMJozmY0IRtcS79HqfRfNb6JDpBgFETXW+jrNJEk1pGXfDv0dCQ/LDh5
	ctBOnPQUhRdzyerXXBT/isTjZZVZ0S4xIL0McC2AEUxOougmrhHqxgVtWOu6Mu6KnZcn5sNOoKw
	horMQPE/e4L0fWsqyoQpJ/tqa8O9P0vWms3Q34f/gSWuSfR3uc+RG/qK+ISKd/F8OTXAe8LlK1F
	uAj2
X-Received: by 2002:a2e:a548:0:b0:38e:cab9:3637 with SMTP id
 38308e7fff4ca-395ca6386cfmr12750401fa.18.1779373485499; Thu, 21 May 2026
 07:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515144548.13795-1-stephen.smalley.work@gmail.com> <CAP+JOzQsYmrevuw6fKu7LE_Pi0JH1X15wqTqd0zuvv8vJ1s7OA@mail.gmail.com>
In-Reply-To: <CAP+JOzQsYmrevuw6fKu7LE_Pi0JH1X15wqTqd0zuvv8vJ1s7OA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 21 May 2026 10:24:33 -0400
X-Gm-Features: AVHnY4KJHx84_NcYpREoCKM6Q_a0hE38ztclxSo1KLbUNq5ri0auVl8q47e-pmw
Message-ID: <CAP+JOzTqiS-KWJA2vmkEburW1WG9PJ0pnBGGo26XHpaST2rxKw@mail.gmail.com>
Subject: Re: [PATCH] gui: do not load from cwd and properly quote inputs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:05=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, May 15, 2026 at 10:45=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > gui can be called via pkexec and therefore should never trust
> > its cwd. The initial arguments and file names can be
> > user-supplied so ensure they are properly quoted.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  gui/modulesPage.py           | 5 ++++-
> >  gui/polgengui.py             | 6 +-----
> >  gui/sepolgen                 | 2 +-
> >  gui/system-config-selinux.py | 5 +----
> >  4 files changed, 7 insertions(+), 11 deletions(-)
> >
> > diff --git a/gui/modulesPage.py b/gui/modulesPage.py
> > index 02b79f15..7ae5a80a 100644
> > --- a/gui/modulesPage.py
> > +++ b/gui/modulesPage.py
> > @@ -194,7 +194,10 @@ class modulesPage(semanagePage):
> >      def add(self, file):
> >          try:
> >              self.wait()
> > -            status, output =3D getstatusoutput("semodule -i %s" % file=
)
> > +            p =3D Popen(["semodule", "-i", file], stdout=3DPIPE, stder=
r=3DPIPE,
> > +                      universal_newlines=3DTrue)
> > +            out, err =3D p.communicate()
> > +            status, output =3D p.returncode, (out or "") + (err or "")
> >              self.ready()
> >              if status !=3D 0:
> >                  self.error(output)
> > diff --git a/gui/polgengui.py b/gui/polgengui.py
> > index 9c151a11..76751e02 100644
> > --- a/gui/polgengui.py
> > +++ b/gui/polgengui.py
> > @@ -85,7 +85,6 @@ except:
> >  version =3D "1.0"
> >
> >  sys.path.append('/usr/share/system-config-selinux')
> > -sys.path.append('.')
> >
> >  # From John Hunter http://www.daa.com.au/pipermail/pygtk/2003-February=
/004454.html
> >
> > @@ -98,10 +97,7 @@ def foreach(model, path, iter, selected):
> >  ##
> >  xml =3D Gtk.Builder()
> >  xml.set_translation_domain(PROGNAME)
> > -if os.access("polgen.ui", os.F_OK):
> > -    xml.add_from_file("polgen.ui")
> > -else:
> > -    xml.add_from_file("/usr/share/system-config-selinux/polgen.ui")
> > +xml.add_from_file("/usr/share/system-config-selinux/polgen.ui")
> >
> >  FILE =3D 1
> >  DIR =3D 2
> > diff --git a/gui/sepolgen b/gui/sepolgen
> > index 2f0c1cc7..f99fd01c 100644
> > --- a/gui/sepolgen
> > +++ b/gui/sepolgen
> > @@ -1,2 +1,2 @@
> >  #!/bin/sh
> > -sepolicy generate $*
> > +exec sepolicy generate "$@"
> > diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.p=
y
> > index 0b6ba4b5..694a791c 100644
> > --- a/gui/system-config-selinux.py
> > +++ b/gui/system-config-selinux.py
> > @@ -74,10 +74,7 @@ version =3D "1.0"
> >  ##
> >  xml =3D Gtk.Builder()
> >  xml.set_translation_domain(PROGNAME)
> > -if os.access("system-config-selinux.ui", os.F_OK):
> > -    xml.add_from_file("system-config-selinux.ui")
> > -else:
> > -    xml.add_from_file("/usr/share/system-config-selinux/system-config-=
selinux.ui")
> > +xml.add_from_file("/usr/share/system-config-selinux/system-config-seli=
nux.ui")
> >
> >
> >  class childWindow:
> > --
> > 2.54.0
> >
