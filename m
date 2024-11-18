Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CBD1A9B44
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960756; cv=none; b=OIrluFThd+5f8NL8PbaaI68CUtLT91sF0FXQuK7vYT3/hbPPA3zIPa/VS9Hvn66pnaq83EcH+0QroEH60SLBxR7DGdFp+ZwHhSJCuBqgNTWlGSGMqyHkqPMXGgtghNpsWaoyhlQPts8zcV8dUi/1cgDCEJx/w0O9UbTmFjVF4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960756; c=relaxed/simple;
	bh=HDenSzwxsV6EqFUq0E47LkSFK/79C01CK6sdlMC8/QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcD4Mltb2M3SCckNkoobPB5wTNohLlRXs6gFyoLV2bkbV2rk8QUrOMAsBpbMVfbuucFpah5iYB8+rpJya+Z+ez5IdQ8AaYeV0cU+3ga7WSnfKpJVyaPxZApsyDo2fRPW2fZ6l6MPoc7q9QVL9o2bjWi1Rn5x1SclS6q61ulBmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt68FpGv; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt68FpGv"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71806621d42so1575204a34.3
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 12:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731960753; x=1732565553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0wW0k+ihpupvZ1+FY/FDSEglExMDwjinf0kVY8PiUk=;
        b=Mt68FpGvf5hM2rtneSsY6ZLnOHGDWR0618yI5nzDOiVVixek6M+KRwB55UypCg1BIN
         4jPyu6t2gbryFCDr00+fLbynSlfih8eUQFV7KCvk83mKnJ2ySi5atuALTz8Bcg3eaL8X
         ConbwUg5Y91mak76uDXyzOXy6GgbKvASVHVAj4IgtimnDEGFpWkS4G9XAxrLvN3u8zVa
         36RKHJ1Z7NM1Ud3NRyudqkkqYM8cu4As6JkxOcLSJB+pXdYpFPSMSIm0ykUXR3RB8Try
         WXJVN+Z9Gd4GEpntS8zVN2COwM5oSOx41lc6n9SvjiZgBdbP6C+PYqI7Hj7D6yEZiJtx
         AnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960753; x=1732565553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0wW0k+ihpupvZ1+FY/FDSEglExMDwjinf0kVY8PiUk=;
        b=O/zu2NK7Z+LVkXPJj/U9xuhe8FAE84XoHKYXcwSOzj/mwNcjSLZfmlxe27UWht5gnz
         ++HUh8lMBx11HaP4DC176xCrnhbTAzo1Nyo7OpWke3MXA796iZXSqxj1T1DPCN+a8qH0
         pEnJO4CDjwUpYRTJrifaqa51Azlzdm0JMRU4Op1qre077DqH5lnMUzab/CHEblnl90IC
         bwopWly2yClEYIVs7lDzF0Yec2BOV8sRsktBtYhBLvlUYFigiTB3ijtu0WOOT3dvR9Sj
         Ir2UiLHI1PaDLCiYBS1u7BgttEs2rUlSZS6wh5vFWUlKNxB+3od+I4GuNugdmPpQErR6
         +GTw==
X-Gm-Message-State: AOJu0YyRkjMq1MHmGQ6IYZn6NImK0tYT4lskNL2EkeoirKfuf7YPREzw
	PAFi4GmAfuhFbZvfsVZX86rEs+zdsH9cVmJCJSbdpoNuZhmV9sRAUbfvKIzqDFiC7RN9GRQ3RlF
	1gJZ5DWJ1RGfQw8npTH+vbBmnF0T8BA==
X-Google-Smtp-Source: AGHT+IGzYAphHMgJdpCEcWVwU8Yw+m0+kmWnHwkdDkKZw8ikAcFZY16xvm2DNKKgUTSC8zryDo5VxF+eXk/htKXPCwM=
X-Received: by 2002:a05:6830:600c:b0:716:1530:fc7e with SMTP id
 46e09a7af769-71a7793753emr9079391a34.1.1731960753375; Mon, 18 Nov 2024
 12:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105183319.250410-1-cgoettsche@seltendoof.de>
 <20241105183319.250410-2-cgoettsche@seltendoof.de> <CAP+JOzSH1vDNcz6mktCwNMpcv6+BHcps_3KM3w3_rEDHX=Z0eQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSH1vDNcz6mktCwNMpcv6+BHcps_3KM3w3_rEDHX=Z0eQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 18 Nov 2024 15:12:22 -0500
Message-ID: <CAP+JOzQexh51+gaivt1+PSY8W9HtQXu9-Xq=v3eWSC8DG7_A+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] policycoreutils: introduce unsetfiles
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:50=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Nov 5, 2024 at 1:34=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Introduce a helper to remove SELinux file security contexts.
> >
> > Mainly for testing label operations, and only for SELinux disabled
> > systems, since removing file contexts is not supported by SELinux.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these nine patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These nine patches have been merged.
Thanks,
Jim

> > ---
> > v2:
> >    move from libselinux/utils to policycoreutils and rename
> > ---
> >  policycoreutils/.gitignore              |   1 +
> >  policycoreutils/Makefile                |   2 +-
> >  policycoreutils/unsetfiles/Makefile     |  26 ++++
> >  policycoreutils/unsetfiles/unsetfiles.1 |  46 ++++++
> >  policycoreutils/unsetfiles/unsetfiles.c | 183 ++++++++++++++++++++++++
> >  5 files changed, 257 insertions(+), 1 deletion(-)
> >  create mode 100644 policycoreutils/unsetfiles/Makefile
> >  create mode 100644 policycoreutils/unsetfiles/unsetfiles.1
> >  create mode 100644 policycoreutils/unsetfiles/unsetfiles.c
> >
> > diff --git a/policycoreutils/.gitignore b/policycoreutils/.gitignore
> > index 47c9cc52..33e7414c 100644
> > --- a/policycoreutils/.gitignore
> > +++ b/policycoreutils/.gitignore
> > @@ -9,4 +9,5 @@ setfiles/restorecon
> >  setfiles/restorecon_xattr
> >  setfiles/setfiles
> >  setsebool/setsebool
> > +unsetfiles/unsetfiles
> >  hll/pp/pp
> > diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> > index b930b297..32ad0201 100644
> > --- a/policycoreutils/Makefile
> > +++ b/policycoreutils/Makefile
> > @@ -1,4 +1,4 @@
> > -SUBDIRS =3D setfiles load_policy newrole run_init secon sestatus semod=
ule setsebool scripts po man hll
> > +SUBDIRS =3D setfiles load_policy newrole run_init secon sestatus semod=
ule setsebool scripts po man hll unsetfiles
> >
> >  all install relabel clean indent:
> >         @for subdir in $(SUBDIRS); do \
> > diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unse=
tfiles/Makefile
> > new file mode 100644
> > index 00000000..9e5edc04
> > --- /dev/null
> > +++ b/policycoreutils/unsetfiles/Makefile
> > @@ -0,0 +1,26 @@
> > +PREFIX ?=3D /usr
> > +SBINDIR ?=3D $(PREFIX)/sbin
> > +MANDIR ?=3D $(PREFIX)/share/man
> > +
> > +override CFLAGS +=3D -D_GNU_SOURCE
> > +override LDLIBS +=3D -lselinux
> > +
> > +
> > +all: unsetfiles
> > +
> > +unsetfiles: unsetfiles.o
> > +
> > +install: all
> > +       test -d $(DESTDIR)$(SBINDIR)     || install -m 755 -d $(DESTDIR=
)$(SBINDIR)
> > +       test -d $(DESTDIR)$(MANDIR)/man1 || install -m 755 -d $(DESTDIR=
)$(MANDIR)/man1
> > +       install -m 755 unsetfiles $(DESTDIR)$(SBINDIR)
> > +       install -m 644 unsetfiles.1 $(DESTDIR)$(MANDIR)/man1/
> > +
> > +clean:
> > +       -rm -f unsetfiles *.o
> > +
> > +indent:
> > +       ../../scripts/Lindent $(wildcard *.[ch])
> > +
> > +relabel: install
> > +       /sbin/restorecon $(DESTDIR)$(SBINDIR)/unsetfiles
> > diff --git a/policycoreutils/unsetfiles/unsetfiles.1 b/policycoreutils/=
unsetfiles/unsetfiles.1
> > new file mode 100644
> > index 00000000..49d0c821
> > --- /dev/null
> > +++ b/policycoreutils/unsetfiles/unsetfiles.1
> > @@ -0,0 +1,46 @@
> > +.TH UNSETFILES "1" "December 2023" "Security Enhanced Linux"
> > +.SH NAME
> > +unsetfiles \- Remove SELinux file security contexts.
> > +.SH SYNOPSIS
> > +.B unsetfiles
> > +.RB [ \-hnrvx ]
> > +.IR pathname \ ...
> > +
> > +.SH DESCRIPTION
> > +.P
> > +This program removes the SELinux file security contexts of files.  It =
can help
> > +cleaning extended file attributes after disabling SELinux.
> > +.P
> > +.B unsetfiles
> > +will only work on SELinux disabled systems, since removing file securi=
ty
> > +contexts is not supported by SELinux.
> > +
> > +.SH OPTIONS
> > +.TP
> > +.B \-h
> > +Show usage information and exit.
> > +.TP
> > +.B \-n
> > +Do not actually remove any SELinux file security contexts.
> > +.TP
> > +.B \-r
> > +Remove SELinux file security contexts recursive.
> > +.TP
> > +.B \-v
> > +Be verbose about performed actions.
> > +.TP
> > +.B \-x
> > +Do not cross filesystem boundaries.
> > +
> > +.SH ARGUMENTS
> > +.TP
> > +.IR pathname \ ...
> > +One or more path names to operate on.
> > +
> > +.SH SEE ALSO
> > +.BR restorecon (8),
> > +.BR setfiles (8)
> > +
> > +.SH AUTHORS
> > +.nf
> > +Christian G=C3=B6ttsche (cgzones@googlemail.com)
> > diff --git a/policycoreutils/unsetfiles/unsetfiles.c b/policycoreutils/=
unsetfiles/unsetfiles.c
> > new file mode 100644
> > index 00000000..6293d00f
> > --- /dev/null
> > +++ b/policycoreutils/unsetfiles/unsetfiles.c
> > @@ -0,0 +1,183 @@
> > +#include <dirent.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <getopt.h>
> > +#include <linux/magic.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#include <sys/xattr.h>
> > +#include <unistd.h>
> > +
> > +#include <selinux/selinux.h>
> > +
> > +
> > +#define XATTR_NAME_SELINUX "security.selinux"
> > +
> > +
> > +static void usage(const char *progname)
> > +{
> > +       fprintf(stderr, "usage: %s [-nrvx] <path>\n\n"
> > +                       "Options:\n"
> > +                       "\t-n\tdon't remove any file labels\n"
> > +                       "\t-r\tremove labels recursive\n"
> > +                       "\t-v\tbe verbose\n"
> > +                       "\t-x\tdo not cross filesystem boundaries\n",
> > +                       progname);
> > +}
> > +
> > +static void unset(int atfd, const char *path, const char *fullpath,
> > +                  bool dry_run, bool recursive, bool verbose,
> > +                  dev_t root_dev)
> > +{
> > +       ssize_t ret;
> > +       int fd, rc;
> > +       DIR *dir;
> > +
> > +       ret =3D lgetxattr(fullpath, XATTR_NAME_SELINUX, NULL, 0);
> > +       if (ret <=3D 0) {
> > +               if (errno !=3D ENODATA && errno !=3D ENOTSUP)
> > +                       fprintf(stderr, "Failed to get SELinux label of=
 %s:  %m\n", fullpath);
> > +               else if (verbose)
> > +                       printf("Failed to get SELinux label of %s:  %m\=
n", fullpath);
> > +       } else {
> > +               if (dry_run) {
> > +                       printf("Would remove SELinux label of %s\n", fu=
llpath);
> > +               } else {
> > +                       if (verbose)
> > +                               printf("Removing label of %s\n", fullpa=
th);
> > +
> > +                       rc =3D lremovexattr(fullpath, XATTR_NAME_SELINU=
X);
> > +                       if (rc < 0)
> > +                               fprintf(stderr, "Failed to remove SELin=
ux label of %s:  %m\n", fullpath);
> > +               }
> > +       }
> > +
> > +       if (!recursive)
> > +               return;
> > +
> > +       fd =3D openat(atfd, path, O_RDONLY | O_DIRECTORY | O_NOFOLLOW |=
 O_CLOEXEC);
> > +       if (fd < 0) {
> > +               if (errno !=3D ENOTDIR)
> > +                       fprintf(stderr, "Failed to open %s:  %m\n", ful=
lpath);
> > +               return;
> > +       }
> > +
> > +       if (root_dev !=3D (dev_t)-1) {
> > +               struct stat sb;
> > +
> > +               rc =3D fstat(fd, &sb);
> > +               if (rc =3D=3D -1) {
> > +                       fprintf(stderr, "Failed to stat directory %s:  =
%m\n", fullpath);
> > +                       close(fd);
> > +                       return;
> > +               }
> > +
> > +               if (sb.st_dev !=3D root_dev) {
> > +                       if (verbose)
> > +                               printf("Skipping directory %s due to fi=
lesystem boundary\n", fullpath);
> > +
> > +                       close(fd);
> > +                       return;
> > +               }
> > +       }
> > +
> > +       dir =3D fdopendir(fd);
> > +       if (!dir) {
> > +               fprintf(stderr, "Failed to open directory %s:  %m\n", f=
ullpath);
> > +               close(fd);
> > +               return;
> > +       }
> > +
> > +       while (true) {
> > +               const struct dirent *entry;
> > +               char *nextfullpath;
> > +
> > +               errno =3D 0;
> > +               entry =3D readdir(dir);
> > +               if (!entry) {
> > +                       if (errno)
> > +                               fprintf(stderr, "Failed to iterate dire=
ctory %s:  %m\n", fullpath);
> > +                       break;
> > +               }
> > +
> > +               if (entry->d_name[0] =3D=3D '.' && (entry->d_name[1] =
=3D=3D '\0' || (entry->d_name[1] =3D=3D '.' && entry->d_name[2] =3D=3D '\0'=
)))
> > +                       continue;
> > +
> > +               rc =3D asprintf(&nextfullpath, "%s/%s", strcmp(fullpath=
, "/") =3D=3D 0 ? "" : fullpath, entry->d_name);
> > +               if (rc < 0) {
> > +                       fprintf(stderr, "Out of memory!\n");
> > +                       closedir(dir);
> > +                       return;
> > +               }
> > +
> > +               unset(dirfd(dir), entry->d_name, nextfullpath, dry_run,=
 recursive, verbose, root_dev);
> > +
> > +               free(nextfullpath);
> > +       }
> > +
> > +       closedir(dir);
> > +}
> > +
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       bool dry_run =3D false, recursive =3D false, verbose =3D false,=
 same_dev =3D false;
> > +       int c;
> > +
> > +       while ((c =3D getopt(argc, argv, "hnrvx")) !=3D -1) {
> > +               switch (c) {
> > +               case 'h':
> > +                       usage(argv[0]);
> > +                       return EXIT_SUCCESS;
> > +               case 'n':
> > +                       dry_run =3D true;
> > +                       break;
> > +               case 'r':
> > +                       recursive =3D true;
> > +                       break;
> > +               case 'v':
> > +                       verbose =3D true;
> > +                       break;
> > +               case 'x':
> > +                       same_dev =3D true;
> > +                       break;
> > +               default:
> > +                       usage(argv[0]);
> > +                       return EXIT_FAILURE;
> > +               }
> > +       }
> > +
> > +       if (optind >=3D argc) {
> > +               usage(argv[0]);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       if (is_selinux_enabled()) {
> > +               fprintf(stderr, "Removing SELinux attributes on a SELin=
ux enabled system is not supported!\n");
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       for (int index =3D optind; index < argc; index++) {
> > +               dev_t root_dev =3D (dev_t)-1;
> > +
> > +               if (same_dev) {
> > +                       struct stat sb;
> > +                       int rc;
> > +
> > +                       rc =3D stat(argv[index], &sb);
> > +                       if (rc =3D=3D -1) {
> > +                               fprintf(stderr, "Failed to stat %s:  %m=
\n", argv[index]);
> > +                               continue;
> > +                       }
> > +
> > +                       root_dev =3D sb.st_dev;
> > +               }
> > +               unset(AT_FDCWD, argv[index], argv[index], dry_run, recu=
rsive, verbose, root_dev);
> > +       }
> > +
> > +       return EXIT_SUCCESS;
> > +}
> > --
> > 2.45.2
> >
> >
