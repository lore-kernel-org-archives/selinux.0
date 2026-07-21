Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2B38E100
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642111; cv=pass; b=UVDGk/H+sPstXT5pK2aZRaeNO7PIcPZJpsroHsVLd6T+gYuPwUjk7biSx9v5MUF8ryfEAVstLbg+Dzi0bu4jGloDmi/hxIF7BUgQzt1D5K2maQW2997WQEcjtFE+9DLzpSkppF3uEWVJHux/f41jw2J1Rz+yG06XT6c2UJ1jZMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642111; c=relaxed/simple;
	bh=xYWQoIBoyEzqes3YN7kCI/pdGpybAVcPYBSSme8lbNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVMU8zRDg+5qSoG3OQiXToymAlcMc6yCDWxh62qh2BvhGnSohZq8p2JuSpoiCGGQL/KGqRPduSbOhQ12EcZcN+LS5nln7bLTsolRujVQbvJ4y668gp8aW6CLn6JoMRQQHZRbQZUPD2ymET+kMmwqj5xULMZ2hU/uP9MbIr6jGhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptV9QpIY; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptV9QpIY"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38101f85591so4129400a91.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 06:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784642109; cv=none;
        d=google.com; s=arc-20260327;
        b=Okf9Twggv5jwqW/a18nK2muGjDNVO1A0DQ8KwGCWBLWvmLUcxWqtC5qWIajDN1pqES
         1WmIv7Ih3RwYIckGOmLuTHDUqhovToXzqLajPlSpk+EFrW04fB5Lev2Fe0NenrF+8Bnh
         GYcPPr20ElAOn4IvjEGHMjRt5BwQTA9+QFAkjjyoyYQcUJFQQ7zs5frxo5/clHrvL6BT
         rSRdDdehopmWj3s4rSv22WenlGI7nGavbqQhX7BuWJ4TTK0z0Q6fd7yo27jVEdxCo11G
         /07KTc3OTuStUO62S49KvpCn9z3vg4gQK/ZW0R/1kdp2xSuNczfWIiHnKoR4OUiUreq6
         qLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zLtCGMLTJDdNo3UGim8/1XSVq5iNfQiwNtUlhMRJFE8=;
        fh=E51Jjr8Bz9WzQ+Ik80n9UcoRPIh3NakEhV8l9xr/qbM=;
        b=P/7QjNKYTK3QcUkMhLsLgeFRq7QH2EuhGsj6wS4YZ44n6xRTozXtLjKrN+/Qefx6kH
         mfdMPFcgXbfrKEZBKXRp8cSjHzEheJ22uG0YMYOpQtYMAZFUTmS4nJjw0lAj0BXTF70S
         gGiSQdar68Z064dagG0rsiBIb4htGuraXbWNtauiEiE0W7rSvUBG1Q8uP2HmQmEVcaVf
         m1nZtBJJI1QudOXITtXmxn1d618lppNlNijI4oidKdYKGKR5Km+7/qNWN+9xiruXm+J4
         UnitjTHAFFOseLiWpuJGpFgFjitLCa8VRKjmSTd9LQQqUjrzc+oa7FLhp5Q7RShTWYWo
         YRWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784642109; x=1785246909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zLtCGMLTJDdNo3UGim8/1XSVq5iNfQiwNtUlhMRJFE8=;
        b=ptV9QpIYYKvu7Y7te+mmnGHIsAGFPFKjjxNAqJR0LlrGUHk+cSGCYw2ZVzdemqDDW6
         q2La+SVV5hpzOzOP2d3I2ae8U/hVyf842AdujTp09LEZ4ET+8V9wFltihpA9mCRJXL1b
         uhN+Fk4z1Gx+523tEeBMsBhVqlvljrSLJXT3fYpZTPrxn9bO6hAbzblrK8497fHkSNDx
         9uFx4eCCB/dUhuuTPrJfe4D4/whzDrbxssBSh5aDyxeJdXdKqYvRvLwymiiQwlfxk/Jb
         OTYfcQgE6nhgikbTTntxerhTrHR13VUwsQ610kH+aA+KsKIntWLlnCxxqmMKS51EKq+T
         E7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642109; x=1785246909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zLtCGMLTJDdNo3UGim8/1XSVq5iNfQiwNtUlhMRJFE8=;
        b=ImNA0TlCZtYca0Xtkfx78Qr+Ivl19YwhpweQt3eVfPx1+XW6uwxADKCo68/ZaP3JVD
         nAhwvtTXdPYtYJ7veWLgtYAjNYlGsyH7aXfY991wPf21/HM8GZpj+OHDV1BnvpcPl4mv
         ToU93BNDp/tljVP6UhLOZxzN9h4WCbRoDRKRZnka+PY1EMwER8KlYJ6Us4TKK8FgIplL
         I5vJ/VD2xrymaVFm2yyASCIDJm6zCKpVvcOPFMBy5xN6IeImXL0bq+hNqVck6yVWeeS5
         /QhbOCb1iDFz4x46Dohmwj6gpaDo8OZKpi4wiSwfCrFSLGvYFrroiuAmzHw9Bllx+2oa
         htEQ==
X-Gm-Message-State: AOJu0YyymqrxOZ9QiJTJ2YnjNbBVCz9RWWJm76rOQDS3rXzGXXGsOZpD
	XuMiZzZSbnKIMW8Jd7+7U/sf+p5DmbyjwjPm79xy6F7Axaw+4cOtTbalLWc4R6NdqkgASTcAnX1
	EmYx4SfZNXe87AyKoqdsnRrsUg5NAr0GL0A==
X-Gm-Gg: AR+sD119iL2crSn9n9Jo04V6aZuMUWQM0TGcOEKdVpdiboh86XmTxYLezkoKvrcyNAN
	4xr1rNq8bTPnNzgu+Vvl9v4mUPL3Xw8VwZLqsDj80ZXi4/2ZlhguFK38cbum7AOS4jdopuAlF6s
	pZnW1H4OthXAzIvxQ+ZaFtpcG54TGf1OeGw9ycskPyTWPAWPEflt8Hf+qZUdp84tPPa2M09I4iv
	vc0lqhvQuZxfHOLYyV7xLKVdXQSap9EX7l2gxSX0o59fuAvN4EcbcF9ZAQYOg==
X-Received: by 2002:a17:90b:2891:b0:37f:9e21:91d8 with SMTP id
 98e67ed59e1d1-38e4b68268bmr17165322a91.15.1784642108764; Tue, 21 Jul 2026
 06:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <al8hJpiJe7Oj4Pph@suse.com>
In-Reply-To: <al8hJpiJe7Oj4Pph@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 09:54:57 -0400
X-Gm-Features: AUfX_mwMO31_BVMu2n91dgD4FrfOwQgveIh7V79itvHBQP0uANLa1RrcnenCZwA
Message-ID: <CAEjxPJ4EcvA1w0JBFDQaho=_JHADbRT_W1ZsX_Zj17zmzu9btA@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: Using vendor defined directories for
 configuration files
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:41=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> w=
rote:
>
> Besides user/admin defined configuration files. Useful for systems
> that have config files in /usr/etc
>
> Signed-off-by: Stefan Schubert <schubi@suse.de>

This doesn't apply on selinux/main.

> ---
>  policycoreutils/sestatus/Makefile        |  8 +++
>  policycoreutils/sestatus/sestatus.c      | 78 +++++++++++++++++++++++-
>  policycoreutils/sestatus/sestatus.conf.5 |  2 +-
>  3 files changed, 84 insertions(+), 4 deletions(-)
>
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus=
/Makefile
> index 3dbb792b..935fd6dc 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -5,6 +5,7 @@ BINDIR ?=3D $(PREFIX)/bin
>  SBINDIR ?=3D $(PREFIX)/sbin
>  MANDIR =3D $(PREFIX)/share/man
>  ETCDIR ?=3D /etc
> +LIBECONFH ?=3D $(shell test -f /usr/include/libeconf.h && echo y)
>
>  CFLAGS ?=3D -Werror -Wall -W
>  override CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
> @@ -13,6 +14,13 @@ override LDLIBS +=3D -lselinux
>  all: sestatus
>
>  sestatus: sestatus.o
> +ifdef VENDORDIR
> +ifneq ($(LIBECONFH), y)
> +       (echo "VENDORDIR defined but libeconf not available."; exit 1)
> +endif
> +override CFLAGS +=3D -DVENDORDIR=3D'"${VENDORDIR}"'
> +override LDLIBS +=3D -leconf
> +endif
>
>  install: all
>         [ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/m=
an8
> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestat=
us/sestatus.c
> index 6c95828e..a0b9b0f1 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -21,11 +21,16 @@
>
>  #define PROC_BASE "/proc"
>  #define MAX_CHECK 50
> -#define CONF "/etc/sestatus.conf"
> +#define CONFDIR "/etc"
> +#define CONFNAME "sestatus"
> +#define CONFPOST "conf"
> +#define CONF CONFDIR "/" CONFNAME "." CONFPOST
>
>  /* conf file sections */
> -#define PROCS "[process]"
> -#define FILES "[files]"
> +#define SECTIONPROCS "process"
> +#define SECTIONFILES "files"
> +#define PROCS "[" SECTIONPROCS "]"
> +#define FILES "[" SECTIONFILES "]"
>
>  /* buffer size for cmp_cmdline */
>  #define BUFSIZE 255
> @@ -92,9 +97,76 @@ static int pidof(const char *command)
>         return ret;
>  }
>
> +#ifdef VENDORDIR
> +#include <libeconf.h>
> +
> +static void load_checks_with_vendor_settings(char *pc[], int *npc, char =
*fc[], int *nfc)
> +{
> +       econf_file *key_file =3D NULL;
> +       econf_err error;
> +       char **keys;
> +       size_t key_number;
> +
> +       error =3D econf_readDirs (&key_file,
> +                               VENDORDIR,
> +                               CONFDIR,
> +                               CONFNAME,
> +                               CONFPOST,
> +                               "", "#");
> +       if (error !=3D ECONF_SUCCESS) {
> +               printf("\nCannot read settings %s.%s: %s\n",
> +                      CONFNAME,
> +                      CONFPOST,
> +                      econf_errString( error ));
> +               return;
> +       }
> +
> +       error =3D econf_getKeys(key_file, SECTIONPROCS, &key_number, &key=
s);
> +       if (error !=3D ECONF_SUCCESS) {
> +               printf("\nCannot read group %s: %s\n",
> +                      SECTIONPROCS,
> +                      econf_errString( error ));
> +       } else {
> +               for (size_t i =3D 0; i < key_number; i++) {
> +                       if (*npc >=3D MAX_CHECK)
> +                               break;
> +                       pc[*npc] =3D strdup(keys[i]);
> +                       if (!pc[*npc])
> +                               break;
> +                       (*npc)++;
> +               }
> +               econf_free (keys);
> +       }
> +
> +       error =3D econf_getKeys(key_file, SECTIONFILES, &key_number, &key=
s);
> +       if (error !=3D ECONF_SUCCESS) {
> +               printf("\nCannot read group %s: %s\n",
> +                      SECTIONFILES,
> +                      econf_errString( error ));
> +       } else {
> +               for (size_t i =3D 0; i < key_number; i++) {
> +                       if (*nfc >=3D MAX_CHECK)
> +                               break;
> +                       fc[*nfc] =3D strdup(keys[i]);
> +                       if (!fc[*nfc])
> +                               break;
> +                       (*nfc)++;
> +               }
> +               econf_free (keys);
> +       }
> +
> +       econf_free (key_file);
> +       return;
> +}
> +#endif
> +
>  static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
>  {
>
> +#ifdef VENDORDIR
> +       load_checks_with_vendor_settings(pc, npc, fc, nfc);
> +       return;
> +#endif
>         FILE *fp =3D fopen(CONF, "r");
>         char buf[255], *bufp;
>         int buf_len, section =3D -1;
> diff --git a/policycoreutils/sestatus/sestatus.conf.5 b/policycoreutils/s=
estatus/sestatus.conf.5
> index acfedf6f..01f8051d 100644
> --- a/policycoreutils/sestatus/sestatus.conf.5
> +++ b/policycoreutils/sestatus/sestatus.conf.5
> @@ -8,7 +8,7 @@ The \fIsestatus.conf\fR file is used by the \fBsestatus\f=
R(8) command with the \
>  .sp
>  The fully qualified path name of the configuration file is:
>  .RS
> -\fI/etc/sestatus.conf\fR
> +\fI/etc/sestatus.conf\fR or \fI<vendordir>/sestatus.conf\fR if it is not=
 available
>  .RE
>  .RE
>  .sp
> --
> 2.55.0
