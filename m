Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76B23909F
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250840; cv=pass; b=W8x0oKGkgHjwGVSMWv63eJxfPuPuvzTT4XQE13dwx69YqySQYVW5AVVbkz/RF4QZ5ft4zK2iQ9iUyMM5UADwmR33bzVgCQGcz1k3KG6Ftbl60NL14gIUIXjSbEuk+NI1KftafbBHL6gvf+mn2PCc3x9hOqDyYykZ8uRXKBsxvo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250840; c=relaxed/simple;
	bh=EnMoLe1oI42zQ5BJeXyrmt1vNVV8AQSXMqMQqTMAnR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JelxKZFvIiMv+IO6hsZ+ICEJ+tH7cifrQtKwL3chSCniGB4POCH/wlERn04UGzv9HeNJQTnbRcwOAk1fASKcfrpZBieQxjFHpcHSYXcLhM8C0IxxrpR9xq7zFXzQmdJJ0C68ZExXL5HYabLIXrcyMD1iZXx8Ek6Izg9BA1Kkkv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6Et6CZn; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6Et6CZn"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ebd88be784so2912022a34.2
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 08:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785250837; cv=none;
        d=google.com; s=arc-20260327;
        b=p07W+R84DP7YheG766kKXOKvVBr4BfuqI+k+xBPfdF/usAyDZnxXRZ6b/UpVpmoIfj
         kwT4WKiFK+VH6PObGkDr5u56JSv2CrJBZfdsulpPyb9QrHQpeFualseEIOsYAr188hXu
         k1s8f4Vt0G362vWswlx26qUAYETUi9ZySO1rwX+PgqcOwAf7WaBJ8wpNkh6rYuDyJCgl
         agCiULdZPWOj8PoOBjz1mDzAqlpEjFQwwY9Qfmmm+PxrkIugV0oIpQ/Jh/cXixoJ5XV6
         U2LvKFUMKHxgV0t/lU1xFHHsaxuUyV+Mtxa4D05z4Xp1bPvdwuD/bfL8VHWxDzYqDLqR
         SOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nkUZ199c8AjTcQQ90zCEeZS0kuC9yrgTPmOB0YBWM/M=;
        fh=GnlzdOva2/24iZruv/FPyM+Hu4ivhszAUEBd6LhuMlw=;
        b=M/zgdOYLt0LTOJvfRcaCJ+ZDDiss1nBnplA3mJTZVQXaq4byKI+ZW0azSg3qmOweVX
         GqW1mCev9mw2uwKkGn1iBlaLqtNGiOVUk4TYE2Wdx4XjGxstYTvf2IR+szLlZ7XzRmIM
         FZIJQ1SXovstLjPaPJ6lP2r2oI/GUx0C0pNNbTk6nm0movFPuDhwv6k6nHBmG7lx6aqW
         FcCjf3TWzIOpzY3cfRfvhSI3htC67EZbPNVEDaWCT2xK1+vms7ZNdeZzXmNQ+V66FSa0
         0VPgqVvIZg0hRUmDYeJKpB+IJ0Aa5YxmPpb1sEio2K6B2AiwIoFn7rubJRcqRiLExc0b
         on4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785250837; x=1785855637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkUZ199c8AjTcQQ90zCEeZS0kuC9yrgTPmOB0YBWM/M=;
        b=q6Et6CZnuuUI/eWlNTlrQiewIT0OJAMZkMODM8++UrnrAr88l90BnP1TM2Kf9joX1S
         eIQfa1dpbif6pZdz0aE7zVkxPNZxdmeIR7/HWAhhZUS2FI9+o9h8qtUNMIbt9u14HYcw
         C/8BeVX2eL8UeyBHIBH48bWBuRVzrBJ/GPiiSoTGCGoAZmI5hfLpNJ4WnJo6McWls7YR
         GbayD614bRVWDIufsDc/UQ+eaVSYflCrPductufTcZyzXPKaOvU88ecpgnQUvJdKRlcE
         VAHfhY8uhcPKshReoPK/AqskX2gC1fij8v/7IC1YeYZTsDfCTBWR77Q5D10ViPKZBzH1
         FM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785250837; x=1785855637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkUZ199c8AjTcQQ90zCEeZS0kuC9yrgTPmOB0YBWM/M=;
        b=Qt8cfZsdqZk4CU9TLgA8GHonk6FCQ3+MMf1I5nRyYnf2KFKahUQltJi0TvXOm3LRui
         zMgHbxqQXXJZeEGZOpXqhC9mhYgWbSCAcpv8rg3Eg6s/fyDOPewe2wBK9aL9P8VZiYTi
         XoO5AG0vBiVtiaRsSoL2T9JWf4gEsbFYJRjQwHZNER/4H0HA2yvpO5CQhhUKu6rU5m7J
         UA4AklSpQtiRCzpZL89oHb2k3SRLN8mu06t2SuNqYmVgjK8ExyRgIXiIGLT4xmIUzHy3
         8seiOrVH8WMoNAuDwUcSFDs8SSFiTnSV9jOhzPapH2q/Nq0oYJsCT6XdVyWiQUoN/+vM
         VAXA==
X-Gm-Message-State: AOJu0Yz0csp9i9onS6ykFDQVG7jR1tpTrjPUiXFOu1jdvJexGdzpOWhf
	sE7CaSPM+DbpfNiakHNxJvlI+0Ibg+LuZ5UUHINB9enLHA0OELlRawvaAswgLmRPI48381sme4X
	aO8H7FLmboZuibN6lqqeoQPea17jk6DOV2g==
X-Gm-Gg: AR+sD11dz8Nh85/Zs8EoNiWSuuG8Ult1/4FKfQpjHHbjo/F3IaPFpHpsJLyS9/e2AGv
	UqiBx3VbPhHQpdjPmGjnjYNVEvkyuRwwDKSCigxCyWZPbTMVSdIgJqo1cCAwgR3lM80tkHPh5E+
	KSUHCsdQ56zP9FtaFDO7v7S9d9dp6pzHBCWLAVjT/OrxhJCjeBVRnS7xfxB7HyNEDhwM/6y1rok
	h/Wc2o3UklXAaVxYxgVo+XkmITDfHess1p7Qhrk3lmRRUR8lhAdjRVf2etf29oj25fkKwTt
X-Received: by 2002:a05:6820:1621:b0:69d:fcab:c640 with SMTP id
 006d021491bc7-6ac96c6efc5mr1357749eaf.42.1785250836861; Tue, 28 Jul 2026
 08:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728091632.1673214-1-jsegitz@suse.de>
In-Reply-To: <20260728091632.1673214-1-jsegitz@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jul 2026 11:00:25 -0400
X-Gm-Features: AUfX_myrADaTesfGX9YHYEzH_zWrQ9SJsXIByaE_MniLbcbvbA0yKhIApXmbvAA
Message-ID: <CAEjxPJ79h83DFRnHUPrOqSVop6X46yEhYCQKEUyVGnaOaJ7pOw@mail.gmail.com>
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
> ---
>
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

Do you want to print this message even for ECONF_NOKEY?
Previously we ignored missing sections silently.

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

This code doesn't pass make check-format; can fix on merge if desired.

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

This says "or" but econf_readDirs() will merge the two - should say layered=
.

>  .RE
>  .RE
>  .sp
> --
> 2.55.0
>
>
