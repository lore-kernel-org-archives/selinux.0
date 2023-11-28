Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lgmuaswa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D908D6D
	for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 07:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701183717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OStVEEJfM8cX6Zagq++pjfsw1PakX5bgrkhIzAevWmw=;
	b=Lgmuaswao4JbkkoaawqWQYwyNd3l+yDWhc8v5s2CHtvrXodBmn5CmvwgOmFJ2Il4AaAvWX
	R69Zu7XJ9DlNRmHzqLqZRw7hk4fXg2T/IgYivvq1e1e5PgY73yYo+4hpNOEUIauwTd0ziH
	I3JZDwpHMp6oKBW3laqkdwfSnE3Z2jQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-ZZT9VcsgPeGxV04b_s0u1w-1; Tue, 28 Nov 2023 10:01:55 -0500
X-MC-Unique: ZZT9VcsgPeGxV04b_s0u1w-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cd855b6003so3343287b3a.3
        for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 07:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183714; x=1701788514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OStVEEJfM8cX6Zagq++pjfsw1PakX5bgrkhIzAevWmw=;
        b=CkY4YeMz3DGoHTGNMEZgi7Y7VMFEun1HYnlYIrswwUTCOrOZ0G8Qd4SThGlQO8j5GT
         G1Ma7gQ28NkTgmh9NvC0ApgUZTJQpOrJW4G6TWZWSZgO2mRqi/eOgGkBDwydQVBXKtrE
         SLxpj8NMEnBnDmUiiNIFUnGiTPKvyT4iuMUEcIWpROflzZlDX2trTeo55kUB9nWT/w6q
         sZB0IajvhndgO6Av/v10WrKpB1RUfY5fI0in5aQO7erXgvNtbi/xvUX6fVPmaSeyHjMy
         jOwvDmF1IiAh7YYQl7+zEqn+iRa8VwrT5T6VSRqoQiZp928C7pVDN6X7Gcu42pmAA44s
         aldw==
X-Gm-Message-State: AOJu0YxTlCnztlY7Xgfw+V/gb4hezChlLy+UnMKCYwsVeIwlAxDsZmza
	E4GLi65/FhGiJyfaj71N2Ey+ZWS0vIk+fsMTol9NnTSsFCIZxjyYPqKQqkzVxaoLv9rIIElqwwX
	wQpYjI8A+woGodFliN3ypmS5OKAult4ykP4W4Vl9y+7Rh
X-Received: by 2002:a05:6a00:1993:b0:6cb:cdd0:76f7 with SMTP id d19-20020a056a00199300b006cbcdd076f7mr17427432pfl.21.1701183714219;
        Tue, 28 Nov 2023 07:01:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHctX5/PDKfdaRtDplpYiwDKDTzSQ6M+nSoP0RCInADo+3klhULe2Ti4N2N9cgo172qyg4pfWREJ/3BU7HtaaE=
X-Received: by 2002:a05:6a00:1993:b0:6cb:cdd0:76f7 with SMTP id
 d19-20020a056a00199300b006cbcdd076f7mr17427399pfl.21.1701183713818; Tue, 28
 Nov 2023 07:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNt1vLh5YEM98UKqOQSxNP0=b7kBVA14921qk8n=J9HtYg@mail.gmail.com>
 <20231122112942.2832586-2-lautrbach@redhat.com>
In-Reply-To: <20231122112942.2832586-2-lautrbach@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 28 Nov 2023 16:01:42 +0100
Message-ID: <CAFqZXNtbOW6n_UptZXNLS1LUwPuHd7ezMTnJO-ysbJHDz-pAXg@mail.gmail.com>
Subject: Re: [PATCH v2] sepolicy: port to dnf4 python API
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 12:31=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>
> yum module is not available since RHEL 7.
>
> Drop -systemd related code as it's obsoleted these days - only 2
> packages ship their .service in -systemd subpackage
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---
>
> v2: use with dnf.Base() as base:  suggested by Ondrej Mosnacek <omosnace@=
redhat.com>

For the fix:

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

(I didn't review the full patch, but Jim's v1 ack should still apply
to the rest.)

>
>  python/sepolicy/sepolicy/generate.py | 56 +++++++++++++---------------
>  1 file changed, 25 insertions(+), 31 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepol=
icy/generate.py
> index b6df3e91160b..adf65f27a822 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -1262,24 +1262,20 @@ allow %s_t %s_t:%s_socket name_%s;
>          return fcfile
>
>      def __extract_rpms(self):
> -        import yum
> -        yb =3D yum.YumBase()
> -        yb.setCacheDir()
> -
> -        for pkg in yb.rpmdb.searchProvides(self.program):
> -            self.rpms.append(pkg.name)
> -            for fname in pkg.dirlist + pkg.filelist + pkg.ghostlist:
> -                for b in self.DEFAULT_DIRS:
> -                    if b =3D=3D "/etc":
> -                        continue
> -                    if fname.startswith(b):
> -                        if os.path.isfile(fname):
> -                            self.add_file(fname)
> -                        else:
> -                            self.add_dir(fname)
> +        import dnf
> +
> +        with dnf.Base() as base:
> +            base.read_all_repos()
> +            base.fill_sack(load_system_repo=3DTrue)
> +
> +            query =3D base.sack.query()
>
> -            for bpkg in yb.rpmdb.searchNames([pkg.base_package_name]):
> -                for fname in bpkg.dirlist + bpkg.filelist + bpkg.ghostli=
st:
> +            pq =3D query.available()
> +            pq =3D pq.filter(file=3Dself.program)
> +
> +            for pkg in pq:
> +                self.rpms.append(pkg.name)
> +                for fname in pkg.files:
>                      for b in self.DEFAULT_DIRS:
>                          if b =3D=3D "/etc":
>                              continue
> @@ -1288,20 +1284,18 @@ allow %s_t %s_t:%s_socket name_%s;
>                                  self.add_file(fname)
>                              else:
>                                  self.add_dir(fname)
> -
> -        # some packages have own systemd subpackage
> -        # tor-systemd for example
> -        binary_name =3D self.program.split("/")[-1]
> -        for bpkg in yb.rpmdb.searchNames(["%s-systemd" % binary_name]):
> -            for fname in bpkg.filelist + bpkg.ghostlist + bpkg.dirlist:
> -                for b in self.DEFAULT_DIRS:
> -                    if b =3D=3D "/etc":
> -                        continue
> -                    if fname.startswith(b):
> -                        if os.path.isfile(fname):
> -                            self.add_file(fname)
> -                        else:
> -                            self.add_dir(fname)
> +                sq =3D query.available()
> +                sq =3D sq.filter(provides=3Dpkg.source_name)
> +                for bpkg in sq:
> +                    for fname in bpkg.files:
> +                        for b in self.DEFAULT_DIRS:
> +                            if b =3D=3D "/etc":
> +                                continue
> +                            if fname.startswith(b):
> +                                if os.path.isfile(fname):
> +                                    self.add_file(fname)
> +                                else:
> +                                    self.add_dir(fname)
>
>      def gen_writeable(self):
>          try:
> --
> 2.41.0
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

