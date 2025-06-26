Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D620FABC
	for <selinux@vger.kernel.org>; Thu, 26 Jun 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956873; cv=none; b=D1N6gpo0XYeM3zSonPDlh1o9bmC5szNrLzwO+NmrZCV47FwP6VVrV0FNIUOh5M35FfdSYP/2veF4P1Mkv/KGpuYHIgwldZobybm4CpdCBzywJIKW5c7hCxssCP6JH/5lbys4mIGtj3l8YwoVfhoScg0OwVZZ14QXLUMITLbBlGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956873; c=relaxed/simple;
	bh=Xna7KouYSn9142y4mX57GYlEA60dptKn1Z/iVhgWRCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5jdPv/nQK1jq7PFibAZh/eFR2Ql4B65Eh3bq+0jI6PiuB6TspRmdURD7B0YpYsNQRYrrAUKZsNbuXOeotnvnKTzYhBSm3rWKfO81qZhyJuOpkac7B/l9oEW/fJnYjh45DOfJJzcD5aZ66z5saG62S3T92TO2X4yOQo6h/JY100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB7j6qIn; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB7j6qIn"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52b2290e292so420817e0c.3
        for <selinux@vger.kernel.org>; Thu, 26 Jun 2025 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750956870; x=1751561670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJn2GpNtNqZ40QN3y4RQXqzLeMQ0Uqqp/NqM8/P6s6Y=;
        b=gB7j6qIn4980TDBAgGFCG8KDiShwcRYQscmkabHAfnXx5TlXZsJffzOKAJD5hJ3Zi2
         fUqQFS5ovPOEntJWEd0Z3y9QNqL5HiEm0UzOiaTJuwuaKd84Aih+p6wUdsl0fa/D37/+
         cepSXkpK4jgwl2PPk2SrVmx/jo38dTcGQyvWp/X3ih9J85tWMW7lVTqN18xmP6jNNOyt
         CP3T2V5IneqWK8IICnd1u+u/LK7GC8ojdC7uaCFz10CFg6B48zigf8Kvkvwsv+pbZIx9
         IaGT6R8OC3DFTEi4SkknoysVv4+dbfd1xc4a9j2XyQYXxh7IrcjTRu15rkk7hAClemp2
         uaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750956870; x=1751561670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJn2GpNtNqZ40QN3y4RQXqzLeMQ0Uqqp/NqM8/P6s6Y=;
        b=CWtIpZVIvst10tcPAv908yAt6pY4dL7PIENhBjlNWoYhpeb3kIEh9eHH0Q/S18O8Rd
         oDVGAvTsndcdrClmX1AWIxKkYMWCjyqu55PRXJSVLfMjb/cnyvoBWUPRNZ9eXsGgG8W3
         LvX0GYlYlOrJjhbzLimasiIS2xMZkSqtrqBdd+jpeqHjg6Lq37xKEeSew39AtQm2/g4w
         e1lOGrsCvir6NwdnZSBXhVr3dE6CamMrgJGY2iVLYwFgqMuY3NZZzYeb8Cjp6CN6QYdQ
         KkVLugmJQ/y4jTCp7wJg759SZufaUQBvYudYXPU+pDoiWJ4lnx7RZD+DoeHdkcqXmOhz
         STbQ==
X-Gm-Message-State: AOJu0YzCIqQhcK0NEPJTarsBmY09KUjtgHD8FuMbMQ4ypmPCeN+06JYo
	3b4rMWM92E+5exsesjzLyiIsC5DQijZ/IC+p4bgYusvQcgZK48Qqe8uuhZaKqV17C6/qOeINn4k
	8nppYEHZXn80mhF9n3NYfsMz9i3SjCWY=
X-Gm-Gg: ASbGncswQovkVpaHuxhTZzWbZqS9NHHJA/tLpol0aY55H316W/ZBQQ4WMykMnBKp+pp
	5H31D4xfxv0zFdIQbXgZqaW0KnP7w291k1v/lcHytOZc4JDSRzUNNNDLAA0icZRv2Rseoak6/7W
	G/KpdbCcMmQaIMUkZX0cLxDx1rzd8TjUote9Q43TTt
X-Google-Smtp-Source: AGHT+IHZvJhRNf07i74PvNKRDuwiXBxhGG4kuNIltwEsjU2deZADWBxPxn3+o12ehcSzmiqB+SSxHH+l5CAQpX1RlGI=
X-Received: by 2002:a05:6122:200e:b0:531:2d3a:32aa with SMTP id
 71dfb90a1353d-532ef18527bmr6246103e0c.0.1750956870058; Thu, 26 Jun 2025
 09:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87bjqebpre.fsf@redhat.com> <20250625104103.140498-1-hi@alyssa.is> <20250625104103.140498-2-hi@alyssa.is>
In-Reply-To: <20250625104103.140498-2-hi@alyssa.is>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 26 Jun 2025 12:54:19 -0400
X-Gm-Features: Ac12FXx7l_KYENGeOJsnZUgYeKIdqn5Vid0gV7Stxw3yrvmGrF8p9XlRwZHVs58
Message-ID: <CAP+JOzTCEYA0x11_XP+8=O4Yixh7UgpO+JhRPRz_jutfL_-GMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] policycoreutils: use pkg-config for libsemanage
To: Alyssa Ross <hi@alyssa.is>
Cc: selinux@vger.kernel.org, Petr Lautrbach <lautrbach@redhat.com>, 
	Nicolas Iooss <nicolas.iooss@m4x.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Dan Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 6:41=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> libaudit and libbz2 are only required to be in the linker path for
> static builds.  For dynamic builds, they'll be discovered through ELF
> metadata.  pkg-config knows how to do the right thing in both cases,
> so just use it rather than listing libsemanage's dependencies
> manually.
>
> Fixes: da6cd3d8 ("Support static-only builds")
> Closes: https://lore.kernel.org/r/87bjqebpre.fsf@redhat.com
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  policycoreutils/Makefile           | 3 ++-
>  policycoreutils/semodule/Makefile  | 3 +--
>  policycoreutils/setsebool/Makefile | 3 +--
>  3 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> index 7acd51dd..0f3d62f2 100644
> --- a/policycoreutils/Makefile
> +++ b/policycoreutils/Makefile
> @@ -3,7 +3,8 @@ SUBDIRS =3D setfiles load_policy newrole run_init secon s=
estatus semodule setseboo
>  PKG_CONFIG ?=3D pkg-config
>
>  LIBSELINUX_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libselinux)
> -export LIBSELINUX_LDLIBS
> +LIBSEMANAGE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libsemanage)
> +export LIBSELINUX_LDLIBS LIBSEMANAGE_LDLIBS
>

I think that we actually want something like:
ifeq ($(DISABLE_SHARED),y)
    LIBSELINUX_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libselinux/src
$(PKG_CONFIG) --libs libselinux --static)
    LIBSEMANAGE_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libsemanage/src
$(PKG_CONFIG) --libs libsemanage --static)
else
    LIBSELINUX_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libselinux/src
$(PKG_CONFIG) --libs libselinux)
    LIBSEMANAGE_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libsemanage/src
$(PKG_CONFIG) --libs libsemanage)
endif

As originally written, it is going to find the installed libselinux.pc
and libsemanage.pc files which are not going to reflect any changes
made to these files in the current build (I noticed this because your
patch does make changes).
Also, I believe that "--static" is needed to generate the right libs
for a static build.

With my changes above, using DISABLE_SHARED=3Dy results in:
LIBSELINUX_LDLIBS =3D -L/usr/lib -lselinux -lsepol -lpcre2-8
LIBSEMANAGE_LDLIBS =3D -L/usr/lib -lsemanage -laudit -lbz2 -lselinux
-lpcre2-8 -lsepol

while a normal build results in:
LIBSELINUX_LDLIBS =3D -L/usr/lib -lselinux
LIBSEMANAGE_LDLIBS =3D -L/usr/lib -lsemanage

Does this work for everyone?

Thanks,
Jim

>  all install relabel clean indent:
>         @for subdir in $(SUBDIRS); do \
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule=
/Makefile
> index 7c45831f..018ee2ca 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -7,12 +7,11 @@ MANDIR =3D $(PREFIX)/share/man
>  CFLAGS ?=3D -Werror -Wall -W
>  override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/incl=
ude
>  override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/src
> -override LDLIBS +=3D -lsemanage -lsepol $(LIBSELINUX_LDLIBS)
> +override LDLIBS +=3D $(LIBSEMANAGE_LDLIBS) -lsepol $(LIBSELINUX_LDLIBS)
>  SEMODULE_OBJS =3D semodule.o
>
>  all: semodule genhomedircon
>
> -semodule: LDLIBS +=3D -laudit -lbz2
>  semodule: $(SEMODULE_OBJS)
>
>  genhomedircon:
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebo=
ol/Makefile
> index 1d514846..87494c55 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -8,14 +8,13 @@ BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/=
completions
>  CFLAGS ?=3D -Werror -Wall -W
>  override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/incl=
ude
>  override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/src
> -override LDLIBS +=3D -lsemanage $(LIBSELINUX_LDLIBS)
> +override LDLIBS +=3D $(LIBSEMANAGE_LDLIBS) $(LIBSELINUX_LDLIBS)
>  SETSEBOOL_OBJS =3D setsebool.o
>
>  BASHCOMPLETIONS=3Dsetsebool-bash-completion.sh
>
>  all: setsebool
>
> -setsebool: LDLIBS +=3D -laudit -lbz2
>  setsebool: $(SETSEBOOL_OBJS)
>
>  install: all
> --
> 2.49.0
>
