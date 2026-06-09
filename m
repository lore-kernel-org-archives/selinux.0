Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F736331ED3
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029643; cv=pass; b=ITngNobTOjqp3lVG4WT6fxrV0VHrUQi0o5RnK2P17kBT+ZyMCCok3Vb3+RwBZB2uggLuPOuLcI6ODG1pldkr8POHF9AA7ydb9Ldw7r0y83sP5PymjbUfJGilzQdzYz6WP+GI0TcB+BPT9ja9P4rjF1Z5lq8gmMUxV9537nOwJng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029643; c=relaxed/simple;
	bh=AXL3nCNGfKXqo1NEaqK9P2m5XOxQj23M2+H9G/WPYAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdVoGRB4PPFoHgdwSInNJ+umPKHKOlzvyUsL5BhNCdT/q1raSKKH+e43qAXVZj7YjthHHYtqzgwUKtRh/Cw1XofcPUZMx6tdlgmI3/oU0gd+5+ArzWhh+hBgmvL29dRm9bXLH4DOmR/OAdPL3dJWRcUE1mA8vHY0AL/1iwmLeOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6j6+pVd; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6j6+pVd"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa7a70c0aaso5982018e87.0
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 11:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781029640; cv=none;
        d=google.com; s=arc-20240605;
        b=IFMDdJjUwHkF/xVlR+TQJ6brdPC8DAniikUG8ajY6y1r5VN2vHQqhpjrmvK/K0TQvo
         l25lFod7yg5X4T4N+bl9cDz3jDGYBacBChkLnjXcJ++shkqgVKWWkBHhBOVX+Y5a2/E7
         DXAZ4xsnwmWTHX7zPDixdc83L4Ayi93pXVv3t272dDiBj3U6MqtNhbC9Bt+OANMxZY8w
         U4mmtVFfVOdWG3OTCl/iRWvtORvBEi/2DhW/knsIPqvP8CXb2gjqHkvonngo3NpoEQ70
         VV1G2WaIK26S/70TC/AP/OnF6VifSGDFY3Buk4qV6SUxPyNLZHHWm0Vtz/hKcqmAe/FT
         52WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HvIOhiXN0vGEioqwaSZ6yKO/bdYui3f2ssMhEk3LdDo=;
        fh=O5eaInpEYMH3sq23C/QESel+JOHLfHMFMQUnKM5jr6Y=;
        b=cmR7BSCH01bu6rsdRUrE87m3CMH7HqZMhT5M4YsrHu6aqR1Tg6y8VeK7FlnKhwi6qZ
         oXj//PDkStMkjdqIAsRZoLiNZbyJRpX+vo8a2la71lvkYMXDd47zbE6OBQIf6gRgC4ZW
         7HNt4m9M53cBl7MC/x/0qbwGrVP0flp0WYVRK2m9w5Dm+PQ95ynlEJQrvJdCghN1F5MQ
         ExlkLdYhmTIm6MQ4UxrB6kE/br7pJL0iA8Kuevf2xgSQbJ1gg0pAiZ6Ky7nb97fndyv6
         Sk6Xosa3va7MUAkEa3IrCDHG5M0Xmlqh+GvXytz40f4xPPeJQKYCTXMr7+eSUrfgYuxQ
         7ZdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781029640; x=1781634440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvIOhiXN0vGEioqwaSZ6yKO/bdYui3f2ssMhEk3LdDo=;
        b=W6j6+pVdTplb3J8vebp25sfbpKplBgVDPtkVehbjjpiu5E++R2oH9mIJlYDuM3brzo
         27g9HDc3EHA4f4FJ3dm2xBthlGtepnNT8xDn35w23Eqahl47F332Xk7JHMmU5khkzl+N
         vQZGJ2OyyxMu9pgtWHTc8+DSlJR4G5ykePhuTgWtgAiSquycDmIjyq8SGvBiwllNz+DR
         O/XX/Mi8ls48K3wkB46SB3fYmLPZPZmHpbFWkSgjqH+fhRU6MIv8qdxUhV93YxFAV3dk
         5gzRb9tWI/5yipyaod0DddQOI99zCa8uQ0I3/uk+NLw3NOjWVQ8Nvz3mqrEntun0oNEw
         J4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029640; x=1781634440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HvIOhiXN0vGEioqwaSZ6yKO/bdYui3f2ssMhEk3LdDo=;
        b=fZA5daUlNESgXeuu64nfbjYdPEnAOak2YsuS0/zeoAQlI6tJLTIAmLRiS1XJLw9Cdc
         ec4llg9Ces5kpIguVvAW0Px0yKMKsZDepfV5FkCvocFf24KsCx8WUgieTpAKSD8n9dBK
         VxtK662y9AVndrZrHPXWA9YLW3tU7cI1RNqGvBoL+u2NK2ut7aQRUgAJT6Myr1SyKTpf
         tYuBMqEbffjrc2yfxcZEyVJPnKXfH22iwLvAV+KmcpWlPAkrI9Idt8uj8A4sujzprkr/
         B4L0Bvw75hZ+LKP7DNWi1upg3Qq3eNlqYw5xU0TqJ8oK+O5Bq64nTrtBUysUDXK9AiYC
         f3/Q==
X-Gm-Message-State: AOJu0YxIu/WGbFMmBVRjqaXWpYurqZImyUFxbASYgXZdD8SXxWTUeTDq
	c9CHJhHMZlUJl7HpffbgpouYJfIJ2o8lfIIz2bhzjkJpZswOMiwTWJRYNamFrgNh2A+kDD7VIdG
	Jyo3KWvgdjXKTcwtAmweA4Fa7+QNlYS55GA==
X-Gm-Gg: Acq92OEBKotgI+pdZ7GKiORDmZ4a6XJNgISBNDO6oTT5tSZoMNEDV8FYrxYS/yKddnw
	7pcVUofit3l0R7pTiec0Wg6dDCJjxFSwtvbEh5+GDqyQEHe2zw4Q4iCUJEj6DmnVI8utoWsRK82
	I0o1/sFjrNXWmPnQhF+lEX+cstWahHPWAHBVnzz/oGg4/6pIr6Dz6T751m0mNB8LdKUF67s4BQc
	dDsGt38c7VV0fvBeNgZmuNTNBwDrm/7ee+IlfffRcx4MhALHtaEWirQ+tKYlSKe6IF2WQuXBM17
	7hpGp4NtOZfoLPQ=
X-Received: by 2002:a05:6512:4045:10b0:5aa:780b:f341 with SMTP id
 2adb3069b0e04-5aa87c0bacemr4146721e87.35.1781029640259; Tue, 09 Jun 2026
 11:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609174800.6715-2-stephen.smalley.work@gmail.com> <CAP+JOzQm9q4AxWSJq4=e4L4m4C=2Mbmp2FT9rpjdnur4Up-t3Q@mail.gmail.com>
In-Reply-To: <CAP+JOzQm9q4AxWSJq4=e4L4m4C=2Mbmp2FT9rpjdnur4Up-t3Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 9 Jun 2026 14:27:09 -0400
X-Gm-Features: AVVi8CfATMYT8sj5FzAXXpr78uqcWs_ypjI4zqm2lkr2_5eKHHiZAtgvo_smcew
Message-ID: <CAP+JOzSNZ8o70gPSoj05-hc-VSMY6HnP+nngCD6vY7JZZRK5Ew@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: Do not clobber errno of the world
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	=?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cristian@rodriguez.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 2:00=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, Jun 9, 2026 at 1:48=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Cristian Rodr=C3=ADguez <cristian@rodriguez.im>
> >
> > libselinux clobbers errno of all consumers (systemd, sshd you name it)
> > because its constructors do not properly save and restore errno.
> > The following program demonstrates it.
> >
> > int main(void)
> > {
> >         assert(errno =3D=3D 0);
> >         /* Just a test, it doesn't matter already clobbered */
> >         if(is_selinux_enabled() < 0) {
> >                 perror("not enabled");
> >                 return 1;
> >         }
> > }
> >
> > if any function sets errno, it is not switched back to the original
> > value and standards DO NOT require errno to the set to zero before
> > entering main
> >
> > Signed-off-by: Cristian Rodr=C3=ADguez <cristian@rodriguez.im>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >
> > v3 applies make format.
> >
> >  libselinux/src/init.c             | 1 +
> >  libselinux/src/selinux_internal.h | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/libselinux/src/init.c b/libselinux/src/init.c
> > index 499e4e44..abed3088 100644
> > --- a/libselinux/src/init.c
> > +++ b/libselinux/src/init.c
> > @@ -145,6 +145,7 @@ void set_selinuxmnt(const char *mnt)
> >  static void init_lib(void) __attribute__((constructor));
> >  static void init_lib(void)
> >  {
> > +       SELINUX_PROTECT_ERRNO;
> >         selinux_page_size =3D sysconf(_SC_PAGE_SIZE);
> >         init_selinuxmnt();
> >  #ifndef ANDROID
> > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux=
_internal.h
> > index 6089463d..ce04b128 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -147,4 +147,13 @@ static inline void fclose_errno_safe(FILE *stream)
> >
> >  #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
> >
> > +static inline void selinux_reset_errno(int *saved_errno)
> > +{
> > +       errno =3D *saved_errno;
> > +}
> > +
> > +#define SELINUX_PROTECT_ERRNO                             \
> > +       __attribute__((__cleanup__(selinux_reset_errno))) \
> > +       __attribute__((__unused__)) int _saved_errno =3D errno
> > +
> >  #endif /* SELINUX_INTERNAL_H_ */
> > --
> > 2.54.0
> >
