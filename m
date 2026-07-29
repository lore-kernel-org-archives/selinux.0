Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF93DD85A
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356453; cv=pass; b=TrbnQLP5Hl9oFyJe3FsGmitZ3kc5V6bRDw+U3XrEXVE+BPWiK9VwiUZk5UCTtauL6HEUQl71uDeefF/p5MjGTyS6KdqcWZs879tqkO3eObUr28RaQb85mpMFFA3z/A7/bXUifyuiHRNrBEX1Rh3haf/J3AOtKNt7V7Q7jHMSZLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356453; c=relaxed/simple;
	bh=YnZYVJ1x+XpxgJeKheo4kH34Z4OrtSgF0A32cix8EgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QF94c7q97MQhAmYKp9j8SpT5Gh4spwf34yaeH6VsRxpnIdv6doRc6FlQrvPFY9gtXBzTyze6RQi0bLJg6c/4LRP+6ZiY8ay1wvjPDhGzz7lKs5NGwHKX4uNkZqmeonJgkSzAAxbGZA0CzL2zlKn2pAcBu7JmYkbb+BmV2nkcSwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaKrDG5i; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaKrDG5i"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6aca105971eso927473eaf.0
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785356446; cv=none;
        d=google.com; s=arc-20260327;
        b=Egn76k6vWl3Mx0AfZAurub2BM8LNS52Cop1bsSpX08NoXUArV5YYF8vlC4SUu7E6RE
         q+UX4NonxKERQjQxJTsgt6HuoLrHuVuXiNkNlHKW05QsPqNNMB1YkDoJJyOyHNj8Nkuo
         35aj9SOtHZJW5mqyiv4faOUqgDx21vKV9e2go79dslznW6UjsbB9IDe5v4BseyK35dpv
         Rk+KAVq5VUiPO7uTj7uw0kS/5wbDsCWB1zRMbIvkb6fI8OzPvpXmeR3rc3PH0fkA24wo
         qEVoY1GU1h7OwrMrhOJaDEImdeyVVo+PG9YjxmvtwDzX0e6Odtmyc93JGfc6zVbhcX4p
         ja4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MpYuThHdqP3g6U25qambCYPLQtD/X+//jyciXrf8Ar4=;
        fh=GnlzdOva2/24iZruv/FPyM+Hu4ivhszAUEBd6LhuMlw=;
        b=C6x10IzVBQVo+Vee9qgCPOmqsaWt5O9tlKzJohyrPCngvja995BbHNAS5DAkKIKZYC
         NK37Po9kNCaOfOGLtNNyhYR8ZT2H/dzIIDHn9MwJtbJJdnxfs7C9+hNrvPdbKMo+UIq9
         ZFJfatKnbkqDtUvHfNL0eqQEDcFtzdd2s9OQIL/cCWxgq5rj2YuoVnxuIGe+3frpWOp0
         pScFGhynPCE7ojdtzmwDUNac30yxacVFSSYw2CdFffCgqWtE0/cxiSUXsohOVrnr852Q
         5V/dJJ+BjjHq0iBEjcjGI4mkTSPqMBHAwMyRD6o09F8ngYPRz2IYg3BSYpPMmX7m+WWw
         1oyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785356446; x=1785961246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MpYuThHdqP3g6U25qambCYPLQtD/X+//jyciXrf8Ar4=;
        b=LaKrDG5izR7qXg/AubgQNw60XC0wA3aQ63jdglXpf9EKxzZ9I9QYRndE5GAWR2+O3i
         cPXRqCesYLJ/X8aCa71ML3cHuofHKGySVX8B4UiWF5a5CdmQ2C+t7ock8vSzVwPAAT8m
         UaeCylohSKXkGZWPHnuepWScl7gWEnYJi3RH0B99qMgEDrAIUlZXc+Acj56c9ZqPCbmw
         DcBCa1XmLQFQOejace3iD4IQoHfab+Wv3TS3LXxWn+lCTJQcq7txQg4nd1sYr3FtUjd5
         XEfVqEgUOAs5tbRueq5n6gEFOY9VYVbK2b22uxCkimyAesrBSk2GAgWVOPzQE9nolPvC
         U7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356446; x=1785961246;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpYuThHdqP3g6U25qambCYPLQtD/X+//jyciXrf8Ar4=;
        b=ISRhWAXfRgVpGXnUrBqo/ArSgNkCTidIquBACOAoUfXWZQ5Clh0e2sx5sDm1nFX/eS
         NuwvnDH5RVQUT4BF6nH+sKJIjxLKng8CpSg+YrVvuVD6wlilbZ571RxXMJAH9FvhJBRE
         2PB39o62XAg6dMNqLpsCqbd3/HPoip9kg/t1UvdVIw+UB2iguRG5TGMa2tjCSXyi2VLh
         o4ilDsjZJNzkfrMQvb/lfBK2mYOwZVB7crWMNSkEJcuyRisF9quJn9xeX5u8vJlarFtn
         MFOEy8fhf8L5mUxKSYSoMW9vJSyBEW90XzQmdlOL1Y61jNzZQSWk701WYcNWctPpFPGx
         S8Cg==
X-Gm-Message-State: AOJu0YxrFNMapM2OY4Iu5M9SxQbtJCKhFufP1JHl4XcCyfecj3BaR0IC
	14iekyCL0Ph+cfq4+z6WoWz4sC7fFfZ64v5WoHQOkPv0EqUxRHZDQDC41uYj0dvfvpNLAvbDcWh
	kbPCuVb9KtfeCejSE9xTHK/466JpmzEw=
X-Gm-Gg: AR+sD11y2ztCuxkFJ4adn9J1O0rnacqTAUzhqKxI2Ru/tcC2qFjWeIfVnth096Z+634
	XBM1E6ctNGw9Al02tXysFeB++M2pBXD977hoj8WdFwTMpPWsHPyfPxrlLXQyhWz50sn9UoNzw5J
	nLEWpk2Zc/HGLRNIgs05rKe+kDETkeU69GhZTBJ39eh1PypSBsO+u+frvwrBWbB5gtvl/xFQFh/
	7inx6Og5aEzNK7K/wkc5ny7S1CERXhUYZ48uiuvJ44QBOVTEnbH/EqIdQ++luAR123HG91LZeBR
	MtwvXeY3YnwJhgT0NShO2vhHOb2M8Lgdta3Fbf+seNt9b2XbYYWm2fk=
X-Received: by 2002:a05:6820:16a7:b0:6a3:81a2:746b with SMTP id
 006d021491bc7-6acbb584a3bmr34727eaf.21.1785356446543; Wed, 29 Jul 2026
 13:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728091632.1673214-1-jsegitz@suse.de> <CAEjxPJ5rX1t+rj7fWb6QfkZSH=VneZ503gYWvTzp9ZhVYYUpaA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5rX1t+rj7fWb6QfkZSH=VneZ503gYWvTzp9ZhVYYUpaA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 16:20:35 -0400
X-Gm-Features: AUfX_myRqweUoyAq19icZ25-2OIecaOcvqdVuZqsFn4wTdWPrEx4d7_4lzTodNY
Message-ID: <CAEjxPJ5+v8=WxxhstnQ+DZLcCUpzz-MgWPjKj8mY2RUrO_VSuA@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: Using vendor defined directories for
 configuration files
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org, Stefan Schubert <schubi@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:06=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jul 28, 2026 at 5:27=E2=80=AFAM Johannes Segitz <jsegitz@suse.de>=
 wrote:
> >
> > Besides user/admin defined configuration files. Useful for systems
> > that have config files in /usr/etc
> >
> > Signed-off-by: Stefan Schubert <schubi@suse.de>
>
> Will reformat on merge.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
> > ---
> >  policycoreutils/sestatus/Makefile        |  8 +++
> >  policycoreutils/sestatus/sestatus.c      | 78 +++++++++++++++++++++++-
> >  policycoreutils/sestatus/sestatus.conf.5 |  2 +-
> >  3 files changed, 84 insertions(+), 4 deletions(-)
> >
> > diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestat=
us/Makefile
> > index 70f46956..6f8db774 100644
> > --- a/policycoreutils/sestatus/Makefile
> > +++ b/policycoreutils/sestatus/Makefile
> > @@ -5,6 +5,7 @@ BINDIR ?=3D $(PREFIX)/bin
> >  SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR =3D $(PREFIX)/share/man
> >  ETCDIR ?=3D /etc
> > +LIBECONFH ?=3D $(shell test -f /usr/include/libeconf.h && echo y)
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> >  override CFLAGS +=3D -I../../libselinux/include -D_FILE_OFFSET_BITS=3D=
64
> > @@ -14,6 +15,13 @@ override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
> >  all: sestatus
> >
> >  sestatus: sestatus.o
> > +ifdef VENDORDIR
> > +ifneq ($(LIBECONFH), y)
> > +       (echo "VENDORDIR defined but libeconf not available."; exit 1)
> > +endif
> > +override CFLAGS +=3D -DVENDORDIR=3D'"${VENDORDIR}"'
> > +override LDLIBS +=3D -leconf
> > +endif
> >
> >  install: all
> >         [ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)=
/man8
> > diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sest=
atus/sestatus.c
> > index a719f0b3..528a81ae 100644
> > --- a/policycoreutils/sestatus/sestatus.c
> > +++ b/policycoreutils/sestatus/sestatus.c
> > @@ -21,11 +21,16 @@
> >
> >  #define PROC_BASE "/proc"
> >  #define MAX_CHECK 50
> > -#define CONF "/etc/sestatus.conf"
> > +#define CONFDIR "/etc"
> > +#define CONFNAME "sestatus"
> > +#define CONFPOST "conf"
> > +#define CONF CONFDIR "/" CONFNAME "." CONFPOST
> >
> >  /* conf file sections */
> > -#define PROCS "[process]"
> > -#define FILES "[files]"
> > +#define SECTIONPROCS "process"
> > +#define SECTIONFILES "files"
> > +#define PROCS "[" SECTIONPROCS "]"
> > +#define FILES "[" SECTIONFILES "]"
> >
> >  /* buffer size for cmp_cmdline */
> >  #define BUFSIZE 255
> > @@ -91,8 +96,75 @@ static int pidof(const char *command)
> >         return ret;
> >  }
> >
> > +#ifdef VENDORDIR
> > +#include <libeconf.h>
> > +
> > +static void load_checks_with_vendor_settings(char *pc[], int *npc, cha=
r *fc[], int *nfc)
> > +{
> > +       econf_file *key_file =3D NULL;
> > +       econf_err error;
> > +       char **keys;
> > +       size_t key_number;
> > +
> > +       error =3D econf_readDirs (&key_file,
> > +                               VENDORDIR,
> > +                               CONFDIR,
> > +                               CONFNAME,
> > +                               CONFPOST,
> > +                               "", "#");
> > +       if (error !=3D ECONF_SUCCESS) {
> > +               printf("\nCannot read settings %s.%s: %s\n",
> > +                      CONFNAME,
> > +                      CONFPOST,
> > +                      econf_errString( error ));
> > +               return;
> > +       }
> > +
> > +       error =3D econf_getKeys(key_file, SECTIONPROCS, &key_number, &k=
eys);
> > +       if (error !=3D ECONF_SUCCESS) {
> > +               printf("\nCannot read group %s: %s\n",
> > +                      SECTIONPROCS,
> > +                      econf_errString( error ));
> > +       } else {
> > +               for (size_t i =3D 0; i < key_number; i++) {
> > +                       if (*npc >=3D MAX_CHECK)
> > +                               break;
> > +                       pc[*npc] =3D strdup(keys[i]);
> > +                       if (!pc[*npc])
> > +                               break;
> > +                       (*npc)++;
> > +               }
> > +               econf_free (keys);
> > +       }
> > +
> > +       error =3D econf_getKeys(key_file, SECTIONFILES, &key_number, &k=
eys);
> > +       if (error !=3D ECONF_SUCCESS) {
> > +               printf("\nCannot read group %s: %s\n",
> > +                      SECTIONFILES,
> > +                      econf_errString( error ));
> > +       } else {
> > +               for (size_t i =3D 0; i < key_number; i++) {
> > +                       if (*nfc >=3D MAX_CHECK)
> > +                               break;
> > +                       fc[*nfc] =3D strdup(keys[i]);
> > +                       if (!fc[*nfc])
> > +                               break;
> > +                       (*nfc)++;
> > +               }
> > +               econf_free (keys);
> > +       }
> > +
> > +       econf_free (key_file);
> > +       return;
> > +}
> > +#endif
> > +
> >  static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
> >  {
> > +#ifdef VENDORDIR
> > +       load_checks_with_vendor_settings(pc, npc, fc, nfc);
> > +       return;
> > +#endif
> >         FILE *fp =3D fopen(CONF, "r");
> >         char buf[255], *bufp;
> >         int buf_len, section =3D -1;
> > diff --git a/policycoreutils/sestatus/sestatus.conf.5 b/policycoreutils=
/sestatus/sestatus.conf.5
> > index acfedf6f..01f8051d 100644
> > --- a/policycoreutils/sestatus/sestatus.conf.5
> > +++ b/policycoreutils/sestatus/sestatus.conf.5
> > @@ -8,7 +8,7 @@ The \fIsestatus.conf\fR file is used by the \fBsestatus=
\fR(8) command with the \
> >  .sp
> >  The fully qualified path name of the configuration file is:
> >  .RS
> > -\fI/etc/sestatus.conf\fR
> > +\fI/etc/sestatus.conf\fR or \fI<vendordir>/sestatus.conf\fR if it is n=
ot available
> >  .RE
> >  .RE
> >  .sp
> > --
> > 2.55.0
> >
> >
