Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27942189B
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703468; cv=pass; b=OD1aWRhnpEulR4WtmYGRccS8UCLKECNgPEXWshhs6Kw5QHaBIMTm+C5Wc5BwVlzJUsgvOA2GHuE5nBc2KiSpIT6THaZJqCbUuvxT7yB+/8Vy7d15+RALi7ELGRYoJKeDW0d42ZxxnxdKOQQ9cfv5vTPvwalZhIv0YP6mZk4QbH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703468; c=relaxed/simple;
	bh=Z0PZwONgPFoK0XqMeSTQfrvF+OqRU8eqiGRYl14gPv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndQFL1GKxt62Wm2dL4uNqj43RAc/GwhedzvsJ4emSr6CP8bMuMRfLbhzEvIq9Ue2dK7jH/yzL/HrI82lF+a8JXEdcCSagQjvx72duP29cCCjmSLNGxN5MqtfaE+WCJyO641fIRZt497YUUHOhuOkKCQWPFsbnRRG8KMt8pPCscc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8UIBvFK; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8UIBvFK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423610ec93so4904907b3a.2
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 06:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781703467; cv=none;
        d=google.com; s=arc-20240605;
        b=iOKV8Qj4vdyD9A4qsZn7RM0oCorVWKjsObIxfJXMx17p0H97Zj/6F2mUAcdwvZC/xO
         xv/FY/m0TGdH0yxsxIzUsos9xDcRSiqGDhTG+UvqpQKeZWwfUKotYB3HI5DAQLNrfWDo
         n/kWYtsFfgBmw4vO+TcZ/aiMdNWXUZkJvJiQs6tdUkiYvSo7+aHKRj1gNdiVThtIw42y
         +SWfRyxcQa+CFa8F/iAxGTpMb9qRA7zgnMJDdEtfKTGdqukaKpFE+0YnUG5TOn3bd9Rd
         +0R4UiG4U01Rp1CluWc2jfRZjzJQuI2BYqiKG724xwzR34kJ4YRttB5aYT/6NKhvrVqK
         oN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z0PZwONgPFoK0XqMeSTQfrvF+OqRU8eqiGRYl14gPv0=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=L9dOC5vbZDXMrI4jOdynl/m5O9dIKz2ah6lVU5hgRmrL9nxrhzB1abqnkhv6eoAEuc
         nByWGmNhg9b0bXT7UZ1iuHO6jC4AKyk3HNPpj1Orn4WcFvkTsreBBabhlO23nBoAR05f
         pEv0nRJbRGu/OgMkUc8ij9q6kdfBZQF3sFV5mJWaIHdiaCbcl+PdMcv3zfs9d9yrCkqY
         UhWLtn12Az34hinNSm2l0iY1twXI6Dv1l/Javl+1G7p/mr4NCZadkSxv5Fo1MOz0x92m
         0shvGwaofzg2ge2fB/GQ3hfuC7KgLAtNIiMVHbT+ma50XWUXqlTIaY2kIRgXauMZXsKE
         q6wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781703467; x=1782308267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0PZwONgPFoK0XqMeSTQfrvF+OqRU8eqiGRYl14gPv0=;
        b=s8UIBvFKZwaSXgsddA7J7DeciBdSci0GUzqvAa9RHHX7pO/QbQGqbFQHxwLA5PoUcI
         jow2hnZ3vacpmJtErQURBLgMZD5UkfRrgx+Ka7TSVigkZMEiG3SgYFyb9I+HUGWgo6Sy
         iUGAfbGPsi+M2Xy4BNmsvGuBKVV6/Iqq0e2TLrLIcc1x444lhTfj3Y4xy1hx3mkXOSed
         c/HqDPjp6tLs0+VIxg4IEwkSB4m2/o3xFLOpm8GBgqMuzo+MJAqhQKcom4kbD6YJE3ZC
         eyYi/KlOvCvtgI75HAqfuOqbnugrAvU+X8/AigjLerbXe9X/WrrVmJmCs89im5E83l15
         aUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781703467; x=1782308267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z0PZwONgPFoK0XqMeSTQfrvF+OqRU8eqiGRYl14gPv0=;
        b=AX+w7drRLoX2LJj4YPQgdjWKITyKG3H26anFROGtYHadx7CFWE5Oy1wovj00ChioUP
         R8S+CNC261tM82qj8vvGUL4lKNwmS6PYncBfePIiXaJCmb7BjlbjrJ6K5G/kN5hha4y9
         xehP1pwAbZiCxu9fe2Yv8JCXA9DM98e3HaHaTzXSbFJY6BCbIZ84tS9T9pcO+vYES3kz
         tt6xn+Fg/VuZwe/Z13Wiz9wfpHzm3kYM8TBy0cHdOTCu9OemmIyNLDwVL9GoTiLcFHUH
         Ps9qL8fVhDRzOZknP+8mdNwO6nXgC+AfJTm4XJBjsRRB1PY351CD8HXfJvFpSSfpk8vy
         R3Qg==
X-Gm-Message-State: AOJu0YwqsevO+yNpIhNAbaAVpjPP6uO+Q1fl7xclb6D3PZAICVsPL/f5
	bX9jveeyrngM0LCb8cXgVycafSMjPeA5BeBTC3jM7RB3CRBlnCMizzhQsVirUwS9Bbxp46q/RnL
	lakgEqFU9d1Fpiz+rI80iiauB4jqslnjPHg==
X-Gm-Gg: Acq92OFrKa2rA5UsSuHfDupUJj4U30P55QKzrwR8htD5BBv70WxEHCXH5aZF5bIbpbM
	BAgjfXOyBcr6yrx1UZtazZcINZ30lWn0ZDVsOOgttFFiDxGmvi/jujvNDhZcttqiMZJk7Nwo9qM
	lgzag/QYTUqN/GSTfT+9LrhV/wU2oswypJgGvQeGHeCl91muH/xne5UkK2IhzwnBWAEhdm1PMQ6
	/7vH1gspZdNdyjodJdibrD08TxsSLp9uNEz9CU8TWIWBMvNPhY5JI27VlKWvpgJhOuBOact
X-Received: by 2002:a05:6a00:4213:b0:82c:dfea:9e2a with SMTP id
 d2e1a72fcca58-8452441a200mr4252141b3a.2.1781703466905; Wed, 17 Jun 2026
 06:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajGNgKCKVcmvVUeJ@AA-94-54-42-0F-E2> <CAEjxPJ7HfVS2iUOLztp1VGn0hQ9+4Jr=BMwTY0y_ZzEnwHKVcA@mail.gmail.com>
 <ajGXWxFgbeS0zfZx@AA-94-54-42-0F-E2> <CAEjxPJ6V6m7Ery7fKRmcHKeRmFHKuO6=rmEuiQ6ELmcXeGZS=A@mail.gmail.com>
 <CAEjxPJ7STt0KXG=fLAC6BtQNWMaXC7JXTDh=7d5Jwfuxi027Fw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7STt0KXG=fLAC6BtQNWMaXC7JXTDh=7d5Jwfuxi027Fw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 09:37:34 -0400
X-Gm-Features: AVVi8CcmOcOtSvCKjbOfUIe2gqoaOh7f2h6KCaJAGXkvizfbtYjAR5Wk7CA_bb8
Message-ID: <CAEjxPJ4OWn3NkBjW+=UbbXcFg=sxcG6O3xNJmUaUt4ZLdKbEbA@mail.gmail.com>
Subject: Re: About SELinux userspace AVC
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 2:46=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 16, 2026 at 2:43=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Jun 16, 2026 at 2:35=E2=80=AFPM Kalevi Kolttonen <kalevi@koltto=
nen.fi> wrote:
> > >
> > > On Tue, Jun 16, 2026 at 02:04:33PM -0400, Stephen Smalley wrote:
> > > > On Tue, Jun 16, 2026 at 1:53=E2=80=AFPM Kalevi Kolttonen <kalevi@ko=
lttonen.fi> wrote:
> > > > >
> > > > > Hello!
> > > > >
> > > > > When going through the SELinux userspace code base,
> > > > > I found out that AVC is available in userspace too.
> > > > >
> > > > > Just curious, does anyone know if there are many
> > > > > applications that use this feature? As far as I know,
> > > > > most of the AVC decisions happen in the kernel side.
> > > >
> > > > It is used by a variety of applications in both Linux and Android.
> > > > Sometimes indirectly via the newer selinux_check_access(3) API.
> > >
> > > I am trying to see which apps could make use of it, but on
> > > my Fedora 44 installation the number seems pretty small:
> > >
> > > ~ $ rpm -qa|wc -l
> > > 5930
> > > ~ $ rpm -q --whatrequires libselinux
> > > setools-console-analyses-4.6.0-5.fc44.x86_64
> > > setools-console-4.6.0-5.fc44.x86_64
> > > cronie-1.7.2-16.fc44.x86_64
> > > openssh-10.2p1-10.fc44.x86_64
> > > shadow-utils-4.19.0-7.fc44.x86_64
> > > mcstrans-3.10-1.fc44.x86_64
> > >
> > > But I am not sure whether I am doing the right query here.
> >
> > sudo dnf repoquery --disablerepo=3D\* --enablerepo=3Dfedora
> > --whatrequires=3D'libselinux.so.1()(64bit)' --qf '%{sourcerpm}\n'
> > will give a longer list of application that link libselinux.
> >
> > However, if you particularly want to see what applications use these AP=
Is,
> > https://codesearch.debian.net/search?q=3Davc_has_perm%7Cselinux_check_a=
ccess&literal=3D0
> > will be more precise (for Debian; I don't know of a way to do the same
> > for Fedora), and
> > https://cs.android.com/search?q=3Davc_has_perm%20OR%20selinux_check_acc=
ess
> > for Android (after skipping past the ones that are in libselinux itself=
).
>
> Also, systemd uses these APIs, not sure why it isn't showing up in the li=
st.

Answering my own question above, systemd now uses dlopen() to load
libselinux at runtime and therefore this won't show up in package
dependencies.
So checking for this solely by package dependencies is going to be limited.
