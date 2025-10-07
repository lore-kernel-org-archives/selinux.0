Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A36B1CDFD5
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851650; cv=none; b=dZ8b6nXiKI+kGAH3pkvP+1KRpHUQ5SBJLK64P6fUNBlHR0VqIwW4jcVbnqyi4UtN5L7mNgZucw41h8CjQ8Pw71mzIZveSRfMAPIHO1+quYZ4dwPNqVFzWFPcWbgj4527HdCHKqq3WEBS5XaSsXURxHZD0GPYYsQbMad4OhcGXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851650; c=relaxed/simple;
	bh=5zjJj8M5tJv980eHWC4UQsGVDWbqGgMu4PwGBzynOU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXUe8N1gDPBGICoQtqnmWLLWv6+KYkGPKfq8Ax5YWNOj9evYxe1A7HL83QZ91CZxX4qwXKSgtlXLclagJ2j/b/S3zujpfn/6dzK0pQKOsY1yZeAwCepBXtZK+Gh/BV7k0h0ZCM3tUkprJMs9J/ebwv1iKkL2/0+28sElvPq+efY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0S6PMbT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0S6PMbT"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-330469eb750so7680771a91.2
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851649; x=1760456449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G9KXtvbBop3Xqai3s0qgsYYt8zbDEw6G4CA+PbHeEc=;
        b=d0S6PMbTDmf4LysnrjfFwIoWX1/hME+A6ulgIR4b8Nxq7KncTMHgE1BvPUmwHiLl9K
         Za3EmZ+AbiW55tHKhLyDAajS+1Nv1Hagje+Jz62FVAxCNwuhZ/k73hMlqF9GKhWJmfuh
         duP8JNc/WyNGHkOjOE+hZxJ2+9ZrC5ftJ530A5b1uJvXOgF4Hpg5fyOy/Qve91lHPuq6
         4pmnE9co9b8J9voyFreH5rxGNHN0G2GSig+3IHd2eD8Cdtu3HdWd9sm2bELQAx8YdPhV
         vuGG3IddA5DSj8S4NdYAVCweHYU00dTN3vDZQcSC+jLvydP5P52q4vcuHD0nws9XIDXD
         ZzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851649; x=1760456449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G9KXtvbBop3Xqai3s0qgsYYt8zbDEw6G4CA+PbHeEc=;
        b=LVIHL3Se7HrfLDA5dHK/tcQ91xUWGG6et1jAy3qXjSqbos+2CMYD9b5YmxXL5iwwou
         VyTUdQvgGbeqRtD/eM97jtLfBulKwM0NgShibcP4C5ZpuiBJeZowAr8BUI7Paux1HtT9
         wdRieOSA0hGs+FDda1o7IqAKdwp7zEgNzwJblYtgMPcaY0M1fpruNTvN4JQ/kOwc7dF0
         2/ZZ0zbjp8rSRDWPGz3dv7GW+SdMvHLVUMRKYM3TJfzUUZ325wAp/L2J3qfTYlgejalP
         TkrHK/c/5AeMyiOmpC2kySYeyuou79j0Cg+Gq07f0B/gSh/bjXM0Ih7uxDk92UPalXWj
         tnew==
X-Gm-Message-State: AOJu0YwtVKzdlK49AJPnlsbfcDQ2cKQgcwy9cj5Uj7EecYwJOLSMoL5r
	SV4kBgXNtAUv2fD75yStcTTxRlyGZwom08lQ/5tp8QpB92mfRveqs3vyMtrhMPeLP8YeocmY5Eg
	ZwpndKBq6wOBM6Y4Bjx4t0K5niEm039DWuQ==
X-Gm-Gg: ASbGnculwLYG4YfNO23tQacwnsK5XSzyri3X6mDzvAIgMYikNnYieUPZGfSg3CmNFsX
	r8GtY8HuuUf74igAPf+NtOXiSu19mwhJx512bbgzPmRXdKVOrTYc1QCN/Apqj7zlkiBv4kHZ7C7
	BIuaakSeItGQTgwDZmDQFKp7j/hwLHJxMjphmoJ9tFqTrwMEuxhuOVMG21B2KeqUWY0qngs4fz9
	qYEzsJvpc7ftx6m8EfoLY//1ZPAKyeo/cQ1sj07ZA==
X-Google-Smtp-Source: AGHT+IFKxCuqtfNcPPyrNG48tPaJVICn2ND0CjPRMSOmw3nfQv+/eICtPH4BgI6LMTnJQcHZxEPtQNqbwegZbYp3ZvA=
X-Received: by 2002:a17:90b:4d8d:b0:32b:c9c0:2a11 with SMTP id
 98e67ed59e1d1-339c2707c2emr22649973a91.4.1759851648710; Tue, 07 Oct 2025
 08:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4UKshtRGPyEKwkfTS-D5uc9thFNovC2_--kdV-Y3gDbg@mail.gmail.com>
 <20250925060346.906929-1-nvraxn@gmail.com> <CAEjxPJ7DR6i07OcCg6_1Aj+qbxH6gaL3KNNXAPZWX8Vt_FiFCg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7DR6i07OcCg6_1Aj+qbxH6gaL3KNNXAPZWX8Vt_FiFCg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 11:40:37 -0400
X-Gm-Features: AS18NWBbRhLdzbr2x30igjv-YBdrZitRYsZ4wcM3v7o-zJW5fmVW-bHKkwQsnYs
Message-ID: <CAEjxPJ5AJ1z8XXOcd7PiLBiXFk0P4QWXHQjZV92sCFVqviv4Uw@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: get_home_dirs: cleanup parsing of values
 from conf files
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 12:42=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 25, 2025 at 2:04=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > atoi (3) is... bugprone.  It's virtually impossible to differentiate an
> > invalid value (e.g. the string "foo") from a valid value such as "0" as
> > 0 is returned on error!  From the manual page:
> >
> > >       except that atoi() does not detect errors.
> > > RETURN VALUE
> > >       The converted value or 0 on error.
> >
> > In the case of get_home_dirs, atoi is downright wrong.  We are parsing
> > UID_MIN, UID_MAX, and LU_UIDNUMBER, which all have a numerical value,
> > without any validation that what we are parsing is actually a number.
> > This is especially problematic as that means that in the case of an
> > invalid value (e.g. UID_MIN=3Dfoo), UID_MIN is incorrectly parsed as 0.
> >
> > Instead, use strtoul (3) to parse these values.  If parsing fails, such
> > as in the case where UID_MIN=3Dfoo, warn that parsing failed, and use t=
he
> > default values for each key as specified by the manual page.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
