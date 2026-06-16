Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3334F492
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635606; cv=pass; b=mAAuRUkTYDotGBESeVdeJQt2/qzyelrznQr8KqVwzlRNeQKgw+MNot6VB8dKRqCFTROdxmOvxhX++j7xmo6FybE+9uh2A1Ds7GYitPOmsRtOQ3zSgQrITcKQqCGyzff4RQW/6HNdDhgZFsvSjTaJyl23Iq6Qei/ruURDuzjxSwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635606; c=relaxed/simple;
	bh=GM/W0uToTmSz3wcQRfHIDaJOrUG6ak338vQxkF25Qq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcrdbQXp57nF1HiVlZLTZAgsV+YyZOA8YS+bam1OJc3KvZJ7exYpJ80cX8MBPZw9uIFFE5iYnQnxVsiXJGqimQtouB0366flbki9f182aWmTKK+LkvGXs4CdsjxN04p/le7eE5WwvNDTepYVJAhENJP9Co7wEPmUzJ5QqeFwPN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR8k1bE1; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR8k1bE1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so2562335ad.2
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 11:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781635605; cv=none;
        d=google.com; s=arc-20240605;
        b=DA8DHgsLMXWCQajHfgQ0WTbHeS/5WdF4wWPtewYb0jo9GjnnkDrUJ7idrGViXHt+/D
         dMi9CTCeU1+T4VIry9bxCbYrALXX2m2tbzssL5aaFEvQi8nSpF9mcwb1kN7hLgFgrv2a
         QUo7P+HTf1qExs8R8824chFCAyXrqoUJKl1uh3ovanKX+4gw1KNfoh4U22U7d9e/xz9h
         lmbyfsWs4oA9CJG9++PDK7fGq14oFdZIYPWZHtORO2YaJYDa8u7AO5DOhMyqi8zWn1PU
         7Fi/uGaCgIVX7QbaS44YeOTHnB1aeeGMC4JGIbMIvA+PqKiwhwiMJ5gq6wXKyWJtgnQK
         GEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GM/W0uToTmSz3wcQRfHIDaJOrUG6ak338vQxkF25Qq0=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=GFSLfJmuvvuhxYptfCszMXx3Z6XL8n7cA8Dws+td2pU1io9/5wm0nbeMCDrRHehtTF
         Dj2qGhEUEh1KSXu5lghfvCj0AzU71KecfAe+5h43SvTbmFt4GC7ejmIOoUuchV+YCBPg
         oVtKu4TxLViaJ7RPf/iV5u5I3guat9MXrqzwHBwhx69Vpq9ym++vXM+rtQ3owT2bzJOp
         hNIiBG/0UBfHcZocrbZhrGEcqUPLwIg/xuP08pADrSHH3cVuV4rkxCHuQFx0UyynCyA8
         N7XyURFiYFiYYf/UJlUqStf3buQgWvq0cYyBVlAU+biSA+TGLSNbBULAOGiChlGwyNey
         rSEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781635605; x=1782240405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM/W0uToTmSz3wcQRfHIDaJOrUG6ak338vQxkF25Qq0=;
        b=eR8k1bE1sgJ8HNFpf9Cx14g8cML1fzft1K4EH4sFb9GaMFwEi6jH2uCJnJbplSwH4v
         2OiNEkS02IITw10drhZVGqUEr+C4czzhrnq0pvqtO6shn/UpV7OjDyOLgPV1RfY555+O
         eQW4rf2ZQ6OBhycEK+p9lCstVsdO06xiaIalmrZIezPpSfQeBf2Ou5nC0qsE/MDUMOHN
         yrWTcZ8hae12kA6X1T8p53YnaWc+wBHwWcoQBP8kxaLqcfGYQ7ZhLcfSN8076WtwLmkw
         m5Wecy1egKW/XAWAr2UbYeBtZRi8/8RTF26b/mKWbHerKuN4TgLeczW1Xcx7gzUYdtC/
         Hb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635605; x=1782240405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GM/W0uToTmSz3wcQRfHIDaJOrUG6ak338vQxkF25Qq0=;
        b=GlRSfLBPHYm0oDGtQ0vM6Uw+jZgMowMmpxBgjCfkyr3lf/pAp1seh/ZZMQmpUp86Wa
         LcNF1q5T2/ZcqelD3LndHD8P+AKvEzJBShC3rnAzBYxCkXdSPhosm99of8XRWhoUWtyz
         8QYTvP0xhPxcouk80N13LlGhdQahW71hokc95wNi5FnzL8HkPyZATCgV5oUC8OVYMAZI
         wrhvpbvkUwbi6CP8/QPZVZ6hL4k/8Wbq2a10UXdX6S50AIvrwTQ0YJvHFnKfKvbit1v7
         4B63D4/jTfsQ85kvwvsb4S0WUBVQTrlUDtmPezpZ15PykUsjgWAOCFxKdqCuTnAW5EHo
         eTuQ==
X-Gm-Message-State: AOJu0YzRsbNoZFu2uNYQKJp0VORvLhGEquwwstDZ7Rv+MAgAHEZwG2O5
	vpRpCNyNy6G4VKUWBrNSfIv7oUYlnFBa4jiOYVFYIPtPriXqfG40Y2Gh+5U1YpggyVl7RsMGNA6
	psC/B1JDKlm+UepHLONcGvz9WCBifHt8nuA==
X-Gm-Gg: AfdE7clsUYLnuEp8587FO+Hu89v5exeYQ4aV9FXpI/L0d4w+Ya2GAwogcxrQj6/5s/C
	3sK5TypzQf5Xqzd1GmNAP3mBgz/djmTEujLF9WkW5QYZRgFO/5EYpBOvuBIN2ytbviL0bxYVLgD
	Aff7J0DrKkDEk7/fc9nNPPTuNNpRsp7GPYu87DDkOBsHI1aLQFWqLEY+Ufnw2qZZaX9ZfVFBIKk
	Lf/RpdmenknJ2PC2mzwwmybbrt2hOPmILapBVI2ziLK/2kvNKMlPHP+cQzkTYkYL8fb+4E3QZYl
	agJpZjs=
X-Received: by 2002:a17:903:284:b0:2c6:9f66:d57e with SMTP id
 d9443c01a7336-2c6bc285d9fmr2087115ad.36.1781635604845; Tue, 16 Jun 2026
 11:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajGNgKCKVcmvVUeJ@AA-94-54-42-0F-E2> <CAEjxPJ7HfVS2iUOLztp1VGn0hQ9+4Jr=BMwTY0y_ZzEnwHKVcA@mail.gmail.com>
 <ajGXWxFgbeS0zfZx@AA-94-54-42-0F-E2> <CAEjxPJ6V6m7Ery7fKRmcHKeRmFHKuO6=rmEuiQ6ELmcXeGZS=A@mail.gmail.com>
In-Reply-To: <CAEjxPJ6V6m7Ery7fKRmcHKeRmFHKuO6=rmEuiQ6ELmcXeGZS=A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 14:46:33 -0400
X-Gm-Features: AVVi8CflRAFrr2_IW_6udzuaRfsTue09p5nWadjeNTjiae2oEDsTTQ0gAoxjK7Q
Message-ID: <CAEjxPJ7STt0KXG=fLAC6BtQNWMaXC7JXTDh=7d5Jwfuxi027Fw@mail.gmail.com>
Subject: Re: About SELinux userspace AVC
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 2:43=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 16, 2026 at 2:35=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttone=
n.fi> wrote:
> >
> > On Tue, Jun 16, 2026 at 02:04:33PM -0400, Stephen Smalley wrote:
> > > On Tue, Jun 16, 2026 at 1:53=E2=80=AFPM Kalevi Kolttonen <kalevi@kolt=
tonen.fi> wrote:
> > > >
> > > > Hello!
> > > >
> > > > When going through the SELinux userspace code base,
> > > > I found out that AVC is available in userspace too.
> > > >
> > > > Just curious, does anyone know if there are many
> > > > applications that use this feature? As far as I know,
> > > > most of the AVC decisions happen in the kernel side.
> > >
> > > It is used by a variety of applications in both Linux and Android.
> > > Sometimes indirectly via the newer selinux_check_access(3) API.
> >
> > I am trying to see which apps could make use of it, but on
> > my Fedora 44 installation the number seems pretty small:
> >
> > ~ $ rpm -qa|wc -l
> > 5930
> > ~ $ rpm -q --whatrequires libselinux
> > setools-console-analyses-4.6.0-5.fc44.x86_64
> > setools-console-4.6.0-5.fc44.x86_64
> > cronie-1.7.2-16.fc44.x86_64
> > openssh-10.2p1-10.fc44.x86_64
> > shadow-utils-4.19.0-7.fc44.x86_64
> > mcstrans-3.10-1.fc44.x86_64
> >
> > But I am not sure whether I am doing the right query here.
>
> sudo dnf repoquery --disablerepo=3D\* --enablerepo=3Dfedora
> --whatrequires=3D'libselinux.so.1()(64bit)' --qf '%{sourcerpm}\n'
> will give a longer list of application that link libselinux.
>
> However, if you particularly want to see what applications use these APIs=
,
> https://codesearch.debian.net/search?q=3Davc_has_perm%7Cselinux_check_acc=
ess&literal=3D0
> will be more precise (for Debian; I don't know of a way to do the same
> for Fedora), and
> https://cs.android.com/search?q=3Davc_has_perm%20OR%20selinux_check_acces=
s
> for Android (after skipping past the ones that are in libselinux itself).

Also, systemd uses these APIs, not sure why it isn't showing up in the list=
.
