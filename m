Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901538C437
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635441; cv=pass; b=gOx7vUEDZdaFlI/5JmR/gBpv0222JvThT4HsVkadRbcCJeLzaf4wRY9xH7mzy58zWPthzsu1l/0bCzl0LaYdeRBTIGHKRr+zouZ8HfIo0sgfPuabqhHV4ES1YGkIBexMEDSvVBwrJ8d4+/Q7SHRCz/tQBePUkMKaV4g8K/+ZTZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635441; c=relaxed/simple;
	bh=eJYuMPTbqszm/LFHzDsJy+JZ/zcJxZcE7lQtwnUVD/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KegA5MmdEVaZoZbeK6R2s5X/O9WQf7Pqe2mQk8vwfHXx1HpW3Vi3ZmLACwapEOd5qgro/wofGa8z6SlPS6BTcUw1Y2n/QCPfLVhKmZS0dpXDR6bn/mQ/CwKbzOnHrRU7VCBRS6wwmzrEOmKCRIsqv/sOM53zVCUPoa22JWzoPq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY3AWUDB; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY3AWUDB"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso3014966a91.0
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 11:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781635439; cv=none;
        d=google.com; s=arc-20240605;
        b=gASnw3QaM+8z2aRjj7Dv1EYmDZdlpGQdRQ48V6MFYnGy6Bm08Vq9mxBX+o7uSK4+3D
         BkvrePajNVXlDeApoYGX1FOHNtahl0WcK6f8ne7KcRfq/Xpu+FxRqN7qAdvMewvDgPE5
         ldGHw3tBcM9y2XOvVismp53Hk2y8iq2dpo3agc3KzriHGG2UrXhGGvs8uwArry8gCNSs
         fAhkNXvorkt4MamPV7l8InYTig+4gFYw8dQntxPTYOpQzfn0QlTixl3ZI6vSthwx6uDR
         Y9110+yChcvz+Gmyo8i9VbGURLkilSVeb9AeTiedV2fY3jm5U4cZ8Z1Hfvm6B6PHj7xi
         z3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eJYuMPTbqszm/LFHzDsJy+JZ/zcJxZcE7lQtwnUVD/Y=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=YryOmsa5yIjnv6FEagzxYQRXupA+llVgEMLFGl2RnhIQMYIW5nf0srlfVCSRM/Q/p0
         45bIhLpu/knI29TSjAWN4Ge/zOwbTuJXcw+DcfBwl3E4shGUN7dUFKskIj9qsEp5dSEz
         RICiVj4vhqhf09ga3l92sCaoalXhFbGb1fh+M7WGoy2CahKUleqv/wnvZy/hzjDKOlpi
         mlh8OIvmtDmicDokQMhqfSsEQP8ociGWLaB3/T9KRyyPLwKnZO8PpS0qbB6T8xfBA101
         zyg+0Ti8nkiKDyudDpw3YXq2ejXtV61GhE6OWzboR/UmWNOS4M7cGT5lgpfGEpC4qyJD
         8ryQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781635439; x=1782240239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJYuMPTbqszm/LFHzDsJy+JZ/zcJxZcE7lQtwnUVD/Y=;
        b=eY3AWUDBpnjnhMH9ibCGBqv7YU5iQQrWOmAeu1NdxY5VNGmXZmo4Kj5dbF6Pw3C+9D
         LTQ7Fn6VebwUq4saUiYrpyvIXYM5m0YLbW9iS2QVzS6X16cjlny0Z+KodMuGVfjQMboP
         2I5TtRknPyeoopk0eppE87nT1lrOSzr0ssPSkL0HtZtgH4GRg4f6T0Ry75XtApFkhFfp
         T022hj29CDFt1C9QqJ6f4OcYKTldKBR1rIi/6c3UJ+hpl6CDceaI4eQ6U775LvXHfZg2
         FSf6QAHITzbESzH5Y/n4BwuZkyCKv98cVvc6B8Ho7u+mA5WPZ7FyB2iyejf1Xx1gVr4M
         wqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635439; x=1782240239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eJYuMPTbqszm/LFHzDsJy+JZ/zcJxZcE7lQtwnUVD/Y=;
        b=C2QUUYHx9SA9DcVVkYDSe0g/X6wWuAynDyqIuvSeKzZDltlhw6LsENSBhgfz2Cg5gw
         mifHZBJUAAUNybhwTFIqotYbxTnDvQd4UbA4wx9t1pKvAV6GnQlcRw8syThuQUa8WrN0
         Rz+AkZwYBuyrUbFDFXqlwHR1SmIkT3S1bXy3S3F7cwFNHHF4XTku1VlMVYqWsE7JHJYY
         68rS7WHHLYh+h19V6PsipQMYdxlSAbC8+mP76I3P7dmnnOsRFzpr6tZp+rSByTIGIggx
         //2OQyT/8tX+orOrcPWnQK9PW8//7MbmZzRumNSQAGT8a+rvTaVbjHftgykI0Wn48G0F
         ICTA==
X-Gm-Message-State: AOJu0Yx+mJ5ZeG49A1taLjCjD6eG6Z7YZqzSyYVuN+fdOqoTpFPbojgB
	YEWlTuFcKPK8hzSDF+H2BCKg74XCBoVDFiFpZFYApwGLSqFDkjao6IugndDjrnjCCV5oo9wEjEb
	MIuFWFcUEjJh4eAJw0f0bkRVUJx0EzWquQVKs
X-Gm-Gg: Acq92OHy0BsE7nLdSKUB68I7FK5Hb3OC/l/eV4svRGN6oIOmPMDQEKkssxrdYFLc6NG
	hnH+plMMoMSydWFB+ah32dRuE0MQQrajcoXKgT4oBdjOHu0If/R/C7gRxakrDyGrEqvOLH13znK
	knlUnUpI4gCBZRyypjkHBhtZRRoGeE1HTJ7Sh6PWNguFKDwGXx5aADxgUCdhTKWGREr5QFNuTet
	UbOZVPx9vduLxBuqB2CXfqalZAe6E+r3iLGu5ytKNqjLwHUyF8WINvHzmh2TbirO0oZYGM60YnV
	fnHv0Bc=
X-Received: by 2002:a17:90b:3d85:b0:36d:8e6f:8d94 with SMTP id
 98e67ed59e1d1-37c936baab7mr775735a91.15.1781635439216; Tue, 16 Jun 2026
 11:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajGNgKCKVcmvVUeJ@AA-94-54-42-0F-E2> <CAEjxPJ7HfVS2iUOLztp1VGn0hQ9+4Jr=BMwTY0y_ZzEnwHKVcA@mail.gmail.com>
 <ajGXWxFgbeS0zfZx@AA-94-54-42-0F-E2>
In-Reply-To: <ajGXWxFgbeS0zfZx@AA-94-54-42-0F-E2>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 14:43:48 -0400
X-Gm-Features: AVVi8CeWrY0suCRLQeu_-VCG6KaCGh3HC6gLLy0-r6cmI4fi-AcOcoRvJayGqSY
Message-ID: <CAEjxPJ6V6m7Ery7fKRmcHKeRmFHKuO6=rmEuiQ6ELmcXeGZS=A@mail.gmail.com>
Subject: Re: About SELinux userspace AVC
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 2:35=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> On Tue, Jun 16, 2026 at 02:04:33PM -0400, Stephen Smalley wrote:
> > On Tue, Jun 16, 2026 at 1:53=E2=80=AFPM Kalevi Kolttonen <kalevi@koltto=
nen.fi> wrote:
> > >
> > > Hello!
> > >
> > > When going through the SELinux userspace code base,
> > > I found out that AVC is available in userspace too.
> > >
> > > Just curious, does anyone know if there are many
> > > applications that use this feature? As far as I know,
> > > most of the AVC decisions happen in the kernel side.
> >
> > It is used by a variety of applications in both Linux and Android.
> > Sometimes indirectly via the newer selinux_check_access(3) API.
>
> I am trying to see which apps could make use of it, but on
> my Fedora 44 installation the number seems pretty small:
>
> ~ $ rpm -qa|wc -l
> 5930
> ~ $ rpm -q --whatrequires libselinux
> setools-console-analyses-4.6.0-5.fc44.x86_64
> setools-console-4.6.0-5.fc44.x86_64
> cronie-1.7.2-16.fc44.x86_64
> openssh-10.2p1-10.fc44.x86_64
> shadow-utils-4.19.0-7.fc44.x86_64
> mcstrans-3.10-1.fc44.x86_64
>
> But I am not sure whether I am doing the right query here.

sudo dnf repoquery --disablerepo=3D\* --enablerepo=3Dfedora
--whatrequires=3D'libselinux.so.1()(64bit)' --qf '%{sourcerpm}\n'
will give a longer list of application that link libselinux.

However, if you particularly want to see what applications use these APIs,
https://codesearch.debian.net/search?q=3Davc_has_perm%7Cselinux_check_acces=
s&literal=3D0
will be more precise (for Debian; I don't know of a way to do the same
for Fedora), and
https://cs.android.com/search?q=3Davc_has_perm%20OR%20selinux_check_access
for Android (after skipping past the ones that are in libselinux itself).
