Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505A1FF5F7
	for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263165; cv=none; b=DLLqQWn7DPqWuewadJ64R5UBDeumIpuMDYOlLNKfjXFTmfHvm02TfsnzpSfKaXjVrblElo5/ZE3R0oREeNzcyPFFOqMp0pE/JWK17VNjAOyGrHd2iKpv8X4mv4PL+rkst74/bVkVQV/c8J5d1O/j5TmPgH5UXJox6T65rSld4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263165; c=relaxed/simple;
	bh=6jSYiTghfXZjbKTP/L6LOdSs50lj33Azq7ebwg9IN7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWXfmQyL+w8YOIw/xQjSmKnZYgT8zzplGxZbGn9uLU2h+vSfhsRQGBalmPkf6k9L0wP8cuWYaq0RDMPbvwpsDdxMCGD251dnJruBvVXGxTddEPiXZZaKpJ585u6zwGXhVtL4SSRbW1CIO+KpCimkhasUbISY2NA39tRojG7h/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQTlP3U5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQTlP3U5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so1576099b3a.0
        for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729263162; x=1729867962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45IO+at41my6BuhhtkbTgqLamX59++TkDZdRhUb6nwo=;
        b=hQTlP3U5PQiuUYEsHkB2xjDR1q+R8MLVkTypEU2KykQQu8eOlpe7fIWUZ6u4AAzfRX
         +TuvxBAKtKQSb89GtE8rZ9QmcjogHM2VDFzIH2/gQKZiLEK4s6uHZEpamNyzg6Khmlsp
         r0VMgGpE2Isq135jOvybMDso027CxpSZ6tmxHXXrx90eQpDQM1hYmjPdBhr2kevS0X0z
         fEKMJ8gXXtnKEqGU3r2ffbRnTw1Zj1HMqf+z72jbWklPQPT7Tc7ATqzGYBnuiiDKDpL0
         ckOIbYMnfPsahRN1jVjfhqApSBVOrDgISPaGUx+WRc8jsePeSavLe6xzmtSMnBYyUjoK
         nCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729263162; x=1729867962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45IO+at41my6BuhhtkbTgqLamX59++TkDZdRhUb6nwo=;
        b=nxgEz/TXWV9gKkVvvl93VfJVBprtdJJSP+sD9JuGS/SImuv76JH5hWqBhnYhhzhtyF
         ZH8o5gNCvHbryGHok2pD6rWkQM5auiL3e92an8wznN12fYcYuXzOuTNPOltU1fRoHGNR
         RaeWfouELgaSUixFWhiz0Lcdxes7dAkONrXzywJVfzfSV1USIi7mv7USn3wDGIT6p8Fh
         MnT5CH68ZRllkDkaekZHja3N9L/E5h02RPB75nOHpMq2cKoVxoO0Rr3ybRmrz0P1KHyc
         wESeShcQMar/ozcCUZSahAf/LIIiMmgIiZw/ISgt1CIaAswJK53YhEsf/Nn7GEaPIxDi
         CHLA==
X-Gm-Message-State: AOJu0Yx/H5wWtKlz3ZGAQXQ8vtVWZckertXri4dJOaDauAwHANF2r6cw
	4+kQERgpjdM2MCVqzMxxczi2X6W0hVRXupobF4EiNyIslZwxy3pWFa3zqNI1RAh/GN1CApsbPJK
	9GoS7uZ9vJyZ/5Fq3w5z/n8tU10p2yg==
X-Google-Smtp-Source: AGHT+IH5w2LCEKntW/DHOpdIJWociT1uIgcLzA92pNfUgXpnA1RisEeZWR3HLZh8j85Hb3dThUym/VrRfqNZ5KtLW7A=
X-Received: by 2002:a05:6a21:4781:b0:1d8:aca7:912 with SMTP id
 adf61e73a8af0-1d92c503e3fmr3606793637.28.1729263162409; Fri, 18 Oct 2024
 07:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a79e0e6f-e83d-4b4b-a55c-3f2c20b93c83@linux.microsoft.com> <CAEjxPJ4Yby2Y9mYf-mCaFy3cPZ-Ukzs6VCQER6uB0K_UeG=wUQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Yby2Y9mYf-mCaFy3cPZ-Ukzs6VCQER6uB0K_UeG=wUQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Oct 2024 10:52:31 -0400
Message-ID: <CAEjxPJ6vEf0kpOkVUcb0LY2u2svGt+8XRg_t3ywbnPa+nnY1GA@mail.gmail.com>
Subject: Re: selinux_set_callback for policy load not triggering
To: Matthew Sheets <masheets@linux.microsoft.com>
Cc: SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 10:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Oct 17, 2024 at 3:42=E2=80=AFPM Matthew Sheets
> <masheets@linux.microsoft.com> wrote:
> >
> > Hi All,
> >
> > I am currently working on an update for dbus-broker to trigger reload o=
f
> > its configuration whenever an SELinux policy load event is seen.
> >
> > For some background dbus-broker is comprised of two major elements the
> > launcher and the broker.  To trigger a config reload you can either sen=
d
> > a SIGHUP to the launcher or send a message to the launcher over dbus.
> > In most cases the launcher will be the brokers parent.
> >
> > Here is a link to my current PR:
> > https://github.com/bus1/dbus-broker/pull/379
> >
> > In this current state things work.  The broker will see the POLICY_LOAD
> > event and properly send a SIGHUP to its parent, but as David pointed ou=
t
> > my initial attempt at the fix is no good since there is no guarantee
> > that the brokers parent will be the launcher.
> >
> > My attempts at moving the callback registration into the launcher have
> > been less successful.  From what my debugging has told me is that the
> > selinux_set_callback is going through successfully and the function
> > pointer is correctly pointing to the callback function I define.  But
> > when I trigger a load_policy my callback function is never called.
> >
> > I am not familiar with how the callbacks in libselinux work under the
> > hood so I am unsure about what could be blocking them in this situation=
.
>
> Caveat: I haven't looked deeply so take this with a grain of salt (or two=
).
> There are generally two ways of discovering when policy has been reloaded=
:
> 1. Create and receive notifications on a SELinux netlink socket, or
> 2. Map the SELinux status page and poll it for updates to the policy seqn=
o.
>
> Internally libselinux has switched to using the status page whenever
> the kernel supports it since doing so is more efficient (no syscall
> required to read it once you've mapped the page). As an aside, the
> status page is also more easily "virtualizable" for SELinux namespaces
> since it is per-SELinux state/namespace already (the netlink socket
> can also be virtualized via a separate network namespace if/when my
> namespace patches land but that requires you to unshare the network
> namespace too).
>
> As far as libselinux APIs are concerned for the status page, you can
> check for a policy reload or enforcing mode change by calling
> selinux_status_updated() at any time after having done an initial
> selinux_status_open(). selinux_status_updated() will call any
> registered callbacks if enforcing mode or policy was changed, and, it
> returns an indicator as to whether anything changed since the last
> time it was called.
>
> Or if you choose to use the netlink socket and want to use the
> libselinux APIs, you'd call avc_netlink_acquire_fd() to create and
> take ownership of the SELinux netlink socket and then poll/select on
> it for notifications, and upon receiving them, calling
> avc_netlink_check_nb() to process them, including calling your
> callbacks.
>
> But you have to do one of those two things in order for your callback
> to be invoked. I assume dbus and dbus-broker are already doing one of
> them which is why it works for them but not for the launcher.

Also, both avc_has_perm*() and selinux_check_access() internally call
selinux_status_updated() to ensure that they are using the latest
enforcing mode and policy. So anything using those libselinux
functions would get the status update for free.
