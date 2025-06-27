Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208EC15E8B
	for <selinux@vger.kernel.org>; Fri, 27 Jun 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751047680; cv=none; b=goKkQkywTt5kbB3ZIgQI/RMmcwNo0PeFAScyfWcxxbbfq5qPSmrWIUk/lAeLbJiA0hmI76semvJPFAMJDhYlR1pBkYsQwHiedLT+lJ7tqh7GivcngXjkzNOIjGDcD0azyxZOc5JPXx+OSVD1CNGFYEURF6I35T9t+RgdL0WsgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751047680; c=relaxed/simple;
	bh=+QmUodMCsQtef74xIC6YDXO/N9jOhRXLTTLELmESdik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDVMZ4MJoslcriJ5oCAuI1hE1Xi2/u0H6hIszz7P4qXCqrHHYsTLC6YnaHRaRjuXLEAfSf513xuq2d5i7FH5hliToR0BakHGyFa0Sbil1aCjouzFBZ+vqXoQfCrRXgarif+OCoXJI0Yq9kqmjVxKZKu380XFLXiR7JJ1z/Bq+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOSVG2db; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOSVG2db"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a58e0b26c4so2111301cf.3
        for <selinux@vger.kernel.org>; Fri, 27 Jun 2025 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751047677; x=1751652477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc/gxddavLeNZoPaiJ6Th89dN2mJEtwBJEaDIabUbbE=;
        b=UOSVG2dbiINK3/s3WeZZ38P4U9NoQ3mRQLOQJK9onvx3+m3nHMD4YJfNpqIJMpVMvr
         RN6ZXNc9GnEm6MQqtM+pd5mkXDKz8xHCkZKHGWaGFLja6QBhu2wISYm3PKjKkwy5JOK+
         +6oQqhhGK5/lNoWFVWXWejaylc3J87NUPwc5vr8QvknAjsjNQLDCMllAGhVCQqUfNCeM
         7+61joH6B1oSwJHGU4VmLJH13VCintVvtsmQezL14HmgL/S7qYyNqzVwSgPQ1iauXXMb
         u5bLe2qcxbMiGjKvi9tck7bBO8xsCfXF4q7ouJ9IogBLgJy1DgVLvFOeQuZ5h01G7M63
         51SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751047677; x=1751652477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc/gxddavLeNZoPaiJ6Th89dN2mJEtwBJEaDIabUbbE=;
        b=Tbl6UD2PQOct+SQjXVjqofGjzRVSbfFIyKZs+3VwiotXVeEdYOqKxtkJTh/OlP7Vn8
         UeZujU7h6a6xGsj1uklIqEzRgr9/2Q/htm7E0yyF6Y8iI7WqN0VDT+XWAbIhKAvth+So
         JQDv3F18wADz9829rbQ6Q+QKeOCsCk0CJ5K96d0rZ5RQ5vc17ulc/0HBB8Y/GvM2BElc
         3BRFtdJfHpYshF3EPhJzP1vFqxfd9yHhn2oE72SpBnZxKzBN4u40vzpCaPhwNK5ZxDle
         cqwiT0/utfxNS/BVx1QCWM3otzfcL4IqNsThtepH4wwTFLJOruIWT0okFRigcNtrWqUi
         CtGA==
X-Gm-Message-State: AOJu0YzN5XX3Xr/I/SAMB73fAvCs1F5ldH2MnQnFoIfZX0PuxxrebSu/
	KA8Kg/WLJ4fJSIEEgpiNuZrHnyLohZqZh4En8Ybhtmk3RmPPG8wVPgpyq1yPrrV8fJyubOyy3eW
	1cWbO5fC4tRc6Xfi7aWhfZB0SfvvqTODXviBI
X-Gm-Gg: ASbGnctO2K2ePKy8bm56ZlhQP/ss5TAWP2r4yqu7afeJFF9Y6dilmheL3mniUe01YhL
	vyvadi4a4PgmG9q76AimRUw3jKf7JcVqwPORy+VsXgxQ0fIQgJXxxq5Ot313B6AZHgYf4/AxiJ4
	muwUYGIWvrgDsc8umX2V4orDT7NkhdAOyKaE8qi215
X-Google-Smtp-Source: AGHT+IFdB3+JUO5PWjwt8AD+8mJataI43/FdSJFa1v6ldR2gzJvDgrdsmc+4RZrCm3AUAiHVHW0lTJbXIHS1Pm1JuOc=
X-Received: by 2002:a05:620a:458b:b0:7d2:28c7:7795 with SMTP id
 af79cd13be357-7d4439695bdmr684122785a.35.1751047676775; Fri, 27 Jun 2025
 11:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87bjqebpre.fsf@redhat.com> <20250625104103.140498-1-hi@alyssa.is>
 <20250625104103.140498-2-hi@alyssa.is> <CAP+JOzTCEYA0x11_XP+8=O4Yixh7UgpO+JhRPRz_jutfL_-GMQ@mail.gmail.com>
 <877c0xfcoc.fsf@alyssa.is>
In-Reply-To: <877c0xfcoc.fsf@alyssa.is>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 27 Jun 2025 14:07:43 -0400
X-Gm-Features: Ac12FXz_3p5Ol_gy5r3gztMVdhtUWiKl4i5HZumDrMOYJt3jKNVE72OMsYNVhlI
Message-ID: <CAP+JOzRh9UGXUkq2sgHxjK8105E3yOShVqbzEyUxZDSSXb2MLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] policycoreutils: use pkg-config for libsemanage
To: Alyssa Ross <hi@alyssa.is>
Cc: selinux@vger.kernel.org, Petr Lautrbach <lautrbach@redhat.com>, 
	Nicolas Iooss <nicolas.iooss@m4x.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Dan Walsh <dwalsh@redhat.com>, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 11:04=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Wed, Jun 25, 2025 at 6:41=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrot=
e:
> >>
> >> libaudit and libbz2 are only required to be in the linker path for
> >> static builds.  For dynamic builds, they'll be discovered through ELF
> >> metadata.  pkg-config knows how to do the right thing in both cases,
> >> so just use it rather than listing libsemanage's dependencies
> >> manually.
> >>
> >> Fixes: da6cd3d8 ("Support static-only builds")
> >> Closes: https://lore.kernel.org/r/87bjqebpre.fsf@redhat.com
> >> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> >> ---
> >>  policycoreutils/Makefile           | 3 ++-
> >>  policycoreutils/semodule/Makefile  | 3 +--
> >>  policycoreutils/setsebool/Makefile | 3 +--
> >>  3 files changed, 4 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> >> index 7acd51dd..0f3d62f2 100644
> >> --- a/policycoreutils/Makefile
> >> +++ b/policycoreutils/Makefile
> >> @@ -3,7 +3,8 @@ SUBDIRS =3D setfiles load_policy newrole run_init seco=
n sestatus semodule setseboo
> >>  PKG_CONFIG ?=3D pkg-config
> >>
> >>  LIBSELINUX_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libselinux)
> >> -export LIBSELINUX_LDLIBS
> >> +LIBSEMANAGE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libsemanage)
> >> +export LIBSELINUX_LDLIBS LIBSEMANAGE_LDLIBS
> >>
> >
> > I think that we actually want something like:
> > ifeq ($(DISABLE_SHARED),y)
> >     LIBSELINUX_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libselinux/src
> > $(PKG_CONFIG) --libs libselinux --static)
> >     LIBSEMANAGE_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libsemanage/sr=
c
> > $(PKG_CONFIG) --libs libsemanage --static)
> > else
> >     LIBSELINUX_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libselinux/src
> > $(PKG_CONFIG) --libs libselinux)
> >     LIBSEMANAGE_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D../libsemanage/sr=
c
> > $(PKG_CONFIG) --libs libsemanage)
> > endif
>
> > As originally written, it is going to find the installed libselinux.pc
> > and libsemanage.pc files which are not going to reflect any changes
> > made to these files in the current build (I noticed this because your
> > patch does make changes).
>
> I see.  It hadn't occurred to me that selinux userspace supported being
> built all at once like this; I'd only seen all the components built
> individually, which is evidently also what Petr is doing.  Your proposed
> solution wouldn't be compatible with different components being
> installed to different prefixes, which is how we do it in Nixpkgs, where
> every package is installed to a unique prefix.
>

Obviously we want to support building everything separately as well as
everything together.

I think that this should work:
LIBSELINUX_LDLIBS :=3D $(shell
PKG_CONFIG_PATH=3D"$(PKG_CONFIG_PATH):../libselinux/src" $(PKG_CONFIG)
--libs libselinux)
LIBSEMANAGE_LDLIBS :=3D $(shell
PKG_CONFIG_PATH=3D"$(PKG_CONFIG_PATH):../libsemanage/src" $(PKG_CONFIG)
--libs libsemanage)

Based on my testing:
1) If PKG_CONFIG_PATH is set, that will be searched first
2) If the pc files are not found, then "../libsemange/src" or
"../libselinux/src" will be searched
3) If the pc files are still not found, then pkg-config will search
using its defaults

This seems like it should work regardless.

BTW, I also tried using PKG_CONFIG_LIBDIR, but if that is set, then
only that directory will be searched.

> > Also, I believe that "--static" is needed to generate the right libs
> > for a static build.
>
> I /think/ it's generally expected that if you want static builds you set
> e.g. PKG_CONFIG=3D"pkg-config --static".  For example, a quick look at th=
e
> pkg-config autoconf macros tells me that they don't try to detect
> whether to pass it or not, and in Nixpkgs we inject --static for static
> builds.  Your proposal would also be a change in the meaning of
> DISABLE_SHARED, which until now hasn't changed how anything is built,
> just disabled things.

I see. I should just set PKG_CONFIG=3D"pkg-config --static" if I want to
build static. That works for me.

Thanks,
Jim
