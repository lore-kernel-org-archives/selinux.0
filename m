Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D32DB78C
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122535; cv=pass; b=kcr+zu/t+w5zERR5K7XbS32ADxlRmSPJb0K66ILM/XSsCDI8/Ep3hURS3gNIQldZp9f6kA0lyzYZytG7Km3+bDkJyxcUCIaTllYtRxo/e4IPD7LTeAPSxj64Pgumm+THFR6Hfd7AM7hvj5pUOh+exM/9wWRecNSQGEWQ1ISv028=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122535; c=relaxed/simple;
	bh=HXJ6YEjRVdFQAKEz4b52NqfNtfkPxxu/4/EAdQvixLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZkAR0lAEASwH4f7MWT6S8tCDgjct+/qLNrr6keg2cU+/K59xuEJv3YfNXfLebctqG87b9P9VZLl0SZB+5v6UJH2pcwM9zRVDmaILZUKKT04tbL3iigpL7XxpMOd/z6Mp1anT700zEn6yRWcqKaq/KKX11d8OZrD32V4SoqjvdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxmg/n6W; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxmg/n6W"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so50841341fa.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 06:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784122532; cv=none;
        d=google.com; s=arc-20260327;
        b=h8gzfTAmtM7TEoIMSGKxAqJi3aMhBRWLssQF7rkvk9JPpHCTre91Pik23f7Kz74Ke8
         fpE3ZE3DNbTTzjoCcuCKagoLsYSME70slA5J/J7gN0G6JB9gy1UGYfIP75gKXwU/Dpd0
         9OOTJgKYMt/00oJgNGYi/2eBhK4vsxqCzw4bJkpaep72CQ19P7k2cujdvI4ZISXWubOe
         eLQ8YiA0XnKUtN3vtamOwCpuEOPpcgFmrGFAYqSgtsJiNy/Buu052JjEdovbLpeZ18vu
         AdhSN3FUKc6OnSY4zKez5n6/z7zZ7LF3tBE/aJ/Umwjh+ix426ImMdS2nSoc3JN3uLXJ
         7qIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjR4glZgWV2qIdw8Q4jRLqPMMWe5Uw3Ws889hkwUiNk=;
        fh=iWU6EMthgWNLSYoyCnZUFfTmFYJzGz6VSgGmuJwkex4=;
        b=J2VPxdScOkaWCBVsB/T/qjqhZ0UFupDP9I8fd8StBZFmCIQBp8JnFYdo9DQLWcCODE
         1nJ5MbP4cPimwsUiLqqtAPSh8WFgpdVSG83uVRKb6pCs7W/mkegcTHC0fHe7r9ruORKE
         t4SPrasghkjzXd/Einrb0Vt7Hd26y00zu/BZlRwOKtQXpu9OwEGC2rLKD+OOLTPn/H5e
         cXmFMjeiG5r7K+ey+b1ijT6u1IXtoiQtO8GbAaT1roFE7T4CDoxxu+lMmnWtA4599yhL
         7HItMvYo2+VbSwVQ+yKhkEmRTjZW87HE1Mt/sVXSaWCXfv8v4GHuGXwwXVOsfxbllRHy
         hbxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122532; x=1784727332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UjR4glZgWV2qIdw8Q4jRLqPMMWe5Uw3Ws889hkwUiNk=;
        b=Yxmg/n6WvCVaegRJfmIxkbbJ0l//UnGURdwjGs09CshWSa6EAKPQ10RJfXDiTUa8DH
         ZPwOVHviHQDxKTa0Ab876x5SgaVLtPBNRQRxPaPMX7mYIhq2mAqO14Dwdq6LNMIxsLHy
         LyuM4j5f5VECIn4CxVJoy9O7TtE6QO1EUK7WWSygM6yXN5SJGZmFpS6OCtVKfyN6ImNW
         RszYxFK10Wcd8245vmEgHTa6CZ4d5nwm9zW/Kc+Co+e1kxqyWlClqKd1HNWCvaWqLX5F
         mqQ6YEgCzysYvlsyrqDRfSqZpbtMNMrcjSuMr4oKC/fYudY+YCqjcbtl6G/uKvLk9aJv
         9BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122532; x=1784727332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UjR4glZgWV2qIdw8Q4jRLqPMMWe5Uw3Ws889hkwUiNk=;
        b=QUdw82QYpBRtNqWIVFOjXhJuYuSBZEKRcFmgYkKHobijgid3aa8mmLhOSbLNFhNwA/
         CB4ii8l6No0RpJKh2WwBrqpzLhgv/zOCM2SPpffm7xzORjQqeXXL9gS2qJEIF1XWag8M
         UuIULAmW6DJSlHRDVns3E9qoGGU2Zy4Lp6wJkakRcERYiOfG/C7CIpG7ju31rsMA1Hgw
         7zFbfSzJaG+zJ/HcJN+7apT5h2a3pVQF1RUuHzN6tLd35g2IdxfKLLQqrv0z7idLvZwh
         dosnUhUBlbsyQdABITSEUSle1s2e3kpSf4LRcVMPYEXCA3jGjWxZA29Pxq1ffuCpYYKk
         5gfw==
X-Gm-Message-State: AOJu0YxJZnZV2LvpQqY9M0SRhVH0HBGBHB4LquiQQY2nefHLmDRmHJoX
	jkVr1WBpDadzUXuE9yklLToJVmpOWPKENr60X/2lq+U/XLYWqSH3HDGBOb3KVtes199siztg4Uh
	4XHxM3opuZJzceJueR7t+yWeOs7SRy+o=
X-Gm-Gg: AfdE7ck6O7ydQpbfFMXZ8cITibxP4IYc4XIIuZ8lT+6nmYr64D4Fn2L/yas+/LyD8l+
	p05wA6yvjPs8mRn5ilKybVvuKnfb39xjNS6ev0jxug2txiTkwosoq9k6BkBDRSAXtR7iIxjfiFe
	+IMiOJkooQMMz3L1+DET7nVedfmAcNr0gRjtfQqnP9ATgs+pbXCvAFA7qFWikyFcdD/7rFUPjSq
	kHEkeAp4NSrFGKSpYMXRsZ5INdpelxwF4q9t0aEgq3ap3bbfpOHks3QpCBm0Wa1m7yd7o3ojxV4
	A1Ze
X-Received: by 2002:a05:651c:241:b0:39b:da8:cc3d with SMTP id
 38308e7fff4ca-39dadcad7eemr13470421fa.22.1784122531413; Wed, 15 Jul 2026
 06:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151726.14523-1-stephen.smalley.work@gmail.com> <CAP+JOzRMxPEL7wHPoRY4tBziYq7fQinAcC--FW31wZi=aKOMpQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRMxPEL7wHPoRY4tBziYq7fQinAcC--FW31wZi=aKOMpQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 15 Jul 2026 09:35:20 -0400
X-Gm-Features: AUfX_mwHrdl6ZOMnYYiHlccn-kRce2Aq7oshZ_LMg5V_-_rqO34PhOqxUfr5y3g
Message-ID: <CAP+JOzSBvZk4JAi+=LUrN_KWRcq2Tvqcf3ZYv-rX=Hga25a=tQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: drop legacy probing of /selinux and /proc
 nodes for selinuxfs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 10:08=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Tue, Jul 7, 2026 at 11:17=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Originally selinuxfs was mounted on /selinux before the kernel was
> > change starting in Linux v3.0 to create a mount point directory for it
> > at /sys/fs/selinux, and libselinux had logic to check
> > /proc/filesystems and /proc/mounts for selinuxfs to dynamically detect
> > whether SELinux was enabled and where selinuxfs was mounted if it
> > didn't find selinuxfs in the expected locations. This results in
> > wasted effort on any modern Linux kernel where selinuxfs is always
> > mounted on /sys/fs/selinux, particularly in the SELinux-disabled case.
> >
> > NB This makes Linux v3.0 the minimum supported kernel version for the
> > SELinux userspace going forward.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/468
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  README.md                    |  4 ++++
> >  libselinux/src/init.c        | 43 ------------------------------------
> >  libselinux/src/load_policy.c |  6 -----
> >  libselinux/src/policy.h      |  3 +--
> >  4 files changed, 5 insertions(+), 51 deletions(-)
> >
> > diff --git a/README.md b/README.md
> > index ea8c4e46..08e82d0c 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -22,6 +22,10 @@ Archives of the mailing list are available at https:=
//lore.kernel.org/selinux.
> >  See the [SELinux Userspace wiki](https://github.com/SELinuxProject/sel=
inux/wiki)
> >  for more information.
> >
> > +Minimum Supported Kernel Version
> > +--------------------------------
> > +Linux v3.0 (for /sys/fs/selinux mount point directory)
> > +
> >  Installation
> >  ------------
> >
> > diff --git a/libselinux/src/init.c b/libselinux/src/init.c
> > index bd0803dd..1a377a0f 100644
> > --- a/libselinux/src/init.c
> > +++ b/libselinux/src/init.c
> > @@ -81,54 +81,11 @@ int selinuxfs_exists(void)
> >
> >  static void init_selinuxmnt(void)
> >  {
> > -       char *buf =3D NULL, *p;
> > -       FILE *fp =3D NULL;
> > -       size_t len;
> > -       ssize_t num;
> > -
> >         if (selinux_mnt)
> >                 return;
> >
> >         if (verify_selinuxmnt(SELINUXMNT) =3D=3D 0)
> >                 return;
> > -
> > -       if (verify_selinuxmnt(OLDSELINUXMNT) =3D=3D 0)
> > -               return;
> > -
> > -       /* Drop back to detecting it the long way. */
> > -       if (!selinuxfs_exists())
> > -               goto out;
> > -
> > -       /* At this point, the usual spot doesn't have an selinuxfs so
> > -        * we look around for it */
> > -       fp =3D fopen("/proc/mounts", "re");
> > -       if (!fp)
> > -               goto out;
> > -
> > -       __fsetlocking(fp, FSETLOCKING_BYCALLER);
> > -       while ((num =3D getline(&buf, &len, fp)) !=3D -1) {
> > -               char *tmp;
> > -               p =3D strchr(buf, ' ');
> > -               if (!p)
> > -                       goto out;
> > -               p++;
> > -               tmp =3D strchr(p, ' ');
> > -               if (!tmp)
> > -                       goto out;
> > -               if (!strncmp(tmp + 1, SELINUXFS " ", strlen(SELINUXFS) =
+ 1)) {
> > -                       *tmp =3D '\0';
> > -                       break;
> > -               }
> > -       }
> > -
> > -       /* If we found something, dup it */
> > -       if (num > 0)
> > -               verify_selinuxmnt(p);
> > -
> > -out:
> > -       free(buf);
> > -       if (fp)
> > -               fclose(fp);
> >  }
> >
> >  void fini_selinuxmnt(void)
> > diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.=
c
> > index 4337cedc..a6ec4a59 100644
> > --- a/libselinux/src/load_policy.c
> > +++ b/libselinux/src/load_policy.c
> > @@ -307,12 +307,6 @@ int selinux_init_load_policy(int *enforce)
> >                   NULL) =3D=3D 0 ||
> >             errno =3D=3D EBUSY) {
> >                 mntpoint =3D SELINUXMNT;
> > -       } else {
> > -               /* check old mountpoint */
> > -               if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, NULL)=
 =3D=3D 0 ||
> > -                   errno =3D=3D EBUSY) {
> > -                       mntpoint =3D OLDSELINUXMNT;
> > -               }
> >         }
> >
> >         if (!mntpoint) {
> > diff --git a/libselinux/src/policy.h b/libselinux/src/policy.h
> > index f6d72423..0ac599a4 100644
> > --- a/libselinux/src/policy.h
> > +++ b/libselinux/src/policy.h
> > @@ -20,9 +20,8 @@
> >  /* selinuxfs magic number */
> >  #define SELINUX_MAGIC 0xf97cff8c
> >
> > -/* Preferred selinux mount location */
> > +/* selinux mount location */
> >  #define SELINUXMNT "/sys/fs/selinux"
> > -#define OLDSELINUXMNT "/selinux"
> >
> >  /* selinuxfs mount point */
> >  extern char *selinux_mnt;
> > --
> > 2.54.0
> >
