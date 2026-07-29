Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434274A2E3C
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334012; cv=pass; b=NrAOmpQ2x+rFhb5XgFvwA2+KkUARGxdnPDeMjrXkQmp1MSDGtD6mAluNAD42rroZ5NuTgTxrU79tTmuVlKe4th8jWmc9hPBOgcuwUbPGwrEpj6jdwNC8YbhyOTyLgK15M8GpaH0WIkgvKFixVNuzbCgx5mmJkq93+mbsRVsbd5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334012; c=relaxed/simple;
	bh=bgsFqsGWrusKEZCxfJuUIt+oHthxJiiAsR9E6YJOtXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHIz4fbziyHT4JKJKZp6NpbabH/7weMcWrI/PSxgTxSRnCeizCAtaSuSkzgKatd8C9/at1tNCko2TcBjV7axYnfPF1Lkp9eS3HhOHGNjKqe86o2W5QpaKvde7hGS/kaZowvPiRrsYabVFw+gVxQiJEpfQdyMShvDscLI1jwyWWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pT899k+P; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pT899k+P"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-451d8064238so636198fac.3
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 07:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334009; cv=none;
        d=google.com; s=arc-20260327;
        b=h65iffT+Q4ZJH/KeEJGDEj9hyA/O0q4xnmzycVvOliOc64037e24+FkWmHK6QYsrWA
         XUxJYo4F3Dj+rHeLKbp/x2+KOOSSlrby8Q0y7cVmyJp4R1BwhVRklK22e/TSNFF1zDf5
         KlNCDcT5eJVG7UknysFVOQt5X9EnIJW/wXh6k/TjtFXO5eNTX1AIDmvWAhZHqP6lRqGe
         1wpjjLq/y1BVcM6lq1lomH4rGnxRZaFdVLemuWmb6KwT4s0Qum2mx2L7byf66ZXUGyfo
         gEwjj9d3rD0kZGwxNFsxP2Nk6tYja63FcCnFpFYpiR5gbbMvPlBf6vWH3Ez47G9XHh7b
         HUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=73w+MLIP+hzMUYS1yBPpYSymH/mn4K0AO12XLYrrSTw=;
        fh=GnlzdOva2/24iZruv/FPyM+Hu4ivhszAUEBd6LhuMlw=;
        b=OyhOok+6SXbhLexazfHTUR47DZARNVozLjH7Sqw9ikYGTwgXfAKVknoRzfiAozSjG2
         gZApkMVA5BChYoUi8Js2FjPLJH2Z8ddhIy8ahJL6Wj4SFww5cvtutMSG6QTbKj4+J2Gy
         XvytTiumC9+/6MzuIhM2i2oBVzvc2PpVm1mfTG+eOl46H253i8rSbdSUpFro+ETxLazq
         AxtEGlTEvef7wKkgn+ncFj+liXN4CRCRqHaln0ks1y17g7FA95iDKEWsFWu9u1CetOut
         3VXFbk1joB/Jqf9Gi1smCf7lmiXzu5t2G481mw9fuAK1/ccEDje9fddExANWhiorvyrc
         UsRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785334009; x=1785938809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=73w+MLIP+hzMUYS1yBPpYSymH/mn4K0AO12XLYrrSTw=;
        b=pT899k+PzWf7+R+ucNtmHspvmHp9UyzULc9elYDBO3d/uqjyNBGWz1ECNTZ6W7pviJ
         I37uuNHrCFG8lgAaQGM6Pyg/6zWUvQUy6IP2+bCBOiE2uYahQSKzmaUS8t9ipjgcJj7N
         pY7WIQppD+M9tNvosk0o08co+eyfjI7Sfq5dn6dqJHepDsFNjsc0UaxG2kZ07Jp1I2Hy
         iH4+cp1bF/T339AS8fgpQW33GCGfUGI/LCzvPZonh38BKPbiU9D7UR/YIj0SYJzv5nwZ
         cSkr2dbYXVVhtUhTA5WZPohcu0oaRi3YzihXLEhqQjTS388PQYiHrTPvsdffP0tWlCNe
         DIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334009; x=1785938809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=73w+MLIP+hzMUYS1yBPpYSymH/mn4K0AO12XLYrrSTw=;
        b=TnZhn+2KfH8Ab36vbePhEmTOJD9M6zW/8LvzPSb+FNXCA5jSj6ICw3y6AYCjEvHICY
         KBIeMqtQK0bxGdC1qDeRBnG5b0Bvm0H8tu5X8Gy9Q0jRlBPSz83bfifBwEQL29uzftpX
         eRrv03Z3Of9QFAkb3Pq3YT5A6chSFgCzfq6sd3aw6rxTre7Ob/VUZTUh/XLWnGOJVaRg
         99sKwnFV+mrSWFpd0uRkEQqZi/bJnCBiDNCyZ0PCKyYubigxb/WFz51V4/xnxUYBXi1Y
         dXDO+xlBB+cO4t7AJhfTw4CgDwDSKQfwkoGzU5NgKyTxTWFWz78genskMpENOhLxFi55
         qpfg==
X-Gm-Message-State: AOJu0YxE5XnTB2LCZAaT3q3B1F3ZVo9GDTbatpUOwJyMDvUzW8sDyoWE
	zdo07fpykL03WcLwLyGjV6vZtLlrqjNA4+N5vscSwb0d5DSNVZWBhy63WsJwgPxe9a//QQKH2Ps
	1tqL7axqHxtw2o4f6Ek02XD3+PZxKNWfLpLGL
X-Gm-Gg: AR+sD11MtKJRNP/spRDRpcUEYmq7UBosvKl3dsYfRN+RvpPaex1BgDVy1mbIlvGH/go
	NDa50tl6KZGW/yd7pbyfBLuw17wFNabK+xw0vijlrykG6HJNWSeSczjXuO6yvU0MGmku4kg7DM6
	uqx3kTELIPxPSPx8vKZQ1MtohejCqzrcD1w6aGcRYsPteSWiJb4NPADGoIYB1HIQ3BG4ZlSo6am
	1Djm2YpFOrjr5kg2WIMKje4RBwCKUI49dLAekju/59oMKNurT+IHknx/NnFUP3ehkYGdZvYSZoF
	8wH3pak8/vq50augSJSYWu+q9QdYgWS5GxwpxIJTWO+x
X-Received: by 2002:a05:6870:16c7:b0:456:47ed:4321 with SMTP id
 586e51a60fabf-4586cae06eemr3668281fac.26.1785334008622; Wed, 29 Jul 2026
 07:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728091632.1673214-1-jsegitz@suse.de>
In-Reply-To: <20260728091632.1673214-1-jsegitz@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 10:06:36 -0400
X-Gm-Features: AUfX_myyqa9t-HWUEpx2PpHFKHx1XQ0a-E_HG1Fr3Wv__Oj1qoZ0uJBAA2uhTDA
Message-ID: <CAEjxPJ5rX1t+rj7fWb6QfkZSH=VneZ503gYWvTzp9ZhVYYUpaA@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: Using vendor defined directories for
 configuration files
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org, Stefan Schubert <schubi@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 5:27=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> w=
rote:
>
> Besides user/admin defined configuration files. Useful for systems
> that have config files in /usr/etc
>
> Signed-off-by: Stefan Schubert <schubi@suse.de>

Will reformat on merge.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/sestatus/Makefile        |  8 +++
>  policycoreutils/sestatus/sestatus.c      | 78 +++++++++++++++++++++++-
>  policycoreutils/sestatus/sestatus.conf.5 |  2 +-
>  3 files changed, 84 insertions(+), 4 deletions(-)
>
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus=
/Makefile
> index 70f46956..6f8db774 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -5,6 +5,7 @@ BINDIR ?=3D $(PREFIX)/bin
>  SBINDIR ?=3D $(PREFIX)/sbin
>  MANDIR =3D $(PREFIX)/share/man
>  ETCDIR ?=3D /etc
> +LIBECONFH ?=3D $(shell test -f /usr/include/libeconf.h && echo y)
>
>  CFLAGS ?=3D -Werror -Wall -W
>  override CFLAGS +=3D -I../../libselinux/include -D_FILE_OFFSET_BITS=3D64
> @@ -14,6 +15,13 @@ override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
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
> index a719f0b3..528a81ae 100644
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
> @@ -91,8 +96,75 @@ static int pidof(const char *command)
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
>
>
