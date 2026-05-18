Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1FE2AF1D
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134266; cv=pass; b=VWSKupXV6MGiesvMdczYNrRV818dDB3ShYG/XFAVkyuK5okbvRKGIxwTtHOjSPf03g6BO1jUozmlx7N+z6O+j0FT4WUuZb5nm0puWUk+ZC+gq0QBG/B6fz9EYbl1rbkFLbKNh2vsfujN/xCYtQl99jKQEhQrnQ4gXzjdW3onSlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134266; c=relaxed/simple;
	bh=rddiuXhTTppSqO9mxUhsv//8olJkF+iGA5iyjdcLulU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9044inkZi5Ey44vS3BZbER2dsbAdLJITWiJcGKUJXPcAujQhK/phZqrtY7rlY3i/nUW5cixBDI+c3nDYrOK9tfGdrGWY4usIoBDw4EkhOOSF12lQfL2s5XyRi2s9cLyntl3V8tNUMMCeQLdUf5lGNXuCHXi6yaOTEzWfafCUsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+npXYon; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+npXYon"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b788a98557so16037345ad.2
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134265; cv=none;
        d=google.com; s=arc-20240605;
        b=Zf7XEDyEBv457/nGC5SNMQDgSuhgIyYgPOfmecnwywYpv80aKtscf+zt85MAq980Ra
         oCcpl31JUJNof8OCvAFIf2XOQGsZZ9wFOL0Y0FxUCO5giTrjgbhmH9XvRcHa/XANZWx5
         35rcAf0H/idIzasu8+9k2CopNA8Fk29dXoXEAm0BzWH/Wgzh/vbgeRBdFRTOccLmzuhw
         rNW64cMp3mWjmYSU6cU/x1vcarynDY3sj75I8ahGlhW2Zu/HVbL9xeBJ25FujHnQWEuc
         6KXaaw4cWI8xgfmVRPuxhQZa2CFrdRt7wNItqycEzTdehoiIHLSF7TjK7AlClrFPtlRp
         99AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AFomDdda16acYwU7Z52AANoYSzy4mi7XoE4BewvH5wc=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=bPdtvvHo4o1tDB0j2Nbhz+k0IMLsXNW4KdBom1K95p1hi9dHR99qzSq8ruLQ5C5Q03
         NC19OqLfB+EkrMSH5DXhIHC6ZESr8j1dukLgrlS8Bu3KtjcUSdAs7b/9NmnZeL6NlPcD
         KcL1GkNvbIcFOopdwxdgfgBqbjSBhahkC5FHlgUGqAsbcoo+F9+Zci5xhROpVs0kosw1
         mXC2usKFy6+L52JV+4PZSOM+f52lsWkWJx5+/mfHdZqeNmiVlgjXbday5FKN6ABwvT/g
         XrsUyZadEJsk6fJMPd0g6pPyzDCsmjy3NkLMU/MxqDH1y8ewpTLK/qtb+dMH7wNX4430
         448Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134265; x=1779739065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFomDdda16acYwU7Z52AANoYSzy4mi7XoE4BewvH5wc=;
        b=n+npXYonczXXJUGyyBpylAfDQwAwGJVeCDh6hZT9C+qCEkRtG2o5hnPtMXPEpKpJc2
         berMa5Rw6NrnqsF2Smtop6uHIP1bCuysVzsd/h2lhruhPhHP2C7UlGNIGPLoFPnXypHm
         HSfeGF+rdjVTRiTc4WLlgImbnFbhGq6BPpHpNc5ETaAKc3d+GcOlINOTLwgMtPke9/8l
         WHpnZuPrL38Imlcn4PUKDS1KUFN+HDZT8eVkRoBqJEgcmmcOe5eafbKHZJexCvjMa208
         sfYeaJzqy0KBqCCGWcFvdZVhCDzMl/aqw2xYwdEUKgfmiYlFlUI+UzeIJwZdApTB6fF8
         MYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134265; x=1779739065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFomDdda16acYwU7Z52AANoYSzy4mi7XoE4BewvH5wc=;
        b=KzvxxiU76fLW0pJg6QyqWr9mg7FIOK24mChUgKFHYerQQU6ParKdGobHUxrnfAnQJ5
         sH4IC223xmiFW6x8WYtEqbzxou6fo76ZnAHeTyawMLLftRWNBW6vZJmqP6iMvkJETZWF
         EqzadhbGNZyvGxkl0kANhcBsUmpO+jOv7UVuDLMrr7tGaoYS2Mrq92vpqH6JLfeEgaS9
         4aK6GHNuMhaq0P2k7OrhvVC5rCBnHsRjKYUJEkfWeB8aL4+kFWOhpjPPNhj0/9Jsfc55
         jNyKFI33GXjFBL6eKtqZAmnZ+IbnUgkZna1/h7CMxP76fkeJKjw47aTh0X92h6hUs0iu
         Wp9g==
X-Gm-Message-State: AOJu0YwLyZLf3BqG3wlBkDIUiz5x6kYmynr0Y3/OXQTEkV981j14OmyD
	5M4g7qhJGb4VB/Zhl9YvXi2BuFCmtUk/egATeOO4Nhg893iZSSPtlF0p4owl2GcS8+Fgw+SGLRI
	uMw0AADl/f4918bZ4cgGB4R/s2dYBKmq9Vw==
X-Gm-Gg: Acq92OGrVcSgKCxYWwHKYJBU5DMYMTui870d5ASYPWrMS0gnW9DzWD+djor2a2i0qyt
	YTxhlSVGvR6DXvl/xvRCH5ItCXwRlSEvreDtdlhWplicuVNKjzUZSrPHnzKxS80n2itbfL+jrJY
	+Eqf4fmX6pNYjco762Na70Yx797BoZPAgsbkmzJEiTf9V5WkwShC7P9JiAmGjVukBqyvUm+EnZd
	LF28zGrqjd6CMg9h970AltAjrAfhSiyw3utfnWqUdKRonGb/smgQypeR1sTBYtVLjui+SvAF9XD
	5/29GPY=
X-Received: by 2002:a17:902:e78b:b0:2ba:6ca2:be0 with SMTP id
 d9443c01a7336-2bd7e802957mr167228975ad.4.1779134264832; Mon, 18 May 2026
 12:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513134749.37510-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260513134749.37510-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 15:57:33 -0400
X-Gm-Features: AVHnY4IwlK1xUIVw17d0BkAhCkej07XzLu7oMuinPV8WO2JAhStHqsW2MXnKZyc
Message-ID: <CAEjxPJ7DnVBr2TTEdCcA56e_y_JsV+SVLYrWSi8OGk1uyxUteA@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: prevent rsync from interpreting paths
 as options
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 9:48=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Insert a "--" after all legitimate options before any glob or
> pathnames to prevent rsync from interpreting them as options.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  sandbox/seunshare.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Merged.
