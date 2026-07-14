Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3402737E0
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038118; cv=pass; b=VHtLExL19Ppai7braTTf8FOwigh4Ygrgefj/s+0UoGO3cdZ6Yt73TFxntV+rHYZy1Bvo/eNDzoDp2sauYDmocXIXXrSE1wdcrsn8Y1JRyJ3zodKNqCF2L5q2eJpg58dZ4M/jIwsMy0nUbXd+nJjh9XL7XSGhfS2e2ac0SzDUMIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038118; c=relaxed/simple;
	bh=8FSlNiBsfh8Ok7eu/WUtCyHm1ikBqPK7sxAjj5XFKhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxN2SDFcQzcKMqN4ejOpPDq2YbbNWyEjesrDXp1uFlXklw+ETZwpFpC08HvA6Ls6U8Y5pRs9GnJzkkkZywxhMPe+Y8VZBrBpFOpjwFXZqY2Y8wmgTNvfs1sPvSIgB2WJgtBwlJrmXdyMATgXRt2oiJD/v6WV+mMWjNUMenrT2L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9LGFSFU; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9LGFSFU"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c9452243cso10940291fa.3
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 07:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784038108; cv=none;
        d=google.com; s=arc-20260327;
        b=NWedio+SMqis7tYI6NQCzTIDz8Jxm2JzBEzFu5Zg8f2SgukGhD3qIHGAk6uuLqAow0
         wPFW/X+PFnfPJ0iyauOS/BJu8iTwyerFjMQ+UefvhSGphlzDaJS8hwSI0C1zw9VATxLb
         nP8esDO00+DjTdpWibjO4XG1UXjJEGUv0okik5Lz/jnOv1Ga06MjHV5RiuFa7zQ+lvfL
         PK1QklquQgF7i1ZHn6egCvW0CcvrKBqFGbbqWUTsMZUGjsWAZI4vY9PuX/+9dMVOkGsF
         S715X5YAHH5kmqH9P5+HFh7mHqswwMmEtLnftcXpIdzAmfWJ5Smt+2F+pzF199XJ86BA
         DbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F5uknDpZJ484TLQL++quhFzAOSD/iz5G1Vt73GCgnX0=;
        fh=iWU6EMthgWNLSYoyCnZUFfTmFYJzGz6VSgGmuJwkex4=;
        b=MX09MrL0qmxFPryF27VVctOxQvGbOMACrhp/L+PRNmy7tE5W7e+SFIGURmXr26Y8p4
         MtuhzT0d5gPq4Jl4mvl3BXkzNWgACizy+aGWgWfc2qq+knSVFhCjsPdu9y9fh9NjkETh
         3oL9V1LwnNb5+IvZhcPWqg2vSe45sjJn72H+uAfBxJ/fLQ1gqvfaCaLGhXOJarvmSNK5
         wWjT43+ev2aFM3cLXB4CngVGLnl5yH4ZvBsJO0O2yz30nxqepFwjWO3lwhGWdl6aHVeK
         HL5o84uWo26rztkoHRuuESLn9/HE6D9rt8RmLzS5Zn3+5LtnsAYU7F7Zwjehg3wkCgK4
         Tpdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784038108; x=1784642908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F5uknDpZJ484TLQL++quhFzAOSD/iz5G1Vt73GCgnX0=;
        b=L9LGFSFUaKv9njN7rUo1CUEOwCTPFV7Xg13glI+yzmOA2OuaqlP60s5deGtPcLZKkq
         tTnrROSuUnLxyPyELWCduh1gtkb3YxHa8oVjPh4Ov1J9t807NUtUFBbIYFq/cX0QRRmy
         VI7YlKxWD1GSNbPI9KCibGng1RNXbhxVCaORYa8wzOaudFtty5l/VdMbyED1M+3FfcPe
         4uFN7uA8gv7RfcghVE2NSd2P/UD0ChBy1XQ8WLBQfB9SS2jo7soXro82pNoOaGeDltA7
         97SXpgCREOM1utZDLq1aO9//WjMmAhhZFz5ixvgcBE2EQRLgyrzJY0NVVmtx4chn9Y/0
         eJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784038108; x=1784642908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F5uknDpZJ484TLQL++quhFzAOSD/iz5G1Vt73GCgnX0=;
        b=YKu9UC8/IHvps9OIMxoFnhubR64BHDEG1nCYyfOJq6VmqiseKEwZPVTH0IXWdRrqP3
         a99Ei6f2kn5DLwyB3olU6zYLeFVo95TSmjz7Zs7JMx+WFurtVnmquGtAqnN8TQzWLxrG
         Sl638OsFNavuCeD6lJQYGUrJmv6DmSqQzuTrZ3ygFY6L1E519dJerObtuD6gF2qjrHvy
         L9NLSEKr5lrjMt/exGW82QE584ASjYnSEy+rrBrSp4HKEPjDW5PqRqul7Wbpp789rjap
         O8hLt0U8nvR/kUHLNqyuYm/5xE7/uDB3tIOzy8Ci4a+NuhcWRPtgQ/IE0hiqgCp1ckx8
         Koaw==
X-Gm-Message-State: AOJu0Yx5acriPEcg3Ko511zht+eXGNvgz0altKRHpojJ/kZhP4TUsely
	mek9BZBD21c9GL0EgalU4mAwo0tar0C0Gyxe+Db3+Hie45ehyfzmnib4QQGs99to+xuuAlwlGvi
	kH2c4RNAu6VFW1U+CkmpNltg+4N8Uo59syqFw
X-Gm-Gg: AfdE7cn6qannF7V73GdkMPYtTWS84+qqOGN7EHJujYqc6enKLh1TLWhVQi5qsMtqOaf
	KL6SQtRDJPRi9zbebcz0Iqc2PeYHR/kGblYBgYlo4vSsbZlwqLVIlmazDIKQBgbk9/Xv5wpESey
	Nho6ZLS1GXvpba6n+SdtH2+VxPz99Xa7ze8M7a81rysZaadrzdyIcBiW59jLnbfVzWe8zZzF9Xe
	M9xymWS3UHkmjorAyRZN3Qmfo8UkD1CTQGgAYQScIojLPr98OBEoktxY6GxNbb6QHbKVcnV1vg0
	/3YR
X-Received: by 2002:a05:651c:23c3:20b0:39c:7089:8052 with SMTP id
 38308e7fff4ca-39caa8af77emr21177101fa.19.1784038107919; Tue, 14 Jul 2026
 07:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151726.14523-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260707151726.14523-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 14 Jul 2026 10:08:15 -0400
X-Gm-Features: AUfX_mxWgIOaLYW0KIwD-HbavCQY3JBzofMSrp8UQyW64qUBVvPDKaWd4q8f3uc
Message-ID: <CAP+JOzRMxPEL7wHPoRY4tBziYq7fQinAcC--FW31wZi=aKOMpQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: drop legacy probing of /selinux and /proc
 nodes for selinuxfs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:17=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Originally selinuxfs was mounted on /selinux before the kernel was
> change starting in Linux v3.0 to create a mount point directory for it
> at /sys/fs/selinux, and libselinux had logic to check
> /proc/filesystems and /proc/mounts for selinuxfs to dynamically detect
> whether SELinux was enabled and where selinuxfs was mounted if it
> didn't find selinuxfs in the expected locations. This results in
> wasted effort on any modern Linux kernel where selinuxfs is always
> mounted on /sys/fs/selinux, particularly in the SELinux-disabled case.
>
> NB This makes Linux v3.0 the minimum supported kernel version for the
> SELinux userspace going forward.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/468
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  README.md                    |  4 ++++
>  libselinux/src/init.c        | 43 ------------------------------------
>  libselinux/src/load_policy.c |  6 -----
>  libselinux/src/policy.h      |  3 +--
>  4 files changed, 5 insertions(+), 51 deletions(-)
>
> diff --git a/README.md b/README.md
> index ea8c4e46..08e82d0c 100644
> --- a/README.md
> +++ b/README.md
> @@ -22,6 +22,10 @@ Archives of the mailing list are available at https://=
lore.kernel.org/selinux.
>  See the [SELinux Userspace wiki](https://github.com/SELinuxProject/selin=
ux/wiki)
>  for more information.
>
> +Minimum Supported Kernel Version
> +--------------------------------
> +Linux v3.0 (for /sys/fs/selinux mount point directory)
> +
>  Installation
>  ------------
>
> diff --git a/libselinux/src/init.c b/libselinux/src/init.c
> index bd0803dd..1a377a0f 100644
> --- a/libselinux/src/init.c
> +++ b/libselinux/src/init.c
> @@ -81,54 +81,11 @@ int selinuxfs_exists(void)
>
>  static void init_selinuxmnt(void)
>  {
> -       char *buf =3D NULL, *p;
> -       FILE *fp =3D NULL;
> -       size_t len;
> -       ssize_t num;
> -
>         if (selinux_mnt)
>                 return;
>
>         if (verify_selinuxmnt(SELINUXMNT) =3D=3D 0)
>                 return;
> -
> -       if (verify_selinuxmnt(OLDSELINUXMNT) =3D=3D 0)
> -               return;
> -
> -       /* Drop back to detecting it the long way. */
> -       if (!selinuxfs_exists())
> -               goto out;
> -
> -       /* At this point, the usual spot doesn't have an selinuxfs so
> -        * we look around for it */
> -       fp =3D fopen("/proc/mounts", "re");
> -       if (!fp)
> -               goto out;
> -
> -       __fsetlocking(fp, FSETLOCKING_BYCALLER);
> -       while ((num =3D getline(&buf, &len, fp)) !=3D -1) {
> -               char *tmp;
> -               p =3D strchr(buf, ' ');
> -               if (!p)
> -                       goto out;
> -               p++;
> -               tmp =3D strchr(p, ' ');
> -               if (!tmp)
> -                       goto out;
> -               if (!strncmp(tmp + 1, SELINUXFS " ", strlen(SELINUXFS) + =
1)) {
> -                       *tmp =3D '\0';
> -                       break;
> -               }
> -       }
> -
> -       /* If we found something, dup it */
> -       if (num > 0)
> -               verify_selinuxmnt(p);
> -
> -out:
> -       free(buf);
> -       if (fp)
> -               fclose(fp);
>  }
>
>  void fini_selinuxmnt(void)
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index 4337cedc..a6ec4a59 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -307,12 +307,6 @@ int selinux_init_load_policy(int *enforce)
>                   NULL) =3D=3D 0 ||
>             errno =3D=3D EBUSY) {
>                 mntpoint =3D SELINUXMNT;
> -       } else {
> -               /* check old mountpoint */
> -               if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, NULL) =
=3D=3D 0 ||
> -                   errno =3D=3D EBUSY) {
> -                       mntpoint =3D OLDSELINUXMNT;
> -               }
>         }
>
>         if (!mntpoint) {
> diff --git a/libselinux/src/policy.h b/libselinux/src/policy.h
> index f6d72423..0ac599a4 100644
> --- a/libselinux/src/policy.h
> +++ b/libselinux/src/policy.h
> @@ -20,9 +20,8 @@
>  /* selinuxfs magic number */
>  #define SELINUX_MAGIC 0xf97cff8c
>
> -/* Preferred selinux mount location */
> +/* selinux mount location */
>  #define SELINUXMNT "/sys/fs/selinux"
> -#define OLDSELINUXMNT "/selinux"
>
>  /* selinuxfs mount point */
>  extern char *selinux_mnt;
> --
> 2.54.0
>
