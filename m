Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FddOvhgz"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCCDD47
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 12:55:52 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50be24167efso271567e87.3
        for <selinux@vger.kernel.org>; Wed, 06 Dec 2023 12:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701896151; x=1702500951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAnOJ16q0/oVJHr/0J1BsAZqYAsStKduMFJqBLIZNrM=;
        b=FddOvhgzByhzPVlQXx9UVYqhGvOPj9mtt7ZCQLnMPLOUuSV8bzHh68oVZVgCZfZ1II
         BLmAPap/zxr3sRsLjj0f1NTl/uJHlsQzSeOkAsrcT9er32DZnB9UuU9Y1weh7E12VbGj
         e0Ctm99uZ5n4pmnXxFYjn+1OG3wNzJCdg2u3WAkl+BiIbiWfTFDkDavLpLnqf4h0CSpO
         vhj3smu6GWo0pWA3+F9S8FmMz+5ow5DbtnPyPLMFMSCZvmRipKUs1SOQ1kGRK0z+hL4V
         02RfS+mcj6VP4siFSfjBSbJcA0R/GPDtKzd7ykhKX+b2LeXo3MLLdan5xL1ljp2dZyw7
         kZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896151; x=1702500951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAnOJ16q0/oVJHr/0J1BsAZqYAsStKduMFJqBLIZNrM=;
        b=Q39OMRicwuKTKozIDn2pOaqj8XdZsASzzC6qUNczwOtJLWrNlJqv56z2tmEDOWfkcL
         wirWH1UW+0bzjR9k/4LKzFmwP37mEUfYjMBGeCPJFo5hAUwjkjcVOrUJLbNVNPHEd6mX
         NjnxRMu9Ijlf//yJu+1e33TXbtFDd0IcP4p+ByP0xC3LzKdCWRbBLcPK2MTbLAoV17xF
         gJUpeavkBiuH2IE0ua7YqeLZhn/b2ET8PhYjDYcabP7xynAWM3KI5jYUR6rxs+6DfRZl
         IzFGlSCscY0n99d2epLHguvUBOZv++5v8+rZ8O/3CcqiLaPH+yncERG0oXcJVCskFL6Q
         mAYA==
X-Gm-Message-State: AOJu0Yy5iNHdbjkCj8pFPWc1oCm20Et7Bji1PShXYOX9VpGTrM4ZlpX1
	Q5UIxVXl3FWWjrOFFzJp7R03MnIqsyhkGQh3LHxMrVZ8
X-Google-Smtp-Source: AGHT+IE3bwe+oCWViWLLs+y1jxSW9OMkHrM5lOXXNsPG0WvCSNo0KtvQMCoWhLZVGTpoDQRNiDpvzvuw1ciRMxbi91U=
X-Received: by 2002:a05:6512:4014:b0:50b:fb82:358a with SMTP id
 br20-20020a056512401400b0050bfb82358amr568488lfb.272.1701896150556; Wed, 06
 Dec 2023 12:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNt1vLh5YEM98UKqOQSxNP0=b7kBVA14921qk8n=J9HtYg@mail.gmail.com>
 <20231122112942.2832586-2-lautrbach@redhat.com> <CAFqZXNtbOW6n_UptZXNLS1LUwPuHd7ezMTnJO-ysbJHDz-pAXg@mail.gmail.com>
In-Reply-To: <CAFqZXNtbOW6n_UptZXNLS1LUwPuHd7ezMTnJO-ysbJHDz-pAXg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 6 Dec 2023 15:55:39 -0500
Message-ID: <CAP+JOzTYDgrF-5BcxBNaRGpGykpkdX8WRi0JroqksCG9+vpdAg@mail.gmail.com>
Subject: Re: [PATCH v2] sepolicy: port to dnf4 python API
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 10:02=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> On Wed, Nov 22, 2023 at 12:31=E2=80=AFPM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
> >
> > yum module is not available since RHEL 7.
> >
> > Drop -systemd related code as it's obsoleted these days - only 2
> > packages ship their .service in -systemd subpackage
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> > ---
> >
> > v2: use with dnf.Base() as base:  suggested by Ondrej Mosnacek <omosnac=
e@redhat.com>
>
> For the fix:
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> (I didn't review the full patch, but Jim's v1 ack should still apply
> to the rest.)
>

This has now been merged.
Thanks,
Jim

> >
> >  python/sepolicy/sepolicy/generate.py | 56 +++++++++++++---------------
> >  1 file changed, 25 insertions(+), 31 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sep=
olicy/generate.py
> > index b6df3e91160b..adf65f27a822 100644
> > --- a/python/sepolicy/sepolicy/generate.py
> > +++ b/python/sepolicy/sepolicy/generate.py
> > @@ -1262,24 +1262,20 @@ allow %s_t %s_t:%s_socket name_%s;
> >          return fcfile
> >
> >      def __extract_rpms(self):
> > -        import yum
> > -        yb =3D yum.YumBase()
> > -        yb.setCacheDir()
> > -
> > -        for pkg in yb.rpmdb.searchProvides(self.program):
> > -            self.rpms.append(pkg.name)
> > -            for fname in pkg.dirlist + pkg.filelist + pkg.ghostlist:
> > -                for b in self.DEFAULT_DIRS:
> > -                    if b =3D=3D "/etc":
> > -                        continue
> > -                    if fname.startswith(b):
> > -                        if os.path.isfile(fname):
> > -                            self.add_file(fname)
> > -                        else:
> > -                            self.add_dir(fname)
> > +        import dnf
> > +
> > +        with dnf.Base() as base:
> > +            base.read_all_repos()
> > +            base.fill_sack(load_system_repo=3DTrue)
> > +
> > +            query =3D base.sack.query()
> >
> > -            for bpkg in yb.rpmdb.searchNames([pkg.base_package_name]):
> > -                for fname in bpkg.dirlist + bpkg.filelist + bpkg.ghost=
list:
> > +            pq =3D query.available()
> > +            pq =3D pq.filter(file=3Dself.program)
> > +
> > +            for pkg in pq:
> > +                self.rpms.append(pkg.name)
> > +                for fname in pkg.files:
> >                      for b in self.DEFAULT_DIRS:
> >                          if b =3D=3D "/etc":
> >                              continue
> > @@ -1288,20 +1284,18 @@ allow %s_t %s_t:%s_socket name_%s;
> >                                  self.add_file(fname)
> >                              else:
> >                                  self.add_dir(fname)
> > -
> > -        # some packages have own systemd subpackage
> > -        # tor-systemd for example
> > -        binary_name =3D self.program.split("/")[-1]
> > -        for bpkg in yb.rpmdb.searchNames(["%s-systemd" % binary_name])=
:
> > -            for fname in bpkg.filelist + bpkg.ghostlist + bpkg.dirlist=
:
> > -                for b in self.DEFAULT_DIRS:
> > -                    if b =3D=3D "/etc":
> > -                        continue
> > -                    if fname.startswith(b):
> > -                        if os.path.isfile(fname):
> > -                            self.add_file(fname)
> > -                        else:
> > -                            self.add_dir(fname)
> > +                sq =3D query.available()
> > +                sq =3D sq.filter(provides=3Dpkg.source_name)
> > +                for bpkg in sq:
> > +                    for fname in bpkg.files:
> > +                        for b in self.DEFAULT_DIRS:
> > +                            if b =3D=3D "/etc":
> > +                                continue
> > +                            if fname.startswith(b):
> > +                                if os.path.isfile(fname):
> > +                                    self.add_file(fname)
> > +                                else:
> > +                                    self.add_dir(fname)
> >
> >      def gen_writeable(self):
> >          try:
> > --
> > 2.41.0
> >
>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
>
